package logic.ui
{
   import com.star.frameworks.display.Container;
   import com.star.frameworks.managers.StringManager;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import logic.entry.GamePlayer;
   import logic.entry.HButton;
   import logic.game.GameKernel;
   import logic.reader.CcorpsReader;
   import logic.ui.tip.CustomTip;
   import logic.widget.DataWidget;
   import net.base.NetManager;
   import net.msg.corpsMsg.MSG_REQUEST_CONSORTIAUPGRADE;
   import net.msg.corpsMsg.MSG_REQUEST_CONSORTIAUPGRADECANCEL;
   import net.msg.corpsMsg.MSG_RESP_CONSORTIAUPGRADE;
   import net.msg.corpsMsg.MSG_RESP_CONSORTIAUPGRADECANCEL;
   
   public class MyCorpsUI_Upgrade
   {
      
      private static var instance:MyCorpsUI_Upgrade;
      
      private var ParentLock:Container;
      
      private var UpgradeMc:MovieClip;
      
      private var BtnCorps:HButton;
      
      private var BtnMall:HButton;
      
      private var BtnCompose:HButton;
      
      private var BtnStorage:HButton;
      
      private var BtnCorpsCancel:HButton;
      
      private var BtnMallCancel:HButton;
      
      private var BtnComposeCancel:HButton;
      
      private var BtnStorageCancel:HButton;
      
      private var IsShowing:Boolean;
      
      private var _CorpsLevel:int;
      
      private var _StorageLevel:int;
      
      private var _CorpsWealth:int;
      
      private var _ComposeLevel:int;
      
      private var _ShopLevel:int;
      
      public function MyCorpsUI_Upgrade()
      {
         var _loc1_:MovieClip = null;
         var _loc2_:HButton = null;
         var _loc3_:MovieClip = null;
         super();
         this.UpgradeMc = GameKernel.getMovieClipInstance("CorpsupgradeMcPop",GameKernel.fullRect.width / 2 + GameKernel.fullRect.x,300,false);
         this.ParentLock = new Container("TransferMcPopSceneLock");
         this.ParentLock.mouseEnabled = true;
         this.ParentLock.mouseChildren = true;
         this.ParentLock.fillRectangleWithoutBorder(GameKernel.fullRect.x,GameKernel.fullRect.y,GameKernel.fullRect.width,GameKernel.fullRect.height,0,0.5);
         _loc1_ = this.UpgradeMc.getChildByName("btn_close") as MovieClip;
         _loc2_ = new HButton(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.btn_closeClick);
         _loc3_ = this.UpgradeMc.getChildByName("mc_list0") as MovieClip;
         _loc1_ = _loc3_.getChildByName("btn_upgrade") as MovieClip;
         this.BtnCorps = new HButton(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.CorpsUpgrade);
         _loc1_.addEventListener(MouseEvent.MOUSE_OVER,this.CorpsMouseOver);
         _loc1_.addEventListener(MouseEvent.MOUSE_OUT,this._CorpsMouseOut);
         _loc1_ = _loc3_.getChildByName("btn_cancel") as MovieClip;
         this.BtnCorpsCancel = new HButton(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.CorpsUpgradeCancel);
         _loc1_.addEventListener(MouseEvent.MOUSE_OVER,this.CancelMouseOver);
         _loc1_.addEventListener(MouseEvent.MOUSE_OUT,this._CorpsMouseOut);
         _loc3_ = this.UpgradeMc.getChildByName("mc_list1") as MovieClip;
         _loc1_ = _loc3_.getChildByName("btn_upgrade") as MovieClip;
         this.BtnMall = new HButton(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.MallUpgrade);
         _loc1_.addEventListener(MouseEvent.MOUSE_OVER,this.MallMouseOver);
         _loc1_.addEventListener(MouseEvent.MOUSE_OUT,this._CorpsMouseOut);
         _loc1_ = _loc3_.getChildByName("btn_cancel") as MovieClip;
         this.BtnMallCancel = new HButton(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.MallUpgradeCancel);
         _loc1_.addEventListener(MouseEvent.MOUSE_OVER,this.CancelMouseOver);
         _loc1_.addEventListener(MouseEvent.MOUSE_OUT,this._CorpsMouseOut);
         _loc3_ = this.UpgradeMc.getChildByName("mc_list2") as MovieClip;
         _loc1_ = _loc3_.getChildByName("btn_upgrade") as MovieClip;
         this.BtnCompose = new HButton(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.ComposeUpgrade);
         _loc1_.addEventListener(MouseEvent.MOUSE_OVER,this.ComposeMouseOver);
         _loc1_.addEventListener(MouseEvent.MOUSE_OUT,this._CorpsMouseOut);
         _loc1_ = _loc3_.getChildByName("btn_cancel") as MovieClip;
         this.BtnComposeCancel = new HButton(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.ComposeUpgradeCancel);
         _loc1_.addEventListener(MouseEvent.MOUSE_OVER,this.CancelMouseOver);
         _loc1_.addEventListener(MouseEvent.MOUSE_OUT,this._CorpsMouseOut);
         _loc3_ = this.UpgradeMc.getChildByName("mc_list3") as MovieClip;
         _loc1_ = _loc3_.getChildByName("btn_upgrade") as MovieClip;
         this.BtnStorage = new HButton(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.StorageUpgrade);
         _loc1_.addEventListener(MouseEvent.MOUSE_OVER,this.StorageMouseOver);
         _loc1_.addEventListener(MouseEvent.MOUSE_OUT,this._CorpsMouseOut);
         _loc1_ = _loc3_.getChildByName("btn_cancel") as MovieClip;
         this.BtnStorageCancel = new HButton(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.StorageUpgradeCancel);
         _loc1_.addEventListener(MouseEvent.MOUSE_OVER,this.CancelMouseOver);
         _loc1_.addEventListener(MouseEvent.MOUSE_OUT,this._CorpsMouseOut);
      }
      
      public static function getInstance() : MyCorpsUI_Upgrade
      {
         if(instance == null)
         {
            instance = new MyCorpsUI_Upgrade();
         }
         return instance;
      }
      
      public function Show(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int) : void
      {
         var _loc7_:MovieClip = null;
         var _loc8_:TextField = null;
         var _loc9_:MovieClip = null;
         var _loc10_:MovieClip = null;
         var _loc11_:MovieClip = null;
         this._CorpsLevel = param1;
         this._CorpsWealth = param3;
         this._StorageLevel = param2;
         this._ComposeLevel = param4;
         this._ShopLevel = param5;
         _loc7_ = this.UpgradeMc.getChildByName("mc_list0") as MovieClip;
         _loc9_ = _loc7_.getChildByName("tf_buildbase") as MovieClip;
         _loc10_ = _loc7_.getChildByName("mc_nowLv") as MovieClip;
         _loc10_.gotoAndStop(param1 + 2);
         _loc8_ = _loc7_.getChildByName("tf_buildname") as TextField;
         _loc8_.text = StringManager.getInstance().getMessageString("CorpsText52");
         if(this._CorpsLevel < 9 && CcorpsReader.getInstance().GetCorpsUpgradeInfo(this._CorpsLevel + 1).@wealth <= this._CorpsWealth)
         {
            this.BtnCorps.setBtnDisabled(false);
         }
         else
         {
            this.BtnCorps.setBtnDisabled(true);
         }
         this.BtnCorps.m_movie.mouseEnabled = true;
         _loc7_ = this.UpgradeMc.getChildByName("mc_list1") as MovieClip;
         _loc9_ = _loc7_.getChildByName("tf_buildbase") as MovieClip;
         _loc10_ = _loc7_.getChildByName("mc_nowLv") as MovieClip;
         _loc10_.gotoAndStop(this._ShopLevel + 2);
         _loc8_ = _loc7_.getChildByName("tf_buildname") as TextField;
         _loc8_.text = StringManager.getInstance().getMessageString("CorpsText53");
         if(this._ShopLevel < 9 && CcorpsReader.getInstance().GetShopUpgradeInfo(this._ShopLevel + 1).@wealth <= this._CorpsWealth && this._ShopLevel < param1)
         {
            this.BtnMall.setBtnDisabled(false);
         }
         else
         {
            this.BtnMall.setBtnDisabled(true);
         }
         this.BtnMall.m_movie.mouseEnabled = true;
         _loc7_ = this.UpgradeMc.getChildByName("mc_list2") as MovieClip;
         _loc9_ = _loc7_.getChildByName("tf_buildbase") as MovieClip;
         _loc10_ = _loc7_.getChildByName("mc_nowLv") as MovieClip;
         _loc10_.gotoAndStop(param4 + 2);
         _loc8_ = _loc7_.getChildByName("tf_buildname") as TextField;
         _loc8_.text = StringManager.getInstance().getMessageString("CorpsText54");
         if(this._ComposeLevel < 9 && CcorpsReader.getInstance().GetComposeUpgradeInfo(param4 + 1).@wealth <= this._CorpsWealth && param4 < param1)
         {
            this.BtnCompose.setBtnDisabled(false);
         }
         else
         {
            this.BtnCompose.setBtnDisabled(true);
         }
         this.BtnCompose.m_movie.mouseEnabled = true;
         _loc7_ = this.UpgradeMc.getChildByName("mc_list3") as MovieClip;
         _loc9_ = _loc7_.getChildByName("tf_buildbase") as MovieClip;
         _loc10_ = _loc7_.getChildByName("mc_nowLv") as MovieClip;
         _loc10_.gotoAndStop(this._StorageLevel + 2);
         _loc8_ = _loc7_.getChildByName("tf_buildname") as TextField;
         _loc8_.text = StringManager.getInstance().getMessageString("CorpsText55");
         if(this._StorageLevel < 9 && CcorpsReader.getInstance().GetStorageUpgradeInfo(this._StorageLevel + 1).@wealth <= this._CorpsWealth && this._StorageLevel < param1)
         {
            this.BtnStorage.setBtnDisabled(false);
         }
         else
         {
            this.BtnStorage.setBtnDisabled(true);
         }
         this.BtnStorage.m_movie.mouseEnabled = true;
         if(this.IsShowing == false)
         {
            this.ParentLock.fillRectangleWithoutBorder(GameKernel.fullRect.left,GameKernel.fullRect.top,GameKernel.fullRect.width,GameKernel.fullRect.height + 130,0,0.5);
            GameKernel.renderManager.getUI().addComponent(this.ParentLock);
            this.ParentLock.addChild(this.UpgradeMc);
         }
         this.IsShowing = true;
         this.ShowUpgradeButton(param6);
      }
      
      private function ShowUpgradeButton(param1:int) : void
      {
         this.SetUpgradeButton(param1,0,this.BtnCorps,this.BtnCorpsCancel);
         this.SetUpgradeButton(param1,1,this.BtnStorage,this.BtnStorageCancel);
         this.SetUpgradeButton(param1,2,this.BtnCompose,this.BtnComposeCancel);
         this.SetUpgradeButton(param1,3,this.BtnMall,this.BtnMallCancel);
      }
      
      private function SetUpgradeButton(param1:int, param2:int, param3:HButton, param4:HButton) : void
      {
         if(param1 == -1)
         {
            param3.setVisible(true);
            param3.SetTip("");
            param4.setVisible(false);
         }
         else if(param1 == param2)
         {
            param4.setVisible(true);
            param4.setBtnDisabled(false);
            param4.SetTip(StringManager.getInstance().getMessageString("CorpsText99"));
            param3.setVisible(false);
         }
         else
         {
            param3.setVisible(true);
            param3.setBtnDisabled(true);
            param3.m_movie.mouseEnabled = true;
            param3.SetTip(StringManager.getInstance().getMessageString("CorpsText101"));
            param4.setVisible(false);
         }
      }
      
      private function Clear() : void
      {
      }
      
      private function btn_closeClick(param1:Event) : void
      {
         this.IsShowing = false;
         this.ParentLock.removeChild(this.UpgradeMc);
         GameKernel.renderManager.getUI().removeComponent(this.ParentLock);
         MyCorpsUI.getInstance().Show();
      }
      
      private function CorpsUpgrade(param1:Event) : void
      {
         if(this.BtnCorps.m_statue == "disabled")
         {
            return;
         }
         this.DisableUpgradeBtn();
         this.Upgrade(0);
      }
      
      private function MallUpgrade(param1:Event) : void
      {
         if(this.BtnMall.m_statue == "disabled")
         {
            return;
         }
         this.DisableUpgradeBtn();
         this.Upgrade(3);
      }
      
      private function ComposeUpgrade(param1:Event) : void
      {
         if(this.BtnCompose.m_statue == "disabled")
         {
            return;
         }
         this.DisableUpgradeBtn();
         this.Upgrade(2);
      }
      
      private function StorageUpgrade(param1:Event) : void
      {
         if(this.BtnStorage.m_statue == "disabled")
         {
            return;
         }
         this.DisableUpgradeBtn();
         this.Upgrade(1);
      }
      
      private function DisableUpgradeBtn() : void
      {
         this.BtnCorps.setBtnDisabled(true);
         this.BtnMall.setBtnDisabled(true);
         this.BtnCompose.setBtnDisabled(true);
         this.BtnStorage.setBtnDisabled(true);
      }
      
      private function Upgrade(param1:int) : void
      {
         var _loc2_:MSG_REQUEST_CONSORTIAUPGRADE = new MSG_REQUEST_CONSORTIAUPGRADE();
         _loc2_.Type = param1;
         _loc2_.SeqId = GamePlayer.getInstance().seqID++;
         _loc2_.Guid = GamePlayer.getInstance().Guid;
         NetManager.Instance().sendObject(_loc2_);
      }
      
      private function CorpsMouseOver(param1:MouseEvent) : void
      {
         var _loc5_:XML = null;
         var _loc6_:XML = null;
         var _loc7_:int = 0;
         var _loc8_:* = false;
         var _loc2_:MovieClip = param1.target as MovieClip;
         var _loc3_:Point = _loc2_.localToGlobal(new Point(30,20));
         var _loc4_:String = this.BtnCorps.GetTip();
         if(_loc4_ == "")
         {
            _loc5_ = CcorpsReader.getInstance().GetCorpsUpgradeInfo(this._CorpsLevel);
            if(this._CorpsLevel < 9)
            {
               _loc6_ = CcorpsReader.getInstance().GetCorpsUpgradeInfo(this._CorpsLevel + 1);
               _loc7_ = int(_loc6_.@wealth);
               _loc8_ = _loc7_ <= this._CorpsWealth;
               StringManager.getInstance().getMessageString("CorpsText54");
               _loc4_ += CustomTip.GetInstance().GetNumberText(StringManager.getInstance().getMessageString("CorpsText56") + "：","Lv." + (this._CorpsLevel + 1) + " => Lv." + (this._CorpsLevel + 2));
               _loc4_ = _loc4_ + ("\n\n" + CustomTip.GetInstance().GetNumberText(StringManager.getInstance().getMessageString("CorpsText57") + "：",_loc5_.@Number + " => " + _loc6_.@Number));
               _loc4_ = _loc4_ + ("\n\n" + CustomTip.GetInstance().GetNumberText(StringManager.getInstance().getMessageString("CorpsText58") + "：",_loc5_.@Quantity + " => " + _loc6_.@Quantity));
               _loc4_ = _loc4_ + ("\n\n" + CustomTip.GetInstance().GetNumberText(StringManager.getInstance().getMessageString("CorpsText24"),_loc7_.toString(),_loc8_));
               _loc4_ = _loc4_ + ("\n\n" + CustomTip.GetInstance().GetStringText(StringManager.getInstance().getMessageString("CorpsText98"),DataWidget.localToDataZone(_loc6_.@Time)));
            }
            else
            {
               _loc4_ = StringManager.getInstance().getMessageString("CorpsText25");
               _loc4_ = _loc4_ + ("\n\n" + CustomTip.GetInstance().GetNumberText(StringManager.getInstance().getMessageString("CorpsText57") + "：",_loc5_.@Number));
               _loc4_ = _loc4_ + ("\n\n" + CustomTip.GetInstance().GetNumberText(StringManager.getInstance().getMessageString("CorpsText58") + "：",_loc5_.@Quantity));
            }
         }
         CustomTip.GetInstance().Show(_loc4_,_loc3_);
      }
      
      private function _CorpsMouseOut(param1:MouseEvent) : void
      {
         CustomTip.GetInstance().Hide();
      }
      
      private function StorageMouseOver(param1:MouseEvent) : void
      {
         var _loc5_:XML = null;
         var _loc6_:XML = null;
         var _loc7_:int = 0;
         var _loc8_:* = false;
         var _loc2_:MovieClip = param1.target as MovieClip;
         var _loc3_:Point = _loc2_.localToGlobal(new Point(30,20));
         var _loc4_:String = this.BtnStorage.GetTip();
         if(_loc4_ == "")
         {
            _loc5_ = CcorpsReader.getInstance().GetStorageUpgradeInfo(this._StorageLevel);
            if(this._StorageLevel < 9)
            {
               _loc6_ = CcorpsReader.getInstance().GetStorageUpgradeInfo(this._StorageLevel + 1);
               _loc7_ = int(_loc6_.@wealth);
               _loc8_ = _loc7_ <= this._CorpsWealth;
               _loc4_ += CustomTip.GetInstance().GetNumberText(StringManager.getInstance().getMessageString("CorpsText55") + "：","Lv." + (this._StorageLevel + 1) + " => Lv." + (this._StorageLevel + 2));
               if(_loc5_ != null)
               {
                  _loc4_ += "\n\n" + CustomTip.GetInstance().GetNumberText(StringManager.getInstance().getMessageString("CorpsText65"),"+" + _loc5_.@Grid + " => +" + _loc6_.@Grid + "");
               }
               else
               {
                  _loc4_ += "\n\n" + CustomTip.GetInstance().GetNumberText(StringManager.getInstance().getMessageString("CorpsText65"),"+0 => +" + _loc6_.@Grid);
               }
               _loc4_ += "\n\n" + CustomTip.GetInstance().GetNumberText(StringManager.getInstance().getMessageString("CorpsText56") + "：",(this._StorageLevel + 2).toString(),this._CorpsLevel >= this._StorageLevel + 1);
               _loc4_ = _loc4_ + ("\n\n" + CustomTip.GetInstance().GetNumberText(StringManager.getInstance().getMessageString("CorpsText24"),_loc7_.toString(),_loc8_));
               _loc4_ = _loc4_ + ("\n\n" + CustomTip.GetInstance().GetStringText(StringManager.getInstance().getMessageString("CorpsText98"),DataWidget.localToDataZone(_loc6_.@Time)));
            }
            else
            {
               _loc4_ = StringManager.getInstance().getMessageString("CorpsText25");
               _loc4_ = _loc4_ + ("\n\n" + CustomTip.GetInstance().GetNumberText(StringManager.getInstance().getMessageString("CorpsText65"),_loc5_.@Grid));
            }
         }
         CustomTip.GetInstance().Show(_loc4_,_loc3_);
      }
      
      private function ComposeMouseOver(param1:MouseEvent) : void
      {
         var _loc5_:XML = null;
         var _loc6_:XML = null;
         var _loc7_:int = 0;
         var _loc8_:* = false;
         var _loc2_:MovieClip = param1.target as MovieClip;
         var _loc3_:Point = _loc2_.localToGlobal(new Point(30,20));
         var _loc4_:String = this.BtnCompose.GetTip();
         if(_loc4_ == "")
         {
            _loc5_ = CcorpsReader.getInstance().GetComposeUpgradeInfo(this._ComposeLevel);
            if(this._ComposeLevel < 9)
            {
               _loc6_ = CcorpsReader.getInstance().GetComposeUpgradeInfo(this._ComposeLevel + 1);
               _loc7_ = int(_loc6_.@wealth);
               _loc8_ = _loc7_ <= this._CorpsWealth;
               _loc4_ += CustomTip.GetInstance().GetNumberText(StringManager.getInstance().getMessageString("CorpsText54") + "：","Lv." + (this._ComposeLevel + 1) + " => Lv." + (this._ComposeLevel + 2));
               if(_loc5_ != null)
               {
                  _loc4_ += "\n\n" + CustomTip.GetInstance().GetNumberText(StringManager.getInstance().getMessageString("CorpsText66"),"+" + _loc5_.@Odds + "% => +" + _loc6_.@Odds + "%");
               }
               else
               {
                  _loc4_ += "\n\n" + CustomTip.GetInstance().GetNumberText(StringManager.getInstance().getMessageString("CorpsText66"),"+0% => +" + _loc6_.@Odds + "%");
               }
               _loc4_ += "\n\n" + CustomTip.GetInstance().GetNumberText(StringManager.getInstance().getMessageString("CorpsText56") + "：",(this._ComposeLevel + 2).toString(),this._CorpsLevel >= this._ComposeLevel + 1);
               _loc4_ = _loc4_ + ("\n\n" + CustomTip.GetInstance().GetNumberText(StringManager.getInstance().getMessageString("CorpsText24"),_loc7_.toString(),_loc8_));
               _loc4_ = _loc4_ + ("\n\n" + CustomTip.GetInstance().GetStringText(StringManager.getInstance().getMessageString("CorpsText98"),DataWidget.localToDataZone(_loc6_.@Time)));
            }
            else
            {
               _loc4_ = StringManager.getInstance().getMessageString("CorpsText25");
               _loc4_ = _loc4_ + ("\n\n" + CustomTip.GetInstance().GetNumberText(StringManager.getInstance().getMessageString("CorpsText66"),"+" + _loc5_.@Odds + "%"));
            }
         }
         CustomTip.GetInstance().Show(_loc4_,_loc3_);
      }
      
      private function MallMouseOver(param1:MouseEvent) : void
      {
         var _loc5_:XML = null;
         var _loc6_:XML = null;
         var _loc7_:int = 0;
         var _loc8_:* = false;
         var _loc2_:MovieClip = param1.target as MovieClip;
         var _loc3_:Point = _loc2_.localToGlobal(new Point(30,20));
         var _loc4_:String = this.BtnMall.GetTip();
         if(_loc4_ == "")
         {
            _loc5_ = CcorpsReader.getInstance().GetShopUpgradeInfo(this._ShopLevel);
            if(this._ShopLevel < 9)
            {
               _loc6_ = CcorpsReader.getInstance().GetShopUpgradeInfo(this._ShopLevel + 1);
               _loc7_ = int(_loc6_.@wealth);
               _loc8_ = _loc7_ <= this._CorpsWealth;
               _loc4_ += CustomTip.GetInstance().GetNumberText(StringManager.getInstance().getMessageString("CorpsText53") + "：","Lv." + (this._ShopLevel + 1) + " => Lv." + (this._ShopLevel + 2));
               _loc4_ = _loc4_ + ("\n\n" + CustomTip.GetInstance().GetNumberText(StringManager.getInstance().getMessageString("CorpsText56") + "：",(this._ShopLevel + 2).toString(),this._CorpsLevel >= this._ShopLevel + 1));
               _loc4_ = _loc4_ + ("\n\n" + CustomTip.GetInstance().GetNumberText(StringManager.getInstance().getMessageString("CorpsText24"),_loc7_.toString(),_loc8_));
               _loc4_ = _loc4_ + ("\n\n" + CustomTip.GetInstance().GetStringText(StringManager.getInstance().getMessageString("CorpsText98"),DataWidget.localToDataZone(_loc6_.@Time)));
            }
            else
            {
               _loc4_ = StringManager.getInstance().getMessageString("CorpsText25");
            }
         }
         CustomTip.GetInstance().Show(_loc4_,_loc3_);
      }
      
      private function CorpsUpgradeCancel(param1:Event) : void
      {
         this.BtnCorpsCancel.setBtnDisabled(true);
         this.UpgradeCancel(0);
      }
      
      private function MallUpgradeCancel(param1:Event) : void
      {
         this.BtnMallCancel.setBtnDisabled(true);
         this.UpgradeCancel(3);
      }
      
      private function ComposeUpgradeCancel(param1:Event) : void
      {
         this.BtnComposeCancel.setBtnDisabled(true);
         this.UpgradeCancel(2);
      }
      
      private function StorageUpgradeCancel(param1:Event) : void
      {
         this.BtnStorageCancel.setBtnDisabled(true);
         this.UpgradeCancel(1);
      }
      
      private function CancelMouseOver(param1:MouseEvent) : void
      {
      }
      
      private function UpgradeCancel(param1:int) : void
      {
         var _loc2_:MSG_REQUEST_CONSORTIAUPGRADECANCEL = new MSG_REQUEST_CONSORTIAUPGRADECANCEL();
         _loc2_.Type = param1;
         _loc2_.SeqId = GamePlayer.getInstance().seqID++;
         _loc2_.Guid = GamePlayer.getInstance().Guid;
         NetManager.Instance().sendObject(_loc2_);
      }
      
      public function RespUpgradeCancel(param1:MSG_RESP_CONSORTIAUPGRADECANCEL) : void
      {
         if(this.IsShowing)
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("CorpsText99"),0);
            this.Show(this._CorpsLevel,this._StorageLevel,param1.Wealth,this._ComposeLevel,this._ShopLevel,-1);
         }
      }
      
      public function RespUpgrade(param1:MSG_RESP_CONSORTIAUPGRADE) : void
      {
         if(this.IsShowing)
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("CorpsText100"),0);
            this.Show(this._CorpsLevel,this._StorageLevel,this._CorpsWealth,this._ComposeLevel,this._ShopLevel,param1.Type);
         }
      }
      
      public function RespCorpsUpgrade() : void
      {
         var _loc1_:int = 0;
         if(this.IsShowing)
         {
            ++this._CorpsLevel;
            _loc1_ = int(CcorpsReader.getInstance().GetCorpsUpgradeInfo(this._CorpsLevel).@wealth);
            this._CorpsWealth -= _loc1_;
            this.Show(this._CorpsLevel,this._StorageLevel,this._CorpsWealth,this._ComposeLevel,this._ShopLevel,-1);
         }
      }
      
      public function RespCorpsStorageUpgrade() : void
      {
         var _loc1_:int = 0;
         if(this.IsShowing)
         {
            ++this._StorageLevel;
            _loc1_ = int(CcorpsReader.getInstance().GetStorageUpgradeInfo(this._StorageLevel).@wealth);
            this._CorpsWealth -= _loc1_;
            this.Show(this._CorpsLevel,this._StorageLevel,this._CorpsWealth,this._ComposeLevel,this._ShopLevel,-1);
         }
      }
      
      public function RespComposeUpgrade() : void
      {
         var _loc1_:int = 0;
         if(this.IsShowing)
         {
            ++this._ComposeLevel;
            _loc1_ = int(CcorpsReader.getInstance().GetComposeUpgradeInfo(this._ComposeLevel).@wealth);
            this._CorpsWealth -= _loc1_;
            this.Show(this._CorpsLevel,this._StorageLevel,this._CorpsWealth,this._ComposeLevel,this._ShopLevel,-1);
         }
      }
      
      public function RespShopUpgrade() : void
      {
         var _loc1_:int = 0;
         if(this.IsShowing)
         {
            ++this._ShopLevel;
            _loc1_ = int(CcorpsReader.getInstance().GetShopUpgradeInfo(this._ShopLevel).@wealth);
            this._CorpsWealth -= _loc1_;
            this.Show(this._CorpsLevel,this._StorageLevel,this._CorpsWealth,this._ComposeLevel,this._ShopLevel,-1);
         }
      }
   }
}

