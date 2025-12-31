package logic.ui
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import logic.entry.GamePlayer;
   import logic.entry.HButton;
   import logic.entry.MObject;
   import logic.game.GameKernel;
   import net.base.NetManager;
   import net.msg.LoadHe3.MSG_REQUEST_LOADSHIPTEAM;
   import net.msg.LoadHe3.MSG_REQUEST_LOADSHIPTEAMALL;
   import net.msg.LoadHe3.MSG_REQUEST_UNLOADSHIPTEAM;
   import net.msg.LoadHe3.MSG_RESP_LOADSHIPTEAMALL;
   import net.msg.LoadHe3.MSG_RESP_LOADSHIPTEAMALL_TEMP;
   
   public class LoadFleetUI extends AbstractPopUp
   {
      
      private static var instance:LoadFleetUI;
      
      private const RowCount:int = 10;
      
      private var btn_left:HButton;
      
      private var btn_right:HButton;
      
      private var tf_page:TextField;
      
      private var tf_resnum:TextField;
      
      private var PageId:int;
      
      private var PageCount:int;
      
      private var LastSelectedList:XButton;
      
      private var MsgDataList:Array = new Array();
      
      private var TextFileList:Array = new Array();
      
      private var He3Count:int;
      
      private var He3List:Array = new Array();
      
      private var BtnList:Array = new Array();
      
      private var ShowMessage:Boolean = false;
      
      public function LoadFleetUI()
      {
         super();
         setPopUpName("LoadFleetUI");
      }
      
      public static function getInstance() : LoadFleetUI
      {
         if(instance == null)
         {
            instance = new LoadFleetUI();
         }
         return instance;
      }
      
      override public function Init() : void
      {
         this.ShowMessage = false;
         if(GameKernel.popUpDisplayManager.PopDisplayList.ContainsKey(getPopUpName()))
         {
            this.RequestFleetList();
            return;
         }
         this._mc = new MObject("FleetsupplyScene",385,300);
         this.initMcElement();
         GameKernel.popUpDisplayManager.Regisger(instance);
         this.RequestFleetList();
      }
      
      override public function initMcElement() : void
      {
         var _loc1_:HButton = null;
         var _loc2_:MovieClip = null;
         _loc2_ = this._mc.getMC().getChildByName("btn_close") as MovieClip;
         _loc1_ = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.CloseClick);
         _loc2_ = this._mc.getMC().getChildByName("btn_allempty") as MovieClip;
         _loc1_ = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_allemptyClick);
         _loc2_ = this._mc.getMC().getChildByName("brn_allsupply") as MovieClip;
         _loc1_ = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.brn_allsupplyClick);
         _loc2_ = this._mc.getMC().getChildByName("btn_allensure") as MovieClip;
         _loc1_ = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_allensureClick);
         _loc2_ = this._mc.getMC().getChildByName("btn_left") as MovieClip;
         this.btn_left = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_leftClick);
         _loc2_ = this._mc.getMC().getChildByName("btn_right") as MovieClip;
         this.btn_right = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_rightClick);
         this.tf_page = this._mc.getMC().getChildByName("tf_page") as TextField;
         this.tf_resnum = this._mc.getMC().getChildByName("tf_resnum") as TextField;
         _loc2_ = this._mc.getMC().getChildByName("btn_buy") as MovieClip;
         _loc1_ = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_buyClick);
         this.InitList();
      }
      
      private function btn_buyClick(param1:MouseEvent) : void
      {
         StateHandlingUI.getInstance().Init();
         StateHandlingUI.getInstance().setParent("_ResPlaneUI");
         StateHandlingUI.getInstance().getstate(915,916,917);
         StateHandlingUI.getInstance().InitPopUp();
         GameKernel.popUpDisplayManager.Show(StateHandlingUI.getInstance());
      }
      
      private function InitList() : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:XButton = null;
         var _loc4_:TextField = null;
         var _loc5_:XTextField = null;
         var _loc1_:int = 0;
         while(_loc1_ < this.RowCount)
         {
            _loc2_ = this._mc.getMC().getChildByName("mc_list" + _loc1_) as MovieClip;
            _loc3_ = new XButton(_loc2_);
            _loc3_.Data = _loc1_;
            _loc3_.OnMouseOver = this.ListMouseOver;
            _loc3_.OnClick = this.ListMouseOver;
            _loc2_.mouseEnabled = true;
            _loc2_.mouseChildren = true;
            _loc3_ = new XButton(_loc2_.btn_left as MovieClip);
            _loc3_.Data = _loc1_;
            _loc3_.OnClick = this.List_btn_leftClick;
            _loc3_ = new XButton(_loc2_.btn_right as MovieClip);
            _loc3_.Data = _loc1_;
            _loc3_.OnClick = this.List_btn_rightClick;
            _loc3_ = new XButton(_loc2_.btn_ensure as MovieClip);
            _loc3_.Data = _loc1_;
            _loc3_.OnClick = this.List_btn_ensureClick;
            this.BtnList.push(_loc3_);
            _loc4_ = _loc2_.tf_He3num as TextField;
            _loc4_.restrict = "0-9";
            _loc5_ = new XTextField(_loc4_);
            _loc5_.Data = _loc1_;
            _loc5_.OnChange = this.OnHe3Change;
            this.TextFileList.push(_loc5_);
            _loc1_++;
         }
      }
      
      private function OnHe3Change(param1:Event, param2:XTextField) : void
      {
         if(param2.text == "")
         {
            param2.text = "0";
         }
         var _loc3_:int = this.PageId * this.RowCount + param2.Data;
         var _loc4_:MSG_RESP_LOADSHIPTEAMALL_TEMP = this.MsgDataList[_loc3_];
         var _loc5_:int = int(param2.text);
         _loc5_ = this.He3Change(_loc3_,_loc5_);
         param2.text = _loc5_.toString();
         this.ResetKeepNum(param2.Data,_loc5_,_loc4_.Supply);
         this.ResetEnsureButton(param2.Data,_loc5_,_loc4_.Gas);
      }
      
      private function ResetEnsureButton(param1:int, param2:int, param3:int) : void
      {
         XButton(this.BtnList[param1]).setBtnDisabled(param2 == param3);
      }
      
      private function ResetKeepNum(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:int = param2 / param3;
         var _loc5_:MovieClip = this._mc.getMC().getChildByName("mc_list" + param1) as MovieClip;
         TextField(_loc5_.tf_huihe).text = _loc4_.toString();
      }
      
      private function He3Change(param1:int, param2:int) : int
      {
         var _loc3_:MSG_RESP_LOADSHIPTEAMALL_TEMP = this.MsgDataList[param1];
         if(param2 > _loc3_.ShipSpace)
         {
            param2 = _loc3_.ShipSpace;
         }
         this.He3Count += this.He3List[param1];
         if(param2 > this.He3Count)
         {
            param2 = this.He3Count;
         }
         this.He3Count -= param2;
         this.He3List[param1] = param2;
         this.tf_resnum.text = this.He3Count.toString();
         return param2;
      }
      
      private function Clear() : void
      {
         var _loc2_:MovieClip = null;
         this.tf_resnum.text = GamePlayer.getInstance().UserHe3.toString();
         this.MsgDataList.length = 0;
         this.He3List.length = 0;
         this.He3Count = GamePlayer.getInstance().UserHe3;
         this.PageId = 0;
         this.PageCount = 0;
         this.SetPageButton();
         var _loc1_:int = 0;
         while(_loc1_ < this.RowCount)
         {
            _loc2_ = this._mc.getMC().getChildByName("mc_list" + _loc1_) as MovieClip;
            _loc2_.visible = false;
            _loc1_++;
         }
      }
      
      private function RequestFleetList() : void
      {
         this.Clear();
         var _loc1_:MSG_REQUEST_LOADSHIPTEAMALL = new MSG_REQUEST_LOADSHIPTEAMALL();
         _loc1_.SeqId = GamePlayer.getInstance().seqID++;
         _loc1_.Guid = GamePlayer.getInstance().Guid;
         NetManager.Instance().sendObject(_loc1_);
      }
      
      public function RespFleetList(param1:MSG_RESP_LOADSHIPTEAMALL) : void
      {
         var _loc4_:MSG_RESP_LOADSHIPTEAMALL_TEMP = null;
         var _loc2_:* = this.MsgDataList.length == 0;
         var _loc3_:int = 0;
         while(_loc3_ < param1.DataLen)
         {
            _loc4_ = param1.Data[_loc3_];
            this.He3List.push(_loc4_.Gas);
            this.MsgDataList.push(_loc4_);
            _loc3_++;
         }
         this.PageCount = this.MsgDataList.length / this.RowCount;
         if(this.PageCount * this.RowCount < this.MsgDataList.length)
         {
            ++this.PageCount;
         }
         this.SetPageButton();
         if(_loc2_)
         {
            this.ShowFleetList();
         }
      }
      
      private function ShowFleetList() : void
      {
         var _loc3_:MovieClip = null;
         var _loc4_:MSG_RESP_LOADSHIPTEAMALL_TEMP = null;
         var _loc5_:int = 0;
         var _loc1_:int = this.PageId * this.RowCount;
         var _loc2_:int = 0;
         while(_loc2_ < this.RowCount)
         {
            _loc3_ = this._mc.getMC().getChildByName("mc_list" + _loc2_) as MovieClip;
            if(_loc1_ < this.MsgDataList.length)
            {
               _loc3_.visible = true;
               _loc4_ = this.MsgDataList[_loc1_];
               TextField(_loc3_.tf_fleetname).text = _loc4_.ShipName;
               TextField(_loc3_.tf_fleetnum).text = _loc4_.ShipNum.toString();
               _loc5_ = this.He3List[_loc1_] / (_loc4_.Supply + 1);
               TextField(_loc3_.tf_huihe).text = _loc5_.toString();
               TextField(_loc3_.tf_He3num).text = this.He3List[_loc1_].toString();
               this.ResetEnsureButton(_loc2_,this.He3List[_loc1_],_loc4_.Gas);
            }
            else
            {
               _loc3_.visible = false;
            }
            _loc1_++;
            _loc2_++;
         }
      }
      
      private function List_btn_leftClick(param1:MouseEvent, param2:XButton) : void
      {
         var _loc3_:XTextField = this.TextFileList[param2.Data];
         _loc3_.text = "0";
         this.OnHe3Change(null,_loc3_);
      }
      
      private function List_btn_rightClick(param1:MouseEvent, param2:XButton) : void
      {
         var _loc3_:int = this.PageId * this.RowCount + param2.Data;
         var _loc4_:MSG_RESP_LOADSHIPTEAMALL_TEMP = this.MsgDataList[_loc3_];
         var _loc5_:XTextField = this.TextFileList[param2.Data];
         _loc5_.text = _loc4_.ShipSpace.toString();
         this.OnHe3Change(null,_loc5_);
      }
      
      private function LoadHe3(param1:int) : void
      {
         var _loc4_:MSG_REQUEST_LOADSHIPTEAM = null;
         var _loc5_:MSG_REQUEST_UNLOADSHIPTEAM = null;
         var _loc2_:int = int(this.He3List[param1]);
         var _loc3_:MSG_RESP_LOADSHIPTEAMALL_TEMP = this.MsgDataList[param1];
         if(_loc2_ > _loc3_.Gas)
         {
            _loc4_ = new MSG_REQUEST_LOADSHIPTEAM();
            _loc4_.ShipTeamId = _loc3_.ShipTeamId;
            _loc4_.Gas = _loc2_ - _loc3_.Gas;
            _loc4_.SeqId = GamePlayer.getInstance().seqID++;
            _loc4_.Guid = GamePlayer.getInstance().Guid;
            NetManager.Instance().sendObject(_loc4_);
         }
         else if(_loc2_ < _loc3_.Gas)
         {
            _loc5_ = new MSG_REQUEST_UNLOADSHIPTEAM();
            _loc5_.ShipTeamId = _loc3_.ShipTeamId;
            _loc5_.Gas = _loc3_.Gas - _loc2_;
            _loc5_.SeqId = GamePlayer.getInstance().seqID++;
            _loc5_.Guid = GamePlayer.getInstance().Guid;
            NetManager.Instance().sendObject(_loc5_);
         }
         _loc3_.Gas = _loc2_;
      }
      
      private function List_btn_ensureClick(param1:MouseEvent, param2:XButton) : void
      {
         var _loc3_:int = param2.Data;
         param2.setBtnDisabled(true);
         var _loc4_:int = this.PageId * this.RowCount + _loc3_;
         this.LoadHe3(_loc4_);
         this.ShowMessage = true;
      }
      
      private function btn_allemptyClick(param1:Event) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:MSG_RESP_LOADSHIPTEAMALL_TEMP = null;
         var _loc2_:int = 0;
         while(_loc2_ < this.MsgDataList.length)
         {
            _loc3_ = this.He3Change(_loc2_,0);
            if(int(_loc2_ / this.RowCount) == this.PageId)
            {
               _loc4_ = _loc2_ % this.RowCount;
               XTextField(this.TextFileList[_loc4_]).text = _loc3_.toString();
               _loc5_ = this.MsgDataList[_loc2_];
               this.ResetKeepNum(_loc4_,_loc3_,_loc5_.Supply);
               this.ResetEnsureButton(_loc4_,_loc3_,_loc5_.Gas);
            }
            _loc2_++;
         }
      }
      
      private function brn_allsupplyClick(param1:Event) : void
      {
         var _loc3_:MSG_RESP_LOADSHIPTEAMALL_TEMP = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc2_:int = 0;
         while(_loc2_ < this.MsgDataList.length)
         {
            _loc3_ = this.MsgDataList[_loc2_];
            _loc4_ = this.He3Change(_loc2_,_loc3_.ShipSpace);
            if(int(_loc2_ / this.RowCount) == this.PageId)
            {
               _loc5_ = _loc2_ % this.RowCount;
               XTextField(this.TextFileList[_loc5_]).text = _loc4_.toString();
               this.ResetKeepNum(_loc5_,_loc4_,_loc3_.Supply);
               this.ResetEnsureButton(_loc5_,_loc4_,_loc3_.Gas);
            }
            _loc2_++;
         }
      }
      
      private function btn_allensureClick(param1:Event) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < this.MsgDataList.length)
         {
            this.LoadHe3(_loc2_);
            _loc2_++;
         }
         this.CloseClick(null);
      }
      
      private function ListMouseOver(param1:MouseEvent, param2:XButton) : void
      {
         if(this.LastSelectedList != null)
         {
            this.LastSelectedList.setSelect(false);
         }
         this.LastSelectedList = param2;
         this.LastSelectedList.setSelect(true);
      }
      
      private function CloseClick(param1:MouseEvent) : void
      {
         GameKernel.popUpDisplayManager.Hide(this);
         if(ShipTransferUI.instance.isShow)
         {
            ShipTransferUI.instance.reloadSupply();
            InstanceUI.instance.reloadSupply();
         }
      }
      
      private function btn_leftClick(param1:MouseEvent) : void
      {
         --this.PageId;
         this.SetPageButton();
         this.ShowFleetList();
      }
      
      private function btn_rightClick(param1:MouseEvent) : void
      {
         ++this.PageId;
         this.SetPageButton();
         this.ShowFleetList();
      }
      
      private function SetPageButton() : void
      {
         if(this.PageCount == 0)
         {
            this.tf_page.text = "1/1";
            this.btn_left.setBtnDisabled(true);
            this.btn_right.setBtnDisabled(true);
            return;
         }
         if(this.PageId > 0)
         {
            this.btn_left.setBtnDisabled(false);
         }
         else
         {
            this.btn_left.setBtnDisabled(true);
         }
         if(this.PageId + 1 >= this.PageCount)
         {
            this.btn_right.setBtnDisabled(true);
         }
         else
         {
            this.btn_right.setBtnDisabled(false);
         }
         this.tf_page.text = this.PageId + 1 + "/" + this.PageCount;
      }
   }
}

