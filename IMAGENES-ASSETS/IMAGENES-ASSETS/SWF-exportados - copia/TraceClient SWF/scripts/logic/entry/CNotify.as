package logic.entry
{
   import com.star.frameworks.display.Container;
   import com.star.frameworks.managers.StringManager;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import logic.game.GameKernel;
   import logic.ui.MailUI;
   import logic.ui.MallUI;
   import logic.ui.MyCorpsUI;
   import logic.ui.TaskSceneUI;
   import logic.ui.TransforingUI;
   import logic.ui.tip.CustomTip;
   
   public class CNotify extends Container
   {
      
      private var type:int;
      
      private var data:BitmapData;
      
      private var bitData:DisplayObject;
      
      private var TipText:String;
      
      public function CNotify(param1:int = 0)
      {
         super();
         setEnable(true);
         this.type = param1;
         this.init();
      }
      
      public function get Type() : int
      {
         return this.type;
      }
      
      private function init() : void
      {
         switch(this.type)
         {
            case 0:
               this.data = GameKernel.getTextureInstance("Newinfo");
               this.TipText = StringManager.getInstance().getMessageString("ChatingTXT14");
               this.bitData = new Bitmap(this.data);
               break;
            case 2:
               this.data = GameKernel.getTextureInstance("Danger");
               this.TipText = StringManager.getInstance().getMessageString("ChatingTXT16");
               this.bitData = new Bitmap(this.data);
               break;
            case 3:
               this.data = GameKernel.getTextureInstance("Somedanger");
               this.TipText = StringManager.getInstance().getMessageString("ChatingTXT17");
               this.bitData = new Bitmap(this.data);
         }
         addChild(this.bitData);
         this.addEventListener(MouseEvent.MOUSE_OVER,this.NotifyMouseOver);
         this.addEventListener(MouseEvent.MOUSE_OUT,this.NotifyMouseOut);
         this.addEventListener(MouseEvent.CLICK,this.NotifyClick);
      }
      
      private function NotifyMouseOver(param1:MouseEvent) : void
      {
         var _loc2_:Point = this.localToGlobal(new Point(0,this.y + this.height));
         CustomTip.GetInstance().Show(this.TipText,_loc2_);
      }
      
      private function NotifyMouseOut(param1:MouseEvent) : void
      {
         CustomTip.GetInstance().Hide();
      }
      
      private function NotifyClick(param1:MouseEvent) : void
      {
         if(this.type == 0)
         {
            GameKernel.popUpDisplayManager.Hide(MallUI.getInstance());
            MailUI.getInstance().Init();
            GameKernel.popUpDisplayManager.Show(MailUI.getInstance());
         }
         else if(this.type == 1)
         {
            TaskSceneUI.getInstance().Init();
            GameKernel.popUpDisplayManager.Show(TaskSceneUI.getInstance());
         }
         else if(this.type == 2)
         {
            TransforingUI.instance.Show(1);
         }
         else if(this.type == 3)
         {
            MyCorpsUI.getInstance().Show(1);
         }
      }
      
      public function Release() : void
      {
         removeChild(this.bitData);
         this.bitData = null;
      }
   }
}

