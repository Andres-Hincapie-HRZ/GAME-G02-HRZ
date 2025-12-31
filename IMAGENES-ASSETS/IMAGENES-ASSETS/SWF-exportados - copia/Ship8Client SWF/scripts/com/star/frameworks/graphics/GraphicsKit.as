package com.star.frameworks.graphics
{
   import flash.display.Graphics;
   
   public class GraphicsKit
   {
      
      private var target:Graphics;
      
      private var brush:IBrush;
      
      public function GraphicsKit(param1:Graphics)
      {
         super();
         this.target = param1;
      }
      
      private function setTarget(param1:Graphics) : void
      {
         this.target = param1;
      }
      
      private function dispose() : void
      {
         this.target = null;
      }
      
      private function startPen(param1:IPen) : void
      {
         param1.penSetTo(this.target);
      }
      
      private function endPen() : void
      {
         this.target.lineStyle();
         this.target.moveTo(0,0);
      }
      
      private function startBrush(param1:IBrush) : void
      {
         this.brush = param1;
         param1.beginFill(this.target);
      }
      
      private function endBrush() : void
      {
         this.brush.endFill(this.target);
         this.target.moveTo(0,0);
      }
      
      public function clear() : void
      {
         if(this.target != null)
         {
            this.target.clear();
         }
      }
      
      public function drawLine(param1:IPen, param2:Number, param3:Number, param4:Number, param5:Number) : void
      {
         this.startPen(param1);
         this.line(param2,param3,param4,param5);
      }
      
      public function line(param1:Number, param2:Number, param3:Number, param4:Number) : void
      {
         this.target.moveTo(param1,param2);
         this.target.lineTo(param3,param4);
      }
      
      public function moveTo(param1:Number, param2:Number) : void
      {
         this.target.moveTo(param1,param2);
      }
      
      public function rectangle(param1:Number, param2:Number, param3:Number, param4:Number) : void
      {
         this.target.drawRect(param1,param2,param3,param4);
      }
      
      public function ellipse(param1:Number, param2:Number, param3:Number, param4:Number) : void
      {
         this.target.drawEllipse(param1,param2,param3,param4);
      }
      
      public function beginDraw(param1:IPen) : void
      {
         this.startPen(param1);
      }
      
      public function endDraw() : void
      {
         this.endPen();
         this.target.moveTo(0,0);
      }
      
      public function curveTo(param1:Number, param2:Number, param3:Number, param4:Number) : void
      {
         this.target.curveTo(param1,param2,param3,param4);
      }
      
      public function lineTo(param1:Number, param2:Number) : void
      {
         this.target.lineTo(param1,param2);
      }
      
      public function drawRectangle(param1:IPen, param2:Number, param3:Number, param4:Number, param5:Number) : void
      {
         this.startPen(param1);
         this.rectangle(param2,param3,param4,param5);
         this.endPen();
      }
      
      public function fillRectangle(param1:IBrush, param2:Number, param3:Number, param4:Number, param5:Number) : void
      {
         this.startBrush(param1);
         this.rectangle(param2,param3,param4,param5);
         this.endBrush();
      }
      
      public function circle(param1:Number, param2:Number, param3:Number) : void
      {
         this.target.drawCircle(param1,param2,param3);
      }
      
      public function drawCircle(param1:IPen, param2:Number, param3:Number, param4:Number) : void
      {
         this.startPen(param1);
         this.circle(param2,param3,param4);
         this.endPen();
      }
      
      public function fillCircle(param1:IBrush, param2:Number, param3:Number, param4:Number) : void
      {
         this.startBrush(param1);
         this.circle(param2,param3,param4);
         this.endBrush();
      }
      
      public function fillEllipse(param1:IBrush, param2:Number, param3:Number, param4:Number, param5:Number) : void
      {
         this.startBrush(param1);
         this.ellipse(param2,param3,param4,param5);
         this.endBrush();
      }
      
      public function fillRoundRectRingWithThickness(param1:IBrush, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number, param8:Number = -1) : void
      {
         this.startBrush(param1);
         this.roundRect(param2,param3,param4,param5,param6);
         if(param8 == -1)
         {
            param8 = param6 - param7;
         }
         this.roundRect(param2 + param7,param3 + param7,param4 - param7 * 2,param5 - param7 * 2,param8);
         this.endBrush();
      }
      
      public function roundRect(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number = -1, param7:Number = -1, param8:Number = -1) : void
      {
         var _loc9_:Number = param5;
         if(param6 == -1)
         {
            param6 = param5;
         }
         if(param7 == -1)
         {
            param7 = param5;
         }
         if(param8 == -1)
         {
            param8 = param5;
         }
         this.target.drawRoundRectComplex(param1,param2,param3,param4,param5,param6,param7,param8);
      }
      
      public function drawRoundRect(param1:IPen, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number = -1, param8:Number = -1, param9:Number = -1) : void
      {
         this.startPen(param1);
         this.roundRect(param2,param3,param4,param5,param6,param7,param8,param9);
         this.endPen();
      }
      
      public function fillRoundRect(param1:IBrush, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number = -1, param8:Number = -1, param9:Number = -1) : void
      {
         this.startBrush(param1);
         this.roundRect(param2,param3,param4,param5,param6,param7,param8,param9);
         this.endBrush();
      }
   }
}

