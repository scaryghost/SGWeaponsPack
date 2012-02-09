class BaseVetCommando extends SRVetCommando
    abstract;

// Change the cost of particular items
static function float GetCostScaling(KFPlayerReplicationInfo KFPRI, class<Pickup> Item) {
    if ( Item == class'BullpupPickup' || Item == class'AK47Pickup' || Item == class'SCARMK17Pickup' || Item == class'M4Pickup' )
        return FMax(0.9 - (0.10 * float(KFPRI.ClientVeteranSkillLevel)),0.1f); // Up to 70% discount on Assault Rifles
    return 1.0;
}

defaultproperties {
    VeterancyName="Mando"
}
