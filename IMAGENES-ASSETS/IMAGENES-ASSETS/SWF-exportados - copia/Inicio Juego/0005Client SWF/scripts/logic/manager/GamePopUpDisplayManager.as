package logic.manager
{
   import com.star.frameworks.utils.HashSet;
   import flash.display.MovieClip;
   import gs.TweenLite;
   import gs.easing.Strong;
   import logic.game.GameKernel;
   import logic.impl.IPopUp;
   
   public class GamePopUpDisplayManager
   {
      
      private static var instance:GamePopUpDisplayManager;
      
      private var mHistoryX:Number;
      
      private var mHistoryY:Number;
      
      private var _popDisplayList:HashSet;
      
      public function GamePopUpDisplayManager()
      {
         super();
         this._popDisplayList = new HashSet();
      }
      
      public static function getInstance() : GamePopUpDisplayManager
      {
         if(instance == null)
         {
            instance = new GamePopUpDisplayManager();
         }
         return instance;
      }
      
      public function get PopDisplayList() : HashSet
      {
         return this._popDisplayList;
      }
      
      public function Regisger(param1:IPopUp) : void
      {
         if(this._popDisplayList.ContainsKey(param1.getPopUpName()))
         {
            return;
         }
         this._popDisplayList.Put(param1.getPopUpName(),param1);
      }
      
      public function unRegister(param1:IPopUp) : void
      {
         if(this._popDisplayList.ContainsKey(param1.getPopUpName()))
         {
            this._popDisplayList.Remove(param1.getPopUpName());
            param1 = null;
         }
      }
      
      public function Show(param1:IPopUp, param2:Boolean = true, param3:Boolean = true) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(param1.IsVisible())
         {
            return;
         }
         if(GameKernel.platform == 2 && param1.getPopUpName() != "ErrorPopup")
         {
            param1.setLocationXY(param1.getPopUp().x + 130,param1.getPopUp().y);
         }
         this.showSingleTon(param1,param2,param3);
      }
      
      public function HideAllPopup() : void
      {
         var _loc1_:IPopUp = null;
         if(this._popDisplayList.Length() == 0)
         {
            return;
         }
         for each(_loc1_ in this._popDisplayList.Values())
         {
            this.Hide(_loc1_,true,false);
         }
      }
      
      private function showSingleTon(param1:IPopUp, param2:Boolean = true, param3:Boolean = true) : void
      {
         var _loc4_:IPopUp = null;
         if(param1 == null)
         {
            return;
         }
         for each(_loc4_ in this._popDisplayList.Values())
         {
            if(_loc4_ != param1 && _loc4_.IsVisible())
            {
               this.Hide(_loc4_);
            }
         }
         if(param1.IsVisible())
         {
            return;
         }
         if(!GameKernel.renderManager.getUI().getContainer().contains(IPopUp(this._popDisplayList.Get(param1.getPopUpName())).getPopUp()))
         {
            if(param3)
            {
               this.adjustWindowSize(param1,0,param2);
            }
            else
            {
               if(param2)
               {
                  GameKernel.renderManager.lockScene(true);
               }
               else
               {
                  GameKernel.renderManager.lockScene(false);
               }
               GameKernel.renderManager.getUI().addComponent(IPopUp(this._popDisplayList.Get(param1.getPopUpName())).getPopUp());
            }
         }
         else
         {
            GameKernel.renderManager.getUI().getContainer().setChildIndex(IPopUp(this._popDisplayList.Get(param1.getPopUpName())).getPopUp(),GameKernel.renderManager.getUI().getContainer().numChildren - 1);
         }
      }
      
      public function Hide(param1:IPopUp, param2:Boolean = true, param3:Boolean = true) : void
      {
         var _loc4_:IPopUp = null;
         if(param1 == null)
         {
            return;
         }
         if(this._popDisplayList.ContainsKey(param1.getPopUpName()))
         {
            param1.setVisible(false);
            _loc4_ = IPopUp(this._popDisplayList.Get(param1.getPopUpName()));
            if(GameKernel.renderManager.getUI().getContainer().contains(_loc4_.getPopUp()))
            {
               _loc4_.Remove();
               if(param3)
               {
                  this.adjustWindowSize(_loc4_,1,param2);
               }
               else
               {
                  _loc4_.RestRawLocation();
                  GameKernel.renderManager.getUI().removeComponent(_loc4_.getPopUp());
                  if(param2)
                  {
                     GameKernel.renderManager.lockScene(false);
                  }
               }
            }
         }
      }
      
      private function adjustWindowSize(param1:IPopUp, param2:int = 0, param3:Boolean = true) : void
      {
         var scale:Number = NaN;
         var diffX:Number = NaN;
         var diffY:Number = NaN;
         var destX:Number = NaN;
         var destY:Number = NaN;
         var mObj:MovieClip = null;
         var preX:Number = NaN;
         var preY:Number = NaN;
         var ipop:IPopUp = param1;
         var expand:int = param2;
         var lock:Boolean = param3;
         mObj = ipop.getPopUp().getMC();
         if(mObj)
         {
            preX = mObj.x;
            preY = mObj.y;
         }
         else
         {
            preX = 0;
            preY = 0;
         }
         scale = 0.8;
         if(expand)
         {
            diffX = Math.floor(mObj.width * (1 - scale) >> 3);
            diffY = Math.floor(mObj.height * (1 - scale) >> 3);
            destX = mObj.x + diffX;
            destY = mObj.y + diffX;
            TweenLite.to(mObj,0.5,{
               "autoAlpha":0.6,
               "scaleX":0,
               "scaleY":0,
               "x":destX,
               "y":destY,
               "ease":Strong.easeInOut,
               "onComplete":function():void
               {
                  mObj.x = preX;
                  mObj.y = preY;
                  GameKernel.renderManager.getUI().removeComponent(ipop.getPopUp());
                  if(GameKernel.platform == 2)
                  {
                     ipop.RestRawLocation();
                  }
                  if(lock)
                  {
                     GameKernel.renderManager.lockScene(false);
                  }
               }
            });
         }
         else
         {
            if(mObj)
            {
               mObj.scaleX = mObj.scaleY = 0;
            }
            if(lock)
            {
               GameKernel.renderManager.lockScene(true);
            }
            else
            {
               GameKernel.renderManager.lockScene(false);
            }
            GameKernel.renderManager.getUI().addComponent(ipop.getPopUp());
            if(mObj)
            {
               TweenLite.to(mObj,0.5,{
                  "autoAlpha":1,
                  "scaleX":1,
                  "scaleY":1,
                  "ease":Strong.easeInOut
               });
            }
         }
      }
   }
}

