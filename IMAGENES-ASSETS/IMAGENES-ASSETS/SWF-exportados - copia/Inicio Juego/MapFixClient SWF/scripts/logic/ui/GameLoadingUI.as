package logic.ui
{
   import flash.text.TextField;
   import logic.entry.MObject;
   import logic.game.GameKernel;
   import logic.game.GameSetting;
   
   public class GameLoadingUI
   {
      
      private static var instance:GameLoadingUI;
      
      private var isShow:Boolean;
      
      private var loadinMc:MObject;
      
      private var tf_percent:TextField;
      
      private var tf_num:TextField;
      
      public function GameLoadingUI()
      {
         super();
         this.loadinMc = new MObject("Nowloading");
         this.tf_percent = this.loadinMc.getMC().tf_percent as TextField;
         this.tf_num = this.loadinMc.getMC().tf_num as TextField;
         var _loc1_:* = GameSetting.GAME_STAGE_WIDTH - this.loadinMc.width >> 1;
         var _loc2_:* = GameSetting.GAME_STAGE_HEIGHT - this.loadinMc.height >> 1;
         this.loadinMc.setLocationXY(_loc1_,_loc2_);
      }
      
      public static function getInstance() : GameLoadingUI
      {
         if(instance == null)
         {
            instance = new GameLoadingUI();
         }
         return instance;
      }
      
      public function get IsVisible() : Boolean
      {
         return this.isShow;
      }
      
      public function set IsVisible(param1:Boolean) : void
      {
         this.isShow = param1;
      }
      
      public function Show() : void
      {
         if(this.loadinMc)
         {
            if(this.IsVisible)
            {
               return;
            }
            this.IsVisible = true;
            GameKernel.renderManager.getScene().addComponent(this.loadinMc);
            GameKernel.renderManager.lockScene(true);
         }
      }
      
      public function Hide() : void
      {
         if(Boolean(this.loadinMc) && Boolean(this.loadinMc.parent))
         {
            if(!this.IsVisible)
            {
               return;
            }
            this.IsVisible = false;
            GameKernel.renderManager.getScene().removeComponent(this.loadinMc);
            GameKernel.renderManager.lockScene(false);
         }
      }
      
      public function Update(param1:String) : void
      {
         this.tf_percent.text = param1;
      }
      
      public function setLoadinNum(param1:int, param2:int) : void
      {
         this.tf_num.text = param1.toString() + "/ " + param2;
      }
      
      public function getLoadingUI() : MObject
      {
         return this.loadinMc;
      }
   }
}

