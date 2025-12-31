package logic.utils
{
   import flash.display.MovieClip;
   import logic.entry.HButton;
   import logic.entry.MObject;
   import logic.game.GameKernel;
   import logic.ui.AbstractPopUp;
   
   public class YellowcardUi extends AbstractPopUp
   {
      
      private static var instance:YellowcardUi;
      
      public var content:MovieClip;
      
      public var btn_down:HButton;
      
      public var btn_up:HButton;
      
      public function YellowcardUi()
      {
         super();
         setPopUpName("YellowcardUi");
      }
      
      public static function getInstance() : YellowcardUi
      {
         if(instance == null)
         {
            instance = new YellowcardUi();
         }
         return instance;
      }
      
      override public function Init() : void
      {
         if(GameKernel.popUpDisplayManager.PopDisplayList.ContainsKey(getPopUpName()))
         {
            return;
         }
         this._mc = new MObject("YellowcardMc",0,0);
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

