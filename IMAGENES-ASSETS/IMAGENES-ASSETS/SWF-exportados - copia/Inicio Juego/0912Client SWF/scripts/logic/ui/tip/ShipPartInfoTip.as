package logic.ui.tip
{
   import com.star.frameworks.managers.StringManager;
   import flash.geom.Point;
   import logic.entry.shipmodel.ShippartInfo;
   import logic.reader.CShipmodelReader;
   import logic.ui.info.AbstractInfoDecorate;
   
   public class ShipPartInfoTip
   {
      
      private static var instance:ShipPartInfoTip;
      
      private var infoDecorate:AbstractInfoDecorate;
      
      public function ShipPartInfoTip()
      {
         super();
         this.infoDecorate = new AbstractInfoDecorate();
         this.infoDecorate.Load("PartInfoTip");
      }
      
      public static function GetInstance() : ShipPartInfoTip
      {
         if(instance == null)
         {
            instance = new ShipPartInfoTip();
         }
         return instance;
      }
      
      public function Hide() : void
      {
         this.infoDecorate.Hide();
         CustomTip.GetInstance().Hide();
      }
      
      public function Show(param1:int, param2:Point, param3:Boolean = false) : void
      {
         var _loc5_:Number = NaN;
         var _loc6_:* = null;
         var _loc8_:Number = NaN;
         var _loc4_:ShippartInfo = CShipmodelReader.getInstance().getShipPartInfo(param1);
         if(_loc4_.FuncTypeId == 0)
         {
            this.infoDecorate.Update("Capture1",StringManager.getInstance().getMessageString("Text0"));
            _loc5_ = _loc4_.AssaultUpgrade;
            _loc6_ = "";
            if(_loc5_ > 0)
            {
               _loc6_ = " <font size=\'12\' color=\'#00FF00\'>(+" + int(_loc5_ * 100) + "%)</font>";
            }
            this.infoDecorate.Update("Value1",_loc4_._MinAssault + "-" + _loc4_._MaxAssault + _loc6_);
            _loc5_ = _loc4_.RangeUpgrade;
            _loc6_ = "";
            if(_loc5_ > 0)
            {
               _loc6_ = " <font size=\'12\' color=\'#00FF00\'>(+" + _loc5_ + ")</font>";
            }
            this.infoDecorate.Update("Capture2",StringManager.getInstance().getMessageString("Text1"));
            this.infoDecorate.Update("Value2",_loc4_._MinRange + "-" + _loc4_._MaxRange + _loc6_);
            _loc5_ = _loc4_.BackfillUpgrade;
            _loc6_ = "";
            if(_loc5_ > 0)
            {
               _loc6_ = " <font size=\'12\' color=\'#00FF00\'>(-" + _loc5_ + ")</font>";
            }
            this.infoDecorate.Update("Capture3",StringManager.getInstance().getMessageString("Text2"));
            this.infoDecorate.Update("Value3",_loc4_._Backfill.toString() + _loc6_);
            _loc5_ = _loc4_.CubageUpgrade;
            _loc6_ = "";
            if(_loc5_ > 0)
            {
               _loc6_ = " <font size=\'12\' color=\'#00FF00\'>(-" + int(_loc5_ * 100) + "%)</font>";
            }
            this.infoDecorate.Update("Capture4",StringManager.getInstance().getMessageString("Text3"));
            this.infoDecorate.Update("Value4",_loc4_._Cubage.toString() + _loc6_);
            _loc5_ = _loc4_.SupplyUpgrade;
            _loc6_ = "";
            if(_loc5_ > 0)
            {
               _loc6_ = " <font size=\'12\' color=\'#00FF00\'>(-" + int(_loc5_ * 100) + "%)</font>";
            }
            this.infoDecorate.Update("Capture5",StringManager.getInstance().getMessageString("Text4"));
            this.infoDecorate.Update("Value5",_loc4_._Supply.toString() + _loc6_);
            if(_loc4_.KindId != 11)
            {
               this.infoDecorate.Update("Capture6",StringManager.getInstance().getMessageString("Text6"));
               this.infoDecorate.Update("Value6",StringManager.getInstance().getMessageString("Text" + (_loc4_.HurtType + 1)));
            }
            else
            {
               this.infoDecorate.Update("Capture6","");
               this.infoDecorate.Update("Value6","");
            }
            if(_loc4_.KindId == 12)
            {
               this.infoDecorate.Update("Capture7",StringManager.getInstance().getMessageString("Text22"));
               this.infoDecorate.Update("Value7",_loc4_.Turn.toString());
               this.infoDecorate.Update("Capture8","");
               this.infoDecorate.Update("Value8","");
            }
            else if(_loc4_.KindId == 13)
            {
               this.infoDecorate.Update("Capture7",StringManager.getInstance().getMessageString("Text22"));
               _loc8_ = _loc4_.TurnUpgrade;
               if(_loc8_ > 0)
               {
                  this.infoDecorate.Update("Value7",_loc4_.Turn + " <font size=\'12\' color=\'#00FF00\'>(+" + int(_loc8_ * 100) + "%)</font>");
               }
               else
               {
                  this.infoDecorate.Update("Value7",_loc4_.Turn.toString());
               }
               this.infoDecorate.Update("Capture8","");
               this.infoDecorate.Update("Value8","");
            }
            else if(_loc4_.KindId == 14)
            {
               this.infoDecorate.Update("Capture7",StringManager.getInstance().getMessageString("Text22"));
               _loc8_ = _loc4_.TurnUpgrade;
               if(_loc8_ > 0)
               {
                  this.infoDecorate.Update("Value7",_loc4_.Turn + " <font size=\'12\' color=\'#00FF00\'>(+" + int(_loc8_ * 100) + "%)</font>");
               }
               else
               {
                  this.infoDecorate.Update("Value7",_loc4_.Turn.toString());
               }
               this.infoDecorate.Update("Capture8",StringManager.getInstance().getMessageString("Text23"));
               _loc8_ = _loc4_.DecHeadoffUpgrade;
               if(_loc8_ > 0)
               {
                  this.infoDecorate.Update("Value8",int(_loc4_.Headoff * 100) + "% <font size=\'12\' color=\'#00FF00\'>(-" + int(_loc8_ * 100) + "%)</font>");
               }
               else
               {
                  this.infoDecorate.Update("Value8",int(_loc4_.Headoff * 100) + "%");
               }
            }
            else if(_loc4_.KindId == 15)
            {
               this.infoDecorate.Update("Capture7",StringManager.getInstance().getMessageString("Text22"));
               _loc8_ = _loc4_.TurnUpgrade;
               if(_loc8_ > 0)
               {
                  this.infoDecorate.Update("Value7",_loc4_.Turn + " <font size=\'12\' color=\'#00FF00\'>(+" + int(_loc8_ * 100) + "%)</font>");
               }
               else
               {
                  this.infoDecorate.Update("Value7",_loc4_.Turn.toString());
               }
               this.infoDecorate.Update("Capture8",StringManager.getInstance().getMessageString("Text23"));
               _loc8_ = _loc4_.DecHeadoffUpgrade;
               if(_loc8_ > 0)
               {
                  this.infoDecorate.Update("Value8",int(_loc4_.Headoff * 100) + "% <font size=\'12\' color=\'#00FF00\'>(-" + int(_loc8_ * 100) + "%)</font>");
               }
               else
               {
                  this.infoDecorate.Update("Value8",int(_loc4_.Headoff * 100) + "%");
               }
            }
            else
            {
               this.infoDecorate.Update("Capture7","");
               this.infoDecorate.Update("Value7","");
               this.infoDecorate.Update("Capture8","");
               this.infoDecorate.Update("Value8","");
            }
         }
         else
         {
            this.infoDecorate.Update("Capture1",StringManager.getInstance().getMessageString("Text3"));
            this.infoDecorate.Update("Value1",_loc4_.Cubage.toString());
            this.infoDecorate.Update("Capture2",StringManager.getInstance().getMessageString("Text4"));
            this.infoDecorate.Update("Value2",_loc4_.Supply.toString());
            this.infoDecorate.Update("Capture3","");
            this.infoDecorate.Update("Value3","");
            this.infoDecorate.Update("Capture4","");
            this.infoDecorate.Update("Value4","");
            this.infoDecorate.Update("Capture5","");
            this.infoDecorate.Update("Value5","");
            this.infoDecorate.Update("Capture6","");
            this.infoDecorate.Update("Value6","");
            this.infoDecorate.Update("Capture7","");
            this.infoDecorate.Update("Value7","");
            this.infoDecorate.Update("Capture8","");
            this.infoDecorate.Update("Value8","");
         }
         this.infoDecorate.Update("Metal",_loc4_.Metal.toString());
         this.infoDecorate.Update("He3",_loc4_.He3.toString());
         this.infoDecorate.Update("Fund",_loc4_.Money.toString());
         var _loc7_:* = "";
         if(param3)
         {
            _loc7_ = "<font size=\'12\' color=\'#FF0000\'>" + _loc4_.Comment2 + "</font>\n\n";
         }
         _loc7_ += _loc4_.Comment;
         this.infoDecorate.Update("Comment",_loc7_);
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
      
      public function ShowSimple(param1:int, param2:Point) : void
      {
         var _loc3_:ShippartInfo = CShipmodelReader.getInstance().getShipPartInfo(param1);
         var _loc4_:String = _loc3_.Name;
         CustomTip.GetInstance().Show(_loc4_,param2);
      }
   }
}

