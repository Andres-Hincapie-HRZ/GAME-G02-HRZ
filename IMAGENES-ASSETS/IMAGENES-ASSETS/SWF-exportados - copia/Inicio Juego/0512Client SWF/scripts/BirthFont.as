package
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class BirthFont
   {
      
      private static var letterBmp:Bitmap;
      
      private static var letterTexture:BitmapData;
      
      private static var _instance:BirthFont = null;
      
      private var Texture:Class = BirthFont_Texture;
      
      public function BirthFont(param1:HHH)
      {
         super();
         letterBmp = new this.Texture() as Bitmap;
         letterTexture = letterBmp.bitmapData;
      }
      
      public static function get instance() : BirthFont
      {
         if(_instance == null)
         {
            _instance = new BirthFont(new HHH());
         }
         return _instance;
      }
      
      public function getString(param1:String) : BitmapData
      {
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Array = new Array();
         var _loc4_:int = 0;
         while(_loc4_ < param1.length)
         {
            _loc3_.push(this.getCharWidth(param1.charAt(_loc4_)));
            _loc2_ += this.getCharWidth(param1.charAt(_loc4_));
            _loc4_++;
         }
         var _loc5_:BitmapData = new BitmapData(_loc2_,FCharCode.H);
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         while(_loc13_ < param1.length)
         {
            _loc9_ = this.getCharX(param1.charAt(_loc13_));
            _loc10_ = this.getCharY(param1.charAt(_loc13_));
            _loc8_ = int(_loc3_[_loc13_]);
            _loc7_ = FCharCode.H;
            if(_loc13_ > 0)
            {
               _loc11_ += _loc3_[_loc13_ - 1];
            }
            _loc5_.copyPixels(letterTexture,new Rectangle(_loc9_,_loc10_,_loc8_,_loc7_),new Point(_loc11_,_loc12_));
            _loc13_++;
         }
         return _loc5_;
      }
      
      private function getCharX(param1:String) : int
      {
         if(param1.length > 1)
         {
            return 0;
         }
         var _loc2_:int = int(param1.charCodeAt(0));
         var _loc3_:int = 0;
         if(_loc2_ == 32)
         {
            _loc3_ = 200;
         }
         else if(_loc2_ == 33)
         {
            _loc3_ = 10;
         }
         else if(_loc2_ == 126)
         {
            _loc3_ = 0;
         }
         else if(_loc2_ == 64)
         {
            _loc3_ = 13;
         }
         else if(_loc2_ == 35)
         {
            _loc3_ = 25;
         }
         else if(_loc2_ == 36)
         {
            _loc3_ = 34;
         }
         else if(_loc2_ == 37)
         {
            _loc3_ = 41;
         }
         else if(_loc2_ == 94)
         {
            _loc3_ = 54;
         }
         else if(_loc2_ == 38)
         {
            _loc3_ = 62;
         }
         else if(_loc2_ == 42)
         {
            _loc3_ = 72;
         }
         else if(_loc2_ == 40)
         {
            _loc3_ = 79;
         }
         else if(_loc2_ == 41)
         {
            _loc3_ = 84;
         }
         else if(_loc2_ == 95)
         {
            _loc3_ = 89;
         }
         else if(_loc2_ == 43)
         {
            _loc3_ = 97;
         }
         else if(_loc2_ == 45)
         {
            _loc3_ = 105;
         }
         else if(_loc2_ == 61)
         {
            _loc3_ = 110;
         }
         else if(_loc2_ == 47)
         {
            _loc3_ = 118;
         }
         else if(_loc2_ == 59)
         {
            _loc3_ = 128;
         }
         else if(_loc2_ == 58)
         {
            _loc3_ = 132;
         }
         else if(_loc2_ == 39)
         {
            _loc3_ = 135;
         }
         else if(_loc2_ == 44)
         {
            _loc3_ = 144;
         }
         else if(_loc2_ == 46)
         {
            _loc3_ = 148;
         }
         else if(_loc2_ == 60)
         {
            _loc3_ = 151;
         }
         else if(_loc2_ == 62)
         {
            _loc3_ = 159;
         }
         else if(_loc2_ == 63)
         {
            _loc3_ = 167;
         }
         else if(_loc2_ == 91)
         {
            _loc3_ = 174;
         }
         else if(_loc2_ == 93)
         {
            _loc3_ = 179;
         }
         else if(_loc2_ == 123)
         {
            _loc3_ = 184;
         }
         else if(_loc2_ == 125)
         {
            _loc3_ = 191;
         }
         else if(_loc2_ >= 48 && _loc2_ <= 57)
         {
            _loc2_ -= 48;
            _loc3_ = _loc2_ * FCharCode.m_32;
         }
         else if(_loc2_ >= 65 && _loc2_ <= 90)
         {
            _loc2_ -= 65;
            if(_loc2_ < 9)
            {
               _loc3_ = _loc2_ * FCharCode.A_W;
            }
            else if(_loc2_ == 9)
            {
               _loc3_ = FCharCode.A_W * 8 + FCharCode.IJ_W;
            }
            else if(_loc2_ > 9 && _loc2_ < 23)
            {
               _loc3_ = (_loc2_ - 2) * FCharCode.A_W + FCharCode.IJ_W * 2;
            }
            else if(_loc2_ >= 23 && _loc2_ < 26)
            {
               _loc3_ = (_loc2_ - 3) * FCharCode.A_W + FCharCode.IJ_W * 2 + FCharCode.W_W;
            }
         }
         else if(_loc2_ >= 97 && _loc2_ <= 122)
         {
            _loc2_ -= 97;
            if(_loc2_ < 5)
            {
               _loc3_ = _loc2_ * FCharCode.a_W;
            }
            else if(_loc2_ >= 5 && _loc2_ <= 8)
            {
               _loc3_ = (_loc2_ - 1) * FCharCode.a_W + FCharCode.frt_W;
            }
            else if(_loc2_ == 9)
            {
               _loc3_ = (_loc2_ - 2) * FCharCode.a_W + FCharCode.frt_W + FCharCode.il_W;
            }
            else if(_loc2_ > 9 && _loc2_ < 12)
            {
               _loc3_ = (_loc2_ - 3) * FCharCode.a_W + FCharCode.frt_W + FCharCode.il_W + FCharCode.j_W;
            }
            else if(_loc2_ == 12)
            {
               _loc3_ = (_loc2_ - 4) * FCharCode.a_W + FCharCode.frt_W + FCharCode.il_W * 2 + FCharCode.j_W;
            }
            else if(_loc2_ > 12 && _loc2_ <= 17)
            {
               _loc3_ = (_loc2_ - 5) * FCharCode.a_W + FCharCode.frt_W + FCharCode.il_W * 2 + FCharCode.j_W + FCharCode.mw_W;
            }
            else if(_loc2_ > 17 && _loc2_ <= 19)
            {
               _loc3_ = (_loc2_ - 6) * FCharCode.a_W + FCharCode.frt_W * 2 + FCharCode.il_W * 2 + FCharCode.j_W + FCharCode.mw_W;
            }
            else if(_loc2_ > 19 && _loc2_ <= 22)
            {
               _loc3_ = (_loc2_ - 7) * FCharCode.a_W + FCharCode.frt_W * 3 + FCharCode.il_W * 2 + FCharCode.j_W + FCharCode.mw_W;
            }
            else if(_loc2_ > 22 || _loc2_ <= 25)
            {
               _loc3_ = (_loc2_ - 8) * FCharCode.a_W + FCharCode.frt_W * 3 + FCharCode.il_W * 2 + FCharCode.j_W + FCharCode.mw_W * 2;
            }
         }
         return _loc3_;
      }
      
      private function getCharY(param1:String) : int
      {
         if(param1.length > 1)
         {
            return 0;
         }
         var _loc2_:int = int(param1.charCodeAt(0));
         var _loc3_:int = 0;
         if(_loc2_ >= 32 && _loc2_ <= 47 || _loc2_ >= 58 && _loc2_ <= 64 || _loc2_ >= 91 && _loc2_ <= 95 || _loc2_ >= 123 && _loc2_ <= 126)
         {
            _loc3_ = FCharCode.H * 3;
         }
         else if(_loc2_ >= 48 && _loc2_ <= 57)
         {
            _loc3_ = FCharCode.H * 2;
         }
         else if(_loc2_ >= 65 && _loc2_ <= 90)
         {
            _loc3_ = FCharCode.H * 0;
         }
         else if(_loc2_ >= 97 && _loc2_ <= 122)
         {
            _loc3_ = FCharCode.H * 1;
         }
         return _loc3_;
      }
      
      private function getCharWidth(param1:String) : int
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = FCharCode.H;
         if(param1.length > 1)
         {
            return 0;
         }
         var _loc6_:int = int(param1.charCodeAt(0));
         if(_loc6_ == 32)
         {
            _loc4_ = FCharCode.m_32;
         }
         else if(_loc6_ == 33)
         {
            _loc4_ = FCharCode.m_33;
         }
         else if(_loc6_ == 34)
         {
            _loc4_ = FCharCode.m_34;
         }
         else if(_loc6_ == 35)
         {
            _loc4_ = FCharCode.m_35;
         }
         else if(_loc6_ == 36)
         {
            _loc4_ = FCharCode.m_36;
         }
         else if(_loc6_ == 37)
         {
            _loc4_ = FCharCode.m_37;
         }
         else if(_loc6_ == 38)
         {
            _loc4_ = FCharCode.m_38;
         }
         else if(_loc6_ == 39)
         {
            _loc4_ = FCharCode.m_39;
         }
         else if(_loc6_ == 40)
         {
            _loc4_ = FCharCode.m_40;
         }
         else if(_loc6_ == 41)
         {
            _loc4_ = FCharCode.m_41;
         }
         else if(_loc6_ == 42)
         {
            _loc4_ = FCharCode.m_42;
         }
         else if(_loc6_ == 43)
         {
            _loc4_ = FCharCode.m_43;
         }
         else if(_loc6_ == 44)
         {
            _loc4_ = FCharCode.m_44;
         }
         else if(_loc6_ == 45)
         {
            _loc4_ = FCharCode.m_45;
         }
         else if(_loc6_ == 46)
         {
            _loc4_ = FCharCode.m_46;
         }
         else if(_loc6_ == 47)
         {
            _loc4_ = FCharCode.m_47;
         }
         else if(_loc6_ == 58)
         {
            _loc4_ = FCharCode.m_58;
         }
         else if(_loc6_ == 59)
         {
            _loc4_ = FCharCode.m_59;
         }
         else if(_loc6_ == 60)
         {
            _loc4_ = FCharCode.m_60;
         }
         else if(_loc6_ == 61)
         {
            _loc4_ = FCharCode.m_61;
         }
         else if(_loc6_ == 62)
         {
            _loc4_ = FCharCode.m_62;
         }
         else if(_loc6_ == 63)
         {
            _loc4_ = FCharCode.m_63;
         }
         else if(_loc6_ == 64)
         {
            _loc4_ = FCharCode.m_64;
         }
         else if(_loc6_ == 91)
         {
            _loc4_ = FCharCode.m_91;
         }
         else if(_loc6_ == 93)
         {
            _loc4_ = FCharCode.m_93;
         }
         else if(_loc6_ == 94)
         {
            _loc4_ = FCharCode.m_94;
         }
         else if(_loc6_ == 95)
         {
            _loc4_ = FCharCode.m_95;
         }
         else if(_loc6_ == 123)
         {
            _loc4_ = FCharCode.m_123;
         }
         else if(_loc6_ == 124)
         {
            _loc4_ = FCharCode.m_124;
         }
         else if(_loc6_ == 125)
         {
            _loc4_ = FCharCode.m_125;
         }
         else if(_loc6_ == 126)
         {
            _loc4_ = FCharCode.m_126;
         }
         else if(_loc6_ >= 48 && _loc6_ <= 57)
         {
            _loc4_ = FCharCode.m_32;
         }
         else if(_loc6_ >= 65 && _loc6_ <= 90)
         {
            _loc6_ -= 65;
            if(_loc6_ == 8 || _loc6_ == 9)
            {
               _loc4_ = FCharCode.IJ_W;
            }
            else if(_loc6_ == 22)
            {
               _loc4_ = FCharCode.W_W;
            }
            else
            {
               _loc4_ = FCharCode.A_W;
            }
         }
         else if(_loc6_ >= 97 && _loc6_ <= 122)
         {
            if(_loc6_ == 106)
            {
               _loc4_ = FCharCode.j_W;
            }
            else if(_loc6_ == 102 || _loc6_ == 114 || _loc6_ == 116)
            {
               _loc4_ = FCharCode.frt_W;
            }
            else if(_loc6_ == 105 || _loc6_ == 108)
            {
               _loc4_ = FCharCode.il_W;
            }
            else if(_loc6_ == 109 || _loc6_ == 119)
            {
               _loc4_ = FCharCode.mw_W;
            }
            else
            {
               _loc4_ = FCharCode.a_W;
            }
         }
         return _loc4_;
      }
   }
}

class HHH
{
   
   public function HHH()
   {
      super();
   }
}
