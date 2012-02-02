class SGWPHumanPawn extends KFHumanPawn;

function bool hasWeaponInInventory(class<Weapon> wClass) {
    local Inventory I;

    for ( I=Inventory; I!=None; I=I.Inventory ) {
        if (I.Class == wClass) {
            return true;
        }
    }
    return false;
}

function ServerBuyWeapon( Class<Weapon> WClass ) {
    local Inventory I, J;
    local float Price;
    local bool bIsDualWeapon, bHasDual9mms, bHasDualHCs, bHasDualRevolvers, bHasSingleMagnum, bCanCarry;

    if( !CanBuyNow() || Class<KFWeapon>(WClass)==None || Class<KFWeaponPickup>(WClass.Default.PickupClass)==None ) {
        Return;
    }

    Price = class<KFWeaponPickup>(WClass.Default.PickupClass).Default.Cost;

    if ( KFPlayerReplicationInfo(PlayerReplicationInfo).ClientVeteranSkill != none ) {
        Price *= KFPlayerReplicationInfo(PlayerReplicationInfo).ClientVeteranSkill.static.GetCostScaling(KFPlayerReplicationInfo(PlayerReplicationInfo), WClass.Default.PickupClass);
    }

    for ( I=Inventory; I!=None; I=I.Inventory ) {
        if( I.Class==WClass ) {
            Return; // Already has weapon.
        }

        if ( I.Class == class'KFMod.Dualies' ) {
            bHasDual9mms = true;
        }
        else if ( I.Class == class'SGWeaponsPack.DualDeagle' ) {
            bHasDualHCs = true;
        }
        else if ( I.Class == class'SGWeaponsPack.Dual44Magnum' ) {
            bHasDualRevolvers = true;
        } else if (I.class == class'SGWeaponsPack.Magnum44Pistol') {
            bHasSingleMagnum= true;
        }
    }

    if ( WClass == class'SGWeaponsPack.DualDeagle' ) {
        for ( J = Inventory; J != None; J = J.Inventory ) {
            if ( J.class == class'SGWeaponsPack.Deagle' ) {
                Price = Price / 2;
                bHasNonDefaultDualWeapon = true;

                break;
            }
        }

        bIsDualWeapon = true;
        bHasDualHCs = true;
    }

    if ( WClass == class'SGWeaponsPack.Dual44Magnum' ) {
        for ( J = Inventory; J != None; J = J.Inventory ) {
            if ( J.class == class'SGWeaponsPack.Magnum44Pistol' ) {
                Price = Price / 2;
                /** 
                 *  Removed setting bHasNonDefaultDualWeapon to true here because 
                 *  it would give dual magnums for no weight
                 */
                break;
            }
        }

        bIsDualWeapon = true;
        bHasDualRevolvers = true;
    }

    bIsDualWeapon = bIsDualWeapon || WClass == class'Dualies';

    bCanCarry= bHasNonDefaultDualWeapon || 
            (WClass == class'SGWeaponsPack.Dual44Magnum' && bHasSingleMagnum && CanCarry(Class<KFWeapon>(WClass).Default.Weight/2)
            ||  CanCarry(Class<KFWeapon>(WClass).Default.Weight));
    if (!bCanCarry) {
        bHasNonDefaultDualWeapon = false;
        Return;
    }

    if ( PlayerReplicationInfo.Score < Price ) {
        bHasNonDefaultDualWeapon = false;
        Return; // Not enough CASH.
    }

    I = Spawn(WClass);

    if ( I != none ) {
        if ( KFGameType(Level.Game) != none ) {
            KFGameType(Level.Game).WeaponSpawned(I);
        }

        KFWeapon(I).UpdateMagCapacity(PlayerReplicationInfo);
        KFWeapon(I).FillToInitialAmmo();
        KFWeapon(I).SellValue = Price * 0.75;
        I.GiveTo(self);
        PlayerReplicationInfo.Score -= Price;

        if ( bIsDualWeapon ) {
            KFSteamStatsAndAchievements(PlayerReplicationInfo.SteamStatsAndAchievements).OnDualsAddedToInventory(bHasDual9mms, bHasDualHCs, bHasDualRevolvers);
        }

        ClientForceChangeWeapon(I);
    }

    bHasNonDefaultDualWeapon = false;

    SetTraderUpdate();
}

function ServerSellWeapon( Class<Weapon> WClass ) {
    local Inventory I;
    local Single NewSingle;
    local Deagle NewDeagle;
    local Magnum44Pistol New44Magnum;
    local float Price;

    if ( !CanBuyNow() || Class<KFWeapon>(WClass) == none || Class<KFWeaponPickup>(WClass.Default.PickupClass) == none ) {
        SetTraderUpdate();
        Return;
    }

    for ( I = Inventory; I != none; I = I.Inventory ) {
        if ( I.Class == WClass ) {
            if ( KFWeapon(I) != none && KFWeapon(I).SellValue != -1 ) {
                Price = KFWeapon(I).SellValue;
            }
            else {
                Price = int(class<KFWeaponPickup>(WClass.default.PickupClass).default.Cost * 0.75);

                if ( KFPlayerReplicationInfo(PlayerReplicationInfo).ClientVeteranSkill != none ) {
                    Price *= KFPlayerReplicationInfo(PlayerReplicationInfo).ClientVeteranSkill.static.GetCostScaling(KFPlayerReplicationInfo(PlayerReplicationInfo), WClass.Default.PickupClass);
                }
            }

            if ( Dualies(I) != none && DualDeagle(I) == none && Dual44Magnum(I) == none ) {
                NewSingle = Spawn(class'KFMod.Single');
                NewSingle.GiveTo(self);
            }

            if ( DualDeagle(I) != none ) {
                NewDeagle = Spawn(class'SGWeaponsPack.Deagle');
                NewDeagle.GiveTo(self);
                Price = Price / 2;
            }

            if ( Dual44Magnum(I) != none ) {
                New44Magnum = Spawn(class'SGWeaponsPack.Magnum44Pistol');
                New44Magnum.GiveTo(self);
                Price = Price / 2;
            }

            if ( I == Weapon || I == PendingWeapon ) {
                ClientCurrentWeaponSold();
            }

            PlayerReplicationInfo.Score += Price;

            I.Destroyed();
            I.Destroy();

            SetTraderUpdate();

            if ( KFGameType(Level.Game) != none ) {
                KFGameType(Level.Game).WeaponDestroyed(WClass);
            }

            return;
        }
    }
}
