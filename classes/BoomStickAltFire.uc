class BoomStickAltFire extends KFMod.BoomStickAltFire;

simulated function bool AllowFire() {
    return (BoomStick(Weapon).MagAmmoRemaining > 0);
}
