package logic.utils
{
   import com.star.frameworks.display.Container;
   import com.star.frameworks.managers.ResManager;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.filters.DropShadowFilter;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import logic.entry.GamePlayer;
   import logic.game.GameKernel;
   import logic.ui.info.BleakingLineForThai;
   import logic.widget.com.ComXmlParser;
   import logic.widget.tips.CToolTip;
   
   public class ScienceTip extends MovieClip
   {
      
      public var name_txt:TextField;
      
      public var xy_txt:TextField;
      
      public var dj_txt:TextField;
      
      public var mny_txt:TextField;
      
      public var tm_txt:TextField;
      
      public var con_txt:TextField;
      
      private var shorp:Container;
      
      public var cash_txt:TextField;
      
      private var MoneyIcon:Bitmap;
      
      private var cashIcon:Bitmap;
      
      private var TimeIcon:Bitmap;
      
      private var bbo:Boolean = true;
      
      public function ScienceTip(param1:uint = 113)
      {
         var _loc2_:CToolTip = null;
         this.name_txt = new TextField();
         this.xy_txt = new TextField();
         this.dj_txt = new TextField();
         this.mny_txt = new TextField();
         this.tm_txt = new TextField();
         this.con_txt = new TextField();
         this.shorp = new Container();
         this.cash_txt = new TextField();
         super();
         if(!this.bbo)
         {
            return;
         }
         this.bbo = false;
         var _loc3_:ComXmlParser = new ComXmlParser(GameKernel.resManager.getXml(ResManager.GAMERES,"ScienceInfo"));
         _loc2_ = _loc3_.getToolTipDecorate();
         this.addChild(this.shorp);
         this.shorp.mouseEnabled = false;
         this.name_txt = _loc2_.getObject("BuildingName").Display;
         this.dj_txt = _loc2_.getObject("BuildingLvTxt").Display;
         this.xy_txt = _loc2_.getObject("CommentDesc").Display;
         this.mny_txt = _loc2_.getObject("Moneytext").Display;
         this.tm_txt = _loc2_.getObject("Timetext").Display;
         this.con_txt = _loc2_.getObject("Context").Display;
         this.cash_txt = _loc2_.getObject("Cashtext").Display;
         this.MoneyIcon = _loc2_.getObject("MoneyIcon").Display;
         this.cashIcon = _loc2_.getObject("CashIcon").Display;
         this.TimeIcon = _loc2_.getObject("TimeIcon").Display;
         this.name_txt.x = 0;
         this.name_txt.width = 230;
         var _loc4_:TextFormat = new TextFormat();
         _loc4_.size = 13;
         this.name_txt.setTextFormat(_loc4_);
         this.con_txt.wordWrap = true;
         this.tm_txt.textColor = 3407616;
         this.dj_txt.textColor = 65280;
         this.name_txt.textColor = 13417082;
         this.con_txt.width = 230;
         this.dj_txt.width = 180;
         this.xy_txt.width = 230;
         this.xy_txt.wordWrap = true;
         this.addChild(_loc2_.getDecorate());
         this.mouseEnabled = false;
      }
      
      public function pdd(param1:uint = 0) : void
      {
         BleakingLineForThai.GetInstance().BleakThaiLanguage(this.con_txt,16777215);
         BleakingLineForThai.GetInstance().BleakThaiLanguage(this.xy_txt,16711680);
         switch(param1)
         {
            case 0:
               this.csf(true,3);
               break;
            case 1:
               this.csf(false,3);
               break;
            case 2:
               this.csf(true,3);
         }
         this.shorp.graphics.clear();
         this.shorp.graphics.lineStyle(1,479858);
         this.shorp.graphics.beginFill(0,0.7);
         if(GamePlayer.getInstance().language == 10)
         {
            this.shorp.graphics.drawRoundRect(10,10,this.con_txt.width + 40,this.con_txt.y + this.con_txt.height + 20,10,10);
         }
         else
         {
            this.shorp.graphics.drawRoundRect(10,10,this.con_txt.width + 20,this.con_txt.y + this.con_txt.height + 10,10,10);
         }
         this.shorp.graphics.endFill();
         this.shorp.filters = [new DropShadowFilter()];
      }
      
      private function csf(param1:Boolean = true, param2:uint = 0) : void
      {
         if(param1)
         {
            this.xy_txt.visible = true;
            this.MoneyIcon.visible = true;
            this.cashIcon.visible = true;
            this.TimeIcon.visible = true;
            this.mny_txt.visible = true;
            this.tm_txt.visible = true;
            this.cash_txt.visible = true;
            this.tm_txt.width = 150;
            this.mny_txt.width = 180;
            this.cash_txt.width = 180;
            this.MoneyIcon.y = this.xy_txt.y + this.xy_txt.height;
            this.mny_txt.y = this.MoneyIcon.y;
            this.TimeIcon.y = this.MoneyIcon.y + this.MoneyIcon.height + 3;
            this.tm_txt.y = this.TimeIcon.y;
            this.cashIcon.y = this.TimeIcon.y + this.TimeIcon.height + 3;
            this.cash_txt.y = this.cashIcon.y;
            this.con_txt.y = this.TimeIcon.y + this.TimeIcon.height + 3;
         }
         else
         {
            this.xy_txt.visible = false;
            this.MoneyIcon.visible = false;
            this.cashIcon.visible = false;
            this.TimeIcon.visible = false;
            this.mny_txt.visible = false;
            this.tm_txt.visible = false;
            this.cash_txt.visible = false;
            this.con_txt.y = this.dj_txt.y + this.dj_txt.height;
         }
         if(param2 == 3)
         {
            this.cashIcon.visible = false;
            this.cash_txt.visible = false;
         }
      }
   }
}

