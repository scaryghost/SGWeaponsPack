class MP5MPickup extends KFMod.MP5MPickup;

var int healAmmoCharge;

function InitDroppedPickupFor(Inventory Inv) {
    super.InitDroppedPickupFor(Inv);
    
    healAmmoCharge= MP5MMedicGun(Inv).HealAmmoCharge;
}

auto state pickup {
    function Touch(Actor Other) {
        local Inventory Copy;

        if ( KFHumanPawn(Other) != none && !CheckCanCarry(KFHumanPawn(Other)) ) {
            return;
        }

        // If touched by a player pawn, let him pick this up.
        if ( ValidTouch(Other) ) {
            Copy = SpawnCopy(Pawn(Other));
            AnnouncePickup(Pawn(Other));
            SetRespawn();
    
            if ( Copy != None ) {
                Copy.PickupFunction(Pawn(Other));
            }
    
            if ( MySpawner != none && KFGameType(Level.Game) != none ) {
                KFGameType(Level.Game).WeaponPickedUp(MySpawner);
            }
    
            if ( KFWeapon(Copy) != none ) {
                KFWeapon(Copy).SellValue = SellValue;
                KFWeapon(Copy).bPreviouslyDropped = bDropped;
                MP5MMedicGun(Copy).HealAmmoCharge= healAmmoCharge;
    
                if ( !bPreviouslyDropped && KFWeapon(Copy).bIsTier3Weapon &&
                     Pawn(Other).Controller != none && Pawn(Other).Controller != DroppedBy ) {
                    KFWeapon(Copy).Tier3WeaponGiver = DroppedBy;
                }
            }
        }
    }
}

state FallingPickup {
    function Touch(Actor Other) {
        local Inventory Copy;

        if ( KFHumanPawn(Other) != none && !CheckCanCarry(KFHumanPawn(Other)) ) {
            return;
        }
    
        // If touched by a player pawn, let him pick this up.
        if ( ValidTouch(Other) ) {
            Copy = SpawnCopy(Pawn(Other));
            AnnouncePickup(Pawn(Other));
            SetRespawn();
    
            if ( Copy != None ) {
                Copy.PickupFunction(Pawn(Other));
            }
    
            if ( MySpawner != none && KFGameType(Level.Game) != none ) {
                KFGameType(Level.Game).WeaponPickedUp(MySpawner);
            }
    
            if ( KFWeapon(Copy) != none ) {
                KFWeapon(Copy).SellValue = SellValue;
                KFWeapon(Copy).bPreviouslyDropped = bDropped;
                MP5MMedicGun(Copy).HealAmmoCharge= healAmmoCharge;
    
                if ( !bPreviouslyDropped && KFWeapon(Copy).bIsTier3Weapon &&
                     Pawn(Other).Controller != none && Pawn(Other).Controller != DroppedBy ) {
                    KFWeapon(Copy).Tier3WeaponGiver = DroppedBy;
                }
            }
        }
    }
}

state FadeOut {
    function Touch(Actor Other) {
        local Inventory Copy;

        if ( KFHumanPawn(Other) != none && !CheckCanCarry(KFHumanPawn(Other)) ) {
            return;
        }

        // If touched by a player pawn, let him pick this up.
        if ( ValidTouch(Other) ) {
            Copy = SpawnCopy(Pawn(Other));
            AnnouncePickup(Pawn(Other));
            SetRespawn();
    
            if ( Copy != None ) {
                Copy.PickupFunction(Pawn(Other));
            }
    
            if ( MySpawner != none && KFGameType(Level.Game) != none ) {
                KFGameType(Level.Game).WeaponPickedUp(MySpawner);
            }
    
            if ( KFWeapon(Copy) != none ) {
                KFWeapon(Copy).SellValue = SellValue;
                KFWeapon(Copy).bPreviouslyDropped = bDropped;
                MP5MMedicGun(Copy).HealAmmoCharge= healAmmoCharge;
    
                if ( !bPreviouslyDropped && KFWeapon(Copy).bIsTier3Weapon &&
                     Pawn(Other).Controller != none && Pawn(Other).Controller != DroppedBy ) {
                    KFWeapon(Copy).Tier3WeaponGiver = DroppedBy;
                }
            }
        }
    }
}

defaultproperties {
    InventoryType=class'SGWeaponsPack.MP5MMedicGun'
}
