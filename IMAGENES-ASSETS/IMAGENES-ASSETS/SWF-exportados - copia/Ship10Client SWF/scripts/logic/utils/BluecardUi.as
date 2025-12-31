package logic.utils
{
   import flash.display.MovieClip;
   import logic.entry.HButton;
   import logic.entry.MObject;
   import logic.game.GameKernel;
   import logic.ui.AbstractPopUp;
   
   public class BluecardUi extends AbstractPopUp
   {
      
      private static var instance:BluecardUi;
      
      public var content:MovieClip;
      
      public var btn_down:HButton;
      
      public var btn_up:HButton;
      
      public function BluecardUi()
      {
         super();
         setPopUpName("BluecardUi");
      }
      
      public static function getInstance() : BluecardUi
      {
         if(instance == null)
         {
            instance = new BluecardUi();
         }
         return instance;
      }
      
      override public function Init() : void
      {
         if(GameKernel.popUpDisplayManager.PopDisplayList.ContainsKey(getPopUpName()))
         {
            return;
         }
         this._mc = new MObject("BluecardMc",0,0);
         this.initMcElement();
         GameKernel.popUpDisplayManager.Regisger(instance);
      }
      
      override public function initMcElement() : void
      {
         this.content = this._mc.getMC();
         this.content.tf_content.height = 53;
         this.btn_down = new HButton(this.content.btn_down);
         this.btn_up = new HButton(this.content.btn_up);
      }
   }
}

