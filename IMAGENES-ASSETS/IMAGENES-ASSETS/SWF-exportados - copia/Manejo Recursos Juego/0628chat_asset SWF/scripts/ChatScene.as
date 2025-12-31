package
{
   import flash.accessibility.*;
   import flash.display.*;
   import flash.errors.*;
   import flash.events.*;
   import flash.filters.*;
   import flash.geom.*;
   import flash.media.*;
   import flash.net.*;
   import flash.system.*;
   import flash.text.*;
   import flash.ui.*;
   import flash.utils.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol220")]
   public dynamic class ChatScene extends MovieClip
   {
      
      public var btn_decrease:MovieClip;
      
      public var tf_choose:TextField;
      
      public var btn_increase:MovieClip;
      
      public var tf_inputtxt:TextField;
      
      public var btn_enter:MovieClip;
      
      public var btn_up:MovieClip;
      
      public function ChatScene()
      {
         super();
         addFrameScript(0,frame1);
      }
      
      internal function frame1() : *
      {
         stop();
      }
   }
}

