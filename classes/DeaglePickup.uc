class DeaglePickup extends KFMod.DeaglePickup;

function inventory SpawnCopy( pawn Other ) {
    local Inventory I;

    For( I=Other.Inventory; I!=None; I=I.Inventory ) {
        if( Deagle(I)!=None ) {
            if( Inventory!=None )
                Inventory.Destroy();
            InventoryType = Class'SGWeaponsPack.DualDeagle';
            AmmoAmount[0]+= Deagle(I).AmmoAmount(0);
            I.Destroyed();
            I.Destroy();
            Return Super(KFWeaponPickup).SpawnCopy(Other);
        }
    }
    InventoryType = Default.InventoryType;
    Return Super(KFWeaponPickup).SpawnCopy(Other);
}

function bool CheckCanCarry(KFHumanPawn Hm) {
    local Inventory CurInv;
    local bool bHasHandCannon;

    for ( CurInv = Hm.Inventory; CurInv != none; CurInv = CurInv.Inventory ) {
        if ( KFWeapon(CurInv) != none && KFWeapon(CurInv).class == class'SGWeaponsPack.Deagle' ) {
            bHasHandCannon = true;
        }
    }

    if ( !Hm.CanCarry(Class<KFWeapon>(InventoryType).Default.Weight) 
            && Class<KFWeapon>(InventoryType) != class'SGWeaponsPack.Deagle') {
        if ( LastCantCarryTime < Level.TimeSeconds && PlayerController(Hm.Controller) != none ) {
            LastCantCarryTime = Level.TimeSeconds + 0.5;
            PlayerController(Hm.Controller).ReceiveLocalizedMessage(Class'KFMainMessages', 2);
        }

        return false;
    }

    if ( Class<KFWeapon>(InventoryType) == class'SGWeaponsPack.Deagle' ) {
        if ( !bHasHandCannon && !Hm.CanCarry(Class<KFWeapon>(InventoryType).Default.Weight) ) {
            LastCantCarryTime = Level.TimeSeconds + 0.5;
            PlayerController(Hm.Controller).ReceiveLocalizedMessage(Class'KFMainMessages', 2);

            return false;
        }
    }

    return true;
}

defaultproperties {
    InventoryType=class'SGWeaponsPack.Deagle'
}
