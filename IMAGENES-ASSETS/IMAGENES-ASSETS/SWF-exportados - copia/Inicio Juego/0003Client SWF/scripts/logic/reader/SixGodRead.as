package logic.reader
{
   import com.star.frameworks.managers.ResManager;
   import logic.entry.FlagShip;
   import logic.entry.FlagShipPart;
   import logic.entry.props.propsInfo;
   import logic.game.GameKernel;
   
   public class SixGodRead
   {
      
      private static var instance:SixGodRead;
      
      public var m_sixGodAry:Array;
      
      public function SixGodRead()
      {
         var _loc2_:XML = null;
         var _loc3_:XMLList = null;
         var _loc4_:XML = null;
         var _loc5_:propsInfo = null;
         var _loc6_:FlagShip = null;
         var _loc7_:Array = null;
         var _loc8_:Array = null;
         var _loc9_:String = null;
         var _loc10_:int = 0;
         var _loc11_:FlagShipPart = null;
         var _loc12_:int = 0;
         super();
         this.m_sixGodAry = new Array();
         var _loc1_:XML = GameKernel.resManager.getXml(ResManager.GAMERES,"Props");
         for each(_loc2_ in _loc1_.*)
         {
            if(_loc2_.@ID == "0")
            {
               _loc3_ = _loc2_.*;
               for each(_loc4_ in _loc3_)
               {
                  if(_loc4_.@MaogeID == "1")
                  {
                     _loc5_ = new propsInfo();
                     _loc6_ = new FlagShip();
                     _loc6_.PropsId = _loc4_.@PropsId;
                     _loc6_.PropsInfo = CPropsReader.getInstance().GetPropsInfo(_loc4_.@PropsId);
                     _loc6_.NeedMoney = 1000000;
                     _loc7_ = String(_loc4_.@SynthesisID).split(";");
                     _loc8_ = new Array();
                     for each(_loc9_ in _loc7_)
                     {
                        _loc11_ = new FlagShipPart();
                        _loc12_ = int(_loc9_.indexOf(":"));
                        _loc11_.PropsId = parseInt(_loc9_.substr(0,_loc12_));
                        _loc11_.PropsInfo = CPropsReader.getInstance().GetPropsInfo(_loc11_.PropsId);
                        _loc11_.Num = parseInt(_loc9_.substr(_loc12_ + 1));
                        _loc8_.push(_loc11_);
                     }
                     _loc10_ = 0;
                     while(_loc10_ < 6)
                     {
                        if(_loc10_ < _loc8_.length - 1)
                        {
                           _loc6_.NeedParts[_loc10_] = _loc8_[_loc10_];
                        }
                        else if(_loc10_ == _loc8_.length - 1)
                        {
                           _loc6_.NeedParts[5] = _loc8_[_loc10_];
                           if(_loc10_ != 5)
                           {
                              _loc6_.NeedParts[_loc10_] = null;
                           }
                        }
                        else
                        {
                           _loc6_.NeedParts[_loc10_] = null;
                        }
                        _loc10_++;
                     }
                     this.m_sixGodAry.push(_loc6_);
                  }
               }
            }
         }
      }
      
      public static function getInstance() : SixGodRead
      {
         if(instance == null)
         {
            instance = new SixGodRead();
         }
         return instance;
      }
   }
}

