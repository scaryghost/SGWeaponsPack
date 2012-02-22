class BaseVetSupport extends SRVetSupportSpec
    abstract;

// Change the cost of particular items
static function float GetCostScaling(KFPlayerReplicationInfo KFPRI, class<Pickup> Item) {
    if ( Item == class'ShotgunPickup' || Item == class'BoomstickPickup' || Item == class'AA12Pickup' || Item == class'BenelliPickup' )
        return FMax(0.9 - (0.10 * float(KFPRI.ClientVeteranSkillLevel)),0.1f); // Up to 70% discount on Shotguns
    return 1.0;
}

static function AddDefaultInventory(KFPlayerReplicationInfo KFPRI, Pawn P) {
    // If Level 5, give them Assault Shotgun
    if ( KFPRI.ClientVeteranSkillLevel == 5 )
        KFHumanPawn(P).CreateInventoryVeterancy("KFMod.Shotgun", GetCostScaling(KFPRI, class'ShotgunPickup'));
    // If Level 6, give them Hunting Shotgun
    if ( KFPRI.ClientVeteranSkillLevel >= 6 )
        KFHumanPawn(P).CreateInventoryVeterancy("SGWeaponsPack.BoomStick", GetCostScaling(KFPRI, class'BoomStickPickup'));
}

defaultproperties {
    VeterancyName="Support"
}
