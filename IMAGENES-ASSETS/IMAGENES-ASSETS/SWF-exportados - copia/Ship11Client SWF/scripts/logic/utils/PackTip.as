package logic.utils
{
   import com.star.frameworks.managers.ResManager;
   import com.star.frameworks.managers.StringManager;
   import flash.display.MovieClip;
   import flash.filters.DropShadowFilter;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import logic.entry.GamePlayer;
   import logic.game.GameKernel;
   import logic.ui.info.BleakingLineForThai;
   import logic.widget.com.ComXmlParser;
   import logic.widget.tips.CToolTip;
   
   public class PackTip extends MovieClip
   {
      
      public var name_txt:TextField;
      
      public var con_txt:TextField;
      
      private var shorp:MovieClip;
      
      public var qztj_txt:TextField;
      
      public var ms_txt:TextField;
      
      public var xinji_txt:TextField;
      
      public var SuspendID_text:TextField;
      
      public function PackTip()
      {
         var _loc1_:CToolTip = null;
         this.name_txt = new TextField();
         this.con_txt = new TextField();
         this.shorp = new MovieClip();
         this.qztj_txt = new TextField();
         this.ms_txt = new TextField();
         this.xinji_txt = new TextField();
         this.SuspendID_text = new TextField();
         super();
         var _loc2_:ComXmlParser = new ComXmlParser(GameKernel.resManager.getXml(ResManager.GAMERES,"PackInfo"));
         _loc1_ = _loc2_.getToolTipDecorate();
         this.addChild(this.shorp);
         this.shorp.mouseEnabled = false;
         this.name_txt = _loc1_.getObject("BuildingName").Display;
         this.con_txt = _loc1_.getObject("Context").Display;
         this.addChild(this.ms_txt);
         this.addChild(this.SuspendID_text);
         this.SuspendID_text.autoSize = TextFieldAutoSize.LEFT;
         this.SuspendID_text.x = 20;
         this.ms_txt.autoSize = TextFieldAutoSize.LEFT;
         this.ms_txt.htmlText = StringManager.getInstance().getMessageString("ItemText9");
         this.xinji_txt.autoSize = TextFieldAutoSize.LEFT;
         this.addChild(this.xinji_txt);
         this.xinji_txt.x = 20;
         this.xinji_txt.y = 22;
         this.SuspendID_text.wordWrap = true;
         this.addChild(this.qztj_txt);
         this.qztj_txt.textColor = 16711680;
         this.qztj_txt.visible = false;
         this.qztj_txt.wordWrap = true;
         this.qztj_txt.x = 22;
         this.qztj_txt.autoSize = TextFieldAutoSize.LEFT;
         this.name_txt.textColor = 13417082;
         this.name_txt.selectable = false;
         this.name_txt.x = 5;
         this.name_txt.wordWrap = false;
         this.name_txt.width = 0;
         this.con_txt.width = 0;
         this.addChild(_loc1_.getDecorate());
         this.mouseEnabled = false;
      }
      
      public function pdd(param1:int = 0, param2:Boolean = false, param3:int = 0) : void
      {
         var _loc4_:int = 40;
         this.xinji_txt.y = 22 + this.name_txt.height + 2;
         var _loc5_:int = 22;
         if(this.name_txt.width < 45)
         {
            _loc4_ = 70;
         }
         else if(this.name_txt.width < 65)
         {
            _loc4_ = 60;
         }
         this.name_txt.x = _loc4_;
         if(GamePlayer.getInstance().language == 10)
         {
            this.ms_txt.x = 110;
         }
         else
         {
            this.ms_txt.x = 21;
         }
         this.SuspendID_text.visible = false;
         if(!param2)
         {
            this.ms_txt.y = 40;
            this.con_txt.y = this.name_txt.y + this.name_txt.height + 20;
            if(param3 == 2 || param3 == 3)
            {
               this.SuspendID_text.visible = true;
               this.SuspendID_text.width = this.name_txt.width + _loc4_ * 2;
               this.SuspendID_text.y = this.ms_txt.y + this.ms_txt.height;
               this.con_txt.y = this.name_txt.y + this.name_txt.height + 20 + this.SuspendID_text.height + 2;
            }
         }
         else
         {
            this.ms_txt.y = 40 + _loc5_;
            this.con_txt.y = this.name_txt.y + this.name_txt.height + 20 + _loc5_;
            if(param3 == 2 || param3 == 3)
            {
               this.SuspendID_text.visible = true;
               this.SuspendID_text.y = this.ms_txt.y + this.ms_txt.height;
               this.SuspendID_text.width = this.name_txt.width + _loc4_ * 2;
               this.con_txt.y = this.name_txt.y + this.name_txt.height + 20 + _loc5_ + this.SuspendID_text.height + 2;
            }
         }
         this.con_txt.width = this.name_txt.width + _loc4_ * 2;
         this.qztj_txt.width = this.con_txt.width;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         if(param1 == 0)
         {
            this.qztj_txt.visible = false;
            _loc6_ = this.name_txt.width + _loc4_ * 2;
            _loc7_ = this.con_txt.y + this.con_txt.height;
         }
         else
         {
            this.qztj_txt.visible = true;
            this.qztj_txt.y = this.con_txt.y + this.con_txt.height + 15;
            _loc6_ = this.name_txt.width + _loc4_ * 2;
            _loc7_ = this.con_txt.y + this.con_txt.height + this.qztj_txt.height;
         }
         BleakingLineForThai.GetInstance().BleakThaiLanguage(this.con_txt,16777215);
         BleakingLineForThai.GetInstance().BleakThaiLanguage(this.qztj_txt,16711680);
         BleakingLineForThai.GetInstance().BleakThaiLanguage(this.SuspendID_text,0);
         this.shorp.graphics.clear();
         this.shorp.graphics.lineStyle(1,479858);
         this.shorp.graphics.beginFill(0,0.7);
         if(GamePlayer.getInstance().language == 10)
         {
            this.shorp.graphics.drawRoundRect(15,20,_loc6_ + 30,_loc7_ + 10,10,10);
         }
         else
         {
            this.shorp.graphics.drawRoundRect(15,20,_loc6_ + 10,_loc7_,10,10);
         }
         this.shorp.graphics.endFill();
         this.shorp.filters = [new DropShadowFilter()];
      }
   }
}

