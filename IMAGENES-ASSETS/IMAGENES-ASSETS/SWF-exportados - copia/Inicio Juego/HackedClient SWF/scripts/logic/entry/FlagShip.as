package logic.entry
{
   import logic.entry.props.propsInfo;
   
   public class FlagShip
   {
      
      public var PropsId:int;
      
      public var PropsInfo:propsInfo;
      
      public var NeedMoney:int;
      
      public var NeedParts:Array;
      
      public function FlagShip()
      {
         super();
         this.NeedParts = new Array();
      }
   }
}

