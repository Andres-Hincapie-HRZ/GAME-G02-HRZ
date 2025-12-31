package com.star.frameworks.ui
{
   import flash.display.MovieClip;
   
   public interface ICUIMovieClip extends ICUIComponent
   {
      
      function play() : void;
      
      function stop() : void;
      
      function restart() : void;
      
      function getMC() : MovieClip;
   }
}

