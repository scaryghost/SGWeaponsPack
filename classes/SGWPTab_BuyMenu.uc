class SGWPTab_BuyMenu extends SRKFTab_BuyMenu;

defaultproperties {
     Begin Object Class=SGWPBuyMenuInvListBox Name=InventoryBox
         OnCreateComponent=InventoryBox.InternalOnCreateComponent
         WinTop=0.070841
         WinLeft=0.000108
         WinWidth=0.328204
         WinHeight=0.521856
     End Object
     InvSelect=SGWPBuyMenuInvListBox'SGWeaponsPack.SGWPTab_BuyMenu.InventoryBox'

    Begin Object Class=SGWPBuyMenuSaleListBox Name=SaleBox
        OnCreateComponent=SaleBox.InternalOnCreateComponent
        WinTop=0.064312
        WinLeft=0.672632
        WinWidth=0.325857
        WinHeight=0.674039
    End Object
    SaleSelect=SGWPBuyMenuSaleListBox'SGWeaponsPack.SGWPTab_BuyMenu.SaleBox'
}
