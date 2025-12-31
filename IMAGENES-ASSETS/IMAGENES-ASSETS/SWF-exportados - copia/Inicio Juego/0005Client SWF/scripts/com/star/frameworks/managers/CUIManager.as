package com.star.frameworks.managers
{
   import com.star.frameworks.errors.CError;
   import com.star.frameworks.ui.CUIDecorator;
   import com.star.frameworks.ui.CUIFormat;
   import com.star.frameworks.ui.CUIParser;
   import com.star.frameworks.ui.ICUIComponent;
   import flash.display.DisplayObjectContainer;
   import flash.display.Stage;
   import flash.utils.Timer;
   
   public class CUIManager
   {
      
      private static var INITIAL_STAGE_WIDTH:int;
      
      private static var INITIAL_STAGE_HEIGHT:int;
      
      private static var instance:CUIManager = null;
      
      private var stage:Stage;
      
      private var ROOT:DisplayObjectContainer;
      
      private var time:Timer;
      
      public function CUIManager()
      {
         super();
      }
      
      public static function getInstance() : CUIManager
      {
         if(instance == null)
         {
            instance = new CUIManager();
         }
         return instance;
      }
      
      public function setROOT(param1:DisplayObjectContainer) : void
      {
         this.ROOT = param1;
         if(param1 != null && this.stage == null && param1.stage != null)
         {
            this.initStage(param1.stage);
         }
      }
      
      internal function initStage(param1:Stage) : void
      {
         if(this.stage == null)
         {
            this.stage = param1;
            CUIManager.INITIAL_STAGE_WIDTH = this.stage.stageWidth;
            CUIManager.INITIAL_STAGE_HEIGHT = this.stage.stageHeight;
         }
      }
      
      internal function isStageInited() : Boolean
      {
         return this.stage != null;
      }
      
      public function getStage() : Stage
      {
         if(this.stage == null)
         {
            throw new CError("未初始化根节点");
         }
         return this.stage;
      }
      
      public function initUI(param1:String, param2:Boolean = false) : ICUIComponent
      {
         var _loc4_:ICUIComponent = null;
         var _loc3_:CUIParser = new CUIParser(ResManager.getInstance().getXml(ResManager.GAMERES,param1));
         if(param2)
         {
            _loc4_ = _loc3_.getPopWindow();
            if(!DisplayListManager.getInstance().getDisplayList().ContainsKey(_loc4_.getName()))
            {
               DisplayListManager.getInstance().addDisplayList(_loc4_.getName(),_loc4_);
            }
         }
         ResManager.getInstance().removeXML(ResManager.GAMERES,param1);
         return _loc3_.getPopWindow().getComponentByIndex(0);
      }
      
      public function createComponentUI(param1:CUIFormat) : ICUIComponent
      {
         var _loc2_:CUIDecorator = new CUIDecorator(param1);
         return _loc2_.getICUImpl();
      }
   }
}

