package logic.utils
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.filters.DropShadowFilter;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import logic.entry.GamePlayer;
   import logic.entry.commander.CommanderXmlInfo;
   import logic.entry.props.propsInfo;
   import logic.game.GameKernel;
   import logic.reader.CCommanderReader;
   import logic.reader.CPropsReader;
   import logic.ui.info.BleakingLineForThai;
   import logic.widget.StartComderDrag;
   
   public class Commander
   {
      
      private static var instance:Commander;
      
      private var first:Boolean = true;
      
      private var carmc:MovieClip;
      
      private var bit:Bitmap;
      
      private var tf:TextFormat = new TextFormat();
      
      private var down_mc:MovieClip;
      
      private var up_mc:MovieClip;
      
      private var drag_mc:MovieClip;
      
      private var tt_txt:TextField;
      
      private var tip:MovieClip;
      
      private var ltip:MovieClip;
      
      private var pid:int = 0;
      
      private var commanderComent:String = "";
      
      private var shap:MovieClip;
      
      private var ckbo:Boolean = false;
      
      public function Commander()
      {
         super();
         this.carmc = new MovieClip();
         this.tf.font = "宋体";
         this.tf.size = 12;
         this.tf.letterSpacing = 1;
         this.shap = new MovieClip();
      }
      
      public static function getInstance() : Commander
      {
         if(instance == null)
         {
            instance = new Commander();
         }
         return instance;
      }
      
      private function init() : void
      {
         if(this.first)
         {
            BluecardUi.getInstance().Init();
            GreencardUi.getInstance().Init();
            YellowcardUi.getInstance().Init();
            GoldenCardUI.getInstance().Init();
         }
         this.first = false;
      }
      
      public function CommanderTip(param1:Number = 0, param2:Number = 0, param3:int = 0, param4:Boolean = false) : MovieClip
      {
         this.init();
         this.ckbo = param4;
         var _loc5_:int = 0;
         var _loc6_:String = "";
         var _loc7_:String = "";
         var _loc8_:int = 0;
         this.pid = param3;
         var _loc9_:String = "";
         var _loc10_:int = 0;
         var _loc11_:propsInfo = CPropsReader.getInstance().GetPropsInfo(param3);
         if(_loc11_.PackID == 1)
         {
            _loc8_ = param3 % 9 + 1;
            _loc5_ = int(_loc11_.CommanderType);
            _loc7_ = _loc11_.Comment;
            _loc6_ = _loc11_.Name;
            _loc10_ = _loc11_.SkillID;
         }
         var _loc12_:CommanderXmlInfo = this.GetCommanderInfo(_loc11_.Id);
         var _loc13_:int = _loc12_.Type;
         _loc8_++;
         _loc9_ = CCommanderReader.getInstance().getCommanderImage(_loc10_);
         this.commanderComent = CCommanderReader.getInstance().getCommanderDescription(_loc10_);
         this.bit = new Bitmap(GameKernel.getTextureInstance(_loc9_));
         switch(_loc5_)
         {
            case 2:
               this.carmc = GreencardUi.getInstance().getPopUp().getMC();
               GreencardUi.getInstance().content.mc_grade.gotoAndStop(_loc8_);
               GreencardUi.getInstance().content.mc_herostar.gotoAndStop(_loc13_ - 1);
               GreencardUi.getInstance().content.tf_content.htmlText = _loc7_.toString();
               BleakingLineForThai.GetInstance().BleakThaiLanguage(GreencardUi.getInstance().content.tf_content,16777215,false);
               GreencardUi.getInstance().content.tf_commandername.text = _loc6_.toString();
               if(this.bit != null && Boolean(GreencardUi.getInstance().content.mc_commanderbase.contains(this.bit)))
               {
                  GreencardUi.getInstance().content.mc_commanderbase.removeChild(this.bit);
               }
               GreencardUi.getInstance().content.mc_commanderbase.addChild(this.bit);
               this.MoveFunction(GreencardUi.getInstance().btn_down.m_movie,GreencardUi.getInstance().btn_up.m_movie,GreencardUi.getInstance().content.mc_drag,GreencardUi.getInstance().content.tf_content,GreencardUi.getInstance().content.btn_enter);
               break;
            case 1:
               this.carmc = BluecardUi.getInstance().getPopUp().getMC();
               BluecardUi.getInstance().content.mc_grade.gotoAndStop(_loc8_);
               BluecardUi.getInstance().content.mc_herostar.gotoAndStop(_loc13_ - 1);
               BluecardUi.getInstance().content.tf_content.htmlText = _loc7_.toString();
               BleakingLineForThai.GetInstance().BleakThaiLanguage(BluecardUi.getInstance().content.tf_content,16777215,false);
               BluecardUi.getInstance().content.tf_commandername.text = _loc6_.toString();
               if(this.bit != null && Boolean(BluecardUi.getInstance().content.mc_commanderbase.contains(this.bit)))
               {
                  BluecardUi.getInstance().content.mc_commanderbase.removeChild(this.bit);
               }
               BluecardUi.getInstance().content.mc_commanderbase.addChild(this.bit);
               this.MoveFunction(BluecardUi.getInstance().btn_down.m_movie,BluecardUi.getInstance().btn_up.m_movie,BluecardUi.getInstance().content.mc_drag,BluecardUi.getInstance().content.tf_content,BluecardUi.getInstance().content.btn_enter);
               break;
            case 3:
               this.carmc = YellowcardUi.getInstance().getPopUp().getMC();
               YellowcardUi.getInstance().content.mc_grade.gotoAndStop(_loc8_);
               YellowcardUi.getInstance().content.mc_herostar.gotoAndStop(_loc13_ - 1);
               YellowcardUi.getInstance().content.tf_content.htmlText = _loc7_.toString();
               BleakingLineForThai.GetInstance().BleakThaiLanguage(YellowcardUi.getInstance().content.tf_content,16777215,false);
               YellowcardUi.getInstance().content.tf_commandername.text = _loc6_.toString();
               if(this.bit != null && Boolean(YellowcardUi.getInstance().content.mc_commanderbase.contains(this.bit)))
               {
                  YellowcardUi.getInstance().content.mc_commanderbase.removeChild(this.bit);
               }
               YellowcardUi.getInstance().content.mc_commanderbase.addChild(this.bit);
               this.MoveFunction(YellowcardUi.getInstance().btn_down.m_movie,YellowcardUi.getInstance().btn_up.m_movie,YellowcardUi.getInstance().content.mc_drag,YellowcardUi.getInstance().content.tf_content,YellowcardUi.getInstance().content.btn_enter);
               break;
            case 5:
               this.carmc = GoldenCardUI.getInstance().getPopUp().getMC();
               GoldenCardUI.getInstance().content.mc_grade.gotoAndStop(_loc8_);
               GoldenCardUI.getInstance().content.mc_herostar.gotoAndStop(_loc13_ - 1);
               GoldenCardUI.getInstance().content.tf_content.htmlText = _loc7_.toString();
               BleakingLineForThai.GetInstance().BleakThaiLanguage(GoldenCardUI.getInstance().content.tf_content,16777215,false);
               GoldenCardUI.getInstance().content.tf_commandername.text = _loc6_.toString();
               if(this.bit != null && Boolean(GoldenCardUI.getInstance().content.mc_commanderbase.contains(this.bit)))
               {
                  GoldenCardUI.getInstance().content.mc_commanderbase.removeChild(this.bit);
               }
               GoldenCardUI.getInstance().content.mc_commanderbase.addChild(this.bit);
               this.MoveFunction(GoldenCardUI.getInstance().btn_down.m_movie,GoldenCardUI.getInstance().btn_up.m_movie,GoldenCardUI.getInstance().content.mc_drag,GoldenCardUI.getInstance().content.tf_content,GoldenCardUI.getInstance().content.btn_enter);
         }
         this.carmc.mouseEnabled = true;
         this.carmc.x = param1;
         this.carmc.y = param2;
         StartComderDrag.getInstance().Register(this.carmc);
         return this.carmc;
      }
      
      private function MoveFunction(param1:MovieClip, param2:MovieClip, param3:MovieClip, param4:TextField, param5:MovieClip) : void
      {
         var _loc6_:TextFormat = null;
         this.down_mc = param1;
         this.up_mc = param2;
         this.drag_mc = param3;
         this.tt_txt = param4;
         this.tip = param5;
         if(GamePlayer.getInstance().language == 10)
         {
            _loc6_ = this.tt_txt.getTextFormat();
            _loc6_.align = TextFieldAutoSize.RIGHT;
            this.tt_txt.setTextFormat(_loc6_);
            this.tt_txt.defaultTextFormat = _loc6_;
         }
         if(this.tt_txt.maxScrollV <= 1)
         {
            this.down_mc.visible = false;
            this.up_mc.visible = false;
            this.drag_mc.visible = false;
            this.tt_txt.width = 155;
         }
         else
         {
            this.down_mc.visible = true;
            this.up_mc.visible = true;
            this.drag_mc.visible = true;
            this.tt_txt.width = 148;
            this.tt_txt.scrollV = 1;
         }
         this.down_mc.addEventListener(MouseEvent.MOUSE_DOWN,this.ddHd);
         this.up_mc.addEventListener(MouseEvent.MOUSE_DOWN,this.ddHd);
         this.tip.buttonMode = true;
         this.tip.addEventListener(MouseEvent.ROLL_OVER,this.rooHd);
         this.tip.addEventListener(MouseEvent.ROLL_OUT,this.rouHd);
      }
      
      private function rooHd(param1:MouseEvent) : void
      {
         this.shap = this.littelTip(this.commanderComent);
         param1.currentTarget.parent.addChild(this.shap);
         this.shap.x = param1.currentTarget.x + 30;
         if(this.shap.height > 170)
         {
            this.shap.y = param1.currentTarget.y - 170;
         }
         else
         {
            this.shap.y = param1.currentTarget.y - this.shap.height;
         }
         if(this.ckbo)
         {
            if(param1.currentTarget.parent.x >= 30)
            {
               this.shap.x = param1.currentTarget.x - 320;
            }
         }
         else if(GameKernel.isFullStage)
         {
            if(param1.currentTarget.parent.x > GameKernel.fullRect.width - 20 - param1.currentTarget.parent.width)
            {
               this.shap.x = param1.currentTarget.x - 320;
            }
         }
         else if(param1.currentTarget.parent.x > GameKernel.fullRect.width - 20 - param1.currentTarget.parent.width)
         {
            this.shap.x = param1.currentTarget.x - 320;
         }
      }
      
      private function GetCommanderInfo(param1:int) : CommanderXmlInfo
      {
         var _loc2_:propsInfo = CPropsReader.getInstance().GetPropsInfo(param1);
         return CCommanderReader.getInstance().GetCommanderInfo(_loc2_.SkillID);
      }
      
      public function littelTip(param1:String) : MovieClip
      {
         if(this.shap == null)
         {
            this.shap = new MovieClip();
         }
         this.shap.mouseEnabled = false;
         var _loc2_:TextField = new TextField();
         _loc2_.autoSize = TextFieldAutoSize.LEFT;
         _loc2_.wordWrap = true;
         _loc2_.textColor = 16777215;
         _loc2_.width = 150;
         _loc2_.selectable = false;
         this.shap.addChild(_loc2_);
         _loc2_.x = 5;
         _loc2_.y = 5;
         _loc2_.text = param1;
         BleakingLineForThai.GetInstance().BleakThaiLanguage(_loc2_,16777215);
         this.shap.graphics.clear();
         this.shap.graphics.lineStyle(1,479858);
         this.shap.graphics.beginFill(0,0.7);
         this.shap.graphics.drawRoundRect(0,0,160,_loc2_.height + 10,10,10);
         this.shap.graphics.endFill();
         this.shap.filters = [new DropShadowFilter()];
         var _loc3_:BitmapData = new BitmapData(this.shap.width + 50,this.shap.height + 50,true,0);
         _loc3_.draw(this.shap);
         var _loc4_:Bitmap = new Bitmap(_loc3_);
         var _loc5_:MovieClip = new MovieClip();
         _loc5_.addChild(_loc4_);
         _loc5_.mouseEnabled = false;
         var _loc6_:uint = uint(this.shap.numChildren);
         var _loc7_:uint = 0;
         while(_loc7_ < _loc6_)
         {
            this.shap.removeChildAt(0);
            _loc7_++;
         }
         return _loc5_;
      }
      
      public function CloselittelTip(param1:MovieClip) : void
      {
         var _loc2_:int = param1.numChildren;
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_)
         {
            param1.removeChildAt(0);
            _loc3_++;
         }
      }
      
      private function rouHd(param1:MouseEvent) : void
      {
         if(this.shap != null && Boolean(param1.currentTarget.parent.contains(this.shap)))
         {
            this.CloselittelTip(this.shap);
            param1.currentTarget.parent.removeChild(this.shap);
            this.shap = null;
         }
      }
      
      private function ddHd(param1:MouseEvent) : void
      {
         if(param1.currentTarget.name == "btn_up")
         {
            --this.tt_txt.scrollV;
         }
         else
         {
            ++this.tt_txt.scrollV;
         }
      }
      
      public function CloseEnHd() : void
      {
         if(this.down_mc)
         {
            this.down_mc.stop();
            this.down_mc.removeEventListener(MouseEvent.MOUSE_DOWN,this.ddHd);
         }
         if(this.up_mc)
         {
            this.up_mc.stop();
            this.up_mc.removeEventListener(MouseEvent.MOUSE_DOWN,this.ddHd);
         }
         if(this.drag_mc)
         {
            this.drag_mc.stop();
         }
         if(this.tip)
         {
            this.tip.stop();
            this.tip.removeEventListener(MouseEvent.ROLL_OVER,this.rooHd);
            this.tip.removeEventListener(MouseEvent.ROLL_OUT,this.rouHd);
         }
      }
   }
}

