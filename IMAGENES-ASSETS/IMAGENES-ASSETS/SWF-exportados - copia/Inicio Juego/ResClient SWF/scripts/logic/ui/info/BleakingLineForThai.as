package logic.ui.info
{
   import com.star.frameworks.utils.HashSet;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   import logic.entry.GamePlayer;
   
   public class BleakingLineForThai
   {
      
      private static var _instance:BleakingLineForThai;
      
      private var BleakSpaceList:Array = new Array();
      
      private var SearchId:int;
      
      private var tfList:HashSet;
      
      public function BleakingLineForThai()
      {
         super();
         this.tfList = new HashSet();
      }
      
      public static function GetInstance() : BleakingLineForThai
      {
         if(_instance == null)
         {
            _instance = new BleakingLineForThai();
         }
         return _instance;
      }
      
      public function BleakThaiLanguage(param1:TextField, param2:int = -1, param3:Boolean = true) : void
      {
         var _loc6_:String = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         if(GamePlayer.getInstance().language != 7)
         {
            if(param3)
            {
               this.BleakArabiaLanguage(param1,param2);
            }
            return;
         }
         if(param1.numLines <= 1)
         {
            this.SetDefaultColor(param1,param2);
            return;
         }
         this.GetBleakSpaceList(param1);
         var _loc4_:int = param1.numLines;
         if(_loc4_ > 50)
         {
            _loc4_ = 50;
         }
         this.SearchId = 0;
         var _loc5_:int = 0;
         while(_loc5_ + 1 < _loc4_)
         {
            _loc6_ = param1.getLineText(_loc5_);
            if(_loc6_.charCodeAt(_loc6_.length - 1) >= 128)
            {
               _loc7_ = param1.getLineOffset(_loc5_);
               _loc8_ = _loc7_ + _loc6_.length - 1;
               _loc9_ = this.GetNearBleakSpace(_loc8_);
               if(_loc9_ > 0 && _loc9_ > _loc7_)
               {
                  param1.replaceText(_loc9_,_loc9_,"\n");
                  this.ResetBleakSpaceList();
               }
            }
            _loc5_++;
         }
         this.SetDefaultColor(param1,param2);
      }
      
      public function SetDefaultColor(param1:TextField, param2:int = -1) : void
      {
         if(param2 == 0)
         {
            return;
         }
         while(param1.htmlText.indexOf("#000000") > 0)
         {
            param1.htmlText = param1.htmlText.replace("#000000","#" + param2.toString(16));
         }
      }
      
      private function GetBleakSpaceList(param1:TextField) : void
      {
         this.BleakSpaceList.splice(0);
         var _loc2_:int = int(param1.text.indexOf(" "));
         while(_loc2_ >= 0)
         {
            param1.replaceText(_loc2_,_loc2_ + 1,"");
            this.BleakSpaceList.push(_loc2_);
            _loc2_ = int(param1.text.indexOf(" ",_loc2_ + 1));
         }
      }
      
      private function GetNearBleakSpace(param1:int) : int
      {
         while(this.SearchId < this.BleakSpaceList.length)
         {
            if(this.BleakSpaceList[this.SearchId] > param1 && this.SearchId > 0)
            {
               return this.BleakSpaceList[this.SearchId - 1];
            }
            ++this.SearchId;
         }
         return -1;
      }
      
      private function ResetBleakSpaceList() : void
      {
         var _loc1_:int = this.SearchId;
         while(_loc1_ < this.BleakSpaceList.length)
         {
            ++this.BleakSpaceList[_loc1_];
            _loc1_++;
         }
      }
      
      public function BleakThaiLanguage1(param1:TextField, param2:int = -1) : void
      {
         var _loc4_:String = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         if(GamePlayer.getInstance().language != 7)
         {
            return;
         }
         if(param1.numLines <= 0)
         {
            return;
         }
         var _loc3_:String = param1.getLineText(0);
         var _loc5_:int = param1.numLines;
         if(_loc5_ > 50)
         {
            _loc5_ = 50;
         }
         var _loc6_:int = 0;
         while(_loc6_ + 1 < _loc5_)
         {
            _loc4_ = param1.getLineText(_loc6_);
            _loc3_ = param1.getLineText(_loc6_ + 1);
            if(_loc4_ != "")
            {
               _loc7_ = int(_loc4_.charCodeAt(_loc4_.length - 1));
               if(_loc7_ >= 128)
               {
                  _loc8_ = int(_loc3_.charCodeAt(0));
                  if(_loc8_ >= 128)
                  {
                     _loc10_ = int(_loc4_.charCodeAt(_loc4_.length - 1));
                     _loc7_ = int(_loc3_.charCodeAt(0));
                     if(this.IsWordEnd2(_loc10_,_loc7_))
                     {
                        _loc9_ = param1.getLineOffset(_loc6_);
                        _loc9_ = _loc9_ + _loc4_.length - 2;
                        param1.replaceText(_loc9_,_loc9_,"\n");
                     }
                     else if(_loc3_.length > 1)
                     {
                        _loc8_ = int(_loc3_.charCodeAt(1));
                        if(this.IsWordEnd1(_loc10_,_loc7_,_loc8_))
                        {
                           _loc9_ = param1.getLineOffset(_loc6_);
                           _loc9_ = _loc9_ + _loc4_.length - 2;
                           param1.replaceText(_loc9_,_loc9_,"\n");
                        }
                        else if(_loc4_.length > 2)
                        {
                           _loc10_ = int(_loc4_.charCodeAt(_loc4_.length - 2));
                           _loc7_ = int(_loc4_.charCodeAt(_loc4_.length - 1));
                           _loc8_ = int(_loc3_.charCodeAt(0));
                           if(this.IsWordEnd1(_loc10_,_loc7_,_loc8_))
                           {
                              _loc9_ = param1.getLineOffset(_loc6_);
                              _loc9_ = _loc9_ + _loc4_.length - 3;
                              param1.replaceText(_loc9_,_loc9_,"\n");
                           }
                        }
                     }
                  }
               }
            }
            _loc6_++;
         }
         if(param2 == 0)
         {
            return;
         }
         while(param1.htmlText.indexOf("#000000") > 0)
         {
            param1.htmlText = param1.htmlText.replace("#000000","#" + param2.toString(16));
         }
      }
      
      private function IsWordEnd(param1:int, param2:int, param3:int) : Boolean
      {
         if(this.IsWordEnd1(param1,param2,param3) || this.IsWordEnd2(param1,param2))
         {
            return true;
         }
         return false;
      }
      
      private function IsWordEnd1(param1:int, param2:int, param3:int) : Boolean
      {
         var _loc4_:Boolean = false;
         switch(param2)
         {
            case 3656:
            case 3657:
            case 3658:
            case 3659:
               switch(param1)
               {
                  case 3633:
                  case 3636:
                  case 3637:
                  case 3638:
                  case 3639:
                     _loc4_ = true;
               }
               if(3635 == param3)
               {
                  _loc4_ = true;
               }
               break;
            case 3660:
               if(3636 == param1)
               {
                  _loc4_ = true;
               }
         }
         return _loc4_;
      }
      
      private function IsWordEnd2(param1:int, param2:int) : Boolean
      {
         var _loc3_:Boolean = false;
         switch(param2)
         {
            case 3633:
            case 3636:
            case 3637:
            case 3638:
            case 3639:
            case 3640:
            case 3641:
            case 3655:
               if(param1 >= 3585 && param1 <= 3630)
               {
                  _loc3_ = true;
               }
               break;
            case 3656:
            case 3657:
            case 3658:
            case 3659:
               if(3585 <= param1 && 3630 >= param1)
               {
                  _loc3_ = true;
               }
               if(param1 >= 3636 && param1 <= 3641)
               {
                  _loc3_ = true;
               }
               if(3633 == param1)
               {
                  _loc3_ = true;
               }
               break;
            case 3660:
               if(3585 <= param1 && 3630 >= param1)
               {
                  _loc3_ = true;
               }
               if(3636 == param1 || 3640 == param1)
               {
                  _loc3_ = true;
               }
               break;
            default:
               _loc3_ = true;
         }
         return _loc3_;
      }
      
      private function ResetTextField(param1:TextField) : void
      {
         var _loc2_:Rectangle = null;
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         var _loc5_:TextField = null;
         if(this.tfList.ContainsKey(param1))
         {
            _loc2_ = this.tfList.Get(param1);
            param1.x = _loc2_.x;
            param1.width = _loc2_.width;
         }
         else
         {
            this.tfList.Put(param1,new Rectangle(param1.x,0,param1.width));
         }
         if(this.tfList.Length() > 200)
         {
            _loc3_ = this.tfList.Keys();
            _loc4_ = 0;
            while(_loc4_ < 50)
            {
               _loc5_ = _loc3_[_loc4_];
               this.tfList.Remove(_loc5_);
               _loc4_++;
            }
         }
      }
      
      public function BleakArabiaLanguage(param1:TextField, param2:int = -1) : void
      {
         var _loc3_:String = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:String = null;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         if(GamePlayer.getInstance().language != 10)
         {
            return;
         }
         this.ClearHTML(param1);
         this.ResetTextField(param1);
         if(param1.numLines <= 1)
         {
            param1.autoSize = TextFieldAutoSize.RIGHT;
            param1.width = param1.textWidth + 25;
            this.SetDefaultColor(param1,param2);
            return;
         }
         if(param1.numLines > 1)
         {
            _loc4_ = param1.numLines;
            if(_loc4_ > 50)
            {
               _loc4_ = 50;
            }
            _loc5_ = 0;
            while(_loc5_ + 1 < _loc4_)
            {
               _loc3_ = param1.getLineText(_loc5_);
               if(_loc3_ != "")
               {
                  _loc6_ = param1.getLineOffset(_loc5_) + _loc3_.length - 1;
                  _loc7_ = int(_loc3_.charCodeAt(_loc3_.length - 1));
                  _loc8_ = int(_loc3_.charCodeAt(_loc3_.length - 2));
                  _loc9_ = param1.getLineText(_loc5_ + 1);
                  _loc10_ = int(_loc9_.charCodeAt(0));
                  if(_loc7_ == 32 && (_loc10_ > 128 || _loc10_ < 10) && _loc8_ != 37)
                  {
                     param1.replaceText(_loc6_,_loc6_,"\n");
                  }
                  else
                  {
                     _loc11_ = _loc3_.length - 2;
                     while(_loc11_ > 0)
                     {
                        _loc12_ = int(_loc3_.charCodeAt(_loc11_));
                        _loc13_ = int(_loc3_.charCodeAt(_loc11_ - 1));
                        _loc14_ = int(_loc3_.charCodeAt(_loc11_ + 1));
                        if(_loc12_ == 32 && (_loc14_ > 128 || _loc14_ < 10 || _loc14_ == 13) && _loc13_ != 37 && _loc14_ != 37)
                        {
                           if(_loc14_ == 13)
                           {
                              break;
                           }
                           param1.replaceText(_loc6_,_loc6_,"\n");
                           _loc4_ = param1.numLines;
                           if(_loc4_ > 50)
                           {
                              _loc4_ = 50;
                           }
                           break;
                        }
                        _loc6_--;
                        _loc11_--;
                     }
                  }
               }
               _loc5_++;
            }
         }
         this.SetDefaultColor(param1,param2);
         param1.width = param1.textWidth + 25;
      }
      
      private function PopFirstLine(param1:TextField) : String
      {
         var _loc5_:int = 0;
         if(param1.numLines <= 0)
         {
            return null;
         }
         var _loc2_:String = param1.getLineText(0);
         var _loc3_:String = param1.text;
         if(_loc3_ == "" || _loc3_ == null)
         {
            return null;
         }
         if(param1.numLines == 1)
         {
            param1.text = "";
            return _loc2_;
         }
         if(_loc2_.length < 10)
         {
            param1.text = "";
            return _loc2_;
         }
         var _loc4_:int = _loc2_.length - 2;
         if(_loc2_.charCodeAt(_loc4_) == 32)
         {
            param1.text = _loc3_.substr(_loc4_ + 1);
            return _loc2_;
         }
         if(_loc5_ + 1 < param1.numLines)
         {
            if(param1.text.charCodeAt(_loc2_.length + 1) == 32)
            {
               param1.text = _loc3_.substr(_loc4_ + 1);
               return _loc2_;
            }
         }
         _loc5_ = _loc2_.length - 2;
         while(_loc5_ >= 0)
         {
            if(_loc2_.charCodeAt(_loc5_) == 32)
            {
               _loc2_ = _loc2_.substr(0,_loc5_);
               param1.text = _loc3_.substr(_loc5_);
               return _loc2_;
            }
            _loc5_--;
         }
         param1.text = _loc3_.substr(_loc4_);
         return _loc2_;
      }
      
      public function ClearHtmlForAe(param1:String) : String
      {
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         if(GamePlayer.getInstance().language != 10)
         {
            return param1;
         }
         while(param1.indexOf(")") >= 0)
         {
            param1 = param1.replace("("," ");
            param1 = param1.replace(")"," ");
         }
         while(param1.indexOf("]") >= 0)
         {
            param1 = param1.replace("["," ");
            param1 = param1.replace("]"," ");
         }
         var _loc2_:RegExp = /٪/g;
         param1 = param1.replace(_loc2_,"%");
         _loc2_ = /（/g;
         param1 = param1.replace(_loc2_," ");
         _loc2_ = /）/g;
         param1 = param1.replace(_loc2_," ");
         _loc2_ = /，/g;
         param1 = param1.replace(_loc2_," ");
         _loc2_ = /。/g;
         param1 = param1.replace(_loc2_," ");
         _loc2_ = /-/g;
         param1 = param1.replace(_loc2_," ");
         _loc2_ = /\t/g;
         param1 = param1.replace(_loc2_," ");
         _loc2_ = /~/g;
         param1 = param1.replace(_loc2_,"\n");
         _loc2_ = new RegExp("</P>","g");
         param1 = param1.replace(_loc2_,"</P>\n");
         var _loc3_:int = int(param1.indexOf("<"));
         var _loc4_:int = 0;
         if(_loc3_ < 0)
         {
            return param1;
         }
         var _loc5_:String = "";
         if(_loc3_ > 0)
         {
            _loc5_ = param1.substr(0,_loc3_);
         }
         _loc4_ = _loc3_;
         _loc3_ = int(param1.indexOf(">"));
         while(_loc3_ >= 0)
         {
            _loc8_ = int(param1.indexOf("<",_loc3_));
            if(_loc8_ < 0)
            {
               _loc4_ = 0;
               break;
            }
            _loc5_ += param1.substr(_loc3_ + 1,_loc8_ - _loc3_ - 1);
            _loc4_ = _loc8_;
            _loc3_ = int(param1.indexOf(">",_loc8_));
            if(_loc3_ > 0)
            {
               _loc4_ = _loc3_ + 1;
            }
            _loc3_ = int(param1.indexOf(">",_loc3_));
         }
         if(_loc4_ > 0 && _loc4_ < param1.length)
         {
            _loc5_ += param1.substr(_loc4_);
         }
         while(_loc5_.indexOf("  ") > 0)
         {
            _loc5_ = _loc5_.replace("  "," ");
         }
         _loc5_ = _loc5_.replace("%.","%");
         var _loc6_:int = 0;
         var _loc7_:int = _loc5_.length - 1;
         while(_loc7_ >= 0)
         {
            _loc9_ = int(_loc5_.charCodeAt(_loc7_));
            if(_loc9_ > 128)
            {
               if(_loc6_ > 0)
               {
                  _loc5_ = _loc5_.substr(0,_loc7_ + 1) + "\n" + _loc5_.substr(_loc7_ + 1);
               }
               break;
            }
            if(_loc6_ > 0 && (_loc9_ == 13 || _loc9_ == 10))
            {
               break;
            }
            if(_loc9_ == 37)
            {
               _loc6_ = _loc7_;
            }
            _loc7_--;
         }
         return _loc5_;
      }
      
      private function ClearHTML(param1:TextField) : void
      {
         param1.autoSize = TextFieldAutoSize.RIGHT;
         var _loc2_:TextFormat = param1.getTextFormat();
         _loc2_.align = TextFormatAlign.RIGHT;
         param1.setTextFormat(_loc2_);
         param1.defaultTextFormat = _loc2_;
         var _loc3_:String = param1.htmlText;
         param1.text = this.ClearHtmlForAe(_loc3_);
      }
   }
}

