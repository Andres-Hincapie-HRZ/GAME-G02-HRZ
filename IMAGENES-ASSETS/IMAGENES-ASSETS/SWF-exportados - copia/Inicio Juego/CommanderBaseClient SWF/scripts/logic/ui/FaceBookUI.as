package logic.ui
{
   import com.star.frameworks.display.loader.ImageLoader;
   import com.star.frameworks.events.ActionEvent;
   import com.star.frameworks.facebook.FacebookUserInfo;
   import com.star.frameworks.managers.StringManager;
   import com.star.frameworks.utils.CEffectText;
   import com.star.frameworks.utils.CGlobeFuncUtil;
   import com.star.frameworks.utils.HashSet;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.external.ExternalInterface;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import logic.action.ConstructionAction;
   import logic.action.FaceBookAction;
   import logic.action.StarSurfaceAction;
   import logic.entry.GamePlaceType;
   import logic.entry.HButton;
   import logic.entry.MObject;
   import logic.game.GameKernel;
   import logic.game.GameMouseZoneManager;
   import logic.game.GameSetting;
   import logic.game.GameStateManager;
   import logic.manager.GameInterActiveManager;
   import logic.manager.InstanceManager;
   import logic.widget.ConstructionOperationWidget;
   
   public class FaceBookUI
   {
      
      private static var instance:FaceBookUI;
      
      private var mLeft:HButton;
      
      private var mRight:HButton;
      
      private var mcName:String;
      
      private var mCurrentIndex:int;
      
      public var isFirstLoad:Boolean;
      
      private var mMaxIndex:int;
      
      private var isReset:Boolean;
      
      private var _display:MObject;
      
      private var currentFriendList:Array;
      
      private var currentFaceBook:FacebookUserInfo;
      
      public var currentUserId:Number;
      
      private var mInviteBtn:HButton;
      
      private var _display_Width:int;
      
      private var LeftBitmap:Bitmap;
      
      private var RightBitmap:Bitmap;
      
      private var LastStageWidth:int;
      
      public function FaceBookUI()
      {
         super();
         this.mMaxIndex = 0;
         this.isFirstLoad = false;
         this.mCurrentIndex = 0;
      }
      
      public static function getInstance() : FaceBookUI
      {
         if(instance == null)
         {
            instance = new FaceBookUI();
         }
         return instance;
      }
      
      public function InitFaceBookUI(param1:MObject) : void
      {
         if(this._display)
         {
            return;
         }
         this.setDisplay(param1);
         this.initMcElement();
      }
      
      public function Hide() : void
      {
         this._display.visible = false;
      }
      
      public function setDisplay(param1:MObject) : void
      {
         this._display = param1;
         this._display_Width = this._display.width;
         this.LeftBitmap = new Bitmap();
         this._display.addChild(this.LeftBitmap);
         this.RightBitmap = new Bitmap();
         this._display.addChild(this.RightBitmap);
         if(this._display.stage)
         {
            this.LastStageWidth = this._display.stage.stageWidth;
            this._display.stage.addEventListener(Event.RESIZE,this.OnResize);
            this.OnResize(null);
         }
         else
         {
            this._display.addEventListener(Event.ADDED_TO_STAGE,this.OnAddToStage);
         }
      }
      
      public function OnResize(param1:Event) : void
      {
         if(this.LeftBitmap == null)
         {
            return;
         }
         var _loc2_:int = (this._display.stage.stageWidth - this._display_Width) / 2;
         if(_loc2_ > 0)
         {
            this.LeftBitmap.bitmapData = new BitmapData(_loc2_,this._display.height);
            this.LeftBitmap.bitmapData.draw(this._display,null,null,null,new Rectangle(0,0,2,this._display.height));
            this.LeftBitmap.x = -_loc2_;
            this.LeftBitmap.y = 0;
            this.RightBitmap.bitmapData = new BitmapData(_loc2_,this._display.height);
            this.RightBitmap.bitmapData.draw(this._display,null,null,null,new Rectangle(0,0,2,this._display.height));
            this.RightBitmap.x = this._display_Width;
            this.RightBitmap.y = 0;
         }
         else
         {
            this.LeftBitmap.bitmapData = null;
            this.RightBitmap.bitmapData = null;
         }
      }
      
      private function OnAddToStage(param1:Event) : void
      {
         this._display.removeEventListener(Event.ADDED_TO_STAGE,this.OnAddToStage);
         this.LastStageWidth = this._display.stage.stageWidth;
         this._display.stage.addEventListener(Event.RESIZE,this.OnResize);
         this.OnResize(null);
      }
      
      public function getDisplay() : MObject
      {
         return this._display;
      }
      
      public function get CurrentFaceBookFriend() : FacebookUserInfo
      {
         return this.currentFaceBook;
      }
      
      public function set CurrentFaceBookFriend(param1:FacebookUserInfo) : void
      {
         this.currentFaceBook = param1;
         if(this.currentFaceBook != null)
         {
            this.currentUserId = this.currentFaceBook.uid;
         }
      }
      
      private function initMcElement() : void
      {
         this.mLeft = new HButton(this._display.getMC().mc_left);
         this.mRight = new HButton(this._display.getMC().mc_right);
         this.mInviteBtn = new HButton(this._display.getMC().mc_invite);
         GameInterActiveManager.InstallInterActiveEvent(this.mLeft.m_movie,ActionEvent.ACTION_CLICK,this.onGoToPage);
         GameInterActiveManager.InstallInterActiveEvent(this.mRight.m_movie,ActionEvent.ACTION_CLICK,this.onGoToPage);
         GameInterActiveManager.InstallInterActiveEvent(this.mInviteBtn.m_movie,ActionEvent.ACTION_CLICK,this.onInviteHandler);
      }
      
      public function loadFacebookImage(param1:int = 0, param2:Function = null) : void
      {
         if(!this.currentFriendList)
         {
            this.currentFriendList = GameKernel.facebookFriendList;
         }
         this.goForwardAndBack();
      }
      
      public function setBtnState() : void
      {
         if(this.mCurrentIndex == 0)
         {
            this.mLeft.setBtnDisabled(true);
         }
         else
         {
            this.mLeft.setBtnDisabled(false);
         }
         if(this.mCurrentIndex == this.mMaxIndex - 1)
         {
            this.mRight.setBtnDisabled(true);
         }
         else
         {
            this.mRight.setBtnDisabled(false);
         }
      }
      
      public function setMaxIndex() : void
      {
         if(!this.currentFriendList)
         {
            this.currentFriendList = GameKernel.facebookFriendList;
         }
         var _loc1_:int = int(this.currentFriendList.length);
         var _loc2_:int = _loc1_ / GameSetting.GAME_FRIEND_MAX_NUMBER;
         if(_loc2_)
         {
            if(0 == _loc1_ % GameSetting.GAME_FRIEND_MAX_NUMBER)
            {
               this.mMaxIndex = _loc2_;
            }
            else
            {
               this.mMaxIndex = _loc2_ + 1;
            }
         }
         else
         {
            this.mMaxIndex = 1;
         }
      }
      
      public function callBackImage(param1:Number, param2:Object) : void
      {
         var _loc3_:Bitmap = null;
         if(GameKernel.ForRenRen == 1)
         {
            GameKernel.facebookFriendImage.Put(param1,param2);
         }
         else
         {
            if(param2)
            {
               _loc3_ = param2 as Bitmap;
               _loc3_.smoothing = true;
               _loc3_.width = 50;
               _loc3_.height = 50;
            }
            else
            {
               _loc3_ = new Bitmap();
               _loc3_.smoothing = true;
               _loc3_.width = 50;
               _loc3_.height = 50;
            }
            GameKernel.facebookFriendImage.Put(param1,_loc3_);
         }
         this.bindFacebookUser(param1);
      }
      
      private function onGoToPage(param1:MouseEvent) : void
      {
         switch(param1.target.name)
         {
            case "mc_right":
               this.isReset = true;
               ++this.mCurrentIndex;
               this.goForwardAndBack();
               break;
            case "mc_left":
               if(0 == this.mCurrentIndex)
               {
                  this.isReset = false;
               }
               --this.mCurrentIndex;
               this.goForwardAndBack();
         }
      }
      
      private function onInviteHandler(param1:MouseEvent) : void
      {
         ExternalInterface.call("inviteFriends");
      }
      
      public function reBindFacebookFriendLevel() : void
      {
         this.mCurrentIndex = 0;
         this.goForwardAndBack();
      }
      
      private function goForwardAndBack() : void
      {
         var _loc3_:ImageLoader = null;
         var _loc1_:int = 0;
         this.removeFacebookTexture();
         this.removeFacebookListText();
         if(!this.currentFriendList)
         {
            this.currentFriendList = GameKernel.facebookFriendList;
         }
         var _loc2_:int = this.mCurrentIndex * GameSetting.GAME_FRIEND_MAX_NUMBER;
         while(_loc2_ < (this.mCurrentIndex + 1) * GameSetting.GAME_FRIEND_MAX_NUMBER)
         {
            if(_loc2_ >= this.currentFriendList.length)
            {
               break;
            }
            _loc1_++;
            if(GameKernel.facebookFriendImage.ContainsKey(this.currentFriendList[_loc2_].uid) && GameKernel.ForRenRen != 1)
            {
               this.bindFacebookUser(this.currentFriendList[_loc2_].uid);
            }
            else
            {
               _loc3_ = new ImageLoader();
               _loc3_.LoadImage(FacebookUserInfo(this.currentFriendList[_loc2_]).pic_square,this.currentFriendList[_loc2_].uid,this.callBackImage,GameKernel.ForRenRen == 1);
            }
            _loc2_++;
         }
         this.setBtnState();
         if(_loc1_ < GameSetting.GAME_FRIEND_MAX_NUMBER)
         {
            this.Adjust(_loc1_);
         }
      }
      
      public function Adjust(param1:int) : void
      {
         var _loc2_:int = param1;
         while(_loc2_ < GameSetting.GAME_FRIEND_MAX_NUMBER)
         {
            this.mcName = "mc_friend" + _loc2_;
            this.getDisplay().getMC()[this.mcName].gotoAndStop(3);
            _loc2_++;
         }
      }
      
      public function removeFacebookTexture(param1:int = 0) : void
      {
         var _loc2_:DisplayObject = null;
         var _loc6_:int = 0;
         var _loc3_:HashSet = GameKernel.facebookFriendImage;
         var _loc4_:MovieClip = this.getDisplay().getMC();
         var _loc5_:int = 0;
         while(_loc5_ < GameSetting.GAME_FRIEND_MAX_NUMBER)
         {
            this.mcName = "mc_friend" + _loc5_;
            if(_loc4_[this.mcName].tf_uid.text)
            {
               if(GameKernel.ForRenRen != 1)
               {
                  _loc2_ = GameKernel.facebookFriendImage.Get(_loc4_[this.mcName].tf_uid.text);
                  if(_loc2_)
                  {
                     if(Boolean(_loc4_[this.mcName].mc_emptyfriend) && Boolean(MovieClip(_loc4_[this.mcName].mc_emptyfriend).getChildByName(_loc2_.name)))
                     {
                        _loc4_[this.mcName].mc_emptyfriend.removeChild(_loc2_);
                        _loc2_ = null;
                     }
                     if(MovieClip(_loc4_[this.mcName].mc_emptyfriend).numChildren > 1)
                     {
                        _loc6_ = 0;
                        while(_loc6_ < MovieClip(_loc4_[this.mcName].mc_emptyfriend).numChildren - 1)
                        {
                           MovieClip(_loc4_[this.mcName].mc_emptyfriend).removeChildAt(MovieClip(_loc4_[this.mcName].mc_emptyfriend).numChildren - 1);
                           _loc6_++;
                        }
                     }
                  }
               }
               else if(MovieClip(_loc4_[this.mcName].mc_emptyfriend).numChildren > 1)
               {
                  _loc6_ = 0;
                  while(_loc6_ < MovieClip(_loc4_[this.mcName].mc_emptyfriend).numChildren - 1)
                  {
                     MovieClip(_loc4_[this.mcName].mc_emptyfriend).removeChildAt(MovieClip(_loc4_[this.mcName].mc_emptyfriend).numChildren - 1);
                     _loc6_++;
                  }
               }
            }
            _loc5_++;
         }
      }
      
      public function removeFacebookListText() : void
      {
         var _loc1_:MovieClip = this.getDisplay().getMC();
         var _loc2_:int = 0;
         while(_loc2_ < GameSetting.GAME_FRIEND_MAX_NUMBER)
         {
            this.mcName = "mc_friend" + _loc2_;
            if(MovieClip(_loc1_[this.mcName]).currentFrame == 3)
            {
               MovieClip(_loc1_[this.mcName]).gotoAndStop(1);
            }
            TextField(_loc1_[this.mcName].tf_name).text = "";
            TextField(_loc1_[this.mcName].tf_level).text = "";
            TextField(_loc1_[this.mcName].tf_uid).text = "";
            _loc2_++;
         }
      }
      
      public function bindFacebookUser(param1:Number) : void
      {
         var _loc2_:int = 0;
         var _loc3_:FacebookUserInfo = null;
         var _loc4_:FacebookUserInfo = null;
         if(!this.currentFriendList)
         {
            this.currentFriendList = GameKernel.facebookFriendList;
         }
         for each(_loc4_ in this.currentFriendList)
         {
            if(_loc4_.uid == param1)
            {
               _loc3_ = _loc4_;
               break;
            }
            _loc2_++;
         }
         if(_loc2_ < this.mCurrentIndex * GameSetting.GAME_FRIEND_MAX_NUMBER || _loc2_ >= (this.mCurrentIndex + 1) * GameSetting.GAME_FRIEND_MAX_NUMBER)
         {
            return;
         }
         _loc2_ %= GameSetting.GAME_FRIEND_MAX_NUMBER;
         var _loc5_:String = "mc_friend" + _loc2_;
         GameInterActiveManager.InstallInterActiveEvent(this.getDisplay().getMC()[_loc5_],ActionEvent.ACTION_CLICK,this.onGotoFriend);
         TextField(this.getDisplay().getMC()[_loc5_].tf_name).text = _loc3_.first_name == null ? "" : _loc3_.first_name;
         TextField(this.getDisplay().getMC()[_loc5_].tf_uid).text = _loc3_.uid.toString();
         TextField(this.getDisplay().getMC()[_loc5_].tf_level).text = CGlobeFuncUtil.makeString(_loc3_.level);
         if(GameKernel.facebookFriendImage.Get(_loc3_.uid))
         {
            this.getDisplay().getMC()[_loc5_].mc_emptyfriend.addChild(GameKernel.facebookFriendImage.Get(_loc3_.uid));
            if(GameKernel.ForRenRen == 1)
            {
               GameKernel.facebookFriendImage.Remove(_loc3_.uid);
            }
         }
      }
      
      public function bindFacebookUserAfterSort() : void
      {
         this.mCurrentIndex = 0;
         this.goForwardAndBack();
      }
      
      public function bindFacebookUserByIndex(param1:int) : void
      {
         if(param1 < this.mCurrentIndex * GameSetting.GAME_FRIEND_MAX_NUMBER || param1 >= (this.mCurrentIndex + 1) * GameSetting.GAME_FRIEND_MAX_NUMBER)
         {
            return;
         }
         if(!this.currentFriendList)
         {
            this.currentFriendList = GameKernel.facebookFriendList;
         }
         var _loc2_:FacebookUserInfo = this.currentFriendList[param1];
         param1 %= GameSetting.GAME_FRIEND_MAX_NUMBER;
         var _loc3_:String = "mc_friend" + param1;
         GameInterActiveManager.InstallInterActiveEvent(this.getDisplay().getMC()[_loc3_],ActionEvent.ACTION_CLICK,this.onGotoFriend);
         TextField(this.getDisplay().getMC()[_loc3_].tf_name).text = _loc2_.first_name;
         TextField(this.getDisplay().getMC()[_loc3_].tf_uid).text = _loc2_.uid.toString();
         TextField(this.getDisplay().getMC()[_loc3_].tf_level).text = CGlobeFuncUtil.makeString(_loc2_.level);
         if(GameKernel.facebookFriendImage.Get(_loc2_.uid))
         {
            this.getDisplay().getMC()[_loc3_].mc_emptyfriend.addChild(GameKernel.facebookFriendImage.Get(_loc2_.uid));
            if(GameKernel.ForRenRen == 1)
            {
               GameKernel.facebookFriendImage.Remove(_loc2_.uid);
            }
         }
      }
      
      private function setSelectState(param1:MouseEvent = null) : void
      {
         if(param1 == null)
         {
            return;
         }
         MovieClip(param1.currentTarget).gotoAndStop(2);
         var _loc2_:String = String(param1.currentTarget.name);
         var _loc3_:MovieClip = this.getDisplay().getMC();
         var _loc4_:int = 0;
         while(_loc4_ < GameSetting.GAME_FRIEND_MAX_NUMBER)
         {
            this.mcName = "mc_friend" + _loc4_;
            if(this.mcName != _loc2_)
            {
               MovieClip(_loc3_[this.mcName]).gotoAndStop(1);
            }
            _loc4_++;
         }
      }
      
      private function onGotoFriend(param1:MouseEvent) : void
      {
         if(!StarSurfaceAction.getInstance().loadingMapFinished)
         {
            CEffectText.getInstance().showEffectText(GameKernel.renderManager.getUI().getContainer(),StringManager.getInstance().getMessageString("Server37"));
            return;
         }
         ConstructionAction.getInstance().clearConstructionModule();
         ConstructionOperationWidget.getInstance().Hide();
         if(!this.currentFriendList)
         {
            this.currentFriendList = GameKernel.facebookFriendList;
         }
         var _loc2_:String = String(param1.currentTarget.name).replace("mc_friend","");
         var _loc3_:int = parseInt(_loc2_) + this.mCurrentIndex * GameSetting.GAME_FRIEND_MAX_NUMBER;
         this.currentFaceBook = this.currentFriendList[_loc3_];
         if(this.currentFaceBook == null)
         {
            return;
         }
         this.setSelectState(param1);
         InstanceManager.instance.quitToFaceBookFriend();
         if(GameStateManager.preFriendGuid == this.currentFaceBook.uid)
         {
            GameKernel.renderManager.showLoadingMc(false);
            GameMouseZoneManager.gotoStarSurfaceMap();
            return;
         }
         if(this.currentFaceBook.level == 0)
         {
            GameStateManager.preFriendGuid = this.currentFaceBook.uid;
            GameKernel.renderManager.showLoadingMc(false);
            return;
         }
         GameStateManager.playerPlace = GamePlaceType.PLACE_FRIENDHOME;
         FaceBookAction.getInstance().request_Msg_FaceBookInfo(this.currentFaceBook.uid,this.currentFaceBook.first_name);
         GameStateManager.preFriendGuid = this.currentFaceBook.uid;
      }
   }
}

