package logic.utils
{
   import com.star.frameworks.managers.StringManager;
   import flash.display.MovieClip;
   import flash.filters.ColorMatrixFilter;
   import flash.text.TextFormat;
   import logic.entry.ScienceSystem;
   import logic.reader.CScienceReader;
   import logic.ui.AirshipUi;
   import logic.ui.BuildChargeUI;
   import logic.ui.FlattopUi;
   import logic.ui.MissileUi;
   import logic.ui.OpticsUi;
   import logic.ui.ResgatherUi;
   import logic.ui.TrajectoryUi;
   
   public class RegisteredData
   {
      
      private static var instance:RegisteredData;
      
      public var tiplen:int = 220;
      
      public var duilie:int = 1;
      
      public var alph:Number = 0.8;
      
      public var colormatrix:Number = 100;
      
      public var pdd:Boolean;
      
      private var techarr:Array = new Array();
      
      public var levelarr:Array = new Array();
      
      public var tf:TextFormat = new TextFormat();
      
      public var textformat:TextFormat = new TextFormat();
      
      public var money:int = 0;
      
      public var pdcolorarr:Array = new Array();
      
      private var sst:String = "";
      
      private var kkt:String = "";
      
      private var eet:String = "";
      
      private var wbb:String = "";
      
      private var fft:String = "";
      
      private var ggt:String = "";
      
      public function RegisteredData()
      {
         super();
         this.tf.color = 16777215;
         this.textformat.color = 3407616;
         this.kkt = "<font size=\'12\' color=\'#ff0000\'>";
         this.eet = "<font size=\'12\' color=\'#ffffff\'>";
         this.wbb = "</font>";
         this.fft = "<font size=\'12\' color=\'#ffffff\'>";
         this.ggt = "<font size=\'12\' color=\'#ff9900\'>";
      }
      
      public static function getInstance() : RegisteredData
      {
         if(instance == null)
         {
            instance = new RegisteredData();
         }
         return instance;
      }
      
      public function hs(param1:uint, param2:uint, param3:MovieClip) : void
      {
         var _loc4_:ColorMatrix = new ColorMatrix();
         _loc4_.adjustSaturation(0);
         var _loc5_:ColorMatrix = new ColorMatrix();
         _loc5_.adjustSaturation(-100);
         var _loc6_:uint = 0;
         var _loc7_:uint = McBitmap.getInstance().mcarr.length;
         var _loc8_:uint = _loc6_;
         while(_loc8_ < _loc7_)
         {
            if(_loc8_ >= param1 && _loc8_ < param2)
            {
               param3["mc_base" + _loc8_].gotoAndStop(1);
               param3["mc_base" + _loc8_].mc_plan.visible = false;
            }
            McBitmap.getInstance().mcarr[_loc8_].filters = [new ColorMatrixFilter(_loc4_)];
            McBitmap.getInstance().mcarr[_loc8_].alpha = 1;
            this.ppd(_loc8_);
            if(!this.pdd)
            {
               if(_loc8_ >= param1 && _loc8_ < param2)
               {
                  param3["mc_base" + _loc8_].gotoAndStop(2);
               }
               McBitmap.getInstance().mcarr[_loc8_].filters = [new ColorMatrixFilter(_loc5_)];
               McBitmap.getInstance().mcarr[_loc8_].alpha = RegisteredData.getInstance().alph;
            }
            _loc8_++;
         }
      }
      
      public function zsqs(param1:uint, param2:uint, param3:int) : void
      {
         var _loc8_:int = 0;
         var _loc4_:ColorMatrix = new ColorMatrix();
         _loc4_.adjustSaturation(0);
         var _loc5_:ColorMatrix = new ColorMatrix();
         _loc5_.adjustSaturation(-100);
         param1 = 0;
         param2 = McBitmap.getInstance().mcarr.length;
         var _loc6_:uint = param1;
         while(_loc6_ < param2)
         {
            McBitmap.getInstance().mcarr[_loc6_].filters = [new ColorMatrixFilter(_loc5_)];
            _loc6_++;
         }
         var _loc7_:uint = 0;
         while(_loc7_ < ScienceSystem.getinstance().Allarr.length)
         {
            _loc8_ = int(ScienceSystem.getinstance().Allarr[_loc7_].TechId);
            if(_loc8_ < 64)
            {
               if(ScienceSystem.getinstance().Allarr[_loc7_].levelId == CScienceReader.getInstance().weaponarr[_loc8_].length)
               {
                  McBitmap.getInstance().mcarr[_loc8_].filters = [new ColorMatrixFilter(_loc4_)];
               }
            }
            else if(_loc8_ >= 70 && _loc8_ < 97)
            {
               if(ScienceSystem.getinstance().Allarr[_loc7_].levelId == CScienceReader.getInstance().defencearr[_loc8_].length)
               {
                  McBitmap.getInstance().mcarr[_loc8_].filters = [new ColorMatrixFilter(_loc4_)];
               }
            }
            else if(_loc8_ >= 100 && _loc8_ < 111)
            {
               if(ScienceSystem.getinstance().Allarr[_loc7_].levelId == CScienceReader.getInstance().techarr[_loc8_].length)
               {
                  McBitmap.getInstance().mcarr[_loc8_].filters = [new ColorMatrixFilter(_loc4_)];
               }
            }
            _loc7_++;
         }
         McBitmap.getInstance().mcarr[param3].filters = [new ColorMatrixFilter(_loc4_)];
      }
      
      public function MoneyDouHao(param1:int = 0) : String
      {
         var _loc2_:String = String(param1);
         var _loc3_:Array = new Array();
         _loc3_.length = 0;
         var _loc4_:uint = 0;
         var _loc5_:int = _loc2_.length - 1;
         while(_loc5_ >= 0)
         {
            _loc3_[_loc5_] = _loc2_.charAt(_loc5_);
            if(++_loc4_ % 3 == 0 && _loc4_ != _loc2_.length)
            {
               _loc3_[_loc5_] = "," + _loc2_.charAt(_loc5_);
            }
            _loc5_--;
         }
         var _loc6_:String = "";
         var _loc7_:uint = 0;
         while(_loc7_ < _loc3_.length)
         {
            _loc6_ += _loc3_[_loc7_];
            _loc7_++;
         }
         return _loc6_;
      }
      
      public function ppd(param1:uint) : void
      {
         var _loc7_:Array = null;
         var _loc2_:Array = new Array();
         _loc2_.length = 0;
         this.techarr.length = 0;
         if(param1 < 64)
         {
            _loc2_ = String(CScienceReader.getInstance().WeaponTechAry[param1].tech).split(";");
            if(param1 < 16)
            {
               this.levelarr = TrajectoryUi.getInstance().levelarr;
            }
            else if(param1 >= 16 && param1 < 32)
            {
               this.levelarr = OpticsUi.getInstance().levelarr;
            }
            else if(param1 >= 32 && param1 < 48)
            {
               this.levelarr = MissileUi.getInstance().levelarr;
            }
            else if(param1 >= 48 && param1 < 64)
            {
               this.levelarr = FlattopUi.getInstance().levelarr;
            }
         }
         else if(param1 >= 70 && param1 < 97)
         {
            _loc2_ = String(CScienceReader.getInstance().DefenceTechAry[param1].tech).split(";");
            if(param1 < 89)
            {
               this.levelarr = AirshipUi.getInstance().levelarr;
            }
            else if(param1 >= 89)
            {
               this.levelarr = BuildChargeUI.getInstance().levelarr;
            }
         }
         else if(param1 >= 100 && param1 < 111)
         {
            _loc2_ = String(CScienceReader.getInstance().TechArr[param1].tech).split(";");
            this.levelarr = ResgatherUi.getInstance().levelarr;
         }
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc7_ = new Array();
            _loc7_.length = 0;
            _loc7_ = _loc2_[_loc3_].split(":");
            this.techarr.push(_loc7_);
            _loc3_++;
         }
         var _loc4_:int = 1;
         this.pdcolorarr.length = 0;
         var _loc5_:uint = 0;
         while(_loc5_ < this.techarr.length)
         {
            _loc4_ = 1;
            if(this.levelarr[this.techarr[_loc5_][0]] < this.techarr[_loc5_][1])
            {
               _loc4_ = 0;
            }
            else
            {
               _loc4_ = 2;
            }
            this.pdcolorarr.push(_loc4_);
            _loc5_++;
         }
         var _loc6_:uint = 0;
         while(_loc6_ < this.pdcolorarr.length)
         {
            if(this.pdcolorarr[_loc6_] == 0)
            {
               this.pdd = false;
               break;
            }
            if(_loc6_ == this.pdcolorarr.length - 1 && this.pdcolorarr[_loc6_] == 2)
            {
               this.pdd = true;
               break;
            }
            _loc6_++;
         }
      }
      
      public function GetHtml(param1:String) : String
      {
         this.sst = "";
         var _loc2_:Array = new Array();
         _loc2_.length = 0;
         _loc2_ = param1.split(StringManager.getInstance().getMessageString("TechnologyBtn10"));
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_.length)
         {
            if(_loc3_ < _loc2_.length - 1)
            {
               _loc2_[_loc3_] += StringManager.getInstance().getMessageString("TechnologyBtn10");
            }
            if(this.pdcolorarr[_loc3_] == 0)
            {
               this.sst += this.kkt + _loc2_[_loc3_] + this.wbb;
            }
            else
            {
               this.sst += this.eet + _loc2_[_loc3_] + this.wbb;
            }
            _loc3_++;
         }
         return this.sst;
      }
      
      public function GetConHtml(param1:String) : String
      {
         this.sst = "";
         var _loc2_:Array = new Array();
         _loc2_.length = 0;
         _loc2_ = param1.split(StringManager.getInstance().getMessageString("TechnologyBtn12"));
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_.length)
         {
            if(_loc3_ < _loc2_.length - 1)
            {
               _loc2_[_loc3_] += StringManager.getInstance().getMessageString("TechnologyBtn12");
            }
            if(_loc3_ == 0)
            {
               this.sst += this.fft + _loc2_[_loc3_] + this.wbb;
            }
            if(_loc3_ == 1)
            {
               this.sst += "<br>" + this.ggt + _loc2_[_loc3_] + this.wbb;
            }
            _loc3_++;
         }
         return this.sst;
      }
   }
}

