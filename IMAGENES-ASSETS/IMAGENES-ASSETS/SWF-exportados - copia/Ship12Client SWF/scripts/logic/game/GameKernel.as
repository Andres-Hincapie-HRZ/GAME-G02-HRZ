package logic.game
{
   import com.star.frameworks.display.Container;
   import com.star.frameworks.facebook.FacebookClient;
   import com.star.frameworks.facebook.FacebookUserInfo;
   import com.star.frameworks.managers.CUIManager;
   import com.star.frameworks.managers.RenderManager;
   import com.star.frameworks.managers.ResManager;
   import com.star.frameworks.managers.StringManager;
   import com.star.frameworks.utils.CEffectText;
   import com.star.frameworks.utils.HashSet;
   import com.star.frameworks.utils.ResourceHandler;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.InteractiveObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.display.StageDisplayState;
   import flash.display.StageQuality;
   import flash.events.Event;
   import flash.events.FullScreenEvent;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.external.ExternalInterface;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.utils.ByteArray;
   import flash.utils.Timer;
   import flash.utils.getDefinitionByName;
   import flash.utils.getTimer;
   import logic.action.GalaxyMapAction;
   import logic.action.OutSideGalaxiasAction;
   import logic.entry.ConstructionHelperEntry;
   import logic.entry.GamePlayer;
   import logic.entry.GameStageEnum;
   import logic.entry.GameUserInfo;
   import logic.entry.MObject;
   import logic.entry.PlayerInfo;
   import logic.manager.GameLayOutManager;
   import logic.manager.GameLoadingManager;
   import logic.manager.GamePopUpDisplayManager;
   import logic.ui.ChatChannelPopUp;
   import logic.ui.ChatCustomChannelPopUp;
   import logic.ui.ChatToolBar;
   import logic.ui.ChatUI;
   import logic.ui.FaceBookUI;
   import logic.ui.GameLoadingUI;
   import logic.ui.GemcheckPopUI;
   import logic.ui.InstanceMenuUI;
   import logic.ui.LoginUI;
   import logic.ui.MainUI;
   import logic.ui.PlayerInfoUI;
   import logic.widget.TaskNotifyWidget;
   import net.base.NetManager;
   import net.common.MsgTypes;
   import net.msg.MSG_REQUEST_FRIENDLEVEL;
   import net.msg.MSG_RESP_FRIENDLEVEL;
   
   public class GameKernel extends Container
   {
      
      public static var facebookFriendList:Array;
      
      public static var facebookFriendImage:HashSet;
      
      public static var facebookUnPlayFriendList:Array;
      
      public static var facebookPreLoadSet:HashSet;
      
      public static var youselfFaceBook:FacebookUserInfo;
      
      public static var success:Boolean;
      
      public static var flashVar:Object;
      
      public static var PlayerFacebookInfo:HashSet;
      
      private static var PlayerFacebookInfoCallback:Function;
      
      private static var PlayerFacebookInfoArrayCallback:Function;
      
      private static var GetUserInfoByUserIdsCallList:Array;
      
      private static var GetUserInfoByUserIdCallList:Array;
      
      public static var currentGameUserInfo:GameUserInfo;
      
      public static var resHandler:ResourceHandler;
      
      public static var keyBuffer:int;
      
      public static var renderManager:RenderManager;
      
      public static var resManager:ResManager;
      
      public static var uiManager:CUIManager;
      
      public static var gameLayout:GameLayOutManager;
      
      public static var popUpDisplayManager:GamePopUpDisplayManager;
      
      private static var instance:GameKernel;
      
      public static var sceneX:int;
      
      public static var sceneY:int;
      
      public static var DEFAULT_WIDTH:int;
      
      public static var DEFAULT_HEIGHT:int;
      
      public static var platform:int;
      
      public static var platform2:int;
      
      public static var ForFB:int;
      
      public static var ForRenRen:int;
      
      public static var PayUrl:String;
      
      public static var PublishUrl:String;
      
      public static var FuncList:Array;
      
      public static var ObjList:Array;
      
      private static var MainTimer:Timer;
      
      private static var LastTime:Number;
      
      private static var getPlayerFacebookInfo_time:int;
      
      private static var LastUserId:Number;
      
      private static var getPlayerFacebookInfoArray_time:int;
      
      public static var currentPlayerInfo:PlayerInfo = new PlayerInfo();
      
      public static var constructionHelperEntry:ConstructionHelperEntry = new ConstructionHelperEntry();
      
      public static var currentGameStage:int = GameStageEnum.GAME_STAGE_STARSURFACE;
      
      public static var currentMapModelIndex:int = 0;
      
      public static var isBuildModule:Boolean = false;
      
      public static var fullRect:Rectangle = new Rectangle();
      
      public static var isFullStage:Boolean = false;
      
      public static var ForJS:int = 0;
      
      private static var TextureCache:HashSet = new HashSet();
      
      private static var _DefaultNameList:HashSet = new HashSet();
      
      private static var UserIdList:Array = new Array();
      
      public var gameOffsetX:int;
      
      public var gameOffsetY:int;
      
      public var count:int;
      
      public var isInit:Boolean;
      
      public var isLogin:Boolean;
      
      public var isMain:Boolean;
      
      public var isGameServer:Boolean;
      
      public var globalPath:Object;
      
      private var isQuality:Boolean;
      
      public var isCommanderInit:Boolean;
      
      public var ConnectLoginServerNum:int = -1;
      
      public var ConnectErrorCode:int = 0;
      
      public function GameKernel()
      {
         this.name = "GameKernel";
         super("GameKernel");
         this.mouseChildren = false;
         this.addEventListener(Event.ADDED_TO_STAGE,this.Init);
         MainTimer = new Timer(34);
         MainTimer.addEventListener(TimerEvent.TIMER,OnTimer);
         MainTimer.start();
         FuncList = new Array();
         ObjList = new Array();
         LastTime = getTimer();
      }
      
      public static function getInstance() : GameKernel
      {
         if(instance == null)
         {
            instance = new GameKernel();
         }
         return instance;
      }
      
      public static function OnTimer(param1:Event) : void
      {
         var _loc2_:Number = getTimer();
         var _loc3_:int = (_loc2_ - LastTime) / 34;
         if(_loc3_ <= 0)
         {
            _loc3_ = 1;
         }
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            DoTiemr();
            _loc4_++;
         }
         LastTime = _loc2_;
      }
      
      public static function DoTiemr() : void
      {
         var _loc1_:Function = null;
         var _loc2_:int = 0;
         while(_loc2_ < FuncList.length)
         {
            _loc1_ = FuncList[_loc2_];
            if(_loc1_ != null)
            {
               _loc1_(ObjList[_loc2_]);
            }
            _loc2_++;
         }
      }
      
      public static function AddTimerEvent(param1:Function, param2:Object = null) : void
      {
         if(param2 != null)
         {
            if(ObjList.indexOf(param2) < 0)
            {
               FuncList.push(param1);
               ObjList.push(param2);
            }
         }
         else if(FuncList.indexOf(param1) < 0)
         {
            FuncList.push(param1);
            ObjList.push(param2);
         }
      }
      
      public static function RemoveTimerEvent(param1:Function, param2:Object = null) : void
      {
         var _loc3_:int = 0;
         if(param2 != null)
         {
            _loc3_ = int(ObjList.indexOf(param2));
            if(_loc3_ >= 0)
            {
               FuncList[_loc3_] = null;
               FuncList.splice(_loc3_,1);
               ObjList.splice(_loc3_,1);
            }
         }
         else
         {
            _loc3_ = int(FuncList.indexOf(param1));
            if(_loc3_ >= 0)
            {
               FuncList.splice(_loc3_,1);
               ObjList.splice(_loc3_,1);
            }
         }
      }
      
      public static function getFlashParameter(param1:String) : String
      {
         return flashVar[param1];
      }
      
      public static function getFitFullScreenSourceRect(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number) : Rectangle
      {
         param3 = param3 - param5 >> 1;
         param4 = param4 - param6 >> 1;
         return new Rectangle(param3,param4,param5,param6);
      }
      
      public static function getMovieClipInstance(param1:String, param2:int = 0, param3:int = 0, param4:Boolean = false) : MovieClip
      {
         var mClass:* = undefined;
         var mMovie:MovieClip = null;
         var args:String = param1;
         var x:int = param2;
         var y:int = param3;
         var cacheAs:Boolean = param4;
         if(args == "" || args == null)
         {
            return null;
         }
         try
         {
            mClass = Class(getDefinitionByName(args));
         }
         catch(e:*)
         {
            return null;
         }
         if(mClass)
         {
            mMovie = new mClass();
            mMovie.name = args;
            mMovie.x = x;
            mMovie.y = y;
            mMovie.cacheAsBitmap = cacheAs;
            return mMovie;
         }
         return null;
      }
      
      public static function getTextureInstance(param1:String) : BitmapData
      {
         var _loc2_:BitmapData = TextureCache.Get(param1);
         if(_loc2_)
         {
            return _loc2_;
         }
         var _loc3_:* = Class(getDefinitionByName(param1));
         if(_loc3_)
         {
            _loc2_ = new _loc3_(0,0);
            TextureCache.Put(param1,_loc2_);
            return _loc2_;
         }
         return null;
      }
      
      public static function getTextureRect(param1:String, param2:Rectangle, param3:Point) : BitmapData
      {
         var _loc5_:DisplayObject = null;
         var _loc6_:BitmapData = null;
         var _loc7_:BitmapData = null;
         var _loc4_:* = Class(getDefinitionByName(param1));
         if(_loc4_)
         {
            _loc5_ = new _loc4_() as DisplayObject;
            _loc5_.cacheAsBitmap = true;
            _loc6_ = getBitmapData(_loc5_);
            _loc7_ = new BitmapData(param2.width,param2.height);
            _loc7_.copyPixels(_loc6_ as BitmapData,param2,param3);
            return _loc7_;
         }
         throw new Error("不存在指定影集[" + param1 + "]");
      }
      
      private static function getBitmapData(param1:DisplayObject) : BitmapData
      {
         var _loc2_:DisplayObjectContainer = new Sprite();
         var _loc3_:BitmapData = new BitmapData(param1.width,param1.height,true,16777215);
         var _loc4_:Object = param1.getBounds(param1);
         var _loc5_:Matrix = param1.transform.matrix.clone();
         var _loc6_:Point = _loc2_.globalToLocal(param1.localToGlobal(new Point(_loc4_.x,_loc4_.y)));
         var _loc7_:Point = _loc2_.globalToLocal(param1.localToGlobal(new Point(_loc4_.x,_loc4_.y + _loc4_.height)));
         var _loc8_:Point = _loc2_.globalToLocal(param1.localToGlobal(new Point(_loc4_.x + _loc4_.width,_loc4_.y)));
         var _loc9_:Point = _loc2_.globalToLocal(param1.localToGlobal(new Point(_loc4_.x + _loc4_.width,_loc4_.y + _loc4_.height)));
         var _loc10_:Point = _loc6_;
         _loc10_.x > _loc7_.x && (_loc10_.x = _loc7_.x);
         _loc10_.x > _loc8_.x && (_loc10_.x = _loc8_.x);
         _loc10_.x > _loc9_.x && (_loc10_.x = _loc9_.x);
         _loc10_.y > _loc7_.y && (_loc10_.y = _loc7_.y);
         _loc10_.y > _loc8_.y && (_loc10_.y = _loc8_.y);
         _loc10_.y > _loc9_.y && (_loc10_.y = _loc9_.y);
         _loc5_.tx = param1.x - _loc10_.x;
         _loc5_.ty = param1.y - _loc10_.y;
         _loc3_.draw(param1,_loc5_);
         _loc2_ = null;
         return _loc3_;
      }
      
      public static function navigateURL(param1:String = "", param2:String = "_blank") : void
      {
         if(param1 == "")
         {
            if(GamePlayer.getInstance().IsGlobal == "1")
            {
               ExternalInterface.call("buyPoint");
            }
            else if(GameKernel.PayUrl != null && GameKernel.PayUrl != "")
            {
               navigateToURL(new URLRequest(GameKernel.PayUrl),param2);
            }
            else
            {
               navigateToURL(new URLRequest(GamePlayer.getInstance().gameUrl + "/Money.php"),param2);
            }
         }
         else
         {
            navigateToURL(new URLRequest(param1),param2);
         }
      }
      
      public static function RefreshWeb() : void
      {
         if(GamePlayer.getInstance().IsGlobal == "1")
         {
            ExternalInterface.call("refreshGame");
         }
         else
         {
            navigateToURL(new URLRequest(GamePlayer.getInstance().gameUrl),"_top");
         }
      }
      
      public static function isFullScreen() : Boolean
      {
         return instance.stage.displayState == StageDisplayState.FULL_SCREEN;
      }
      
      public static function setFocus(param1:InteractiveObject) : void
      {
         instance.stage.focus = param1;
      }
      
      public static function showFPS() : void
      {
      }
      
      public static function getStageX() : Number
      {
         if(instance.stage.displayState == StageDisplayState.FULL_SCREEN)
         {
            return instance.stage.fullScreenSourceRect.x - instance.gameOffsetX;
         }
         return 0;
      }
      
      public static function getStageY() : Number
      {
         if(instance.stage.displayState == StageDisplayState.FULL_SCREEN)
         {
            return instance.stage.fullScreenSourceRect.y - instance.gameOffsetY;
         }
         return 0;
      }
      
      public static function getScreen() : DisplayObject
      {
         return instance.stage.getChildAt(0);
      }
      
      public static function getStageRight() : Number
      {
         if(instance.stage.displayState == StageDisplayState.FULL_SCREEN)
         {
            return instance.stage.fullScreenSourceRect.right - instance.gameOffsetX;
         }
         return GameSetting.GAME_STAGE_WIDTH;
      }
      
      public static function getStageBottom() : Number
      {
         if(instance.stage.displayState == StageDisplayState.FULL_SCREEN)
         {
            return instance.stage.fullScreenSourceRect.bottom - instance.gameOffsetY;
         }
         return GameSetting.GAME_STAGE_HEIGHT;
      }
      
      public static function getStageWidth() : int
      {
         if(instance.stage.displayState == StageDisplayState.FULL_SCREEN)
         {
            return instance.stage.fullScreenWidth;
         }
         return GameSetting.GAME_STAGE_WIDTH;
      }
      
      public static function getStageHeight() : int
      {
         if(instance.stage.displayState == StageDisplayState.FULL_SCREEN)
         {
            return instance.stage.fullScreenHeight;
         }
         return GameSetting.GAME_STAGE_HEIGHT;
      }
      
      private static function AddDefaultName(param1:Number, param2:String) : void
      {
         if(param2 != null && param2 != null)
         {
            _DefaultNameList.Put(param1,param2);
         }
      }
      
      private static function AddDefaultNameArray(param1:Array, param2:Array) : void
      {
         if(param2 == null)
         {
            return;
         }
         var _loc3_:int = 0;
         while(_loc3_ < param1.length)
         {
            if(param2[_loc3_] != null && param2[_loc3_] != null)
            {
               _DefaultNameList.Put(param1[_loc3_],param2[_loc3_]);
            }
            _loc3_++;
         }
      }
      
      private static function SetDefaultName(param1:FacebookUserInfo) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc2_:String = _DefaultNameList.Get(param1.uid);
         if(_loc2_ != null && _loc2_ != "")
         {
            param1.DefaultName = _loc2_;
         }
         if(param1.pic_square == null || param1.pic_square == "" || param1.pic_square.indexOf("/rsrc.php/") > 0)
         {
            param1.pic_square = "https://graph.facebook.com/100000556404329/picture?type=square";
         }
      }
      
      public static function getPlayerFacebookInfo(param1:Number, param2:Function, param3:String) : void
      {
         var _loc4_:FacebookUserInfo = null;
         var _loc5_:Object = null;
         AddDefaultName(param1,param3);
         if(GameKernel.flashVar["SessionKey"] != undefined)
         {
            _loc4_ = CheckFacebookUserInfo(param1);
            if(_loc4_ != null)
            {
               SetDefaultName(_loc4_);
               param2(_loc4_);
               return;
            }
            _loc5_ = {
               "Data":param1,
               "Callback":param2
            };
            GetUserInfoByUserIdCallList.push(_loc5_);
            getPlayerFacebookInfoWork();
         }
         else
         {
            _loc4_ = new FacebookUserInfo();
            _loc4_.uid = param1;
            _loc4_.first_name = param3 + "";
            _loc4_.pic_square = "http://51.222.141.200:8080/images/frymire.png";
            SetDefaultName(_loc4_);
            param2(_loc4_);
         }
      }
      
      public static function CheckFacebookUserInfo(param1:Number) : FacebookUserInfo
      {
         var _loc2_:FacebookUserInfo = null;
         for each(_loc2_ in GameKernel.facebookFriendList)
         {
            if(_loc2_.uid == param1)
            {
               return _loc2_;
            }
         }
         if(PlayerFacebookInfo.ContainsKey(param1))
         {
            return PlayerFacebookInfo.Get(param1);
         }
         return null;
      }
      
      private static function getPlayerFacebookInfoWork() : void
      {
         var _loc1_:Object = null;
         if((getTimer() - getPlayerFacebookInfo_time > 5000 || PlayerFacebookInfoCallback == null) && GetUserInfoByUserIdCallList.length > 0)
         {
            getPlayerFacebookInfo_time = getTimer();
            _loc1_ = GetUserInfoByUserIdCallList[0];
            GetUserInfoByUserIdCallList.splice(0,1);
            PlayerFacebookInfoCallback = _loc1_.Callback;
            LastUserId = Number(_loc1_.Data);
            FacebookClient.GetUserInfoByUserId(getPlayerFacebookInfoCallback,_loc1_.Data);
         }
      }
      
      private static function getPlayerFacebookInfoCallback(param1:FacebookUserInfo) : void
      {
         getPlayerFacebookInfo_time = getTimer();
         if(param1 != null)
         {
            SetDefaultName(param1);
            PlayerFacebookInfo.Put(param1.uid,param1);
            CheckCurPlayerInfo(param1);
         }
         else
         {
            param1 = new FacebookUserInfo();
            param1.uid = LastUserId;
            param1.first_name = LastUserId + "";
         }
         if(PlayerFacebookInfoCallback != null)
         {
            PlayerFacebookInfoCallback(param1);
            PlayerFacebookInfoCallback = null;
         }
         getPlayerFacebookInfoWork();
      }
      
      private static function CheckCurPlayerInfo(param1:FacebookUserInfo) : void
      {
         if(param1.uid == FaceBookUI.getInstance().currentUserId)
         {
            FaceBookUI.getInstance().CurrentFaceBookFriend = param1;
            PlayerInfoUI.getInstance().UpdateUserName();
         }
      }
      
      private static function CheckList(param1:Array, param2:Function) : void
      {
         var _loc5_:* = undefined;
         var _loc3_:Array = new Array();
         var _loc4_:int = 0;
         while(_loc4_ < param1.length)
         {
            if(PlayerFacebookInfo.ContainsKey(param1[_loc4_]))
            {
               _loc5_ = PlayerFacebookInfo.Get(param1[_loc4_]);
               SetDefaultName(_loc5_);
               _loc3_.push(_loc5_);
               param1.splice(_loc4_,1);
            }
            else
            {
               _loc4_++;
            }
         }
         if(_loc3_.length > 0)
         {
            param2(_loc3_);
         }
      }
      
      public static function getPlayerFacebookInfoArray(param1:Array, param2:Function, param3:Array = null) : void
      {
         var _loc4_:Array = null;
         var _loc5_:int = 0;
         var _loc6_:Object = null;
         var _loc7_:Array = null;
         var _loc8_:int = 0;
         var _loc9_:Number = NaN;
         var _loc10_:FacebookUserInfo = null;
         AddDefaultNameArray(param1,param3);
         if(GameKernel.flashVar["SessionKey"] != undefined)
         {
            _loc4_ = new Array();
            _loc5_ = 0;
            while(_loc5_ < param1.length)
            {
               if(param1[_loc5_] > 0 && _loc4_.indexOf(param1[_loc5_]) < 0)
               {
                  _loc4_.push(param1[_loc5_]);
               }
               _loc5_++;
            }
            CheckList(_loc4_,param2);
            if(_loc4_.length == 0)
            {
               return;
            }
            _loc6_ = {
               "Data":_loc4_,
               "Callback":param2
            };
            GetUserInfoByUserIdsCallList.push(_loc6_);
            getPlayerFacebookInfoArrayWork();
         }
         else if(param3 != null)
         {
            _loc7_ = new Array();
            _loc8_ = 0;
            for each(_loc9_ in param1)
            {
               _loc10_ = new FacebookUserInfo();
               _loc10_.uid = _loc9_;
               _loc10_.first_name = param3[_loc8_];
               _loc10_.pic_square = "http://51.222.141.200:8080/images/frymire.png";
               SetDefaultName(_loc10_);
               _loc7_.push(_loc10_);
               _loc8_++;
            }
            param2(_loc7_);
         }
      }
      
      private static function getPlayerFacebookInfoArrayWork() : void
      {
         var _loc1_:Object = null;
         var _loc2_:Array = null;
         if((getTimer() - getPlayerFacebookInfoArray_time > 10000 || PlayerFacebookInfoArrayCallback == null) && GetUserInfoByUserIdsCallList.length > 0)
         {
            getPlayerFacebookInfoArray_time = getTimer();
            _loc1_ = GetUserInfoByUserIdsCallList[0];
            GetUserInfoByUserIdsCallList.splice(0,1);
            _loc2_ = _loc1_.Data;
            CheckList(_loc2_,_loc1_.Callback);
            if(_loc2_.length == 0)
            {
               getPlayerFacebookInfoArrayWork();
               return;
            }
            PlayerFacebookInfoArrayCallback = _loc1_.Callback;
            FacebookClient.GetUserInfoByUserIds(getPlayerFacebookInfoArrayCallback,_loc2_);
         }
      }
      
      private static function getPlayerFacebookInfoArrayCallback(param1:Array) : void
      {
         var _loc2_:FacebookUserInfo = null;
         getPlayerFacebookInfoArray_time = getTimer();
         if(param1 != null)
         {
            for each(_loc2_ in param1)
            {
               SetDefaultName(_loc2_);
               PlayerFacebookInfo.Put(_loc2_.uid,_loc2_);
               CheckCurPlayerInfo(_loc2_);
            }
         }
         if(PlayerFacebookInfoArrayCallback != null)
         {
            PlayerFacebookInfoArrayCallback(param1);
            PlayerFacebookInfoArrayCallback = null;
         }
         getPlayerFacebookInfoArrayWork();
      }
      
      private function Init(param1:Event) : void
      {
         var offset:Point;
         var list:HashSet;
         var e:Event = param1;
         facebookFriendList = new Array();
         facebookFriendImage = new HashSet();
         facebookUnPlayFriendList = new Array();
         facebookPreLoadSet = new HashSet();
         PlayerFacebookInfo = new HashSet();
         GetUserInfoByUserIdsCallList = new Array();
         GetUserInfoByUserIdCallList = new Array();
         var sessionKey:String = GameKernel.flashVar["SessionKey"];
         var apiKey:String = GameKernel.flashVar["ApiKey"];
         var SessionSecret:String = GameKernel.flashVar["SessionSecret"];
         var userId:String = GameKernel.flashVar["UserId"];
         var friendString:String = GameKernel.flashVar["friendString"];
         GameKernel.ForJS = int(GameKernel.flashVar["ForJS"]);
         GameKernel.platform2 = int(parseInt(GameKernel.flashVar["platform"]));
         GameKernel.ForFB = int(GameKernel.flashVar["ForFB"]);
         GameKernel.ForRenRen = int(GameKernel.flashVar["ForRenRen"]);
         GameKernel.PayUrl = GameKernel.flashVar["PayUrl"];
         GameKernel.PublishUrl = GameKernel.flashVar["PublishUrl"];
         FacebookClient.Init(apiKey,SessionSecret,sessionKey,userId,friendString);
         renderManager = RenderManager.getInstance();
         resManager = ResManager.getInstance();
         uiManager = CUIManager.getInstance();
         gameLayout = GameLayOutManager.getInstance();
         popUpDisplayManager = GamePopUpDisplayManager.getInstance();
         sceneX = (stage.stageWidth >> 1) - GameSetting.MAP_GRID_WIDTH;
         sceneY = (stage.stageHeight >> 1) + GameSetting.MAP_GRID_HEIGHT;
         stage.stageFocusRect = false;
         offset = localToGlobal(new Point(0,0));
         this.gameOffsetX = offset.x;
         this.gameOffsetY = offset.y;
         list = new HashSet();
         fullRect.x = 0;
         fullRect.y = 0;
         fullRect.width = stage.stageWidth;
         fullRect.height = stage.stageHeight;
         DEFAULT_WIDTH = stage.stageWidth;
         DEFAULT_HEIGHT = stage.stageHeight;
         list.Put("galaxy_asset",CDN.CDN_PATH + CDN.res + CDN.galayPath + GameSetting.GAME_FILE_PRIX);
         GameLoadingManager.getInstance().Load(list,function():void
         {
            if(GameLoadingUI.getInstance().IsVisible)
            {
               GameLoadingManager.getInstance().HideLoadingUI();
               GameMouseZoneManager.goForwardGalaxyMap();
            }
         });
         if(GamePlayer.getInstance().sessionKey != null)
         {
            NetManager.Instance().OnLogin(GamePlayer.getInstance().userID,GamePlayer.getInstance().sessionKey);
         }
         else
         {
            LoginUI.getInstance().Init();
         }
         if(NetManager.Instance().GetLoginServerIp() == null)
         {
            if(GameKernel.flashVar["server"] == "2")
            {
               NetManager.Instance().loginServerPort = "5999";
               NetManager.Instance().loginServerHost = "192.168.21.2";
            }
            else
            {
               NetManager.Instance().loginServerPort = "5999";
               NetManager.Instance().loginServerHost = "192.168.21.24";
            }
            GameSetting.DEBUG_NATIVE = true;
         }
         if(GameKernel.flashVar["server"] == "3")
         {
            GameSetting.DEBUG_NATIVE = true;
         }
         removeEventListener(Event.ADDED_TO_STAGE,this.Init);
      }
      
      public function initStageKeyBoard() : void
      {
         stage.addEventListener(KeyboardEvent.KEY_DOWN,this.keyDown);
         stage.addEventListener(KeyboardEvent.KEY_UP,this.keyUp);
         stage.addEventListener(FullScreenEvent.FULL_SCREEN,this.onFullScreenHandler);
         renderManager.getMap().setEnable(true);
         renderManager.getMap().addActionEvent(MouseEvent.MOUSE_DOWN,this.onClick);
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         ChatUI.getInstance().setSpecialTipState(false);
         GameKernel.renderManager.getUI().removeComponent(GemcheckPopUI.getInstance()._mc);
         ChatToolBar.getInstance().HideToolBar();
         ChatChannelPopUp.getInstance().Hide();
         ChatCustomChannelPopUp.getInstance().setVisible(false);
      }
      
      public function releaseStageKeyBoard() : void
      {
         if(stage.hasEventListener(KeyboardEvent.KEY_DOWN))
         {
            stage.removeEventListener(KeyboardEvent.KEY_DOWN,this.keyDown);
         }
         if(stage.hasEventListener(KeyboardEvent.KEY_UP))
         {
            stage.removeEventListener(KeyboardEvent.KEY_UP,this.keyUp);
         }
      }
      
      private function keyDown(param1:KeyboardEvent) : void
      {
         if(GameKernel.currentGameStage == GameStageEnum.GAME_STAGE_OUTSIDE && param1.altKey && param1.ctrlKey && param1.keyCode == 69 && param1.charCode == 101)
         {
            OutSideGalaxiasAction.ctrlDown = true;
         }
         if(param1.shiftKey)
         {
            if(MainUI.shirtKeyDown)
            {
               return;
            }
            MainUI.shirtKeyDown = true;
         }
      }
      
      private function onFullScreenHandler(param1:FullScreenEvent) : void
      {
         if(!param1.fullScreen)
         {
            this.setClientFullScreen(false);
         }
      }
      
      private function keyUp(param1:KeyboardEvent) : void
      {
         if(GameKernel.currentGameStage == GameStageEnum.GAME_STAGE_OUTSIDE)
         {
            OutSideGalaxiasAction.ctrlDown = false;
         }
         MainUI.shirtKeyDown = false;
         if(!0)
         {
         }
      }
      
      public function switchGameQuality() : void
      {
         if(this.isQuality)
         {
            stage.quality = StageQuality.LOW;
         }
         else
         {
            stage.quality = StageQuality.HIGH;
         }
         this.isQuality = !this.isQuality;
      }
      
      public function initFaceBook() : void
      {
         if(GameKernel.ForFB == 1)
         {
            this.count = 2;
            FacebookClient.GetLoginUserInfo(this.initFacebookLoginUserInfo);
         }
         else
         {
            this.count = 1;
            FacebookClient.GetAppFriends(this.initFaceBookFriendList);
            FacebookClient.GetLoginUserInfo(this.initFacebookLoginUserInfo);
         }
      }
      
      public function initFaceBookFriendList(param1:Boolean) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Number = NaN;
         var _loc4_:FacebookUserInfo = null;
         GameKernel.success = param1;
         if(param1)
         {
            _loc2_ = 0;
            while(_loc2_ < FacebookClient.friendsInfo.length)
            {
               facebookFriendList.push(FacebookClient.friendsInfo[_loc2_]);
               PlayerFacebookInfo.Put(FacebookClient.friendsInfo[_loc2_].uid,FacebookClient.friendsInfo[_loc2_]);
               _loc2_++;
            }
         }
         else if(GameSetting.DEBUG_NATIVE)
         {
            if(GameKernel.flashVar["SessionKey"] == undefined)
            {
               _loc3_ = 0;
               while(_loc3_ < 10)
               {
                  _loc4_ = new FacebookUserInfo();
                  _loc4_.uid = _loc3_ + 100;
                  _loc4_.name = "Test" + _loc3_;
                  _loc4_.first_name = "Test" + _loc3_;
                  _loc4_.pic_square = "http://51.222.141.200:8080/images/frymire.png";
                  facebookFriendList.push(_loc4_);
                  _loc3_++;
               }
            }
         }
         ++this.count;
         this.checkFacebook();
      }
      
      public function initFacebookLoginUserInfo(param1:FacebookUserInfo) : void
      {
         if(param1)
         {
            youselfFaceBook = param1;
            PlayerFacebookInfo.Put(param1.uid,param1);
         }
         else if(GameSetting.DEBUG_NATIVE)
         {
            if(GameKernel.flashVar["SessionKey"] == undefined)
            {
               youselfFaceBook = new FacebookUserInfo();
               youselfFaceBook.uid = GamePlayer.getInstance().userID;
               youselfFaceBook.name = "yourself";
               youselfFaceBook.first_name = "yourself";
               youselfFaceBook.pic_square = "http://51.222.141.200:8080/images/frymire.png";
            }
         }
         ++this.count;
         this.checkFacebook();
      }
      
      public function initFaceBookUnInvitedFriends(param1:Boolean) : void
      {
         var _loc2_:FacebookUserInfo = null;
         if(param1)
         {
            if(FacebookClient.facebookFriendsInfo.length)
            {
               _loc2_ = FacebookClient.facebookFriendsInfo[0];
               if(_loc2_.pic_square)
               {
                  facebookPreLoadSet.Put(_loc2_.uid,_loc2_.pic_square);
               }
            }
         }
         else if(GameSetting.DEBUG_NATIVE)
         {
         }
         ++this.count;
         this.checkFacebook();
      }
      
      public function checkFacebook() : void
      {
         if(this.count == 3)
         {
            this.count = 0;
            GamePlayer.getInstance().handlerGameServerRequest();
            if(GamePlayer.getInstance().isGuideComplete)
            {
               GamePlayer.getInstance().sendGameGuidCompletedState();
            }
            FaceBookUI.getInstance().setMaxIndex();
            FaceBookUI.getInstance().setBtnState();
            FaceBookUI.getInstance().isFirstLoad = true;
            FaceBookUI.getInstance().loadFacebookImage(0,FaceBookUI.getInstance().callBackImage);
            this.GetFriendLevel();
         }
      }
      
      public function GetBtngatherMcRect() : Point
      {
         var _loc1_:MObject = GameKernel.gameLayout.getInstallUI("BtngatherMc") as MObject;
         return new Point(_loc1_.width,_loc1_.height);
      }
      
      public function GetFacebookUIRect() : Point
      {
         var _loc1_:MObject = GameKernel.gameLayout.getInstallUI("FacebookUiScene") as MObject;
         return new Point(_loc1_.width,_loc1_.height);
      }
      
      public function GetBtngatherMcHeight() : int
      {
         var _loc1_:MObject = GameKernel.gameLayout.getInstallUI("BtngatherMc") as MObject;
         return _loc1_.height;
      }
      
      public function setClientFullScreen(param1:Boolean = true) : void
      {
         var _loc2_:DisplayObject = GameKernel.gameLayout.getInstallUI("ChatScene");
         var _loc3_:MObject = GameKernel.gameLayout.getInstallUI("BtngatherMc") as MObject;
         var _loc4_:MObject = GameKernel.gameLayout.getInstallUI("FacebookUiScene") as MObject;
         GameKernel.isFullStage = param1;
         if(param1)
         {
            instance.stage.displayState = StageDisplayState.FULL_SCREEN;
            _loc2_.y = _loc2_.stage.stageHeight - ChatUI.chatUIHeight;
            _loc3_.y = _loc3_.stage.stageHeight - _loc3_.height;
            GameKernel.gameLayout.setVisible(_loc4_,false);
            GalaxyMapAction.instance.setFullLocation(true);
            CEffectText.getInstance().showEffectText(instance.stage,StringManager.getInstance().getMessageString("ChatingTXT19"));
            GameKernel.renderManager.rendMask(true);
            InstanceMenuUI.instance.setFullLocation(true);
            TaskNotifyWidget.GetInstance().setFullLocation(true);
         }
         else
         {
            instance.stage.displayState = StageDisplayState.NORMAL;
            if(GameKernel.ForFB == 1)
            {
               _loc2_.y = _loc2_.stage.stageHeight - ChatUI.chatUIHeight;
               _loc3_.y = _loc3_.stage.stageHeight - _loc3_.height;
            }
            else
            {
               _loc2_.y = _loc2_.stage.stageHeight - ChatUI.chatUIHeight - _loc4_.height;
               _loc3_.y = _loc3_.stage.stageHeight - _loc3_.height - _loc4_.height;
            }
            GameKernel.gameLayout.setVisible(_loc4_,true);
            GalaxyMapAction.instance.setFullLocation(false);
            InstanceMenuUI.instance.setFullLocation(false);
            TaskNotifyWidget.GetInstance().setFullLocation(false);
         }
         PlayerInfoUI.getInstance().changeFullScreenIcon();
      }
      
      private function GetFriendLevel() : void
      {
         var _loc3_:MSG_REQUEST_FRIENDLEVEL = null;
         var _loc4_:int = 0;
         var _loc5_:FacebookUserInfo = null;
         var _loc1_:int = int(facebookFriendList.length);
         var _loc2_:int = 0;
         while(_loc1_ > 0)
         {
            _loc3_ = new MSG_REQUEST_FRIENDLEVEL();
            if(_loc1_ > MsgTypes.MAX_MSGFRIENDLEN)
            {
               _loc3_.DataLen = MsgTypes.MAX_MSGFRIENDLEN;
               _loc1_ -= MsgTypes.MAX_MSGFRIENDLEN;
            }
            else
            {
               _loc3_.DataLen = _loc1_;
               _loc1_ = 0;
            }
            _loc4_ = 0;
            while(_loc4_ < _loc3_.DataLen)
            {
               _loc5_ = facebookFriendList[_loc2_];
               _loc3_.Data[_loc4_] = _loc5_.uid;
               _loc2_++;
               _loc4_++;
            }
            _loc3_.SeqId = GamePlayer.getInstance().seqID++;
            _loc3_.Guid = GamePlayer.getInstance().Guid;
            NetManager.Instance().sendObject(_loc3_);
         }
      }
      
      public function resp_MSG_RESP_FRIENDLEVEL(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc6_:int = 0;
         var _loc7_:FacebookUserInfo = null;
         var _loc4_:MSG_RESP_FRIENDLEVEL = new MSG_RESP_FRIENDLEVEL();
         NetManager.Instance().readObject(_loc4_,param3);
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_.DataLen)
         {
            _loc6_ = 0;
            while(_loc6_ < facebookFriendList.length)
            {
               _loc7_ = facebookFriendList[_loc6_];
               if(_loc7_.uid == _loc4_.Data[_loc5_])
               {
                  _loc7_.level = _loc4_.DataLevel[_loc5_] + 1;
                  break;
               }
               _loc6_++;
            }
            _loc5_++;
         }
         GameKernel.facebookFriendList = GameKernel.facebookFriendList.sortOn("level",Array.NUMERIC).reverse();
         FaceBookUI.getInstance().bindFacebookUserAfterSort();
      }
   }
}

