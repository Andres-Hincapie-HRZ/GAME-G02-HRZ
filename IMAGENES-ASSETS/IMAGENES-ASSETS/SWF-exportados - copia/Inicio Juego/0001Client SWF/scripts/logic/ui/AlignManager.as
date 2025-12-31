package logic.ui
{
   import com.star.frameworks.utils.HashSet;
   import flash.display.DisplayObject;
   import flash.display.Stage;
   import flash.events.Event;
   import logic.game.GameKernel;
   import logic.game.GameSetting;
   
   public class AlignManager
   {
      
      private static var _instance:AlignManager;
      
      private var AlignList:HashSet;
      
      private var _Stage:Stage;
      
      private var HasAddListener:Boolean = false;
      
      public function AlignManager()
      {
         super();
         this.AlignList = new HashSet();
      }
      
      public static function GetInstance() : AlignManager
      {
         if(_instance == null)
         {
            _instance = new AlignManager();
         }
         return _instance;
      }
      
      public function SetAlign(param1:DisplayObject, param2:String) : void
      {
         var _loc3_:Object = new Object();
         _loc3_.Align = param2;
         _loc3_.StageWidth = GameSetting.GAME_STAGE_WIDTH;
         this.AlignList.Put(param1,_loc3_);
         if(param1.stage)
         {
            this.AddResizeListener(param1);
         }
         else
         {
            param1.addEventListener(Event.ADDED_TO_STAGE,this.OnAddToStage);
         }
         this.ResetLocation(param1);
      }
      
      public function ResetRightAlignWidth(param1:DisplayObject) : void
      {
         var _loc2_:Object = null;
         if(this.AlignList.ContainsKey(param1) && Boolean(param1.stage))
         {
            _loc2_ = this.AlignList.GetValue(param1);
            _loc2_.RighWidth = GameKernel.fullRect.x + param1.stage.stageWidth - param1.x;
         }
         this.ResetLocation(param1);
      }
      
      private function AddResizeListener(param1:DisplayObject) : void
      {
         if(this.HasAddListener == false)
         {
            this._Stage = param1.stage;
            param1.stage.addEventListener(Event.RESIZE,this.OnResize);
            this.HasAddListener = true;
         }
      }
      
      private function OnAddToStage(param1:Event) : void
      {
         var _loc3_:Object = null;
         var _loc2_:DisplayObject = param1.target as DisplayObject;
         if(this.AlignList.ContainsKey(_loc2_))
         {
            this.AddResizeListener(_loc2_);
            _loc3_ = this.AlignList.GetValue(_loc2_);
            if(_loc3_.StageWidth != _loc2_.stage.stageWidth)
            {
               this.ResetLocation(_loc2_);
            }
         }
      }
      
      private function OnResize(param1:Event) : void
      {
         var _loc2_:DisplayObject = null;
         var _loc3_:int = 0;
         while(_loc3_ < this.AlignList.Length())
         {
            _loc2_ = this.AlignList.Keys()[_loc3_];
            this.ResetLocation(_loc2_);
            _loc3_++;
         }
      }
      
      private function ResetLocation(param1:DisplayObject) : void
      {
         if(this._Stage == null)
         {
            return;
         }
         var _loc2_:Object = this.AlignList.GetValue(param1);
         if(_loc2_.Align == "left")
         {
            param1.x -= (this._Stage.stageWidth - _loc2_.StageWidth) / 2;
         }
         else if(_loc2_.Align == "right")
         {
            param1.x += (this._Stage.stageWidth - _loc2_.StageWidth) / 2;
         }
         else
         {
            param1.x -= (this._Stage.stageWidth - _loc2_.StageWidth) / 2;
            param1.width = this._Stage.stageWidth;
            param1.height = this._Stage.stageHeight;
         }
         _loc2_.StageWidth = this._Stage.stageWidth;
      }
   }
}

