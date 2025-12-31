package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol3017")]
   public dynamic class galaxy_battle extends MovieClip
   {
      
      public var mc_self:MovieClip;
      
      public var mc_other:MovieClip;
      
      public function galaxy_battle()
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

