package logic.ui
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import logic.entry.HButton;
   import logic.entry.MObject;
   import logic.game.GameKernel;
   import logic.widget.NotifyWidget;
   import net.msg.mail.MSG_RESP_EMAILINFO_TEMP;
   
   public class MailUI extends AbstractPopUp
   {
      
      private static var instance:MailUI;
      
      private var btn_inbox:HButton;
      
      private var btn_writeletter:HButton;
      
      private var btn_friendlist:HButton;
      
      private var mc_base:MovieClip;
      
      private var SelectedBtn:HButton;
      
      public function MailUI()
      {
         super();
         setPopUpName("MailUI");
      }
      
      public static function getInstance() : MailUI
      {
         if(instance == null)
         {
            instance = new MailUI();
         }
         return instance;
      }
      
      override public function Init() : void
      {
         NotifyWidget.getInstance().removeNotify(0);
         if(GameKernel.popUpDisplayManager.PopDisplayList.ContainsKey(getPopUpName()))
         {
            this.FirstShow();
            return;
         }
         this._mc = new MObject("MailScene",385,285);
         this.initMcElement();
         GameKernel.popUpDisplayManager.Regisger(instance);
         this.FirstShow();
      }
      
      private function FirstShow() : void
      {
         MailUI_Inbox.getInstance().FirstShow();
         this.btn_inboxClick(null);
      }
      
      override public function initMcElement() : void
      {
         var _loc1_:HButton = null;
         var _loc2_:MovieClip = null;
         _loc2_ = this._mc.getMC().getChildByName("btn_close") as MovieClip;
         _loc1_ = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_closeClick);
         _loc2_ = this._mc.getMC().getChildByName("btn_inbox") as MovieClip;
         this.btn_inbox = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_inboxClick);
         _loc2_ = this._mc.getMC().getChildByName("btn_writeletter") as MovieClip;
         this.btn_writeletter = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_writeletterClick);
         _loc2_ = this._mc.getMC().getChildByName("btn_friendlist") as MovieClip;
         this.btn_friendlist = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_friendlistClick);
         this.mc_base = this._mc.getMC().getChildByName("mc_base") as MovieClip;
      }
      
      private function btn_closeClick(param1:Event) : void
      {
         GameKernel.popUpDisplayManager.Hide(this);
      }
      
      private function btn_inboxClick(param1:Event) : void
      {
         this.ResetSelectedBtn(this.btn_inbox);
         if(this.mc_base.numChildren > 0)
         {
            this.mc_base.removeChildAt(0);
         }
         this.mc_base.addChild(MailUI_Inbox.getInstance().GetInboxList());
      }
      
      private function btn_writeletterClick(param1:Event) : void
      {
         this.ResetSelectedBtn(this.btn_writeletter);
         if(this.mc_base.numChildren > 0)
         {
            this.mc_base.removeChildAt(0);
         }
         MailUI_Write.getInstance().Clear();
         MailUI_Write.getInstance().SetReply(false);
         this.mc_base.addChild(MailUI_Write.getInstance().GetWriteMc());
      }
      
      private function btn_friendlistClick(param1:Event) : void
      {
         this.ResetSelectedBtn(this.btn_friendlist);
         if(this.mc_base.numChildren > 0)
         {
            this.mc_base.removeChildAt(0);
         }
         this.mc_base.addChild(MailUI_Friends.getInstance().GetMc());
      }
      
      private function ResetSelectedBtn(param1:HButton) : void
      {
         if(this.SelectedBtn != null)
         {
            this.SelectedBtn.setSelect(false);
         }
         this.SelectedBtn = param1;
         this.SelectedBtn.setSelect(true);
      }
      
      public function ReturnToInbox() : void
      {
         if(this.SelectedBtn == this.btn_inbox)
         {
            this.SelectedBtn = null;
         }
         this.btn_inboxClick(null);
      }
      
      public function ReturnToMail() : void
      {
         this.ResetSelectedBtn(this.btn_inbox);
         if(this.mc_base.numChildren > 0)
         {
            this.mc_base.removeChildAt(0);
         }
         this.mc_base.addChild(MailUI_Detail.getInstance().GetDetailMc());
      }
      
      public function GetDetail(param1:MSG_RESP_EMAILINFO_TEMP, param2:String, param3:String, param4:String) : void
      {
         MailUI_Detail.getInstance().Clear();
         MailUI_Detail.getInstance().GetDetail(param1,param2,param3,param4);
         if(this.mc_base.numChildren > 0)
         {
            this.mc_base.removeChildAt(0);
         }
         this.mc_base.addChild(MailUI_Detail.getInstance().GetDetailMc());
      }
      
      public function GetMc() : MovieClip
      {
         return this._mc.getMC();
      }
      
      public function DeleteMail(param1:int) : void
      {
         MailUI_Inbox.getInstance().DeleteMail2(param1);
         this.btn_inboxClick(null);
      }
      
      public function Reply(param1:MSG_RESP_EMAILINFO_TEMP, param2:String, param3:String, param4:String) : void
      {
         this.ResetSelectedBtn(this.btn_writeletter);
         if(this.mc_base.numChildren > 0)
         {
            this.mc_base.removeChildAt(0);
         }
         MailUI_Write.getInstance().SetReply(true);
         MailUI_Write.getInstance().SetReplyValue(param1,param2,param3,param4);
         this.mc_base.addChild(MailUI_Write.getInstance().GetWriteMc());
      }
      
      public function WriteMail(param1:int, param2:Boolean = true) : void
      {
         this.Init();
         this.ResetSelectedBtn(this.btn_writeletter);
         if(this.mc_base.numChildren > 0)
         {
            this.mc_base.removeChildAt(0);
         }
         MailUI_Write.getInstance().WriteMailToUser(param1);
         this.mc_base.addChild(MailUI_Write.getInstance().GetWriteMc());
         if(param2)
         {
            GameKernel.popUpDisplayManager.Show(this);
         }
      }
   }
}

