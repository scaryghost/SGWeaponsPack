class ChainsawAmmo extends KFMod.ChainsawAmmo;

defaultproperties {
    bAcceptsAmmoPickups= true;
    PickupClass=class'SGWeaponsPack.ChainsawAmmoPickup'

    /** Set up "fuel" for the chainsaw */
    AmmoPickupAmount=100
    MaxAmmo= 1500;
    InitialAmount= 1500;
}
