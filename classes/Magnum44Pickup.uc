class Magnum44Pickup extends KFMod.Magnum44Pickup;

function inventory SpawnCopy( pawn Other ) {
    local Inventory I;

    For( I=Other.Inventory; I!=None; I=I.Inventory ) {
        if( Magnum44Pistol(I)!=None ) {
            if( Inventory!=None )
                Inventory.Destroy();
            InventoryType = Class'SGWeaponsPack.Dual44Magnum';
            AmmoAmount[0]+= Magnum44Pistol(I).AmmoAmount(0);
            I.Destroyed();
            I.Destroy();
            Return Super(KFWeaponPickup).SpawnCopy(Other);
        }
    }
    InventoryType = Default.InventoryType;
    Return Super(KFWeaponPickup).SpawnCopy(Other);
}

defaultproperties {
    InventoryType=Class'SGWeaponsPack.Magnum44Pistol'
}
