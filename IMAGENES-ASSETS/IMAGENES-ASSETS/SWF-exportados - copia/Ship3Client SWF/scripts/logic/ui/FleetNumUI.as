package logic.ui
{
   import com.star.frameworks.display.Container;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import logic.entry.HButton;
   import logic.entry.MObject;
   import logic.game.GameSetting;
   
   public class FleetNumUI
   {
      
      private static var instance:FleetNumUI;
      
      private var tfNum:TextField;
      
      private var xtfNum:XTextField;
      
      private var _MaxNum:int;
      
      private var _ReMaxNum:int;
      
      private var ReturnCallback:Function;
      
      private var _mc:MObject;
      
      private var _Parent:MovieClip;
      
      private var ParentLock:Container;
      
      private var tf_title:TextField;
      
      private var LastNum:int;
      
      private var btn_ensure:HButton;
      
      public function FleetNumUI()
      {
         super();
         this._mc = new MObject("Addfriendpopup",0,0);
         this.initMcElement();
         this.ParentLock = new Container("SceneLock");
         this.ParentLock.mouseEnabled = true;
         this.ParentLock.mouseChildren = false;
         this.ParentLock.fillRectangleWithoutBorder(0,0,100,100,0,0);
      }
      
      public static function getInstance() : FleetNumUI
      {
         if(instance == null)
         {
            instance = new FleetNumUI();
         }
         return instance;
      }
      
      private function initMcElement() : void
      {
         var _loc1_:MovieClip = null;
         var _loc2_:HButton = null;
         MovieClip(this._mc.getMC().getChildByName("btn_front") as MovieClip).visible = false;
         MovieClip(this._mc.getMC().getChildByName("btn_next") as MovieClip).visible = false;
         this.tf_title = this._mc.getMC().getChildByName("tf_title") as TextField;
         this.tfNum = this._mc.getMC().getChildByName("tf_id") as TextField;
         this.tfNum.addEventListener(Event.CHANGE,this.tfNumChange);
         this.tfNum.restrict = "0-9";
         _loc1_ = this._mc.getMC().getChildByName("btn_ensure") as MovieClip;
         _loc1_.stop();
         this.btn_ensure = new HButton(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.btn_ensureClick);
         _loc1_ = this._mc.getMC().getChildByName("btn_cancel") as MovieClip;
         _loc2_ = new HButton(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.CandelClick);
         _loc1_ = this._mc.getMC().getChildByName("btn_front") as MovieClip;
         _loc2_ = new HButton(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.btn_frontClick);
         _loc1_ = this._mc.getMC().getChildByName("btn_next") as MovieClip;
         _loc2_ = new HButton(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.btn_nextClick);
      }
      
      private function btn_nextClick(param1:MouseEvent) : void
      {
         this.tfNum.text = this._MaxNum.toString();
      }
      
      private function btn_frontClick(param1:MouseEvent) : void
      {
         this.tfNum.text = "1";
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
         this.LastNum = _loc2_;
         this._Parent.removeChild(this._mc);
         this._Parent.removeChild(this.ParentLock);
         this.ReturnCallback(_loc2_);
      }
      
      private function CandelClick(param1:Event) : void
      {
         this._Parent.removeChild(this._mc);
         this._Parent.removeChild(this.ParentLock);
      }
      
      public function Show(param1:MovieClip, param2:int, param3:Function, param4:String = null, param5:Boolean = false, param6:int = -1) : void
      {
         if(param2 < 0)
         {
            param2 = 268435455;
         }
         if(param4 != null)
         {
            this.tf_title.text = param4;
         }
         this.ParentLock.x = 0 - param1.width / 2;
         this.ParentLock.y = 0 - param1.height / 2;
         this.ParentLock.width = GameSetting.GAME_STAGE_WIDTH;
         this.ParentLock.height = GameSetting.GAME_STAGE_HEIGHT;
         param1.addChild(this.ParentLock);
         this._MaxNum = param2;
         if(param6 > 0)
         {
            this.tfNum.text = param6.toString();
         }
         else if(this.LastNum <= 0 || this.LastNum > param2)
         {
            this.tfNum.text = this._MaxNum.toString();
         }
         this.ReturnCallback = param3;
         this._Parent = param1;
         this._mc.x = 0;
         this._mc.y = 0;
         param1.addChild(this._mc);
         MovieClip(this._mc.getMC().getChildByName("btn_front") as MovieClip).visible = param5;
         MovieClip(this._mc.getMC().getChildByName("btn_next") as MovieClip).visible = param5;
      }
   }
}

