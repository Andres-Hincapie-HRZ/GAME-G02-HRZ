package logic.widget
{
   import com.star.frameworks.utils.CDraggerUtil;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import logic.action.ConstructionAction;
   import logic.game.GameKernel;
   import logic.game.GameMouseZoneManager;
   import logic.game.GameSetting;
   import logic.ui.ChatUI;
   import logic.ui.GemcheckPopUI;
   import logic.ui.tip.CustomTip;
   
   public class OutSideGalaxiasDragger extends CDraggerUtil
   {
      
      private static var instance:OutSideGalaxiasDragger;
      
      public function OutSideGalaxiasDragger()
      {
         super();
         super._currentModel = 1;
         _preDragPiexlX = 0;
         _preDragPiexlY = 0;
         if(instance != null)
         {
            throw Error("SingleTon");
         }
      }
      
      public static function getInstance() : OutSideGalaxiasDragger
      {
         if(instance == null)
         {
            instance = new OutSideGalaxiasDragger();
         }
         return instance;
      }
      
      override public function onStartDrag(param1:MouseEvent) : void
      {
         GameMouseZoneManager.setSubMenuState();
         if(ConstructionAction.currentTarget)
         {
            ConstructionAction.currentTarget.HideEquimentInfluence();
            ConstructionAction.currentTarget.removeEquimentSenseZone();
         }
         CustomTip.GetInstance().Hide();
         ChatUI.getInstance().setSpecialTipState(false);
         GameKernel.renderManager.getUI().removeComponent(GemcheckPopUI.getInstance()._mc);
         if(ConstructionOperationWidget.getInstance().Operation)
         {
            ConstructionOperationWidget.getInstance().Hide();
         }
         _isDragging = true;
         _moving = false;
         _startDragX = param1.stageX;
         _startDragY = param1.stageY;
         _dragX = _target.x;
         _dragY = _target.y;
         _preDragPiexlX = _dragPiexlX;
         _preDragPiexlY = _dragPiexlY;
         _target.stage.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag,false,0,true);
         _target.stage.addEventListener(MouseEvent.MOUSE_MOVE,this.onDragging,false,0,true);
      }
      
      override public function onStopDrag(param1:MouseEvent) : void
      {
         _moving = false;
         var _loc2_:int = Math.round(_dragPiexlY / GameSetting.MAP_OUTSIDE_GRID_HEIGHT);
         var _loc3_:int = Math.round(_dragPiexlX / GameSetting.MAP_OUTSIDE_GRID_WIDTH);
         if(_target.stage)
         {
            _target.stage.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
            _target.stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.onDragging);
         }
      }
      
      override public function onDragging(param1:MouseEvent) : void
      {
         _moving = true;
         if(_isDragging && _moving)
         {
            _dragPiexlX = param1.stageX - _startDragX;
            _dragPiexlY = param1.stageY - _startDragY;
            this.onMove(_target,param1.stageX - _startDragX + _dragX,param1.stageY - _startDragY + _dragY);
         }
      }
      
      override public function onMove(param1:DisplayObject, param2:int, param3:int) : void
      {
         if(param2 >= 75 + GameKernel.fullRect.x)
         {
            param2 = 75 + GameKernel.fullRect.x;
         }
         else if(param2 <= -1700 - GameKernel.fullRect.x)
         {
            param2 = -1700 - GameKernel.fullRect.x;
         }
         if(param3 <= -900 + GameKernel.fullRect.y)
         {
            param3 = -900 + GameKernel.fullRect.y;
         }
         else if(param3 >= 50 - GameKernel.fullRect.y)
         {
            param3 = 50 - GameKernel.fullRect.y;
         }
         param1.y = param3;
         param1.x = param2;
      }
   }
}

