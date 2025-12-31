package logic.ui
{
   import com.star.frameworks.display.Container;
   import com.star.frameworks.events.ActionEvent;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import logic.entry.GamePlayer;
   import logic.game.GameKernel;
   import logic.ui.info.BleakingLineForThai;
   
   public class Suspension extends Container
   {
      
      public static var instance:Suspension;
      
      private var txtLAry:Array = new Array();
      
      private var txtRAry:Array = new Array();
      
      private var m_IsIn:int = 0;
      
      public var m_timesArry:Array = new Array(0,0);
      
      public function Suspension()
      {
         super();
         setEnable(false);
      }
      
      public static function getInstance() : Suspension
      {
         if(instance == null)
         {
            instance = new Suspension();
         }
         return instance;
      }
      
      public function setInstanceNull() : void
      {
         instance = null;
      }
      
      public function Init(param1:int, param2:int, param3:int) : void
      {
         if(this.m_timesArry[param3] == 0)
         {
            this.m_timesArry[param3] = 1;
            graphics.clear();
            graphics.lineStyle(1,479858);
            graphics.beginFill(0,0.8);
            if(GamePlayer.getInstance().language == 10)
            {
               graphics.drawRoundRect(0,0,param1 + 10,param2 + 20,5,10);
            }
            else
            {
               graphics.drawRoundRect(0,0,param1,param2,5,10);
            }
            graphics.endFill();
         }
      }
      
      public function Resume() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < 14)
         {
            if(this.contains(this.txtRAry[_loc1_]))
            {
               removeChild(this.txtRAry[_loc1_]);
            }
            _loc1_++;
         }
         this.txtRAry.length = 0;
      }
      
      public function putRect(param1:int, param2:String, param3:String, param4:uint = 16777215, param5:uint = 16777215, param6:int = 100, param7:int = 100) : void
      {
         var _loc8_:TextField = this.createTextField(0,20 * param1,param6,20,param2,param4);
         var _loc9_:TextField = this.createTextField(param6,20 * param1,param7,20,param3,param5);
         this.txtLAry.push(_loc8_);
         this.txtRAry.push(_loc9_);
      }
      
      public function putRectImg(param1:int, param2:String, param3:String, param4:uint, param5:uint) : void
      {
         var _loc6_:TextField = this.createTextField(100,20 * param1,100,20,param3,param5);
         this.txtRAry.push(_loc6_);
         var _loc7_:Bitmap = this.createImg(0,20 * param1,20,param2);
         this.txtRAry.push(_loc7_);
      }
      
      public function putRectOnlyOne(param1:int, param2:String, param3:int = 100, param4:int = 20, param5:int = 20) : void
      {
         var _loc6_:TextField = this.createTextField(0,param5 * param1,param3,param4,param2);
         _loc6_.wordWrap = true;
         this.txtLAry.push(_loc6_);
      }
      
      public function putRectOnlyOne2(param1:int, param2:String, param3:int = 100, param4:int = 20) : void
      {
         var _loc5_:TextField = this.createTextField(0,param1,param3,param4,param2);
         this.txtLAry.push(_loc5_);
      }
      
      private function createImg(param1:Number, param2:Number, param3:Number, param4:String) : Bitmap
      {
         var _loc5_:Bitmap = new Bitmap(GameKernel.getTextureInstance(param4));
         _loc5_.x = param1 + 28;
         _loc5_.y = param2;
         _loc5_.width *= 0.8;
         _loc5_.height *= 0.8;
         addChild(_loc5_);
         return _loc5_;
      }
      
      private function createTextField(param1:Number, param2:Number, param3:Number, param4:Number, param5:String = "ddd", param6:uint = 16777215) : TextField
      {
         var _loc7_:TextField = new TextField();
         _loc7_.x = param1;
         _loc7_.y = param2;
         _loc7_.width = param3;
         _loc7_.height = param4;
         _loc7_.selectable = true;
         _loc7_.mouseEnabled = false;
         _loc7_.textColor = param6;
         _loc7_.multiline = true;
         _loc7_.wordWrap = true;
         _loc7_.htmlText = param5;
         BleakingLineForThai.GetInstance().BleakThaiLanguage(_loc7_,param6);
         addChild(_loc7_);
         return _loc7_;
      }
      
      public function Show() : void
      {
         GameKernel.renderManager.getUI().addComponent(instance);
      }
      
      public function Hide() : void
      {
         GameKernel.renderManager.getUI().removeComponent(instance);
      }
      
      private function mouseover(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < 14)
         {
            _loc2_++;
         }
         this.Show();
      }
      
      private function mouseout(param1:MouseEvent) : void
      {
         this.Resume();
         this.Hide();
      }
      
      public function delinstance() : void
      {
         this.removeEventListener(ActionEvent.ACTION_MOUSE_OVER,this.mouseover);
         this.removeEventListener(ActionEvent.ACTION_MOUSE_OUT,this.mouseout);
         instance = null;
      }
   }
}

