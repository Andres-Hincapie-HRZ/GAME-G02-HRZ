package logic.utils
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import logic.entry.HButton;
   import logic.entry.MObject;
   import logic.game.GameKernel;
   import logic.ui.AbstractPopUp;
   
   public class GreencardUi extends AbstractPopUp
   {
      
      private static var instance:GreencardUi;
      
      public var content:MovieClip;
      
      public var tf_content:TextField = new TextField();
      
      public var btn_down:HButton;
      
      public var btn_up:HButton;
      
      public var btn_drag:HButton;
      
      public function GreencardUi()
      {
         super();
         setPopUpName("GreencardUi");
      }
      
      public static function getInstance() : GreencardUi
      {
         if(instance == null)
         {
            instance = new GreencardUi();
         }
         return instance;
      }
      
      override public function Init() : void
      {
         if(GameKernel.popUpDisplayManager.PopDisplayList.ContainsKey(getPopUpName()))
         {
            return;
         }
         this._mc = new MObject("GreencardMc",0,0);
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

