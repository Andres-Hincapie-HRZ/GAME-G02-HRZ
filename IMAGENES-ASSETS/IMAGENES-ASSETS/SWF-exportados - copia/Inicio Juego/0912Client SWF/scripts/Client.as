package
{
   import com.star.frameworks.debug.Log;
   import com.star.frameworks.events.ModuleEvent;
   import com.star.frameworks.managers.ModuleEventManager;
   import com.star.frameworks.managers.RenderManager;
   import com.star.frameworks.managers.ResManager;
   import flash.display.LoaderInfo;
   import flash.display.Sprite;
   import flash.display.StageAlign;
   import flash.display.StageDisplayState;
   import flash.display.StageScaleMode;
   import flash.events.Event;
   import flash.system.Security;
   import logic.entry.GamePlayer;
   import logic.game.CDN;
   import logic.game.GameKernel;
   import logic.game.GameSetting;
   import net.base.NetManager;
   
   public class Client extends Sprite
   {
      
      private var LastStageWidth:int;
      
      public function Client()
      {
         super();
         Security.allowDomain("*");
         Security.allowInsecureDomain("*");
         ModuleEventManager.getInstance().addEventListener(ModuleEvent.MAIN_STAGE,this.Init);
      }
      
      private function Init(param1:ModuleEvent) : void
      {
         var _loc12_:String = null;
         var _loc2_:int = 0;
         var _loc3_:Array = param1.resLib.Keys();
         var _loc4_:Array = param1.resLib.Values();
         while(_loc2_ < param1.resLib.Length())
         {
            ResManager.getInstance().registerRes(_loc3_[_loc2_],LoaderInfo(_loc4_[_loc2_]).content);
            _loc2_++;
         }
         CDN.getInstance().Parser(param1.pathObj);
         RenderManager.getInstance().Render(this);
         var _loc5_:Object = param1.flashVar;
         var _loc6_:String = _loc5_["UserId"];
         var _loc7_:String = _loc5_["SessionKey"];
         var _loc8_:String = _loc5_["GiftId"];
         var _loc9_:String = _loc5_["ApiKey"];
         var _loc10_:String = _loc5_["SessionSecret"];
         var _loc11_:String = _loc5_["SessionKey"];
         _loc12_ = _loc5_["SessionIP"];
         var _loc13_:String = _loc5_["Language"];
         var _loc14_:String = _loc5_["IsFan"];
         var _loc15_:String = _loc5_["ServerPort"];
         var _loc16_:String = _loc5_["GameUrl"];
         GameKernel.flashVar = param1.flashVar;
         GamePlayer.getInstance().userID = Number(_loc6_);
         GamePlayer.getInstance().sessionKey = _loc7_;
         NetManager.Instance().loginServerHost = _loc12_;
         if(_loc8_ == null)
         {
            _loc8_ = "-1";
         }
         if(_loc13_ != null)
         {
            GamePlayer.getInstance().language = int(_loc13_);
         }
         Log.LogEnable = GamePlayer.getInstance().language == 11;
         if(_loc14_ != null)
         {
            GamePlayer.getInstance().isFan = int(_loc14_);
         }
         if(_loc15_ != null)
         {
            NetManager.Instance().loginServerPort = _loc15_;
         }
         GamePlayer.getInstance().giftId = int(_loc8_);
         GamePlayer.getInstance().gameUrl = _loc16_;
         GamePlayer.getInstance().MvpUrl = _loc5_["MvpUrl"];
         GamePlayer.getInstance().IsGlobal = _loc5_["IsGlobal"];
         GamePlayer.getInstance().DefaultName = _loc5_["charName"];
         this.showFPS();
         addChild(GameKernel.getInstance());
         this.setStage();
      }
      
      private function showFPS() : void
      {
      }
      
      public function setStage() : void
      {
         stage.scaleMode = StageScaleMode.NO_SCALE;
         stage.displayState = StageDisplayState.NORMAL;
         stage.align = StageAlign.TOP;
         stage.showDefaultContextMenu = false;
         this.LastStageWidth = GameSetting.GAME_STAGE_WIDTH;
         stage.addEventListener(Event.RESIZE,this.OnResize);
         this.OnResize(null);
      }
      
      private function OnResize(param1:Event) : void
      {
         GameKernel.fullRect.x = -(this.stage.stageWidth - this.LastStageWidth) / 2;
         GameKernel.fullRect.width = this.stage.stageWidth;
         GameKernel.fullRect.height = this.stage.stageHeight;
      }
   }
}

