package logic.ui
{
   import com.star.frameworks.managers.StringManager;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.utils.Timer;
   import logic.entry.GamePlayer;
   import logic.entry.HButton;
   import logic.entry.HButtonStatue;
   import logic.entry.HButtonType;
   import logic.entry.MObject;
   import logic.entry.shipmodel.ShipbodyInfo;
   import logic.entry.shipmodel.ShipmodelInfo;
   import logic.entry.shipmodel.ShippartInfo;
   import logic.game.GameKernel;
   import logic.reader.CShipmodelReader;
   import logic.ui.tip.ShipModelInfoTip;
   import logic.widget.DataWidget;
   import net.base.NetManager;
   import net.msg.ship.MSG_REQUEST_BRUISESHIPDELETE;
   import net.msg.ship.MSG_REQUEST_BRUISESHIPINFO;
   import net.msg.ship.MSG_REQUEST_BRUISESHIPRELIVE;
   import net.msg.ship.MSG_REQUEST_SPEEDBRUISESHIP;
   import net.msg.ship.MSG_RESP_BRUISESHIPDELETE;
   import net.msg.ship.MSG_RESP_BRUISESHIPINFO;
   import net.msg.ship.MSG_RESP_BRUISESHIPINFO_TEMP;
   import net.msg.ship.MSG_RESP_BRUISESHIPRELIVE;
   import net.msg.ship.MSG_RESP_SPEEDBRUISESHIP;
   import net.router.ShipmodelRouter;
   
   public class ShipPairUI extends AbstractPopUp
   {
      
      private static var instance:ShipPairUI;
      
      private var btn_left:HButton;
      
      private var btn_right:HButton;
      
      private var tf_page:TextField;
      
      private var tf_repairnum:TextField;
      
      private var MsgShipList:MSG_RESP_BRUISESHIPINFO;
      
      private var PageId:int;
      
      private var ShipListArray:Array;
      
      private var PageRowCount:int = 5;
      
      private var PairTiemr:Timer;
      
      private var mc_base:MovieClip;
      
      private var tf_time:TextField;
      
      private var tf_name:TextField;
      
      private var tf_num:TextField;
      
      private var btn_quicken:HButton;
      
      private var btn_cancel:HButton;
      
      private var btn_start:HButton;
      
      private var DeleteShipId:int;
      
      private var SelectedShip:XMovieClip;
      
      private var MaxNum:int;
      
      private var SelectedModelId:int;
      
      public function ShipPairUI()
      {
         super();
         setPopUpName("ShipPairUI");
      }
      
      public static function getInstance() : ShipPairUI
      {
         if(instance == null)
         {
            instance = new ShipPairUI();
         }
         return instance;
      }
      
      override public function Init() : void
      {
         if(!GameKernel.popUpDisplayManager.PopDisplayList.ContainsKey(getPopUpName()))
         {
            this._mc = new MObject("BoatrepairScene",385,300);
            GameKernel.popUpDisplayManager.Regisger(instance);
            this.initMcElement();
         }
         this.Clear();
         this.RequestShipList();
      }
      
      override public function initMcElement() : void
      {
         var _loc1_:HButton = null;
         var _loc2_:MovieClip = null;
         var _loc4_:XMovieClip = null;
         var _loc5_:XButton = null;
         this.PairTiemr = new Timer(1000);
         this.PairTiemr.addEventListener(TimerEvent.TIMER,this.OnPairTiemr);
         _loc2_ = this._mc.getMC().getChildByName("btn_close") as MovieClip;
         _loc1_ = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.CloseClick);
         _loc2_ = this._mc.getMC().getChildByName("btn_quicken") as MovieClip;
         this.btn_quicken = new HButton(_loc2_,HButtonType.SIMPLE,false,StringManager.getInstance().getMessageString("ShipRepair1"));
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_quickenClick);
         _loc2_ = this._mc.getMC().getChildByName("btn_cancel") as MovieClip;
         this.btn_cancel = new HButton(_loc2_,HButtonType.SIMPLE,false,StringManager.getInstance().getMessageString("ShipRepair2"));
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_cancelClick);
         _loc2_ = this._mc.getMC().getChildByName("btn_start") as MovieClip;
         this.btn_start = new HButton(_loc2_,HButtonType.SIMPLE,false,StringManager.getInstance().getMessageString("ShipRepair3"));
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_startClick);
         _loc2_ = this._mc.getMC().getChildByName("btn_up") as MovieClip;
         this.btn_left = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_leftClick);
         _loc2_ = this._mc.getMC().getChildByName("btn_down") as MovieClip;
         this.btn_right = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_rightClick);
         this.tf_page = this._mc.getMC().getChildByName("tf_page") as TextField;
         _loc2_ = this._mc.getMC().getChildByName("btn_front") as MovieClip;
         _loc1_ = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_frontClick);
         _loc2_ = this._mc.getMC().getChildByName("btn_next") as MovieClip;
         _loc1_ = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_nextClick);
         this.tf_repairnum = this._mc.getMC().getChildByName("tf_repairnum") as TextField;
         this.tf_repairnum.addEventListener(Event.CHANGE,this.tf_repairnumChange);
         this.tf_repairnum.restrict = "0-9";
         this.ShipListArray = new Array();
         var _loc3_:int = 0;
         while(_loc3_ < this.PageRowCount)
         {
            _loc4_ = new XMovieClip(this._mc.getMC().getChildByName("mc_list" + _loc3_) as MovieClip);
            _loc4_.Data = _loc3_;
            _loc4_.OnClick = this.ShipClick;
            _loc4_.OnMouseOver = this.ShiwMouseOver;
            _loc4_.m_movie.addEventListener(MouseEvent.ROLL_OUT,this.ShipMouseOut);
            _loc4_.m_movie.stop();
            this.ShipListArray.push(_loc4_);
            _loc5_ = new XButton(_loc4_.m_movie.btn_close);
            _loc5_.Data = _loc3_;
            _loc5_.OnClick = this.DeleteShip;
            _loc3_++;
         }
         this.tf_time = TextField(this._mc.getMC().getChildByName("tf_time"));
         this.tf_name = TextField(this._mc.getMC().getChildByName("tf_name"));
         this.tf_num = TextField(this._mc.getMC().getChildByName("tf_num"));
         this.mc_base = MovieClip(this._mc.getMC().getChildByName("mc_base"));
         this.mc_base.addEventListener(MouseEvent.MOUSE_OVER,this.mc_baseMouseOver);
         this.mc_base.addEventListener(MouseEvent.MOUSE_OUT,this.ShipMouseOut);
      }
      
      private function RequestShipList() : void
      {
         this.MsgShipList = null;
         this.PageId = 0;
         var _loc1_:MSG_REQUEST_BRUISESHIPINFO = new MSG_REQUEST_BRUISESHIPINFO();
         _loc1_.SeqId = GamePlayer.getInstance().seqID++;
         _loc1_.Guid = GamePlayer.getInstance().Guid;
         NetManager.Instance().sendObject(_loc1_);
      }
      
      public function RespShipList(param1:MSG_RESP_BRUISESHIPINFO) : void
      {
         this.MsgShipList = param1;
         this.ShowShipList();
         this.ShowPairShip();
      }
      
      private function ShowPairShip() : void
      {
         this.tf_time.text = "";
         this.tf_name.text = "";
         this.tf_num.text = "";
         if(this.mc_base.numChildren > 1)
         {
            this.mc_base.removeChildAt(1);
         }
         this.btn_quicken.setBtnDisabled(true);
         this.btn_quicken.m_movie.mouseEnabled = true;
         this.btn_cancel.setBtnDisabled(true);
         this.btn_cancel.m_movie.mouseEnabled = true;
         this.btn_start.setBtnDisabled(true);
         this.btn_start.m_movie.mouseEnabled = true;
         this.PairTiemr.stop();
         if(this.MsgShipList == null)
         {
            return;
         }
         if(this.MsgShipList.ShipModelId < 0)
         {
            return;
         }
         var _loc1_:ShipmodelInfo = ShipmodelRouter.instance.ShipModeList.Get(this.MsgShipList.ShipModelId);
         this.ShowShip(_loc1_,DataWidget.GetTimeString(this.MsgShipList.NeedTime),this.MsgShipList.Num);
         this.btn_quicken.setBtnDisabled(false);
         this.btn_cancel.setBtnDisabled(false);
         this.PairTiemr.start();
      }
      
      private function ShowShip(param1:ShipmodelInfo, param2:String, param3:int) : void
      {
         if(this.mc_base.numChildren > 1)
         {
            this.mc_base.removeChildAt(1);
         }
         this.tf_time.text = param2;
         this.tf_name.text = param1.m_ShipName;
         this.tf_num.text = param3.toString();
         var _loc4_:ShipbodyInfo = CShipmodelReader.getInstance().getShipBodyInfo(param1.m_BodyId);
         var _loc5_:Bitmap = new Bitmap(GameKernel.getTextureInstance(_loc4_.SmallIcon));
         _loc5_.x = -8;
         _loc5_.y = 0;
         this.mc_base.addChild(_loc5_);
      }
      
      private function OnPairTiemr(param1:Event) : void
      {
         if(this.MsgShipList == null)
         {
            return;
         }
         --this.MsgShipList.NeedTime;
         if(this.MsgShipList.NeedTime <= 0)
         {
            this.MsgShipList.ShipModelId = -1;
            this.ShowPairShip();
         }
         else
         {
            TextField(this._mc.getMC().getChildByName("tf_time")).text = DataWidget.GetTimeString(this.MsgShipList.NeedTime);
         }
      }
      
      private function ShowShipList() : void
      {
         var _loc3_:MovieClip = null;
         var _loc4_:MSG_RESP_BRUISESHIPINFO_TEMP = null;
         var _loc5_:ShipmodelInfo = null;
         var _loc6_:ShipbodyInfo = null;
         var _loc7_:Bitmap = null;
         var _loc1_:int = this.PageId * this.PageRowCount;
         var _loc2_:int = 0;
         for(; _loc2_ < this.PageRowCount; _loc2_++)
         {
            _loc3_ = XMovieClip(this.ShipListArray[_loc2_]).m_movie;
            if(_loc1_ < this.MsgShipList.DataLen)
            {
               _loc3_.visible = true;
               _loc4_ = this.MsgShipList.DeadShipData[_loc1_];
               _loc5_ = ShipmodelRouter.instance.ShipModeList.Get(_loc4_.ShipModelId);
               if(_loc5_ == null)
               {
                  this.MsgShipList.DeadShipData.splice(_loc1_,1);
                  --this.MsgShipList.DataLen;
                  _loc2_--;
                  continue;
               }
               TextField(_loc3_.tf_name).text = _loc5_.m_ShipName;
               TextField(_loc3_.tf_num).text = _loc4_.Num.toString();
               TextField(_loc3_.tf_time).text = this.GetCreateTime(_loc5_,_loc4_.Num);
               _loc6_ = CShipmodelReader.getInstance().getShipBodyInfo(_loc5_.m_BodyId);
               _loc7_ = new Bitmap(GameKernel.getTextureInstance(_loc6_.SmallIcon));
               if(MovieClip(_loc3_.mc_base).numChildren > 0)
               {
                  MovieClip(_loc3_.mc_base).removeChildAt(0);
               }
               _loc7_.x = -8;
               _loc7_.y = 0;
               MovieClip(_loc3_.mc_base).addChild(_loc7_);
            }
            else
            {
               _loc3_.visible = false;
            }
            _loc1_++;
         }
         this.ResetPageButton();
      }
      
      private function ResetPageButton() : void
      {
         if(this.MsgShipList == null)
         {
            return;
         }
         var _loc1_:int = this.MsgShipList.DataLen / this.PageRowCount;
         if(_loc1_ * this.PageRowCount < this.MsgShipList.DataLen)
         {
            _loc1_++;
         }
         this.btn_left.setBtnDisabled(this.PageId == 0);
         this.btn_right.setBtnDisabled(this.PageId + 1 >= _loc1_);
         this.tf_page.text = int(this.PageId + 1).toString();
      }
      
      private function GetCreateTime(param1:ShipmodelInfo, param2:int) : String
      {
         var _loc6_:ShippartInfo = null;
         var _loc3_:ShipbodyInfo = CShipmodelReader.getInstance().getShipBodyInfo(param1.m_BodyId);
         var _loc4_:int = _loc3_.CreateTime;
         var _loc5_:int = 0;
         while(_loc5_ < param1.m_PartNum)
         {
            _loc6_ = CShipmodelReader.getInstance().getShipPartInfo(param1.m_PartId[_loc5_]);
            _loc4_ += _loc6_.CreateTime;
            _loc5_++;
         }
         return DataWidget.GetTimeString(_loc4_ * param2 * 0.75);
      }
      
      private function Clear() : void
      {
         var _loc2_:MovieClip = null;
         this.SelectedModelId = -1;
         this.MsgShipList = null;
         var _loc1_:int = 0;
         while(_loc1_ < this.PageRowCount)
         {
            _loc2_ = XMovieClip(this.ShipListArray[_loc1_]).m_movie;
            _loc2_.visible = false;
            _loc1_++;
         }
         this.btn_left.setBtnDisabled(true);
         this.btn_right.setBtnDisabled(true);
         this.tf_page.text = "";
         this.btn_quicken.setBtnDisabled(true);
         this.btn_quicken.m_movie.mouseEnabled = true;
         this.btn_cancel.setBtnDisabled(true);
         this.btn_cancel.m_movie.mouseEnabled = true;
         this.btn_start.setBtnDisabled(true);
         this.btn_start.m_movie.mouseEnabled = true;
         if(this.mc_base.numChildren > 1)
         {
            this.mc_base.removeChildAt(1);
         }
      }
      
      private function CloseClick(param1:Event) : void
      {
         this.PairTiemr.stop();
         GameKernel.popUpDisplayManager.Hide(this);
      }
      
      private function btn_quickenClick(param1:Event) : void
      {
         if(this.btn_quicken.m_statue == HButtonStatue.DISABLED)
         {
            return;
         }
         if(this.MsgShipList == null)
         {
            return;
         }
         if(this.MsgShipList.NeedTime <= this.MsgShipList.Num)
         {
            return;
         }
         if(GamePlayer.getInstance().SpValue < GamePlayer.getInstance().ShipSpeedCredit)
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("SpeedTXT02"));
            return;
         }
         var _loc2_:MSG_REQUEST_SPEEDBRUISESHIP = new MSG_REQUEST_SPEEDBRUISESHIP();
         _loc2_.ShipModelId = this.MsgShipList.ShipModelId;
         _loc2_.SeqId = GamePlayer.getInstance().seqID++;
         _loc2_.Guid = GamePlayer.getInstance().Guid;
         NetManager.Instance().sendObject(_loc2_);
      }
      
      public function RespSpeetPair(param1:MSG_RESP_SPEEDBRUISESHIP) : void
      {
         if(this.MsgShipList == null)
         {
            return;
         }
         if(param1.ErrorCode == 0)
         {
            GamePlayer.getInstance().SpValue = GamePlayer.getInstance().SpValue - GamePlayer.getInstance().ShipSpeedCredit;
            PlayerInfoUI.getInstance().resetPlayerSp(GamePlayer.getInstance().SpValue);
            this.MsgShipList.ShipModelId = param1.ShipModelId;
            this.MsgShipList.NeedTime = param1.SpareTime;
         }
      }
      
      private function btn_cancelClick(param1:Event) : void
      {
         if(this.btn_cancel.m_statue == HButtonStatue.DISABLED)
         {
            return;
         }
         if(this.MsgShipList == null)
         {
            return;
         }
         var _loc2_:MSG_REQUEST_BRUISESHIPRELIVE = new MSG_REQUEST_BRUISESHIPRELIVE();
         _loc2_.ShipModelId = this.MsgShipList.ShipModelId;
         _loc2_.Num = this.MsgShipList.Num;
         _loc2_.Type = 1;
         _loc2_.SeqId = GamePlayer.getInstance().seqID++;
         _loc2_.Guid = GamePlayer.getInstance().Guid;
         NetManager.Instance().sendObject(_loc2_);
         this.Clear();
      }
      
      private function btn_startClick(param1:Event) : void
      {
         if(this.btn_start.m_statue == HButtonStatue.DISABLED)
         {
            if(this.MsgShipList != null && this.MsgShipList.ShipModelId >= 0)
            {
               MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("ShipRepair4"),1);
            }
            else if(this.SelectedModelId < 0)
            {
               MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("ShipRepair5"),1);
            }
            return;
         }
         if(this.tf_repairnum.text == "")
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("FormationText3"));
            return;
         }
         var _loc2_:int = int(this.tf_repairnum.text);
         var _loc3_:MSG_REQUEST_BRUISESHIPRELIVE = new MSG_REQUEST_BRUISESHIPRELIVE();
         _loc3_.ShipModelId = this.SelectedModelId;
         _loc3_.Num = _loc2_;
         _loc3_.Type = 0;
         _loc3_.SeqId = GamePlayer.getInstance().seqID++;
         _loc3_.Guid = GamePlayer.getInstance().Guid;
         NetManager.Instance().sendObject(_loc3_);
         this.SelectedModelId = -1;
         this.Clear();
      }
      
      public function RespPair(param1:MSG_RESP_BRUISESHIPRELIVE) : void
      {
         if(param1.ErrorCode != 0 && param1.Type == 0)
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("ShipText27"));
         }
         else
         {
            this.RequestShipList();
         }
      }
      
      private function btn_leftClick(param1:Event) : void
      {
         --this.PageId;
         this.ShowShipList();
      }
      
      private function btn_rightClick(param1:Event) : void
      {
         ++this.PageId;
         this.ShowShipList();
      }
      
      private function btn_frontClick(param1:Event) : void
      {
         if(this.MsgShipList == null)
         {
            return;
         }
         this.tf_repairnum.text = "1";
      }
      
      private function btn_nextClick(param1:Event) : void
      {
         if(this.MsgShipList == null)
         {
            return;
         }
         this.tf_repairnum.text = this.MaxNum.toString();
      }
      
      private function DeleteShip(param1:Event, param2:XButton) : void
      {
         if(this.MsgShipList == null)
         {
            return;
         }
         var _loc3_:int = this.PageId * this.PageRowCount + param2.Data;
         var _loc4_:MSG_RESP_BRUISESHIPINFO_TEMP = this.MsgShipList.DeadShipData[_loc3_];
         this.DeleteShipId = _loc4_.ShipModelId;
         MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("ShipText30"),2,this.DoDeleteShip);
      }
      
      private function DoDeleteShip() : void
      {
         var _loc1_:MSG_REQUEST_BRUISESHIPDELETE = new MSG_REQUEST_BRUISESHIPDELETE();
         _loc1_.ShipModelId = this.DeleteShipId;
         _loc1_.SeqId = GamePlayer.getInstance().seqID++;
         _loc1_.Guid = GamePlayer.getInstance().Guid;
         NetManager.Instance().sendObject(_loc1_);
         this.Clear();
      }
      
      public function RespDeleteShip(param1:MSG_RESP_BRUISESHIPDELETE) : void
      {
         this.RequestShipList();
      }
      
      private function ShipClick(param1:Event, param2:XMovieClip) : void
      {
         var _loc4_:MSG_RESP_BRUISESHIPINFO_TEMP = null;
         var _loc5_:ShipmodelInfo = null;
         if(this.SelectedShip != null)
         {
            this.SelectedShip.m_movie.gotoAndStop(1);
         }
         this.SelectedShip = param2;
         this.SelectedShip.m_movie.gotoAndStop(2);
         if(this.MsgShipList == null)
         {
            return;
         }
         var _loc3_:int = this.PageId * this.PageRowCount + param2.Data;
         if(this.MsgShipList.ShipModelId < 0)
         {
            _loc4_ = this.MsgShipList.DeadShipData[_loc3_];
            _loc5_ = ShipmodelRouter.instance.ShipModeList.Get(_loc4_.ShipModelId);
            this.ShowShip(_loc5_,TextField(param2.m_movie.tf_time).text,_loc4_.Num);
            this.btn_start.setBtnDisabled(false);
            this.MaxNum = _loc4_.Num;
            this.tf_repairnum.text = this.MaxNum.toString();
            this.SelectedModelId = _loc4_.ShipModelId;
         }
      }
      
      private function tf_repairnumChange(param1:Event) : void
      {
         if(this.tf_repairnum.text == "")
         {
            return;
         }
         var _loc2_:int = int(this.tf_repairnum.text);
         if(_loc2_ > this.MaxNum)
         {
            this.tf_repairnum.text = this.MaxNum.toString();
         }
         else if(_loc2_ <= 0)
         {
            this.tf_repairnum.text = "1";
         }
      }
      
      private function ShiwMouseOver(param1:Event, param2:XMovieClip) : void
      {
         var _loc3_:int = this.PageId * this.PageRowCount + param2.Data;
         var _loc4_:MSG_RESP_BRUISESHIPINFO_TEMP = this.MsgShipList.DeadShipData[_loc3_];
         var _loc5_:Point = new Point(0,param2.m_movie.height);
         _loc5_ = param2.m_movie.localToGlobal(_loc5_);
         ShipModelInfoTip.GetInstance().Show(_loc4_.ShipModelId,_loc5_);
      }
      
      private function mc_baseMouseOver(param1:MouseEvent) : void
      {
         var _loc2_:int = -1;
         if(this.MsgShipList != null && this.MsgShipList.ShipModelId >= 0)
         {
            _loc2_ = this.MsgShipList.ShipModelId;
         }
         else if(this.SelectedModelId >= 0)
         {
            _loc2_ = this.SelectedModelId;
         }
         if(_loc2_ < 0)
         {
            return;
         }
         var _loc3_:Point = new Point(this.mc_base.width,0);
         _loc3_ = this.mc_base.localToGlobal(_loc3_);
         ShipModelInfoTip.GetInstance().Show(_loc2_,_loc3_);
      }
      
      private function ShipMouseOut(param1:MouseEvent) : void
      {
         ShipModelInfoTip.GetInstance().Hide();
      }
   }
}

