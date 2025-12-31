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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol413")]
   public dynamic class LuckyScene extends MovieClip
   {
      
      public var btn_left:MovieClip;
      
      public var btn_first:MovieClip;
      
      public var btn_last:MovieClip;
      
      public var mc_li0:MovieClip;
      
      public var mc_li1:MovieClip;
      
      public var mc_li2:MovieClip;
      
      public var mc_li3:MovieClip;
      
      public var mc_li4:MovieClip;
      
      public var txt_tf0:TextField;
      
      public var txt_tf1:TextField;
      
      public var txt_tf2:TextField;
      
      public var btn_prev:MovieClip;
      
      public var txt_input:TextField;
      
      public var tf_page:TextField;
      
      public var tf_selectednum:TextField;
      
      public var txt_time:TextField;
      
      public var btn_help:MovieClip;
      
      public var tf_notice:TextArea;
      
      public var mc_li5:MovieClip;
      
      public var mc_help:MovieClip;
      
      public var btn_addfleet:MovieClip;
      
      public var btn_close:MovieClip;
      
      public var mc_list0:MovieClip;
      
      public var mc_list1:MovieClip;
      
      public var btn_search:MovieClip;
      
      public var btn_next:MovieClip;
      
      public var btn_right:MovieClip;
      
      public function LuckyScene()
      {
         super();
         this.__setProp_tf_notice_LuckyScene_();
      }
      
      internal function __setProp_tf_notice_LuckyScene_() : *
      {
         try
         {
            this.tf_notice["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.tf_notice.condenseWhite = true;
         this.tf_notice.editable = true;
         this.tf_notice.enabled = true;
         this.tf_notice.horizontalScrollPolicy = "off";
         this.tf_notice.htmlText = "";
         this.tf_notice.maxChars = 0;
         this.tf_notice.restrict = "";
         this.tf_notice.text = "";
         this.tf_notice.verticalScrollPolicy = "auto";
         this.tf_notice.visible = true;
         this.tf_notice.wordWrap = true;
         try
         {
            this.tf_notice["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

