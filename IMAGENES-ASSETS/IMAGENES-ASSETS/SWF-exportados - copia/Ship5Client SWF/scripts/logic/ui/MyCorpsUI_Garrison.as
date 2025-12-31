package logic.ui
{
   import com.star.frameworks.display.Container;
   import com.star.frameworks.managers.StringManager;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import logic.entry.GamePlayer;
   import logic.entry.HButton;
   import logic.entry.HButtonType;
   import logic.entry.commander.CommanderInfo;
   import logic.entry.shipmodel.ShipbodyInfo;
   import logic.game.GameKernel;
   import logic.reader.CShipmodelReader;
   import net.base.NetManager;
   import net.msg.corpsMsg.MSG_REQUEST_GOTORESOURCESTAR;
   import net.msg.corpsMsg.MSG_RESP_GOTORESOURCESTAR;
   import net.msg.ship.*;
   import net.router.CommanderRouter;
   
   public class MyCorpsUI_Garrison
   {
      
      private static var instance:MyCorpsUI_Garrison;
      
      private var ParentLock:Container;
      
      private var GarrisonMc:MovieClip;
      
      private var btn_left:HButton;
      
      private var btn_right:HButton;
      
      private var tf_page:TextField;
      
      private var PageIndex:int;
      
      private var PageCount:int;
      
      private var MsgFleetList:MSG_RESP_JUMPGALAXYSHIP;
      
      private var ItemList:Array;
      
      private var SelectedCount:int;
      
      private var _GalaxyMapId:int;
      
      private var _GalaxyId:int;
      
      private var _ShipMaxNum:int;
      
      private var btn_battle:HButton;
      
      private var SelectedList:Array;
      
      public function MyCorpsUI_Garrison()
      {
         var _loc1_:MovieClip = null;
         var _loc2_:HButton = null;
         this.SelectedList = new Array();
         super();
         this.ItemList = new Array();
         this.GarrisonMc = GameKernel.getMovieClipInstance("CorpsgarrisonScene",385,300,false);
         this.ParentLock = new Container("MyCorpsUI_GarrisonSceneLock");
         this.ParentLock.mouseEnabled = true;
         this.ParentLock.mouseChildren = true;
         this.ParentLock.fillRectangleWithoutBorder(GameKernel.fullRect.x,GameKernel.fullRect.y,GameKernel.fullRect.width,GameKernel.fullRect.height,0,0.5);
         _loc1_ = this.GarrisonMc.getChildByName("btn_close") as MovieClip;
         _loc2_ = new HButton(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.btn_closeClick);
         _loc1_ = this.GarrisonMc.getChildByName("btn_left") as MovieClip;
         this.btn_left = new HButton(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.btn_leftClick);
         _loc1_ = this.GarrisonMc.getChildByName("btn_right") as MovieClip;
         this.btn_right = new HButton(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.btn_rightClick);
         this.tf_page = this.GarrisonMc.getChildByName("tf_page") as TextField;
         _loc1_ = this.GarrisonMc.getChildByName("btn_battle") as MovieClip;
         this.btn_battle = new HButton(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.btn_battleClick);
         this.InitList();
      }
      
      public static function getInstance() : MyCorpsUI_Garrison
      {
         if(instance == null)
         {
            instance = new MyCorpsUI_Garrison();
         }
         return instance;
      }
      
      private function InitList() : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:XButton = null;
         var _loc1_:int = 0;
         while(_loc1_ < 9)
         {
            _loc2_ = this.GarrisonMc.getChildByName("mc_list" + _loc1_) as MovieClip;
            _loc3_ = new XButton(_loc2_,HButtonType.SELECT);
            this.ItemList.push(_loc3_);
            _loc3_.Data = _loc1_;
            _loc3_.OnMouseUp = this.ItemClick;
            _loc2_.visible = false;
            _loc1_++;
         }
      }
      
      private function Clear() : void
      {
         var _loc2_:MovieClip = null;
         var _loc1_:int = 0;
         while(_loc1_ < 9)
         {
            _loc2_ = this.GarrisonMc.getChildByName("mc_list" + _loc1_) as MovieClip;
            _loc2_.visible = false;
            _loc1_++;
         }
         TextField(this.GarrisonMc.tf_fleetpage).text = "";
         this.PageIndex = 0;
         this.PageCount = 0;
         this.SelectedCount = 0;
         this.MsgFleetList = null;
         TextField(this.GarrisonMc.getChildByName("tf_fleetpage")).text = "0/" + this._ShipMaxNum;
         this.ShowPageButton();
      }
      
      private function ShowPageButton() : void
      {
         if(this.PageCount == 0)
         {
            this.tf_page.text = "";
            return;
         }
         if(this.PageIndex > 0)
         {
            this.btn_left.setBtnDisabled(false);
         }
         else
         {
            this.btn_left.setBtnDisabled(true);
         }
         if(this.PageIndex + 1 < this.PageCount)
         {
            this.btn_right.setBtnDisabled(false);
         }
         else
         {
            this.btn_right.setBtnDisabled(true);
         }
         this.tf_page.text = this.PageIndex + 1 + "/" + this.PageCount;
      }
      
      private function RequestFleetList(param1:int, param2:int) : void
      {
         this.MsgFleetList = null;
         var _loc3_:MSG_REQUEST_JUMPGALAXYSHIP = new MSG_REQUEST_JUMPGALAXYSHIP();
         _loc3_.Type = 1;
         _loc3_.GalaxyMapId = param1;
         _loc3_.GalaxyId = param2;
         _loc3_.SeqId = GamePlayer.getInstance().seqID++;
         _loc3_.Guid = GamePlayer.getInstance().Guid;
         NetManager.Instance().sendObject(_loc3_);
      }
      
      public function ResqFleetList(param1:MSG_RESP_JUMPGALAXYSHIP) : void
      {
         if(this.MsgFleetList != null)
         {
            this.MsgFleetList.DataLen += param1.DataLen;
            this.MsgFleetList.Data = this.MsgFleetList.Data.concat(param1.Data);
         }
         else
         {
            this.MsgFleetList = param1;
            this.ResetSelectedList();
            this.ShowList();
         }
         this.PageCount = this.MsgFleetList.DataLen / 9;
         if(this.PageCount * 9 < this.MsgFleetList.DataLen)
         {
            ++this.PageCount;
         }
         this.ShowPageButton();
      }
      
      private function ResetSelectedList() : void
      {
         this.SelectedList.splice(0);
         var _loc1_:int = 0;
         while(_loc1_ < this.MsgFleetList.DataLen)
         {
            this.SelectedList.push(0);
            _loc1_++;
         }
      }
      
      private function ShowList() : void
      {
         var _loc3_:MovieClip = null;
         var _loc4_:MSG_RESP_JUMPGALAXYSHIP_TEMP = null;
         var _loc5_:MovieClip = null;
         var _loc6_:Bitmap = null;
         var _loc7_:ShipbodyInfo = null;
         var _loc8_:CommanderInfo = null;
         var _loc1_:int = this.PageIndex * 9;
         var _loc2_:int = 0;
         while(_loc2_ < 9)
         {
            _loc3_ = this.GarrisonMc.getChildByName("mc_list" + _loc2_) as MovieClip;
            if(_loc1_ < this.MsgFleetList.DataLen)
            {
               _loc4_ = this.MsgFleetList.Data[_loc1_];
               _loc3_.visible = true;
               _loc5_ = _loc3_.getChildByName("mc_commanderbase") as MovieClip;
               if(_loc5_.numChildren > 0)
               {
                  _loc5_.removeChildAt(0);
               }
               _loc6_ = CommanderSceneUI.getInstance().CommanderImg(_loc4_.CommanderId);
               _loc6_.width = 50;
               _loc6_.height = 50;
               _loc5_.addChild(_loc6_);
               _loc5_ = _loc3_.getChildByName("mc_fleetbase") as MovieClip;
               if(_loc5_.numChildren > 0)
               {
                  _loc5_.removeChildAt(0);
               }
               _loc7_ = CShipmodelReader.getInstance().getShipBodyInfo(_loc4_.BodyId);
               _loc6_ = new Bitmap(GameKernel.getTextureInstance(_loc7_.SmallIcon));
               _loc5_.addChild(_loc6_);
               _loc8_ = CommanderRouter.instance.selectCommander(_loc4_.CommanderId);
               if(_loc8_ != null)
               {
                  TextField(_loc3_.tf_num).text = (_loc8_.commander_level + 1).toString();
               }
               else
               {
                  TextField(_loc3_.tf_num).text = "";
               }
               TextField(_loc3_.tf_fleetname).text = _loc4_.TeamName;
               TextField(_loc3_.tf_fleetnum).text = _loc4_.ShipNum.toString();
               XButton(this.ItemList[_loc2_]).setBtnDisabled(false);
               XButton(this.ItemList[_loc2_]).setSelect(this.SelectedList[_loc1_] == 1);
            }
            else
            {
               _loc3_.visible = false;
            }
            _loc1_++;
            _loc2_++;
         }
         this.btn_battle.setBtnDisabled(false);
         this.ShowPageButton();
      }
      
      public function Show(param1:int, param2:int, param3:int) : void
      {
         this._GalaxyMapId = param1;
         this._GalaxyId = param2;
         this._ShipMaxNum = param3;
         this.Clear();
         this.RequestFleetList(param1,param2);
         GameKernel.renderManager.getUI().addComponent(this.ParentLock);
         this.ParentLock.addChild(this.GarrisonMc);
      }
      
      private function btn_battleClick(param1:Event) : void
      {
         var _loc5_:MSG_RESP_JUMPGALAXYSHIP_TEMP = null;
         var _loc2_:MSG_REQUEST_GOTORESOURCESTAR = new MSG_REQUEST_GOTORESOURCESTAR();
         _loc2_.DataLen = 0;
         var _loc3_:int = 0;
         while(_loc3_ < this.MsgFleetList.DataLen)
         {
            if(this.SelectedList[_loc3_] == 1)
            {
               _loc5_ = this.MsgFleetList.Data[_loc3_];
               _loc2_.ShipTeamId[_loc2_.DataLen] = _loc5_.ShipTeamId;
               ++_loc2_.DataLen;
            }
            _loc3_++;
         }
         var _loc4_:int = 0;
         while(_loc4_ < 9)
         {
            XButton(this.ItemList[_loc4_]).setBtnDisabled(true);
            _loc4_++;
         }
         if(_loc2_.DataLen <= 0)
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("StarText6"),0);
            return;
         }
         _loc2_.GalaxyMapId = this._GalaxyMapId;
         _loc2_.GalaxyId = this._GalaxyId;
         _loc2_.SeqId = GamePlayer.getInstance().seqID++;
         _loc2_.Guid = GamePlayer.getInstance().Guid;
         NetManager.Instance().sendObject(_loc2_);
         this.btn_battle.setBtnDisabled(true);
         this.btn_left.setBtnDisabled(true);
         this.btn_right.setBtnDisabled(true);
      }
      
      public function Resp_MSG_RESP_GOTORESOURCESTAR(param1:MSG_RESP_GOTORESOURCESTAR) : void
      {
         if(param1.ErrorCode == 1)
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("StarText7"),0);
            return;
         }
         if(param1.ErrorCode == 2)
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("CorpsText168"),0);
            return;
         }
         var _loc2_:int = 0;
         while(_loc2_ < this.MsgFleetList.DataLen)
         {
            if(this.SelectedList[_loc2_] == 1)
            {
               this.MsgFleetList.Data.splice(_loc2_,1);
               --this.MsgFleetList.DataLen;
               this.SelectedList.splice(_loc2_,1);
            }
            else
            {
               _loc2_++;
            }
         }
         this.PageIndex = 0;
         this.PageCount = this.MsgFleetList.DataLen / 9;
         if(this.PageCount * 9 < this.MsgFleetList.DataLen)
         {
            ++this.PageCount;
         }
         this.ShowPageButton();
         this.ShowList();
      }
      
      private function btn_closeClick(param1:Event) : void
      {
         this.ParentLock.removeChild(this.GarrisonMc);
         GameKernel.renderManager.getUI().removeComponent(this.ParentLock);
      }
      
      private function ItemClick(param1:MouseEvent, param2:XButton) : void
      {
         if(param2.m_selsected)
         {
            if(this.SelectedCount >= this._ShipMaxNum)
            {
               param2.setSelect(false);
               return;
            }
            ++this.SelectedCount;
         }
         else
         {
            --this.SelectedCount;
         }
         var _loc3_:int = this.PageIndex * 9 + param2.Data;
         this.SelectedList[_loc3_] = param2.m_selsected ? 1 : 0;
         TextField(this.GarrisonMc.getChildByName("tf_fleetpage")).text = this.SelectedCount.toString() + "/" + this._ShipMaxNum;
      }
      
      private function btn_leftClick(param1:Event) : void
      {
         --this.PageIndex;
         this.ShowList();
      }
      
      private function btn_rightClick(param1:Event) : void
      {
         ++this.PageIndex;
         this.ShowList();
      }
   }
}

