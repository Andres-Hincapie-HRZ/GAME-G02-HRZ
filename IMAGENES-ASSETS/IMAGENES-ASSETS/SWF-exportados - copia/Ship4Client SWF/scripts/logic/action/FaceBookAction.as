package logic.action
{
   import flash.geom.Point;
   import logic.entry.GStar;
   import logic.entry.GamePlayer;
   import logic.game.GameMouseZoneManager;
   import logic.game.GameStateManager;
   import logic.manager.GalaxyManager;
   import logic.manager.GalaxyShipManager;
   import logic.ui.GotoGalaxyUI;
   import logic.ui.PlayerInfoPopUp;
   import logic.ui.PlayerInfoUI;
   import net.base.NetManager;
   import net.msg.facebook.MSG_REQUEST_FRIENDINFO;
   import net.msg.facebook.MSG_RESP_FRIENDINFO;
   
   public class FaceBookAction
   {
      
      private static var instance:FaceBookAction;
      
      private var curFaceBookFriend:MSG_RESP_FRIENDINFO;
      
      private var isFight:int;
      
      private var camp:int;
      
      private var _UserName:String;
      
      public function FaceBookAction()
      {
         super();
      }
      
      public static function getInstance() : FaceBookAction
      {
         if(instance == null)
         {
            instance = new FaceBookAction();
         }
         return instance;
      }
      
      public function get CurFaceBookFriendInfo() : MSG_RESP_FRIENDINFO
      {
         return this.curFaceBookFriend;
      }
      
      public function set CurFaceBookFriendInfo(param1:MSG_RESP_FRIENDINFO) : void
      {
         this.curFaceBookFriend = param1;
      }
      
      public function request_Msg_FaceBookInfo(param1:Number, param2:String) : void
      {
         this._UserName = param2;
         var _loc3_:MSG_REQUEST_FRIENDINFO = new MSG_REQUEST_FRIENDINFO();
         _loc3_.SeqId = GamePlayer.getInstance().seqID++;
         _loc3_.Guid = GamePlayer.getInstance().Guid;
         _loc3_.ObjUserId = param1;
         _loc3_.ObjGuid = -1;
         NetManager.Instance().sendObject(_loc3_);
      }
      
      public function resp_Msg_FaceBookInfo(param1:MSG_RESP_FRIENDINFO) : void
      {
         if(this.curFaceBookFriend != null)
         {
            this.curFaceBookFriend = null;
         }
         this.curFaceBookFriend = param1;
         var _loc2_:int = param1.Exp;
         var _loc3_:int = param1.LevelId;
         var _loc4_:int = param1.GalaxyId;
         var _loc5_:int = param1.GalaxyMapId;
         var _loc6_:int = param1.ObjGuid;
         var _loc7_:Number = param1.ObjUserId;
         var _loc8_:int = param1.StarType;
         this.isFight = param1.FightFlag;
         var _loc9_:GStar = new GStar(param1.GalaxyId,param1.StarType);
         _loc9_.GalaxyMapId = param1.GalaxyMapId;
         _loc9_.Level = param1.LevelId;
         _loc9_.FightFlag = param1.FightFlag;
         GalaxyMapAction.instance.curStar = _loc9_;
         GalaxyManager.instance.enterStar = _loc9_;
         this.loadFriendLogic();
      }
      
      public function loadFriendLogic() : void
      {
         var _loc1_:Point = null;
         PlayerInfoUI.getInstance().bindFriendInfo(this.curFaceBookFriend,this._UserName);
         if(!PlayerInfoPopUp.isEnterState)
         {
            ConstructionAction.getInstance().clearGalaxyMapConstructionList();
            GalaxyShipManager.instance.releaseShipTeam();
            GalaxyManager.instance.requestGalaxy(this.curFaceBookFriend.GalaxyMapId,this.curFaceBookFriend.GalaxyId);
            _loc1_ = GalaxyManager.getStarCoordinate(this.curFaceBookFriend.GalaxyId);
            GotoGalaxyUI.instance.GotoGalaxy(_loc1_.x,_loc1_.y);
         }
         _loc1_ = GalaxyManager.getStarCoordinate(this.curFaceBookFriend.GalaxyId);
         GalaxyManager.instance.printCacheStar(_loc1_.x,_loc1_.y);
         GalaxyManager.instance.gotoGalaxyMap();
         if(this.isFight == 0)
         {
            GameStateManager.getInstance().viewFaceBookFriend();
         }
         else
         {
            GameMouseZoneManager.gotoOutSideMap();
         }
         PlayerInfoPopUp.isEnterState = false;
      }
   }
}

