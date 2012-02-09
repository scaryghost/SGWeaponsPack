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

    SRLevelEffects(5)="100% extra melee damage|20% faster melee attacks|20% faster melee movement|75% less damage from Bloat Bile|30% resistance to all damage|60% discount on Katana/Chainsaw/Sword|Spawn with an axe|Can't be grabbed by Clots|Up to 4 Zed-Time Extensions"
    SRLevelEffects(6)="100% extra melee damage|25% faster melee attacks|30% faster melee movement|80% less damage from Bloat Bile|40% resistance to all damage|70% discount on Katana/Chainsaw/Sword|Spawn with a katana|Can't be grabbed by Clots|Up to 4 Zed-Time Extensions"
}
