package logic.manager
{
   import com.star.frameworks.geom.PointKit;
   import com.star.frameworks.geom.RectangleKit;
   import com.star.frameworks.utils.HashSet;
   import flash.display.DisplayObject;
   import gs.TweenLite;
   import logic.entry.MObject;
   import logic.game.GameKernel;
   
   public class GameLayOutManager
   {
      
      private static var instance:GameLayOutManager;
      
      private var _layoutList:HashSet;
      
      public function GameLayOutManager()
      {
         super();
         this._layoutList = new HashSet();
      }
      
      public static function getInstance() : GameLayOutManager
      {
         if(instance == null)
         {
            instance = new GameLayOutManager();
         }
         return instance;
      }
      
      public function get LayOutList() : HashSet
      {
         return this._layoutList;
      }
      
      public function InstallUI(param1:String, param2:RectangleKit) : void
      {
         var _loc3_:MObject = null;
         if(this.LayOutList.ContainsKey(param1))
         {
            _loc3_ = this.LayOutList.Get(param1) as MObject;
            _loc3_.x = param2.x;
            _loc3_.y = param2.y;
            GameKernel.renderManager.getUI().addComponent(_loc3_);
            return;
         }
         _loc3_ = new MObject(param1);
         this.LayOutList.Put(param1,_loc3_);
         _loc3_.x = param2.x;
         _loc3_.y = param2.y;
         GameKernel.renderManager.getUI().addComponent(_loc3_);
      }
      
      public function installComponent(param1:String, param2:DisplayObject) : void
      {
         var _loc3_:DisplayObject = null;
         if(this.LayOutList.ContainsKey(param1))
         {
            _loc3_ = this.LayOutList.Get(param1) as DisplayObject;
            if(param2.parent == null)
            {
               GameKernel.renderManager.getUI().addComponent(param2);
            }
         }
         else
         {
            this.LayOutList.Put(param1,param2);
            GameKernel.renderManager.getUI().addComponent(param2);
         }
      }
      
      public function unInstallUI(param1:String) : void
      {
         if(this.LayOutList.ContainsKey(param1))
         {
            this.setVisible(this.LayOutList.Get(param1),false);
         }
      }
      
      public function getInstallUI(param1:String) : DisplayObject
      {
         return this.LayOutList.Get(param1);
      }
      
      public function setUIAnimation(param1:DisplayObject, param2:PointKit, param3:Function = null) : void
      {
         TweenLite.to(param1,1,{
            "x":param2.x,
            "y":param2.y,
            "onComplete":param3
         });
      }
      
      public function setVisible(param1:DisplayObject, param2:Boolean) : void
      {
         if(param2)
         {
            if(this.LayOutList.ContainsKey(param1.name))
            {
               GameKernel.renderManager.getUI().addComponent(param1);
            }
            return;
         }
         if(GameKernel.renderManager.getUI().getChildByName(param1.name))
         {
            GameKernel.renderManager.getUI().removeComponent(param1);
         }
      }
   }
}

