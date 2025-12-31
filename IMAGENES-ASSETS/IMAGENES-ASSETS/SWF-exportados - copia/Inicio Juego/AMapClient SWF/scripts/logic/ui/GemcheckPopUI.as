package logic.ui
{
   import com.star.frameworks.managers.StringManager;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import logic.entry.MObject;
   import logic.entry.props.propsInfo;
   import logic.game.GameKernel;
   import logic.reader.CCommanderReader;
   import logic.reader.CPropsReader;
   import logic.ui.tip.CommanderChipTip;
   import net.msg.ChipLottery.CmosInfo;
   import net.router.CommanderRouter;
   
   public class GemcheckPopUI
   {
      
      private static var instance:GemcheckPopUI;
      
      public var _mc:MObject;
      
      public function GemcheckPopUI()
      {
         super();
      }
      
      public static function getInstance() : GemcheckPopUI
      {
         if(instance == null)
         {
            instance = new GemcheckPopUI();
         }
         return instance;
      }
      
      public function Init() : void
      {
         if(this._mc)
         {
            return;
         }
         this._mc = new MObject("GemcheckPop",380,290);
         this.initMcElement();
      }
      
      private function initMcElement() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         var _loc3_:Sprite = null;
         var _loc4_:XMovieClip = null;
         this._mc.getMC().btn_planbar.visible = false;
         _loc1_ = 0;
         while(_loc1_ < 12)
         {
            _loc2_ = this._mc.getMC().getChildByName("pic_" + _loc1_) as MovieClip;
            _loc2_.mouseChildren = false;
            if(_loc1_ < 8)
            {
               _loc2_ = this._mc.getMC().getChildByName("mc_txt" + _loc1_) as MovieClip;
               _loc2_.visible = false;
               _loc2_ = this._mc.getMC().getChildByName("skillmc_" + _loc1_) as MovieClip;
               _loc2_.mouseChildren = false;
            }
            if(_loc1_ < 4)
            {
               _loc2_ = this._mc.getMC().getChildByName("mc_" + _loc1_) as MovieClip;
               _loc2_.mouseChildren = false;
            }
            _loc1_++;
         }
         this._mc.getMC().addEventListener(MouseEvent.MOUSE_OVER,this.mouseOver);
         _loc1_ = 0;
         while(_loc1_ < 5)
         {
            _loc3_ = this._mc.getMC().getChildByName("mc_pic" + _loc1_) as Sprite;
            _loc3_.addChildAt(new Bitmap(),0);
            _loc4_ = new XMovieClip(_loc3_ as MovieClip);
            _loc4_.Data = _loc1_;
            _loc4_.OnMouseOver = this.ChipOver;
            _loc3_.addEventListener(MouseEvent.MOUSE_OUT,this.ChipOut);
            _loc1_++;
         }
      }
      
      private function ChipOut(param1:MouseEvent) : void
      {
         CommanderChipTip.Hide();
      }
      
      private function ChipOver(param1:MouseEvent, param2:XMovieClip) : void
      {
         var _loc3_:CmosInfo = new CmosInfo();
         _loc3_.Exp = 0;
         _loc3_.PropsId = CommanderRouter.instance.commanderstoneinfo.Cmos[param2.Data];
         if(_loc3_.PropsId > 0)
         {
            CommanderChipTip.Show(param2.m_movie,_loc3_,false);
         }
      }
      
      public function initpop() : void
      {
         var _loc4_:Bitmap = null;
         var _loc5_:int = 0;
         var _loc6_:Number = NaN;
         var _loc9_:MovieClip = null;
         var _loc10_:int = 0;
         var _loc11_:Bitmap = null;
         var _loc12_:propsInfo = null;
         var _loc13_:BitmapData = null;
         var _loc14_:Number = NaN;
         var _loc1_:int = CommanderRouter.instance.commanderstoneinfo.SkillId;
         var _loc2_:MovieClip = this._mc.getMC().mcheadbase as MovieClip;
         var _loc3_:String = CCommanderReader.getInstance().getCommanderAvatar(_loc1_);
         _loc4_ = new Bitmap(GameKernel.getTextureInstance(_loc3_));
         if(_loc2_.numChildren > 1)
         {
            _loc2_.removeChildAt(1);
         }
         _loc2_.addChild(_loc4_);
         this._mc.getMC().tf_name.text = CCommanderReader.getInstance().getCommanderName(_loc1_);
         this._mc.getMC().tf_membership.text = CommanderRouter.instance.commanderstoneinfo.UserName;
         this._mc.getMC().tf_LV.text = String(CommanderRouter.instance.commanderstoneinfo.Level + 1);
         this._mc.getMC().mc_grade.gotoAndStop(CommanderRouter.instance.commanderstoneinfo.CardLevel + 2);
         this._mc.getMC().tf_jingzhun.text = String(CommanderRouter.instance.commanderstoneinfo.Aim);
         this._mc.getMC().tf_sudu.text = String(CommanderRouter.instance.commanderstoneinfo.Priority);
         this._mc.getMC().tf_guibi.text = String(CommanderRouter.instance.commanderstoneinfo.Blench);
         this._mc.getMC().tf_dianzi.text = String(CommanderRouter.instance.commanderstoneinfo.Electron);
         _loc5_ = 0;
         while(_loc5_ < 8)
         {
            _loc9_ = this._mc.getMC().getChildByName("mc_txt" + _loc5_) as MovieClip;
            _loc9_.gotoAndStop(CommanderRouter.instance.commanderstoneinfo.CommanderZJ.charAt(_loc5_));
            _loc9_.visible = true;
            _loc5_++;
         }
         _loc6_ = CommanderRouter.instance.commanderstoneinfo.S_Blast * 0.1;
         this._mc.getMC().tf_baojirate1.text = "+ " + String(_loc6_.toFixed(1)) + "%";
         _loc6_ = CommanderRouter.instance.commanderstoneinfo.S_BlastHurt * 0.1;
         this._mc.getMC().tf_baoji1.text = "+ " + String(_loc6_.toFixed(1)) + "%";
         _loc6_ = CommanderRouter.instance.commanderstoneinfo.S_DoubleHit * 0.1;
         this._mc.getMC().tf_shuang1.text = "+ " + String(_loc6_.toFixed(1)) + "%";
         _loc6_ = CommanderRouter.instance.commanderstoneinfo.S_Shield * 0.1;
         this._mc.getMC().tf_hudun1.text = "+ " + String(_loc6_.toFixed(1)) + "%";
         _loc6_ = CommanderRouter.instance.commanderstoneinfo.S_RepairShield * 0.1;
         this._mc.getMC().tf_hudunhuifu1.text = "+ " + String(_loc6_.toFixed(1)) + "%";
         _loc6_ = CommanderRouter.instance.commanderstoneinfo.S_Endure * 0.1;
         this._mc.getMC().tf_jiegou1.text = "+ " + String(_loc6_.toFixed(1)) + "%";
         _loc6_ = CommanderRouter.instance.commanderstoneinfo.S_Exp * 0.1;
         this._mc.getMC().tf_jingyan1.text = "+ " + String(_loc6_.toFixed(1)) + "%";
         _loc6_ = CommanderRouter.instance.commanderstoneinfo.S_Assault * 0.1;
         this._mc.getMC().tf_gongjili1.text = "+ " + String(_loc6_.toFixed(1)) + "%";
         this._mc.getMC().tf_jingzhun1.text = "+ " + String(CommanderRouter.instance.commanderstoneinfo.S_Aim);
         this._mc.getMC().tf_guibi1.text = "+ " + String(CommanderRouter.instance.commanderstoneinfo.S_Blench);
         this._mc.getMC().tf_dianzi1.text = "+ " + String(CommanderRouter.instance.commanderstoneinfo.S_Electron);
         this._mc.getMC().tf_sudu1.text = "+ " + String(CommanderRouter.instance.commanderstoneinfo.S_Priority);
         this._mc.getMC().tf_jingzhun0.text = "+ " + String(CommanderRouter.instance.commanderstoneinfo.S_Aim);
         this._mc.getMC().tf_sudu0.text = "+ " + String(CommanderRouter.instance.commanderstoneinfo.S_Priority);
         this._mc.getMC().tf_guibi0.text = "+ " + String(CommanderRouter.instance.commanderstoneinfo.S_Blench);
         this._mc.getMC().tf_dianzi0.text = "+ " + String(CommanderRouter.instance.commanderstoneinfo.S_Electron);
         var _loc7_:Number = CommanderRouter.instance.commanderstoneinfo.AimPer / 10;
         this._mc.getMC().tf_jingzhun2.htmlText = "<FONT COLOR=\'" + this.selectColor(CommanderRouter.instance.commanderstoneinfo.AimPer) + "\'>" + _loc7_ + "</FONT> ";
         _loc7_ = CommanderRouter.instance.commanderstoneinfo.BlenchPer / 10;
         this._mc.getMC().tf_guibi2.htmlText = "<FONT COLOR=\'" + this.selectColor(CommanderRouter.instance.commanderstoneinfo.BlenchPer) + "\'>" + _loc7_ + "</FONT> ";
         _loc7_ = CommanderRouter.instance.commanderstoneinfo.ElectronPer / 10;
         this._mc.getMC().tf_dianzi2.htmlText = "<FONT COLOR=\'" + this.selectColor(CommanderRouter.instance.commanderstoneinfo.ElectronPer) + "\'>" + _loc7_ + "</FONT> ";
         _loc7_ = CommanderRouter.instance.commanderstoneinfo.PriorityPer / 10;
         this._mc.getMC().tf_sudu2.htmlText = "<FONT COLOR=\'" + this.selectColor(CommanderRouter.instance.commanderstoneinfo.PriorityPer) + "\'>" + _loc7_ + "</FONT> ";
         var _loc8_:int = CCommanderReader.getInstance().GetCommanderExp(CommanderRouter.instance.commanderstoneinfo.Level);
         if(_loc8_ == 0)
         {
            this._mc.getMC().mc_planbar.width = 0;
         }
         else
         {
            this._mc.getMC().mc_planbar.width = int(CommanderRouter.instance.commanderstoneinfo.Exp * 104 / _loc8_);
         }
         _loc5_ = 0;
         while(_loc5_ < 5)
         {
            _loc10_ = int(CommanderRouter.instance.commanderstoneinfo.Cmos[_loc5_]);
            _loc11_ = Bitmap(Sprite(this._mc.getMC().getChildByName("mc_pic" + _loc5_)).getChildAt(0));
            if(_loc10_ > 0)
            {
               _loc12_ = CPropsReader.getInstance().GetPropsInfo(_loc10_);
               _loc13_ = GameKernel.getTextureInstance(_loc12_.ImageFileName);
               _loc11_.bitmapData = _loc13_;
               _loc11_.width = 20;
               _loc11_.height = 20;
               _loc14_ = _loc12_.ChipValue;
               if(_loc14_ < 1)
               {
                  TextField(this._mc.getMC().getChildByName("txt_plus" + _loc5_)).text = "+" + Number(_loc14_ * 100) + "%";
               }
               else
               {
                  TextField(this._mc.getMC().getChildByName("txt_plus" + _loc5_)).text = "+" + _loc14_;
               }
            }
            else
            {
               TextField(this._mc.getMC().getChildByName("txt_plus" + _loc5_)).text = "+0";
               _loc11_.bitmapData = null;
            }
            _loc5_++;
         }
      }
      
      private function mouseOver(param1:Event) : void
      {
         var _loc4_:MovieClip = null;
         var _loc2_:String = param1.target.name;
         var _loc3_:int = int(_loc2_.search("_"));
         _loc2_ = _loc2_.slice(0,_loc3_);
         switch(_loc2_)
         {
            case "mc":
               _loc4_ = param1.target as MovieClip;
               if(_loc4_.hasEventListener(MouseEvent.MOUSE_OVER))
               {
                  break;
               }
               _loc2_ = param1.target.name.substring(3);
               _loc4_.addEventListener(MouseEvent.MOUSE_OUT,this.outPic,false,1,true);
               this.showmc(int(_loc2_),_loc4_);
               break;
            case "skillmc":
               _loc4_ = param1.target as MovieClip;
               _loc2_ = param1.target.name.substring(8);
               _loc4_.addEventListener(MouseEvent.MOUSE_OUT,this.outPic,false,1,true);
               this.showskillmc(int(_loc2_),_loc4_);
               break;
            case "pic":
               _loc4_ = param1.target as MovieClip;
               if(_loc4_.hasEventListener(MouseEvent.MOUSE_OVER))
               {
                  break;
               }
               _loc2_ = param1.target.name.substring(4);
               _loc4_.addEventListener(MouseEvent.MOUSE_OUT,this.outPic,false,1,true);
               this.showpic(int(_loc2_),_loc4_);
         }
      }
      
      private function showmc(param1:int, param2:MovieClip) : void
      {
         var _loc3_:int = 35 + param1;
         var _loc4_:String = "IconText" + String(_loc3_);
         _loc4_ = StringManager.getInstance().getMessageString(_loc4_);
         var _loc5_:TextField = new TextField();
         _loc5_.htmlText = _loc4_;
         _loc5_.wordWrap = true;
         _loc5_.autoSize = TextFieldAutoSize.LEFT;
         _loc5_.multiline = true;
         var _loc6_:TextField = new TextField();
         _loc6_.width = _loc5_.width + 5;
         _loc6_.text = "(" + StringManager.getInstance().getMessageString("CommanderText134") + ")";
         _loc6_.wordWrap = true;
         _loc6_.autoSize = TextFieldAutoSize.LEFT;
         _loc6_.multiline = true;
         var _loc7_:TextField = new TextField();
         _loc7_.textColor = 16777215;
         var _loc8_:String = this.selectColor(this.selectShuxing(param1));
         var _loc9_:Number = this.selectShuxing(param1) / 10;
         _loc7_.htmlText = StringManager.getInstance().getMessageString("CommanderText133") + "<FONT COLOR=\'" + _loc8_ + "\'>" + _loc9_ + "</FONT> ";
         _loc7_.wordWrap = true;
         _loc7_.autoSize = TextFieldAutoSize.LEFT;
         _loc7_.multiline = true;
         Suspension.getInstance();
         var _loc10_:Point = param2.localToGlobal(new Point(0,0));
         _loc10_ = this._mc.getMC().globalToLocal(_loc10_);
         if(param1 == 0)
         {
            Suspension.getInstance().Init(_loc5_.width + 5,_loc5_.height + _loc6_.height + _loc7_.textHeight - 7,1);
            Suspension.getInstance().setLocationXY(_loc10_.x,_loc10_.y + 20);
            Suspension.getInstance().putRectOnlyOne(0,_loc4_,_loc5_.width + 5,_loc5_.height);
            Suspension.getInstance().putRectOnlyOne2(_loc5_.height - 3,_loc7_.htmlText,_loc5_.width + 5,_loc7_.height);
            Suspension.getInstance().putRectOnlyOne2(_loc5_.height + _loc7_.height - 9,_loc6_.text,_loc5_.width + 5,_loc6_.height);
         }
         else
         {
            Suspension.getInstance().Init(_loc5_.width + 5,_loc5_.height + _loc7_.height - 3,1);
            Suspension.getInstance().setLocationXY(_loc10_.x,_loc10_.y + 20);
            Suspension.getInstance().putRectOnlyOne(0,_loc4_,_loc5_.width + 5,_loc5_.height);
            Suspension.getInstance().putRectOnlyOne2(_loc5_.height - 3,_loc7_.htmlText,_loc5_.width + 5,_loc7_.height);
         }
         this._mc.getMC().addChild(Suspension.getInstance());
      }
      
      private function selectShuxing(param1:int) : int
      {
         if(param1 == 0)
         {
            return CommanderRouter.instance.commanderstoneinfo.AimPer;
         }
         if(param1 == 1)
         {
            return CommanderRouter.instance.commanderstoneinfo.PriorityPer;
         }
         if(param1 == 2)
         {
            return CommanderRouter.instance.commanderstoneinfo.BlenchPer;
         }
         return CommanderRouter.instance.commanderstoneinfo.ElectronPer;
      }
      
      private function selectColor(param1:int) : String
      {
         if(param1 >= 0 && param1 < 30)
         {
            return "#FFFFFF";
         }
         if(param1 >= 30 && param1 < 40)
         {
            return "#00FF1F";
         }
         if(param1 >= 40 && param1 < 47)
         {
            return "#0090F8";
         }
         if(param1 >= 47 && param1 < 50)
         {
            return "#A66BD3";
         }
         if(param1 == 50)
         {
            return "#FF0000";
         }
         return "";
      }
      
      private function showskillmc(param1:int, param2:MovieClip) : void
      {
         var _loc3_:int = 36 + param1;
         var _loc4_:String = "CommanderText" + String(_loc3_);
         _loc4_ = StringManager.getInstance().getMessageString(_loc4_);
         var _loc5_:TextField = new TextField();
         _loc5_.text = _loc4_;
         _loc5_.width = _loc5_.textWidth + 5;
         var _loc6_:int = 54 + param1;
         var _loc7_:String = "CommanderText" + String(_loc6_);
         _loc7_ = StringManager.getInstance().getMessageString(_loc7_);
         var _loc8_:TextField = new TextField();
         _loc8_.htmlText = _loc7_;
         _loc8_.wordWrap = true;
         _loc8_.autoSize = TextFieldAutoSize.LEFT;
         _loc8_.multiline = true;
         _loc8_.width = _loc5_.textWidth;
         Suspension.getInstance();
         Suspension.getInstance().Init(_loc8_.width + 5,_loc8_.height + 20,1);
         var _loc9_:Point = param2.localToGlobal(new Point(0,0));
         _loc9_ = this._mc.getMC().globalToLocal(_loc9_);
         Suspension.getInstance().setLocationXY(_loc9_.x,_loc9_.y + 40);
         Suspension.getInstance().putRectOnlyOne(0,_loc4_,_loc8_.width + 5,20);
         Suspension.getInstance().putRectOnlyOne(1,_loc7_,_loc8_.width + 5,_loc8_.height);
         this._mc.getMC().addChild(Suspension.getInstance());
      }
      
      private function showpic(param1:int, param2:MovieClip) : void
      {
         var _loc4_:int = 0;
         var _loc3_:TextField = new TextField();
         _loc4_ = 134 + param1;
         var _loc5_:String = "CorpsText" + String(_loc4_);
         _loc3_.text = StringManager.getInstance().getMessageString(_loc5_);
         _loc3_.wordWrap = true;
         _loc3_.autoSize = TextFieldAutoSize.LEFT;
         _loc3_.multiline = true;
         Suspension.getInstance();
         if(_loc3_.textWidth + 5 > 100)
         {
            _loc3_.width = 100;
         }
         else
         {
            _loc3_.width = _loc3_.textWidth + 5;
         }
         Suspension.getInstance().Init(_loc3_.width + 5,_loc3_.height,1);
         var _loc6_:Point = param2.localToGlobal(new Point(0,0));
         _loc6_ = this._mc.getMC().globalToLocal(_loc6_);
         Suspension.getInstance().setLocationXY(_loc6_.x,_loc6_.y + 20);
         var _loc7_:int = 0;
         while(_loc7_ < 1)
         {
            Suspension.getInstance().putRectOnlyOne(_loc7_,_loc3_.text,_loc3_.width + 5,_loc3_.height);
            _loc7_++;
         }
         this._mc.getMC().addChild(Suspension.getInstance());
      }
      
      private function outPic(param1:Event) : void
      {
         this._mc.getMC().removeChild(Suspension.getInstance());
         Suspension.getInstance().delinstance();
         param1.target.removeEventListener(MouseEvent.MOUSE_OUT,this.outPic);
      }
   }
}

