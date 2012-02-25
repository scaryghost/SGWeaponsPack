class BoomStick extends KFMod.BoomStick;

simulated function WeaponTick(float dt) {
    super(KFWeaponShotgun).WeaponTick(dt);

    if( bWaitingToLoadShotty ) {
        CurrentReloadCountDown -= dt;

        if( CurrentReloadCountDown <= 0 ) {

            if( AmmoAmount(0) > 0 ) {
                MagAmmoRemaining = Min(AmmoAmount(0), 2);
                SingleShotCount = MagAmmoRemaining;
                ClientSetSingleShotCount(SingleShotCount);
                NetUpdateTime = Level.TimeSeconds - 1;
                bWaitingToLoadShotty = false;
            }
        }
    }
}

defaultproperties {
    FireModeClass(0)=Class'SGWeaponsPack.BoomStickAltFire'
    FireModeClass(1)=Class'SGWeaponsPack.BoomStickFire'
    PickupClass=Class'SGWeaponsPack.BoomStickPickup'
}
