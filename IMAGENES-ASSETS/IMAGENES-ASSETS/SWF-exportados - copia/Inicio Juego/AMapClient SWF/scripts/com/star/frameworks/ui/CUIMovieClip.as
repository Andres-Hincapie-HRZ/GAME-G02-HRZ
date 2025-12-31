package com.star.frameworks.ui
{
   import flash.display.MovieClip;
   import logic.entry.MObject;
   
   public class CUIMovieClip extends CUIComponent implements ICUIMovieClip
   {
      
      private var mc:MObject;
      
      public function CUIMovieClip(param1:CUIFormat = null)
      {
         super(param1);
      }
      
      override public function initComponent() : void
      {
         setType("CUIMovieClip");
         HasChild(true);
         setShow(getFormat().isShow);
         setXYWH(getFormat().rectangle);
         setVisible(getFormat().visible);
         setEnable(getFormat().enabled);
         setName(getFormat().name);
         this.mc = new MObject(getFormat().mcClass,0,0);
         setLocationXY(getX(),getY());
         getContainer().addChild(this.mc);
      }
      
      public function getMC() : MovieClip
      {
         if(this.mc)
         {
            return this.mc.getMC();
         }
         return null;
      }
      
      public function play() : void
      {
         if(this.mc)
         {
            this.mc.getMC().play();
         }
      }
      
      public function stop() : void
      {
         if(this.mc)
         {
            this.mc.getMC().stop();
         }
      }
      
      public function restart() : void
      {
         if(this.mc)
         {
            this.mc.getMC().gotoAndPlay(1);
         }
      }
   }
}

