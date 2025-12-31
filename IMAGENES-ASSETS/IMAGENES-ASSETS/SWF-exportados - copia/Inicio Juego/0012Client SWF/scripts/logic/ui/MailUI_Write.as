package logic.ui
{
   import com.star.frameworks.managers.FontManager;
   import com.star.frameworks.managers.StringManager;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import logic.entry.GamePlayer;
   import logic.entry.HButton;
   import logic.game.GameKernel;
   import net.base.NetManager;
   import net.msg.mail.MSG_REQUEST_SENDEMAIL;
   import net.msg.mail.MSG_RESP_EMAILINFO_TEMP;
   
   public class MailUI_Write
   {
      
      private static var instance:MailUI_Write;
      
      private var WriteMc:MovieClip;
      
      private var mc_checkbox:HButton;
      
      private var btn_clear:HButton;
      
      private var btn_back:HButton;
      
      private var xtf_addressee:XTextField;
      
      public function MailUI_Write()
      {
         super();
         this.WriteMc = GameKernel.getMovieClipInstance("WriteletterMc",0,0,false);
         this.Init();
      }
      
      public static function getInstance() : MailUI_Write
      {
         if(instance == null)
         {
            instance = new MailUI_Write();
         }
         return instance;
      }
      
      public function GetWriteMc() : MovieClip
      {
         return this.WriteMc;
      }
      
      public function SetReply(param1:Boolean) : void
      {
         if(param1)
         {
            this.btn_clear.setVisible(false);
            this.btn_back.setVisible(true);
         }
         else
         {
            this.xtf_addressee.ResetDefaultText();
            this.btn_clear.setVisible(true);
            this.btn_back.setVisible(false);
         }
      }
      
      private function Init() : void
      {
         var _loc1_:HButton = null;
         var _loc2_:MovieClip = null;
         _loc2_ = this.WriteMc.getChildByName("btn_clear") as MovieClip;
         this.btn_clear = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_clearClick);
         _loc2_ = this.WriteMc.getChildByName("btn_back") as MovieClip;
         this.btn_back = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_backClick);
         _loc2_ = this.WriteMc.getChildByName("btn_send") as MovieClip;
         _loc1_ = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_sendClick);
         var _loc3_:Object = this.WriteMc.getChildByName("mc_input") as Object;
         _loc3_.setStyle("textFormat",FontManager.getInstance().getTextFormat("Tahoma",12,6667519));
         var _loc4_:TextField = this.WriteMc.getChildByName("tf_addressee") as TextField;
         _loc4_.restrict = "0-9";
         _loc4_.maxChars = 7;
         this.xtf_addressee = new XTextField(_loc4_,StringManager.getInstance().getMessageString("MailText45"));
         _loc4_ = this.WriteMc.getChildByName("tf_title") as TextField;
         _loc4_.maxChars = GamePlayer.getInstance().language == 0 ? 8 : 20;
      }
      
      private function btn_clearClick(param1:Event) : void
      {
         this.Clear();
      }
      
      private function btn_backClick(param1:Event) : void
      {
         MailUI.getInstance().ReturnToMail();
      }
      
      private function btn_sendClick(param1:Event) : void
      {
         var _loc2_:TextField = this.WriteMc.getChildByName("tf_title") as TextField;
         _loc2_.text = _loc2_.text.replace(" ","");
         if(_loc2_.text == "")
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("MailText48"),1);
            return;
         }
         var _loc3_:MSG_REQUEST_SENDEMAIL = new MSG_REQUEST_SENDEMAIL();
         _loc3_.Title = _loc2_.text;
         _loc2_ = this.WriteMc.getChildByName("tf_addressee") as TextField;
         _loc3_.SendGuid = int(_loc2_.text);
         if(_loc3_.SendGuid == GamePlayer.getInstance().Guid)
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("MailText50"),0);
            return;
         }
         var _loc4_:Object = this.WriteMc.getChildByName("mc_input") as Object;
         var _loc5_:String = String(_loc4_.text);
         var _loc6_:int = _loc5_.length;
         var _loc7_:int = GamePlayer.getInstance().language == 0 ? 127 : 511;
         if(_loc5_.length > _loc7_)
         {
            _loc5_ = _loc5_.substr(0,_loc7_);
         }
         _loc3_.Content = _loc5_;
         _loc3_.SeqId = GamePlayer.getInstance().seqID++;
         _loc3_.Guid = GamePlayer.getInstance().Guid;
         NetManager.Instance().sendObject(_loc3_);
         MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("MailText46"),1);
         MailUI.getInstance().ReturnToInbox();
      }
      
      private function mc_checkboxClick(param1:Event) : void
      {
         if(this.mc_checkbox.m_selsected)
         {
            this.mc_checkbox.setSelect(false);
         }
         else
         {
            this.mc_checkbox.setSelect(true);
         }
      }
      
      public function Clear() : void
      {
         var _loc1_:TextField = null;
         _loc1_ = this.WriteMc.getChildByName("tf_title") as TextField;
         _loc1_.text = "";
         _loc1_ = this.WriteMc.getChildByName("tf_addressee") as TextField;
         _loc1_.text = "";
         var _loc2_:Object = this.WriteMc.getChildByName("mc_input") as Object;
         _loc2_.text = "";
      }
      
      public function SetReplyValue(param1:MSG_RESP_EMAILINFO_TEMP, param2:String, param3:String, param4:String) : void
      {
         var _loc5_:TextField = null;
         _loc5_ = this.WriteMc.getChildByName("tf_title") as TextField;
         _loc5_.text = StringManager.getInstance().getMessageString("MailText49") + param1.Title;
         _loc5_ = this.WriteMc.getChildByName("tf_addressee") as TextField;
         _loc5_.text = param1.SrcGuid.toString();
         var _loc6_:Object = this.WriteMc.getChildByName("mc_input") as Object;
         _loc6_.text = "\n-----------------------\n" + StringManager.getInstance().getMessageString("MailText34") + param2 + "(ID:" + param1.SrcGuid + ")" + "\n" + StringManager.getInstance().getMessageString("MailText35") + param3 + "\n" + StringManager.getInstance().getMessageString("MailText36") + param1.Title + "\n " + StringManager.getInstance().getMessageString("MailText37") + "\n" + param4;
      }
      
      public function WriteMailToUser(param1:int) : void
      {
         this.SetReply(false);
         this.Clear();
         var _loc2_:TextField = this.WriteMc.getChildByName("tf_addressee") as TextField;
         _loc2_.text = param1.toString();
      }
   }
}

