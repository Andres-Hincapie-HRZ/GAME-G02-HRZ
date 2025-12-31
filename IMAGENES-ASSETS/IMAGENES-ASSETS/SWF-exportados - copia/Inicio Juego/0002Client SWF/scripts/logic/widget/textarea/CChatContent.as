package logic.widget.textarea
{
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFieldType;
   import flash.text.TextFormat;
   import logic.entry.GamePlayer;
   
   public class CChatContent
   {
      
      private var mParent:*;
      
      private var m_text:TextField;
      
      public function CChatContent(param1:* = null)
      {
         super();
         this.mParent = param1;
         this.init();
      }
      
      public function get TextArea() : TextField
      {
         return this.m_text;
      }
      
      private function init() : void
      {
         var _loc1_:TextFormat = null;
         this.m_text = new TextField();
         this.m_text.multiline = true;
         this.m_text.wordWrap = true;
         this.m_text.textColor = 16777215;
         this.m_text.type = TextFieldType.DYNAMIC;
         this.m_text.useRichTextClipboard = true;
         this.m_text.selectable = true;
         if(GamePlayer.getInstance().language == 10)
         {
            _loc1_ = this.m_text.getTextFormat();
            _loc1_.align = TextFieldAutoSize.RIGHT;
            this.m_text.setTextFormat(_loc1_);
            this.m_text.defaultTextFormat = _loc1_;
         }
      }
      
      public function setUnSelectedState() : void
      {
         this.m_text.alpha = 0.1;
      }
      
      public function setXYWH(param1:int = 0, param2:int = 0, param3:int = 0, param4:int = 0) : void
      {
         this.m_text.x = param1;
         this.m_text.y = param2;
         this.m_text.width = param3;
         this.m_text.height = param4;
      }
   }
}

