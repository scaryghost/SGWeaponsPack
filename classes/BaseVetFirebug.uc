class BaseVetFirebug extends SRVetFirebug
    abstract;

static function float GetMagCapacityMod(KFPlayerReplicationInfo KFPRI, KFWeapon Other) {
    if ( Flamethrower(Other) != none && KFPRI.ClientVeteranSkillLevel > 0 )
        return 1.0 + (0.10 * float(KFPRI.ClientVeteranSkillLevel)); // Up to 60% larger fuel canister
    if ( MAC10MP(Other) != none && KFPRI.ClientVeteranSkillLevel > 0 )
        return 1.0 + (0.12 * FMin(float(KFPRI.ClientVeteranSkillLevel), 5.0)); // 60% increase in MAC10 ammo carry
    return 1.0;
}

static function float GetAmmoPickupMod(KFPlayerReplicationInfo KFPRI, KFAmmunition Other) {
    if ( (FlameAmmo(Other) != none || MAC10Ammo(Other) != none || HuskGunAmmo(Other) != none) && KFPRI.ClientVeteranSkillLevel > 0 )
        return 1.0 + (0.10 * float(KFPRI.ClientVeteranSkillLevel)); // Up to 60% larger fuel canister
    return 1.0;
}

static function float AddExtraAmmoFor(KFPlayerReplicationInfo KFPRI, Class<Ammunition> AmmoType) {
    if ( (AmmoType == class'FlameAmmo' || AmmoType == class'MAC10Ammo' || AmmoType == class'HuskGunAmmo') && KFPRI.ClientVeteranSkillLevel > 0 )
        return 1.0 + (0.10 * float(KFPRI.ClientVeteranSkillLevel)); // Up to 60% larger fuel canister
    return 1.0;
}

// Change the cost of particular items
static function float GetCostScaling(KFPlayerReplicationInfo KFPRI, class<Pickup> Item) {
    if ( Item == class'FlameThrowerPickup' || Item == class'MAC10Pickup' || Item == class'HuskGunPickup' )
        return FMax(0.9 - (0.10 * float(KFPRI.ClientVeteranSkillLevel)),0.1); // Up to 70% discount on Flame Thrower
    return 1.0;
}


defaultproperties {
     VeterancyName="PyroBug"
}
