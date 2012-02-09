class Deagle extends KFMod.Deagle;

simulated function bool PutDown() {
    if ( Instigator.PendingWeapon.class == class'SGWeaponsPack.DualDeagle' ) {
        bIsReloading = false;
    }

    return super(KFWeapon).PutDown();
}

defaultproperties {
    PickupClass=class'SGWeaponsPack.DeaglePickup'
}
