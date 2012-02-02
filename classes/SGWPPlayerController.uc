class SGWPPlayerController extends KFPCServ;

function SetPawnClass(string inClass, string inCharacter) {
    PawnClass = Class'SGWeaponsPack.SGWPHumanPawn';
    inCharacter = Class'KFGameType'.Static.GetValidCharacter(inCharacter);
    PawnSetupRecord = class'xUtil'.static.FindPlayerRecord(inCharacter);
    PlayerReplicationInfo.SetCharacterName(inCharacter);
}

function ShowBuyMenu(string wlTag,float maxweight){
    StopForceFeedback();
    ClientOpenMenu(string(Class'SGWeaponsPack.SGWPGUIBuyMenu'),,wlTag,string(maxweight));
}

