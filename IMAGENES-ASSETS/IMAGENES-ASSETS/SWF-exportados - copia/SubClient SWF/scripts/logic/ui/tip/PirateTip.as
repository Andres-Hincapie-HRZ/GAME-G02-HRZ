package logic.ui.tip
{
   import com.star.frameworks.managers.StringManager;
   import flash.geom.Point;
   import logic.reader.CorpsPirateReader;
   import logic.ui.info.AbstractInfoDecorate;
   
   public class PirateTip
   {
      
      private static var instance:PirateTip;
      
      private var infoDecorate:AbstractInfoDecorate;
      
      public function PirateTip()
      {
         super();
         this.infoDecorate = new AbstractInfoDecorate();
         this.infoDecorate.Load("PirateInfoTip");
         this.infoDecorate.ToolTip.SetMoveEvent();
      }
      
      public static function GetInstance() : PirateTip
      {
         if(instance == null)
         {
            instance = new PirateTip();
         }
         return instance;
      }
      
      public function Hide() : void
      {
         this.infoDecorate.Hide();
      }
      
      public function ShowPirateTip(param1:int, param2:Point, param3:int, param4:int, param5:int) : void
      {
         var _loc6_:XML = CorpsPirateReader.GetPirateInfo(param1);
         this.infoDecorate.Update("PirateName",_loc6_.@Name);
         this.infoDecorate.Update("Level","Lv:" + (int(_loc6_.@Level) + 1));
         this.infoDecorate.Update("Caption1",StringManager.getInstance().getMessageString("Pirate01"));
         this.infoDecorate.Update("Value1",_loc6_.@wealth);
         this.infoDecorate.setDisableState("Value1",_loc6_.@wealth > param3);
         this.infoDecorate.Update("Caption2",StringManager.getInstance().getMessageString("Pirate02"));
         this.infoDecorate.Update("Value2",_loc6_.@HonorNum);
         this.infoDecorate.Update("Caption3",StringManager.getInstance().getMessageString("Pirate03"));
         if(param1 > 0)
         {
            this.infoDecorate.Update("Value3",StringManager.getInstance().getMessageString("Pirate04") + _loc6_.@Level);
            this.infoDecorate.setDisableState("Value3",_loc6_.@Level - 1 > param4);
            this.infoDecorate.Update("Value4",StringManager.getInstance().getMessageString("Pirate21") + int(int(_loc6_.@CorpsLv) + 1));
            this.infoDecorate.setDisableState("Value4",param5 < int(_loc6_.@CorpsLv));
         }
         else
         {
            this.infoDecorate.Update("Value3",StringManager.getInstance().getMessageString("Pirate21") + int(int(_loc6_.@CorpsLv) + 1));
            this.infoDecorate.setDisableState("Value3",param5 < int(_loc6_.@CorpsLv));
            this.infoDecorate.Update("Value4","");
         }
         this.infoDecorate.Update("Comment",_loc6_.@Comment);
         this.infoDecorate.putDecorate();
         this.infoDecorate.Show(param2.x,param2.y);
      }
   }
}

