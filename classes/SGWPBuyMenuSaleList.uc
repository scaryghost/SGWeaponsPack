class SGWPBuyMenuSaleList extends SRBuyMenuSaleList;

function UpdateForSaleBuyables() {
    local class<KFVeterancyTypes> PlayerVeterancy;
    local KFPlayerReplicationInfo KFPRI;
    local ClientPerkRepLink KFLR;
    local GUIBuyable ForSaleBuyable;
    local class<KFWeaponPickup> ForSalePickup;
    local int j, DualDivider,i;
    local bool bZeroWeight;
    local class<KFWeapon> ForSaleWeapon;

    DualDivider = 1;

    //Clear the ForSaleBuyables array
    CopyAllBuyables();
    ForSaleBuyables.Length = 0;

    // Grab the items for sale
    KFLR = Class'ClientPerkRepLink'.Static.FindStats(PlayerOwner());
    if( KFLR==None )
        return; // Hmmmm?

    // Grab Players Veterancy for quick reference
    if ( KFPlayerController(PlayerOwner()) != none )
        PlayerVeterancy = KFPlayerReplicationInfo(PlayerOwner().PlayerReplicationInfo).ClientVeteranSkill;
    if( PlayerVeterancy==None )
        PlayerVeterancy = class'KFVeterancyTypes';

    KFPRI = KFPlayerReplicationInfo(PlayerOwner().PlayerReplicationInfo);

    //Grab the perk's weapons first
    for ( j = 0; j < KFLR.ShopInventory.Length; j++ ) {
        ForSalePickup = class<KFWeaponPickup>(KFLR.ShopInventory[j].PC);

        i= class'SGWeaponsPack.SGWPMutator'.static.shouldReplace(String(ForSalePickup),
                class'SGWeaponsPack.SGWPMutator'.default.pickupReplaceArray); 
        if (i != -1) {
            ForSalePickup= class<KFWeaponPickup>(class'SGWeaponsPack.SGWPMutator'.default.pickupReplaceArray[i].newClass);
        }
        

        if ( ForSalePickup==None || ActiveCategory!=KFLR.ShopInventory[j].CatNum
             || class<KFWeapon>(ForSalePickup.default.InventoryType).default.bKFNeverThrow
             || IsInInventory(ForSalePickup) )
            continue;

        // Remove single weld.
        if ( (ForSalePickup==Class'SGWeaponsPack.DeaglePickup' && IsInInventory(class'SGWeaponsPack.DualDeaglePickup'))
             || (ForSalePickup==Class'SGWeaponsPack.Magnum44Pickup' && IsInInventory(class'SGWeaponsPack.Dual44MagnumPickup')) )
            continue;

        DualDivider = 1;
        bZeroWeight = false;

        // Make cheaper and lighter.
        if ( (ForSalePickup==Class'SGWeaponsPack.DualDeaglePickup' 
                && IsInInventory(class'SGWeaponsPack.DeaglePickup'))) {
            DualDivider = 2;
            bZeroWeight = true;
        } else if (ForSalePickup==Class'SGWeaponsPack.Dual44MagnumPickup' 
                && IsInInventory(class'SGWeaponsPack.Magnum44Pickup')) {
            /** Do not give dual magnums 0 weight */
            DualDivider = 2;
        }

        for( i=0; i<KFLR.CachePerks.Length; ++i )
            if( !KFLR.CachePerks[i].PerkClass.Static.AllowWeaponInTrader(ForSalePickup,KFPRI) )
                break;
        if( i<KFLR.CachePerks.Length )
            continue;

        ForSaleWeapon =  class<KFWeapon>(ForSalePickup.default.InventoryType);
        ForSaleBuyable = AllocateEntry();

        ForSaleBuyable.ItemName         = ForSalePickup.default.ItemName;
        ForSaleBuyable.ItemDescription      = ForSalePickup.default.Description;
        ForSaleBuyable.ItemCategorie        = "Melee"; // Dummy stuff..
        ForSaleBuyable.ItemImage        = ForSaleWeapon.default.TraderInfoTexture;
        ForSaleBuyable.ItemWeaponClass      = ForSaleWeapon;
        ForSaleBuyable.ItemAmmoClass        = ForSaleWeapon.default.FireModeClass[0].default.AmmoClass;
        ForSaleBuyable.ItemPickupClass      = ForSalePickup;
        ForSaleBuyable.ItemCost         = int((float(ForSalePickup.default.Cost)
                                              * PlayerVeterancy.static.GetCostScaling(KFPRI, ForSalePickup)) / DualDivider);
        ForSaleBuyable.ItemAmmoCost     = 0;
        ForSaleBuyable.ItemFillAmmoCost     = 0;

        if ( bZeroWeight)
            ForSaleBuyable.ItemWeight   = 0.f;
        else if (KFCBHumanPawn(KFCBPlayerController(PlayerOwner()).Pawn).hasWeaponInInventory(class'SGWeaponsPack.Magnum44Pistol')
                && ForSalePickup == class'SGWeaponsPack.Dual44MagnumPickup')
        /**
         *  Added this so dual magnums would only add 2 blocks if the 
         *  player already has single magnum
         */
            ForSaleBuyable.ItemWeight= ForSalePickup.default.Weight/2;
        else ForSaleBuyable.ItemWeight      = ForSalePickup.default.Weight;

        ForSaleBuyable.ItemPower        = ForSalePickup.default.PowerValue;
        ForSaleBuyable.ItemRange        = ForSalePickup.default.RangeValue;
        ForSaleBuyable.ItemSpeed        = ForSalePickup.default.SpeedValue;
        ForSaleBuyable.ItemAmmoCurrent      = 0;
        ForSaleBuyable.ItemAmmoMax      = 0;
        ForSaleBuyable.ItemPerkIndex        = ForSalePickup.default.CorrespondingPerkIndex;

        // Make sure we mark the list as a sale list
        ForSaleBuyable.bSaleList = true;

        // Sort same perk weapons in front.
        if( ForSalePickup.default.CorrespondingPerkIndex == PlayerVeterancy.default.PerkIndex ) {
            ForSaleBuyables.Insert(0, 1);
            ForSaleBuyables[0] = ForSaleBuyable;
        }
        else ForSaleBuyables[ForSaleBuyables.Length] = ForSaleBuyable;

        bZeroWeight = false;
    }

    //Now Update the list
    UpdateList();
}

