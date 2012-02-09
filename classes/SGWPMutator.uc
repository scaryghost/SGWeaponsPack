class SGWPMutator extends Mutator;

struct replacementPair {
    var class<Object> oldClass;
    var class<Object> newClass;
    var bool bReplace;
};

var array<replacementPair> pickupReplaceArray;
var array<replacementPair> ammoReplaceArray;

static function int shouldReplace(string objectName, array<replacementPair> replacementArray) {
    local int i, replaceIndex;

    replaceIndex= -1;
    for(i=0; replaceIndex == -1 && i < replacementArray.length; i++) {
        if (objectName ~= String(replacementArray[i].oldClass)) {
            replaceIndex = i;
        }
    }
    
    return replaceIndex;
}

function bool CheckReplacement(Actor Other, out byte bSuperRelevant) {
    local int index;

    if (KFWeaponPickup(Other) != none) {
        index= shouldReplace(String(Other.class), pickupReplaceArray);
        if (index != -1) {
            ReplaceWith(Other,String(pickupReplaceArray[index].newClass));
            return false;
        }
    } else if (KFWeapon(Other) != none) {
        index= shouldReplace(String(KFWeapon(Other).PickupClass.class), pickupReplaceArray);
        if (index != -1) {
            ReplaceWith(Other,String(class<Pickup>(pickupReplaceArray[index].newClass).default.InventoryType));
            return false;
        }
    } else if (KFAmmoPickup(Other) != none) {
        index= shouldReplace(String(KFWeapon(Other).PickupClass.class), ammoReplaceArray);
        if (index != -1) {
            ReplaceWith(Other,String(class<Pickup>(ammoReplaceArray[index].newClass).default.InventoryType));
            return false;
        }
    }
    return true;
}

function PostBeginPlay() {
    local KFGameType KF;

    KF = KFGameType(Level.Game);
    if (Level.NetMode != NM_Standalone)
        AddToPackageMap("KFCommBeta");

    if (KF == none) {
        Destroy();
        return;
    }

    KF.PlayerControllerClass= class'SGWeaponsPack.SGWPPlayerController';
    KF.PlayerControllerClassName= "SGWeaponsPack.SGWPPlayerController";
}

defaultproperties {
    GroupName="KF-SGWeaponsPack"
    FriendlyName="SG Weapon Pack"
    Description="Applies bug/exploit fixes and feature changes to the stock weapons.  Version 1.0.0"

    pickupReplaceArray(0)=(oldClass=class'KFMod.ChainsawPickup',newClass=class'SGWeaponsPack.ChainsawPickup',bReplace=true)
    pickupReplaceArray(1)=(oldClass=class'KFMod.LAWPickup',newClass=class'SGWeaponsPack.LAWPickup',bReplace=true)
    pickupReplaceArray(2)=(oldClass=class'KFMod.SCARMK17Pickup',newClass=class'SGWeaponsPack.SCARMK17Pickup',bReplace=true)
    pickupReplaceArray(3)=(oldClass=class'KFMod.DeaglePickup',newClass=class'SGWeaponsPack.DeaglePickup',bReplace=true)
    pickupReplaceArray(4)=(oldClass=class'KFMod.DualDeaglePickup',newClass=class'SGWeaponsPack.DualDeaglePickup',bReplace=true)
    pickupReplaceArray(5)=(oldClass=class'KFMod.Dual44MagnumPickup',newClass=class'SGWeaponsPack.Dual44MagnumPickup',bReplace=true)
    pickupReplaceArray(6)=(oldClass=class'KFMod.Magnum44Pickup',newClass=class'SGWeaponsPack.Magnum44Pickup',bReplace=true)
    pickupReplaceArray(7)=(oldClass=class'KFMod.HuskGunPickup',newClass=class'SGWeaponsPack.HuskGunPickup',bReplace=true)
    pickupReplaceArray(8)=(oldClass=class'KFMod.MP7MPickup',newClass=class'SGWeaponsPack.MP7MPickup',bReplace=true)
    pickupReplaceArray(9)=(oldClass=class'KFMod.MP5MPickup',newClass=class'SGWeaponsPack.MP5MPickup',bReplace=true)

    ammoReplaceArray(0)=(oldClass=class'KFMod.ChainsawAmmoPickup',newClass=class'SGWeaponsPack.ChainsawAmmoPickup',bReplace=true)
    ammoReplaceArray(1)=(oldClass=class'KFMod.HuskGunAmmoPickup',newClass=class'SGWeaponsPack.HuskGunAmmoPickup',bReplace=true)

}
