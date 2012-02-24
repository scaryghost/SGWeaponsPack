class BoomStickAltFire extends KFMod.BoomStickAltFire;

simulated function bool AllowFire() {
    return (!BoomStick(Weapon).bWaitingToLoadShotty && super.AllowFire());
}
