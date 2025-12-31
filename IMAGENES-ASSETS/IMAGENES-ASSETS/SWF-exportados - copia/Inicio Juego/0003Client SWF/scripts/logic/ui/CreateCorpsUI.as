package logic.ui
{
   import com.star.frameworks.display.Container;
   import com.star.frameworks.managers.StringManager;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import logic.entry.GamePlayer;
   import logic.entry.HButton;
   import logic.entry.MObject;
   import logic.entry.ScienceSystem;
   import logic.game.GameKernel;
   import net.base.NetManager;
   import net.msg.corpsMsg.MSG_REQUEST_CREATECONSORTIA;
   
   public class CreateCorpsUI
   {
      
      private static var instance:CreateCorpsUI;
      
      private var ParentLock:Container;
      
      private var mc_corpsbase:MovieClip;
      
      private var tf_corpsname:TextField;
      
      private var btn_left:HButton;
      
      private var btn_right:HButton;
      
      private var btn_ensure:HButton;
      
      private var CorpsHeadIndex:int;
      
      private var _mc:MObject;
      
      private var condition0:Boolean;
      
      private var condition1:Boolean;
      
      private var btn_mall:HButton;
      
      public function CreateCorpsUI()
      {
         super();
         this.Init();
      }
      
      public static function getInstance() : CreateCorpsUI
      {
         if(instance == null)
         {
            instance = new CreateCorpsUI();
         }
         return instance;
      }
      
      public function Init() : void
      {
         this._mc = new MObject("FoundcorpsMcpop",GameKernel.fullRect.width / 2 + GameKernel.fullRect.x,300);
         this.initMcElement();
      }
      
      public function initMcElement() : void
      {
         var _loc1_:MovieClip = null;
         var _loc2_:HButton = null;
         var _loc3_:TextField = null;
         this.mc_corpsbase = this._mc.getMC().getChildByName("mc_corpsbase") as MovieClip;
         this.tf_corpsname = this._mc.getMC().getChildByName("tf_corpsname") as TextField;
         this.tf_corpsname.addEventListener(Event.CHANGE,this.tf_corpsnameChange);
         this.tf_corpsname.maxChars = GamePlayer.getInstance().language == 0 ? 8 : 16;
         _loc1_ = this._mc.getMC().getChildByName("btn_left") as MovieClip;
         this.btn_left = new HButton(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.btn_leftClick);
         this.btn_left.setBtnDisabled(true);
         _loc1_ = this._mc.getMC().getChildByName("btn_right") as MovieClip;
         this.btn_right = new HButton(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.btn_rightClick);
         _loc1_ = this._mc.getMC().getChildByName("btn_close") as MovieClip;
         _loc2_ = new HButton(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.btn_closeClick);
         _loc1_ = this._mc.getMC().getChildByName("btn_ensure") as MovieClip;
         this.btn_ensure = new HButton(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.btn_ensureClick);
         _loc1_ = this._mc.getMC().getChildByName("btn_mall") as MovieClip;
         this.btn_mall = new HButton(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.btn_mallClick);
         this.condition0 = false;
         this.condition1 = false;
         _loc3_ = this._mc.getMC().getChildByName("tf_condition0") as TextField;
         _loc3_.text = StringManager.getInstance().getMessageString("CorpsText47");
         _loc3_ = this._mc.getMC().getChildByName("tf_condition1") as TextField;
         _loc3_.text = StringManager.getInstance().getMessageString("CorpsText48");
         this.ParentLock = new Container("CreateCorpsUISceneLock");
         this.ParentLock.mouseEnabled = true;
         this.ParentLock.mouseChildren = true;
         this.ParentLock.fillRectangleWithoutBorder(GameKernel.fullRect.left,GameKernel.fullRect.top,GameKernel.fullRect.width,GameKernel.fullRect.height + 130,0,0.5);
      }
      
      private function ShowCorpsImage() : void
      {
         if(this.mc_corpsbase.numChildren > 0)
         {
            this.mc_corpsbase.removeChildAt(0);
         }
         var _loc1_:Bitmap = new Bitmap(GameKernel.getTextureInstance("corp_" + this.CorpsHeadIndex));
         this.mc_corpsbase.addChild(_loc1_);
      }
      
      public function Show() : void
      {
         this.Clear();
         var _loc1_:int = Math.random() * 100;
         this.CorpsHeadIndex = _loc1_ % 49;
         this.ShowCorpsImage();
         this.SetPageButton();
         GameKernel.renderManager.getUI().addComponent(this.ParentLock);
         this.ParentLock.addChild(this._mc.getMC());
      }
      
      public function Clear() : void
      {
         this.tf_corpsname.text = "";
         this.btn_ensure.setBtnDisabled(true);
         this.condition0 = false;
         this.condition1 = false;
         var _loc1_:TextField = this._mc.getMC().getChildByName("tf_condition0") as TextField;
         var _loc2_:TextFormat = _loc1_.getTextFormat();
         _loc2_.color = 16711680;
         var _loc3_:int = 0;
         while(_loc3_ < ScienceSystem.getinstance().Packarr.length)
         {
            if(ScienceSystem.getinstance().Packarr[_loc3_].PropsId == 922)
            {
               _loc2_.color = 65280;
               this.condition0 = true;
               break;
            }
            _loc3_++;
         }
         _loc1_.setTextFormat(_loc2_);
         this.btn_mall.setVisible(!this.condition0);
         _loc1_ = this._mc.getMC().getChildByName("tf_condition1") as TextField;
         _loc2_ = _loc1_.getTextFormat();
         _loc2_.color = 16711680;
         if(GamePlayer.getInstance().UserMoney >= 10000)
         {
            _loc2_.color = 65280;
            this.condition1 = true;
         }
         _loc1_.setTextFormat(_loc2_);
      }
      
      private function ShowCorpsHead() : void
      {
      }
      
      private function btn_leftClick(param1:Event) : void
      {
         --this.CorpsHeadIndex;
         this.ShowCorpsImage();
         this.SetPageButton();
      }
      
      private function btn_rightClick(param1:Event) : void
      {
         ++this.CorpsHeadIndex;
         this.ShowCorpsImage();
         this.SetPageButton();
      }
      
      private function SetPageButton() : void
      {
         if(this.CorpsHeadIndex == 0)
         {
            this.btn_left.setBtnDisabled(true);
         }
         else
         {
            this.btn_left.setBtnDisabled(false);
         }
         if(this.CorpsHeadIndex == 49)
         {
            this.btn_right.setBtnDisabled(true);
         }
         else
         {
            this.btn_right.setBtnDisabled(false);
         }
      }
      
      private function btn_closeClick(param1:Event) : void
      {
         this.ParentLock.removeChild(this._mc.getMC());
         GameKernel.renderManager.getUI().removeComponent(this.ParentLock);
      }
      
      private function btn_ensureClick(param1:Event) : void
      {
         var _loc2_:MSG_REQUEST_CREATECONSORTIA = new MSG_REQUEST_CREATECONSORTIA();
         _loc2_.Name = this.tf_corpsname.text;
         _loc2_.HeadId = this.CorpsHeadIndex;
         _loc2_.SeqId = GamePlayer.getInstance().seqID++;
         _loc2_.Guid = GamePlayer.getInstance().Guid;
         NetManager.Instance().sendObject(_loc2_);
         this.btn_closeClick(null);
      }
      
      private function btn_cancelClick(param1:Event) : void
      {
         this.btn_closeClick(null);
      }
      
      private function tf_corpsnameChange(param1:Event) : void
      {
         if(this.condition1 == false || this.condition0 == false)
         {
            return;
         }
         if(this.tf_corpsname.text == "")
         {
            this.btn_ensure.setBtnDisabled(true);
         }
         else
         {
            this.btn_ensure.setBtnDisabled(false);
         }
      }
      
      private function btn_mallClick(param1:Event) : void
      {
         if(this.condition0 == false)
         {
            StateHandlingUI.getInstance().Init();
            StateHandlingUI.getInstance().setParent("CreateCorpsUI");
            StateHandlingUI.getInstance().getstate(922);
            StateHandlingUI.getInstance().InitPopUp();
            GameKernel.popUpDisplayManager.Show(StateHandlingUI.getInstance());
            PropsBuyUI.getInstance().ShowCreateCorpsUI = 1;
         }
      }
   }
}

