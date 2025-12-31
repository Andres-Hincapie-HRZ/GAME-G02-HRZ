package logic.game
{
   import com.star.frameworks.events.ActionEvent;
   import com.star.frameworks.facebook.FacebookUserInfo;
   import com.star.frameworks.geom.RectangleKit;
   import flash.events.MouseEvent;
   import logic.action.ConstructionAction;
   import logic.action.FaceBookAction;
   import logic.action.GalaxyMapAction;
   import logic.entry.GamePlaceType;
   import logic.entry.GamePlayer;
   import logic.entry.GameStageEnum;
   import logic.entry.HButton;
   import logic.entry.MObject;
   import logic.manager.FightManager;
   import logic.manager.GalaxyManager;
   import logic.manager.GameInterActiveManager;
   import logic.ui.GameSystemUI;
   import logic.ui.PlayerInfoUI;
   import logic.widget.ConstructionOperationWidget;
   import logic.widget.ProgressInFriendToolBarWidget;
   import logic.widget.ProgressListToolBarWidget;
   
   public class GameStateManager
   {
      
      public static var IsResouseStar:Boolean;
      
      private static var instance:GameStateManager;
      
      public static var isGoHome:Boolean = false;
      
      public static var playerPlace:int = 0;
      
      public static var preFriendGuid:Number = -1;
      
      private var _goHomeBtn:HButton;
      
      public function GameStateManager()
      {
         super();
      }
      
      public static function getInstance() : GameStateManager
      {
         if(instance == null)
         {
            instance = new GameStateManager();
         }
         return instance;
      }
      
      public static function UpdateStarType(param1:Number, param2:Boolean) : void
      {
         var _loc3_:FacebookUserInfo = null;
         IsResouseStar = param2;
         if(GamePlayer.getInstance().userID == param1)
         {
            GameStateManager.playerPlace = GamePlaceType.PLACE_HOME;
         }
         else
         {
            GameStateManager.playerPlace = GamePlaceType.PLACE_OTHER;
            for each(_loc3_ in GameKernel.facebookFriendList)
            {
               if(_loc3_.uid == param1)
               {
                  GameStateManager.playerPlace = GamePlaceType.PLACE_FRIENDHOME;
                  return;
               }
            }
         }
      }
      
      public function viewFaceBookFriend() : void
      {
         GameSystemUI.getInstance().setViewFaceBookGalaxyState(true);
         GameMouseZoneManager.gotoStarSurfaceMap();
      }
      
      public function backHome() : void
      {
         playerPlace = GamePlaceType.PLACE_HOME;
         if(ConstructionOperationWidget.getInstance().Operation)
         {
            ConstructionOperationWidget.getInstance().Hide();
         }
         GameSystemUI.getInstance().setViewFaceBookGalaxyState(false);
         this.hideGoHomeBtn();
      }
      
      public function showGoHomeBtn() : void
      {
         if(this._goHomeBtn != null)
         {
            GameKernel.gameLayout.InstallUI("GohomeBtn",new RectangleKit(680,300));
            GameInterActiveManager.InstallInterActiveEvent(this._goHomeBtn.m_movie,ActionEvent.ACTION_CLICK,this.onGoHome);
            return;
         }
         GameKernel.gameLayout.InstallUI("GohomeBtn",new RectangleKit(680,300));
         this._goHomeBtn = new HButton(MObject(GameKernel.gameLayout.getInstallUI("GohomeBtn")).getMC());
         GameInterActiveManager.InstallInterActiveEvent(this._goHomeBtn.m_movie,ActionEvent.ACTION_CLICK,this.onGoHome);
      }
      
      public function hideGoHomeBtn() : void
      {
         if(this._goHomeBtn == null)
         {
            return;
         }
         GameKernel.gameLayout.unInstallUI("GohomeBtn");
         GameInterActiveManager.unInstallnterActiveEvent(this._goHomeBtn.m_movie,ActionEvent.ACTION_CLICK,this.onGoHome);
      }
      
      private function onGoHome(param1:MouseEvent) : void
      {
         PlayerInfoUI.getInstance().bindPlayerInfo();
         GalaxyManager.instance.requestGalaxy(GamePlayer.getInstance().galaxyMapID,GamePlayer.getInstance().galaxyID);
         ConstructionAction.getInstance().clearGalaxyMapConstructionList();
         GameStateManager.getInstance().backHome();
         GalaxyManager.instance.goHome();
         GameStateManager.preFriendGuid = GamePlayer.getInstance().Guid;
      }
      
      public function goHome() : void
      {
         ProgressInFriendToolBarWidget.getInstance().RemoveAllIosInFriend();
         if(GalaxyManager.instance.isMineHome())
         {
            if(GameKernel.currentGameStage == GameStageEnum.GAME_STAGE_GALAXY)
            {
               GalaxyManager.instance.goHome();
               ProgressListToolBarWidget.getInstance().HideProgressList();
               return;
            }
            ProgressListToolBarWidget.getInstance().showProgressList();
            return;
         }
         GameStateManager.playerPlace = GamePlaceType.PLACE_HOME;
         PlayerInfoUI.getInstance().bindPlayerInfo();
         FightManager.instance.CleanFight();
         GalaxyManager.instance.requestGalaxy(GamePlayer.getInstance().galaxyMapID,GamePlayer.getInstance().galaxyID);
         GalaxyMapAction.instance.InitCurStar();
         GameStateManager.getInstance().backHome();
         GalaxyManager.instance.goHome();
         switch(GameKernel.currentGameStage)
         {
            case GameStageEnum.GAME_STAGE_STARSURFACE:
               GameMouseZoneManager.gotoStarSurfaceMap();
               break;
            case GameStageEnum.GAME_STAGE_OUTSIDE:
               GameMouseZoneManager.gotoOutSideMap();
               break;
            case GameStageEnum.GAME_STAGE_GALAXY:
         }
         GameStateManager.preFriendGuid = GamePlayer.getInstance().Guid;
         FaceBookAction.getInstance().CurFaceBookFriendInfo = null;
         ConstructionAction.currentProgressIso = null;
      }
      
      public function fetchPlayerPlace(param1:Number) : void
      {
         var _loc2_:FacebookUserInfo = null;
         if(GamePlayer.getInstance().userID == param1)
         {
            GameStateManager.playerPlace = GamePlaceType.PLACE_HOME;
         }
         else
         {
            GameStateManager.playerPlace = GamePlaceType.PLACE_OTHER;
            for each(_loc2_ in GameKernel.facebookFriendList)
            {
               if(_loc2_.uid == param1)
               {
                  GameStateManager.playerPlace = GamePlaceType.PLACE_FRIENDHOME;
                  return;
               }
            }
         }
      }
   }
}

