package logic.entry.props
{
   import logic.entry.commander.CommanderXmlInfo;
   
   public class PackPropsInfo
   {
      
      public var Id:int;
      
      public var _PropsInfo:propsInfo;
      
      public var Num:int;
      
      public var LockFlag:int;
      
      public var Grade:int;
      
      public var Type:int;
      
      public var CommanderType:int;
      
      public var aCommanderInfo:CommanderXmlInfo;
      
      public function PackPropsInfo()
      {
         super();
      }
   }
}

