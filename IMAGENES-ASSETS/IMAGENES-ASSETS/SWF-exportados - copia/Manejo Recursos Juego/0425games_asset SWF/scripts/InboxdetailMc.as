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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2735")]
   public dynamic class InboxdetailMc extends MovieClip
   {
      
      public var mc_textarea:TextArea;
      
      public var mc_proplist:MovieClip;
      
      public var tf_title:TextField;
      
      public var tf_addresser:TextField;
      
      public var btn_delete:MovieClip;
      
      public var btn_battlereport:MovieClip;
      
      public var btn_writeback:MovieClip;
      
      public var btn_close:MovieClip;
      
      public var tf_time:TextField;
      
      public var btn_allpick:MovieClip;
      
      public function InboxdetailMc()
      {
         super();
         this.__setProp_mc_textarea_InboxdetailMc_();
      }
      
      internal function __setProp_mc_textarea_InboxdetailMc_() : *
      {
         try
         {
            this.mc_textarea["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.mc_textarea.condenseWhite = false;
         this.mc_textarea.editable = false;
         this.mc_textarea.enabled = true;
         this.mc_textarea.horizontalScrollPolicy = "auto";
         this.mc_textarea.htmlText = "";
         this.mc_textarea.maxChars = 0;
         this.mc_textarea.restrict = "";
         this.mc_textarea.text = "";
         this.mc_textarea.verticalScrollPolicy = "auto";
         this.mc_textarea.visible = true;
         this.mc_textarea.wordWrap = true;
         try
         {
            this.mc_textarea["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

