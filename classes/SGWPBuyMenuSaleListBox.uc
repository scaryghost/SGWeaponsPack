class SGWPBuyMenuSaleListBox extends SRBuyMenuSaleListBox;

function InitComponent(GUIController MyController, GUIComponent MyOwner) {
    Super(KFBuyMenuSaleListBox).InitComponent(MyController,MyOwner);
}

defaultproperties {
    DefaultListClass="SGWeaponsPack.SGWPBuyMenuSaleList"
}
