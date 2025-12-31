package logic.ui
{
   import com.star.frameworks.events.ActionEvent;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import logic.entry.HButton;
   import logic.entry.MObject;
   import logic.game.GameMouseZoneManager;
   import logic.manager.GameInterActiveManager;
   
   public class GameSystemUI
   {
      
      public static var systemUIWidth:int;
      
      public static var systemUIHeight:int;
      
      private static var instance:GameSystemUI;
      
      public var starGalaxyBtn:HButton;
      
      public var constructionBtn:HButton;
      
      public var goHomeBtn:HButton;
      
      public var surFaceBtn:HButton;
      
      public var universeBtn:HButton;
      
      public var mallBtn:HButton;
      
      public var sysBtn:HButton;
      
      public var militaryBtn:HButton;
      
      public var alternationBtn:HButton;
      
      public var progressBtn:HButton;
      
      public var subMenuBtn:MObject;
      
      public var interactiveSubMenuBtn:MObject;
      
      public var interactiveSubMenuBtn2:MObject;
      
      public var interactiveSubMenuBtn3:MObject;
      
      public var interactiveSubMenuBtn4:MObject;
      
      private var _mc:MObject;
      
      public var _base:MovieClip;
      
      private var LastStageWidth:int;
      
      public function GameSystemUI()
      {
         super();
      }
      
      public static function getInstance() : GameSystemUI
      {
         if(instance == null)
         {
            instance = new GameSystemUI();
         }
         return instance;
      }
      
      public function get Display() : MObject
      {
         return this._mc;
      }
      
      public function Init(param1:MObject) : void
      {
         this._mc = param1;
         if(this._mc.stage)
         {
            this.LastStageWidth = this._mc.stage.stageWidth;
            this._mc.stage.addEventListener(Event.RESIZE,this.OnResize);
         }
         else
         {
            this._mc.addEventListener(Event.ADDED_TO_STAGE,this.OnAddToStage);
         }
         this._base = this._mc.getMC().mc_base as MovieClip;
         this.initMcElement();
         this.initSubMenu();
         this.initInteractiveSubMenu();
         this.initInteractiveSubMenu2();
         this.initInteractiveSubMenu3();
         this.initInteractiveSubMenu4();
         systemUIWidth = this._mc.getMC().width;
         systemUIHeight = this._mc.getMC().height;
      }
      
      private function OnAddToStage(param1:Event) : void
      {
         this._mc.removeEventListener(Event.ADDED_TO_STAGE,this.OnAddToStage);
         this.LastStageWidth = this._mc.stage.stageWidth;
         this._mc.stage.addEventListener(Event.RESIZE,this.OnResize);
      }
      
      private function initMcElement() : void
      {
         this.starGalaxyBtn = new HButton(this._mc.getMC().btn_galaxy);
         this.surFaceBtn = new HButton(this._mc.getMC().btn_surface);
         this.universeBtn = new HButton(this._mc.getMC().btn_universe);
         this.constructionBtn = new HButton(this._mc.getMC().mc_construct);
         this.militaryBtn = new HButton(this._mc.getMC().mc_military);
         this.sysBtn = new HButton(this._mc.getMC().mc_system);
         this.mallBtn = new HButton(this._mc.getMC().mc_mall);
         this.alternationBtn = new HButton(this._mc.getMC().mc_alternation);
         this.goHomeBtn = new HButton(this._mc.getMC().btn_gohome);
         this.progressBtn = new HButton(this._mc.getMC().btn_progress);
         GameInterActiveManager.InstallInterActiveEvent(this.universeBtn.m_movie,ActionEvent.ACTION_CLICK,GameMouseZoneManager.onNagivateToolBar);
         GameInterActiveManager.InstallInterActiveEvent(this.starGalaxyBtn.m_movie,ActionEvent.ACTION_CLICK,GameMouseZoneManager.onNagivateToolBar);
         GameInterActiveManager.InstallInterActiveEvent(this.surFaceBtn.m_movie,ActionEvent.ACTION_CLICK,GameMouseZoneManager.onNagivateToolBar);
         GameInterActiveManager.InstallInterActiveEvent(this.constructionBtn.m_movie,ActionEvent.ACTION_CLICK,GameMouseZoneManager.onNagivateToolBar);
         GameInterActiveManager.InstallInterActiveEvent(this.militaryBtn.m_movie,ActionEvent.ACTION_CLICK,GameMouseZoneManager.onNagivateToolBar);
         GameInterActiveManager.InstallInterActiveEvent(this.sysBtn.m_movie,ActionEvent.ACTION_CLICK,GameMouseZoneManager.onNagivateToolBar);
         GameInterActiveManager.InstallInterActiveEvent(this.mallBtn.m_movie,ActionEvent.ACTION_CLICK,GameMouseZoneManager.onNagivateToolBar);
         GameInterActiveManager.InstallInterActiveEvent(this.alternationBtn.m_movie,ActionEvent.ACTION_CLICK,GameMouseZoneManager.onNagivateToolBar);
         GameInterActiveManager.InstallInterActiveEvent(this.goHomeBtn.m_movie,ActionEvent.ACTION_CLICK,GameMouseZoneManager.onNagivateToolBar);
         GameInterActiveManager.InstallInterActiveEvent(this.progressBtn.m_movie,ActionEvent.ACTION_CLICK,GameMouseZoneManager.onNagivateToolBar);
         GameInterActiveManager.InstallInterActiveEvent(this.universeBtn.m_movie,ActionEvent.ACTION_MOUSE_OVER,GameMouseZoneManager.ShowTip);
         GameInterActiveManager.InstallInterActiveEvent(this.starGalaxyBtn.m_movie,ActionEvent.ACTION_MOUSE_OVER,GameMouseZoneManager.ShowTip);
         GameInterActiveManager.InstallInterActiveEvent(this.surFaceBtn.m_movie,ActionEvent.ACTION_MOUSE_OVER,GameMouseZoneManager.ShowTip);
         GameInterActiveManager.InstallInterActiveEvent(this.constructionBtn.m_movie,ActionEvent.ACTION_MOUSE_OVER,GameMouseZoneManager.ShowTip);
         GameInterActiveManager.InstallInterActiveEvent(this.militaryBtn.m_movie,ActionEvent.ACTION_MOUSE_OVER,GameMouseZoneManager.ShowTip);
         GameInterActiveManager.InstallInterActiveEvent(this.sysBtn.m_movie,ActionEvent.ACTION_MOUSE_OVER,GameMouseZoneManager.ShowTip);
         GameInterActiveManager.InstallInterActiveEvent(this.alternationBtn.m_movie,ActionEvent.ACTION_MOUSE_OVER,GameMouseZoneManager.ShowTip);
         GameInterActiveManager.InstallInterActiveEvent(this.goHomeBtn.m_movie,ActionEvent.ACTION_MOUSE_OVER,GameMouseZoneManager.ShowTip);
         GameInterActiveManager.InstallInterActiveEvent(this.mallBtn.m_movie,ActionEvent.ACTION_MOUSE_OVER,GameMouseZoneManager.ShowTip);
         GameInterActiveManager.InstallInterActiveEvent(this.progressBtn.m_movie,ActionEvent.ACTION_MOUSE_OVER,GameMouseZoneManager.ShowTip);
         GameInterActiveManager.InstallInterActiveEvent(this.universeBtn.m_movie,ActionEvent.ACTION_MOUSE_OUT,GameMouseZoneManager.HideTip);
         GameInterActiveManager.InstallInterActiveEvent(this.starGalaxyBtn.m_movie,ActionEvent.ACTION_MOUSE_OUT,GameMouseZoneManager.HideTip);
         GameInterActiveManager.InstallInterActiveEvent(this.surFaceBtn.m_movie,ActionEvent.ACTION_MOUSE_OUT,GameMouseZoneManager.HideTip);
         GameInterActiveManager.InstallInterActiveEvent(this.constructionBtn.m_movie,ActionEvent.ACTION_MOUSE_OUT,GameMouseZoneManager.HideTip);
         GameInterActiveManager.InstallInterActiveEvent(this.militaryBtn.m_movie,ActionEvent.ACTION_MOUSE_OUT,GameMouseZoneManager.HideTip);
         GameInterActiveManager.InstallInterActiveEvent(this.sysBtn.m_movie,ActionEvent.ACTION_MOUSE_OUT,GameMouseZoneManager.HideTip);
         GameInterActiveManager.InstallInterActiveEvent(this.alternationBtn.m_movie,ActionEvent.ACTION_MOUSE_OUT,GameMouseZoneManager.HideTip);
         GameInterActiveManager.InstallInterActiveEvent(this.goHomeBtn.m_movie,ActionEvent.ACTION_MOUSE_OUT,GameMouseZoneManager.HideTip);
         GameInterActiveManager.InstallInterActiveEvent(this.mallBtn.m_movie,ActionEvent.ACTION_MOUSE_OUT,GameMouseZoneManager.HideTip);
         GameInterActiveManager.InstallInterActiveEvent(this.progressBtn.m_movie,ActionEvent.ACTION_MOUSE_OUT,GameMouseZoneManager.HideTip);
      }
      
      public function setViewFaceBookGalaxyState(param1:Boolean = false) : void
      {
      }
      
      public function setViewAdditionGalaxyState(param1:Boolean = true) : void
      {
      }
      
      private function initSubMenu() : void
      {
         this.subMenuBtn = new MObject("NavigationAnim",0,0);
         var _loc1_:HButton = new HButton(this.subMenuBtn.getMC().btn_build);
         var _loc2_:HButton = new HButton(this.subMenuBtn.getMC().btn_boatyard);
         var _loc3_:HButton = new HButton(this.subMenuBtn.getMC().btn_research);
         var _loc4_:HButton = new HButton(this.subMenuBtn.getMC().btn_technology);
         GameInterActiveManager.InstallInterActiveEvent(_loc1_.m_movie,ActionEvent.ACTION_CLICK,GameMouseZoneManager.onNagivateToolBar);
         GameInterActiveManager.InstallInterActiveEvent(_loc3_.m_movie,ActionEvent.ACTION_CLICK,GameMouseZoneManager.onNagivateToolBar);
         GameInterActiveManager.InstallInterActiveEvent(_loc2_.m_movie,ActionEvent.ACTION_CLICK,GameMouseZoneManager.onNagivateToolBar);
         GameInterActiveManager.InstallInterActiveEvent(_loc4_.m_movie,ActionEvent.ACTION_CLICK,GameMouseZoneManager.onNagivateToolBar);
         GameInterActiveManager.InstallInterActiveEvent(_loc1_.m_movie,ActionEvent.ACTION_MOUSE_OVER,GameMouseZoneManager.ShowTip);
         GameInterActiveManager.InstallInterActiveEvent(_loc1_.m_movie,ActionEvent.ACTION_MOUSE_OUT,GameMouseZoneManager.HideTip);
         GameInterActiveManager.InstallInterActiveEvent(_loc2_.m_movie,ActionEvent.ACTION_MOUSE_OVER,GameMouseZoneManager.ShowTip);
         GameInterActiveManager.InstallInterActiveEvent(_loc2_.m_movie,ActionEvent.ACTION_MOUSE_OUT,GameMouseZoneManager.HideTip);
         GameInterActiveManager.InstallInterActiveEvent(_loc3_.m_movie,ActionEvent.ACTION_MOUSE_OVER,GameMouseZoneManager.ShowTip);
         GameInterActiveManager.InstallInterActiveEvent(_loc3_.m_movie,ActionEvent.ACTION_MOUSE_OUT,GameMouseZoneManager.HideTip);
         GameInterActiveManager.InstallInterActiveEvent(_loc4_.m_movie,ActionEvent.ACTION_MOUSE_OVER,GameMouseZoneManager.ShowTip);
         GameInterActiveManager.InstallInterActiveEvent(_loc4_.m_movie,ActionEvent.ACTION_MOUSE_OUT,GameMouseZoneManager.HideTip);
      }
      
      private function initInteractiveSubMenu() : void
      {
         this.interactiveSubMenuBtn = new MObject("NavigationAnim1");
         var _loc1_:HButton = new HButton(this.interactiveSubMenuBtn.getMC().btn_commander);
         var _loc2_:HButton = new HButton(this.interactiveSubMenuBtn.getMC().btn_unload);
         var _loc3_:HButton = new HButton(this.interactiveSubMenuBtn.getMC().btn_foundfleet);
         var _loc4_:HButton = new HButton(this.interactiveSubMenuBtn.getMC().btn_printdesign);
         GameInterActiveManager.InstallInterActiveEvent(_loc1_.m_movie,ActionEvent.ACTION_CLICK,GameMouseZoneManager.onNagivateToolBar);
         GameInterActiveManager.InstallInterActiveEvent(_loc2_.m_movie,ActionEvent.ACTION_CLICK,GameMouseZoneManager.onNagivateToolBar);
         GameInterActiveManager.InstallInterActiveEvent(_loc3_.m_movie,ActionEvent.ACTION_CLICK,GameMouseZoneManager.onNagivateToolBar);
         GameInterActiveManager.InstallInterActiveEvent(_loc4_.m_movie,ActionEvent.ACTION_CLICK,GameMouseZoneManager.onNagivateToolBar);
         GameInterActiveManager.InstallInterActiveEvent(_loc1_.m_movie,ActionEvent.ACTION_MOUSE_OVER,GameMouseZoneManager.ShowTip);
         GameInterActiveManager.InstallInterActiveEvent(_loc1_.m_movie,ActionEvent.ACTION_MOUSE_OUT,GameMouseZoneManager.HideTip);
         GameInterActiveManager.InstallInterActiveEvent(_loc2_.m_movie,ActionEvent.ACTION_MOUSE_OVER,GameMouseZoneManager.ShowTip);
         GameInterActiveManager.InstallInterActiveEvent(_loc2_.m_movie,ActionEvent.ACTION_MOUSE_OUT,GameMouseZoneManager.HideTip);
         GameInterActiveManager.InstallInterActiveEvent(_loc3_.m_movie,ActionEvent.ACTION_MOUSE_OVER,GameMouseZoneManager.ShowTip);
         GameInterActiveManager.InstallInterActiveEvent(_loc3_.m_movie,ActionEvent.ACTION_MOUSE_OUT,GameMouseZoneManager.HideTip);
         GameInterActiveManager.InstallInterActiveEvent(_loc4_.m_movie,ActionEvent.ACTION_MOUSE_OVER,GameMouseZoneManager.ShowTip);
         GameInterActiveManager.InstallInterActiveEvent(_loc4_.m_movie,ActionEvent.ACTION_MOUSE_OUT,GameMouseZoneManager.HideTip);
      }
      
      private function initInteractiveSubMenu2() : void
      {
         this.interactiveSubMenuBtn2 = new MObject("NavigationAnim2");
         var _loc1_:HButton = new HButton(this.interactiveSubMenuBtn2.getMC().btn_corps);
         var _loc2_:HButton = new HButton(this.interactiveSubMenuBtn2.getMC().btn_friend);
         var _loc3_:HButton = new HButton(this.interactiveSubMenuBtn2.getMC().btn_business);
         var _loc4_:HButton = new HButton(this.interactiveSubMenuBtn2.getMC().btn_ranking);
         GameInterActiveManager.InstallInterActiveEvent(_loc1_.m_movie,ActionEvent.ACTION_CLICK,GameMouseZoneManager.onNagivateToolBar);
         GameInterActiveManager.InstallInterActiveEvent(_loc2_.m_movie,ActionEvent.ACTION_CLICK,GameMouseZoneManager.onNagivateToolBar);
         GameInterActiveManager.InstallInterActiveEvent(_loc3_.m_movie,ActionEvent.ACTION_CLICK,GameMouseZoneManager.onNagivateToolBar);
         GameInterActiveManager.InstallInterActiveEvent(_loc4_.m_movie,ActionEvent.ACTION_CLICK,GameMouseZoneManager.onNagivateToolBar);
         GameInterActiveManager.InstallInterActiveEvent(_loc1_.m_movie,ActionEvent.ACTION_MOUSE_OVER,GameMouseZoneManager.ShowTip);
         GameInterActiveManager.InstallInterActiveEvent(_loc1_.m_movie,ActionEvent.ACTION_MOUSE_OUT,GameMouseZoneManager.HideTip);
         GameInterActiveManager.InstallInterActiveEvent(_loc2_.m_movie,ActionEvent.ACTION_MOUSE_OVER,GameMouseZoneManager.ShowTip);
         GameInterActiveManager.InstallInterActiveEvent(_loc2_.m_movie,ActionEvent.ACTION_MOUSE_OUT,GameMouseZoneManager.HideTip);
         GameInterActiveManager.InstallInterActiveEvent(_loc3_.m_movie,ActionEvent.ACTION_MOUSE_OVER,GameMouseZoneManager.ShowTip);
         GameInterActiveManager.InstallInterActiveEvent(_loc3_.m_movie,ActionEvent.ACTION_MOUSE_OUT,GameMouseZoneManager.HideTip);
         GameInterActiveManager.InstallInterActiveEvent(_loc4_.m_movie,ActionEvent.ACTION_MOUSE_OVER,GameMouseZoneManager.ShowTip);
         GameInterActiveManager.InstallInterActiveEvent(_loc4_.m_movie,ActionEvent.ACTION_MOUSE_OUT,GameMouseZoneManager.HideTip);
      }
      
      private function initInteractiveSubMenu3() : void
      {
         this.interactiveSubMenuBtn3 = new MObject("NavigationAnim3");
         var _loc1_:HButton = new HButton(this.interactiveSubMenuBtn3.getMC().btn_mail);
         var _loc2_:HButton = new HButton(this.interactiveSubMenuBtn3.getMC().btn_storage);
         var _loc3_:HButton = new HButton(this.interactiveSubMenuBtn3.getMC().btn_task);
         var _loc4_:HButton = new HButton(this.interactiveSubMenuBtn3.getMC().btn_steal);
         GameInterActiveManager.InstallInterActiveEvent(_loc1_.m_movie,ActionEvent.ACTION_CLICK,GameMouseZoneManager.onNagivateToolBar);
         GameInterActiveManager.InstallInterActiveEvent(_loc2_.m_movie,ActionEvent.ACTION_CLICK,GameMouseZoneManager.onNagivateToolBar);
         GameInterActiveManager.InstallInterActiveEvent(_loc3_.m_movie,ActionEvent.ACTION_CLICK,GameMouseZoneManager.onNagivateToolBar);
         GameInterActiveManager.InstallInterActiveEvent(_loc4_.m_movie,ActionEvent.ACTION_CLICK,GameMouseZoneManager.onNagivateToolBar);
         GameInterActiveManager.InstallInterActiveEvent(_loc1_.m_movie,ActionEvent.ACTION_MOUSE_OVER,GameMouseZoneManager.ShowTip);
         GameInterActiveManager.InstallInterActiveEvent(_loc1_.m_movie,ActionEvent.ACTION_MOUSE_OUT,GameMouseZoneManager.HideTip);
         GameInterActiveManager.InstallInterActiveEvent(_loc2_.m_movie,ActionEvent.ACTION_MOUSE_OVER,GameMouseZoneManager.ShowTip);
         GameInterActiveManager.InstallInterActiveEvent(_loc2_.m_movie,ActionEvent.ACTION_MOUSE_OUT,GameMouseZoneManager.HideTip);
         GameInterActiveManager.InstallInterActiveEvent(_loc3_.m_movie,ActionEvent.ACTION_MOUSE_OVER,GameMouseZoneManager.ShowTip);
         GameInterActiveManager.InstallInterActiveEvent(_loc3_.m_movie,ActionEvent.ACTION_MOUSE_OUT,GameMouseZoneManager.HideTip);
         GameInterActiveManager.InstallInterActiveEvent(_loc4_.m_movie,ActionEvent.ACTION_MOUSE_OVER,GameMouseZoneManager.ShowTip);
         GameInterActiveManager.InstallInterActiveEvent(_loc4_.m_movie,ActionEvent.ACTION_MOUSE_OUT,GameMouseZoneManager.HideTip);
      }
      
      public function GetStorageBtnPoint() : Point
      {
         var _loc1_:Sprite = this.interactiveSubMenuBtn3.getMC().btn_storage;
         return _loc1_.localToGlobal(new Point(0,0));
      }
      
      public function initInteractiveSubMenu4() : void
      {
         var _loc4_:HButton = null;
         this.interactiveSubMenuBtn4 = new MObject("NavigationAnim4");
         var _loc1_:HButton = new HButton(this.interactiveSubMenuBtn4.getMC().btn_lottery);
         var _loc2_:HButton = new HButton(this.interactiveSubMenuBtn4.getMC().btn_mall);
         var _loc3_:MovieClip = this.interactiveSubMenuBtn4.getMC().getChildByName("btn_chip") as MovieClip;
         if(_loc3_ != null)
         {
            _loc4_ = new HButton(this.interactiveSubMenuBtn4.getMC().btn_chip);
            GameInterActiveManager.InstallInterActiveEvent(_loc4_.m_movie,ActionEvent.ACTION_CLICK,GameMouseZoneManager.onNagivateToolBar);
            GameInterActiveManager.InstallInterActiveEvent(_loc4_.m_movie,ActionEvent.ACTION_MOUSE_OVER,GameMouseZoneManager.ShowTip);
            GameInterActiveManager.InstallInterActiveEvent(_loc4_.m_movie,ActionEvent.ACTION_MOUSE_OUT,GameMouseZoneManager.HideTip);
         }
         GameInterActiveManager.InstallInterActiveEvent(_loc1_.m_movie,ActionEvent.ACTION_CLICK,GameMouseZoneManager.onNagivateToolBar);
         GameInterActiveManager.InstallInterActiveEvent(_loc2_.m_movie,ActionEvent.ACTION_CLICK,GameMouseZoneManager.onNagivateToolBar);
         GameInterActiveManager.InstallInterActiveEvent(_loc1_.m_movie,ActionEvent.ACTION_MOUSE_OVER,GameMouseZoneManager.ShowTip);
         GameInterActiveManager.InstallInterActiveEvent(_loc1_.m_movie,ActionEvent.ACTION_MOUSE_OUT,GameMouseZoneManager.HideTip);
         GameInterActiveManager.InstallInterActiveEvent(_loc2_.m_movie,ActionEvent.ACTION_MOUSE_OVER,GameMouseZoneManager.ShowTip);
         GameInterActiveManager.InstallInterActiveEvent(_loc2_.m_movie,ActionEvent.ACTION_MOUSE_OUT,GameMouseZoneManager.HideTip);
      }
      
      public function ShowSubMenu() : void
      {
         if(Boolean(this._base) && Boolean(this.subMenuBtn))
         {
            this._base.addChild(this.subMenuBtn);
         }
      }
      
      public function HideSubMenu() : void
      {
         if(Boolean(this._base) && this._base.contains(this.subMenuBtn))
         {
            this._base.removeChild(this.subMenuBtn);
         }
      }
      
      public function ShowInteractiveSubMenu() : void
      {
         if(Boolean(this._base) && Boolean(this.interactiveSubMenuBtn))
         {
            this._base.addChild(this.interactiveSubMenuBtn);
         }
      }
      
      public function HideInteractiveSubMenu() : void
      {
         if(Boolean(this._base) && this._base.contains(this.interactiveSubMenuBtn))
         {
            this._base.removeChild(this.interactiveSubMenuBtn);
         }
      }
      
      public function ShowInteractiveSubMenu2() : void
      {
         if(Boolean(this._base) && Boolean(this.interactiveSubMenuBtn2))
         {
            this._base.addChild(this.interactiveSubMenuBtn2);
         }
      }
      
      public function HideInteractiveSubMenu2() : void
      {
         if(Boolean(this._base) && this._base.contains(this.interactiveSubMenuBtn2))
         {
            this._base.removeChild(this.interactiveSubMenuBtn2);
         }
      }
      
      public function ShowInteractiveSubMenu3() : void
      {
         if(Boolean(this._base) && Boolean(this.interactiveSubMenuBtn3))
         {
            this._base.addChild(this.interactiveSubMenuBtn3);
         }
      }
      
      public function HideInteractiveSubMenu3() : void
      {
         if(Boolean(this._base) && this._base.contains(this.interactiveSubMenuBtn3))
         {
            this._base.removeChild(this.interactiveSubMenuBtn3);
         }
      }
      
      public function ShowInteractiveSubMenu4() : void
      {
         if(Boolean(this._base) && Boolean(this.interactiveSubMenuBtn4))
         {
            this._base.addChild(this.interactiveSubMenuBtn4);
         }
      }
      
      public function HideInteractiveSubMenu4() : void
      {
         if(Boolean(this._base) && this._base.contains(this.interactiveSubMenuBtn4))
         {
            this._base.removeChild(this.interactiveSubMenuBtn4);
         }
      }
      
      private function OnResize(param1:Event) : void
      {
         this._mc.x += (this._mc.stage.stageWidth - this.LastStageWidth) / 2;
         this.LastStageWidth = this._mc.stage.stageWidth;
      }
   }
}

