class KFCBMutator extends Mutator;

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
    }
    return true;
}

function PostBeginPlay() {
    local KFGameType KF;
    local int i,k;
    local replacementPair replacementValue;

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
    FriendlyName="Scary Ghost Weapon's Pack"
    Description="Applies bug/exploit fixes and feature changes to the stock weapons.  Version 1.0.0"

    pickupReplaceArray(0)=(oldClass=class'KFMod.ChainsawPickup',newClass=class'KFCommBeta.KFCBChainsawPickup',bReplace=true)
    pickupReplaceArray(1)=(oldClass=class'KFMod.LAWPickup',newClass=class'KFCommBeta.KFCBLAWPickup',bReplace=true)
    pickupReplaceArray(2)=(oldClass=class'KFMod.SCARMK17Pickup',newClass=class'KFCommBeta.KFCBSCARMK17Pickup',bReplace=true)
    pickupReplaceArray(3)=(oldClass=class'KFMod.DeaglePickup',newClass=class'KFCommBeta.KFCBDeaglePickup',bReplace=true)
    pickupReplaceArray(4)=(oldClass=class'KFMod.DualDeaglePickup',newClass=class'KFCommBeta.KFCBDualDeaglePickup',bReplace=true)
    pickupReplaceArray(5)=(oldClass=class'KFMod.Dual44MagnumPickup',newClass=class'KFCommBeta.KFCBDual44MagnumPickup',bReplace=true)
    pickupReplaceArray(6)=(oldClass=class'KFMod.Magnum44Pickup',newClass=class'KFCommBeta.KFCBMagnum44Pickup',bReplace=true)
    pickupReplaceArray(7)=(oldClass=class'KFMod.HuskGunPickup',newClass=class'KFCommBeta.KFCBHuskGunPickup',bReplace=true)
    pickupReplaceArray(8)=(oldClass=class'KFMod.MP7MPickup',newClass=class'KFCommBeta.KFCBMP7MPickup',bReplace=true)
    pickupReplaceArray(9)=(oldClass=class'KFMod.MP5MPickup',newClass=class'KFCommBeta.KFCBMP5MPickup',bReplace=true)

    ammoReplaceArray(0)=(oldClass=class'KFMod.ChainsawAmmo',newClass=class'KFCommBeta.KFCBChainsawAmmo',bReplace=true)

}
