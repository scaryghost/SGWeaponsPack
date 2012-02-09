class BaseVetSupport extends SRVetSupportSpec
    abstract;

// Change the cost of particular items
static function float GetCostScaling(KFPlayerReplicationInfo KFPRI, class<Pickup> Item) {
    if ( Item == class'ShotgunPickup' || Item == class'BoomstickPickup' || Item == class'AA12Pickup' || Item == class'BenelliPickup' )
        return FMax(0.9 - (0.10 * float(KFPRI.ClientVeteranSkillLevel)),0.1f); // Up to 70% discount on Shotguns
    return 1.0;
}
defaultproperties {
    VeterancyName="Support"
}
