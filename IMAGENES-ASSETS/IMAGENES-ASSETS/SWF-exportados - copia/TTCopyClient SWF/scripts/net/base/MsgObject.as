package net.base
{
   import flash.external.ExternalInterface;
   import flash.utils.describeType;
   import flash.utils.getQualifiedClassName;
   import net.common.MsgHead;
   
   public class MsgObject
   {
      
      public function MsgObject()
      {
         super();
         ExternalInterface.call("console.log","PKT " + getQualifiedClassName(this));
      }
      
      public function pushField(param1:String, param2:String, param3:Array = null) : void
      {
         if(!param3)
         {
            return;
         }
         var _loc4_:Array = new Array(param2.toLowerCase());
         param3.push(param1);
         param3[param1] = _loc4_;
      }
      
      private function getLen(param1:Object, param2:int = 0) : int
      {
         var _loc7_:int = 0;
         var _loc8_:String = null;
         var _loc9_:String = null;
         var _loc10_:int = 0;
         if(!(param1 is MsgObject))
         {
            return param2;
         }
         var _loc3_:* = param2;
         var _loc4_:int = 0;
         var _loc5_:Array = param1.varlist;
         var _loc6_:int = 0;
         while(_loc6_ < _loc5_.length)
         {
            _loc7_ = 1;
            _loc8_ = _loc5_[_loc5_[_loc6_]][0];
            if(_loc8_.substr(0,1) == "w")
            {
               _loc7_ = 2;
               _loc8_ = _loc8_.substr(1,_loc8_.length - 1);
            }
            else if(_loc8_.substr(0,1) == "u")
            {
               _loc8_ = _loc8_.substr(1,_loc8_.length - 1);
            }
            _loc7_ *= int(_loc8_);
            _loc9_ = _loc5_[_loc5_[_loc6_]][1].toLowerCase();
            if(_loc9_ == "array")
            {
               _loc10_ = 0;
               while(_loc10_ < _loc7_)
               {
                  _loc3_ = this.getLen(param1[_loc5_[_loc6_]][_loc10_],_loc3_);
                  _loc10_++;
               }
            }
            else if(!(_loc9_ == "int" || _loc9_ == "uint" || _loc9_ == "number" || _loc9_ == "boolean" || _loc9_ == "string"))
            {
               _loc3_ = this.getLen(param1[_loc5_[_loc6_]],_loc3_);
            }
            else
            {
               if(_loc7_ >= 2 && (_loc9_ == "int" || _loc9_ == "uint" || _loc9_ == "number"))
               {
                  if(_loc7_ == 8)
                  {
                     _loc4_ = (8 - _loc3_) % 8 % 8;
                  }
                  else if(_loc7_ == 4)
                  {
                     _loc4_ = (4 - _loc3_) % 4 % 4;
                  }
                  else if(_loc7_ == 2)
                  {
                     _loc4_ = (2 - _loc3_) % 2 % 2;
                  }
                  else
                  {
                     _loc4_ = 0;
                  }
                  if(_loc4_ > 0)
                  {
                     _loc3_ += _loc4_;
                  }
               }
               _loc3_ += _loc7_;
            }
            _loc6_++;
         }
         _loc5_ = null;
         return _loc3_;
      }
      
      public function getObjectLen(param1:Object) : int
      {
         if(!(param1 is MsgObject))
         {
            return 0;
         }
         var _loc2_:int = 0;
         if(param1 is MsgHead)
         {
            _loc2_ += 4;
         }
         _loc2_ = this.getLen(param1,_loc2_);
         var _loc3_:int = (4 - _loc2_) % 4 % 4;
         if(_loc3_ > 0)
         {
            _loc2_ += _loc3_;
         }
         return _loc2_;
      }
      
      public function getVarType(param1:*) : void
      {
         var vList:Array;
         var xml:XML;
         var pname:String = null;
         var value:* = param1;
         if(!(value is MsgObject))
         {
            return;
         }
         vList = value.varlist;
         xml = describeType(value);
         with(_loc3_)
         {
            if(hasOwnProperty("variable"))
            {
               for(pname in variable)
               {
                  if(vList.indexOf(variable.@name[pname] + "") >= 0)
                  {
                     vList[variable.@name[pname]][1] = variable.@type[pname];
                  }
               }
            }
         }
         xml = null;
         vList = null;
      }
      
      public function setVarType(param1:Object) : void
      {
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         if(!(param1 is MsgHead))
         {
            return;
         }
         var _loc2_:Array = param1.varlist;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc4_ = _loc2_[_loc3_];
            if(_loc2_.indexOf(_loc4_) >= 0)
            {
               _loc5_ = getQualifiedClassName(param1[_loc4_]).toLowerCase();
               if(_loc5_ == "int")
               {
                  _loc6_ = _loc2_[_loc2_[_loc3_]][0];
                  if(_loc6_.substr(0,1) == "u")
                  {
                     _loc5_ = "uint";
                  }
               }
               else if(_loc5_ == "null")
               {
                  _loc5_ = "string";
               }
               _loc2_[_loc4_][1] = _loc5_;
            }
            _loc3_++;
         }
         _loc2_ = null;
      }
   }
}

