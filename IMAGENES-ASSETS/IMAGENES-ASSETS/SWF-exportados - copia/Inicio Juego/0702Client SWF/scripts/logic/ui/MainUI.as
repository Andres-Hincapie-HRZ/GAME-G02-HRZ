package logic.ui
{
   import com.star.frameworks.geom.RectangleKit;
   import com.star.frameworks.managers.StringManager;
   import com.star.frameworks.module.IModule;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import gs.TweenLite;
   import gs.easing.Elastic;
   import logic.action.ConstructionAction;
   import logic.action.StarSurfaceAction;
   import logic.entry.GameStageEnum;
   import logic.entry.MObject;
   import logic.game.GameKernel;
   import logic.game.GameSetting;
   import logic.manager.GameScreenManager;
   
   public final class MainUI implements IModule
   {
      
      private static var instance:MainUI;
      
      public static var shirtKeyDown:Boolean = false;
      
      private var _mainUI:MObject;
      
      private var _test:MovieClip;
      
      public var m_typeAry:Array = new Array();
      
      private var nextRound:MovieClip;
      
      private var endInstance:MovieClip;
      
      public function MainUI()
      {
         super();
      }
      
      public static function getInstance() : MainUI
      {
         if(instance == null)
         {
            instance = new MainUI();
         }
         return instance;
      }
      
      public function Init() : void
      {
         this.initMcElement();
         this.PlayMainUI();
      }
      
      internal function initMcElement() : void
      {
         GameKernel.gameLayout.installComponent("ChatScene",ChatUI.getInstance().TextArea);
         GameKernel.gameLayout.InstallUI("BtngatherMc",new RectangleKit(430,650));
         GameKernel.gameLayout.InstallUI("FacebookUiScene",new RectangleKit(0,650));
         GameKernel.gameLayout.InstallUI("PlayerinfoMc",new RectangleKit(50,50));
         GameKernel.gameLayout.InstallUI("ResPlanMc",new RectangleKit(420,50));
         FaceBookUI.getInstance().InitFaceBookUI(GameKernel.gameLayout.getInstallUI("FacebookUiScene") as MObject);
         PlayerInfoUI.getInstance().Init(GameKernel.gameLayout.getInstallUI("PlayerinfoMc") as MObject);
         ResPlaneUI.getInstance().Init(GameKernel.gameLayout.getInstallUI("ResPlanMc") as MObject);
         GameSystemUI.getInstance().Init(GameKernel.gameLayout.getInstallUI("BtngatherMc") as MObject);
         ChatUI.getInstance().Init();
         if(GameKernel.ForFB == 1)
         {
            FaceBookUI.getInstance().Hide();
            GameKernel.gameLayout.getInstallUI("BtngatherMc").y = GameKernel.fullRect.height - GameKernel.gameLayout.getInstallUI("BtngatherMc").height;
            ChatUI.getInstance().TextArea.y = GameKernel.fullRect.height - ChatUI.getInstance().TextArea.height;
         }
         else
         {
            GameKernel.fullRect.x = (GameSetting.GAME_STAGE_WIDTH - GameKernel.gameLayout.getInstallUI("PlayerinfoMc").stage.stageWidth) / 2;
            GameKernel.fullRect.width = GameKernel.gameLayout.getInstallUI("PlayerinfoMc").stage.stageWidth;
         }
         this.EnterScrene();
      }
      
      public function SetUIVisible(param1:Boolean) : void
      {
         GameKernel.gameLayout.getInstallUI("PlayerinfoMc").visible = param1;
         GameKernel.gameLayout.getInstallUI("ResPlanMc").visible = param1;
      }
      
      private function EnterScrene() : void
      {
         GameKernel.currentGameStage = GameStageEnum.GAME_STAGE_STARSURFACE;
         StarSurfaceAction.getInstance().Init();
         GameScreenManager.getInstance().ShowScreen(StarSurfaceAction.getInstance());
         ConstructionAction.getInstance().SufFaceUI = StarSurfaceAction.getInstance().LayOut;
         this.m_typeAry[0] = StringManager.getInstance().getMessageString("CommanderText113");
         this.m_typeAry[1] = StringManager.getInstance().getMessageString("CommanderText114");
         this.m_typeAry[2] = StringManager.getInstance().getMessageString("CommanderText115");
         this.m_typeAry[3] = StringManager.getInstance().getMessageString("Boss34");
      }
      
      private function PlayMainUI() : void
      {
         var _loc1_:DisplayObject = GameKernel.gameLayout.getInstallUI("FacebookUiScene");
         var _loc2_:MObject = GameKernel.gameLayout.getInstallUI("ResPlanMc") as MObject;
         var _loc3_:MObject = GameKernel.gameLayout.getInstallUI("BtngatherMc") as MObject;
         TweenLite.to(GameKernel.gameLayout.getInstallUI("PlayerinfoMc"),1,{
            "x":GameKernel.fullRect.x,
            "y":GameKernel.fullRect.y,
            "ease":Elastic.easeOut
         });
         TweenLite.to(GameKernel.gameLayout.getInstallUI("ResPlanMc"),1,{
            "x":GameKernel.fullRect.x + GameKernel.fullRect.width - _loc2_.width,
            "y":GameKernel.fullRect.y,
            "ease":Elastic.easeOut
         });
         if(GameKernel.ForFB == 1)
         {
            FaceBookUI.getInstance().Hide();
            TweenLite.to(GameKernel.gameLayout.getInstallUI("BtngatherMc"),1,{
               "x":GameKernel.fullRect.x + GameKernel.fullRect.width - _loc3_.width,
               "y":GameKernel.fullRect.height - GameSystemUI.systemUIHeight,
               "ease":Elastic.easeOut
            });
            TweenLite.to(GameKernel.gameLayout.getInstallUI("ChatScene"),1,{
               "x":GameKernel.fullRect.x,
               "y":GameKernel.fullRect.height - ChatUI.chatUIHeight,
               "ease":Elastic.easeOut
            });
         }
         else
         {
            TweenLite.to(GameKernel.gameLayout.getInstallUI("BtngatherMc"),1,{
               "x":GameKernel.fullRect.x + GameKernel.fullRect.width - _loc3_.width,
               "y":GameKernel.fullRect.height - _loc1_.height - GameSystemUI.systemUIHeight,
               "ease":Elastic.easeOut
            });
            TweenLite.to(GameKernel.gameLayout.getInstallUI("ChatScene"),1,{
               "x":GameKernel.fullRect.x,
               "y":GameKernel.fullRect.height - _loc1_.height - ChatUI.chatUIHeight,
               "ease":Elastic.easeOut
            });
         }
      }
      
      public function Release() : void
      {
      }
      
      public function SetVisible(param1:Boolean) : void
      {
         GameKernel.renderManager.Show(this,param1);
      }
      
      public function BindFacebookUserInfo() : void
      {
      }
      
      public function getUI() : MObject
      {
         if(!this._mainUI)
         {
            this._mainUI = new MObject();
         }
         return this._mainUI;
      }
   }
}

