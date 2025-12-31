package logic.entry
{
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import gs.TweenLite;
   import logic.entry.test.BirthButton;
   
   public class Effect02 extends Sprite
   {
      
      private static var _instance:Effect02 = null;
      
      public var btn1:BirthButton = new BirthButton("转向");
      
      public var btn2:BirthButton = new BirthButton("装载");
      
      public var btn3:BirthButton = new BirthButton("修改");
      
      public var btn4:BirthButton = new BirthButton("合并");
      
      public var btn5:BirthButton = new BirthButton("解散");
      
      public var btn6:BirthButton = new BirthButton("回家");
      
      public function Effect02(param1:HHH)
      {
         super();
         name = "Effect02";
         this.btn1.visible = false;
         this.btn2.visible = false;
         this.btn3.visible = false;
         this.btn4.visible = false;
         this.btn5.visible = false;
         addChild(this.btn1);
         addChild(this.btn2);
         addChild(this.btn3);
         addChild(this.btn4);
         addChild(this.btn5);
         addChild(this.btn6);
      }
      
      public static function get instance() : Effect02
      {
         if(_instance == null)
         {
            _instance = new Effect02(new HHH());
         }
         return _instance;
      }
      
      private function checkOut(param1:MouseEvent) : void
      {
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         this.close();
      }
      
      public function open() : void
      {
         this.btn1.visible = true;
         this.btn2.visible = true;
         this.btn3.visible = true;
         this.btn4.visible = true;
         this.btn5.visible = true;
         this.btn6.visible = true;
         TweenLite.to(this.btn1,0.5,{
            "x":30,
            "y":-40
         });
         TweenLite.to(this.btn2,0.5,{
            "x":30,
            "y":-20
         });
         TweenLite.to(this.btn3,0.5,{
            "x":30,
            "y":0
         });
         TweenLite.to(this.btn4,0.5,{
            "x":30,
            "y":20
         });
         TweenLite.to(this.btn5,0.5,{
            "x":30,
            "y":40
         });
         TweenLite.to(this.btn6,0.5,{
            "x":30,
            "y":60
         });
      }
      
      public function close() : void
      {
         TweenLite.to(this.btn1,0.5,{
            "x":0,
            "y":0,
            "onComplete":this.onComplete
         });
         TweenLite.to(this.btn2,0.5,{
            "x":0,
            "y":0
         });
         TweenLite.to(this.btn3,0.5,{
            "x":0,
            "y":0
         });
         TweenLite.to(this.btn4,0.5,{
            "x":0,
            "y":0
         });
         TweenLite.to(this.btn5,0.5,{
            "x":0,
            "y":0
         });
         TweenLite.to(this.btn6,0.5,{
            "x":0,
            "y":0
         });
      }
      
      private function onComplete() : void
      {
         this.btn1.visible = false;
         this.btn2.visible = false;
         this.btn3.visible = false;
         this.btn4.visible = false;
         this.btn5.visible = false;
         this.btn6.visible = false;
      }
   }
}

class HHH
{
   
   public function HHH()
   {
      super();
   }
}
