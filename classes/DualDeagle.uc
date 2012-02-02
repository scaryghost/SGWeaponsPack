class DualDeagle extends KFMod.DualDeagle;

function bool HandlePickupQuery( pickup Item ) {
    if ( Item.InventoryType==Class'SGWeaponsPack.Deagle' ) {
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
        I = Spawn(Class'SGWeaponsPack.Deagle');
        I.GiveTo(Instigator);
        Weapon(I).Ammo[0].AmmoAmount = OtherAmmo;
        Deagle(I).MagAmmoRemaining = MagAmmoRemaining / 2;
        MagAmmoRemaining = Max(MagAmmoRemaining-Deagle(I).MagAmmoRemaining,0);
    }

    Pickup = Spawn(class'SGWeaponsPack.DeaglePickup',,, StartLocation);

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

simulated function bool PutDown()
{
    if ( Instigator.PendingWeapon.class == class'SGWeaponsPack.Deagle' )
    {
        bIsReloading = false;
    }

    return super.PutDown();
}

defaultproperties {
    PickupClass=class'SGWeaponsPack.DualDeaglePickup'
    ItemName="SG Dual Handcannons"
}
