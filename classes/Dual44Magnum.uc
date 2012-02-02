class Dual44Magnum extends KFMod.Dual44Magnum;

function bool HandlePickupQuery( pickup Item ) {
    if ( Item.InventoryType==Class'SGWeaponsPack.Magnum44Pistol' ) {
        if( LastHasGunMsgTime < Level.TimeSeconds && PlayerController(Instigator.Controller) != none ) {
            LastHasGunMsgTime = Level.TimeSeconds + 0.5;
            PlayerController(Instigator.Controller).ReceiveLocalizedMessage(Class'KFMainMessages', 1);
        }

        return True;
    }

    return Super.HandlePickupQuery(Item);
}

function DropFrom(vector StartLocation) {
    local int m;
    local Pickup Pickup;
    local Inventory I;
    local int AmmoThrown, OtherAmmo;

    if( !bCanThrow )
        return;

    AmmoThrown = AmmoAmount(0);
    ClientWeaponThrown();

    for (m = 0; m < NUM_FIRE_MODES; m++) {
        if (FireMode[m].bIsFiring)
            StopFire(m);
    }

    if ( Instigator != None )
        DetachFromPawn(Instigator);

    if( Instigator.Health > 0 ) {
        OtherAmmo = AmmoThrown / 2;
        AmmoThrown -= OtherAmmo;
        I = Spawn(Class'SGWeaponsPack.Magnum44Pistol');
        I.GiveTo(Instigator);
        Weapon(I).Ammo[0].AmmoAmount = OtherAmmo;
        Magnum44Pistol(I).MagAmmoRemaining = MagAmmoRemaining / 2;
        MagAmmoRemaining = Max(MagAmmoRemaining-Magnum44Pistol(I).MagAmmoRemaining,0);
    }

    Pickup = Spawn(Class'SGWeaponsPack.Magnum44Pickup',,, StartLocation);

    if ( Pickup != None ) {
        Pickup.InitDroppedPickupFor(self);
        Pickup.Velocity = Velocity;
        WeaponPickup(Pickup).AmmoAmount[0] = AmmoThrown;
        if( KFWeaponPickup(Pickup)!=None )
            KFWeaponPickup(Pickup).MagAmmoRemaining = MagAmmoRemaining;
        if (Instigator.Health > 0)
            WeaponPickup(Pickup).bThrown = true;
    }

    Destroyed();
    Destroy();
}

simulated function bool PutDown() {
    if ( Instigator.PendingWeapon.class == class'SGWeaponsPack.Magnum44Pistol' ) {
        bIsReloading = false;
    }

    return super.PutDown();
}

defaultproperties {
    PickupClass=class'SGWeaponsPack.Dual44MagnumPickup'
    ItemName="SG Dual 44 Magnums"
}
