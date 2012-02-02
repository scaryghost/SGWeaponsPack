class Magnum44Pistol extends KFMod.Magnum44Pistol;

simulated function bool PutDown() {
    if ( Instigator.PendingWeapon.class == class'SGWeaponsPack.Dual44Magnum' ) {
        bIsReloading = false;
    }

    return super(KFWeapon).PutDown();
}

defaultproperties {
    Weight=2.000000
    ItemName="SG 44 Magnum"
    PickupClass=Class'SGWeaponsPack.Magnum44Pickup'
}
