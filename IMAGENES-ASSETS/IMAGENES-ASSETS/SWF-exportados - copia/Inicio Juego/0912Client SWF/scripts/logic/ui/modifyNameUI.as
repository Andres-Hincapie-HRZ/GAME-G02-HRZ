package logic.ui
{
   import com.star.frameworks.managers.StringManager;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import logic.entry.GamePlayer;
   import logic.entry.HButton;
   import logic.entry.MObject;
   import logic.game.GameKernel;
   import net.base.NetManager;
   import net.msg.MSG_REQUEST_UPDATEPLAYERNAME;
   import net.msg.MSG_RESP_UPDATEPLAYERNAME;
   
   public class modifyNameUI extends AbstractPopUp
   {
      
      private static var instance:modifyNameUI;
      
      private var BaseMc:MovieClip;
      
      private var btn_ok:HButton;
      
      private var btn_cancel:HButton;
      
      private var txt_name:TextField;
      
      private var NewName:String;
      
      public function modifyNameUI()
      {
         super();
         setPopUpName("modifyNameUI");
      }
      
      public static function getInstance() : modifyNameUI
      {
         if(instance == null)
         {
            instance = new modifyNameUI();
         }
         return instance;
      }
      
      override public function Init() : void
      {
         if(GameKernel.popUpDisplayManager.PopDisplayList.ContainsKey(getPopUpName()))
         {
            this.Clear();
            return;
         }
         this._mc = new MObject("modifymc",385,300);
         this.initMcElement();
         this.Clear();
         GameKernel.popUpDisplayManager.Regisger(instance);
      }
      
      override public function initMcElement() : void
      {
         this.BaseMc = this._mc.getMC();
         this.btn_ok = new HButton(this.BaseMc.btn_ok as MovieClip);
         this.btn_ok.m_movie.addEventListener(MouseEvent.CLICK,this.btn_okClick);
         this.btn_cancel = new HButton(this.BaseMc.btn_cancel as MovieClip);
         this.btn_cancel.m_movie.addEventListener(MouseEvent.CLICK,this.btn_cancelClick);
         this.txt_name = TextField(this.BaseMc.txt_name);
         this.txt_name.maxChars = GamePlayer.getInstance().language == 0 ? 8 : 16;
      }
      
      private function btn_cancelClick(param1:MouseEvent) : void
      {
         GameKernel.popUpDisplayManager.Hide(this);
      }
      
      private function btn_okClick(param1:MouseEvent) : void
      {
         if(this.txt_name.text == "")
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("Boss80"),0);
            return;
         }
         MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("Boss83"),2,this.ChangeName);
      }
      
      private function ChangeName() : void
      {
         var _loc1_:MSG_REQUEST_UPDATEPLAYERNAME = null;
         this.NewName = this.txt_name.text;
         _loc1_ = new MSG_REQUEST_UPDATEPLAYERNAME();
         _loc1_.Name = this.txt_name.text;
         _loc1_.SeqId = GamePlayer.getInstance().seqID++;
         _loc1_.Guid = GamePlayer.getInstance().Guid;
         NetManager.Instance().sendObject(_loc1_);
         this.txt_name.text = "";
         this.Invalid(false);
      }
      
      public function Resp_MSG_RESP_UPDATEPLAYERNAME(param1:MSG_RESP_UPDATEPLAYERNAME) : void
      {
         this.Invalid(true);
         switch(param1.ErrorCode)
         {
            case 0:
               GameKernel.popUpDisplayManager.Hide(this);
               GamePlayer.getInstance().Name = this.NewName;
               PlayerInfoUI.getInstance().UpdateUserName();
               GamePlayer.getInstance().cash = GamePlayer.getInstance().cash - 150;
               ResPlaneUI.getInstance().updateResPlane();
               break;
            case 1:
               MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("FriendText23"),0);
               break;
            case 2:
               MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("FriendText24"),0);
         }
      }
      
      private function Clear() : void
      {
         this.Invalid(true);
         this.txt_name.text = "";
      }
   }
}

