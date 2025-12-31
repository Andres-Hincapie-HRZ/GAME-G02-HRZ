package com.star.frameworks.graphics
{
   import flash.display.Graphics;
   
   public class PenKit implements IPen
   {
      
      private var m_thickness:uint = 0;
      
      private var m_color:ColorKit = null;
      
      private var m_pixelHinting:Boolean = false;
      
      private var m_scaleMode:String = null;
      
      private var m_caps:String = null;
      
      private var m_joints:String = null;
      
      private var m_miterLimit:Number = 0;
      
      public function PenKit(param1:ColorKit, param2:uint = 1, param3:Boolean = false, param4:String = "normal", param5:String = null, param6:String = null, param7:Number = 3)
      {
         super();
         this.m_color = param1;
         this.m_thickness = param2;
         this.m_pixelHinting = param3;
         this.m_scaleMode = param4;
         this.m_caps = param5;
         this.m_joints = param6;
         this.m_miterLimit = param7;
      }
      
      public function getColor() : ColorKit
      {
         return this.m_color;
      }
      
      public function setColor(param1:ColorKit) : void
      {
         this.m_color = param1;
      }
      
      public function getThickness() : uint
      {
         return this.m_thickness;
      }
      
      public function setThickness(param1:uint) : void
      {
         this.m_thickness = param1;
      }
      
      public function getPixelHinting() : Boolean
      {
         return this.m_pixelHinting;
      }
      
      public function setPixelHinting(param1:Boolean) : void
      {
         this.m_pixelHinting = param1;
      }
      
      public function getScaleMode() : String
      {
         return this.m_scaleMode;
      }
      
      public function setScaleMode(param1:String) : void
      {
         this.m_scaleMode = param1;
      }
      
      public function getCaps() : String
      {
         return this.m_caps;
      }
      
      public function setCaps(param1:String) : void
      {
         this.m_caps = param1;
      }
      
      public function getJoints() : String
      {
         return this.m_joints;
      }
      
      public function setJoints(param1:String) : void
      {
         this.m_joints = param1;
      }
      
      public function getMiterLimit() : Number
      {
         return this.m_miterLimit;
      }
      
      public function setMiterLimit(param1:Number) : void
      {
         this.m_miterLimit = param1;
      }
      
      public function penSetTo(param1:Graphics) : void
      {
         param1.lineStyle(this.m_thickness,this.m_color.getRGB(),this.m_color.getAlpha(),this.m_pixelHinting,this.m_scaleMode,this.m_caps,this.m_joints,this.m_miterLimit);
      }
   }
}

