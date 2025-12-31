package logic.widget
{
   import com.star.frameworks.managers.StringManager;
   import com.star.frameworks.utils.StringUitl;
   import logic.action.ChatAction;
   import logic.entry.ChannelEnum;
   import logic.entry.GamePlayer;
   import logic.ui.ChatUI;
   
   public class ChatModuleUtil
   {
      
      public function ChatModuleUtil()
      {
         super();
      }
      
      public static function createTxtLink(param1:int, param2:int, param3:String, param4:String, param5:String = "#FFFFFF") : String
      {
         var guid:int = param1;
         var targetType:int = param2;
         var userName:String = param3;
         var content:String = param4;
         var txtColor:String = param5;
         try
         {
            return createTxtLink2(guid,targetType,userName,content,txtColor);
         }
         catch(e:*)
         {
            return "";
         }
      }
      
      private static function ClearFlag(param1:String) : String
      {
         if(param1 != null)
         {
            while(param1.indexOf("\"") >= 0)
            {
               param1 = param1.replace("\"","\'");
            }
         }
         return param1;
      }
      
      public static function createTxtLink2(param1:int, param2:int, param3:String, param4:String, param5:String = "#FFFFFF") : String
      {
         var rank_name:String = null;
         var rank_color:String = null;
         var _loc8_:Array = null;
         var _loc11_:String = null;
         var _loc12_:int = 0;
         var _loc13_:Array = null;
         var _loc14_:String = null;
         var _loc15_:String = null;
         var _loc16_:String = null;
         var _loc17_:int = 0;
         var _loc18_:Array = null;
         var _loc19_:String = null;
         var _loc20_:String = null;
         var _loc21_:String = null;
         var _loc6_:* = "";
         var _loc7_:String = "";
         var _loc9_:String = param3;
         param4 = filterHtmlCode(param4);
         _loc6_ += "<font size=\'12\' color=\'" + param5 + "\'>";
         if(ChatAction.specialType == ChatAction.TOOL_TYPE)
         {
            if(param1 == GamePlayer.getInstance().Guid)
            {
               _loc6_ += "<a href=\'event:" + param1 + "," + _loc9_ + "\'>" + StringManager.getInstance().getMessageString("ChatingTXT13") + ":</a>";
               _loc6_ += "</font>";
               if(ChatAction.getInstance().IsFitShareToolContentReg(param4))
               {
                  param4 = StringUitl.Trim(param4);
                  _loc8_ = param4.split("/");
                  _loc7_ = _loc8_[0];
                  if(_loc7_.charAt(0) != "[")
                  {
                     _loc15_ = _loc7_.replace(StringUitl.Trim("[" + ChatUI.toolObj.Name + "]"),"");
                     if(_loc7_.length == _loc15_.length)
                     {
                        _loc6_ += "<font size=\'12\' color=\'" + param5 + "\'>";
                        _loc6_ = _loc6_ + param4;
                        _loc6_ = _loc6_ + "</font>";
                     }
                     else
                     {
                        _loc6_ += "<font size=\'12\' color=\'" + param5 + "\'>";
                        _loc6_ = _loc6_ + _loc15_;
                        _loc6_ = _loc6_ + "</font>";
                        _loc6_ = _loc6_ + "<font size=\'12\' color=\'#99FFFF\'>";
                        _loc6_ = _loc6_ + ("<a href=\'event:" + ChatAction.specialType + "," + ChatUI.toolObj.Proid + "," + param1 + "," + _loc7_ + "\'>[" + StringUitl.Trim(ChatUI.toolObj.Name) + "]</a>");
                        _loc6_ = _loc6_ + "</font>";
                        if(param4.lastIndexOf("/") != param4.length)
                        {
                           _loc8_ = param4.split("/");
                           _loc6_ += "<font size=\'12\' color=\'" + param5 + "\'>";
                           _loc6_ = _loc6_ + _loc8_[1];
                           _loc6_ = _loc6_ + "</font>";
                        }
                     }
                  }
                  else if(StringUitl.Trim(_loc7_) != StringUitl.Trim("[" + ChatUI.toolObj.Name + "]"))
                  {
                     _loc6_ += "<font size=\'12\' color=\'" + param5 + "\'>";
                     _loc6_ = _loc6_ + param4;
                     _loc6_ = _loc6_ + "</font>";
                  }
                  else
                  {
                     _loc7_ = ClearFlag(_loc7_);
                     _loc6_ += "<font size=\'12\' color=\'#99FFFF\'>";
                     _loc6_ = _loc6_ + ("<a href=\"event:" + ChatAction.specialType + "," + ChatUI.toolObj.Proid + "," + param1 + "," + _loc7_ + "\">" + StringUitl.Trim(_loc7_) + "</a>");
                     _loc6_ = _loc6_ + "</font>";
                     if(_loc8_.length > 1 && _loc8_[1] != "")
                     {
                        _loc6_ += "<font size=\'12\' color=\'" + param5 + "\'>";
                        _loc6_ = _loc6_ + _loc8_[1];
                        _loc6_ = _loc6_ + "</font>";
                     }
                  }
                  _loc6_ += "<br/>";
               }
               ChatUI.toolObj.Type = -1;
               ChatUI.toolObj.Proid = -1;
               ChatUI.toolObj.Name = undefined;
               return _loc6_;
            }
            _loc6_ += "<a href=\'event:" + param1 + "," + _loc9_ + "\'>[" + StringUitl.Trim(param3) + "]:</a>";
            _loc8_ = param4.split("[");
            if(param4.charAt(0) != "[")
            {
               _loc14_ = _loc8_[0];
               _loc6_ += "<font size=\'12\' color=\'" + param5 + "\'>";
               _loc6_ = _loc6_ + _loc14_;
               _loc6_ = _loc6_ + "</font>";
            }
            _loc11_ = _loc8_[1];
            if(_loc11_)
            {
               _loc12_ = int(_loc11_.indexOf("/"));
               _loc7_ = _loc11_.substr(0,_loc12_);
               _loc7_ = "[" + _loc7_;
               _loc7_ = ClearFlag(_loc7_);
            }
            _loc6_ += "<font size=\'12\' color=\'#99FFFF\'>";
            _loc6_ = _loc6_ + ("<a href=\"event:" + ChatAction.specialType + "," + ChatUI.toolObj.Proid + "," + param1 + "," + _loc7_ + "\">" + StringUitl.Trim(_loc7_) + "</a>");
            _loc6_ = _loc6_ + "</font>";
            _loc13_ = _loc11_.split("/");
            if(_loc13_.length > 1 && _loc13_[_loc13_.length - 1] != "")
            {
               _loc6_ += "<font size=\'12\' color=\'" + param5 + "\'>";
               _loc6_ = _loc6_ + _loc13_[1];
               _loc6_ = _loc6_ + "</font>";
            }
            _loc6_ += "<br/>";
            ChatAction.specialType = ChatAction.COMMON_TYPE;
            ChatUI.toolObj.Type = -1;
            ChatUI.toolObj.Proid = -1;
            ChatUI.toolObj.Name = undefined;
            return _loc6_;
         }
         if(ChatAction.specialType == ChatAction.COMMAND_TYPE)
         {
            if(param1 == GamePlayer.getInstance().Guid)
            {
               _loc6_ += "<a href=\'event:" + param1 + "," + _loc9_ + "\'>" + StringManager.getInstance().getMessageString("ChatingTXT13") + "</a>";
            }
            else
            {
               _loc6_ += "<a href=\'event:" + param1 + "," + _loc9_ + "\'>[" + StringUitl.Trim(param3) + "]</a>";
            }
            _loc6_ += "</font>";
            _loc6_ = _loc6_ + "<font size=\'12\' color=\'#FF0000\'>";
            _loc6_ = _loc6_ + ("<a href=\'event:" + param4 + "\'>[" + param4 + "]</a>");
            _loc6_ = _loc6_ + "</font>";
            _loc6_ = _loc6_ + "<br/>";
            ChatAction.specialType = ChatAction.COMMON_TYPE;
            ChatUI.toolObj.Type = -1;
            ChatUI.toolObj.Proid = -1;
            ChatUI.toolObj.Name = undefined;
            return _loc6_;
         }
         if(ChatAction.specialType == ChatAction.COMMAND_CARD)
         {
            if(param1 == GamePlayer.getInstance().Guid)
            {
               _loc6_ += "<a href=\'event:" + param1 + "," + _loc9_ + "\'>" + StringManager.getInstance().getMessageString("ChatingTXT13") + ":</a>";
               if(ChatAction.getInstance().IsFitShareToolContentReg(param4))
               {
                  param4 = StringUitl.Trim(param4);
                  _loc8_ = param4.split("/");
                  _loc7_ = _loc8_[0];
                  if(_loc7_.charAt(0) != "[")
                  {
                     _loc20_ = _loc7_.replace(StringUitl.Trim("[" + ChatUI.toolObj.Name + "]"),"");
                     if(_loc7_.length == _loc20_.length)
                     {
                        _loc6_ += "<font size=\'12\' color=\'" + param5 + "\'>";
                        _loc6_ = _loc6_ + param4;
                        _loc6_ = _loc6_ + "</font>";
                     }
                     else
                     {
                        _loc7_ = ClearFlag(_loc7_);
                        _loc6_ += "<font size=\'12\' color=\'" + param5 + "\'>";
                        _loc6_ = _loc6_ + _loc20_;
                        _loc6_ = _loc6_ + "</font>";
                        _loc6_ = _loc6_ + "<font size=\'12\' color=\'#99FFFF\'>";
                        _loc6_ = _loc6_ + ("<a href=\'event:" + ChatAction.specialType + "," + ChatUI.toolObj.Proid + "," + param1 + "," + _loc7_ + "\'>[" + StringUitl.Trim(ChatUI.toolObj.Name) + "]</a>");
                        _loc6_ = _loc6_ + "</font>";
                        if(param4.lastIndexOf("/") != param4.length)
                        {
                           _loc8_ = param4.split("/");
                           _loc6_ += "<font size=\'12\' color=\'" + param5 + "\'>";
                           if(_loc8_.length < 1)
                           {
                              _loc6_ += "";
                           }
                           _loc6_ += _loc8_[1];
                           _loc6_ = _loc6_ + "</font>";
                        }
                     }
                  }
                  else if(StringUitl.Trim(_loc7_) != StringUitl.Trim("[" + ChatUI.toolObj.Name + "]"))
                  {
                     _loc6_ += "<font size=\'12\' color=\'" + param5 + "\'>";
                     _loc6_ = _loc6_ + param4;
                     _loc6_ = _loc6_ + "</font>";
                  }
                  else
                  {
                     _loc7_ = ClearFlag(_loc7_);
                     _loc6_ += "<font size=\'12\' color=\'#99FFFF\'>";
                     _loc6_ = _loc6_ + (StringManager.getInstance().getMessageString("CommanderText130") + "<a href=\'event:" + ChatAction.specialType + "," + ChatUI.toolObj.Proid + "," + param1 + "," + _loc7_ + "\'>" + StringUitl.Trim(_loc7_) + "</a>");
                     _loc6_ = _loc6_ + "</font>";
                     if(_loc8_.length > 1 && _loc8_[1] != "")
                     {
                        _loc6_ += "<font size=\'12\' color=\'" + param5 + "\'>";
                        _loc6_ = _loc6_ + (StringManager.getInstance().getMessageString("CommanderText130") + _loc8_[1]);
                        _loc6_ = _loc6_ + "</font>";
                     }
                  }
                  _loc6_ += "<br/>";
               }
               return _loc6_;
            }
            _loc6_ += "<a href=\'event:" + param1 + "," + _loc9_ + "\'>[" + StringUitl.Trim(param3) + "]:</a>";
            _loc8_ = param4.split("[");
            if(param4.charAt(0) != "[")
            {
               _loc19_ = _loc8_[0];
               _loc6_ += "<font size=\'12\' color=\'" + param5 + "\'>";
               _loc6_ = _loc6_ + _loc14_;
               _loc6_ = _loc6_ + "</font>";
            }
            _loc16_ = _loc8_.length < 1 ? "" : _loc8_[1];
            _loc17_ = int(_loc16_.indexOf("/"));
            if(_loc12_ == -1)
            {
               _loc17_ = 0;
            }
            _loc7_ = _loc16_.substr(0,_loc17_);
            _loc7_ = ClearFlag(_loc7_);
            _loc7_ = "[" + _loc7_;
            _loc6_ += "<font size=\'12\' color=\'#99FFFF\'>";
            _loc6_ = _loc6_ + (StringManager.getInstance().getMessageString("CommanderText130") + "<a href=\"event:" + ChatAction.specialType + "," + ChatUI.toolObj.Proid + "," + param1 + "," + _loc7_ + "\">" + StringUitl.Trim(_loc7_) + "</a>");
            _loc6_ = _loc6_ + "</font>";
            _loc18_ = _loc16_.split("/");
            if(_loc18_.length > 1 && _loc18_[_loc18_.length - 1] != "")
            {
               _loc6_ += "<font size=\'12\' color=\'" + param5 + "\'>";
               if(_loc18_.length < 1)
               {
                  _loc6_ += "";
               }
               else
               {
                  _loc6_ += _loc18_[1];
               }
               _loc6_ += "</font>";
            }
            _loc6_ += "<br/>";
            ChatAction.specialType = ChatAction.COMMON_TYPE;
            return _loc6_;
         }
         var _loc10_:String = "";
         if(param2 == ChannelEnum.CHANNEL_PRIVATE)
         {
            if(GamePlayer.getInstance().language == 10)
            {
               _loc6_ += "<a href=\'event:" + param1 + "," + _loc9_ + "\'>[" + StringUitl.Trim(param3) + "]</a>";
               _loc8_ = filterPrivateChannel(param4);
               if(_loc8_.length > 1)
               {
                  _loc10_ = _loc8_[1];
               }
               _loc6_ += _loc10_;
            }
            else if(param1 == GamePlayer.getInstance().Guid)
            {
               _loc6_ += StringManager.getInstance().getMessageString("ChatingTXT0");
               _loc8_ = filterPrivateChannel(param4);
               _loc21_ = _loc8_[0];
               if(_loc8_.length > 1)
               {
                  _loc10_ = _loc8_[1];
               }
               _loc6_ += "[" + _loc21_ + "]";
               _loc6_ = _loc6_ + StringManager.getInstance().getMessageString("ChatingTXT29");
               _loc6_ = _loc6_ + StringManager.getInstance().getMessageString("ChatingTXT2");
               _loc6_ = _loc6_ + _loc10_;
            }
            else
            {
               _loc6_ += "<a href=\'event:" + param1 + "," + _loc9_ + "\'>[" + StringUitl.Trim(param3) + "]</a>";
               _loc6_ = _loc6_ + StringManager.getInstance().getMessageString("ChatingTXT1");
               _loc6_ = _loc6_ + StringManager.getInstance().getMessageString("ChatingTXT2");
               _loc8_ = filterPrivateChannel(param4);
               if(_loc8_.length > 1)
               {
                  _loc10_ = _loc8_[1];
               }
               _loc6_ += _loc10_;
            }
            _loc6_ += "</font>";
         }
         else if(param2 == ChannelEnum.CHANNEL_GMNOTICE)
         {
            _loc6_ += StringManager.getInstance().getMessageString("ChatingTXT22") + ": ";
            _loc6_ = _loc6_ + param4;
            _loc6_ = _loc6_ + "</font>";
         }
         else if(param2 >= 100)
         {
            rank_name = "";
            rank_color = "";
            switch(param2)
            {
               case 100:
                  rank_name = "ADM ";
                  rank_color = "#FF1100";
                  break;
               case 101:
                  rank_name = "MOD ";
                  rank_color = "#66CCFF";
                  break;
               case 102:
                  rank_name = "VIP I ";
                  rank_color = "#F700FF";
                  break;
               case 103:
                  rank_name = "VIP II ";
                  rank_color = "#00FFFB";
                  break;
               case 104:
                  rank_name = "MVP ";
                  rank_color = "#FFD500";
                  break;
               case 105:
                  rank_name = "INF ";
                  rank_color = "#E91E63";
            }
            if(param1 == GamePlayer.getInstance().Guid)
            {
               _loc6_ += "<a href=\'event:" + param1 + "," + _loc9_ + "\'>[<font size=\'12\' face=\'Impact\' color=\'" + rank_color + "\'><strong>" + rank_name + "</strong></font>Me]:</a>";
            }
            else
            {
               _loc6_ += "<a href=\'event:" + param1 + "," + _loc9_ + "\'>[<font size=\'12\' face=\'Impact\' color=\'" + rank_color + "\'><strong>" + rank_name + "</strong></font>" + StringUitl.Trim(param3) + "]:</a>";
            }
            _loc6_ += param4;
            _loc6_ = _loc6_ + "</font>";
         }
         else
         {
            if(param1 == GamePlayer.getInstance().Guid)
            {
               _loc6_ += "<a href=\'event:" + param1 + "," + _loc9_ + "\'>" + StringManager.getInstance().getMessageString("ChatingTXT13") + ":</a>";
            }
            else
            {
               _loc6_ += "<a href=\'event:" + param1 + "," + _loc9_ + "\'>[" + StringUitl.Trim(param3) + "]:</a>";
            }
            _loc6_ += param4;
            _loc6_ = _loc6_ + "</font>";
         }
         return _loc6_ + "<br/>";
      }
      
      public static function createAppendMsgContentHtml(param1:int, param2:String) : String
      {
         var _loc4_:* = undefined;
         var _loc3_:String = setFontColor(param1);
         _loc4_ = "<font size=\'12\' color=\'" + _loc3_ + "\'>";
         _loc4_ = _loc4_ + (StringUitl.Trim(MatchChannel(param1)) + ":");
         _loc4_ = _loc4_ + StringUitl.Trim(param2);
         _loc4_ = _loc4_ + "</font>";
         return _loc4_ + "</br>";
      }
      
      public static function filterPrivateChannel(param1:String = null) : Array
      {
         var _loc2_:Array = null;
         if(param1 == "" || param1 == null)
         {
            return null;
         }
         if(GamePlayer.getInstance().language == 10)
         {
            param1 = param1.substr(0,param1.length - 1);
            _loc2_ = param1.split(":");
            return _loc2_.reverse();
         }
         if(param1.indexOf("/") == 0)
         {
            param1 = param1.substr(1,param1.length - 1);
            if(param1.indexOf(":") != -1)
            {
               return param1.split(":");
            }
            if(param1.indexOf(" ") != -1)
            {
               _loc2_ = param1.split(" ");
            }
            return _loc2_;
         }
         return null;
      }
      
      public static function setFontColor(param1:int) : String
      {
         var _loc2_:String = "#FFFFFF";
         switch(param1)
         {
            case ChannelEnum.CHANNEL_WORLD:
               _loc2_ = "#FFFFFF";
               break;
            case ChannelEnum.CHANNEL_CONSORTIA:
               _loc2_ = "#33FF00";
               break;
            case ChannelEnum.CHANNEL_GALAXY:
               _loc2_ = "#FFCC99";
               break;
            case ChannelEnum.CHANNEL_TEAM:
               _loc2_ = "#66CCFF";
               break;
            case ChannelEnum.CHANNEL_PRIVATE:
               _loc2_ = "#FF00FF";
               break;
            case ChannelEnum.CHANNEL_GMNOTICE:
               _loc2_ = "#FFFF00";
               break;
            case ChannelEnum.CHANNEL_SYSTEM:
               _loc2_ = "#FFFF00";
               break;
            case 100:
               _loc2_ = "#FFFFFF";
               break;
            case 101:
               _loc2_ = "#FFFFFF";
         }
         return _loc2_;
      }
      
      public static function getChannelColor(param1:int) : uint
      {
         switch(param1)
         {
            case ChannelEnum.CHANNEL_WORLD:
               return 16777215;
            case ChannelEnum.CHANNEL_CONSORTIA:
               return 3407616;
            case ChannelEnum.CHANNEL_GALAXY:
               return 16764057;
            case ChannelEnum.CHANNEL_GMNOTICE:
               return 16711680;
            case ChannelEnum.CHANNEL_PRIVATE:
               return 16711935;
            case ChannelEnum.CHANNEL_SYSTEM:
               return 16711680;
            case ChannelEnum.CHANNEL_TEAM:
               return 6737151;
            case 100:
               return 16726843;
            case 101:
               return 10657952;
            default:
               return 0;
         }
      }
      
      public static function MatchChannel(param1:int) : String
      {
         var _loc2_:String = null;
         switch(param1)
         {
            case ChannelEnum.CHANNEL_WORLD:
               _loc2_ = StringManager.getInstance().getMessageString("ChatingTXT5");
               break;
            case 100:
               _loc2_ = StringManager.getInstance().getMessageString("ChatingTXT5");
               break;
            case 101:
               _loc2_ = StringManager.getInstance().getMessageString("ChatingTXT5");
               break;
            case ChannelEnum.CHANNEL_CONSORTIA:
               _loc2_ = StringManager.getInstance().getMessageString("ChatingTXT6");
               break;
            case ChannelEnum.CHANNEL_GALAXY:
               _loc2_ = StringManager.getInstance().getMessageString("ChatingTXT7");
               break;
            case ChannelEnum.CHANNEL_GMNOTICE:
               _loc2_ = StringManager.getInstance().getMessageString("ChatingTXT22");
               break;
            case ChannelEnum.CHANNEL_PRIVATE:
               _loc2_ = StringManager.getInstance().getMessageString("ChatingTXT9");
               break;
            case ChannelEnum.CHANNEL_SYSTEM:
               _loc2_ = StringManager.getInstance().getMessageString("ChatingTXT11");
               break;
            case ChannelEnum.CHANNEL_TEAM:
               _loc2_ = StringManager.getInstance().getMessageString("ChatingTXT8");
         }
         return _loc2_;
      }
      
      public static function filterHtmlCode(param1:String) : String
      {
         var _loc3_:int = 0;
         var _loc6_:RegExp = null;
         var _loc2_:int = param1.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_)
         {
            if(param1.charAt(_loc4_) == "<")
            {
               _loc3_++;
            }
            _loc4_++;
         }
         var _loc5_:int = 0;
         while(_loc5_ < _loc3_)
         {
            param1 = param1.replace("<","&lt;");
            param1 = param1.replace(">","&gt;");
            if(param1.match("</"))
            {
               param1 = param1.replace("<","&lt;");
               param1 = param1.replace(">","&gt;");
            }
            _loc5_++;
         }
         _loc6_ = /&#13;/g;
         param1 = param1.replace(_loc6_,"");
         _loc6_ = /&#10;/g;
         return param1.replace(_loc6_,"");
      }
      
      public static function replaceContent(param1:String) : String
      {
         if(param1 == null || param1 == "")
         {
            return null;
         }
         if(GamePlayer.getInstance().language == 10)
         {
            if(param1.indexOf("</br>") > 0)
            {
               param1 = param1.replace("</br>","\n");
            }
            else
            {
               param1 += "\n";
            }
         }
         else
         {
            param1 = param1.replace("</br>","\n");
         }
         return param1;
      }
   }
}

