package logic.ui.tip
{
   import com.star.frameworks.facebook.FacebookUserInfo;
   import com.star.frameworks.managers.StringManager;
   import com.star.frameworks.utils.HashSet;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   import logic.action.GalaxyMapAction;
   import logic.entry.GStar;
   import logic.entry.GamePlayer;
   import logic.game.GameKernel;
   import logic.ui.FleetInfoUI_Res;
   import logic.ui.MailUI;
   import logic.ui.info.AbstractInfoDecorate;
   import net.base.NetManager;
   import net.common.MsgTypes;
   import net.msg.galaxyMap.MSG_REQUEST_GALAXYINFO;
   import net.msg.galaxyMap.MSG_RESP_GALAXYINFO;
   
   public class StarInfoTip
   {
      
      private static var instance:StarInfoTip;
      
      private var infoDecorate:AbstractInfoDecorate;
      
      private var TipTimer:Timer;
      
      private var EnterTimer:int;
      
      private var EnterMouseEvent:MouseEvent;
      
      private var CurStarInfo:GStar;
      
      private var StarInfoList:HashSet;
      
      private var CurUserId:Number;
      
      private var BitmapTemp:Bitmap;
      
      private var GalaxyMapId_Mail:int;
      
      private var GalaxyId_Mail:int;
      
      public function StarInfoTip()
      {
         super();
         this.BitmapTemp = new Bitmap();
         this.BitmapTemp.width = 50;
         this.BitmapTemp.height = 50;
         this.StarInfoList = new HashSet();
         this.TipTimer = new Timer(500);
         this.TipTimer.addEventListener(TimerEvent.TIMER,this.OnTipTimer);
         this.infoDecorate = new AbstractInfoDecorate();
         this.infoDecorate.Load("StarInfoTip");
         this.infoDecorate.ToolTip.SetMoveEvent();
      }
      
      public static function GetInstance() : StarInfoTip
      {
         if(instance == null)
         {
            instance = new StarInfoTip();
         }
         return instance;
      }
      
      public function Hide() : void
      {
         this.EnterTimer = 0;
         this.infoDecorate.Hide();
         CustomTip.GetInstance().Hide();
      }
      
      public function Show(param1:MouseEvent) : void
      {
         if(this.EnterTimer == 0)
         {
            this.Hide();
         }
         this.EnterMouseEvent = param1;
         this.EnterTimer = getTimer();
         if(!this.TipTimer.running)
         {
            this.TipTimer.start();
         }
      }
      
      private function OnTipTimer(param1:Event) : void
      {
         if(this.EnterTimer > 0 && getTimer() - this.EnterTimer > 1000)
         {
            this.CurStarInfo = GalaxyMapAction.instance.GetStarInfo(this.EnterMouseEvent);
            this.RequestStarInfo();
            this.EnterTimer = 0;
            this.TipTimer.stop();
         }
      }
      
      private function RequestStarInfo() : void
      {
         if(this.CurStarInfo == null)
         {
            return;
         }
         var _loc1_:String = this.CurStarInfo.GalaxyMapId + "-" + this.CurStarInfo.GalaxyId;
         if(this.StarInfoList.ContainsKey(_loc1_))
         {
            this.RespStarInfo(this.StarInfoList.Get(_loc1_));
            return;
         }
         this._RequestStarInfo(this.CurStarInfo.GalaxyMapId,this.CurStarInfo.GalaxyId);
      }
      
      public function RequestStarInfoForWriteMail(param1:int, param2:int) : void
      {
         var _loc4_:MSG_RESP_GALAXYINFO = null;
         var _loc3_:String = param1 + "-" + param2;
         if(this.StarInfoList.ContainsKey(_loc3_))
         {
            _loc4_ = this.StarInfoList.Get(_loc3_);
            this.ToWriteMail(_loc4_.ObjGuid);
            return;
         }
         this.GalaxyMapId_Mail = param1;
         this.GalaxyId_Mail = param2;
         this._RequestStarInfo(param1,param2);
      }
      
      private function ToWriteMail(param1:int) : void
      {
         MailUI.getInstance().WriteMail(param1);
      }
      
      private function _RequestStarInfo(param1:int, param2:int) : void
      {
         var _loc3_:MSG_REQUEST_GALAXYINFO = new MSG_REQUEST_GALAXYINFO();
         _loc3_.GalaxyMapId = param1;
         _loc3_.GalaxyId = param2;
         _loc3_.SeqId = GamePlayer.getInstance().seqID++;
         _loc3_.Guid = GamePlayer.getInstance().Guid;
         NetManager.Instance().sendObject(_loc3_);
      }
      
      public function RespStarInfo(param1:MSG_RESP_GALAXYINFO) : void
      {
         var _loc2_:DisplayObject = null;
         var _loc3_:Point = null;
         this.StarInfoList.Put(param1.GalaxyMapId + "-" + param1.GalaxyId,param1);
         if(this.GalaxyMapId_Mail == param1.GalaxyMapId && this.GalaxyId_Mail == param1.GalaxyId)
         {
            this.GalaxyMapId_Mail = -1;
            this.GalaxyId_Mail = -1;
            this.ToWriteMail(param1.ObjGuid);
            return;
         }
         if(!GameKernel.renderManager.getMap().getContainer().contains(GalaxyMapAction.instance.getUI()))
         {
            return;
         }
         if(this.CurStarInfo == null)
         {
            return;
         }
         if(param1.GalaxyId == this.CurStarInfo.GalaxyId && this.CurStarInfo.GalaxyMapId == this.CurStarInfo.GalaxyMapId)
         {
            _loc2_ = this.EnterMouseEvent.target as DisplayObject;
            _loc3_ = _loc2_.localToGlobal(new Point(this.EnterMouseEvent.localX,this.EnterMouseEvent.localY));
            if(param1.Type == 2)
            {
               this.ShowTransportStarInfo(param1,_loc3_);
            }
            else if(param1.Type == 3)
            {
               this.ShowResouceStarInfo(param1,_loc3_);
            }
            else
            {
               this.ShowUserStarInfo(param1,_loc3_);
            }
         }
      }
      
      private function ShowUserStarInfo(param1:MSG_RESP_GALAXYINFO, param2:Point) : void
      {
         this.infoDecorate.Update("UesrLevel","Lv：" + (param1.Level + 1));
         this.infoDecorate.Update("UserGuid","Id：" + param1.ObjGuid + "-" + param1.ObjUserId);
         this.infoDecorate.Update("Location",StringManager.getInstance().getMessageString("StarText0") + this.GetLocation(param1.GalaxyId));
         this.infoDecorate.Update("Corps",StringManager.getInstance().getMessageString("StarText1") + param1.Consortia);
         this.infoDecorate.Update("Status",StringManager.getInstance().getMessageString("StarText3") + (param1.Status == 0 ? StringManager.getInstance().getMessageString("StarText2") : StringManager.getInstance().getMessageString("CorpsText9")));
         this.infoDecorate.Update("UserName",param1.Name);
         this.infoDecorate.replaceTexture("UserImag",this.BitmapTemp);
         this.infoDecorate.putDecorate();
         this.infoDecorate.Show(param2.x,param2.y);
         this.CurUserId = param1.ObjUserId;
         GameKernel.getPlayerFacebookInfo(param1.ObjUserId,this.getPlayerFacebookInfoCallback,param1.Name);
      }
      
      private function ShowTransportStarInfo(param1:MSG_RESP_GALAXYINFO, param2:Point) : void
      {
         var _loc3_:String = StringManager.getInstance().getMessageString("MailText17") + StringManager.getInstance().getMessageString("Boss46") + "\n\n" + StringManager.getInstance().getMessageString("StarText0") + this.GetLocation(param1.GalaxyId);
         CustomTip.GetInstance().Show(_loc3_,param2);
      }
      
      private function ShowResouceStarInfo(param1:MSG_RESP_GALAXYINFO, param2:Point) : void
      {
         var _loc3_:String = StringManager.getInstance().getMessageString("MailText17") + StringManager.getInstance().getMessageString("StarText5") + "\n\n" + StringManager.getInstance().getMessageString("StarText0") + this.GetLocation(param1.GalaxyId) + "\n\n" + StringManager.getInstance().getMessageString("StarText1") + param1.Consortia;
         CustomTip.GetInstance().Show(_loc3_,param2);
      }
      
      private function GetLocation(param1:int) : String
      {
         var _loc2_:int = param1 / MsgTypes.MAP_RANGE;
         var _loc3_:int = param1 % MsgTypes.MAP_RANGE;
         return "(" + _loc2_ + "," + _loc3_ + ")";
      }
      
      private function getPlayerFacebookInfoCallback(param1:FacebookUserInfo) : void
      {
         if(param1 != null && this.CurUserId == param1.uid)
         {
            this.infoDecorate.Update("UserName",param1.first_name);
            FleetInfoUI_Res.GetInstance().GetFacebookUserImg(this.CurUserId,param1.pic_square,this.GetFacebookUserImgCallback);
         }
      }
      
      private function GetFacebookUserImgCallback(param1:Number, param2:DisplayObject) : void
      {
         var _loc3_:Bitmap = null;
         if(this.CurUserId == param1 && param2 != null)
         {
            param2.width = 50;
            param2.height = 50;
            this.infoDecorate.replaceTexture("UserImag",param2);
         }
         else
         {
            _loc3_ = new Bitmap(null);
            this.infoDecorate.replaceTexture("UserImag",_loc3_);
         }
      }
   }
}

