package net.base
{
   import flash.utils.ByteArray;
   
   public class MsgSocket implements iMsgSocket
   {
      
      private static var msgSocket:MsgSocket = null;
      
      public function MsgSocket()
      {
         super();
      }
      
      public static function Instance() : MsgSocket
      {
         if(msgSocket == null)
         {
            msgSocket = new MsgSocket();
         }
         return msgSocket;
      }
      
      private function read_Data(param1:Object, param2:ByteArray, param3:int) : int
      {
         var _loc8_:int = 0;
         var _loc9_:String = null;
         var _loc10_:Boolean = false;
         var _loc11_:String = null;
         var _loc12_:int = 0;
         if(!param1 || !param2)
         {
            return 0;
         }
         var _loc4_:int = param3;
         var _loc5_:Array = param1.varlist;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         for(; _loc7_ < _loc5_.length; _loc7_++)
         {
            _loc8_ = 1;
            _loc9_ = _loc5_[_loc5_[_loc7_]][0];
            _loc10_ = false;
            if(_loc9_.substr(0,1) == "w")
            {
               _loc10_ = true;
               _loc8_ = 2;
               _loc9_ = _loc9_.substr(1,_loc9_.length - 1);
            }
            else if(_loc9_.substr(0,1) == "u")
            {
               _loc9_ = _loc9_.substr(1,_loc9_.length - 1);
            }
            _loc8_ *= int(_loc9_);
            _loc11_ = _loc5_[_loc5_[_loc7_]][1].toLowerCase();
            if(_loc11_ == "array")
            {
               _loc12_ = 0;
               while(_loc12_ < _loc8_)
               {
                  _loc4_ = this.read_Data(param1[_loc5_[_loc7_]][_loc12_],param2,_loc4_);
                  _loc12_++;
               }
               continue;
            }
            if(!(_loc11_ == "int" || _loc11_ == "uint" || _loc11_ == "number" || _loc11_ == "boolean" || _loc11_ == "string"))
            {
               _loc4_ = this.read_Data(param1[_loc5_[_loc7_]],param2,_loc4_);
               continue;
            }
            if(_loc8_ >= 2 && (_loc11_ == "int" || _loc11_ == "uint" || _loc11_ == "number"))
            {
               _loc6_ = (_loc8_ - _loc4_ % _loc8_) % _loc8_;
               if(_loc6_ > 0)
               {
                  this.GetByte(param2,_loc6_);
                  _loc4_ += _loc6_;
               }
            }
            _loc4_ += _loc8_;
            switch(_loc5_[_loc5_[_loc7_]][1].toLowerCase())
            {
               case "int":
                  if(_loc8_ >= 4)
                  {
                     param1[_loc5_[_loc7_]] = this.readInt(param2);
                  }
                  else if(_loc8_ >= 2)
                  {
                     param1[_loc5_[_loc7_]] = this.readShort(param2);
                  }
                  else
                  {
                     param1[_loc5_[_loc7_]] = this.readChar(param2);
                  }
                  break;
               case "uint":
                  if(_loc8_ >= 4)
                  {
                     param1[_loc5_[_loc7_]] = this.readUnsignInt(param2);
                  }
                  else if(_loc8_ >= 2)
                  {
                     param1[_loc5_[_loc7_]] = this.readUnsignShort(param2);
                  }
                  else
                  {
                     param1[_loc5_[_loc7_]] = this.readUnsignChar(param2);
                  }
                  break;
               case "number":
                  param1[_loc5_[_loc7_]] = this.readInt64(param2);
                  break;
               case "boolean":
                  param1[_loc5_[_loc7_]] = this.readBoolean(param2);
                  break;
               case "string":
                  if(_loc10_)
                  {
                     param1[_loc5_[_loc7_]] = this.readWideChar(param2,int(_loc9_));
                  }
                  else
                  {
                     param1[_loc5_[_loc7_]] = this.readUtf8Str(param2,_loc8_);
                  }
            }
         }
         _loc5_ = null;
         return _loc4_;
      }
      
      public function readData(param1:Object, param2:ByteArray) : int
      {
         if(!param1 || !param2)
         {
            return 0;
         }
         var _loc3_:int = int(param2.position);
         param2.position = 0;
         param1.usSize = this.readMsgSize(param2);
         param1.usType = this.readMsgType(param2);
         var _loc4_:int = 4;
         _loc4_ = this.read_Data(param1,param2,_loc4_);
         var _loc5_:int = (4 - _loc4_ % 4) % 4;
         if(_loc5_ > 0)
         {
            _loc4_ += _loc5_;
         }
         param2.position = _loc3_;
         return _loc4_;
      }
      
      public function send_Data(param1:Object, param2:ByteArray, param3:int) : int
      {
         var _loc8_:Boolean = false;
         var _loc9_:int = 0;
         var _loc10_:String = null;
         var _loc11_:String = null;
         var _loc12_:int = 0;
         if(!param1 || !param2)
         {
            return param3;
         }
         var _loc4_:Array = param1.varlist;
         var _loc5_:int = param3;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         for(; _loc7_ < _loc4_.length; _loc7_++)
         {
            _loc8_ = false;
            _loc9_ = 1;
            _loc10_ = _loc4_[_loc4_[_loc7_]][0];
            if(_loc10_.substr(0,1) == "w")
            {
               _loc8_ = true;
               _loc9_ = 2;
               _loc10_ = _loc10_.substr(1,_loc10_.length - 1);
            }
            else if(_loc10_.substr(0,1) == "u")
            {
               _loc10_ = _loc10_.substr(1,_loc10_.length - 1);
            }
            _loc9_ *= int(_loc10_);
            _loc11_ = _loc4_[_loc4_[_loc7_]][1].toLowerCase();
            if(_loc11_ == "array")
            {
               _loc12_ = 0;
               while(_loc12_ < _loc9_)
               {
                  _loc5_ = this.send_Data(param1[_loc4_[_loc7_]][_loc12_],param2,_loc5_);
                  _loc12_++;
               }
               continue;
            }
            if(!(_loc11_ == "int" || _loc11_ == "uint" || _loc11_ == "number" || _loc11_ == "boolean" || _loc11_ == "string"))
            {
               _loc5_ = this.send_Data(param1[_loc4_[_loc7_]],param2,_loc5_);
               continue;
            }
            if(_loc9_ >= 2 && (_loc11_ == "int" || _loc11_ == "uint" || _loc11_ == "number"))
            {
               if(_loc9_ == 8)
               {
                  _loc6_ = (8 - _loc5_ % 8) % 8;
               }
               else if(_loc9_ == 4)
               {
                  _loc6_ = (4 - _loc5_ % 4) % 4;
               }
               else if(_loc9_ == 2)
               {
                  _loc6_ = (2 - _loc5_ % 2) % 2;
               }
               else
               {
                  _loc6_ = 0;
               }
               if(_loc6_ > 0)
               {
                  this.PushByte(param2,_loc6_);
                  _loc5_ += _loc6_;
               }
            }
            _loc5_ += _loc9_;
            switch(_loc4_[_loc4_[_loc7_]][1].toLowerCase())
            {
               case "int":
                  if(_loc9_ >= 4)
                  {
                     this.writeInt(param2,param1[_loc4_[_loc7_]]);
                  }
                  else if(_loc9_ >= 2)
                  {
                     this.writeShort(param2,param1[_loc4_[_loc7_]]);
                  }
                  else
                  {
                     this.writeByte(param2,param1[_loc4_[_loc7_]]);
                  }
                  break;
               case "uint":
                  if(_loc9_ >= 4)
                  {
                     this.writeUnsignInt(param2,param1[_loc4_[_loc7_]]);
                  }
                  else if(_loc9_ >= 2)
                  {
                     this.writeShort(param2,param1[_loc4_[_loc7_]]);
                  }
                  else
                  {
                     this.writeByte(param2,param1[_loc4_[_loc7_]]);
                  }
                  break;
               case "number":
                  this.writeInt64(param2,param1[_loc4_[_loc7_]]);
                  break;
               case "boolean":
                  this.writeBoolean(param2,param1[_loc4_[_loc7_]]);
                  break;
               case "string":
                  if(_loc8_)
                  {
                     this.writeWideChar(param2,param1[_loc4_[_loc7_]] == null ? "" : param1[_loc4_[_loc7_]],int(_loc10_));
                  }
                  else
                  {
                     this.writeUtf8Str(param2,param1[_loc4_[_loc7_]] == null ? "" : param1[_loc4_[_loc7_]],_loc9_);
                  }
            }
         }
         _loc4_ = null;
         return _loc5_;
      }
      
      public function sendData(param1:Object, param2:ByteArray) : void
      {
         if(!param1 || !param2)
         {
            return;
         }
         param2.position = 0;
         this.writeShort(param2,param1.usSize);
         this.writeShort(param2,param1.usType);
         var _loc3_:int = 4;
         _loc3_ = this.send_Data(param1,param2,_loc3_);
         var _loc4_:int = (4 - _loc3_ % 4) % 4;
         if(_loc4_ > 0)
         {
            this.PushByte(param2,_loc4_);
            _loc3_ += _loc4_;
         }
      }
      
      public function GetByte(param1:ByteArray, param2:int) : void
      {
         var _loc3_:int = 0;
         while(_loc3_ < param2)
         {
            param1.readByte();
            _loc3_++;
         }
      }
      
      public function PushByte(param1:ByteArray, param2:int) : void
      {
         if(param2 <= 0)
         {
            return;
         }
         var _loc3_:int = int(param1.position);
         var _loc4_:int = 0;
         while(_loc4_ < param2)
         {
            param1[_loc3_ + _loc4_] = 0;
            _loc4_++;
         }
         param1.position += param2;
      }
      
      public function readMsgSize(param1:ByteArray) : int
      {
         if(param1.length <= 2)
         {
            return 0;
         }
         return this.readUnsignShort(param1);
      }
      
      public function readMsgType(param1:ByteArray) : int
      {
         if(param1.length - param1.position < 2)
         {
            return 0;
         }
         return this.readUnsignShort(param1);
      }
      
      public function writeByte(param1:ByteArray, param2:int) : void
      {
         param1[param1.position] = param2;
         param1.position += 1;
      }
      
      public function readByte(param1:ByteArray) : int
      {
         return param1.readByte();
      }
      
      public function readChar(param1:ByteArray) : int
      {
         return param1.readByte();
      }
      
      public function writeChar(param1:ByteArray, param2:int) : void
      {
         param1[param1.position] = param2;
         param1.position += 1;
      }
      
      public function readUnsignChar(param1:ByteArray) : int
      {
         var _loc2_:int = param1.readByte();
         if(_loc2_ < 0)
         {
            _loc2_ += 256;
         }
         return _loc2_;
      }
      
      public function writeUnsignChar(param1:ByteArray, param2:int) : void
      {
         param1[param1.position] = param2;
         param1.position += 1;
      }
      
      public function writeShort(param1:ByteArray, param2:int) : void
      {
         var _loc3_:int = int(param1.position);
         param1[_loc3_] = param2 % 256;
         param1[_loc3_ + 1] = param2 / 256;
         param1.position += 2;
      }
      
      public function readShort(param1:ByteArray) : int
      {
         var _loc2_:int = param1.readByte();
         var _loc3_:int = param1.readByte();
         if(_loc2_ < 0)
         {
            _loc2_ += 256;
         }
         if(_loc3_ < 0)
         {
            _loc3_ += 256;
         }
         var _loc4_:int = _loc3_ * 256 + _loc2_;
         if(_loc4_ > 256 * 128 - 1)
         {
            _loc4_ -= 256 * 256;
         }
         return _loc4_;
      }
      
      public function writeUnsignShort(param1:ByteArray, param2:uint) : void
      {
         var _loc3_:int = int(param1.position);
         param1[_loc3_] = param2 & 0xFF;
         param1[_loc3_ + 1] = param2 >> 8 & 0xFF;
         param1.position += 2;
      }
      
      public function readUnsignShort(param1:ByteArray) : int
      {
         var _loc2_:int = param1.readByte();
         var _loc3_:int = param1.readByte();
         if(_loc2_ < 0)
         {
            _loc2_ += 256;
         }
         if(_loc3_ < 0)
         {
            _loc3_ += 256;
         }
         return (_loc3_ & 0xFF) << 8 | _loc2_ & 0xFF;
      }
      
      public function writeInt(param1:ByteArray, param2:int) : void
      {
         var _loc3_:int = int(param1.position);
         param1[_loc3_] = param2 & 0xFF;
         param1[_loc3_ + 1] = param2 >> 8 & 0xFF;
         param1[_loc3_ + 2] = param2 >> 16 & 0xFF;
         param1[_loc3_ + 3] = param2 >> 24 & 0xFF;
         param1.position += 4;
      }
      
      public function readInt(param1:ByteArray) : int
      {
         var _loc2_:int = param1.readByte();
         var _loc3_:int = param1.readByte();
         var _loc4_:int = param1.readByte();
         var _loc5_:int = param1.readByte();
         return (_loc5_ & 0xFF) << 24 | (_loc4_ & 0xFF) << 16 | (_loc3_ & 0xFF) << 8 | _loc2_ & 0xFF;
      }
      
      public function writeUnsignInt(param1:ByteArray, param2:uint) : void
      {
         var _loc3_:int = int(param1.position);
         param1[_loc3_] = param2 & 0xFF;
         param1[_loc3_ + 1] = param2 >> 8 & 0xFF;
         param1[_loc3_ + 2] = param2 >> 16 & 0xFF;
         param1[_loc3_ + 3] = param2 >> 24 & 0xFF;
         param1.position += 4;
      }
      
      public function readUnsignInt(param1:ByteArray) : uint
      {
         var _loc2_:int = param1.readByte();
         var _loc3_:int = param1.readByte();
         var _loc4_:int = param1.readByte();
         var _loc5_:int = param1.readByte();
         return (_loc5_ & 0xFF) << 24 | (_loc4_ & 0xFF) << 16 | (_loc3_ & 0xFF) << 8 | _loc2_ & 0xFF;
      }
      
      public function writeInt64(param1:ByteArray, param2:Number) : void
      {
         var _loc3_:int = int(param1.position);
         param1[_loc3_] = param2 & 0xFF;
         param1[_loc3_ + 1] = param2 >> 8 & 0xFF;
         param1[_loc3_ + 2] = param2 >> 16 & 0xFF;
         param1[_loc3_ + 3] = param2 >> 24 & 0xFF;
         param2 /= Math.pow(256,4);
         param2 = Math.floor(param2);
         param1[_loc3_ + 4] = param2 & 0xFF;
         param1[_loc3_ + 5] = param2 >> 8 & 0xFF;
         param1[_loc3_ + 6] = param2 >> 16 & 0xFF;
         param1[_loc3_ + 7] = param2 >> 24 & 0xFF;
         param1.position += 8;
      }
      
      public function readInt64(param1:ByteArray) : Number
      {
         var _loc2_:int = param1.readByte();
         var _loc3_:int = param1.readByte();
         var _loc4_:int = param1.readByte();
         var _loc5_:int = param1.readByte();
         var _loc6_:int = param1.readByte();
         var _loc7_:int = param1.readByte();
         var _loc8_:int = param1.readByte();
         var _loc9_:int = param1.readByte();
         var _loc10_:Number = (_loc9_ & 0xFF) << 24 | (_loc8_ & 0xFF) << 16 | (_loc7_ & 0xFF) << 8 | _loc6_ & 0xFF;
         var _loc11_:Number = (_loc5_ & 0xFF) << 24 | (_loc4_ & 0xFF) << 16 | (_loc3_ & 0xFF) << 8 | _loc2_ & 0xFF;
         if(_loc11_ < 0)
         {
            _loc11_ += Math.pow(256,4);
         }
         return _loc10_ * Math.pow(256,4) + _loc11_;
      }
      
      public function writeStr(param1:ByteArray, param2:String, param3:int) : void
      {
         var _loc4_:int = int(param1.position);
         var _loc5_:int = 0;
         while(_loc5_ < param3)
         {
            if(_loc5_ < param2.length)
            {
               param1[_loc4_ + _loc5_] = param2.charCodeAt(_loc5_);
            }
            else
            {
               param1[_loc4_ + _loc5_] = 0;
            }
            _loc5_++;
         }
         param1.position += param3;
      }
      
      public function writeUtf8Str(param1:ByteArray, param2:String, param3:int) : void
      {
         var _loc4_:int = int(param1.position);
         var _loc5_:int = 0;
         while(_loc5_ < param3)
         {
            param1[_loc4_ + _loc5_] = 0;
            _loc5_++;
         }
         param1.writeMultiByte(param2,"utf-8");
         param1.position = _loc4_ + param3;
      }
      
      public function writeWideChar(param1:ByteArray, param2:String, param3:int) : void
      {
         var _loc4_:int = 0;
         while(_loc4_ < param2.length && _loc4_ < param3)
         {
            this.writeShort(param1,param2.charCodeAt(_loc4_));
            _loc4_++;
         }
         this.PushByte(param1,(param3 - param2.length) * 2);
      }
      
      public function readStr(param1:ByteArray, param2:int) : String
      {
         return param1.readMultiByte(param2,"utf-8");
      }
      
      public function readUtf8Str(param1:ByteArray, param2:int) : String
      {
         return param1.readMultiByte(param2,"utf-8");
      }
      
      public function readWideChar(param1:ByteArray, param2:int) : String
      {
         var _loc3_:int = 0;
         var _loc4_:String = "";
         var _loc5_:int = 0;
         while(_loc5_ < param2)
         {
            _loc3_ = this.readShort(param1);
            if(_loc3_ == 0)
            {
               break;
            }
            _loc4_ += String.fromCharCode(_loc3_);
            _loc5_++;
         }
         _loc5_++;
         while(_loc5_ < param2)
         {
            param1.readShort();
            _loc5_++;
         }
         return _loc4_;
      }
      
      public function writeBoolean(param1:ByteArray, param2:Boolean) : void
      {
         param1[param1.position] = param2 ? 1 : 0;
         param1.position += 1;
      }
      
      public function readBoolean(param1:ByteArray) : Boolean
      {
         return param1.readByte() != 0 ? true : false;
      }
      
      public function DecodeMsgBuf(param1:ByteArray, param2:int, param3:int) : void
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc4_:int = 4;
         if(param3 > 0)
         {
            _loc5_ = (param2 + 1979) % 256;
            _loc6_ = 0;
            while(_loc6_ < param3 - 4)
            {
               param1[_loc4_] ^= _loc5_;
               _loc4_++;
               _loc6_++;
            }
         }
      }
      
      public function EncodeMsgBuf(param1:ByteArray, param2:int, param3:int) : void
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc4_:int = 4;
         if(param3 > 0)
         {
            _loc5_ = (param2 + 1979) % 256;
            _loc6_ = 0;
            while(_loc6_ < param3 - 4)
            {
               param1[_loc4_] ^= _loc5_;
               _loc4_++;
               _loc6_++;
            }
         }
      }
   }
}

