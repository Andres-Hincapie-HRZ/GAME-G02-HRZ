package net.router
{
   import flash.utils.ByteArray;
   import logic.entry.GamePlayer;
   import logic.entry.Rank.*;
   import logic.ui.RankingSceneUI;
   import net.base.NetManager;
   import net.msg.Rank.*;
   
   public class RankRouter
   {
      
      private static var _instance:RankRouter = null;
      
      public var m_rankuserinfoAry:Array = new Array();
      
      public var m_CorpsRankAry:Array = new Array();
      
      public var m_RankFightAry:Array = new Array();
      
      public var m_pageID:int;
      
      public var m_maxPagenum:int;
      
      public var m_ConsortiaCount:int;
      
      public var m_HoldGalaxyAreaAry:Array = new Array();
      
      public function RankRouter()
      {
         super();
      }
      
      public static function getinstance() : RankRouter
      {
         if(_instance == null)
         {
            _instance = new RankRouter();
         }
         return _instance;
      }
      
      public function resp_MSG_RESP_RANKCENT(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc6_:MSG_RANKUSERINFO = null;
         var _loc7_:RankUserInfo = null;
         var _loc4_:MSG_RESP_RANKCENT = new MSG_RESP_RANKCENT();
         NetManager.Instance().readObject(_loc4_,param3);
         if(_loc4_.PageId == -1)
         {
            RankingSceneUI.getInstance().noFind();
            return;
         }
         this.m_pageID = _loc4_.PageId;
         this.m_maxPagenum = _loc4_.MaxPageId;
         this.m_rankuserinfoAry.splice(0);
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_.DataLen)
         {
            _loc6_ = _loc4_.Data[_loc5_] as MSG_RANKUSERINFO;
            _loc7_ = new RankUserInfo();
            _loc7_.Name = _loc6_.Name;
            _loc7_.ConsortiaName = _loc6_.ConsortiaName;
            _loc7_.UserId = _loc6_.UserId;
            _loc7_.RankId = _loc6_.RankId;
            _loc7_.KillTotal = _loc6_.KillTotal;
            _loc7_.Guid = _loc6_.Guid;
            _loc7_.HeadId = _loc6_.HeadId;
            _loc7_.Level = _loc6_.Level;
            _loc7_.Assault = _loc6_.Assault;
            _loc7_.ConsortiaId = _loc6_.ConsortiaId;
            this.m_rankuserinfoAry.push(_loc7_);
            _loc5_++;
         }
         RankingSceneUI.getInstance().showList();
      }
      
      public function resp_MSG_RESP_RANKKILLTOTAL(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc6_:MSG_RANKUSERINFO = null;
         var _loc7_:RankUserInfo = null;
         var _loc4_:MSG_RESP_RANKKILLTOTAL = new MSG_RESP_RANKKILLTOTAL();
         NetManager.Instance().readObject(_loc4_,param3);
         if(_loc4_.PageId == -1)
         {
            RankingSceneUI.getInstance().noFind();
            return;
         }
         this.m_pageID = _loc4_.PageId;
         this.m_maxPagenum = _loc4_.MaxPageId;
         this.m_rankuserinfoAry.splice(0);
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_.DataLen)
         {
            _loc6_ = _loc4_.Data[_loc5_] as MSG_RANKUSERINFO;
            _loc7_ = new RankUserInfo();
            _loc7_.Name = _loc6_.Name;
            _loc7_.ConsortiaName = _loc6_.ConsortiaName;
            _loc7_.UserId = _loc6_.UserId;
            _loc7_.RankId = _loc6_.RankId;
            _loc7_.KillTotal = _loc6_.KillTotal;
            _loc7_.Guid = _loc6_.Guid;
            _loc7_.HeadId = _loc6_.HeadId;
            _loc7_.Level = _loc6_.Level;
            _loc7_.Assault = _loc6_.Assault;
            _loc7_.ConsortiaId = _loc6_.ConsortiaId;
            this.m_rankuserinfoAry.push(_loc7_);
            _loc5_++;
         }
         RankingSceneUI.getInstance().showList();
      }
      
      public function resp_MSG_RESP_CONSORTIARANK(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc6_:MSG_RESP_CONSORTIARANK_TEMP = null;
         var _loc7_:CorpsRankInfo = null;
         var _loc8_:int = 0;
         var _loc4_:MSG_RESP_CONSORTIARANK = new MSG_RESP_CONSORTIARANK();
         NetManager.Instance().readObject(_loc4_,param3);
         this.m_ConsortiaCount = _loc4_.ConsortiaCount;
         if(this.m_ConsortiaCount % 6 == 0)
         {
            this.m_maxPagenum = this.m_ConsortiaCount / 6;
         }
         else
         {
            this.m_maxPagenum = this.m_ConsortiaCount / 6 + 1;
         }
         this.m_CorpsRankAry.length = 0;
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_.DataLen)
         {
            _loc6_ = _loc4_.Data[_loc5_] as MSG_RESP_CONSORTIARANK_TEMP;
            _loc7_ = new CorpsRankInfo();
            _loc7_.Name = _loc6_.Name;
            _loc7_.ConsortiaId = _loc6_.ConsortiaId;
            _loc7_.RankId = _loc6_.RankId;
            _loc7_.ThrowWealth = _loc6_.ThrowWealth;
            _loc7_.HeadId = _loc6_.HeadId;
            _loc7_.Level = _loc6_.Level;
            _loc7_.HoldGalaxy = _loc6_.HoldGalaxy;
            _loc7_.Member = _loc6_.Member;
            _loc7_.MaxMember = _loc6_.MaxMember;
            this.m_HoldGalaxyAreaAry[_loc5_] = new Array();
            _loc8_ = 0;
            while(_loc8_ < _loc7_.HoldGalaxy)
            {
               this.m_HoldGalaxyAreaAry[_loc5_][_loc8_] = int(_loc6_.HoldGalaxyArea[_loc8_]);
               _loc8_++;
            }
            this.m_CorpsRankAry.push(_loc7_);
            _loc5_++;
         }
         RankingSceneUI.getInstance().showcorpslist();
      }
      
      public function resp_MSG_RESP_RANKFIGHT(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc6_:MSG_RESP_RANKFIGHT_TEMP = null;
         var _loc7_:RankFightInfo = null;
         var _loc4_:MSG_RESP_RANKFIGHT = new MSG_RESP_RANKFIGHT();
         NetManager.Instance().readObject(_loc4_,param3);
         this.m_pageID = _loc4_.PageId;
         this.m_maxPagenum = _loc4_.MaxPageId;
         this.m_RankFightAry.length = 0;
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_.DataLen)
         {
            _loc6_ = _loc4_.Data[_loc5_] as MSG_RESP_RANKFIGHT_TEMP;
            _loc7_ = new RankFightInfo();
            _loc7_.UserId = _loc6_.UserId;
            _loc7_.UserName = _loc6_.UserName;
            _loc7_.GalaxyId = _loc6_.GalaxyId;
            _loc7_.ConsortiaName = _loc6_.ConsortiaName;
            _loc7_.Guid = _loc6_.Guid;
            _loc7_.StarType = _loc6_.StarType;
            _loc7_.Reserve = _loc6_.Reserve;
            this.m_RankFightAry.push(_loc7_);
            _loc5_++;
         }
         RankingSceneUI.getInstance().showfightlist();
         RankingSceneUI.getInstance().setpage();
      }
      
      public function sendMsgRANKCENT(param1:int, param2:int = -1) : void
      {
         var _loc3_:MSG_REQUEST_RANKCENT = new MSG_REQUEST_RANKCENT();
         _loc3_.SeqId = GamePlayer.getInstance().seqID++;
         _loc3_.Guid = GamePlayer.getInstance().Guid;
         _loc3_.PageId = param1;
         _loc3_.ObjGuid = param2;
         NetManager.Instance().sendObject(_loc3_);
      }
      
      public function sengMsgRANKKILLTOTAL(param1:int, param2:int = -1) : void
      {
         var _loc3_:MSG_REQUEST_RANKKILLTOTAL = new MSG_REQUEST_RANKKILLTOTAL();
         _loc3_.SeqId = GamePlayer.getInstance().seqID++;
         _loc3_.Guid = GamePlayer.getInstance().Guid;
         _loc3_.PageId = param1;
         _loc3_.ObjGuid = param2;
         NetManager.Instance().sendObject(_loc3_);
      }
      
      public function sengMsgCONSORTIARANK(param1:int) : void
      {
         var _loc2_:MSG_REQUEST_CONSORTIARANK = new MSG_REQUEST_CONSORTIARANK();
         _loc2_.SeqId = GamePlayer.getInstance().seqID++;
         _loc2_.Guid = GamePlayer.getInstance().Guid;
         _loc2_.PageId = param1;
         NetManager.Instance().sendObject(_loc2_);
      }
      
      public function sendMsgRANKFIGHT(param1:int) : void
      {
         var _loc2_:MSG_REQUEST_RANKFIGHT = new MSG_REQUEST_RANKFIGHT();
         _loc2_.SeqId = GamePlayer.getInstance().seqID++;
         _loc2_.Guid = GamePlayer.getInstance().Guid;
         _loc2_.PageId = param1;
         NetManager.Instance().sendObject(_loc2_);
      }
      
      public function resp_MSG_RESP_WARFIELD_PAGE(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_WARFIELD_PAGE = new MSG_RESP_WARFIELD_PAGE();
         NetManager.Instance().readObject(_loc4_,param3);
         RankingSceneUI.getInstance().RespBattleMsg(_loc4_);
      }
   }
}

