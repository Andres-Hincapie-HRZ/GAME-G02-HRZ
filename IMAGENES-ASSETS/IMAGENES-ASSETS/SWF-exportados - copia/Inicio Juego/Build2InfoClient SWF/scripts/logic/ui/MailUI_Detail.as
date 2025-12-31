package logic.ui
{
   import com.star.frameworks.events.ActionEvent;
   import com.star.frameworks.managers.FontManager;
   import com.star.frameworks.managers.StringManager;
   import com.star.frameworks.utils.HashSet;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.geom.Point;
   import flash.text.StyleSheet;
   import flash.text.TextField;
   import logic.action.ChatAction;
   import logic.action.ConstructionAction;
   import logic.entry.FBModel;
   import logic.entry.GamePlayer;
   import logic.entry.HButton;
   import logic.entry.ScienceSystem;
   import logic.entry.props.propsInfo;
   import logic.entry.shipmodel.ShipbodyInfo;
   import logic.entry.shipmodel.ShipmodelInfo;
   import logic.game.GameKernel;
   import logic.manager.InstanceManager;
   import logic.reader.CPropsReader;
   import logic.reader.CShipmodelReader;
   import logic.reader.CorpsPirateReader;
   import logic.reader.InstanceConstellationsReader;
   import logic.reader.LocusReader;
   import logic.ui.info.BleakingLineForThai;
   import logic.ui.tip.CustomTip;
   import logic.utils.UpdateResource;
   import net.base.NetManager;
   import net.msg.fightMsg.MSG_RESP_FIGHTRESULT;
   import net.msg.mail.MSG_REQUEST_EMAILGOODS;
   import net.msg.mail.MSG_REQUEST_READEMAIL;
   import net.msg.mail.MSG_RESP_EMAILGOODS;
   import net.msg.mail.MSG_RESP_EMAILINFO_TEMP;
   import net.msg.mail.MSG_RESP_READEMAIL;
   import net.msg.mail.MSG_RESP_READEMAIL_TEMP;
   import net.router.ShipmodelRouter;
   
   public class MailUI_Detail
   {
      
      private static var instance:MailUI_Detail;
      
      private var DetailMc:MovieClip;
      
      private var btn_left:HButton;
      
      private var btn_right:HButton;
      
      private var btn_allpick:HButton;
      
      private var btn_battlereport:HButton;
      
      private var _MailInfo:MSG_RESP_EMAILINFO_TEMP;
      
      private var _SendDate:String;
      
      private var _SrcUserName:String;
      
      private var MailMsg:MSG_RESP_READEMAIL;
      
      private var PageIndex:int;
      
      private var btn_writeback:HButton;
      
      private var TextareaTemp:TextField;
      
      private var ShowShareForm:Boolean = false;
      
      public function MailUI_Detail()
      {
         super();
         this.DetailMc = GameKernel.getMovieClipInstance("InboxdetailMc",0,0,false);
         this.Init();
      }
      
      public static function getInstance() : MailUI_Detail
      {
         if(instance == null)
         {
            instance = new MailUI_Detail();
         }
         return instance;
      }
      
      public function GetDetailMc() : MovieClip
      {
         return this.DetailMc;
      }
      
      private function Init() : void
      {
         var _loc1_:HButton = null;
         var _loc2_:MovieClip = null;
         var _loc8_:MovieClip = null;
         var _loc9_:TextField = null;
         var _loc10_:MovieClip = null;
         _loc2_ = this.DetailMc.getChildByName("btn_close") as MovieClip;
         _loc1_ = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_closeClick);
         var _loc3_:Object = this.DetailMc.getChildByName("mc_textarea");
         _loc3_.setStyle("textFormat",FontManager.getInstance().getTextFormat("Tahoma",12,6667519));
         this.TextareaTemp = new TextField();
         this.TextareaTemp.width = _loc3_.width;
         this.TextareaTemp.multiline = true;
         this.TextareaTemp.wordWrap = true;
         this.TextareaTemp.setTextFormat(FontManager.getInstance().getTextFormat("Tahoma",12,6667519));
         if(GamePlayer.getInstance().language == 7)
         {
            this.TextareaTemp.x = _loc3_.x;
            this.TextareaTemp.y = _loc3_.y;
            this.TextareaTemp.width = _loc3_.width;
            this.TextareaTemp.height = _loc3_.height;
            _loc3_.visible = false;
            this.DetailMc.addChildAt(this.TextareaTemp,this.DetailMc.getChildIndex(_loc3_ as DisplayObject));
         }
         _loc2_ = this.DetailMc.getChildByName("btn_delete") as MovieClip;
         _loc1_ = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_deleteClick);
         _loc2_ = this.DetailMc.getChildByName("btn_allpick") as MovieClip;
         this.btn_allpick = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_allpickClick);
         _loc2_ = this.DetailMc.getChildByName("btn_writeback") as MovieClip;
         this.btn_writeback = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_writebackClick);
         _loc2_ = this.DetailMc.getChildByName("btn_battlereport") as MovieClip;
         this.btn_battlereport = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_battlereportClick);
         var _loc4_:MovieClip = this.DetailMc.getChildByName("mc_proplist") as MovieClip;
         _loc2_ = _loc4_.getChildByName("btn_left") as MovieClip;
         this.btn_left = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_leftClick);
         _loc2_ = _loc4_.getChildByName("btn_right") as MovieClip;
         this.btn_right = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_rightClick);
         var _loc5_:int = 0;
         while(_loc5_ < 9)
         {
            _loc8_ = _loc4_.getChildByName("mc_list" + _loc5_) as MovieClip;
            _loc8_.buttonMode = true;
            _loc8_.addEventListener(MouseEvent.CLICK,this.mc_listClick);
            _loc8_.addEventListener(MouseEvent.MOUSE_OVER,this.ListMouseOver);
            _loc8_.addEventListener(MouseEvent.MOUSE_OUT,this.ListMouseOut);
            _loc9_ = _loc8_.getChildByName("tf_num") as TextField;
            _loc9_.visible = false;
            _loc10_ = _loc8_.getChildByName("mc_base") as MovieClip;
            _loc10_.mouseEnabled = false;
            _loc5_++;
         }
         TextField(this.DetailMc.tf_addresser).addEventListener(MouseEvent.CLICK,this.tf_addresserClick);
         var _loc6_:String = "a:link{text-decoration: underline;} a:hover{color:#ff0000;text-decoration: underline;} a:active{text-decoration: underline;}";
         var _loc7_:StyleSheet = new StyleSheet();
         _loc7_.parseCSS(_loc6_);
         this.DetailMc.tf_addresser.styleSheet = _loc7_;
         _loc3_.addEventListener(ActionEvent.ACTION_TEXT_LINK,this.mc_textareaClick);
      }
      
      private function mc_textareaClick(param1:TextEvent) : void
      {
         if(this._MailInfo.TitleType == 14 || this._MailInfo.SrcGuid > 0 && this._MailInfo.Type == 4 && this._MailInfo.TitleType == 0)
         {
            this.ShowPlayerInfo(this._MailInfo.SrcGuid);
         }
         else if(this._MailInfo.TitleType == 19)
         {
            ChatAction.getInstance().sendChatUserInfoMessage(-1,-1,3,-1,this._MailInfo.Name);
         }
         else
         {
            ChatAction.getInstance().sendChatUserInfoMessage(this._MailInfo.FightGalaxyId,-1,3);
         }
      }
      
      private function ListMouseOver(param1:MouseEvent) : void
      {
         var _loc4_:String = null;
         var _loc8_:propsInfo = null;
         var _loc9_:ShipmodelInfo = null;
         var _loc10_:String = null;
         var _loc2_:MovieClip = param1.target as MovieClip;
         var _loc3_:int = int(_loc2_.name.substr(7));
         _loc3_ = this.PageIndex * 9 + _loc3_;
         if(_loc3_ >= this.MailMsg.DataLen)
         {
            return;
         }
         var _loc5_:MSG_RESP_READEMAIL_TEMP = this.MailMsg.Data[_loc3_];
         var _loc6_:int = _loc5_.Num + _loc5_.LockNum;
         if(this._MailInfo.Type == 2)
         {
            _loc8_ = CPropsReader.getInstance().GetPropsInfo(_loc5_.Id);
            _loc4_ = CustomTip.GetInstance().GetStringText(StringManager.getInstance().getMessageString("MailText16"),StringManager.getInstance().getMessageString("AuctionText15"));
            _loc4_ = _loc4_ + ("\n\n" + CustomTip.GetInstance().GetStringText(StringManager.getInstance().getMessageString("MailText17"),_loc8_.Name));
            _loc4_ = _loc4_ + ("\n\n" + CustomTip.GetInstance().GetNumberText(StringManager.getInstance().getMessageString("MailText18"),_loc6_.toString()));
         }
         else if(this._MailInfo.Type == 3)
         {
            _loc9_ = ShipmodelRouter.instance.ShipModeList.Get(_loc5_.Id);
            _loc4_ = CustomTip.GetInstance().GetStringText(StringManager.getInstance().getMessageString("MailText16"),StringManager.getInstance().getMessageString("AuctionText2"));
            _loc4_ = _loc4_ + ("\n\n" + CustomTip.GetInstance().GetStringText(StringManager.getInstance().getMessageString("MailText17"),_loc9_.m_ShipName));
            _loc4_ = _loc4_ + ("\n\n" + CustomTip.GetInstance().GetNumberText(StringManager.getInstance().getMessageString("MailText18"),_loc6_.toString()));
         }
         else
         {
            _loc4_ = CustomTip.GetInstance().GetStringText(StringManager.getInstance().getMessageString("MailText16"),StringManager.getInstance().getMessageString("MailText40"));
            switch(_loc5_.Id)
            {
               case 0:
                  _loc10_ = StringManager.getInstance().getMessageString("AuctionText7");
                  break;
               case 1:
                  _loc10_ = StringManager.getInstance().getMessageString("AuctionText8");
                  break;
               case 2:
                  _loc10_ = StringManager.getInstance().getMessageString("MailText19");
                  break;
               case 3:
                  _loc10_ = StringManager.getInstance().getMessageString("MailText20");
                  break;
               case 4:
                  _loc10_ = StringManager.getInstance().getMessageString("ShipText26");
            }
            _loc4_ += "\n\n" + CustomTip.GetInstance().GetStringText(StringManager.getInstance().getMessageString("MailText17"),_loc10_);
            _loc4_ = _loc4_ + ("\n\n" + CustomTip.GetInstance().GetNumberText(StringManager.getInstance().getMessageString("MailText18"),_loc6_.toString()));
         }
         var _loc7_:Point = _loc2_.localToGlobal(new Point(50,10));
         CustomTip.GetInstance().Show(_loc4_,_loc7_);
      }
      
      private function ListMouseOut(param1:MouseEvent) : void
      {
         CustomTip.GetInstance().Hide();
      }
      
      private function mc_listClick(param1:MouseEvent) : void
      {
         var _loc6_:MSG_REQUEST_EMAILGOODS = null;
         var _loc2_:MovieClip = param1.target as MovieClip;
         var _loc3_:int = int(_loc2_.name.substr(7));
         _loc3_ = this.PageIndex * 9 + _loc3_;
         if(_loc3_ >= this.MailMsg.DataLen)
         {
            return;
         }
         var _loc4_:MSG_RESP_READEMAIL_TEMP = this.MailMsg.Data[_loc3_];
         var _loc5_:Boolean = true;
         if(this._MailInfo.Type == 2)
         {
            if(_loc4_.Id == 936)
            {
               this.AddResource(_loc4_.Id,_loc4_.Num);
            }
            else
            {
               if(_loc4_.LockNum > 0)
               {
                  if(!this.AddToPack(_loc4_.Id,_loc4_.LockNum,1))
                  {
                     _loc5_ = false;
                  }
                  else
                  {
                     _loc4_.LockNum = 0;
                  }
               }
               if(_loc4_.Num > 0)
               {
                  if(!this.AddToPack(_loc4_.Id,_loc4_.Num,0))
                  {
                     _loc5_ = false;
                  }
               }
               if(_loc5_ == false)
               {
                  MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("CommanderText12"),10);
               }
            }
         }
         else if(this._MailInfo.Type == 4)
         {
            this.AddResource(_loc4_.Id,_loc4_.Num);
         }
         if(_loc5_)
         {
            _loc6_ = new MSG_REQUEST_EMAILGOODS();
            _loc6_.AutoId = this._MailInfo.AutoId;
            _loc6_.PropsId = _loc4_.Id;
            _loc6_.SeqId = GamePlayer.getInstance().seqID++;
            _loc6_.Guid = GamePlayer.getInstance().Guid;
            NetManager.Instance().sendObject(_loc6_);
            this.MailMsg.Data.splice(_loc3_,1);
            --this.MailMsg.DataLen;
            if(this.MailMsg.DataLen <= 0)
            {
               this._MailInfo.GoodFlag = 0;
               this.btn_allpick.setVisible(false);
            }
         }
         this.ShowGood();
      }
      
      private function AddResource(param1:int, param2:int, param3:int = 0) : Boolean
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         if(param1 == 4)
         {
            GamePlayer.getInstance().coins = GamePlayer.getInstance().coins + param2;
         }
         else
         {
            if(param1 == 0)
            {
               _loc6_ = param2;
            }
            else if(param1 == 1 || param1 == 936)
            {
               _loc7_ = param2;
            }
            else if(param1 == 2)
            {
               _loc5_ = param2;
            }
            else if(param1 == 3)
            {
               _loc4_ = param2;
            }
            ConstructionAction.getInstance().addResource(_loc4_,_loc5_,_loc6_,_loc7_);
         }
         return true;
      }
      
      public function OnReceiveGoods(param1:MSG_RESP_EMAILGOODS) : void
      {
      }
      
      private function AddToPack(param1:int, param2:int, param3:int = 0) : Boolean
      {
         return UpdateResource.getInstance().AddToPack(param1,param2,param3);
      }
      
      private function tf_addresserClick(param1:MouseEvent) : void
      {
         this.ShowPlayerInfo(this._MailInfo.SrcGuid);
      }
      
      private function ShowPlayerInfo(param1:int) : void
      {
         if(param1 <= 0)
         {
            return;
         }
         if(this.btn_writeback.m_movie.visible == false && this._MailInfo.TitleType != 14)
         {
            return;
         }
         ChatAction.getInstance().sendChatUserInfoMessage(-1,param1,3);
      }
      
      public function GetDetail(param1:MSG_RESP_EMAILINFO_TEMP, param2:String, param3:String, param4:String) : void
      {
         var _loc7_:TextField = null;
         var _loc9_:MovieClip = null;
         this.MailMsg = null;
         var _loc5_:MovieClip = this.DetailMc.getChildByName("mc_proplist") as MovieClip;
         var _loc6_:int = 0;
         while(_loc6_ < 9)
         {
            _loc9_ = _loc5_.getChildByName("mc_list" + _loc6_) as MovieClip;
            _loc9_.visible = false;
            _loc6_++;
         }
         this._SrcUserName = param2;
         this.ShowShareForm = false;
         this._SendDate = param3;
         this._MailInfo = param1;
         this.ShowShare();
         _loc7_ = this.DetailMc.getChildByName("tf_time") as TextField;
         _loc7_.text = param3;
         _loc7_ = this.DetailMc.getChildByName("tf_title") as TextField;
         _loc7_.text = param1.Title;
         _loc7_ = this.DetailMc.getChildByName("tf_addresser") as TextField;
         _loc7_.text = "<a href=\'event:\'>" + param4 + "</a>";
         if(param1.Type == 1 || param1.Type == 5 || param1.Type == 6 || param1.SrcGuid < 0 || param1.TitleType >= 4)
         {
            this.btn_writeback.setVisible(false);
         }
         else
         {
            this.btn_writeback.setVisible(true);
         }
         var _loc8_:Object = this.DetailMc.getChildByName("mc_textarea");
         this._MailInfo.ReadFlag = 1;
         this.btn_allpick.setVisible(false);
         if(param1.TitleType == 14)
         {
            this.RequestDetail(this._MailInfo.AutoId,2);
            this.MailMsg = null;
            _loc8_.htmlText = this.GetMatchReport();
            this.ResetTextareaForThai();
            _loc5_.visible = false;
            this.btn_battlereport.setVisible(true);
         }
         else if(param1.Type != 1)
         {
            this.RequestDetail(this._MailInfo.AutoId);
            this.btn_battlereport.setVisible(false);
         }
         else
         {
            this.RequestDetail(this._MailInfo.AutoId,2);
            this.MailMsg = null;
            _loc8_.htmlText = this.GetFightReport();
            this.ResetTextareaForThai();
            _loc5_.visible = false;
            this.btn_battlereport.setVisible(true);
         }
      }
      
      private function ResetTextareaForThai() : void
      {
         if(GamePlayer.getInstance().language != 7 && GamePlayer.getInstance().language != 10)
         {
            return;
         }
         var _loc1_:Object = this.DetailMc.getChildByName("mc_textarea");
         this.TextareaTemp.htmlText = _loc1_.htmlText;
         BleakingLineForThai.GetInstance().BleakThaiLanguage(this.TextareaTemp,6667519);
         _loc1_.htmlText = this.TextareaTemp.htmlText;
      }
      
      private function GetFightReport() : String
      {
         var _loc1_:int = this._MailInfo.FightGalaxyId / 420;
         var _loc2_:int = this._MailInfo.FightGalaxyId % 420;
         var _loc3_:String = StringManager.getInstance().getMessageString("MailText21");
         _loc3_ = _loc3_.replace("@@1",this._SrcUserName + "(" + _loc1_ + "," + _loc2_ + ")");
         return _loc3_.replace("@@2",this._SendDate);
      }
      
      private function GetMatchReport() : String
      {
         var _loc1_:String = StringManager.getInstance().getMessageString("MailText63");
         _loc1_ = _loc1_.replace("@@1",this._MailInfo.Name);
         _loc1_ = _loc1_.replace("@@2",this._MailInfo.SrcGuid);
         if(this._MailInfo.SrcUserid == 2)
         {
            _loc1_ += StringManager.getInstance().getMessageString("MailText66");
         }
         else if(this._MailInfo.SrcUserid == 1)
         {
            _loc1_ += StringManager.getInstance().getMessageString("MailText64");
         }
         else
         {
            _loc1_ += StringManager.getInstance().getMessageString("MailText65");
         }
         return _loc1_;
      }
      
      private function RequestDetail(param1:int, param2:int = 0) : void
      {
         var _loc3_:MSG_REQUEST_READEMAIL = new MSG_REQUEST_READEMAIL();
         _loc3_.AutoId = param1;
         _loc3_.SeqId = GamePlayer.getInstance().seqID++;
         _loc3_.Guid = GamePlayer.getInstance().Guid;
         _loc3_.FightFlag = param2;
         NetManager.Instance().sendObject(_loc3_);
      }
      
      public function OnGetDetail(param1:MSG_RESP_READEMAIL) : void
      {
         if(this._MailInfo.AutoId != param1.AutoId)
         {
            return;
         }
         this.MailMsg = param1;
         var _loc2_:Object = this.DetailMc.getChildByName("mc_textarea");
         _loc2_.htmlText = this.GetMailContent(param1.Content);
         this.ResetTextareaForThai();
         var _loc3_:MovieClip = this.DetailMc.getChildByName("mc_proplist") as MovieClip;
         if(param1.DataLen > 0)
         {
            this.PageIndex = 0;
            _loc3_.visible = true;
            this.btn_allpick.setVisible(true);
            this.ShowGood();
         }
         else
         {
            this.btn_allpick.setVisible(false);
            _loc3_.visible = false;
         }
      }
      
      private function ShowShare() : void
      {
         if(this._MailInfo == null)
         {
            return;
         }
         if(GameKernel.ForFB == 1 || GameKernel.ForRenRen == 1)
         {
            return;
         }
         if((this._MailInfo.TitleType == 14 || this._MailInfo.Type == 1) && this._MailInfo.ReadFlag == 0)
         {
            this.ShowShareForm = true;
            this.btn_battlereportClick(null);
         }
         else if(this._MailInfo.TitleType == 10 && this._MailInfo.ReadFlag == 0)
         {
            EnjoyUi.getInstance().PublishMessage(StringManager.getInstance().getMessageString("EmailText34"),StringManager.getInstance().getMessageString("EmailText40"),StringManager.getInstance().getMessageString("EmailText41"),"PiratesChallenge",StringManager.getInstance().getMessageString("Boss7"));
         }
         else if(this._MailInfo.TitleType == 9 && this._MailInfo.ReadFlag == 0)
         {
            EnjoyUi.getInstance().PublishMessage(StringManager.getInstance().getMessageString("EmailText31"),StringManager.getInstance().getMessageString("EmailText15"),StringManager.getInstance().getMessageString("EmailText16"),"NoviceSpree",StringManager.getInstance().getMessageString("Boss10"));
         }
      }
      
      public function OnShowShare(param1:MSG_RESP_FIGHTRESULT) : void
      {
         this.btn_battlereport.setBtnDisabled(false);
         if(this._MailInfo == null)
         {
            return;
         }
         if(this._MailInfo.TitleType == 14 && this.ShowShareForm)
         {
            this.ShowShareForm = false;
            EnjoyUi.getInstance().ShowBattleReport(this._MailInfo.Name,param1);
         }
         else if(this._MailInfo.Type == 1 && this.ShowShareForm)
         {
            this.ShowShareForm = false;
            EnjoyUi.getInstance().ShowBattleReport2(this._SrcUserName,param1);
         }
      }
      
      private function GetMailContent(param1:String) : String
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:FBModel = null;
         var _loc6_:HashSet = null;
         var _loc7_:int = 0;
         var _loc8_:Array = null;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         var _loc15_:XML = null;
         var _loc16_:XML = null;
         var _loc17_:XML = null;
         var _loc18_:int = 0;
         var _loc19_:int = 0;
         var _loc20_:Array = null;
         var _loc21_:int = 0;
         var _loc22_:int = 0;
         var _loc23_:int = 0;
         var _loc24_:String = null;
         var _loc25_:int = 0;
         var _loc26_:String = null;
         var _loc27_:int = 0;
         var _loc28_:propsInfo = null;
         var _loc29_:ShipmodelInfo = null;
         var _loc30_:ShipbodyInfo = null;
         var _loc31_:String = null;
         var _loc32_:MSG_RESP_READEMAIL_TEMP = null;
         var _loc2_:String = "";
         if(this._MailInfo.TitleType < 0)
         {
            return param1;
         }
         if(this._MailInfo.TitleType == 4)
         {
            _loc3_ = this._MailInfo.FightGalaxyId / 420;
            _loc4_ = this._MailInfo.FightGalaxyId % 420;
            _loc2_ = StringManager.getInstance().getMessageString("MailText22");
            _loc2_ = _loc2_.replace("@@1",this._SrcUserName);
            _loc2_ = _loc2_.replace("@@2","(" + _loc3_ + "," + _loc4_ + ")");
         }
         else if(this._MailInfo.TitleType == 5)
         {
            _loc2_ = StringManager.getInstance().getMessageString("MailText42");
         }
         else if(this._MailInfo.TitleType == 6 || this._MailInfo.TitleType == 10)
         {
            _loc2_ = StringManager.getInstance().getMessageString("MailText43");
            if(this._MailInfo.TitleType == 6)
            {
               _loc5_ = InstanceManager.instance.getFBModelByEctype(this._MailInfo.SrcGuid);
            }
            else if(this._MailInfo.TitleType == 10)
            {
               _loc6_ = InstanceManager.instance.challengeDataList;
               _loc7_ = 0;
               while(_loc7_ < _loc6_.Length())
               {
                  _loc5_ = _loc6_.Values()[_loc7_];
                  if(_loc5_.EctypeID == this._MailInfo.SrcGuid)
                  {
                     break;
                  }
                  _loc5_ = null;
                  _loc7_++;
               }
            }
            if(_loc5_ != null)
            {
               _loc2_ = _loc2_.replace("@@1",_loc5_.Name);
            }
            else
            {
               _loc2_ = _loc2_.replace("@@1",this._MailInfo.SrcGuid);
            }
         }
         else if(this._MailInfo.TitleType == 9)
         {
            _loc2_ = StringManager.getInstance().getMessageString("EmailText1");
         }
         else if(this._MailInfo.TitleType == 11)
         {
            _loc2_ = StringManager.getInstance().getMessageString("MailText59");
         }
         else if(this._MailInfo.TitleType == 12)
         {
            _loc8_ = param1.split(",");
            _loc2_ = StringManager.getInstance().getMessageString("MailText61");
            _loc9_ = int(_loc8_[1]);
            _loc10_ = int(_loc8_[2]);
            _loc11_ = int(_loc8_[3]);
            _loc12_ = int(_loc8_[4]);
            _loc13_ = _loc10_ * 3 + _loc11_ + _loc12_;
            _loc14_ = int(Number(_loc10_) / Number(_loc10_ + _loc11_ + _loc12_) * 100);
            _loc2_ = _loc2_.replace("@@1",_loc10_);
            _loc2_ = _loc2_.replace("@@2",_loc11_);
            _loc2_ = _loc2_.replace("@@3",_loc12_);
            _loc2_ = _loc2_.replace("@@4",_loc13_);
            _loc2_ = _loc2_.replace("@@5",_loc14_);
            _loc2_ = _loc2_.replace("@@6",_loc9_ + 1);
         }
         else if(this._MailInfo.TitleType == 13)
         {
            _loc2_ = StringManager.getInstance().getMessageString("VIP2");
         }
         else if(this._MailInfo.TitleType == 14)
         {
            _loc2_ = this.GetMatchReport();
         }
         else if(this._MailInfo.TitleType == 15)
         {
            _loc2_ = StringManager.getInstance().getMessageString("Pirate13");
            _loc15_ = CorpsPirateReader.GetPirateInfo(this._MailInfo.SrcGuid);
            _loc2_ = _loc2_.replace("@@1","Lv." + int(this._MailInfo.SrcGuid + 1) + _loc15_.@Name);
         }
         else if(this._MailInfo.TitleType == 16)
         {
            _loc2_ = StringManager.getInstance().getMessageString("Boss17");
            _loc16_ = LocusReader.getInstance().GetLocusInfoById(this._MailInfo.SrcGuid);
            if(_loc16_)
            {
               _loc2_ = _loc2_.replace("@@1",_loc16_.@Name);
            }
         }
         else if(this._MailInfo.TitleType == 17)
         {
            _loc2_ = StringManager.getInstance().getMessageString("Boss38");
            _loc17_ = InstanceConstellationsReader.getInstance().GetStarInfoByEctypeId(this._MailInfo.SrcGuid);
            if(_loc17_)
            {
               _loc2_ = _loc2_.replace("@@1",_loc17_.@Name);
            }
         }
         else if(this._MailInfo.TitleType == 18)
         {
            _loc18_ = this._MailInfo.FightGalaxyId / 420;
            _loc19_ = this._MailInfo.FightGalaxyId % 420;
            _loc2_ = StringManager.getInstance().getMessageString("MailText22");
            _loc2_ = _loc2_.replace("@@1",StringManager.getInstance().getMessageString("Boss46"));
            _loc2_ = _loc2_.replace("@@2","(" + _loc18_ + "," + _loc19_ + ")");
         }
         else if(this._MailInfo.TitleType == 19)
         {
            if(this._MailInfo.SrcGuid == -1)
            {
               _loc2_ = StringManager.getInstance().getMessageString("Boss138");
            }
            else if(this._MailInfo.SrcGuid == 0)
            {
               _loc2_ = StringManager.getInstance().getMessageString("Boss142");
               _loc2_ = _loc2_.replace("@@1","<font color=\'#FF3300\'><a href=\'event:\'>" + this._MailInfo.Name + "</a></font>");
            }
            else if(this._MailInfo.SrcGuid == 1)
            {
               _loc2_ = StringManager.getInstance().getMessageString("Boss140");
            }
         }
         else if(this._MailInfo.TitleType == 20)
         {
            _loc2_ = StringManager.getInstance().getMessageString("Boss150");
            _loc2_ = _loc2_.replace("@@1","<a href=\'" + GamePlayer.getInstance().MvpUrl + "\'>" + GamePlayer.getInstance().MvpUrl + "</a>");
            _loc2_ = _loc2_.replace("@@2","<a href=\'" + GamePlayer.getInstance().HDUrl + "\'>" + GamePlayer.getInstance().HDUrl + "</a>");
         }
         else if(this._MailInfo.TitleType == 21)
         {
            if(this._MailInfo.SrcGuid == 1)
            {
               _loc2_ = StringManager.getInstance().getMessageString("Boss158");
            }
            else
            {
               _loc2_ = StringManager.getInstance().getMessageString("Boss168");
               _loc8_ = param1.split(",");
               _loc2_ = _loc2_.replace("@@1",_loc8_[2]);
               _loc2_ = _loc2_.replace("@@2",_loc8_[1]);
            }
         }
         else if(this._MailInfo.TitleType == 22)
         {
            if(this._MailInfo.SrcGuid == 1)
            {
               _loc2_ = StringManager.getInstance().getMessageString("Boss178");
            }
            else
            {
               _loc2_ = StringManager.getInstance().getMessageString("Boss179");
            }
         }
         else
         {
            _loc20_ = param1.split(",");
            _loc21_ = int(_loc20_[1]);
            _loc22_ = int(_loc20_[2]);
            _loc23_ = int(_loc20_[3]);
            if(this._MailInfo.TitleType <= 1)
            {
               _loc27_ = int(_loc20_[4]);
               _loc24_ = _loc27_ == 0 ? StringManager.getInstance().getMessageString("AuctionText7") : StringManager.getInstance().getMessageString("AuctionText8");
               _loc25_ = int(_loc20_[5]);
            }
            if(_loc21_ == 1)
            {
               _loc28_ = CPropsReader.getInstance().GetPropsInfo(_loc22_);
               _loc26_ = _loc28_.Name;
            }
            else
            {
               _loc29_ = ShipmodelRouter.instance.ShipModeList.Get(_loc22_);
               if(_loc29_ != null)
               {
                  _loc30_ = CShipmodelReader.getInstance().getShipBodyInfo(_loc29_.m_BodyId);
                  _loc26_ = _loc30_.Name + "-" + _loc29_.m_ShipName;
               }
               else
               {
                  _loc26_ = _loc22_.toString();
               }
            }
            switch(this._MailInfo.TitleType)
            {
               case 0:
                  _loc2_ = StringManager.getInstance().getMessageString("MailText23");
                  _loc2_ = _loc2_.replace("@@1",_loc26_);
                  _loc2_ = _loc2_.replace("@@2",_loc23_.toString());
                  _loc2_ = _loc2_.replace("@@3",_loc25_.toString());
                  _loc2_ = _loc2_.replace("@@4",_loc24_);
                  if(this._MailInfo.SrcGuid != -1)
                  {
                     _loc31_ = StringManager.getInstance().getMessageString("Boss120");
                     _loc31_ = _loc31_.replace("@@1",this._MailInfo.SrcGuid);
                     _loc31_ = _loc31_.replace("@@2","<a href=\'event:\'>" + this._MailInfo.Name + "</a>");
                     _loc2_ += "\n" + _loc31_;
                  }
                  break;
               case 1:
                  _loc2_ = StringManager.getInstance().getMessageString("MailText24");
                  _loc2_ = _loc2_.replace("@@1",_loc25_.toString());
                  _loc2_ = _loc2_.replace("@@2",_loc24_);
                  _loc2_ = _loc2_.replace("@@3",_loc26_);
                  _loc2_ = _loc2_.replace("@@4",_loc23_.toString());
                  break;
               case 2:
                  _loc2_ = StringManager.getInstance().getMessageString("MailText25");
                  _loc2_ = _loc2_.replace("@@1",_loc26_);
                  _loc2_ = _loc2_.replace("@@2",_loc23_.toString());
                  break;
               case 3:
                  _loc2_ = StringManager.getInstance().getMessageString("MailText26");
                  _loc2_ = _loc2_.replace("@@1",_loc26_);
                  _loc2_ = _loc2_.replace("@@2",_loc23_.toString());
                  break;
               case 7:
                  if(this.MailMsg.DataLen > 0)
                  {
                     _loc32_ = this.MailMsg.Data[0];
                     if(_loc32_.Id == 936)
                     {
                        _loc2_ = StringManager.getInstance().getMessageString("VIP4");
                     }
                  }
            }
         }
         return _loc2_;
      }
      
      private function ShowGood() : void
      {
         var _loc4_:MovieClip = null;
         var _loc5_:MovieClip = null;
         var _loc6_:MSG_RESP_READEMAIL_TEMP = null;
         var _loc7_:TextField = null;
         var _loc8_:propsInfo = null;
         var _loc9_:Bitmap = null;
         var _loc10_:ShipmodelInfo = null;
         var _loc11_:ShipbodyInfo = null;
         var _loc12_:Bitmap = null;
         var _loc13_:Bitmap = null;
         var _loc1_:MovieClip = this.DetailMc.getChildByName("mc_proplist") as MovieClip;
         var _loc2_:int = this.PageIndex * 9;
         var _loc3_:int = 0;
         while(_loc3_ < 9)
         {
            _loc4_ = _loc1_.getChildByName("mc_list" + _loc3_) as MovieClip;
            if(_loc2_ < this.MailMsg.DataLen)
            {
               _loc5_ = _loc4_.getChildByName("mc_base") as MovieClip;
               _loc4_.visible = true;
               if(_loc5_.numChildren > 0)
               {
                  _loc5_.removeChildAt(0);
               }
               _loc6_ = this.MailMsg.Data[_loc2_];
               if(this._MailInfo.Type == 2)
               {
                  _loc8_ = CPropsReader.getInstance().GetPropsInfo(_loc6_.Id);
                  if(_loc8_ != null)
                  {
                     _loc9_ = new Bitmap(GameKernel.getTextureInstance(_loc8_.ImageFileName));
                     _loc5_.addChild(_loc9_);
                  }
               }
               else if(this._MailInfo.Type == 3)
               {
                  _loc10_ = ShipmodelRouter.instance.ShipModeList.Get(_loc6_.Id);
                  _loc11_ = CShipmodelReader.getInstance().getShipBodyInfo(_loc10_.m_BodyId);
                  _loc12_ = new Bitmap(GameKernel.getTextureInstance(_loc11_.SmallIcon));
                  _loc12_.smoothing = true;
                  _loc12_.x = -2;
                  _loc12_.width = 43;
                  _loc12_.height = 43;
                  _loc5_.addChild(_loc12_);
               }
               else
               {
                  switch(_loc6_.Id)
                  {
                     case 0:
                        _loc13_ = new Bitmap(GameKernel.getTextureInstance("BattleGold"));
                        break;
                     case 1:
                        _loc13_ = new Bitmap(GameKernel.getTextureInstance("BattleCash"));
                        break;
                     case 2:
                        _loc13_ = new Bitmap(GameKernel.getTextureInstance("BattleMetal"));
                        break;
                     case 3:
                        _loc13_ = new Bitmap(GameKernel.getTextureInstance("BattleHe3"));
                        break;
                     case 4:
                        _loc13_ = new Bitmap(GameKernel.getTextureInstance("Giftmoney2"));
                  }
                  _loc5_.addChild(_loc13_);
               }
               _loc7_ = _loc4_.getChildByName("tf_num") as TextField;
               _loc7_.text = (_loc6_.Num + _loc6_.LockNum).toString();
               _loc2_++;
            }
            else
            {
               _loc4_.visible = false;
            }
            _loc3_++;
         }
         this.ResetPageButton();
      }
      
      public function Clear() : void
      {
         var _loc1_:TextField = null;
         _loc1_ = this.DetailMc.getChildByName("tf_title") as TextField;
         _loc1_.text = "";
         _loc1_ = this.DetailMc.getChildByName("tf_addresser") as TextField;
         _loc1_.text = "";
         _loc1_ = this.DetailMc.getChildByName("tf_time") as TextField;
         _loc1_.text = "";
         var _loc2_:Object = this.DetailMc.getChildByName("mc_textarea");
         _loc2_.htmlText = "";
      }
      
      private function btn_deleteClick(param1:Event) : void
      {
         MailUI.getInstance().DeleteMail(this._MailInfo.AutoId);
      }
      
      private function CheckPackSpace() : Boolean
      {
         var _loc4_:MSG_RESP_READEMAIL_TEMP = null;
         var _loc5_:int = 0;
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         while(_loc2_ < this.MailMsg.DataLen)
         {
            _loc4_ = this.MailMsg.Data[_loc2_];
            if(_loc4_.LockNum > 0)
            {
               _loc1_++;
            }
            if(_loc4_.Num > 0)
            {
               _loc1_++;
            }
            _loc5_ = 0;
            while(_loc5_ < ScienceSystem.getinstance().Packarr.length)
            {
               if(ScienceSystem.getinstance().Packarr[_loc5_].PropsId == _loc4_.Id)
               {
                  if(_loc4_.LockNum > 0 && ScienceSystem.getinstance().Packarr[_loc5_].LockFlag == 1)
                  {
                     _loc1_--;
                  }
                  if(_loc4_.Num > 0 && ScienceSystem.getinstance().Packarr[_loc5_].LockFlag == 0)
                  {
                     _loc1_--;
                  }
               }
               _loc5_++;
            }
            _loc2_++;
         }
         var _loc3_:int = GamePlayer.getInstance().PropsPack - ScienceSystem.getinstance().Packarr.length;
         return _loc1_ <= _loc3_;
      }
      
      private function btn_allpickClick(param1:Event) : void
      {
         var _loc4_:int = 0;
         var _loc5_:MSG_RESP_READEMAIL_TEMP = null;
         var _loc2_:Function = null;
         if(this._MailInfo.Type == 2)
         {
            _loc2_ = this.AddToPack;
            if(!this.CheckPackSpace())
            {
               MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("CommanderText12"),10);
               return;
            }
         }
         else if(this._MailInfo.Type == 4)
         {
            _loc2_ = this.AddResource;
         }
         if(_loc2_ != null)
         {
            _loc4_ = 0;
            while(_loc4_ < this.MailMsg.DataLen)
            {
               _loc5_ = this.MailMsg.Data[_loc4_];
               if(_loc5_.Id == 936)
               {
                  this.AddResource(_loc5_.Id,_loc5_.Num);
               }
               else
               {
                  if(_loc5_.LockNum > 0)
                  {
                     this.AddToPack(_loc5_.Id,_loc5_.LockNum,1);
                  }
                  if(_loc5_.Num > 0)
                  {
                     _loc2_(_loc5_.Id,_loc5_.Num);
                  }
               }
               _loc4_++;
            }
         }
         this._MailInfo.GoodFlag = 0;
         this.MailMsg.DataLen = 0;
         this.PageIndex = 0;
         this.ShowGood();
         var _loc3_:MSG_REQUEST_EMAILGOODS = new MSG_REQUEST_EMAILGOODS();
         _loc3_.AutoId = this._MailInfo.AutoId;
         _loc3_.PropsId = -1;
         _loc3_.SeqId = GamePlayer.getInstance().seqID++;
         _loc3_.Guid = GamePlayer.getInstance().Guid;
         NetManager.Instance().sendObject(_loc3_);
      }
      
      private function btn_writebackClick(param1:Event) : void
      {
         MailUI.getInstance().Reply(this._MailInfo,this._SrcUserName,this._SendDate,this.MailMsg.Content);
      }
      
      private function btn_battlereportClick(param1:Event) : void
      {
         this.btn_battlereport.setBtnDisabled(true);
         this.RequestDetail(this._MailInfo.AutoId,1);
      }
      
      private function btn_videoClick(param1:Event) : void
      {
      }
      
      private function btn_leftClick(param1:Event) : void
      {
         if(this.MailMsg == null)
         {
            return;
         }
         --this.PageIndex;
         this.ShowGood();
      }
      
      private function btn_rightClick(param1:Event) : void
      {
         if(this.MailMsg == null)
         {
            return;
         }
         ++this.PageIndex;
         this.ShowGood();
      }
      
      private function ResetPageButton() : void
      {
         if(this.PageIndex == 0)
         {
            this.btn_left.setBtnDisabled(true);
         }
         else
         {
            this.btn_left.setBtnDisabled(false);
         }
         if((this.PageIndex + 1) * 9 >= this.MailMsg.DataLen)
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
         MailUI.getInstance().ReturnToInbox();
      }
   }
}

