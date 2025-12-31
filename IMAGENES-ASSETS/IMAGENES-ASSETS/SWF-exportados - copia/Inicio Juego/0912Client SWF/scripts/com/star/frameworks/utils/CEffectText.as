package com.star.frameworks.utils
{
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.text.AntiAliasType;
   import flash.text.GridFitType;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import gs.TweenLite;
   import logic.game.GameKernel;
   import logic.ui.info.BleakingLineForThai;
   
   public class CEffectText
   {
      
      private static var instance:CEffectText;
      
      private var mBg:MovieClip;
      
      private var mShowTxt:TextField;
      
      private var newFormat:TextFormat;
      
      private var m_parent:DisplayObjectContainer;
      
      public function CEffectText()
      {
         super();
         this.newFormat = new TextFormat();
         this.newFormat.color = 16777215;
         this.newFormat.size = 15;
         this.mShowTxt = new TextField();
         this.mShowTxt.autoSize = TextFieldAutoSize.LEFT;
         var _loc1_:TextFormat = new TextFormat();
         _loc1_.font = "Times New Roman";
         this.mShowTxt.defaultTextFormat = _loc1_;
         this.mShowTxt.gridFitType = GridFitType.SUBPIXEL;
         this.mShowTxt.antiAliasType = AntiAliasType.ADVANCED;
         this.mShowTxt.setTextFormat(_loc1_);
         this.mBg = GameKernel.getMovieClipInstance("TransparentPicMc");
         this.mBg.addChild(this.mShowTxt);
      }
      
      public static function getInstance() : CEffectText
      {
         if(instance == null)
         {
            instance = new CEffectText();
         }
         return instance;
      }
      
      public function showEffectText(param1:DisplayObjectContainer, param2:String, param3:Boolean = false) : void
      {
         this.m_parent = param1;
         this.mBg.y = 50;
         if(param3 && this.mShowTxt.text != "")
         {
            this.mShowTxt.appendText(param2);
         }
         else
         {
            this.mShowTxt.text = param2;
         }
         BleakingLineForThai.GetInstance().BleakThaiLanguage(this.mShowTxt,16777215);
         this.mShowTxt.setTextFormat(this.newFormat);
         this.mShowTxt.selectable = false;
         this.mShowTxt.mouseEnabled = false;
         this.mShowTxt.mouseWheelEnabled = false;
         this.mShowTxt.tabEnabled = false;
         this.mShowTxt.alpha = 80;
         this.mBg.x = (Math.min(param1.width,GameKernel.getInstance().stage.stageWidth) - this.mBg.width) / 2;
         this.mBg.x += GameKernel.fullRect.x;
         this.mShowTxt.x = this.mBg.width - this.mShowTxt.width >> 1;
         this.mShowTxt.y = this.mBg.height - this.mShowTxt.height >> 1;
         param1.addChild(this.mBg);
         TweenLite.to(this.mShowTxt,2,{
            "alpha":0,
            "onComplete":this.ShowComplete
         });
      }
      
      private function ShowComplete() : void
      {
         if(this.m_parent.getChildIndex(this.mBg) != -1)
         {
            this.m_parent.removeChild(this.mBg);
            this.mShowTxt.text = "";
         }
      }
   }
}

