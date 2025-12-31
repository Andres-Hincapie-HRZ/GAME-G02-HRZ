package logic.utils
{
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   
   public class ScienceUiTip extends Sprite
   {
      
      public var name_txt:TextField;
      
      private var back:Shape = new Shape();
      
      private var tf:TextFormat = new TextFormat();
      
      private var tf1:TextFormat = new TextFormat();
      
      public function ScienceUiTip()
      {
         super();
         this.addChild(this.back);
         this.name_txt = new TextField();
         this.name_txt.x = 40;
         this.name_txt.y = 5;
         this.addChild(this.name_txt);
         this.tf.color = 16777215;
         this.tf1.color = 16711680;
         this.mouseEnabled = false;
         this.name_txt.wordWrap = false;
         this.name_txt.autoSize = TextFieldAutoSize.LEFT;
      }
      
      public function pdd() : void
      {
         var _loc1_:int = 120;
         if(this.name_txt.width > 120)
         {
            _loc1_ = this.name_txt.width;
         }
         this.back.graphics.clear();
         this.back.graphics.lineStyle(1,479858);
         this.back.graphics.beginFill(0,0.7);
         this.back.graphics.drawRoundRect(0,2,this.name_txt.x + _loc1_ + 5,30,5,5);
         this.back.graphics.endFill();
         this.name_txt.setTextFormat(this.tf);
      }
      
      public function speedtip() : void
      {
         this.name_txt.x = 2;
         this.name_txt.y = 1;
         this.back.graphics.clear();
         this.back.graphics.lineStyle(1,479858);
         this.back.graphics.beginFill(0,0.7);
         this.back.graphics.drawRoundRect(0,0,this.name_txt.width + 10,this.name_txt.height + 1,5,5);
         this.back.graphics.endFill();
         this.name_txt.setTextFormat(this.tf);
      }
   }
}

