package logic.ui
{
   import com.star.frameworks.managers.StringManager;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.utils.Timer;
   import logic.action.GalaxyMapAction;
   import logic.entry.GamePlayer;
   import logic.entry.HButton;
   import logic.entry.HButtonStatue;
   import logic.entry.StarLevelEntry;
   import logic.game.GameKernel;
   import logic.game.GameMouseZoneManager;
   import logic.reader.StarLevelReader;
   import logic.ui.tip.CustomTip;
   import logic.widget.DataWidget;
   import net.base.NetManager;
   import net.common.MsgTypes;
   import net.msg.corpsMsg.MSG_REQUEST_CONSORTIAFIELD;
   import net.msg.corpsMsg.MSG_RESP_CONSORTIAFIELD;
   import net.msg.corpsMsg.MSG_RESP_CONSORTIAFIELD_TEMP;
   
   public class MyCorpsUI_Demesne implements MyCorpsUI_Base
   {
      
      private static var instance:MyCorpsUI_Demesne;
      
      public var PageIndex:int;
      
      public var PageCount:int;
      
      private var _PageRows:int;
      
      private var McList:Array;
      
      private var DemesneList:MSG_RESP_CONSORTIAFIELD;
      
      private var _Timer:Timer;
      
      private var btn_army_List:Array;
      
      private var SelectedRow:XMovieClip;
      
      public function MyCorpsUI_Demesne(param1:int)
      {
         var _loc3_:MovieClip = null;
         var _loc4_:XMovieClip = null;
         var _loc5_:MovieClip = null;
         var _loc6_:XButton = null;
         var _loc7_:HButton = null;
         super();
         this.btn_army_List = new Array();
         this._PageRows = param1;
         this.McList = new Array();
         this._Timer = new Timer(1000);
         this._Timer.addEventListener(TimerEvent.TIMER,this.UpdateTime);
         var _loc2_:int = 0;
         while(_loc2_ < this._PageRows)
         {
            _loc3_ = GameKernel.getMovieClipInstance("DemesnelistPlan",0,0,false);
            _loc3_.name = "Item" + _loc2_;
            _loc4_ = new XMovieClip(_loc3_);
            _loc4_.Data = _loc2_;
            _loc4_.OnMouseOver = this.RowClick;
            _loc4_.m_movie.gotoAndStop("up");
            _loc5_ = _loc3_.getChildByName("btn_army") as MovieClip;
            _loc6_ = new XButton(_loc5_);
            _loc6_.Data = _loc2_;
            _loc6_.OnClick = this.btn_armyClick;
            this.btn_army_List.push(_loc6_);
            _loc5_ = _loc3_.getChildByName("btn_enter") as MovieClip;
            _loc7_ = new HButton(_loc5_);
            _loc5_.addEventListener(MouseEvent.CLICK,this.btn_enterClick);
            _loc5_ = _loc3_.getChildByName("btn_detail") as MovieClip;
            _loc7_ = new HButton(_loc5_);
            _loc5_.addEventListener(MouseEvent.CLICK,this.btn_detailClick);
            _loc5_.addEventListener(MouseEvent.MOUSE_OVER,this.btn_detailMouseOver);
            _loc5_.addEventListener(MouseEvent.MOUSE_OUT,this.btn_detailMouseOut);
            this.McList.push(_loc3_);
            _loc3_.visible = false;
            _loc2_++;
         }
         this.PageIndex = 0;
      }
      
      public static function getInstance(param1:int = -1) : MyCorpsUI_Demesne
      {
         if(instance == null)
         {
            instance = new MyCorpsUI_Demesne(param1);
         }
         return instance;
      }
      
      private function Clear() : void
      {
         var _loc2_:MovieClip = null;
         var _loc1_:int = 0;
         while(_loc1_ < this._PageRows)
         {
            _loc2_ = this.McList[_loc1_];
            _loc2_.visible = false;
            _loc1_++;
         }
      }
      
      public function StopTimer() : void
      {
         this._Timer.stop();
      }
      
      public function GetList(param1:int = -1) : Array
      {
         if(param1 >= 0 && param1 < this.PageCount)
         {
            this.PageIndex = param1;
         }
         this.RequestDemesne();
         if(!this._Timer.running)
         {
            this._Timer.start();
         }
         return this.McList;
      }
      
      public function GetPageIndex() : int
      {
         return this.PageIndex;
      }
      
      public function GetPageCount() : int
      {
         return this.PageCount;
      }
      
      public function NextPage() : Array
      {
         if(this.PageIndex + 1 < this.PageCount)
         {
            ++this.PageIndex;
            this.ShowCurPage();
         }
         return this.McList;
      }
      
      public function PrePage() : Array
      {
         if(this.PageIndex > 0)
         {
            --this.PageIndex;
            this.ShowCurPage();
         }
         return this.McList;
      }
      
      public function GetHeadString() : String
      {
         return StringManager.getInstance().getMessageString("CorpsText8");
      }
      
      private function RequestDemesne() : void
      {
         var _loc1_:MSG_REQUEST_CONSORTIAFIELD = new MSG_REQUEST_CONSORTIAFIELD();
         _loc1_.SeqId = GamePlayer.getInstance().seqID++;
         _loc1_.Guid = GamePlayer.getInstance().Guid;
         NetManager.Instance().sendObject(_loc1_);
      }
      
      public function RespDemesneList(param1:MSG_RESP_CONSORTIAFIELD) : void
      {
         if(param1.DataLen > this._PageRows)
         {
            this.PageCount = 2;
         }
         else
         {
            this.PageCount = 1;
         }
         MyCorpsUI.getInstance().ShowPageButton();
         this.DemesneList = param1;
         this.ShowCurPage();
         this.ShowListInfo();
      }
      
      private function ShowCurPage() : void
      {
         var _loc3_:MovieClip = null;
         var _loc4_:MSG_RESP_CONSORTIAFIELD_TEMP = null;
         var _loc5_:TextField = null;
         var _loc6_:MovieClip = null;
         var _loc7_:TextField = null;
         var _loc8_:TextField = null;
         if(this.DemesneList == null)
         {
            return;
         }
         var _loc1_:int = this.PageIndex * this._PageRows;
         var _loc2_:int = 0;
         while(_loc2_ < this._PageRows)
         {
            _loc3_ = this.McList[_loc2_];
            if(_loc1_ < this.DemesneList.DataLen)
            {
               _loc4_ = this.DemesneList.Data[_loc1_];
               _loc5_ = _loc3_.getChildByName("tf_location") as TextField;
               _loc5_.text = int(_loc4_.GalaxyId / MsgTypes.MAP_RANGE) + "," + _loc4_.GalaxyId % MsgTypes.MAP_RANGE;
               _loc5_ = _loc3_.getChildByName("tf_lv") as TextField;
               _loc5_.text = (_loc4_.Level + 1).toString();
               _loc5_ = _loc3_.getChildByName("tf_state") as TextField;
               _loc5_.text = _loc4_.Status == 0 ? StringManager.getInstance().getMessageString("CorpsText9") : StringManager.getInstance().getMessageString("CorpsText10");
               _loc5_ = _loc3_.getChildByName("tf_time") as TextField;
               _loc5_.text = DataWidget.GetTimeString(_loc4_.NeedTime);
               _loc6_ = _loc3_.getChildByName("btn_army") as MovieClip;
               if(_loc4_.ShipNum == -1)
               {
                  XButton(this.btn_army_List[_loc2_]).setBtnDisabled(true);
                  _loc7_ = _loc6_.getChildByName("tf_num") as TextField;
                  _loc7_.text = "?/" + _loc4_.MaxShipNum;
               }
               else
               {
                  if(GamePlayer.getInstance().ConsortiaJob == 0 || _loc4_.ShipNum == _loc4_.MaxShipNum)
                  {
                     XButton(this.btn_army_List[_loc2_]).setBtnDisabled(true);
                     XButton(this.btn_army_List[_loc2_]).SetTip(StringManager.getInstance().getMessageString("CorpsText44"));
                     XButton(this.btn_army_List[_loc2_]).m_movie.mouseEnabled = true;
                  }
                  else if(_loc4_.Status == 1)
                  {
                     XButton(this.btn_army_List[_loc2_]).setBtnDisabled(true);
                     XButton(this.btn_army_List[_loc2_]).SetTip(StringManager.getInstance().getMessageString("CorpsText81"));
                     XButton(this.btn_army_List[_loc2_]).m_movie.mouseEnabled = true;
                  }
                  else
                  {
                     XButton(this.btn_army_List[_loc2_]).setBtnDisabled(false);
                     XButton(this.btn_army_List[_loc2_]).SetTip("");
                  }
                  _loc8_ = _loc6_.getChildByName("tf_num") as TextField;
                  _loc8_.text = _loc4_.ShipNum + "/" + _loc4_.MaxShipNum;
               }
               _loc3_.visible = true;
            }
            else
            {
               _loc3_.visible = false;
            }
            _loc1_++;
            _loc2_++;
         }
         if(this.SelectedRow != null)
         {
            this.SelectedRow.m_movie.gotoAndStop("up");
         }
      }
      
      private function UpdateTime(param1:Event) : void
      {
         var _loc3_:MSG_RESP_CONSORTIAFIELD_TEMP = null;
         var _loc4_:int = 0;
         var _loc5_:MovieClip = null;
         var _loc6_:TextField = null;
         if(this.DemesneList == null)
         {
            return;
         }
         var _loc2_:int = 0;
         while(_loc2_ < this.DemesneList.DataLen)
         {
            _loc3_ = this.DemesneList.Data[_loc2_];
            if(_loc3_.NeedTime > 0)
            {
               --_loc3_.NeedTime;
               _loc4_ = _loc2_ - this.PageIndex * this._PageRows;
               if(_loc4_ >= 0 && _loc4_ < this._PageRows)
               {
                  _loc5_ = this.McList[_loc4_];
                  _loc6_ = _loc5_.getChildByName("tf_time") as TextField;
                  _loc6_.text = DataWidget.GetTimeString(_loc3_.NeedTime);
               }
            }
            _loc2_++;
         }
      }
      
      private function btn_enterClick(param1:MouseEvent) : void
      {
         var _loc3_:MSG_RESP_CONSORTIAFIELD_TEMP = null;
         var _loc2_:int = this.GetSelectedItemId(param1);
         if(_loc2_ >= 0)
         {
            _loc3_ = this.DemesneList.Data[_loc2_];
            GameMouseZoneManager.NagivateToolBarByName("btn_universe",true);
            GotoGalaxyUI.instance.GotoGalaxy(_loc3_.GalaxyId / MsgTypes.MAP_RANGE,_loc3_.GalaxyId % MsgTypes.MAP_RANGE);
            MyCorpsUI.getInstance().Hide();
         }
      }
      
      private function GetSelectedItemId(param1:MouseEvent) : int
      {
         var _loc3_:int = 0;
         var _loc2_:DisplayObject = param1.target as DisplayObject;
         _loc2_ = _loc2_.parent;
         if(_loc2_.name.indexOf("Item") >= 0)
         {
            _loc3_ = int(_loc2_.name.substr(4));
            _loc3_ = this.PageIndex * this._PageRows + _loc3_;
            if(_loc3_ < this.DemesneList.DataLen)
            {
               return _loc3_;
            }
         }
         return -1;
      }
      
      private function btn_armyClick(param1:MouseEvent, param2:XButton) : void
      {
         if(XButton(this.btn_army_List[param2.Data]).m_statue == HButtonStatue.DISABLED)
         {
            return;
         }
         var _loc3_:int = param2.Data + this.PageIndex * this._PageRows;
         var _loc4_:MSG_RESP_CONSORTIAFIELD_TEMP = this.DemesneList.Data[_loc3_];
         MyCorpsUI_Garrison.getInstance().Show(GalaxyMapAction.instance.curStar.GalaxyMapId,_loc4_.GalaxyId,_loc4_.MaxShipNum - _loc4_.ShipNum);
      }
      
      private function btn_detailMouseOver(param1:MouseEvent) : void
      {
         var _loc3_:MSG_RESP_CONSORTIAFIELD_TEMP = null;
         var _loc4_:StarLevelEntry = null;
         var _loc5_:Number = NaN;
         var _loc6_:String = null;
         var _loc7_:MovieClip = null;
         var _loc8_:Point = null;
         var _loc2_:int = this.GetSelectedItemId(param1);
         if(_loc2_ >= 0)
         {
            _loc3_ = this.DemesneList.Data[_loc2_];
            _loc4_ = StarLevelReader.getInstance().Read(_loc3_.Level);
            if(_loc4_ != null)
            {
               _loc5_ = _loc4_.affect * 100;
               _loc5_ = Math.round(_loc5_);
               _loc6_ = CustomTip.GetInstance().GetNumberText(StringManager.getInstance().getMessageString("ShipText9") + "："," +" + _loc5_ + "%") + "\n\n" + CustomTip.GetInstance().GetNumberText(StringManager.getInstance().getMessageString("ShipText8") + "："," +" + _loc5_ + "%") + "\n\n" + CustomTip.GetInstance().GetNumberText(StringManager.getInstance().getMessageString("ShipText10") + "："," +" + _loc5_ + "%") + "\n\n" + CustomTip.GetInstance().GetNumberText(StringManager.getInstance().getMessageString("CorpsText62") + "："," +" + _loc5_ + "%") + "\n\n" + CustomTip.GetInstance().GetNumberText(StringManager.getInstance().getMessageString("CorpsText63") + "："," +" + _loc5_ + "%");
               _loc7_ = param1.target as MovieClip;
               _loc8_ = _loc7_.localToGlobal(new Point(-45,_loc7_.height / _loc7_.scaleY));
               CustomTip.GetInstance().Show(_loc6_,_loc8_);
            }
         }
      }
      
      private function ShowListInfo() : void
      {
         var _loc3_:MSG_RESP_CONSORTIAFIELD_TEMP = null;
         var _loc4_:StarLevelEntry = null;
         if(this.DemesneList == null)
         {
            return;
         }
         var _loc1_:Number = 0;
         var _loc2_:int = 0;
         while(_loc2_ < this.DemesneList.DataLen)
         {
            _loc3_ = this.DemesneList.Data[_loc2_];
            _loc4_ = StarLevelReader.getInstance().Read(_loc3_.Level);
            if(_loc4_ != null)
            {
               _loc1_ += _loc4_.affect * 100;
            }
            _loc2_++;
         }
         _loc1_ = Math.round(_loc1_);
         MyCorpsUI.getInstance().ShowListInfo(StringManager.getInstance().getMessageString("CorpsText124") + _loc1_ + "%");
      }
      
      private function btn_detailMouseOut(param1:MouseEvent) : void
      {
         CustomTip.GetInstance().Hide();
      }
      
      private function btn_detailClick(param1:MouseEvent) : void
      {
         CustomTip.GetInstance().Hide();
      }
      
      private function RowClick(param1:MouseEvent, param2:XMovieClip) : void
      {
         if(this.SelectedRow != null)
         {
            this.SelectedRow.m_movie.gotoAndStop("up");
         }
         this.SelectedRow = param2;
         this.SelectedRow.m_movie.gotoAndStop("selected");
      }
   }
}

