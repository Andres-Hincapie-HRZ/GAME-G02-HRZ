package logic.widget
{
   import com.star.frameworks.utils.CDraggerUtil;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import logic.action.ConstructionAction;
   import logic.action.StarSurfaceAction;
   import logic.entry.ConstructionState;
   import logic.game.GameKernel;
   import logic.game.GameMouseZoneManager;
   import logic.game.GameSetting;
   import logic.ui.ChatUI;
   import logic.ui.GemcheckPopUI;
   import logic.ui.tip.CustomTip;
   
   public class StarSurFaceDragger extends CDraggerUtil
   {
      
      private static var instance:StarSurFaceDragger;
      
      public function StarSurFaceDragger()
      {
         super();
         super._currentModel = 0;
         _preDragPiexlX = 0;
         _preDragPiexlY = 0;
         if(instance != null)
         {
            throw Error("SingleTon");
         }
      }
      
      public static function getInstance() : StarSurFaceDragger
      {
         if(instance == null)
         {
            instance = new StarSurFaceDragger();
         }
         return instance;
      }
      
      override public function onStartDrag(param1:MouseEvent) : void
      {
         GameMouseZoneManager.setSubMenuState();
         if(ConstructionOperationWidget.getInstance().Operation)
         {
            ConstructionOperationWidget.getInstance().Hide();
         }
         CustomTip.GetInstance().Hide();
         if(ConstructionAction.currentTarget && !StarSurfaceAction.getInstance().IsBuildDrag && ConstructionAction.currentTarget.State != ConstructionState.STATE_MIRGRATE)
         {
            ConstructionAction.currentTarget.removeEquimentSenseZone();
         }
         ChatUI.getInstance().setSpecialTipState(false);
         GameKernel.renderManager.getUI().removeComponent(GemcheckPopUI.getInstance()._mc);
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
      
      override public function onDragging(param1:MouseEvent) : void
      {
         _moving = true;
         StarSurfaceAction.getInstance().Lock();
         if(_isDragging && _moving)
         {
            _dragPiexlX = param1.stageX - _startDragX;
            _dragPiexlY = param1.stageY - _startDragY;
            this.onMove(_target,param1.stageX - _startDragX + _dragX,param1.stageY - _startDragY + _dragY);
         }
      }
      
      override public function onStopDrag(param1:MouseEvent) : void
      {
         _moving = false;
         var _loc2_:int = Math.round(_dragPiexlY / GameSetting.MAP_GRID_HEIGHT);
         var _loc3_:int = Math.round(_dragPiexlX / GameSetting.MAP_GRID_WIDTH);
         StarSurfaceAction.getInstance().unLock();
         _target.stage.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         _target.stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.onDragging);
      }
      
      override public function onMove(param1:DisplayObject, param2:int, param3:int) : void
      {
         if(GameKernel.platform != 2)
         {
            if(param2 >= 0 + GameKernel.fullRect.x)
            {
               param2 = 0 + GameKernel.fullRect.x;
            }
            else if(param2 <= -1230 - GameKernel.fullRect.x)
            {
               param2 = -1230 - GameKernel.fullRect.x;
            }
         }
         else if(param2 >= 0 + GameKernel.fullRect.x)
         {
            param2 = 0 + GameKernel.fullRect.x;
         }
         else if(param2 <= -970 - GameKernel.fullRect.x)
         {
            param2 = -970 - GameKernel.fullRect.x;
         }
         if(param3 >= -200 + GameKernel.fullRect.y)
         {
            param3 = -200 + GameKernel.fullRect.y;
         }
         else if(param3 <= -990 - GameKernel.fullRect.y)
         {
            param3 = -990 - GameKernel.fullRect.y;
         }
         param1.x = param2;
         param1.y = param3;
      }
   }
}

