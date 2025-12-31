package logic.widget.com
{
   import com.star.frameworks.events.ActionEvent;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import logic.entry.HButton;
   import logic.manager.GameInterActiveManager;
   import logic.ui.ChatCustomChannelPopUp;
   
   public class ComCheckBox
   {
      
      private var _isSelect:Boolean;
      
      private var _value:Object;
      
      private var _instance:HButton;
      
      public function ComCheckBox(param1:MovieClip, param2:Object = null, param3:Boolean = false)
      {
         super();
         this._isSelect = param3;
         this._value = param2;
         this._instance = new HButton(param1);
         GameInterActiveManager.InstallInterActiveEvent(this._instance.m_movie,ActionEvent.ACTION_CLICK,this.onChange);
      }
      
      public function get IsSelect() : Boolean
      {
         return this._isSelect;
      }
      
      public function get Value() : Object
      {
         return this._value;
      }
      
      public function set Value(param1:Object) : void
      {
         this._value = param1;
      }
      
      public function Release() : void
      {
      }
      
      public function setCheckBoxStateOn() : void
      {
         this._isSelect = true;
         this._instance.setSelect(this._isSelect);
      }
      
      public function setCheckBoxStateOff() : void
      {
         this._isSelect = false;
         this._instance.setSelect(this._isSelect);
      }
      
      private function onChange(param1:MouseEvent) : void
      {
         if(this._isSelect)
         {
            this._instance.setSelect(false);
            ChatCustomChannelPopUp.updateChannel(this.Value,1);
         }
         else
         {
            this._instance.setSelect(true);
            ChatCustomChannelPopUp.updateChannel(this.Value);
         }
         this._isSelect = !this._isSelect;
      }
   }
}

