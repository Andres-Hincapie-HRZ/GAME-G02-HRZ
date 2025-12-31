package
{
   import adobe.utils.*;
   import fl.controls.TextArea;
   import flash.accessibility.*;
   import flash.desktop.*;
   import flash.display.*;
   import flash.errors.*;
   import flash.events.*;
   import flash.external.*;
   import flash.filters.*;
   import flash.geom.*;
   import flash.media.*;
   import flash.net.*;
   import flash.printing.*;
   import flash.profiler.*;
   import flash.sampler.*;
   import flash.system.*;
   import flash.text.*;
   import flash.text.engine.*;
   import flash.ui.*;
   import flash.utils.*;
   import flash.xml.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2635")]
   public dynamic class WriteletterMc extends MovieClip
   {
      
      public var mc_input:TextArea;
      
      public var tf_addressee:TextField;
      
      public var btn_clear:MovieClip;
      
      public var tf_title:TextField;
      
      public var btn_back:MovieClip;
      
      public var btn_send:MovieClip;
      
      public function WriteletterMc()
      {
         super();
         this.__setProp_mc_input_WriteletterMc_();
      }
      
      internal function __setProp_mc_input_WriteletterMc_() : *
      {
         try
         {
            this.mc_input["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.mc_input.condenseWhite = true;
         this.mc_input.editable = true;
         this.mc_input.enabled = true;
         this.mc_input.horizontalScrollPolicy = "off";
         this.mc_input.htmlText = "";
         this.mc_input.maxChars = 0;
         this.mc_input.restrict = "";
         this.mc_input.text = "";
         this.mc_input.verticalScrollPolicy = "off";
         this.mc_input.visible = true;
         this.mc_input.wordWrap = false;
         try
         {
            this.mc_input["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

