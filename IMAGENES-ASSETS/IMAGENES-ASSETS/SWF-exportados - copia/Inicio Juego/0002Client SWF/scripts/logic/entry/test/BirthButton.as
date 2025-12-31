package logic.entry.test
{
   import flash.display.SimpleButton;
   
   public class BirthButton extends SimpleButton
   {
      
      public var selected:Boolean = false;
      
      public function BirthButton(param1:String = "", param2:int = 80, param3:int = 20)
      {
         super();
         if(param1.length > 0)
         {
            name = param1;
         }
         upState = new ButtonState(param2,param3,param1,0);
         overState = new ButtonState(param2,param3,param1,6710886);
         downState = new ButtonState(param2,param3,param1,16777215);
         hitTestState = new ButtonState(param2,param3);
      }
      
      public function setName(param1:String) : void
      {
         (upState as ButtonState).setName(param1);
         (overState as ButtonState).setName(param1);
         (downState as ButtonState).setName(param1);
      }
   }
}

import flash.display.Sprite;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;

class ButtonState extends Sprite
{
   
   private var label:TextField = new TextField();
   
   public function ButtonState(param1:int, param2:int, param3:String = null, param4:int = 0)
   {
      super();
      addChild(new BirthPanelRect(0,0,param1,param2));
      if(param3)
      {
         this.label.autoSize = TextFieldAutoSize.LEFT;
         this.label.x = 5;
         this.label.y = 0;
         this.label.defaultTextFormat = new TextFormat("Arial",14,param4);
         this.label.text = param3;
         addChild(this.label);
      }
   }
   
   public function setName(param1:String) : void
   {
      this.label.text = param1;
   }
}
