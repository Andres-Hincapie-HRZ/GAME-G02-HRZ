package net.msg.Compose
{
   import flash.utils.ByteArray;
   import net.base.MsgSocket;
   import net.common.MsgHead;
   import net.common.MsgTypes;
   
   public class MSG_RESP_UNIONCOMMANDERCARD extends MsgHead
   {
      
      public var PropsId:int;
      
      public var Card1:int;
      
      public var Card2:int;
      
      public var Card3:int;
      
      public var Goods:int;
      
      public var GoodsLockFlag:int;
      
      public function MSG_RESP_UNIONCOMMANDERCARD()
      {
         super();
         usSize = this.getLength();
         usType = MsgTypes._MSG_RESP_UNIONCOMMANDERCARD;
      }
      
      public function readBuf(param1:ByteArray) : void
      {
         var _loc2_:MsgSocket = null;
         _loc2_ = MsgSocket.Instance();
         usSize = _loc2_.readMsgSize(param1);
         usType = _loc2_.readMsgType(param1);
         this.PropsId = _loc2_.readInt(param1);
         this.Card1 = _loc2_.readInt(param1);
         this.Card2 = _loc2_.readInt(param1);
         this.Card3 = _loc2_.readInt(param1);
         this.Goods = _loc2_.readInt(param1);
         this.GoodsLockFlag = _loc2_.readInt(param1);
         _loc2_ = null;
      }
      
      public function getLength(param1:int = 0) : int
      {
         param1 = 4;
         return param1 + 24;
      }
      
      public function release() : void
      {
      }
   }
}

