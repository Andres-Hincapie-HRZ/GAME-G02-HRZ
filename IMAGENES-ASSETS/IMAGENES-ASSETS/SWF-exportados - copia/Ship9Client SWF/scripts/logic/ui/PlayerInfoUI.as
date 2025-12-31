package logic.ui
{
   import com.star.frameworks.display.loader.ImageLoader;
   import com.star.frameworks.events.ActionEvent;
   import com.star.frameworks.facebook.FacebookUserInfo;
   import com.star.frameworks.managers.StringManager;
   import com.star.frameworks.utils.CGlobeFuncUtil;
   import com.star.frameworks.utils.MusicResHandler;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.external.ExternalInterface;
   import flash.text.TextField;
   import logic.action.FaceBookAction;
   import logic.entry.GamePlaceType;
   import logic.entry.GamePlayer;
   import logic.entry.HButton;
   import logic.entry.MObject;
   import logic.game.GameKernel;
   import logic.game.GameMouseZoneManager;
   import logic.game.GameStateManager;
   import logic.manager.GameInterActiveManager;
   import logic.reader.CPlayerLevelsReader;
   import logic.widget.ConstructionOperationWidget;
   import net.msg.facebook.MSG_RESP_FRIENDINFO;
   
   public class PlayerInfoUI
   {
      
      private static var instance:PlayerInfoUI;
      
      private var mc_base:MovieClip;
      
      private var _tfName:TextField;
      
      private var _tfLV:TextField;
      
      private var _tfPernum:TextField;
      
      private var _mcPlanbar:MovieClip;
      
      private var _infoMc:HButton;
      
      private var _mc:MObject;
      
      private var _prePlayImage:DisplayObject;
      
      private var _spObj:MovieClip;
      
      private var _spBase:MovieClip;
      
      private var _musicMenu:MovieClip;
      
      private var mOff:Boolean;
      
      private var btn_lottery:HButton;
      
      private var m_daytaskBtn:HButton;
      
      public var RewardMc:MovieClip;
      
      private var LastStageWidth:int;
      
      public function PlayerInfoUI()
      {
         super();
         this._prePlayImage = new MovieClip();
      }
      
      public static function getInstance() : PlayerInfoUI
      {
         if(instance == null)
         {
            instance = new PlayerInfoUI();
         }
         return instance;
      }
      
      public function Init(param1:MObject) : void
      {
         this._mc = param1;
         if(this._mc.stage)
         {
            this.LastStageWidth = int(int(this._mc.stage.stageWidth));
            this._mc.stage.addEventListener(Event.RESIZE,this.OnResize);
         }
         else
         {
            this._mc.addEventListener(Event.ADDED_TO_STAGE,this.OnAddToStage);
         }
         this.initMcElement();
      }
      
      private function initMcElement() : void
      {
         this.mc_base = this._mc.getMC().mc_base as MovieClip;
         this._tfName = this._mc.getMC().tf_name as TextField;
         this._tfLV = this._mc.getMC().tf_LV as TextField;
         this._tfPernum = this._mc.getMC().tf_pernum as TextField;
         this._mcPlanbar = this._mc.getMC().mc_planbar as MovieClip;
         this._infoMc = new HButton(this._mc.getMC().btn_news);
         this._spObj = this._mc.getMC().mc_spplanbar as MovieClip;
         this._spBase = this._mc.getMC().mc_spplanbar2 as MovieClip;
         this.m_daytaskBtn = new HButton(this._mc.getMC().btn_daytask);
         this._musicMenu = this._mc.getMC().btn_music;
         var _loc1_:HButton = new HButton(this._musicMenu);
         this._musicMenu.useHandCursor = true;
         this._musicMenu.addEventListener(MouseEvent.CLICK,this.onMusicControl);
         this.RewardMc = this._mc.getMC().getChildByName("mc_drawrewards") as MovieClip;
         GameInterActiveManager.InstallInterActiveEvent(this._infoMc.m_movie,ActionEvent.ACTION_CLICK,this.onPopConstructionInfoHandler);
         GameInterActiveManager.InstallInterActiveEvent(this._spBase,ActionEvent.ACTION_CLICK,this.onPopMallShop);
         GameInterActiveManager.InstallInterActiveEvent(this._spBase,ActionEvent.ACTION_MOUSE_OVER,GameMouseZoneManager.ShowTip);
         GameInterActiveManager.InstallInterActiveEvent(this._infoMc.m_movie,ActionEvent.ACTION_MOUSE_OVER,GameMouseZoneManager.ShowTip);
         GameInterActiveManager.InstallInterActiveEvent(this.m_daytaskBtn.m_movie,ActionEvent.ACTION_MOUSE_OVER,GameMouseZoneManager.ShowTip);
         GameInterActiveManager.InstallInterActiveEvent(this._spBase,ActionEvent.ACTION_MOUSE_OUT,GameMouseZoneManager.HideTip);
         GameInterActiveManager.InstallInterActiveEvent(this._infoMc.m_movie,ActionEvent.ACTION_MOUSE_OUT,GameMouseZoneManager.HideTip);
         GameInterActiveManager.InstallInterActiveEvent(this.m_daytaskBtn.m_movie,ActionEvent.ACTION_MOUSE_OUT,GameMouseZoneManager.HideTip);
         GameInterActiveManager.InstallInterActiveEvent(this.m_daytaskBtn.m_movie,ActionEvent.ACTION_CLICK,this.onPopDayTask);
      }
      
      private function OnAddToStage(param1:Event) : void
      {
         this._mc.removeEventListener(Event.ADDED_TO_STAGE,this.OnAddToStage);
         this.LastStageWidth = int(int(this._mc.stage.stageWidth));
         this._mc.stage.addEventListener(Event.RESIZE,this.OnResize);
      }
      
      private function onMusicControl(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(MusicResHandler.LoadFinish)
         {
            MusicControlUI.instance.Init();
         }
         else
         {
            _loc2_ = StringManager.getInstance().getMessageString("BattleTXT12");
            MessageBox.show(_loc2_,this.startLoading);
         }
      }
      
      private function startLoading() : void
      {
         MusicLoadingProgressUI.instance.Init();
      }
      
      public function changeFullScreenIcon() : void
      {
         if(GameKernel.isFullStage)
         {
            this._infoMc.m_movie.gotoAndStop(2);
         }
         else
         {
            this._infoMc.m_movie.gotoAndStop(1);
         }
      }
      
      private function onPopDayTask(param1:MouseEvent) : void
      {
         GameDateTaskUI.GetInstance().Init();
      }
      
      private function onPopConstructionInfoHandler(param1:MouseEvent) : void
      {
         ConstructionOperationWidget.getInstance().Hide();
         GameKernel.getInstance().setClientFullScreen(!this.mOff);
         this.mOff = !this.mOff;
      }
      
      private function onPopMallShop(param1:MouseEvent) : void
      {
         StateHandlingUI.getInstance().Init();
         StateHandlingUI.getInstance().setParent("_ResPlaneUI");
         StateHandlingUI.getInstance().getstate(927);
         StateHandlingUI.getInstance().InitPopUp();
         GameKernel.popUpDisplayManager.Show(StateHandlingUI.getInstance());
      }
      
      public function bindPlayerImage() : void
      {
         var _loc1_:ImageLoader = null;
         ExternalInterface.call("console.log","[#] GameKernel.youselfFaceBook => " + GameKernel.youselfFaceBook);
         _loc1_ = new ImageLoader();
         _loc1_.LoadImage("http://homepages.cae.wisc.edu/~ece533/images/frymire.png",this.mc_base,this.playerCallBack,GameKernel.ForRenRen == 1);
         ExternalInterface.call("console.log","[#] Passed ");
      }
      
      private function removePlayInfo() : void
      {
         if(this._prePlayImage && this._prePlayImage.parent)
         {
            this._prePlayImage.parent.removeChild(this._prePlayImage);
         }
      }
      
      public function bindFriendImage(param1:Number) : void
      {
         var _loc2_:Object = null;
         var _loc3_:FacebookUserInfo = null;
         var _loc4_:ImageLoader = null;
         var _loc5_:Bitmap = null;
         if(GameKernel.ForRenRen == 1)
         {
            this._prePlayImage = new MovieClip();
            this._prePlayImage.width = 50;
            this._prePlayImage.height = 50;
            _loc2_ = GameKernel.facebookFriendImage.Get(param1);
            if(_loc2_)
            {
               GameKernel.facebookFriendImage.Remove(param1);
            }
            else if(FleetInfoUI_Res.GetInstance().FacebookUserImg.ContainsKey(param1))
            {
               _loc2_ = FleetInfoUI_Res.GetInstance().FacebookUserImg.Get(param1);
               FleetInfoUI_Res.GetInstance().FacebookUserImg.Remove(param1);
            }
            else
            {
               _loc3_ = GameKernel.CheckFacebookUserInfo(param1);
               if(_loc3_)
               {
                  _loc4_ = new ImageLoader();
                  _loc4_.LoadImage(_loc3_.pic_square,this.mc_base,this.playerCallBack,GameKernel.ForRenRen == 1);
               }
            }
            if(_loc2_)
            {
               MovieClip(this._prePlayImage).addChild(_loc2_ as DisplayObject);
               this.mc_base.addChild(this._prePlayImage);
            }
         }
         else
         {
            _loc2_ = GameKernel.facebookFriendImage.Get(param1);
            if(_loc2_)
            {
               _loc2_ = CGlobeFuncUtil.copyTexture(_loc2_ as Bitmap,param1.toString());
            }
            else if(FleetInfoUI_Res.GetInstance().FacebookUserImg.ContainsKey(param1))
            {
               _loc5_ = FleetInfoUI_Res.GetInstance().FacebookUserImg.Get(param1);
               _loc2_ = new Bitmap(_loc5_.bitmapData.clone());
            }
            if(_loc2_)
            {
               this._prePlayImage = _loc2_ as Bitmap;
               this.mc_base.addChild(this._prePlayImage);
            }
         }
      }
      
      public function bindFriendInfo(param1:MSG_RESP_FRIENDINFO, param2:String) : void
      {
         this.removePlayInfo();
         this.bindFriendImage(param1.ObjUserId);
         var _loc3_:int = CPlayerLevelsReader.getInstance().Read(param1.LevelId).Exp;
         if(param2 != null)
         {
            this._tfName.text = param2;
         }
         else
         {
            this._tfName.text = param1.ObjGuid.toString();
         }
         this._tfLV.text = String(param1.LevelId + 1);
         if(_loc3_ == 0)
         {
            this._tfPernum.text = "100%";
            this._mcPlanbar.width = 85;
         }
         else if(param1.Exp >= _loc3_)
         {
            this._tfPernum.text = "100%";
            this._mcPlanbar.width = 85;
         }
         else
         {
            this._tfPernum.text = Math.floor(param1.Exp / _loc3_ * 100) + "%";
            this._mcPlanbar.width = 85 * (param1.Exp / _loc3_);
         }
         this._spObj.width = 111;
      }
      
      public function UpdateUserName() : void
      {
         if(GamePlayer.getInstance().Name == null)
         {
            if(FaceBookUI.getInstance().CurrentFaceBookFriend != null)
            {
               this._tfName.text = FaceBookUI.getInstance().CurrentFaceBookFriend.first_name;
            }
         }
         else
         {
            this._tfName.text = GamePlayer.getInstance().Name;
         }
      }
      
      public function bindGalaxyFriendInfo(param1:Number, param2:String) : void
      {
         FaceBookUI.getInstance().CurrentFaceBookFriend = GameKernel.CheckFacebookUserInfo(param1);
         FaceBookUI.getInstance().currentUserId = param1;
         FaceBookAction.getInstance().request_Msg_FaceBookInfo(param1,param2);
      }
      
      private function playerCallBack(param1:MovieClip, param2:DisplayObject) : void
      {
         this.removePlayInfo();
         if(GameKernel.ForRenRen == 1)
         {
            this._prePlayImage = new MovieClip();
            MovieClip(this._prePlayImage).addChild(param2);
            MovieClip(this._prePlayImage).width = 50;
            MovieClip(this._prePlayImage).height = 50;
            GameKernel.facebookFriendImage.Put(GameKernel.youselfFaceBook.uid,param2);
            param1.addChild(this._prePlayImage);
         }
         else
         {
            this._prePlayImage = param2 as Bitmap;
            if(!param2)
            {
               this._prePlayImage = new Bitmap();
            }
            this._prePlayImage.width = 50;
            this._prePlayImage.height = 50;
            GameKernel.facebookFriendImage.Put(GameKernel.youselfFaceBook.uid,this._prePlayImage);
            param1.addChild(this._prePlayImage);
         }
      }
      
      public function bindPlayerInfo() : void
      {
         this.bindPlayerImage();
         var _loc1_:int = GamePlayer.getInstance().exp;
         var _loc2_:int = CPlayerLevelsReader.getInstance().Read(GamePlayer.getInstance().level).Exp;
         this.UpdateUserName();
         this._tfLV.text = String(GamePlayer.getInstance().level + 1);
         if(_loc2_ == 0)
         {
            this._tfPernum.text = "100%";
            this._mcPlanbar.width = 85;
         }
         else
         {
            this._tfPernum.text = Math.floor(_loc1_ / _loc2_ * 100) + "%";
            this._mcPlanbar.width = 85 * (_loc1_ / _loc2_);
         }
         this._spObj.width = GamePlayer.getInstance().SpValue / GamePlayer.getInstance().MaxSpValue * 111;
      }
      
      public function updatePlayerSp() : void
      {
         if(GamePlayer.getInstance().SpValue <= 0)
         {
            return;
         }
         --GamePlayer.getInstance().SpValue;
         this.resetPlayerSp(GamePlayer.getInstance().SpValue);
      }
      
      public function resetPlayerSp(param1:int) : void
      {
         GamePlayer.getInstance().SpValue = param1;
         if(GameStateManager.playerPlace == GamePlaceType.PLACE_HOME)
         {
            this._spObj.width = GamePlayer.getInstance().SpValue / GamePlayer.getInstance().MaxSpValue * 111;
         }
      }
      
      public function removeSpEvent() : void
      {
         GameInterActiveManager.unInstallnterActiveEvent(this._spBase,ActionEvent.ACTION_CLICK,this.onPopMallShop);
      }
      
      public function addSpEvent() : void
      {
         GameInterActiveManager.InstallInterActiveEvent(this._spBase,ActionEvent.ACTION_CLICK,this.onPopMallShop);
      }
      
      private function OnResize(param1:Event) : void
      {
         this._mc.x -= (this._mc.stage.stageWidth - this.LastStageWidth) / 2;
         this.LastStageWidth = int(int(this._mc.stage.stageWidth));
      }
   }
}

