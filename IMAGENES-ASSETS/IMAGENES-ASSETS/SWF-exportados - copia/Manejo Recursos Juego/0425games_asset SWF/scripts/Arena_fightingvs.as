package
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol520")]
   public dynamic class Arena_fightingvs extends MovieClip
   {
      
      public var mc_0:MovieClip;
      
      public var mc_1:MovieClip;
      
      public var txt_name0:TextField;
      
      public var txt_name1:TextField;
      
      public var txt_num0:TextField;
      
      public var txt_num1:TextField;
      
      public function Arena_fightingvs()
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

