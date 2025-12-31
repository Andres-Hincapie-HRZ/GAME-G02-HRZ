package
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol6346")]
   public dynamic class BuildlistMc extends MovieClip
   {
      
      public var mc_base:MovieClip;
      
      public var tf_page:TextField;
      
      public var tf_name:TextField;
      
      public function BuildlistMc()
      {
         super();
         addFrameScript(0,this.frame1,1,this.frame2);
      }
      
      internal function frame2() : *
      {
         stop();
      }
      
      internal function frame1() : *
      {
         stop();
      }
   }
}

