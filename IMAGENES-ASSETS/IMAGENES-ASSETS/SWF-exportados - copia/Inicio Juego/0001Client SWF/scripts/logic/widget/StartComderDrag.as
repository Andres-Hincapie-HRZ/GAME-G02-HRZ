package logic.widget
{
   import com.star.frameworks.utils.CDraggerUtil;
   import com.star.frameworks.utils.HashSet;
   import flash.display.DisplayObjectContainer;
   import flash.events.MouseEvent;
   import logic.game.GameSetting;
   
   public class StartComderDrag extends CDraggerUtil
   {
      
      private static var instance:StartComderDrag;
      
      private var comderList:HashSet;
      
      public function StartComderDrag()
      {
         super();
         super._currentModel = 0;
         _preDragPiexlX = 0;
         _preDragPiexlY = 0;
         this.comderList = new HashSet();
         if(instance != null)
         {
            throw Error("SingleTon");
         }
      }
      
      public static function getInstance() : StartComderDrag
      {
         if(instance == null)
         {
            instance = new StartComderDrag();
         }
         return instance;
      }
      
      override public function Register(param1:DisplayObjectContainer) : void
      {
         _target = param1;
         if(!_target.hasEventListener(MouseEvent.MOUSE_DOWN))
         {
            _target.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag,false,0,true);
         }
      }
      
      override public function onStartDrag(param1:MouseEvent) : void
      {
         if(param1.target.name == "btn_enter")
         {
            return;
         }
         _isDragging = true;
         _moving = false;
         _startDragX = param1.stageX;
         _startDragY = param1.stageY;
         _dragX = _target.x;
         _dragY = _target.y;
         _preDragPiexlX = _dragPiexlX;
         _preDragPiexlY = _dragPiexlY;
         if(_target.parent)
         {
            _target.parent.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag,false,0,true);
         }
         if(_target.parent)
         {
            _target.parent.addEventListener(MouseEvent.MOUSE_MOVE,this.onDragging,false,0,true);
         }
      }
      
      override public function onDragging(param1:MouseEvent) : void
      {
         _moving = true;
         if(_isDragging && _moving)
         {
            _dragPiexlX = param1.stageX - _startDragX;
            _dragPiexlY = param1.stageY - _startDragY;
            onMove(_target,param1.stageX - _startDragX + _dragX,param1.stageY - _startDragY + _dragY);
         }
      }
      
      override public function onStopDrag(param1:MouseEvent) : void
      {
         _moving = false;
         var _loc2_:int = Math.round(_dragPiexlY / GameSetting.MAP_GRID_HEIGHT);
         var _loc3_:int = Math.round(_dragPiexlX / GameSetting.MAP_GRID_WIDTH);
         if(_target.parent)
         {
            _target.parent.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         }
         if(_target.parent)
         {
            _target.parent.removeEventListener(MouseEvent.MOUSE_MOVE,this.onDragging);
         }
      }
   }
}

