package logic.ui
{
   import com.star.frameworks.events.ActionEvent;
   import com.star.frameworks.events.ModuleEvent;
   import com.star.frameworks.managers.StringManager;
   import flash.display.DisplayObject;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import logic.entry.MObject;
   import logic.game.GameKernel;
   import logic.manager.GameInterActiveManager;
   import logic.manager.GamePopUpDisplayManager;
   import logic.ui.info.BleakingLineForThai;
   
   public class ErrorPopup extends AbstractPopUp
   {
      
      private static var instance:ErrorPopup;
      
      private var btn_refrush:SimpleButton;
      
      public function ErrorPopup()
      {
         super();
         setPopUpName("ErrorPopup");
      }
      
      public static function getInstance() : ErrorPopup
      {
         if(instance == null)
         {
            instance = new ErrorPopup();
         }
         return instance;
      }
      
      public function getErrorPopUp() : MObject
      {
         return this._mc;
      }
      
      override public function Init() : void
      {
         if(this._mc)
         {
            return;
         }
         if(GameKernel.popUpDisplayManager.PopDisplayList.ContainsKey(getPopUpName()))
         {
            this.ClearLogicUI();
            GameKernel.popUpDisplayManager.Show(this,true,false);
            return;
         }
         this.ClearLogicUI();
         this._mc = new MObject("ErrorScene",0,0,true);
         var _loc1_:DisplayObject = this._mc.getMC().getChildByName("mc_back");
         this.btn_refrush = this._mc.getMC().getChildByName("btn_refrush") as SimpleButton;
         GameInterActiveManager.InstallInterActiveEvent(this.btn_refrush,ActionEvent.ACTION_CLICK,this.onReConnect);
         GameKernel.renderManager.showLoadingMc(false);
         GameKernel.popUpDisplayManager.Regisger(instance);
         GameKernel.popUpDisplayManager.Show(this,true,false);
      }
      
      private function ClearLogicUI() : void
      {
         GamePopUpDisplayManager.getInstance().HideAllPopup();
      }
      
      public function setErrorMsg(param1:String, param2:int = -1) : void
      {
         if(param2 >= 0)
         {
            if(this._mc)
            {
               TextField(this._mc.getMC().txt_info).text = "    " + param1 + StringManager.getInstance().getMessageString("Server" + int(26 + param2));
            }
         }
         else if(this._mc)
         {
            TextField(this._mc.getMC().txt_info).text = "    " + param1;
         }
         if(this._mc)
         {
            BleakingLineForThai.GetInstance().BleakThaiLanguage(TextField(this._mc.getMC().txt_info),16758016);
         }
      }
      
      public function InitModule(param1:ModuleEvent) : void
      {
      }
      
      public function Release() : void
      {
      }
      
      public function getUI() : MObject
      {
         return null;
      }
      
      public function SetVisible(param1:Boolean) : void
      {
      }
      
      private function onReConnect(param1:MouseEvent) : void
      {
         GameKernel.RefreshWeb();
      }
   }
}

