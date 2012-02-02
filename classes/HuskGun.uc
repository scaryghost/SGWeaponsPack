class HuskGun extends KFMod.Huskgun;

var float ammoRegenRate, ammoRegenCount, msgTimer;
var int coolDownLimit;
var bool bIsInCoolDown;

simulated function Tick(float delta) {
    super.Tick(delta);

    if ( AmmoAmount(0) < FireMode[0].AmmoClass.Default.MaxAmmo) {
        ammoRegenCount+= (delta * ammoRegenRate);
        ConsumeAmmo(0, -1*(ammoRegenCount));
        ammoRegenCount-= int(ammoRegenCount);
    
        if (FireMode[0].AmmoPerFire > 0 && InventoryGroup > 0 && !bMeleeWeapon && bConsumesPhysicalAmmo &&
                !(Ammo[0] == none || FireMode[0] == none || FireMode[0].AmmoPerFire <= 0 || Ammo[0].AmmoAmount < coolDownLimit)) {
            bIsInCoolDown= false;
            msgTimer= 0;
        } else if (bIsInCoolDown) {
            msgTimer-= delta;
            if (msgTimer <= 0) {
                PlayerController(KFCBHumanPawn(Owner).Controller).ReceiveLocalizedMessage(class'HuskGunOverHeatMessage');
                msgTimer= class'HuskGunOverHeatMessage'.default.LifeTime;
            }
        }
    }
}

simulated function OutOfAmmo() {
    bIsInCoolDown= true;
}

defaultproperties {
    ammoRegenRate= 1.0
    coolDownLimit= 10
    FireModEClass(0)=class'SGWeaponsPack.HuskGunFire'
    PickupClass=class'SGWeaponsPack.HuskGunPickup'
    ItemName="SG HuskGun"
}