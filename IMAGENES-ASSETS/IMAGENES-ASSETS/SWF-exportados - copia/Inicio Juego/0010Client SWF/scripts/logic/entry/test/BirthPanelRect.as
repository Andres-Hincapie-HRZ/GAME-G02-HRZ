package logic.entry.test
{
   import flash.display.Shape;
   
   public class BirthPanelRect extends Shape
   {
      
      public function BirthPanelRect(param1:int, param2:int, param3:int, param4:int, param5:Number = 0.3)
      {
         super();
         this.name = "HPanel";
         graphics.clear();
         graphics.lineStyle(1,0,0.5,true);
         graphics.beginFill(12303308,param5);
         graphics.drawRoundRect(0,0,param3 - 1,param4 - 1,7,7);
         this.x = param1;
         this.y = param2;
      }
   }
}

