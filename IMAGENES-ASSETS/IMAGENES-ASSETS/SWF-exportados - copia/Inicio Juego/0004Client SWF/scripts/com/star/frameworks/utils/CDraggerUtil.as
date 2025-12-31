package com.star.frameworks.utils
{
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.events.MouseEvent;
   import logic.action.StarSurfaceAction;
   import logic.entry.GameStageEnum;
   import logic.game.GameKernel;
   import logic.game.GameSetting;
   import logic.widget.ConstructionOperationWidget;
   
   public class CDraggerUtil
   {
      
      private static var instance:CDraggerUtil;
      
      protected var _currentModel:int;
      
      protected var _target:DisplayObjectContainer;
      
      protected var _isDragging:Boolean;
      
      protected var _moving:Boolean;
      
      protected var _startDragX:int;
      
      protected var _startDragY:int;
      
      protected var _dragX:int;
      
      protected var _dragY:int;
      
      protected var _dragPiexlX:Number;
      
      protected var _dragPiexlY:Number;
      
      protected var _preDragPiexlX:Number;
      
      protected var _preDragPiexlY:Number;
      
      protected var _startDrag:Function;
      
      protected var _stopDrag:Function;
      
      protected var _dragging:Function;
      
      protected var _moveHandler:Function;
      
      public function CDraggerUtil()
      {
         super();
         this._dragPiexlX = 0;
         this._dragPiexlY = 0;
      }
      
      public static function getInstance() : CDraggerUtil
      {
         if(instance == null)
         {
            instance = new CDraggerUtil();
         }
         return instance;
      }
      
      public function set StartDrag(param1:Function) : void
      {
         this._startDrag = param1;
      }
      
      public function set StopDrag(param1:Function) : void
      {
         this._stopDrag = param1;
      }
      
      public function set Dragging(param1:Function) : void
      {
         this._stopDrag = param1;
      }
      
      public function set MoveHandler(param1:Function) : void
      {
         this._moveHandler = param1;
      }
      
      public function get DragX() : int
      {
         return this._dragX;
      }
      
      public function get DragY() : int
      {
         return this._dragY;
      }
      
      public function get StartDragX() : int
      {
         return this._startDragX;
      }
      
      public function get StartDragY() : int
      {
         return this._startDragY;
      }
      
      public function get DragPiexlX() : Number
      {
         return this._dragPiexlX;
      }
      
      public function get DragPiexlY() : Number
      {
         return this._dragPiexlY;
      }
      
      public function get PreDragPiexlX() : Number
      {
         return this._preDragPiexlX;
      }
      
      public function get PreDragPiexlY() : Number
      {
         return this._preDragPiexlY;
      }
      
      public function get IsMove() : Boolean
      {
         return this._moving;
      }
      
      public function get CurrentPosX() : int
      {
         return this._target.x;
      }
      
      public function get CurrentPosY() : int
      {
         return this._target.y;
      }
      
      public function Register(param1:DisplayObjectContainer) : void
      {
         this._target = param1;
         this._target.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag,false,0,true);
      }
      
      public function unRegister(param1:DisplayObjectContainer) : void
      {
         if(this._target)
         {
            if(this._target.hasEventListener(MouseEvent.MOUSE_DOWN))
            {
               this._target.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
            }
         }
      }
      
      public function onStartDrag(param1:MouseEvent) : void
      {
         ConstructionOperationWidget.getInstance().Hide();
         if(GameKernel.currentGameStage == GameStageEnum.GAME_STAGE_OUTSIDE)
         {
            this._isDragging = true;
            this._moving = false;
            this._startDragX = param1.stageX;
            this._startDragY = param1.stageY;
            this._dragX = this._target.x;
            this._dragY = this._target.y;
            this._target.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag,false,0,true);
            this._target.addEventListener(MouseEvent.MOUSE_MOVE,this.onDragging,false,0,true);
         }
         else if(GameKernel.currentGameStage == GameStageEnum.GAME_STAGE_OUTSIDE)
         {
            if(!StarSurfaceAction.getInstance().IsBuildDrag)
            {
               this._isDragging = true;
               this._moving = false;
               this._startDragX = param1.stageX;
               this._startDragY = param1.stageY;
               this._dragX = this._target.x;
               this._dragY = this._target.y;
               this._target.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag,false,0,true);
               this._target.addEventListener(MouseEvent.MOUSE_MOVE,this.onDragging,false,0,true);
            }
         }
      }
      
      public function onStopDrag(param1:MouseEvent) : void
      {
         this._moving = false;
         StarSurfaceAction.getInstance().IsBuildDrag = false;
         var _loc2_:int = Math.round(this._dragPiexlY / GameSetting.MAP_GRID_HEIGHT);
         var _loc3_:int = Math.round(this._dragPiexlX / GameSetting.MAP_GRID_WIDTH);
         this._target.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         this._target.removeEventListener(MouseEvent.MOUSE_MOVE,this.onDragging);
      }
      
      public function isStop() : Boolean
      {
         return this._preDragPiexlX == this._dragPiexlX && this._preDragPiexlY == this._dragPiexlY;
      }
      
      public function onDragging(param1:MouseEvent) : void
      {
         this._moving = true;
         if(this._isDragging && this._moving && !StarSurfaceAction.getInstance().IsBuildDrag)
         {
            this._dragPiexlX = param1.stageX - this._startDragX;
            this._dragPiexlY = param1.stageY - this._startDragY;
            this.onMove(this._target,param1.stageX - this._startDragX + this._dragX,param1.stageY - this._startDragY + this._dragY);
         }
      }
      
      public function onMove(param1:DisplayObject, param2:int, param3:int) : void
      {
         param1.x = param2;
         param1.y = param3;
      }
   }
}

