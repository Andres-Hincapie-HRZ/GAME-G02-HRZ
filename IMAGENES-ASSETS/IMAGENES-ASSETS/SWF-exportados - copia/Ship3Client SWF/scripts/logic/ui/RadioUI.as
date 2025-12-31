package logic.ui
{
   import com.star.frameworks.display.Container;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import logic.entry.HButton;
   import logic.entry.MObject;
   
   public class RadioUI
   {
      
      private static var instance:RadioUI;
      
      private var tfNum:TextField;
      
      private var _MaxNum:int;
      
      private var ReturnCallback:Function;
      
      private var _mc:MObject;
      
      private var _Parent:MovieClip;
      
      private var ParentLock:Container;
      
      private var tf_title:TextField;
      
      public function RadioUI()
      {
         super();
         this._mc = new MObject("HireScenePopup",0,0);
         this.initMcElement();
      }
      
      public static function getInstance() : RadioUI
      {
         if(instance == null)
         {
            instance = new RadioUI();
         }
         return instance;
      }
      
      private function initMcElement() : void
      {
         var _loc1_:MovieClip = null;
         var _loc2_:HButton = null;
         _loc1_ = this._mc.getMC().mc_ensure as MovieClip;
         _loc2_ = new HButton(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.CandelClick);
         _loc1_ = this._mc.getMC().getChildByName("btn_cancel") as MovieClip;
         _loc2_ = new HButton(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.CandelClick);
      }
      
      private function tfNumChange(param1:Event) : void
      {
         if(this.tfNum.text == "")
         {
            return;
         }
         if(int(this.tfNum.text) > this._MaxNum)
         {
            this.tfNum.text = this._MaxNum.toString();
         }
      }
      
      private function btn_ensureClick(param1:Event) : void
      {
         if(this.tfNum.text == "" || int(this.tfNum.text) <= 0)
         {
            return;
         }
         var _loc2_:int = int(this.tfNum.text);
         if(_loc2_ > this._MaxNum)
         {
            return;
         }
         this._Parent.removeChild(this._mc);
         this.ReturnCallback(_loc2_);
      }
      
      private function CandelClick(param1:Event) : void
      {
         this._Parent.removeChild(this._mc);
      }
      
      public function Show(param1:MovieClip, param2:String = null) : void
      {
         if(param2 != null)
         {
            TextField(this._mc.getMC().tf_content).text = param2;
         }
         this._Parent = param1;
         this._mc.x = 0;
         this._mc.y = 0;
         param1.addChild(this._mc);
      }
   }
}

