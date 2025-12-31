package logic.ui
{
   import com.star.frameworks.managers.StringManager;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import logic.entry.GamePlayer;
   import logic.entry.HButton;
   import logic.entry.HButtonType;
   import logic.entry.MObject;
   import logic.entry.ScienceSystem;
   import logic.game.GameKernel;
   import logic.reader.CPropsReader;
   import logic.ui.tip.CustomTip;
   import net.base.NetManager;
   import net.msg.MSG_REQUEST_CHANGESERVER;
   import net.msg.MSG_REQUEST_DELETESERVER;
   import net.msg.MSG_REQUEST_GAMESERVERLIST;
   import net.msg.MSG_RESP_CHANGESERVER;
   import net.msg.MSG_RESP_DELETESERVER;
   import net.msg.MSG_RESP_GAMESERVERLIST;
   
   public class ChangeServerUI extends AbstractPopUp
   {
      
      private static var instance:ChangeServerUI;
      
      private var ROW_COUNT:int = 20;
      
      private var ServerListMsg:MSG_RESP_GAMESERVERLIST;
      
      private var ServerPopMc:MovieClip;
      
      private var ChangerserverruleMc:MovieClip;
      
      private var NormalCorlor:int;
      
      private var ListArry:Array = new Array();
      
      private var SelectedId:int;
      
      public function ChangeServerUI()
      {
         super();
         setPopUpName("ChangeServerUI");
      }
      
      public static function getInstance() : ChangeServerUI
      {
         if(instance == null)
         {
            instance = new ChangeServerUI();
         }
         return instance;
      }
      
      override public function Init() : void
      {
         if(GameKernel.popUpDisplayManager.PopDisplayList.ContainsKey(getPopUpName()))
         {
            this.Clear();
            this.RequestServerList();
            return;
         }
         if(GameKernel.platform == 2)
         {
            this._mc = new MObject("ChangeServerScene",410,400);
         }
         else
         {
            this._mc = new MObject("ChangeServerScene",380,400);
         }
         this.initMcElement();
         this.Clear();
         this.RequestServerList();
         GameKernel.popUpDisplayManager.Regisger(instance);
      }
      
      override public function initMcElement() : void
      {
         var _loc1_:HButton = null;
         var _loc2_:MovieClip = null;
         var _loc5_:DisplayObject = null;
         var _loc6_:XMovieClip = null;
         _loc2_ = this._mc.getMC().getChildByName("btn_close") as MovieClip;
         _loc1_ = new HButton(_loc2_,HButtonType.SIMPLE,false,StringManager.getInstance().getMessageString("Server23"));
         _loc2_.addEventListener(MouseEvent.CLICK,this.CloseClick);
         _loc2_ = this._mc.getMC().getChildByName("btn_help") as MovieClip;
         _loc1_ = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_helpClick);
         _loc2_ = this._mc.getMC().getChildByName("btn_buy") as MovieClip;
         _loc1_ = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_buyClick);
         if(CPropsReader.getInstance().GetPropsInfo(929).Cash == 0)
         {
            _loc1_.setBtnDisabled(true);
         }
         this.ROW_COUNT = 0;
         var _loc3_:int = 0;
         while(_loc3_ < 60)
         {
            _loc5_ = this._mc.getMC().getChildByName("mc_list" + _loc3_);
            if(_loc5_ == null)
            {
               break;
            }
            ++this.ROW_COUNT;
            _loc2_ = _loc5_ as MovieClip;
            _loc6_ = new XMovieClip(_loc2_);
            _loc6_.Data = _loc3_;
            _loc6_.OnClick = this.ListClick;
            _loc6_.OnMouseOver = this.ListOver;
            _loc2_.addEventListener(MouseEvent.MOUSE_OUT,this.ListOut);
            _loc2_.buttonMode = true;
            _loc2_.mouseChildren = false;
            _loc2_.gotoAndStop(2);
            this.ListArry.push(_loc6_);
            _loc3_++;
         }
         this.ServerPopMc = GameKernel.getMovieClipInstance("ServerPopMc");
         this._mc.getMC().addChild(this.ServerPopMc);
         this.ServerPopMc.visible = false;
         this.ChangerserverruleMc = GameKernel.getMovieClipInstance("ChangerserverruleMc");
         this._mc.getMC().addChild(this.ChangerserverruleMc);
         this.ChangerserverruleMc.x = -260;
         this.ChangerserverruleMc.y = -250;
         _loc2_ = this.ChangerserverruleMc.btn_ensure as MovieClip;
         _loc1_ = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_ensureClick);
         _loc2_ = this.ChangerserverruleMc.btn_cancel as MovieClip;
         _loc1_ = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_cancelClick);
         this.ChangerserverruleMc.visible = false;
         var _loc4_:TextField = this.ChangerserverruleMc.getChildByName("tf_content0") as TextField;
         this.NormalCorlor = _loc4_.textColor;
      }
      
      private function btn_helpClick(param1:MouseEvent) : void
      {
         this.ChangerserverruleMc.visible = true;
      }
      
      private function DeleteServer() : void
      {
         var _loc1_:MSG_REQUEST_DELETESERVER = new MSG_REQUEST_DELETESERVER();
         _loc1_.UserId = GamePlayer.getInstance().userID;
         _loc1_.SeqId = GamePlayer.getInstance().seqID++;
         _loc1_.Guid = GamePlayer.getInstance().Guid;
         NetManager.Instance().sendObject(_loc1_);
      }
      
      public function Resp_MSG_RESP_DELETESERVER(param1:MSG_RESP_DELETESERVER) : void
      {
         if(param1.ErrorCode == 0)
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("Server39"),1);
            GameKernel.RefreshWeb();
         }
         else if(param1.ErrorCode == 17)
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("Server40"),1);
         }
         else
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("Server" + int(param1.ErrorCode - 1)),1);
         }
         this.ShowChangeServerRule(param1.ErrorCode);
      }
      
      private function ShowChangeServerRule(param1:int) : void
      {
         var _loc3_:TextField = null;
         this.ChangerserverruleMc.visible = true;
         var _loc2_:int = 0;
         while(_loc2_ < 10)
         {
            _loc3_ = this.ChangerserverruleMc.getChildByName("tf_content" + _loc2_) as TextField;
            _loc3_.textColor = this.NormalCorlor;
            switch(_loc2_)
            {
               case 0:
                  if(param1 == 17)
                  {
                     _loc3_.textColor = 16711680;
                  }
                  break;
               case 1:
                  if(param1 == 4)
                  {
                     _loc3_.textColor = 16711680;
                  }
                  break;
               case 2:
                  if(param1 == 5)
                  {
                     _loc3_.textColor = 16711680;
                  }
                  break;
               case 3:
                  if(param1 == 6)
                  {
                     _loc3_.textColor = 16711680;
                  }
                  break;
               case 4:
                  if(param1 == 13)
                  {
                     _loc3_.textColor = 16711680;
                  }
                  break;
               case 5:
                  if(param1 == 2 || param1 == 7)
                  {
                     _loc3_.textColor = 16711680;
                  }
                  break;
               case 6:
                  if(param1 == 3)
                  {
                     _loc3_.textColor = 16711680;
                  }
                  break;
               case 7:
                  if(param1 == 1)
                  {
                     _loc3_.textColor = 16711680;
                  }
            }
            _loc2_++;
         }
      }
      
      private function btn_helpOver(param1:MouseEvent) : void
      {
         CustomTip.GetInstance().Show(StringManager.getInstance().getMessageString("Server21"),this._mc.getMC().btn_help.localToGlobal(new Point(0,35)),false,250);
      }
      
      private function btn_helpOut(param1:MouseEvent) : void
      {
      }
      
      private function btn_buyClick(param1:MouseEvent) : void
      {
         this.SelectedId = -1;
         this.BuyProps();
      }
      
      private function BuyProps() : void
      {
         StateHandlingUI.getInstance().Init();
         StateHandlingUI.getInstance().setParent("CreateCorpsUI");
         StateHandlingUI.getInstance().getstate(929);
         StateHandlingUI.getInstance().InitPopUp();
         GameKernel.popUpDisplayManager.Show(StateHandlingUI.getInstance());
         PropsBuyUI.getInstance().ShowCreateCorpsUI = 3;
      }
      
      public function Show() : void
      {
         this.Init();
         GameKernel.popUpDisplayManager.Show(this);
      }
      
      private function Clear() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         var _loc3_:TextField = null;
         this.ChangerserverruleMc.visible = false;
         _loc1_ = 0;
         while(_loc1_ < this.ROW_COUNT)
         {
            _loc2_ = this._mc.getMC().getChildByName("mc_list" + _loc1_) as MovieClip;
            _loc2_.gotoAndStop(2);
            XMovieClip(this.ListArry[_loc1_]).Data = -1;
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < 10)
         {
            _loc3_ = this.ChangerserverruleMc.getChildByName("tf_content" + _loc1_) as TextField;
            _loc3_.textColor = this.NormalCorlor;
            _loc1_++;
         }
      }
      
      private function RequestServerList() : void
      {
         var _loc1_:MSG_REQUEST_GAMESERVERLIST = new MSG_REQUEST_GAMESERVERLIST();
         _loc1_.SeqId = GamePlayer.getInstance().seqID++;
         _loc1_.Guid = GamePlayer.getInstance().Guid;
         NetManager.Instance().sendObject(_loc1_);
      }
      
      public function RespServerList(param1:MSG_RESP_GAMESERVERLIST) : void
      {
         this.ServerListMsg = param1;
         this.ShowServerList();
      }
      
      private function ShowServerList() : void
      {
         var _loc1_:MovieClip = null;
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < this.ROW_COUNT)
         {
            _loc1_ = this._mc.getMC().getChildByName("mc_list" + _loc2_) as MovieClip;
            _loc1_.gotoAndStop(2);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < this.ServerListMsg.DataLen)
         {
            _loc1_ = this._mc.getMC().getChildByName("mc_list" + this.ServerListMsg.Data[_loc2_]) as MovieClip;
            if(!(_loc1_ == null || this.ListArry[this.ServerListMsg.Data[_loc2_]] == null))
            {
               XMovieClip(this.ListArry[this.ServerListMsg.Data[_loc2_]]).Data = _loc2_;
               if(this.ServerListMsg.Data[_loc2_] == GamePlayer.getInstance().GameServerId)
               {
                  _loc1_.gotoAndStop(3);
               }
               else
               {
                  _loc1_.gotoAndStop(1);
               }
            }
            _loc2_++;
         }
      }
      
      private function CloseClick(param1:MouseEvent) : void
      {
         GameKernel.popUpDisplayManager.Hide(this);
      }
      
      private function ListClick(param1:MouseEvent, param2:XMovieClip) : void
      {
         if(param2.Data < 0 || param2.Data >= this.ServerListMsg.DataLen)
         {
            return;
         }
         if(this.ServerListMsg.Data[param2.Data] == GamePlayer.getInstance().GameServerId)
         {
            return;
         }
         this.SelectedId = param2.Data;
      }
      
      public function DoChangeServer() : void
      {
         if(this.SelectedId < 0)
         {
            return;
         }
         var _loc1_:int = 0;
         while(_loc1_ < ScienceSystem.getinstance().Packarr.length)
         {
            if(ScienceSystem.getinstance().Packarr[_loc1_].PropsId == 929)
            {
               MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("Server15"),2,this.ChangeSever);
               return;
            }
            _loc1_++;
         }
         MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("Server22"),1);
      }
      
      private function ChangeSever() : void
      {
         var _loc2_:MSG_REQUEST_CHANGESERVER = null;
         var _loc1_:int = this.SelectedId;
         if(_loc1_ < this.ServerListMsg.DataLen)
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("Server16"),-1);
            _loc2_ = new MSG_REQUEST_CHANGESERVER();
            _loc2_.GameServerId = this.ServerListMsg.Data[_loc1_];
            _loc2_.SeqId = GamePlayer.getInstance().seqID++;
            _loc2_.Guid = GamePlayer.getInstance().Guid;
            NetManager.Instance().sendObject(_loc2_);
         }
         this.SelectedId = -1;
      }
      
      public function RespChangeServer(param1:MSG_RESP_CHANGESERVER) : void
      {
         MessagePopup.getInstance().Hide();
         if(param1.ErrorCode == 0)
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("Server17"),1,this.ReloadGame);
         }
         else if(param1.ErrorCode == 16)
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("Server34"),1);
         }
         else
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("Server" + int(param1.ErrorCode - 1)),1);
         }
         this.CloseClick(null);
      }
      
      private function ReloadGame() : void
      {
         GameKernel.RefreshWeb();
      }
      
      private function ListOver(param1:MouseEvent, param2:XMovieClip) : void
      {
         if(param2.Data < 0 || param2.Data >= this.ServerListMsg.DataLen)
         {
            return;
         }
         this.ShowServerInfo(param2);
      }
      
      private function ListOut(param1:MouseEvent) : void
      {
         this.ServerPopMc.visible = false;
      }
      
      private function ShowServerInfo(param1:XMovieClip) : void
      {
         var _loc2_:int = param1.Data;
         TextField(this.ServerPopMc.tf_name).text = StringManager.getInstance().getMessageString("ServerName" + int(this.ServerListMsg.Data[_loc2_] + 1));
         if(this.ServerListMsg.RegisterNum[_loc2_] < 30000)
         {
            TextField(this.ServerPopMc.tf_state).htmlText = "<font color=\'#00FFDF\'>" + StringManager.getInstance().getMessageString("Server18") + "</font>";
            MovieClip(this.ServerPopMc.mc_plan).gotoAndStop(1);
         }
         else if(this.ServerListMsg.RegisterNum[_loc2_] < 80000)
         {
            TextField(this.ServerPopMc.tf_state).htmlText = "<font color=\'#FFFF00\'>" + StringManager.getInstance().getMessageString("Server19") + "</font>";
            MovieClip(this.ServerPopMc.mc_plan).gotoAndStop(2);
         }
         else
         {
            TextField(this.ServerPopMc.tf_state).htmlText = "<font color=\'#FF0000\'>" + StringManager.getInstance().getMessageString("Server20") + "</font>";
            MovieClip(this.ServerPopMc.mc_plan).gotoAndStop(3);
         }
         this.ServerPopMc.x = param1.m_movie.x;
         this.ServerPopMc.y = param1.m_movie.y - this.ServerPopMc.height - 5;
         var _loc3_:Point = this._mc.getMC().localToGlobal(new Point(this.ServerPopMc.x + this.ServerPopMc.width,0));
         if(_loc3_.x > GameKernel.getStageWidth())
         {
            this.ServerPopMc.x -= this.ServerPopMc.width;
         }
         this.ServerPopMc.visible = true;
      }
      
      private function btn_ensureClick(param1:MouseEvent) : void
      {
         MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("Server38"),2,this.DeleteServer);
         this.ChangerserverruleMc.visible = false;
      }
      
      private function btn_cancelClick(param1:MouseEvent) : void
      {
         this.ChangerserverruleMc.visible = false;
      }
   }
}

