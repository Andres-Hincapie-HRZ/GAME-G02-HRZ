package logic.ui
{
   import com.star.frameworks.display.Container;
   import com.star.frameworks.managers.StringManager;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import logic.entry.GamePlayer;
   import logic.entry.HButton;
   import logic.game.GameKernel;
   import net.base.NetManager;
   import net.msg.corpsMsg.MSG_REQUEST_CONSORTIAGIVEN;
   
   public class MyCorpsUI_Transfer
   {
      
      private static var instance:MyCorpsUI_Transfer;
      
      private var ParentLock:Container;
      
      private var TransferMc:MovieClip;
      
      public function MyCorpsUI_Transfer()
      {
         var _loc1_:MovieClip = null;
         var _loc2_:HButton = null;
         super();
         this.TransferMc = GameKernel.getMovieClipInstance("TransferMcPop",GameKernel.fullRect.width / 2 + GameKernel.fullRect.x,300,false);
         this.ParentLock = new Container("TransferMcPopSceneLock");
         this.ParentLock.mouseEnabled = true;
         this.ParentLock.mouseChildren = true;
         this.ParentLock.fillRectangleWithoutBorder(GameKernel.fullRect.x,GameKernel.fullRect.y,GameKernel.fullRect.width,GameKernel.fullRect.height,0,0.5);
         _loc1_ = this.TransferMc.getChildByName("btn_cancel") as MovieClip;
         _loc2_ = new HButton(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.btn_closeClick);
         _loc1_ = this.TransferMc.getChildByName("btn_ensure") as MovieClip;
         _loc2_ = new HButton(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.btn_ensureClick);
      }
      
      public static function getInstance() : MyCorpsUI_Transfer
      {
         if(instance == null)
         {
            instance = new MyCorpsUI_Transfer();
         }
         return instance;
      }
      
      public function Show() : void
      {
         this.Clear();
         this.ParentLock.fillRectangleWithoutBorder(GameKernel.fullRect.left,GameKernel.fullRect.top,GameKernel.fullRect.width,GameKernel.fullRect.height + 130,0,0.5);
         GameKernel.renderManager.getUI().addComponent(this.ParentLock);
         this.ParentLock.addChild(this.TransferMc);
      }
      
      private function Clear() : void
      {
      }
      
      private function btn_closeClick(param1:Event) : void
      {
         this.ParentLock.removeChild(this.TransferMc);
         GameKernel.renderManager.getUI().removeComponent(this.ParentLock);
         MyCorpsUI.getInstance().Show();
      }
      
      private function btn_ensureClick(param1:Event) : void
      {
         var _loc2_:TextField = this.TransferMc.getChildByName("tf_name") as TextField;
         _loc2_.text = _loc2_.text.replace(/^\s*/g,"");
         _loc2_.text = _loc2_.text.replace(/\s*$/g,"");
         if(_loc2_.text == "")
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("CorpsText23"),0);
         }
         var _loc3_:int = int(_loc2_.text);
         var _loc4_:MSG_REQUEST_CONSORTIAGIVEN = new MSG_REQUEST_CONSORTIAGIVEN();
         _loc4_.ObjGuid = _loc3_;
         _loc4_.SeqId = GamePlayer.getInstance().seqID++;
         _loc4_.Guid = GamePlayer.getInstance().Guid;
         NetManager.Instance().sendObject(_loc4_);
         this.btn_closeClick(null);
      }
   }
}

