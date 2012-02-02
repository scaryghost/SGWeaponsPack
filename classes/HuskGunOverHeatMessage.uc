class HuskGunOverHeatMessage extends LocalMessage;

var(Message) localized String message;
var(Message) color yellowColor;

static function color GetCOlor(optional int index, 
        optional PlayerReplicationInfo RelatedPRI_1, 
        optional PlayerReplicationInfo RelatedPRI_2) {
    return default.yellowColor;
}

static function string GetString(optional int index,
        optional PlayerReplicationInfo RelatedPRI_1, 
        optional PlayerReplicationInfo RelatedPRI_2,
        optional Object OptionalObject) {
    return default.message;
}

defaultproperties {
    message="Overheating..."
    
    YellowColor=(G=255,R=255,A=255)

    bIsConsoleMessage=False
    bFadeMessage=True
    bBeep=false
    Lifetime=2
    DrawColor=(G=160,R=0)
    StackMode=SM_None
    PosY=0.8500000
    PosX=0.900000
    FontSize=3
}
