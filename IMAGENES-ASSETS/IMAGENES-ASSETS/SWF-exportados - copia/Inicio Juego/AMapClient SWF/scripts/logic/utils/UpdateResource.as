package logic.utils
{
   import logic.entry.GamePlayer;
   import logic.entry.ScienceSystem;
   import logic.ui.ResPlaneUI;
   
   public class UpdateResource
   {
      
      private static var instance:UpdateResource;
      
      public var fuhuoNum:int = 0;
      
      public var lockflg:int = 0;
      
      private var MAX_PROPSNUM:int = 9999;
      
      public function UpdateResource()
      {
         super();
      }
      
      public static function getInstance() : UpdateResource
      {
         if(instance == null)
         {
            instance = new UpdateResource();
         }
         return instance;
      }
      
      public function addResource(param1:int = 0, param2:int = 0, param3:int = 0) : void
      {
         GamePlayer.getInstance().OutGas = GamePlayer.getInstance().OutGas + param1;
         GamePlayer.getInstance().OutMetal = GamePlayer.getInstance().OutMetal + param2;
         GamePlayer.getInstance().OutMoney = GamePlayer.getInstance().OutMoney + param3;
         ResPlaneUI.getInstance().updateResource();
      }
      
      public function HasPackSpace(param1:int, param2:int = 0, param3:int = 1) : int
      {
         if(GamePlayer.getInstance().PropsPack - ScienceSystem.getinstance().Packarr.length <= 0)
         {
            return 1;
         }
         var _loc4_:int = 0;
         while(_loc4_ < ScienceSystem.getinstance().Packarr.length)
         {
            if(ScienceSystem.getinstance().Packarr[_loc4_].PropsId == param1 && ScienceSystem.getinstance().Packarr[_loc4_].LockFlag == param2)
            {
               if(ScienceSystem.getinstance().Packarr[_loc4_].PropsNum + param3 <= this.MAX_PROPSNUM)
               {
                  return 0;
               }
               return 2;
            }
            _loc4_++;
         }
         return 0;
      }
      
      public function GetPropsNum(param1:int, param2:int = 0) : int
      {
         var _loc3_:int = 0;
         while(_loc3_ < ScienceSystem.getinstance().Packarr.length)
         {
            if(ScienceSystem.getinstance().Packarr[_loc3_].PropsId == param1)
            {
               return ScienceSystem.getinstance().Packarr[_loc3_].PropsNum;
            }
            _loc3_++;
         }
         return 0;
      }
      
      public function MoveMax(param1:int, param2:int) : int
      {
         var _loc3_:int = 0;
         var _loc4_:Boolean = true;
         var _loc5_:int = 0;
         while(_loc5_ < ScienceSystem.getinstance().Packarr.length)
         {
            if(ScienceSystem.getinstance().Packarr[_loc5_].PropsId == param1 && ScienceSystem.getinstance().Packarr[_loc5_].LockFlag == param2)
            {
               _loc3_ = this.MAX_PROPSNUM - ScienceSystem.getinstance().Packarr[_loc5_].PropsNum;
               _loc4_ = false;
               break;
            }
            _loc5_++;
         }
         if(_loc4_)
         {
            if(_loc3_ == 0)
            {
               _loc3_ = this.MAX_PROPSNUM;
            }
         }
         return _loc3_;
      }
      
      public function panduanjuntuan(param1:int, param2:int) : Boolean
      {
         var _loc3_:uint = 0;
         while(_loc3_ < ScienceSystem.getinstance().Juntarr.length)
         {
            if(ScienceSystem.getinstance().Juntarr[_loc3_].PropsId == param1 && ScienceSystem.getinstance().Juntarr[_loc3_].LockFlag == param2)
            {
               return true;
            }
            _loc3_++;
         }
         if(ScienceSystem.getinstance().Juntarr.length < GamePlayer.getInstance().PropsCorpsPack)
         {
            return true;
         }
         return false;
      }
      
      public function MoveMaxjun(param1:int, param2:int) : int
      {
         var _loc3_:int = 0;
         var _loc4_:Boolean = true;
         var _loc5_:uint = 0;
         while(_loc5_ < ScienceSystem.getinstance().Juntarr.length)
         {
            if(ScienceSystem.getinstance().Juntarr[_loc5_].PropsId == param1 && ScienceSystem.getinstance().Juntarr[_loc5_].LockFlag == param2)
            {
               _loc3_ = this.MAX_PROPSNUM - ScienceSystem.getinstance().Juntarr[_loc5_].PropsNum;
               _loc4_ = false;
               break;
            }
            _loc5_++;
         }
         if(_loc4_)
         {
            if(_loc3_ == 0)
            {
               _loc3_ = this.MAX_PROPSNUM;
            }
         }
         return _loc3_;
      }
      
      public function AddToPack(param1:int, param2:int, param3:int = 0) : Boolean
      {
         var _loc6_:Object = null;
         var _loc7_:Object = null;
         var _loc4_:Boolean = true;
         if(ScienceSystem.getinstance().Packarr.length == 0)
         {
            if(param2 > this.MAX_PROPSNUM)
            {
               param2 = this.MAX_PROPSNUM;
            }
            _loc6_ = new Object();
            _loc6_.PropsId = param1;
            _loc6_.PropsNum = param2;
            _loc6_.CardLevel = 0;
            _loc6_.StorageType = 0;
            _loc6_.LockFlag = param3;
            _loc6_.Reserve = 0;
            ScienceSystem.getinstance().Packarr.push(_loc6_);
            return true;
         }
         var _loc5_:int = 0;
         while(_loc5_ < ScienceSystem.getinstance().Packarr.length)
         {
            if(ScienceSystem.getinstance().Packarr[_loc5_].PropsId == param1 && ScienceSystem.getinstance().Packarr[_loc5_].LockFlag == param3)
            {
               ScienceSystem.getinstance().Packarr[_loc5_].PropsNum = ScienceSystem.getinstance().Packarr[_loc5_].PropsNum + param2;
               if(ScienceSystem.getinstance().Packarr[_loc5_].PropsNum > this.MAX_PROPSNUM)
               {
                  ScienceSystem.getinstance().Packarr[_loc5_].PropsNum = this.MAX_PROPSNUM;
               }
               return true;
            }
            if(_loc5_ >= ScienceSystem.getinstance().Packarr.length - 1)
            {
               if(ScienceSystem.getinstance().Packarr[_loc5_].PropsId == param1 && ScienceSystem.getinstance().Packarr[_loc5_].LockFlag == param3)
               {
                  ScienceSystem.getinstance().Packarr[_loc5_].PropsNum = ScienceSystem.getinstance().Packarr[_loc5_].PropsNum + param2;
                  if(ScienceSystem.getinstance().Packarr[_loc5_].PropsNum > this.MAX_PROPSNUM)
                  {
                     ScienceSystem.getinstance().Packarr[_loc5_].PropsNum = this.MAX_PROPSNUM;
                  }
                  return true;
               }
               if(GamePlayer.getInstance().PropsPack - ScienceSystem.getinstance().Packarr.length <= 0)
               {
                  return false;
               }
               if(param2 > this.MAX_PROPSNUM)
               {
                  param2 = this.MAX_PROPSNUM;
               }
               _loc7_ = new Object();
               _loc7_.PropsId = param1;
               _loc7_.PropsNum = param2;
               _loc7_.CardLevel = 0;
               _loc7_.StorageType = 0;
               _loc7_.LockFlag = param3;
               _loc7_.Reserve = 0;
               ScienceSystem.getinstance().Packarr.push(_loc7_);
               _loc4_ = true;
               break;
            }
            _loc5_++;
         }
         return _loc4_;
      }
      
      public function DeleteProps(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:uint = 0;
         while(_loc4_ < ScienceSystem.getinstance().Packarr.length)
         {
            if(ScienceSystem.getinstance().Packarr[_loc4_].PropsId == param1 && ScienceSystem.getinstance().Packarr[_loc4_].LockFlag == param2)
            {
               ScienceSystem.getinstance().Packarr[_loc4_].PropsNum = ScienceSystem.getinstance().Packarr[_loc4_].PropsNum - param3;
               if(ScienceSystem.getinstance().Packarr[_loc4_].PropsNum <= 0)
               {
                  ScienceSystem.getinstance().Packarr[_loc4_].PropsNum = 0;
                  ScienceSystem.getinstance().Packarr.splice(_loc4_,1);
               }
            }
            _loc4_++;
         }
      }
      
      public function DeleteProps_1(param1:int, param2:int, param3:int) : void
      {
         var _loc6_:int = 0;
         var _loc4_:int = param3;
         var _loc5_:uint = 0;
         while(_loc5_ < ScienceSystem.getinstance().Packarr.length)
         {
            if(ScienceSystem.getinstance().Packarr[_loc5_].PropsId == param1 && ScienceSystem.getinstance().Packarr[_loc5_].LockFlag == param2)
            {
               _loc6_ = _loc4_;
               if(_loc4_ <= ScienceSystem.getinstance().Packarr[_loc5_].PropsNum)
               {
                  _loc6_ = _loc4_;
                  _loc4_ = 0;
               }
               else
               {
                  _loc6_ = int(ScienceSystem.getinstance().Packarr[_loc5_].PropsNum);
                  _loc4_ -= _loc6_;
               }
               ScienceSystem.getinstance().Packarr[_loc5_].PropsNum = ScienceSystem.getinstance().Packarr[_loc5_].PropsNum - _loc6_;
               if(ScienceSystem.getinstance().Packarr[_loc5_].PropsNum <= 0)
               {
                  ScienceSystem.getinstance().Packarr[_loc5_].PropsNum = 0;
                  ScienceSystem.getinstance().Packarr.splice(_loc5_,1);
               }
            }
            if(_loc4_ == 0)
            {
               return;
            }
            _loc5_++;
         }
         if(_loc4_ > 0)
         {
            this.DeleteProps_1(param1,0,_loc4_);
         }
      }
      
      public function XiaoLaBaHd(param1:int = 0, param2:Boolean = true) : Boolean
      {
         var _loc3_:Boolean = true;
         var _loc4_:Boolean = true;
         var _loc5_:int = 0;
         if(ScienceSystem.getinstance().Packarr.length == 0)
         {
            return false;
         }
         var _loc6_:uint = 0;
         while(_loc6_ < ScienceSystem.getinstance().Packarr.length)
         {
            if(ScienceSystem.getinstance().Packarr[_loc6_].PropsId == param1 && ScienceSystem.getinstance().Packarr[_loc6_].LockFlag == 1)
            {
               _loc3_ = true;
               _loc4_ = true;
               this.lockflg = 1;
               if(param2)
               {
                  if(ScienceSystem.getinstance().Packarr[_loc6_].PropsNum > 1)
                  {
                     --ScienceSystem.getinstance().Packarr[_loc6_].PropsNum;
                  }
                  else if(ScienceSystem.getinstance().Packarr[_loc6_].PropsNum == 1)
                  {
                     ScienceSystem.getinstance().Packarr.splice(_loc6_,1);
                  }
               }
               return _loc3_;
            }
            _loc6_++;
         }
         var _loc7_:uint = 0;
         while(_loc7_ < ScienceSystem.getinstance().Packarr.length)
         {
            if(ScienceSystem.getinstance().Packarr[_loc7_].PropsId == param1 && ScienceSystem.getinstance().Packarr[_loc7_].LockFlag == 0)
            {
               _loc3_ = true;
               _loc4_ = false;
               this.lockflg = 0;
               if(param2)
               {
                  if(ScienceSystem.getinstance().Packarr[_loc7_].PropsNum > 1)
                  {
                     --ScienceSystem.getinstance().Packarr[_loc7_].PropsNum;
                  }
                  else if(ScienceSystem.getinstance().Packarr[_loc7_].PropsNum == 1)
                  {
                     ScienceSystem.getinstance().Packarr.splice(_loc7_,1);
                  }
               }
               return _loc3_;
            }
            _loc7_++;
         }
         return false;
      }
      
      public function pdHd(param1:int) : Boolean
      {
         var _loc2_:Boolean = false;
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         while(_loc4_ < ScienceSystem.getinstance().Packarr.length)
         {
            if(_loc4_ < ScienceSystem.getinstance().Packarr.length - 1)
            {
               if(ScienceSystem.getinstance().Packarr[_loc4_].PropsId == param1 && ScienceSystem.getinstance().Packarr[_loc4_].LockFlag == 0)
               {
                  _loc2_ = true;
                  _loc3_ += ScienceSystem.getinstance().Packarr[_loc4_].PropsNum;
               }
               else if(ScienceSystem.getinstance().Packarr[_loc4_].PropsId == param1 && ScienceSystem.getinstance().Packarr[_loc4_].LockFlag == 1)
               {
                  _loc2_ = true;
                  _loc3_ += ScienceSystem.getinstance().Packarr[_loc4_].PropsNum;
               }
            }
            else if(_loc4_ >= ScienceSystem.getinstance().Packarr.length - 1)
            {
               if(ScienceSystem.getinstance().Packarr[_loc4_].PropsId == param1 && ScienceSystem.getinstance().Packarr[_loc4_].LockFlag == 0)
               {
                  _loc3_ += ScienceSystem.getinstance().Packarr[_loc4_].PropsNum;
                  _loc2_ = true;
               }
               else if(ScienceSystem.getinstance().Packarr[_loc4_].PropsId == param1 && ScienceSystem.getinstance().Packarr[_loc4_].LockFlag == 1)
               {
                  _loc2_ = true;
                  _loc3_ += ScienceSystem.getinstance().Packarr[_loc4_].PropsNum;
               }
               else if(!_loc2_)
               {
                  _loc2_ = false;
                  this.fuhuoNum = 0;
                  return _loc2_;
               }
            }
            _loc4_++;
         }
         this.fuhuoNum = _loc3_;
         return _loc2_;
      }
      
      public function UpdateYfHd(param1:int, param2:int) : void
      {
         var _loc3_:uint = 0;
         while(_loc3_ < ScienceSystem.getinstance().Packarr.length)
         {
            if(ScienceSystem.getinstance().Packarr[_loc3_].PropsId == param1 && ScienceSystem.getinstance().Packarr[_loc3_].LockFlag == param2)
            {
               if(ScienceSystem.getinstance().Packarr[_loc3_].PropsNum > 1)
               {
                  --ScienceSystem.getinstance().Packarr[_loc3_].PropsNum;
                  return;
               }
               if(ScienceSystem.getinstance().Packarr[_loc3_].PropsNum == 1)
               {
                  ScienceSystem.getinstance().Packarr.splice(_loc3_,1);
                  return;
               }
            }
            _loc3_++;
         }
      }
   }
}

