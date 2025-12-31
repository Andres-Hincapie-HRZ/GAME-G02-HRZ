package logic.entry
{
   import logic.entry.props.propsInfo;
   
   public class DiamondInfo
   {
      
      public var PropsId:int;
      
      public var SuspendID:int;
      
      public var GemLevel:int;
      
      public var GemKindID:int;
      
      public var GemValue:String;
      
      public var GemColor:int;
      
      public var Diamond:int;
      
      public var BlastHurt:Number;
      
      public var OrderID:int;
      
      public var Eolith:int;
      
      public var GemID:int;
      
      public var ResultGemList:Array;
      
      public var Gem1ID:int;
      
      public var PropsInfo:propsInfo;
      
      public var GemaValueList:Object;
      
      public function DiamondInfo()
      {
         super();
      }
      
      public function set ResultGem(param1:String) : void
      {
         this.ResultGemList = param1.split(";");
      }
   }
}

