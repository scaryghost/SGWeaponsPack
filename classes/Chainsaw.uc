class Chainsaw extends KFMod.Chainsaw;

defaultproperties {
    bAmmoHUDAsBar= true;
    bConsumesPhysicalAmmo= true;
    bMeleeWeapon= false;
    MagCapacity= 750;
    bShowChargingBar= true;

    FireModeClass(0)=class'SGWeaponsPack.ChainsawFire'
    FireModeClass(1)=class'SGWeaponsPack.ChainsawAltFire'

    PickupClass=class'SGWeaponsPack.ChainsawPickup'
    ItemName="SG Chainsaw"
}
