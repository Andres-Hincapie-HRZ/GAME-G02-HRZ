package net.router
{
   import com.star.frameworks.managers.StringManager;
   import com.star.frameworks.utils.HashSet;
   import flash.utils.ByteArray;
   import logic.action.ConstructionAction;
   import logic.entry.EquimentTypeEnum;
   import logic.entry.GamePlayer;
   import logic.entry.shipmodel.CreateshipInfo;
   import logic.entry.shipmodel.ShipbodyInfo;
   import logic.entry.shipmodel.ShipmodelInfo;
   import logic.entry.shipmodel.ShippartInfo;
   import logic.game.ConstructionAnimationManager;
   import logic.reader.CShipmodelReader;
   import logic.ui.MessagePopup;
   import logic.ui.ShipmodelUI;
   import net.base.NetManager;
   import net.msg.shipmodelMsg.*;
   
   public class ShipmodelRouter
   {
      
      private static var _instance:ShipmodelRouter = null;
      
      public var m_IfbeingCreate:Boolean;
      
      public var m_ShipmodelInfoAry:Array = new Array();
      
      public var m_ZoonShipmodelInfoAry:Array = new Array();
      
      public var m_CancelIndexId:int;
      
      public var m_CompleteIndexId:int;
      
      public var m_CreateShipAry:Array = new Array();
      
      public var Issend:int = 0;
      
      public var m_SpeedShipIndexId:int;
      
      public var m_RemainTime:int;
      
      public var m_IncShipPercent:int;
      
      public var m_MaxCreateShipNum:int;
      
      public var ShipBodyIds:Array = new Array();
      
      public var ShipPartIds:Array = new Array();
      
      public var ShipModeList:HashSet = new HashSet();
      
      public var OnAddShipModel:Function;
      
      public function ShipmodelRouter()
      {
         super();
      }
      
      public static function get instance() : ShipmodelRouter
      {
         if(_instance == null)
         {
            _instance = new ShipmodelRouter();
         }
         return _instance;
      }
      
      public function resp_MSG_RESP_SHIPMODELINFO(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc5_:int = 0;
         var _loc7_:MSG_RESP_SHIPMODELINFO_TEMP = null;
         var _loc8_:ShipmodelInfo = null;
         var _loc9_:ShipmodelInfo = null;
         var _loc10_:int = 0;
         var _loc4_:MSG_RESP_SHIPMODELINFO = new MSG_RESP_SHIPMODELINFO();
         NetManager.Instance().readObject(_loc4_,param3);
         var _loc6_:int = 0;
         while(_loc6_ < _loc4_.DataLen)
         {
            _loc7_ = _loc4_.Data[_loc6_] as MSG_RESP_SHIPMODELINFO_TEMP;
            _loc8_ = new ShipmodelInfo();
            _loc9_ = new ShipmodelInfo();
            _loc8_.m_ShipModelId = _loc7_.ShipModelId;
            _loc8_.m_ShipName = _loc7_.ShipName;
            _loc8_.m_BodyId = _loc7_.BodyId;
            _loc8_.m_PartNum = _loc7_.PartNum;
            _loc8_.m_PubFlag = _loc7_.PubFlag;
            _loc8_.m_IsShow = 1;
            _loc10_ = 0;
            while(_loc10_ < _loc7_.PartNum)
            {
               _loc8_.m_PartId[_loc10_] = _loc7_.PartId[_loc10_];
               _loc10_++;
            }
            _loc5_ = 0;
            while(_loc5_ < this.m_ZoonShipmodelInfoAry.length)
            {
               _loc9_ = this.m_ZoonShipmodelInfoAry[_loc5_];
               if(_loc9_.m_ShipModelId == _loc8_.m_ShipModelId)
               {
                  this.m_ZoonShipmodelInfoAry[_loc5_] = _loc8_;
                  break;
               }
               _loc5_++;
            }
            if(_loc5_ == this.m_ZoonShipmodelInfoAry.length)
            {
               this.m_ZoonShipmodelInfoAry.push(_loc8_);
            }
            this.ShipModeList.Put(_loc8_.m_ShipModelId,_loc8_);
            _loc6_++;
         }
      }
      
      public function resp_MSG_RESP_SHIPMODELINFODEL(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc5_:int = 0;
         var _loc8_:MSG_RESP_SHIPMODELINFO_TEMP = null;
         var _loc9_:ShipmodelInfo = null;
         var _loc10_:ShipmodelInfo = null;
         var _loc11_:int = 0;
         var _loc4_:MSG_RESP_SHIPMODELINFODEL = new MSG_RESP_SHIPMODELINFODEL();
         NetManager.Instance().readObject(_loc4_,param3);
         var _loc6_:int = 0;
         while(_loc6_ < _loc4_.DataLen)
         {
            _loc8_ = _loc4_.Data[_loc6_] as MSG_RESP_SHIPMODELINFO_TEMP;
            _loc9_ = new ShipmodelInfo();
            _loc10_ = new ShipmodelInfo();
            _loc9_.m_ShipModelId = _loc8_.ShipModelId;
            _loc9_.m_ShipName = _loc8_.ShipName;
            _loc9_.m_BodyId = _loc8_.BodyId;
            _loc9_.m_PartNum = _loc8_.PartNum;
            _loc9_.m_PubFlag = _loc8_.PubFlag;
            _loc9_.m_IsShow = 0;
            _loc11_ = 0;
            while(_loc11_ < _loc8_.PartNum)
            {
               _loc9_.m_PartId[_loc11_] = _loc8_.PartId[_loc11_];
               _loc11_++;
            }
            _loc5_ = 0;
            while(_loc5_ < this.m_ZoonShipmodelInfoAry.length)
            {
               _loc10_ = this.m_ZoonShipmodelInfoAry[_loc5_];
               if(_loc10_.m_ShipModelId == _loc9_.m_ShipModelId)
               {
                  this.m_ZoonShipmodelInfoAry[_loc5_] = _loc9_;
                  break;
               }
               _loc5_++;
            }
            if(_loc5_ == this.m_ZoonShipmodelInfoAry.length)
            {
               this.m_ZoonShipmodelInfoAry.push(_loc9_);
            }
            this.ShipModeList.Put(_loc9_.m_ShipModelId,_loc9_);
            _loc6_++;
         }
         this.m_ShipmodelInfoAry.length = 0;
         var _loc7_:int = 0;
         while(_loc7_ < this.m_ZoonShipmodelInfoAry.length)
         {
            if(this.m_ZoonShipmodelInfoAry[_loc7_].m_IsShow == 1)
            {
               this.m_ShipmodelInfoAry.push(this.m_ZoonShipmodelInfoAry[_loc7_]);
            }
            _loc7_++;
         }
         if(this.OnAddShipModel != null)
         {
            this.OnAddShipModel();
         }
      }
      
      public function resp_MSG_RESP_CREATESHIP(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_CREATESHIP = new MSG_RESP_CREATESHIP();
         NetManager.Instance().readObject(_loc4_,param3);
         ConstructionAction.getInstance().costResource(_loc4_.Gas,_loc4_.Metal,_loc4_.Money,0);
         var _loc5_:int = 0;
         while(_loc5_ < this.m_CreateShipAry.length)
         {
            if(_loc4_.ShipModelId == this.m_CreateShipAry[_loc5_].ShipModelId)
            {
               if(--this.m_CreateShipAry[_loc5_].Num == 0)
               {
                  this.m_CreateShipAry.splice(_loc5_,1);
               }
            }
            _loc5_++;
         }
      }
      
      public function resp_MSG_RESP_CANCELSHIP(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_CANCELSHIP = new MSG_RESP_CANCELSHIP();
         NetManager.Instance().readObject(_loc4_,param3);
         if(_loc4_.Status == 1)
         {
            this.m_CancelIndexId = _loc4_.IndexId;
            this.m_CreateShipAry.splice(this.m_CancelIndexId,1);
            this.m_MaxCreateShipNum += _loc4_.Num;
            ShipmodelUI.getInstance().m_LRbeingPageNumber = 0;
            ShipmodelUI.getInstance().beingstorage();
            if(this.m_CreateShipAry.length > 0)
            {
               GamePlayer.getInstance().m_IfbeingCreatShip = true;
               ConstructionAnimationManager.PlayConstuctionByBuildingID(EquimentTypeEnum.EQUIMENT_TYPE_SHIPBUILDING);
            }
            else
            {
               GamePlayer.getInstance().m_IfbeingCreatShip = false;
               ConstructionAnimationManager.StopConstructionByBuildingID(EquimentTypeEnum.EQUIMENT_TYPE_SHIPBUILDING);
            }
         }
         else
         {
            ShipmodelUI.getInstance().ErrorCancel();
         }
      }
      
      public function resp_MSG_RESP_CREATESHIPINFO(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc6_:MSG_RESP_CREATESHIPINFO_TEMP = null;
         var _loc7_:CreateshipInfo = null;
         this.Issend = 1;
         var _loc4_:MSG_RESP_CREATESHIPINFO = new MSG_RESP_CREATESHIPINFO();
         NetManager.Instance().readObject(_loc4_,param3);
         this.m_IncShipPercent = _loc4_.IncShipPercent;
         this.m_MaxCreateShipNum = _loc4_.MaxCreateShipNum;
         this.m_CreateShipAry.length = 0;
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_.DataLen)
         {
            _loc6_ = _loc4_.Data[_loc5_] as MSG_RESP_CREATESHIPINFO_TEMP;
            _loc7_ = new CreateshipInfo();
            _loc7_.ShipModelId = _loc6_.ShipModelId;
            _loc7_.NeedTime = _loc6_.NeedTime;
            _loc7_.Num = _loc6_.Num;
            _loc7_.IncSpeed = _loc6_.IncSpeed;
            this.m_CreateShipAry[_loc5_] = _loc7_;
            _loc5_++;
         }
         if(this.m_CreateShipAry.length > 0)
         {
            GamePlayer.getInstance().m_IfbeingCreatShip = true;
            ConstructionAnimationManager.PlayConstuctionByBuildingID(EquimentTypeEnum.EQUIMENT_TYPE_SHIPBUILDING);
         }
         else
         {
            GamePlayer.getInstance().m_IfbeingCreatShip = false;
            ConstructionAnimationManager.StopConstructionByBuildingID(EquimentTypeEnum.EQUIMENT_TYPE_SHIPBUILDING);
         }
         if(ShipmodelUI.getInstance().m_ifopen == 1)
         {
            ShipmodelUI.getInstance().beingstorage();
         }
      }
      
      public function resp_MSG_RESP_SHIPCREATINGCOMPLETE(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_SHIPCREATINGCOMPLETE = new MSG_RESP_SHIPCREATINGCOMPLETE();
         NetManager.Instance().readObject(_loc4_,param3);
         this.m_CompleteIndexId = _loc4_.IndexId;
         if(this.m_CreateShipAry[this.m_CompleteIndexId] == null)
         {
            return;
         }
         if(ShipmodelUI.getInstance().m_Isopen == 1 && this.m_CreateShipAry[this.m_CompleteIndexId] != null)
         {
            if(this.m_CreateShipAry[this.m_CompleteIndexId].Num > 1)
            {
               --this.m_CreateShipAry[this.m_CompleteIndexId].Num;
            }
            else
            {
               this.m_CreateShipAry.splice(this.m_CompleteIndexId,1);
            }
            if(this.m_CreateShipAry.length > 0)
            {
               GamePlayer.getInstance().m_IfbeingCreatShip = true;
               ConstructionAnimationManager.PlayConstuctionByBuildingID(EquimentTypeEnum.EQUIMENT_TYPE_SHIPBUILDING);
            }
            else
            {
               GamePlayer.getInstance().m_IfbeingCreatShip = false;
               ConstructionAnimationManager.StopConstructionByBuildingID(EquimentTypeEnum.EQUIMENT_TYPE_SHIPBUILDING);
            }
            if(ShipmodelUI.getInstance().IsSpeedOver == true)
            {
               ShipmodelUI.getInstance().IsSpeedOver = false;
               ShipmodelUI.getInstance().reMoverText();
            }
            ShipmodelUI.getInstance().beingstorage();
         }
      }
      
      public function sendmsgCREATESHIP(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:MSG_REQUEST_CREATESHIP = new MSG_REQUEST_CREATESHIP();
         _loc4_.SeqId = GamePlayer.getInstance().seqID++;
         _loc4_.Guid = GamePlayer.getInstance().Guid;
         _loc4_.ShipModelId = param1;
         _loc4_.Num = param2;
         _loc4_.Type = param3;
         NetManager.Instance().sendObject(_loc4_);
      }
      
      public function sendmsgCANCELSHIP(param1:int) : void
      {
         var _loc2_:MSG_REQUEST_CANCELSHIP = new MSG_REQUEST_CANCELSHIP();
         _loc2_.SeqId = GamePlayer.getInstance().seqID++;
         _loc2_.Guid = GamePlayer.getInstance().Guid;
         _loc2_.IndexId = param1;
         NetManager.Instance().sendObject(_loc2_);
      }
      
      public function sendmsgCREATESHIPINFO() : void
      {
         var _loc1_:MSG_REQUEST_CREATESHIPINFO = new MSG_REQUEST_CREATESHIPINFO();
         _loc1_.SeqId = GamePlayer.getInstance().seqID++;
         _loc1_.Guid = GamePlayer.getInstance().Guid;
         NetManager.Instance().sendObject(_loc1_);
      }
      
      public function sendmsgDELETESHIPMODEL(param1:int) : void
      {
         var _loc2_:MSG_REQUEST_DELETESHIPMODEL = new MSG_REQUEST_DELETESHIPMODEL();
         _loc2_.SeqId = GamePlayer.getInstance().seqID++;
         _loc2_.Guid = GamePlayer.getInstance().Guid;
         _loc2_.ShipModelId = param1;
         NetManager.Instance().sendObject(_loc2_);
      }
      
      public function sendmsgSPEEDSHIP(param1:int) : void
      {
         var _loc2_:MSG_REQUEST_SPEEDSHIP = new MSG_REQUEST_SPEEDSHIP();
         _loc2_.SeqId = GamePlayer.getInstance().seqID++;
         _loc2_.Guid = GamePlayer.getInstance().Guid;
         _loc2_.IndexId = param1;
         NetManager.Instance().sendObject(_loc2_);
      }
      
      public function resp_MSG_RESP_SPEEDSHIP(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_SPEEDSHIP = new MSG_RESP_SPEEDSHIP();
         NetManager.Instance().readObject(_loc4_,param3);
         if(_loc4_.ErrorCode == 0)
         {
            this.m_SpeedShipIndexId = _loc4_.IndexId;
            this.m_RemainTime = _loc4_.SpareTime;
            this.m_CreateShipAry[_loc4_.IndexId].NeedTime = _loc4_.SpareTime;
            ShipmodelUI.getInstance().showbeing();
            ConstructionAction.getInstance().costResource(0,0,0,GamePlayer.getInstance().ShipSpeedCredit);
         }
      }
      
      public function resp_MSG_RESP_SHIPBODYINFO(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_SHIPBODYINFO = new MSG_RESP_SHIPBODYINFO();
         NetManager.Instance().readObject(_loc4_,param3);
         this.ShipBodyIds.length = 0;
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_.BodyNum)
         {
            this.ShipBodyIds.push(_loc4_.BodyId[_loc5_]);
            _loc5_++;
         }
         this.ShipPartIds.length = 0;
         var _loc6_:int = 0;
         while(_loc6_ < _loc4_.PartNum)
         {
            this.ShipPartIds.push(_loc4_.PartId[_loc6_]);
            _loc6_++;
         }
         _loc4_.release();
         _loc4_ = null;
      }
      
      public function resp_MSG_RESP_CREATESHIPMODEL(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_CREATESHIPMODEL = new MSG_RESP_CREATESHIPMODEL();
         NetManager.Instance().readObject(_loc4_,param3);
         var _loc5_:ShipmodelInfo = new ShipmodelInfo();
         _loc5_.m_ShipModelId = _loc4_.ShipModelId;
         _loc5_.m_BodyId = _loc4_.BodyId;
         _loc5_.m_PartNum = _loc4_.PartNum;
         _loc5_.m_ShipName = _loc4_.ShipName;
         _loc5_.m_IsShow = 1;
         var _loc6_:int = 0;
         while(_loc6_ < _loc4_.PartNum)
         {
            _loc5_.m_PartId[_loc6_] = _loc4_.PartId[_loc6_];
            _loc6_++;
         }
         this.m_ShipmodelInfoAry.push(_loc5_);
         this.m_ZoonShipmodelInfoAry.push(_loc5_);
         this.ShipModeList.Put(_loc5_.m_ShipModelId,_loc5_);
         ConstructionAction.getInstance().costResource(0,0,_loc4_.NeedMoney,0);
         MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("DesignText15"),0);
      }
      
      public function ExistsBody(param1:int) : Boolean
      {
         var _loc3_:int = 0;
         var _loc4_:ShipbodyInfo = null;
         var _loc2_:ShipbodyInfo = CShipmodelReader.getInstance().getShipBodyInfo(param1);
         if(_loc2_ == null)
         {
            return true;
         }
         for each(_loc3_ in this.ShipBodyIds)
         {
            if(_loc3_ == param1)
            {
               return true;
            }
            _loc4_ = CShipmodelReader.getInstance().getShipBodyInfo(_loc3_);
            if(_loc4_.KindId == _loc2_.KindId && _loc4_.GroupID == _loc2_.GroupID && _loc4_.GroupLV > _loc2_.GroupLV)
            {
               return true;
            }
         }
         return false;
      }
      
      public function ExistsPart(param1:int) : Boolean
      {
         var _loc3_:int = 0;
         var _loc4_:ShippartInfo = null;
         var _loc2_:ShippartInfo = CShipmodelReader.getInstance().getShipPartInfo(param1);
         if(_loc2_ == null)
         {
            return true;
         }
         for each(_loc3_ in this.ShipPartIds)
         {
            if(_loc3_ == param1)
            {
               return true;
            }
            _loc4_ = CShipmodelReader.getInstance().getShipPartInfo(_loc3_);
            if(_loc4_.KindId == _loc2_.KindId && _loc4_.GroupID == _loc2_.GroupID && _loc4_.GroupLV > _loc2_.GroupLV)
            {
               return true;
            }
         }
         return false;
      }
      
      public function AddBodyPart(param1:int, param2:int) : void
      {
         if(param1 >= 0)
         {
            this.AddBodyId(param1);
         }
         else
         {
            this.AddPartId(param2);
         }
      }
      
      private function AddBodyId(param1:int) : void
      {
         if(this.ExistsBody(param1))
         {
            return;
         }
         this.ShipBodyIds.push(param1);
      }
      
      private function AddPartId(param1:int) : void
      {
         if(this.ExistsPart(param1))
         {
            return;
         }
         this.ShipPartIds.push(param1);
      }
      
      public function GetShipModelByName(param1:String) : ShipmodelInfo
      {
         var _loc3_:ShipmodelInfo = null;
         var _loc2_:int = 0;
         while(_loc2_ < this.m_ShipmodelInfoAry.length)
         {
            _loc3_ = this.m_ShipmodelInfoAry[_loc2_];
            if(_loc3_.m_ShipName == param1)
            {
               return _loc3_;
            }
            _loc2_++;
         }
         return null;
      }
   }
}

