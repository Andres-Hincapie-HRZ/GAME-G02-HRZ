package net.router
{
   import com.star.frameworks.managers.StringManager;
   import flash.utils.ByteArray;
   import logic.action.ActionModuleDefined;
   import logic.action.ConstructionAction;
   import logic.entry.GamePlayer;
   import logic.manager.GalaxyManager;
   import logic.manager.GameModuleActionManager;
   import logic.ui.MessagePopup;
   import net.base.NetManager;
   import net.msg.MSG_RESP_EXCHANGERES;
   import net.msg.MSG_RESP_GETSTORAGERESOURCE;
   import net.msg.constructionMsg.MSG_RESP_BUILDCOMPLETE;
   import net.msg.constructionMsg.MSG_RESP_BUILDINFO;
   import net.msg.constructionMsg.MSG_RESP_BUILDINFOFRIEND;
   import net.msg.constructionMsg.MSG_RESP_BUILDINGDEATHCOMPLETE;
   import net.msg.constructionMsg.MSG_RESP_CANCELBUILD;
   import net.msg.constructionMsg.MSG_RESP_CONSORTIABUILDING;
   import net.msg.constructionMsg.MSG_RESP_CONSORTIAWEALTH;
   import net.msg.constructionMsg.MSG_RESP_CREATEBUILD;
   import net.msg.constructionMsg.MSG_RESP_CREATEBUILDINFO;
   import net.msg.constructionMsg.MSG_RESP_DELETEBUILD;
   import net.msg.constructionMsg.MSG_RESP_MOVEBUILD;
   import net.msg.constructionMsg.MSG_RESP_SPEEDBUILDING;
   import net.msg.constructionMsg.MSG_RESP_SPEEDFRIENDBUILDING;
   import net.msg.constructionMsg.MSG_RESP_STORAGERESOURCE;
   import net.msg.constructionMsg.MSG_RESP_TIMEQUEUE;
   
   public class ConstructionRouter
   {
      
      private static var instance:ConstructionRouter;
      
      public function ConstructionRouter()
      {
         super();
      }
      
      public static function getInstance() : ConstructionRouter
      {
         if(instance == null)
         {
            instance = new ConstructionRouter();
         }
         return instance;
      }
      
      public function resp_Msg_BuildInfo(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_BUILDINFO = new MSG_RESP_BUILDINFO();
         NetManager.Instance().readObject(_loc4_,param3);
         if(_loc4_.GalaxyMapId != 0 || _loc4_.GalaxyId == GamePlayer.getInstance().galaxyID || GalaxyManager.instance.LastRequestGalaxyId == _loc4_.GalaxyId)
         {
            ConstructionAction(GameModuleActionManager.getModuleInstance(ActionModuleDefined.Construction_action)).Msg_Resp_BuildingInfo(_loc4_);
         }
      }
      
      public function resp_Msg_CreateBuild(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_CREATEBUILD = new MSG_RESP_CREATEBUILD();
         NetManager.Instance().readData(_loc4_,param3);
         ConstructionAction(GameModuleActionManager.getModuleInstance(ActionModuleDefined.Construction_action)).respCreateBuild(_loc4_);
      }
      
      public function resp_Msg_BuildCompleted(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_BUILDCOMPLETE = new MSG_RESP_BUILDCOMPLETE();
         NetManager.Instance().readData(_loc4_,param3);
         ConstructionAction(GameModuleActionManager.getModuleInstance(ActionModuleDefined.Construction_action)).respBuildingCompleted(_loc4_);
      }
      
      public function resp_Msg_CancelBuilding(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_CANCELBUILD = new MSG_RESP_CANCELBUILD();
         NetManager.Instance().readObject(_loc4_,param3);
         ConstructionAction(GameModuleActionManager.getModuleInstance(ActionModuleDefined.Construction_action)).respCancelBuilding(_loc4_);
      }
      
      public function resp_Msg_DeleteBuilding(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_DELETEBUILD = new MSG_RESP_DELETEBUILD();
         NetManager.Instance().readObject(_loc4_,param3);
         ConstructionAction(GameModuleActionManager.getModuleInstance(ActionModuleDefined.Construction_action)).respDeleteBuild(_loc4_);
      }
      
      public function resp_Msg_MoveBuilding(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_MOVEBUILD = new MSG_RESP_MOVEBUILD();
         NetManager.Instance().readObject(_loc4_,param3);
         ConstructionAction(GameModuleActionManager.getModuleInstance(ActionModuleDefined.Construction_action)).respMoveBuilding(_loc4_);
      }
      
      public function resp_MSG_STORAGERESOURCE(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_STORAGERESOURCE = new MSG_RESP_STORAGERESOURCE();
         NetManager.Instance().readObject(_loc4_,param3);
         ConstructionAction(GameModuleActionManager.getModuleInstance(ActionModuleDefined.Construction_action)).respStorageResource(_loc4_);
      }
      
      public function resp_MSG_GETSTORAGERESOURCE(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_GETSTORAGERESOURCE = new MSG_RESP_GETSTORAGERESOURCE();
         NetManager.Instance().readObject(_loc4_,param3);
         ConstructionAction(GameModuleActionManager.getModuleInstance(ActionModuleDefined.Construction_action)).respGetStorageResource(_loc4_);
      }
      
      public function resp_MSG_BUILDINGDEATHCOMPLETE(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_BUILDINGDEATHCOMPLETE = new MSG_RESP_BUILDINGDEATHCOMPLETE();
         NetManager.Instance().readObject(_loc4_,param3);
         ConstructionAction(GameModuleActionManager.getModuleInstance(ActionModuleDefined.Construction_action)).respBuildingDeathCompleted(_loc4_);
      }
      
      public function resp_MSG_RESP_SPEEDBUILDING(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_SPEEDBUILDING = new MSG_RESP_SPEEDBUILDING();
         NetManager.Instance().readObject(_loc4_,param3);
         ConstructionAction(GameModuleActionManager.getModuleInstance(ActionModuleDefined.Construction_action)).respBuildingSpeed(_loc4_);
      }
      
      public function resp_MSG_RESP_TIMEQUEUE(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_TIMEQUEUE = new MSG_RESP_TIMEQUEUE();
         NetManager.Instance().readObject(_loc4_,param3);
         ConstructionAction(GameModuleActionManager.getModuleInstance(ActionModuleDefined.Construction_action)).respTimeQueue(_loc4_);
      }
      
      public function resp_MSG_RESP_CONSORTIAWEALTH(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_CONSORTIAWEALTH = new MSG_RESP_CONSORTIAWEALTH();
         NetManager.Instance().readObject(_loc4_,param3);
         ConstructionAction(GameModuleActionManager.getModuleInstance(ActionModuleDefined.Construction_action)).respBuildingConsortiWealth(_loc4_);
      }
      
      public function resp_MSG_RESP_CONSORTIABUILDING(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_CONSORTIABUILDING = new MSG_RESP_CONSORTIABUILDING();
         NetManager.Instance().readObject(_loc4_,param3);
         ConstructionAction(GameModuleActionManager.getModuleInstance(ActionModuleDefined.Construction_action)).respConsortBuilding(_loc4_);
      }
      
      public function resp_MSG_RESP_SPEEDFRIENDBUILDING(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_SPEEDFRIENDBUILDING = new MSG_RESP_SPEEDFRIENDBUILDING();
         NetManager.Instance().readObject(_loc4_,param3);
         ConstructionAction(GameModuleActionManager.getModuleInstance(ActionModuleDefined.Construction_action)).respSpeedBuildInFriend(_loc4_);
      }
      
      public function resp_MSG_RESP_CREATEBUILDINFO(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_CREATEBUILDINFO = new MSG_RESP_CREATEBUILDINFO();
         NetManager.Instance().readObject(_loc4_,param3);
         ConstructionAction(GameModuleActionManager.getModuleInstance(ActionModuleDefined.Construction_action)).respCreateBuildInfo(_loc4_);
      }
      
      public function resp_MSG_RESP_BUILDINFOFRIEND(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_BUILDINFOFRIEND = new MSG_RESP_BUILDINFOFRIEND();
         NetManager.Instance().readObject(_loc4_,param3);
         ConstructionAction(GameModuleActionManager.getModuleInstance(ActionModuleDefined.Construction_action)).respBuildInfoFriend(_loc4_);
      }
      
      public function resp_MSG_RESP_EXCHANGERES(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_EXCHANGERES = new MSG_RESP_EXCHANGERES();
         NetManager.Instance().readObject(_loc4_,param3);
         ConstructionAction.getInstance().addResource(_loc4_.Gas,_loc4_.Metal,0,0);
         MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("Boss22"),0);
      }
   }
}

