class BoomStickFire extends KFMod.BoomStickFire;

simulated function bool AllowFire() {
    return (BoomStick(Weapon).SingleShotCount >= 1);
}
