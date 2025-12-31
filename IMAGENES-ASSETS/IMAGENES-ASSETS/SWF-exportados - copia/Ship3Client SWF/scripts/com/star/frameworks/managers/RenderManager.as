package com.star.frameworks.managers
{
   import com.star.frameworks.display.Container;
   import com.star.frameworks.module.IModule;
   import com.star.frameworks.ui.CUIComponent;
   import com.star.frameworks.ui.ICUIComponent;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import logic.game.GameKernel;
   import logic.game.GameSetting;
   import logic.ui.AlignManager;
   
   public class RenderManager
   {
      
      private static var instance:RenderManager;
      
      public static var loadingMc:MovieClip;
      
      private var root:Sprite;
      
      private var scene:ICUIComponent;
      
      private var map:ICUIComponent;
      
      private var ui:ICUIComponent;
      
      private var mainUI:ICUIComponent;
      
      private var currentHandler:*;
      
      private var lock:Container;
      
      private var maskSp:Container;
      
      private var LockNum:int;
      
      public function RenderManager()
      {
         super();
      }
      
      public static function getInstance() : RenderManager
      {
         if(instance == null)
         {
            instance = new RenderManager();
         }
         return instance;
      }
      
      public function Render(param1:Sprite) : void
      {
         this.root = param1;
         this.root.mouseEnabled = false;
         this.root.tabChildren = false;
         this.root.tabEnabled = false;
         this.scene = new CUIComponent();
         this.scene.HasChild(true);
         this.scene.setShow(true);
         this.scene.setEnable(false);
         this.scene.setName("Scene");
         Container(this.scene.getComponent()).tabChildren = false;
         Container(this.scene.getComponent()).tabEnabled = false;
         this.ui = new CUIComponent();
         this.ui.setEnable(false);
         this.ui.setShow(true);
         this.ui.setName("UI");
         this.ui.HasChild(true);
         Container(this.ui.getComponent()).tabChildren = false;
         Container(this.ui.getComponent()).tabEnabled = false;
         this.map = new CUIComponent();
         this.map.setEnable(false);
         this.map.HasChild(true);
         this.map.setShow(true);
         this.map.setName("Map");
         Container(this.map.getComponent()).tabChildren = false;
         Container(this.map.getComponent()).tabEnabled = false;
         this.scene.addComponent(this.map);
         this.scene.addComponent(this.ui);
         this.root.addChild(this.scene.getComponent());
         this.lock = new Container("SceneLock");
         this.lock.mouseEnabled = true;
         this.lock.mouseChildren = false;
         this.lock.fillRectangleWithoutBorder(0,0,GameSetting.GAME_STAGE_WIDTH,GameSetting.GAME_STAGE_HEIGHT,0,0.6);
         AlignManager.GetInstance().SetAlign(this.lock,"none");
         loadingMc = GameKernel.getMovieClipInstance("RingLoading",380,300);
         loadingMc.gotoAndStop(1);
      }
      
      public function rendMask(param1:Boolean = true) : void
      {
      }
      
      private function initLockScreen() : void
      {
      }
      
      public function showLoadingMc(param1:Boolean) : void
      {
         if(param1)
         {
            if(!this.getScene().getContainer().contains(loadingMc))
            {
               GameKernel.renderManager.lockScene(param1);
               loadingMc.gotoAndPlay(1);
               this.getScene().addComponent(loadingMc);
            }
         }
         else if(this.getScene().getChildByName(loadingMc.name))
         {
            loadingMc.stop();
            GameKernel.renderManager.lockScene(false);
            this.getScene().removeComponent(loadingMc);
         }
      }
      
      public function lockScene(param1:Boolean = false) : void
      {
         if(param1)
         {
            ++this.LockNum;
            if(this.lock.parent == null)
            {
               this.initLockScreen();
               this.getUI().addComponent(this.lock);
            }
         }
         else if(this.lock.parent)
         {
            --this.LockNum;
            if(this.LockNum <= 0)
            {
               this.LockNum = 0;
               this.lock.parent.removeChild(this.lock);
            }
         }
      }
      
      public function lockSceneAndLoading(param1:Boolean = false) : void
      {
         if(param1)
         {
            this.initLockScreen();
            this.lock.addChild(loadingMc);
            this.getUI().addComponent(this.lock);
            return;
         }
         this.lock.removeChild(loadingMc);
         this.getUI().removeComponent(this.lock,true);
      }
      
      public function getRoot() : Sprite
      {
         return this.root;
      }
      
      public function getScene() : ICUIComponent
      {
         return this.scene;
      }
      
      public function getMap() : ICUIComponent
      {
         return this.map;
      }
      
      public function getUI() : ICUIComponent
      {
         return this.ui;
      }
      
      public function getSceneLock() : Container
      {
         return this.lock;
      }
      
      public function setUIVisible(param1:String, param2:Boolean) : void
      {
      }
      
      public function Show(param1:IModule, param2:Boolean = false) : void
      {
         if(!param2)
         {
            if(this.getUI().getComponentByName(param1.getUI().name))
            {
               this.getUI().removeComponent(param1.getUI());
               param1 = null;
            }
         }
         else if(DisplayListManager.getInstance().getDisplayItem(param1.getUI().name))
         {
            this.getUI().addComponent(param1.getUI());
            this.currentHandler = param1;
         }
      }
   }
}

