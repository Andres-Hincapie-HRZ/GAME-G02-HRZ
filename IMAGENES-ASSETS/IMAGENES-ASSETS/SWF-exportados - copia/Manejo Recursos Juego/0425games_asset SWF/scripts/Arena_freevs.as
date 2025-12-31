package
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol501")]
   public dynamic class Arena_freevs extends MovieClip
   {
      
      public var mc_0:MovieClip;
      
      public var mc_1:MovieClip;
      
      public var txt_name0:TextField;
      
      public var txt_name1:TextField;
      
      public var txt_num0:TextField;
      
      public var txt_num1:TextField;
      
      public var mc_lock:MovieClip;
      
      public function Arena_freevs()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      internal function frame1() : *
      {
         stop();
      }
   }
}

