class BoomStick extends KFMod.BoomStick;

simulated function SetPendingReload() {
    if (!bWaitingToLoadShotty) {
        super.SetPendingReload();
    }
}

defaultproperties {
    FireModeClass(0)=Class'SGWeaponsPack.BoomStickAltFire'
    FireModeClass(1)=Class'SGWeaponsPack.BoomStickFire'
    PickupClass=Class'SGWeaponsPack.BoomStickPickup'
}
