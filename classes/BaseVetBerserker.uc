class BaseVetBerserker extends SRVetBerserker
    abstract;

static function float GetCostScaling(KFPlayerReplicationInfo KFPRI, class<Pickup> Item) {
    if ( Item == class'ChainsawPickup' || Item == class'KatanaPickup' || Item == class'ClaymoreSwordPickup')
        return FMax(0.9 - (0.10 * float(KFPRI.ClientVeteranSkillLevel)),0.1); // Up to 70% discount on Melee Weapons
    return 1.0;
}


static function AddDefaultInventory(KFPlayerReplicationInfo KFPRI, Pawn P) {
    if ( KFPRI.ClientVeteranSkillLevel == 5 ) {
        KFHumanPawn(P).CreateInventoryVeterancy("KFMod.Axe", GetCostScaling(KFPRI, class'AxePickup'));
    } else if ( KFPRI.ClientVeteranSkillLevel >= 6 ) {
        KFHumanPawn(P).CreateInventoryVeterancy("KFMod.Katana", GetCostScaling(KFPRI, class'KatanaPickup'));
    }
}

defaultproperties {
    VeterancyName="Zerk"
}
