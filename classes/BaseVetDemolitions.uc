class BaseVetDemolitions extends SRVetDemolitions;

static function float AddExtraAmmoFor(KFPlayerReplicationInfo KFPRI, Class<Ammunition> AmmoType) {
    if ( AmmoType == class'FragAmmo'  ) {
        // Up to 6 extra Grenades
        return 1.0 + (0.20 * float(KFPRI.ClientVeteranSkillLevel));
    }
    else if ( AmmoType == class'PipeBombAmmo' ) {
        // Up to 6 extra for a total of 8 Remote Explosive Devices
        return 1.0 + (0.5 * float(KFPRI.ClientVeteranSkillLevel));
    }
    else if ( AmmoType == class'LAWAmmo' ) {
        // Modified in Balance Round 5 to be up to 100% extra ammo
        return 1.0 + (0.20 * float(KFPRI.ClientVeteranSkillLevel));
    }

    return 1.0;

}

static function float GetCostScaling(KFPlayerReplicationInfo KFPRI, class<Pickup> Item) {
    if (Item == class'PipeBombPickup' ) {
        return 0.5 - (0.04 * float(KFPRI.ClientVeteranSkillLevel)); // Up to 74% discount on PipeBomb
    }
    else if (Item == class'M79Pickup' || Item == class 'M32Pickup'
        || Item == class 'LawPickup' || Item == class 'M4203Pickup') {
        return 0.90 - (0.10 * float(KFPRI.ClientVeteranSkillLevel)); // Up to 70% discount on M79/M32
    }
    return 1.0;
}

static function float GetAmmoCostScaling(KFPlayerReplicationInfo KFPRI, class<Pickup> Item) {
    if (Item == class'PipeBombPickup') {
        return 0.5 - (0.04 * float(KFPRI.ClientVeteranSkillLevel)); // Up to 74% discount on PipeBomb
    }
    else if ( Item == class'M79Pickup' || Item == class'M32Pickup'
        || Item == class'LAWPickup' || Item == class'M4203Pickup') {
        return 1.0 - (0.05 * float(KFPRI.ClientVeteranSkillLevel)); // Up to 30% discount on Grenade Launcher and LAW Ammo
    }

    return 1.0;

}

defaultproperties {
    VeterancyName="Demo"

    LevelEffects(0)="5% extra Explosives damage|25% resistance to Explosives|10% discount on Explosives|50% off Remote Explosives"
    LevelEffects(1)="10% extra Explosives damage|30% resistance to Explosives|20% increase in grenade capacity|Can carry 3 Remote Explosives|20% discount on Explosives|54% off Remote Explosives"
    LevelEffects(2)="20% extra Explosives damage|35% resistance to Explosives|40% increase in grenade capacity|Can carry 4 Remote Explosives|30% discount on Explosives|58% off Remote Explosives"
    LevelEffects(3)="30% extra Explosives damage|40% resistance to Explosives|60% increase in grenade capacity|Can carry 5 Remote Explosives|40% discount on Explosives|62% off Remote Explosives"
    LevelEffects(4)="40% extra Explosives damage|45% resistance to Explosives|80% increase in grenade capacity|Can carry 6 Remote Explosives|50% discount on Explosives|66% off Remote Explosives"
    LevelEffects(5)="50% extra Explosives damage|50% resistance to Explosives|100% increase in grenade capacity|Can carry 7 Remote Explosives|60% discount on Explosives|70% off Remote Explosives|Spawn with a Pipe Bomb"
    LevelEffects(6)="60% extra Explosives damage|55% resistance to Explosives|120% increase in grenade capacity|Can carry 8 Remote Explosives|70% discount on Explosives|74% off Remote Explosives|Spawn with an M79 and Pipe Bomb"
}
