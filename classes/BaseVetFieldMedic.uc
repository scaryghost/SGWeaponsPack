class BaseVetFieldMedic extends SRVetFieldMedic
    abstract;

// Change the cost of particular items
static function float GetCostScaling(KFPlayerReplicationInfo KFPRI, class<Pickup> Item) {
    if ( Item == class'Vest' ) {
        return 0.9 - (0.10 * float(KFPRI.ClientVeteranSkillLevel));  // Up to 70% discount on Body Armor
    }
    else if ( Item == class'MP7MPickup' || Item == class'MP5MPickup' ) {
        return 0.25 - (0.02 * float(KFPRI.ClientVeteranSkillLevel));  // Up to 87% discount on Medic Gun
    }

    return 1.0;
}

static function AddDefaultInventory(KFPlayerReplicationInfo KFPRI, Pawn P) {
    // If Level 5 or Higher, give them Body Armor
    if ( KFPRI.ClientVeteranSkillLevel >= 5 )
        P.ShieldStrength = 100;
    // If Level 6, give them a Medic Gun
    if ( KFPRI.ClientVeteranSkillLevel >= 6 )
        KFHumanPawn(P).CreateInventoryVeterancy("SGWeaponsPack.MP7MMedicGun", GetCostScaling(KFPRI, class'SGWeaponsPack.MP7MPickup'));
}

defaultproperties {
     VeterancyName="Medic"
     LevelEffects(0)="10% faster Syringe recharge|10% more potent medical injections|10% less damage from Bloat Bile|10% discount on Body Armor|75% discount on Medic Guns"
     LevelEffects(1)="25% faster Syringe recharge|25% more potent medical injections|25% less damage from Bloat Bile|20% larger Medic Gun clips|10% better Body Armor|20% discount on Body Armor|77% discount on Medic Guns"
     LevelEffects(2)="50% faster Syringe recharge|25% more potent medical injections|50% less damage from Bloat Bile|5% faster movement speed|40% larger Medic Gun clips|20% better Body Armor|30% discount on Body Armor|79% discount on Medic Guns"
     LevelEffects(3)="75% faster Syringe recharge|50% more potent medical injections|50% less damage from Bloat Bile|10% faster movement speed|60% larger Medic Gun clips|30% better Body Armor|40% discount on Body Armor|81% discount on Medic Guns"
     LevelEffects(4)="100% faster Syringe recharge|50% more potent medical injections|50% less damage from Bloat Bile|15% faster movement speed|80% larger Medic Gun clips|40% better Body Armor|50% discount on Body Armor|83% discount on Medic Guns"
     LevelEffects(5)="150% faster Syringe recharge|50% more potent medical injections|75% less damage from Bloat Bile|20% faster movement speed|100% larger Medic Gun clips|50% better Body Armor|60% discount on Body Armor|85% discount on Medic Guns|Spawn with Body Armor"
     LevelEffects(6)="200% faster Syringe recharge|75% more potent medical injections|75% less damage from Bloat Bile|25% faster movement speed|100% larger Medic Gun clips|75% better Body Armor|70% discount on Body Armor||87% discount on Medic Guns| Spawn with Body Armor and Medic Gun"
}
