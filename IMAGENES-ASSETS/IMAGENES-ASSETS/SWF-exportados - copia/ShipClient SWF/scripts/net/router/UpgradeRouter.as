package net.router
{
   import flash.utils.ByteArray;
   import logic.action.ConstructionAction;
   import logic.entry.EquimentTypeEnum;
   import logic.entry.GamePlayer;
   import logic.game.ConstructionAnimationManager;
   import logic.game.GameMouseZoneManager;
   import logic.ui.GameDateTaskUI;
   import logic.ui.UpgradeUI;
   import net.base.NetManager;
   import net.msg.FlagShip.MSG_RESP_UPGRADEFLAGSHIP;
   import net.msg.FlagShip.MSG_RESP_UPGRADESHIPPROPS;
   import net.msg.upgrade.MSG_RESP_SHIPBODYUPGRADE;
   import net.msg.upgrade.MSG_RESP_SHIPBODYUPGRADECOMPLETE;
   import net.msg.upgrade.MSG_RESP_SHIPBODYUPGRADEINFO;
   import net.msg.upgrade.MSG_RESP_SPEEDSHIPBODYUPGRADE;
   
   public class UpgradeRouter
   {
      
      private static var _instance:UpgradeRouter;
      
      private var UpgradeInfoList:Array = new Array();
      
      public var CurUpgradeBodyId:int;
      
      public var CurUpgradeBodyNeedTime:int;
      
      public var CurUpgradePartId:int;
      
      public var CurUpgradePartNeedTime:int;
      
      public var IncUpgradePercent:Number;
      
      public var GetUpgradeInfoCallback:Function;
      
      public function UpgradeRouter()
      {
         super();
         this.CurUpgradeBodyId = -1;
         this.CurUpgradePartId = -1;
      }
      
      public static function get instance() : UpgradeRouter
      {
         if(_instance == null)
         {
            _instance = new UpgradeRouter();
         }
         return _instance;
      }
      
      public function resp_MSG_RESP_SHIPBODYUPGRADE(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_SHIPBODYUPGRADE = new MSG_RESP_SHIPBODYUPGRADE();
         NetManager.Instance().readObject(_loc4_,param3);
         if(_loc4_.CancelFlag == 0)
         {
            if(_loc4_.Type == 0)
            {
               this.CurUpgradeBodyId = _loc4_.BodyPartId;
               this.CurUpgradeBodyNeedTime = _loc4_.NeedTime;
            }
            else
            {
               this.CurUpgradePartId = _loc4_.BodyPartId;
               this.CurUpgradePartNeedTime = _loc4_.NeedTime;
            }
            UpgradeUI.getInstance().ShowUpgradeInfo(_loc4_);
         }
         else
         {
            if(_loc4_.Type == 0)
            {
               this.CurUpgradeBodyId = -1;
               this.CurUpgradeBodyNeedTime = _loc4_.NeedTime;
            }
            else
            {
               this.CurUpgradePartId = -1;
               this.CurUpgradePartNeedTime = _loc4_.NeedTime;
            }
            UpgradeUI.getInstance().CancelUpgrade(_loc4_);
            if(this.GetUpgradeInfoCallback != null)
            {
               this.GetUpgradeInfoCallback();
            }
         }
         this.ResetEquipment();
      }
      
      public function resp_MSG_RESP_SHIPBODYUPGRADEINFO(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_SHIPBODYUPGRADEINFO = new MSG_RESP_SHIPBODYUPGRADEINFO();
         NetManager.Instance().readObject(_loc4_,param3);
         this.IncUpgradePercent = 1 + _loc4_.IncUpgradePercent / 100;
         if(_loc4_.BodyNum > 0)
         {
            this.CurUpgradeBodyId = _loc4_.BodyId[0].BodyPartId;
            this.CurUpgradeBodyNeedTime = _loc4_.BodyId[0].NeedTime;
         }
         else
         {
            this.CurUpgradeBodyId = -1;
         }
         if(_loc4_.PartNum > 0)
         {
            this.CurUpgradePartId = _loc4_.PartId[0].BodyPartId;
            this.CurUpgradePartNeedTime = _loc4_.PartId[0].NeedTime;
         }
         else
         {
            this.CurUpgradePartId = -1;
         }
         UpgradeUI.getInstance().ShowUpgradeInfo(null);
         this.ResetEquipment();
         if(!GameMouseZoneManager.isEnterSearch)
         {
            GameDateTaskUI.GetInstance().Init();
         }
         else if(this.GetUpgradeInfoCallback != null)
         {
            this.GetUpgradeInfoCallback();
         }
      }
      
      public function resp_MSG_RESP_SHIPBODYUPGRADECOMPLETE(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_SHIPBODYUPGRADECOMPLETE = new MSG_RESP_SHIPBODYUPGRADECOMPLETE();
         NetManager.Instance().readObject(_loc4_,param3);
         if(_loc4_.Type == 0)
         {
            this.CurUpgradeBodyId = -1;
         }
         else
         {
            this.CurUpgradePartId = -1;
         }
         UpgradeUI.getInstance().UpgradeOver(_loc4_.Type,_loc4_.BodyPartId);
         this.ResetEquipment();
         if(this.GetUpgradeInfoCallback != null)
         {
            this.GetUpgradeInfoCallback();
         }
      }
      
      public function resp_MSG_RESP_SPEEDSHIPBODYUPGRADE(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_SPEEDSHIPBODYUPGRADE = new MSG_RESP_SPEEDSHIPBODYUPGRADE();
         NetManager.Instance().readObject(_loc4_,param3);
         if(_loc4_.Type == 0 && this.CurUpgradeBodyId == _loc4_.BodyPartId)
         {
            this.CurUpgradeBodyId = _loc4_.BodyPartId;
            this.CurUpgradeBodyNeedTime = _loc4_.SpareTime;
         }
         else if(this.CurUpgradePartId == _loc4_.BodyPartId)
         {
            this.CurUpgradePartId = _loc4_.BodyPartId;
            this.CurUpgradePartNeedTime = _loc4_.SpareTime;
         }
         if(_loc4_.FeeType == 0)
         {
            ConstructionAction.getInstance().costResource(0,0,0,_loc4_.Credit);
         }
         else
         {
            GamePlayer.getInstance().coins = GamePlayer.getInstance().coins - _loc4_.Credit;
         }
         UpgradeUI.getInstance().ShowUpgradeInfo(null);
      }
      
      public function Resp_MSG_RESP_UPGRADEFLAGSHIP(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_UPGRADEFLAGSHIP = new MSG_RESP_UPGRADEFLAGSHIP();
         NetManager.Instance().readObject(_loc4_,param3);
         UpgradeUI.getInstance().Resp_MSG_RESP_UPGRADEFLAGSHIP(_loc4_);
      }
      
      public function Resp_MSG_RESP_UPGRADESHIPPROPS(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_UPGRADESHIPPROPS = new MSG_RESP_UPGRADESHIPPROPS();
         NetManager.Instance().readObject(_loc4_,param3);
         UpgradeUI.getInstance().Resp_MSG_RESP_UPGRADESHIPPROPS(_loc4_);
      }
      
      private function ResetEquipment() : void
      {
         if(this.CurUpgradeBodyId != -1 || this.CurUpgradePartId != -1)
         {
            ConstructionAnimationManager.PlayConstuctionByBuildingID(EquimentTypeEnum.EQUIMENT_TYPE_WEAPONRESEARCHCENTER);
         }
         else
         {
            ConstructionAnimationManager.StopConstructionByBuildingID(EquimentTypeEnum.EQUIMENT_TYPE_WEAPONRESEARCHCENTER);
         }
      }
      
      public function IsUpgrading() : Boolean
      {
         return this.CurUpgradeBodyId != -1 || this.CurUpgradePartId != -1;
      }
   }
}

