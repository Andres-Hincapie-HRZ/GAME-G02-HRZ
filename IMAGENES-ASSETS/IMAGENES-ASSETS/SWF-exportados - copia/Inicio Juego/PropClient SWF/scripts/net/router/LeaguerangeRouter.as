package net.router
{
   import flash.utils.ByteArray;
   import logic.entry.GamePlayer;
   import logic.entry.Rank.*;
   import logic.ui.LeaguerangeSceneUI;
   import net.base.NetManager;
   import net.msg.Rank.*;
   
   public class LeaguerangeRouter
   {
      
      public static var instance:LeaguerangeRouter;
      
      public var leaguerangeInfoAry:Array = new Array();
      
      public var MaxPageId:int;
      
      public var PageId:int;
      
      public var DataLen:int;
      
      public function LeaguerangeRouter()
      {
         super();
      }
      
      public static function getInstance() : LeaguerangeRouter
      {
         if(instance == null)
         {
            instance = new LeaguerangeRouter();
         }
         return instance;
      }
      
      public function sendMsgRANKMATCH(param1:int, param2:int) : void
      {
         var _loc3_:MSG_REQUEST_RANKMATCH = new MSG_REQUEST_RANKMATCH();
         _loc3_.SeqId = GamePlayer.getInstance().seqID++;
         _loc3_.Guid = GamePlayer.getInstance().Guid;
         _loc3_.ObjGuid = param1;
         _loc3_.PageId = param2;
         NetManager.Instance().sendObject(_loc3_);
      }
      
      public function resp_MSG_RESP_RANKMATCH(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc6_:MSG_RESP_RANKMATCH_TEMP = null;
         var _loc7_:LeaguerangeInfo = null;
         var _loc4_:MSG_RESP_RANKMATCH = new MSG_RESP_RANKMATCH();
         NetManager.Instance().readObject(_loc4_,param3);
         if(_loc4_.PageId == -1)
         {
            LeaguerangeSceneUI.getInstance().noFind();
            return;
         }
         this.PageId = _loc4_.PageId;
         this.MaxPageId = _loc4_.MaxPageId;
         this.leaguerangeInfoAry.length = 0;
         this.DataLen = _loc4_.DataLen;
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_.DataLen)
         {
            _loc6_ = _loc4_.Data[_loc5_] as MSG_RESP_RANKMATCH_TEMP;
            _loc7_ = new LeaguerangeInfo();
            _loc7_.UserName = _loc6_.UserName;
            _loc7_.Guid = _loc6_.Guid;
            _loc7_.MatchDogfall = _loc6_.MatchDogfall;
            _loc7_.MatchLevel = _loc6_.MatchLevel;
            _loc7_.MatchLost = _loc6_.MatchLost;
            _loc7_.MatchWin = _loc6_.MatchWin;
            _loc7_.MatchWeekTop = _loc6_.MatchWeekTop;
            this.leaguerangeInfoAry.push(_loc7_);
            _loc5_++;
         }
         LeaguerangeSceneUI.getInstance().InitPopUp();
      }
   }
}

