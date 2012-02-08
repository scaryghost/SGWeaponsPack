class HuskGunFire extends KFMod.HuskGunFire;

var float ammoConsumedScale;
var float baseAmmoConsumed;

event ModeDoFire() {
    local float Rec;
    local float AmmoAmountToUse;

    if (!AllowFire())
        return;

    Spread = Default.Spread;
    Rec = 1;

    if ( KFPlayerReplicationInfo(Instigator.PlayerReplicationInfo) != none && KFPlayerReplicationInfo(Instigator.PlayerReplicationInfo).ClientVeteranSkill != none ) {
        Spread *= KFPlayerReplicationInfo(Instigator.PlayerReplicationInfo).ClientVeteranSkill.Static.ModifyRecoilSpread(KFPlayerReplicationInfo(Instigator.PlayerReplicationInfo), self, Rec);
    }

    if( !bFiringDoesntAffectMovement ) {
        if (FireRate > 0.25) {
            Instigator.Velocity.x *= 0.1;
            Instigator.Velocity.y *= 0.1;
        }
        else {
            Instigator.Velocity.x *= 0.5;
            Instigator.Velocity.y *= 0.5;
        }
    }

    if (!AllowFire())
        return;

    if (MaxHoldTime > 0.0)
        HoldTime = FMin(HoldTime, MaxHoldTime);

    // server
    if (Weapon.Role == ROLE_Authority) {
        if( HoldTime < MaxChargeTime ) {
            AmmoAmountToUse = baseAmmoConsumed+(HoldTime/MaxChargeTime)*ammoConsumedScale;
        }
        else {
            AmmoAmountToUse = baseAmmoConsumed + ammoConsumedScale;
        }

        if( Weapon.AmmoAmount(ThisModeNum) < AmmoAmountToUse ) {
            AmmoAmountToUse = Weapon.AmmoAmount(ThisModeNum);
        }

        Weapon.ConsumeAmmo(ThisModeNum, AmmoAmountToUse);


        DoFireEffect();
        HoldTime = 0;   // if bot decides to stop firing, HoldTime must be reset first
        if ( (Instigator == None) || (Instigator.Controller == None) )
            return;

        if ( AIController(Instigator.Controller) != None )
            AIController(Instigator.Controller).WeaponFireAgain(BotRefireRate, true);

        Instigator.DeactivateSpawnProtection();
    }

    // client
    if (Instigator.IsLocallyControlled()) {
        ShakeView();
        PlayFiring();
        FlashMuzzleFlash();
        StartMuzzleSmoke();
    }
    else { // server
        ServerPlayFiring();
    }

    Weapon.IncrementFlashCount(ThisModeNum);

    // set the next firing time. must be careful here so client and server do not get out of sync
    if (bFireOnRelease) {
        if (bIsFiring)
            NextFireTime += MaxHoldTime + FireRate;
        else
            NextFireTime = Level.TimeSeconds + FireRate;
    }
    else {
        NextFireTime += FireRate;
        NextFireTime = FMax(NextFireTime, Level.TimeSeconds);
    }

    Load = AmmoPerFire;
    HoldTime = 0;

    if (Instigator.PendingWeapon != Weapon && Instigator.PendingWeapon != None) {
        bIsFiring = false;
        Weapon.PutDown();
    }

    // client
    if (Instigator.IsLocallyControlled()) {
        HandleRecoil(Rec);
    }
}

simulated function bool AllowFire() {
    return (Weapon.AmmoAmount(ThisModeNum) >= AmmoPerFire 
            && !HuskGun(Weapon).bIsInCoolDown);
}

defaultproperties {
    ammoConsumedScale= 40
    baseAmmoConsumed= 30
}
