package logic.widget
{
   import com.star.frameworks.managers.StringManager;
   import com.star.frameworks.utils.StringUitl;
   import logic.action.ChatAction;
   import logic.entry.ChannelEnum;
   import logic.entry.GamePlayer;
   import logic.ui.ChatUI;
   import net.msg.chatMsg.MSG_CHAT_MESSAGE;
   
   public class ChatModuleUtil
   {
      
      public function ChatModuleUtil()
      {
         super();
      }
      
      public static function createTxtLink(param1:int, param2:int, param3:String, param4:String, param5:String = "#FFFFFF", param6:MSG_CHAT_MESSAGE = null) : String
      {
         var guid:int = param1;
         var targetType:int = param2;
         var userName:String = param3;
         var content:String = param4;
         var txtColor:String = param5;
         var message:MSG_CHAT_MESSAGE = param6;
         try
         {
            return createTxtLink2(guid,targetType,userName,content,txtColor,message);
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
      
      public static function createTxtLink2(param1:int, param2:int, param3:String, param4:String, param5:String = "#FFFFFF", param6:MSG_CHAT_MESSAGE = null) : String
      {
         var rank_name:String = null;
         var rank_color:String = null;
         var rank:* = param6.rank;
         var acronym:* = param6.acronym;
         var corp_name:String = param6.corp;
         var obj_8_:Array = null;
         var obj_11_:String = null;
         var obj_12_:int = 0;
         var obj_13_:Array = null;
         var obj_14_:String = null;
         var obj_15_:String = null;
         var obj_16_:String = null;
         var obj_17_:int = 0;
         var obj_18_:Array = null;
         var obj_19_:String = null;
         var obj_20_:String = null;
         var obj_21_:String = null;
         var obj_6_:String = "";
         var obj_7_:String = "";
         var obj_9_:String = param3;
         param4 = filterHtmlCode(param4);
         obj_6_ += "<font size=\'12\' color=\'" + param5 + "\'>";
         if(ChatAction.specialType == ChatAction.TOOL_TYPE)
         {
            if(param1 == GamePlayer.getInstance().Guid)
            {
               obj_6_ += "<a href=\'event:" + param1 + "," + obj_9_ + "\'>" + StringManager.getInstance().getMessageString("ChatingTXT13") + ":</a>";
               obj_6_ += "</font>";
               if(ChatAction.getInstance().IsFitShareToolContentReg(param4))
               {
                  param4 = StringUitl.Trim(param4);
                  obj_8_ = param4.split("/");
                  obj_7_ = obj_8_[0];
                  if(obj_7_.charAt(0) != "[")
                  {
                     obj_15_ = obj_7_.replace(StringUitl.Trim("[" + ChatUI.toolObj.Name + "]"),"");
                     if(obj_7_.length == obj_15_.length)
                     {
                        obj_6_ += "<font size=\'12\' color=\'" + param5 + "\'>";
                        obj_6_ = obj_6_ + param4;
                        obj_6_ = obj_6_ + "</font>";
                     }
                     else
                     {
                        obj_6_ += "<font size=\'12\' color=\'" + param5 + "\'>";
                        obj_6_ = obj_6_ + obj_15_;
                        obj_6_ = obj_6_ + "</font>";
                        obj_6_ = obj_6_ + "<font size=\'12\' color=\'#99FFFF\'>";
                        obj_6_ = obj_6_ + ("<a href=\'event:" + ChatAction.specialType + "," + ChatUI.toolObj.Proid + "," + param1 + "," + obj_7_ + "\'>[" + StringUitl.Trim(ChatUI.toolObj.Name) + "]</a>");
                        obj_6_ = obj_6_ + "</font>";
                        if(param4.lastIndexOf("/") != param4.length)
                        {
                           obj_8_ = param4.split("/");
                           obj_6_ += "<font size=\'12\' color=\'" + param5 + "\'>";
                           obj_6_ = obj_6_ + obj_8_[1];
                           obj_6_ = obj_6_ + "</font>";
                        }
                     }
                  }
                  else if(StringUitl.Trim(obj_7_) != StringUitl.Trim("[" + ChatUI.toolObj.Name + "]"))
                  {
                     obj_6_ += "<font size=\'12\' color=\'" + param5 + "\'>";
                     obj_6_ = obj_6_ + param4;
                     obj_6_ = obj_6_ + "</font>";
                  }
                  else
                  {
                     obj_7_ = ClearFlag(obj_7_);
                     obj_6_ += "<font size=\'12\' color=\'#99FFFF\'>";
                     obj_6_ = obj_6_ + ("<a href=\"event:" + ChatAction.specialType + "," + ChatUI.toolObj.Proid + "," + param1 + "," + obj_7_ + "\">" + StringUitl.Trim(obj_7_) + "</a>");
                     obj_6_ = obj_6_ + "</font>";
                     if(obj_8_.length > 1 && obj_8_[1] != "")
                     {
                        obj_6_ += "<font size=\'12\' color=\'" + param5 + "\'>";
                        obj_6_ = obj_6_ + obj_8_[1];
                        obj_6_ = obj_6_ + "</font>";
                     }
                  }
                  obj_6_ += "<br/>";
               }
               ChatUI.toolObj.Type = -1;
               ChatUI.toolObj.Proid = -1;
               ChatUI.toolObj.Name = undefined;
               return obj_6_;
            }
            obj_6_ += "<a href=\'event:" + param1 + "," + obj_9_ + "\'>[" + StringUitl.Trim(param3) + "]:</a>";
            obj_8_ = param4.split("[");
            if(param4.charAt(0) != "[")
            {
               obj_14_ = obj_8_[0];
               obj_6_ += "<font size=\'12\' color=\'" + param5 + "\'>";
               obj_6_ = obj_6_ + obj_14_;
               obj_6_ = obj_6_ + "</font>";
            }
            obj_11_ = obj_8_[1];
            if(obj_11_)
            {
               obj_12_ = int(obj_11_.indexOf("/"));
               obj_7_ = obj_11_.substr(0,obj_12_);
               obj_7_ = "[" + obj_7_;
               obj_7_ = ClearFlag(obj_7_);
            }
            obj_6_ += "<font size=\'12\' color=\'#99FFFF\'>";
            obj_6_ = obj_6_ + ("<a href=\"event:" + ChatAction.specialType + "," + ChatUI.toolObj.Proid + "," + param1 + "," + obj_7_ + "\">" + StringUitl.Trim(obj_7_) + "</a>");
            obj_6_ = obj_6_ + "</font>";
            obj_13_ = obj_11_.split("/");
            if(obj_13_.length > 1 && obj_13_[obj_13_.length - 1] != "")
            {
               obj_6_ += "<font size=\'12\' color=\'" + param5 + "\'>";
               obj_6_ = obj_6_ + obj_13_[1];
               obj_6_ = obj_6_ + "</font>";
            }
            obj_6_ += "<br/>";
            ChatAction.specialType = ChatAction.COMMON_TYPE;
            ChatUI.toolObj.Type = -1;
            ChatUI.toolObj.Proid = -1;
            ChatUI.toolObj.Name = undefined;
            return obj_6_;
         }
         if(ChatAction.specialType == ChatAction.COMMAND_TYPE)
         {
            if(param1 == GamePlayer.getInstance().Guid)
            {
               obj_6_ += "<a href=\'event:" + param1 + "," + obj_9_ + "\'>" + StringManager.getInstance().getMessageString("ChatingTXT13") + "</a>";
            }
            else
            {
               obj_6_ += "<a href=\'event:" + param1 + "," + obj_9_ + "\'>[" + StringUitl.Trim(param3) + "]</a>";
            }
            obj_6_ += "</font>";
            obj_6_ = obj_6_ + "<font size=\'12\' color=\'#FF0000\'>";
            obj_6_ = obj_6_ + ("<a href=\'event:" + param4 + "\'>[" + param4 + "]</a>");
            obj_6_ = obj_6_ + "</font>";
            obj_6_ = obj_6_ + "<br/>";
            ChatAction.specialType = ChatAction.COMMON_TYPE;
            ChatUI.toolObj.Type = -1;
            ChatUI.toolObj.Proid = -1;
            ChatUI.toolObj.Name = undefined;
            return obj_6_;
         }
         if(ChatAction.specialType == ChatAction.COMMAND_CARD)
         {
            if(param1 == GamePlayer.getInstance().Guid)
            {
               obj_6_ += "<a href=\'event:" + param1 + "," + obj_9_ + "\'>" + StringManager.getInstance().getMessageString("ChatingTXT13") + ":</a>";
               if(ChatAction.getInstance().IsFitShareToolContentReg(param4))
               {
                  param4 = StringUitl.Trim(param4);
                  obj_8_ = param4.split("/");
                  obj_7_ = obj_8_[0];
                  if(obj_7_.charAt(0) != "[")
                  {
                     obj_20_ = obj_7_.replace(StringUitl.Trim("[" + ChatUI.toolObj.Name + "]"),"");
                     if(obj_7_.length == obj_20_.length)
                     {
                        obj_6_ += "<font size=\'12\' color=\'" + param5 + "\'>";
                        obj_6_ = obj_6_ + param4;
                        obj_6_ = obj_6_ + "</font>";
                     }
                     else
                     {
                        obj_7_ = ClearFlag(obj_7_);
                        obj_6_ += "<font size=\'12\' color=\'" + param5 + "\'>";
                        obj_6_ = obj_6_ + obj_20_;
                        obj_6_ = obj_6_ + "</font>";
                        obj_6_ = obj_6_ + "<font size=\'12\' color=\'#99FFFF\'>";
                        obj_6_ = obj_6_ + ("<a href=\'event:" + ChatAction.specialType + "," + ChatUI.toolObj.Proid + "," + param1 + "," + obj_7_ + "\'>[" + StringUitl.Trim(ChatUI.toolObj.Name) + "]</a>");
                        obj_6_ = obj_6_ + "</font>";
                        if(param4.lastIndexOf("/") != param4.length)
                        {
                           obj_8_ = param4.split("/");
                           obj_6_ += "<font size=\'12\' color=\'" + param5 + "\'>";
                           if(obj_8_.length < 1)
                           {
                              obj_6_ += "";
                           }
                           obj_6_ += obj_8_[1];
                           obj_6_ = obj_6_ + "</font>";
                        }
                     }
                  }
                  else if(StringUitl.Trim(obj_7_) != StringUitl.Trim("[" + ChatUI.toolObj.Name + "]"))
                  {
                     obj_6_ += "<font size=\'12\' color=\'" + param5 + "\'>";
                     obj_6_ = obj_6_ + param4;
                     obj_6_ = obj_6_ + "</font>";
                  }
                  else
                  {
                     obj_7_ = ClearFlag(obj_7_);
                     obj_6_ += "<font size=\'12\' color=\'#99FFFF\'>";
                     obj_6_ = obj_6_ + (StringManager.getInstance().getMessageString("CommanderText130") + "<a href=\'event:" + ChatAction.specialType + "," + ChatUI.toolObj.Proid + "," + param1 + "," + obj_7_ + "\'>" + StringUitl.Trim(obj_7_) + "</a>");
                     obj_6_ = obj_6_ + "</font>";
                     if(obj_8_.length > 1 && obj_8_[1] != "")
                     {
                        obj_6_ += "<font size=\'12\' color=\'" + param5 + "\'>";
                        obj_6_ = obj_6_ + (StringManager.getInstance().getMessageString("CommanderText130") + obj_8_[1]);
                        obj_6_ = obj_6_ + "</font>";
                     }
                  }
                  obj_6_ += "<br/>";
               }
               return obj_6_;
            }
            obj_6_ += "<a href=\'event:" + param1 + "," + obj_9_ + "\'>[" + StringUitl.Trim(param3) + "]:</a>";
            obj_8_ = param4.split("[");
            if(param4.charAt(0) != "[")
            {
               obj_19_ = obj_8_[0];
               obj_6_ += "<font size=\'12\' color=\'" + param5 + "\'>";
               obj_6_ = obj_6_ + obj_14_;
               obj_6_ = obj_6_ + "</font>";
            }
            obj_16_ = obj_8_.length < 1 ? "" : obj_8_[1];
            obj_17_ = int(obj_16_.indexOf("/"));
            if(obj_12_ == -1)
            {
               obj_17_ = 0;
            }
            obj_7_ = obj_16_.substr(0,obj_17_);
            obj_7_ = ClearFlag(obj_7_);
            obj_7_ = "[" + obj_7_;
            obj_6_ += "<font size=\'12\' color=\'#99FFFF\'>";
            obj_6_ = obj_6_ + (StringManager.getInstance().getMessageString("CommanderText130") + "<a href=\"event:" + ChatAction.specialType + "," + ChatUI.toolObj.Proid + "," + param1 + "," + obj_7_ + "\">" + StringUitl.Trim(obj_7_) + "</a>");
            obj_6_ = obj_6_ + "</font>";
            obj_18_ = obj_16_.split("/");
            if(obj_18_.length > 1 && obj_18_[obj_18_.length - 1] != "")
            {
               obj_6_ += "<font size=\'12\' color=\'" + param5 + "\'>";
               if(obj_18_.length < 1)
               {
                  obj_6_ += "";
               }
               else
               {
                  obj_6_ += obj_18_[1];
               }
               obj_6_ += "</font>";
            }
            obj_6_ += "<br/>";
            ChatAction.specialType = ChatAction.COMMON_TYPE;
            return obj_6_;
         }
         var _loc10_:String = "";
         if(param2 == ChannelEnum.CHANNEL_PRIVATE)
         {
            if(GamePlayer.getInstance().language == 10)
            {
               obj_6_ += "<a href=\'event:" + param1 + "," + obj_9_ + "\'>[" + StringUitl.Trim(param3) + "]</a>";
               obj_8_ = filterPrivateChannel(param4);
               if(obj_8_.length > 1)
               {
                  _loc10_ = obj_8_[1];
               }
               obj_6_ += _loc10_;
            }
            else if(param1 == GamePlayer.getInstance().Guid)
            {
               obj_6_ += StringManager.getInstance().getMessageString("ChatingTXT0");
               obj_8_ = filterPrivateChannel(param4);
               obj_21_ = obj_8_[0];
               if(obj_8_.length > 1)
               {
                  _loc10_ = obj_8_[1];
               }
               obj_6_ += "[" + obj_21_ + "]";
               obj_6_ = obj_6_ + StringManager.getInstance().getMessageString("ChatingTXT29");
               obj_6_ = obj_6_ + StringManager.getInstance().getMessageString("ChatingTXT2");
               obj_6_ = obj_6_ + _loc10_;
            }
            else
            {
               obj_6_ += "<a href=\'event:" + param1 + "," + obj_9_ + "\'>[" + StringUitl.Trim(param3) + "]</a>";
               obj_6_ = obj_6_ + StringManager.getInstance().getMessageString("ChatingTXT1");
               obj_6_ = obj_6_ + StringManager.getInstance().getMessageString("ChatingTXT2");
               obj_8_ = filterPrivateChannel(param4);
               if(obj_8_.length > 1)
               {
                  _loc10_ = obj_8_[1];
               }
               obj_6_ += _loc10_;
            }
            obj_6_ += "</font>";
         }
         else if(param2 == ChannelEnum.CHANNEL_GMNOTICE)
         {
            obj_6_ += StringManager.getInstance().getMessageString("ChatingTXT22") + ": ";
            obj_6_ = obj_6_ + param4;
            obj_6_ = obj_6_ + "</font>";
         }
         else if(param2 == 500)
         {
            obj_6_ += "<font color=\'#fa0505\'><strong>[Medusa]:</strong> ";
            obj_6_ = obj_6_ + param4;
            obj_6_ = obj_6_ + "</font></font>";
         }
         else
         {
            rank_name = "";
            rank_color = "";
            switch(rank)
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
                  break;
               case 106:
                  rank_name = "BTR ";
                  rank_color = "#FFE51C";
                  break;
               case 107:
                  rank_name = "GM ";
                  rank_color = "#34EB9B";
            }
            if(acronym > -1)
            {
               obj_6_ += "<font color=\'#9E9E9E\'><a href=\'event:CorpsName," + acronym + "\'>" + filterHtmlCode(corp_name) + "</a></font> ";
            }
            if(rank > -1)
            {
               if(param1 == GamePlayer.getInstance().Guid)
               {
                  obj_6_ += "<a href=\'event:" + param1 + "," + obj_9_ + "\'><font size=\'12\' face=\'Impact\' color=\'" + rank_color + "\'><strong>" + rank_name + "</strong></font>" + StringUitl.Trim(param3) + ": </a>";
               }
               else
               {
                  obj_6_ += "<a href=\'event:" + param1 + "," + obj_9_ + "\'><font size=\'12\' face=\'Impact\' color=\'" + rank_color + "\'><strong>" + rank_name + "</strong></font>" + StringUitl.Trim(param3) + ": </a>";
               }
            }
            else if(param1 == GamePlayer.getInstance().Guid)
            {
               obj_6_ += "<a href=\'event:" + param1 + "," + obj_9_ + "\'>" + StringUitl.Trim(param3) + ": </a>";
            }
            else
            {
               obj_6_ += "<a href=\'event:" + param1 + "," + obj_9_ + "\'>" + StringUitl.Trim(param3) + ": </a>";
            }
            obj_6_ += param4;
            obj_6_ = obj_6_ + "</font>";
         }
         return obj_6_ + "<br/>";
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
            case ChannelEnum.CHANNEL_MEDUSA:
               _loc2_ = "#FF0000";
               break;
            default:
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
            case ChannelEnum.CHANNEL_MEDUSA:
               return 16711680;
            case ChannelEnum.CHANNEL_TEAM:
               return 6737151;
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
               break;
            default:
               _loc2_ = StringManager.getInstance().getMessageString("ChatingTXT5");
         }
         return _loc2_;
      }
      
      public static function filterHtmlCode(param1:String) : String
      {
         var _loc3_:int = 0;
         var obj_6_:RegExp = null;
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
         obj_6_ = /&#13;/g;
         param1 = param1.replace(obj_6_,"");
         obj_6_ = /&#10;/g;
         return param1.replace(obj_6_,"");
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

