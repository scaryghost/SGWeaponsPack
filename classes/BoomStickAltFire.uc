class BoomStickAltFire extends KFMod.BoomStickAltFire;

simulated function bool AllowFire() {
    return (BoomStick(Weapon).SingleShotCount >= 1);
}
