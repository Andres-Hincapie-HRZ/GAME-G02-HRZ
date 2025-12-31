package logic.ui.tip
{
   import com.star.frameworks.managers.StringManager;
   import flash.geom.Point;
   import logic.entry.shipmodel.ShipbodyInfo;
   import logic.reader.CShipmodelReader;
   import logic.ui.info.AbstractInfoDecorate;
   
   public class ShipBodyInfoTip
   {
      
      private static var instance:ShipBodyInfoTip;
      
      private var infoDecorate:AbstractInfoDecorate;
      
      public function ShipBodyInfoTip()
      {
         super();
         this.infoDecorate = new AbstractInfoDecorate();
         this.infoDecorate.Load("BodyInfoTip");
      }
      
      public static function GetInstance() : ShipBodyInfoTip
      {
         if(instance == null)
         {
            instance = new ShipBodyInfoTip();
         }
         return instance;
      }
      
      public function Hide() : void
      {
         this.infoDecorate.Hide();
         CustomTip.GetInstance().Hide();
      }
      
      public function Show(param1:int, param2:Point) : void
      {
         var _loc3_:ShipbodyInfo = CShipmodelReader.getInstance().getShipBodyInfo(param1);
         this.infoDecorate.Update("Name",StringManager.getInstance().getMessageString("MailText17") + _loc3_.Name);
         this.infoDecorate.Update("GroupLV",StringManager.getInstance().getMessageString("DesignText5") + _loc3_.GroupLV);
         this.infoDecorate.Update("KindName",StringManager.getInstance().getMessageString("MailText16") + _loc3_.KindName);
         this.infoDecorate.Update("Locomotivity",StringManager.getInstance().getMessageString("DesignText6") + _loc3_.Locomotivity);
         this.infoDecorate.Update("Storage",StringManager.getInstance().getMessageString("DesignText7") + _loc3_.Storage);
         this.infoDecorate.Update("Endure",StringManager.getInstance().getMessageString("DesignText8") + _loc3_.Endure);
         this.infoDecorate.Update("Shield",StringManager.getInstance().getMessageString("DesignText9") + _loc3_.Shield);
         this.infoDecorate.Update("CreateTime",StringManager.getInstance().getMessageString("DesignText10") + this.GetTimeString(_loc3_.CreateTime));
         this.infoDecorate.putDecorate();
         this.infoDecorate.Show(param2.x,param2.y);
      }
      
      private function GetTimeString(param1:int) : String
      {
         var _loc2_:uint = uint(param1 / 60 / 60 >> 0);
         var _loc3_:uint = param1 / 60 % 60;
         var _loc4_:uint = param1 % 60;
         return _loc2_ + ":" + _loc3_ + ":" + _loc4_;
      }
      
      public function ShowSimple(param1:int, param2:Point, param3:Boolean = false) : void
      {
         var _loc4_:ShipbodyInfo = CShipmodelReader.getInstance().getShipBodyInfo(param1);
         var _loc5_:String = CustomTip.GetInstance().GetStringText(StringManager.getInstance().getMessageString("MailText17"),_loc4_.Name);
         _loc5_ = _loc5_ + ("\n\n" + CustomTip.GetInstance().GetStringText(StringManager.getInstance().getMessageString("Text5"),StringManager.getInstance().getMessageString("Text" + (6 + _loc4_.DefendType))));
         if(_loc4_.Comment != "")
         {
            _loc5_ += "\n\n" + _loc4_.Comment;
         }
         if(param3)
         {
            _loc5_ += "\n\n<font size=\'12\' color=\'#FF0000\'>" + _loc4_.Comment2 + "</font>";
         }
         CustomTip.GetInstance().Show(_loc5_,param2);
      }
   }
}

