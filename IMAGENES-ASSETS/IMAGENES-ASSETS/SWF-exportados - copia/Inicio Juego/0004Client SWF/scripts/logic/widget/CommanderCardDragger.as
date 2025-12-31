package logic.widget
{
   import com.star.frameworks.utils.CDraggerUtil;
   import flash.display.DisplayObjectContainer;
   import flash.events.MouseEvent;
   
   public class CommanderCardDragger extends CDraggerUtil
   {
      
      private static var m_Instance:CommanderCardDragger;
      
      public function CommanderCardDragger()
      {
         super();
         _preDragPiexlX = 0;
         _preDragPiexlY = 0;
         if(m_Instance != null)
         {
            throw Error("SingleTon");
         }
      }
      
      public static function GetInstance() : CommanderCardDragger
      {
         if(m_Instance == null)
         {
            m_Instance = new CommanderCardDragger();
         }
         return m_Instance;
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
         _isDragging = true;
         _moving = false;
         _startDragX = param1.stageX;
         _startDragY = param1.stageY;
         _dragX = _target.x;
         _dragY = _target.y;
         _preDragPiexlX = _dragPiexlX;
         _preDragPiexlY = _dragPiexlY;
         if(_target.stage)
         {
            _target.stage.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag,false,0,true);
         }
         if(_target.stage)
         {
            _target.stage.addEventListener(MouseEvent.MOUSE_MOVE,this.onDragging,false,0,true);
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
         if(_target.stage)
         {
            _target.stage.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         }
         if(_target.stage)
         {
            _target.stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.onDragging);
         }
      }
   }
}

