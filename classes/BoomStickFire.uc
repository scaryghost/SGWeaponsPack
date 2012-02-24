class BoomStickFire extends KFMod.BoomStickFire;

simulated function bool AllowFire() {
    return (!BoomStick(Weapon).bWaitingToLoadShotty && super.AllowFire());
}
