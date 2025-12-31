package logic.ui.tip
{
   import com.star.frameworks.managers.StringManager;
   import com.star.frameworks.utils.HashSet;
   import flash.display.Bitmap;
   import flash.geom.Point;
   import logic.entry.DiamondInfo;
   import logic.entry.GamePlayer;
   import logic.entry.commander.CommanderInfo;
   import logic.entry.commander.CommanderXmlInfo;
   import logic.game.GameKernel;
   import logic.reader.CCommanderReader;
   import logic.reader.CPropsReader;
   import logic.ui.info.AbstractInfoDecorate;
   import net.base.NetManager;
   import net.msg.commanderMsg.MSG_REQUEST_COMMANDERINFO;
   import net.router.CommanderRouter;
   
   public class CommanderInfoTip
   {
      
      private static var instance:CommanderInfoTip;
      
      private var infoDecorate:AbstractInfoDecorate;
      
      private var CurCommanderInfo:CommanderInfo;
      
      private var CurCommanderXmlInfo:CommanderXmlInfo;
      
      private var CurCommanderId:int;
      
      private var _LocationPoint:Point;
      
      private var RefreshCommanderInfo:Boolean = false;
      
      private var ValueArr:HashSet = new HashSet();
      
      private var commander_aim:int;
      
      private var commander_priority:int;
      
      private var commander_electron:int;
      
      private var commander_blench:int;
      
      private var CommanderValueArr:Array = new Array();
      
      public function CommanderInfoTip()
      {
         super();
         this.infoDecorate = new AbstractInfoDecorate();
         this.infoDecorate.Load("CommanderInfoTip");
         this.infoDecorate.ToolTip.SetMoveEvent();
         this.ValueArr.Put("S",4);
         this.ValueArr.Put("A",3);
         this.ValueArr.Put("B",2);
         this.ValueArr.Put("C",1);
         this.ValueArr.Put("D",0);
      }
      
      public static function GetInstance() : CommanderInfoTip
      {
         if(instance == null)
         {
            instance = new CommanderInfoTip();
         }
         return instance;
      }
      
      public function Hide() : void
      {
         this.infoDecorate.Hide();
      }
      
      public function ShowCommanderInfo(param1:int, param2:int, param3:Point) : void
      {
         this.infoDecorate.Hide();
         this.CurCommanderId = param1;
         this._LocationPoint = param3;
         this.CurCommanderInfo = CommanderRouter.instance.selectCommander(param1);
         if(param2 >= 0)
         {
            this.CurCommanderXmlInfo = CCommanderReader.getInstance().GetCommanderInfo(param2);
         }
         else
         {
            this.CurCommanderXmlInfo = null;
         }
         if(Boolean(this.CurCommanderInfo) && this.CurCommanderInfo.HasCardLevel)
         {
            this.ShowTip();
         }
         else
         {
            this.RequestCommanderInfo(param1);
         }
      }
      
      private function RequestCommanderInfo(param1:int) : void
      {
         var _loc2_:MSG_REQUEST_COMMANDERINFO = new MSG_REQUEST_COMMANDERINFO();
         _loc2_.ShowType = 1;
         _loc2_.CommanderId = param1;
         _loc2_.SeqId = GamePlayer.getInstance().seqID++;
         _loc2_.Guid = GamePlayer.getInstance().Guid;
         NetManager.Instance().sendObject(_loc2_);
      }
      
      public function RespCommanderInfo(param1:CommanderInfo) : void
      {
         if(this.CurCommanderId != param1.commander_commanderId)
         {
            return;
         }
         this.CurCommanderInfo = param1;
         this.ShowTip();
      }
      
      private function GetDiamondValue() : void
      {
         var _loc1_:int = 0;
         var _loc2_:DiamondInfo = null;
         this.commander_aim = 0;
         this.commander_priority = 0;
         this.commander_electron = 0;
         this.commander_blench = 0;
         _loc1_ = 0;
         while(_loc1_ < 9)
         {
            this.CommanderValueArr[_loc1_] = "D";
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < 12)
         {
            if(this.CurCommanderInfo.commander_Stone[_loc1_] > -1)
            {
               _loc2_ = CPropsReader.getInstance().GetDiamond(this.CurCommanderInfo.commander_Stone[_loc1_]);
               if(_loc2_.GemKindID == 1)
               {
                  this.commander_aim += int(_loc2_.GemValue);
               }
               if(_loc2_.GemKindID == 2)
               {
                  this.commander_blench += int(_loc2_.GemValue);
               }
               if(_loc2_.GemKindID == 3)
               {
                  this.commander_electron += int(_loc2_.GemValue);
               }
               if(_loc2_.GemKindID == 4)
               {
                  this.commander_priority += int(_loc2_.GemValue);
               }
               else if(_loc2_.GemKindID > 12)
               {
                  if(this.ValueArr.Get(this.CommanderValueArr[_loc2_.GemKindID - 13]) < this.ValueArr.Get(_loc2_.GemValue))
                  {
                     this.CommanderValueArr[_loc2_.GemKindID - 13] = _loc2_.GemValue;
                  }
               }
            }
            _loc1_++;
         }
      }
      
      private function ShowTip() : void
      {
         var _loc4_:Object = null;
         var _loc5_:Bitmap = null;
         var _loc6_:Bitmap = null;
         var _loc7_:* = null;
         this.GetDiamondValue();
         this.infoDecorate.Update("Level","" + (this.CurCommanderInfo.commander_level + 1));
         var _loc1_:* = "<font color=\'#";
         switch(this.CurCommanderInfo.commander_type)
         {
            case 4:
               _loc1_ += "F800F8";
               break;
            case 3:
               _loc1_ += "0090F8";
               break;
            case 2:
               _loc1_ += "00C800";
               break;
            default:
               _loc1_ += "FFFFFF";
         }
         _loc1_ += "\'>";
         this.infoDecorate.Update("Name",_loc1_ + this.CurCommanderInfo.commander_name + "</font>");
         this.infoDecorate.Update("AimValue","" + int(this.CurCommanderInfo.commander_aim + this.commander_aim));
         this.infoDecorate.Update("PriorityValue","" + int(this.CurCommanderInfo.commander_priority + this.commander_priority));
         this.infoDecorate.Update("ElectronValue","" + int(this.CurCommanderInfo.commander_electron + this.commander_electron));
         this.infoDecorate.Update("BlenchValue","" + int(this.CurCommanderInfo.commander_blench + this.commander_blench));
         var _loc2_:int = 0;
         while(_loc2_ < 9)
         {
            _loc4_ = this.infoDecorate.ToolTip.getObject("Star" + _loc2_);
            _loc5_ = _loc4_.Display as Bitmap;
            if(this.CurCommanderInfo.commander_type != 1 && _loc2_ <= this.CurCommanderInfo.commander_cardLevel)
            {
               _loc6_ = new Bitmap(GameKernel.getTextureInstance("Commanderstar"));
            }
            else
            {
               _loc6_ = new Bitmap(GameKernel.getTextureInstance("Emptystar"));
            }
            _loc6_.x = _loc5_.x;
            _loc6_.y = _loc5_.y;
            this.infoDecorate.replaceTexture("Star" + _loc2_,_loc6_);
            _loc2_++;
         }
         var _loc3_:int = 0;
         while(_loc3_ < 8)
         {
            if(_loc3_ < this.CurCommanderInfo.commander_commanderZJ.length)
            {
               _loc7_ = this.CurCommanderInfo.commander_commanderZJ.substr(_loc3_,1);
               if(this.ValueArr.Get(this.CommanderValueArr[_loc3_]) > this.ValueArr.Get(_loc7_))
               {
                  _loc7_ = this.CommanderValueArr[_loc3_];
               }
               switch(_loc7_)
               {
                  case "A":
                     _loc7_ = "<font color=\'#F800F8\'>" + _loc7_ + "</font>";
                     break;
                  case "B":
                     _loc7_ = "<font color=\'#0090F8\'>" + _loc7_ + "</font>";
                     break;
                  case "C":
                     _loc7_ = "<font color=\'#00C800\'>" + _loc7_ + "</font>";
                     break;
                  case "D":
                     _loc7_ = "<font color=\'#F8F8F8\'>" + _loc7_ + "</font>";
                     break;
                  case "S":
                     _loc7_ = "<font color=\'#F80000\'>" + _loc7_ + "</font>";
               }
               this.infoDecorate.Update("Skill" + _loc3_,_loc7_);
            }
            else
            {
               this.infoDecorate.Update("Skill" + _loc3_,"");
            }
            _loc3_++;
         }
         if(this.CurCommanderXmlInfo != null)
         {
            this.infoDecorate.Update("Comment","<font color=\'#ccba7a\'>" + StringManager.getInstance().getMessageString("CommanderText0") + "</font>" + this.CurCommanderXmlInfo.Comment);
         }
         else
         {
            this.infoDecorate.Update("Comment","<font color=\'#ccba7a\'>" + StringManager.getInstance().getMessageString("CommanderText0") + "</font>" + StringManager.getInstance().getMessageString("CorpsText14"));
         }
         this.infoDecorate.putDecorate();
         this.infoDecorate.Show(this._LocationPoint.x,this._LocationPoint.y);
      }
   }
}

