class SGWPBuyMenuInvListBox extends SRKFBuyMenuInvListBox;

function InitComponent(GUIController MyController, GUIComponent MyOwner) {
	Super(KFBuyMenuInvListBox).InitComponent(MyController,MyOwner);
}

defaultproperties {
    DefaultListClass="SGWeaponsPack.SGWPBuyMenuInvList"
}
