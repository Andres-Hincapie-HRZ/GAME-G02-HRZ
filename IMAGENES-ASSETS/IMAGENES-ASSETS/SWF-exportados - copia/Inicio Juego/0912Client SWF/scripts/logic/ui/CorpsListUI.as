package logic.ui
{
   import com.star.frameworks.facebook.FacebookUserInfo;
   import com.star.frameworks.managers.StringManager;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.StyleSheet;
   import flash.text.TextField;
   import logic.action.ChatAction;
   import logic.entry.GamePlayer;
   import logic.entry.HButton;
   import logic.entry.HButtonType;
   import logic.entry.MObject;
   import logic.game.GameKernel;
   import net.base.NetManager;
   import net.msg.corpsMsg.MSG_REQUEST_CONSORTIADELMEMBER;
   import net.msg.corpsMsg.MSG_REQUEST_CONSORTIAINFO;
   import net.msg.corpsMsg.MSG_REQUEST_CONSORTIAPROCLAIM;
   import net.msg.corpsMsg.MSG_REQUEST_JOINCONSORTIA;
   import net.msg.corpsMsg.MSG_RESP_CONSORTIAINFO;
   import net.msg.corpsMsg.MSG_RESP_CONSORTIAINFO_TEMP;
   import net.msg.corpsMsg.MSG_RESP_CONSORTIAPROCLAIM;
   
   public class CorpsListUI extends AbstractPopUp
   {
      
      private static var instance:CorpsListUI;
      
      private var LeftBtn:HButton;
      
      private var RightBtn:HButton;
      
      private var tf_page:TextField;
      
      private var mc_corpsbase:MovieClip;
      
      private var tf_corpscommander:TextField;
      
      private var tf_grade:TextField;
      
      private var tf_corpsmember:TextField;
      
      private var tf_corpsranking:TextField;
      
      private var tf_corpsintro:TextField;
      
      private var tf_search:TextField;
      
      private var tf_corpsname:TextField;
      
      private var CurPage:int;
      
      private const RowCount:int = 11;
      
      private const mc_planbarLen:int = 98;
      
      private var PageCount:int;
      
      private var SelectedCorpsId:int;
      
      private var SelectedUserId:Number;
      
      private var SelectedCorpsName:String;
      
      private var SelectedRow:MovieClip;
      
      private var CorpsList:Array;
      
      private var btn_enter:HButton;
      
      private var btn_found:HButton;
      
      private var btn_mycorps:HButton;
      
      private var btn_leavecorps:HButton;
      
      private var btn_disbandcorps:HButton;
      
      private var CorpsInfoMsg:MSG_RESP_CONSORTIAPROCLAIM;
      
      public function CorpsListUI()
      {
         super();
         setPopUpName("CorpsListUI");
      }
      
      public static function getInstance() : CorpsListUI
      {
         if(instance == null)
         {
            instance = new CorpsListUI();
         }
         return instance;
      }
      
      override public function Init() : void
      {
         if(GameKernel.popUpDisplayManager.PopDisplayList.ContainsKey(getPopUpName()))
         {
            if(this.SelectedRow != null)
            {
               this.SelectedRow.gotoAndStop("up");
            }
            this.Clear();
            this.RequestCorpsList();
            return;
         }
         this._mc = new MObject("CorpsScene",379,300);
         this.initMcElement();
         this.Clear();
         GameKernel.popUpDisplayManager.Regisger(instance);
         this.RequestCorpsList();
      }
      
      override public function initMcElement() : void
      {
         var _loc1_:HButton = null;
         var _loc2_:MovieClip = null;
         _loc2_ = this._mc.getMC().getChildByName("btn_close") as MovieClip;
         _loc1_ = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.CloseClick);
         _loc2_ = this._mc.getMC().getChildByName("btn_corpssearch") as MovieClip;
         _loc1_ = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_corpssearchClick);
         _loc2_ = this._mc.getMC().getChildByName("btn_applycorps") as MovieClip;
         this.btn_enter = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_enterClick);
         this.btn_enter.setBtnDisabled(true);
         _loc2_ = this._mc.getMC().getChildByName("btn_foundcorps") as MovieClip;
         this.btn_found = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_foundClick);
         _loc2_ = this._mc.getMC().getChildByName("btn_mycorps") as MovieClip;
         this.btn_mycorps = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_mycorpsClick);
         _loc2_ = this._mc.getMC().getChildByName("btn_leavecorps") as MovieClip;
         this.btn_leavecorps = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_leavecorpsClick);
         _loc2_ = this._mc.getMC().getChildByName("btn_disbandcorps") as MovieClip;
         this.btn_disbandcorps = new HButton(_loc2_);
         this.btn_disbandcorps.setBtnDisabled(true);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_disbandcorpsClick);
         _loc2_ = this._mc.getMC().getChildByName("btn_left") as MovieClip;
         this.LeftBtn = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_leftClick);
         _loc2_ = this._mc.getMC().getChildByName("btn_right") as MovieClip;
         this.RightBtn = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_rightClick);
         this.tf_page = this._mc.getMC().getChildByName("tf_page") as TextField;
         this.mc_corpsbase = this._mc.getMC().getChildByName("mc_corpsbase") as MovieClip;
         this.tf_corpscommander = this._mc.getMC().getChildByName("tf_corpscommander") as TextField;
         this.tf_grade = this._mc.getMC().getChildByName("tf_grade") as TextField;
         this.tf_corpsmember = this._mc.getMC().getChildByName("tf_corpsmember") as TextField;
         this.tf_corpsname = this._mc.getMC().getChildByName("tf_corpsname") as TextField;
         this.tf_corpsranking = this._mc.getMC().getChildByName("tf_corpsranking") as TextField;
         this.tf_corpsintro = this._mc.getMC().getChildByName("tf_corpsintro") as TextField;
         this.tf_search = this._mc.getMC().getChildByName("tf_search") as TextField;
         var _loc3_:String = "a:link{text-decoration: underline;} a:hover{color:#ff0000;text-decoration: underline;} a:active{text-decoration: underline;}";
         var _loc4_:StyleSheet = new StyleSheet();
         _loc4_.parseCSS(_loc3_);
         this.tf_corpscommander.styleSheet = _loc4_;
         this.tf_corpscommander.addEventListener(MouseEvent.CLICK,this.tf_corpscommanderClick);
         this.tf_corpsname.styleSheet = _loc4_;
         this.tf_corpsname.addEventListener(MouseEvent.CLICK,this.tf_corpsnameClick);
         this.InitList();
      }
      
      public function ResetShow() : void
      {
         this.Clear();
         this.RequestCorpsList();
         this.ResetButton();
      }
      
      private function Clear() : void
      {
         this.SelectedCorpsId = -1;
         this.SelectedRow = null;
         this.CurPage = 0;
         this.LeftBtn.setBtnDisabled(true);
         this.RightBtn.setBtnDisabled(true);
         this.tf_page.text = "";
         if(this.mc_corpsbase.numChildren > 0)
         {
            this.mc_corpsbase.removeChildAt(0);
         }
         this.tf_corpscommander.text = "";
         this.tf_corpsmember.text = "";
         this.tf_corpsranking.text = "";
         this.tf_corpsintro.text = "";
         this.tf_search.text = "";
         this.tf_corpsname.text = "";
         this.tf_grade.text = "";
         this.ResetButton();
      }
      
      private function InitList() : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:MovieClip = null;
         var _loc4_:HButton = null;
         var _loc1_:int = 0;
         while(_loc1_ < this.RowCount)
         {
            _loc2_ = this._mc.getMC().getChildByName("mc_list" + _loc1_) as MovieClip;
            _loc2_.mouseChildren = false;
            _loc2_.addEventListener(MouseEvent.CLICK,this.RowClick);
            _loc3_ = GameKernel.getMovieClipInstance("CorpsnamePlan",0,0,false);
            _loc4_ = new HButton(_loc3_,HButtonType.SELECT);
            _loc3_.name = "CorpsnamePlan";
            _loc2_.addChild(_loc3_);
            _loc2_.visible = false;
            _loc1_++;
         }
      }
      
      private function CloseClick(param1:Event) : void
      {
         this.Close();
      }
      
      public function Close(param1:Boolean = true) : void
      {
         GameKernel.popUpDisplayManager.Hide(this);
      }
      
      private function btn_corpssearchClick(param1:Event) : void
      {
      }
      
      private function btn_enterClick(param1:Event) : void
      {
         if(this.SelectedCorpsId == -1)
         {
            return;
         }
         var _loc2_:MSG_REQUEST_JOINCONSORTIA = new MSG_REQUEST_JOINCONSORTIA();
         _loc2_.ConsortiaId = this.SelectedCorpsId;
         _loc2_.SeqId = GamePlayer.getInstance().seqID++;
         _loc2_.Guid = GamePlayer.getInstance().Guid;
         NetManager.Instance().sendObject(_loc2_);
         GameKernel.popUpDisplayManager.Hide(this);
      }
      
      private function btn_foundClick(param1:Event) : void
      {
         CreateCorpsUI.getInstance().Show();
      }
      
      private function btn_mycorpsClick(param1:Event) : void
      {
         this.Close();
         MyCorpsUI.getInstance().Show();
      }
      
      private function btn_leavecorpsClick(param1:Event) : void
      {
         MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("CorpsText71"),2,this.DeleteCorps);
      }
      
      private function btn_disbandcorpsClick(param1:Event) : void
      {
         MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("CorpsText45"),2,this.DeleteCorps);
      }
      
      private function DeleteCorps() : void
      {
         var _loc1_:MSG_REQUEST_CONSORTIADELMEMBER = new MSG_REQUEST_CONSORTIADELMEMBER();
         _loc1_.DelGuid = GamePlayer.getInstance().Guid;
         _loc1_.SeqId = GamePlayer.getInstance().seqID++;
         _loc1_.Guid = GamePlayer.getInstance().Guid;
         NetManager.Instance().sendObject(_loc1_);
         GamePlayer.getInstance().consortiaId = -1;
         GamePlayer.getInstance().ConsortiaJob = 0;
         GamePlayer.getInstance().PropsCorpsPack = 0;
         GameKernel.popUpDisplayManager.Hide(this);
      }
      
      private function btn_leftClick(param1:Event) : void
      {
         if(this.CurPage == 0)
         {
            return;
         }
         if(this.SelectedRow != null)
         {
            this.SelectedRow.gotoAndStop("up");
         }
         --this.CurPage;
         this.ResetPageButton();
         this.RequestCorpsList();
      }
      
      private function btn_rightClick(param1:Event) : void
      {
         if(this.CurPage + 1 == this.PageCount)
         {
            return;
         }
         if(this.SelectedRow != null)
         {
            this.SelectedRow.gotoAndStop("up");
         }
         ++this.CurPage;
         this.ResetPageButton();
         this.RequestCorpsList();
      }
      
      private function RowClick(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = param1.target as MovieClip;
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:int = int(_loc2_.name.substr(7));
         var _loc4_:MovieClip = _loc2_.getChildByName("CorpsnamePlan") as MovieClip;
         if(this.SelectedRow != null)
         {
            this.SelectedRow.gotoAndStop("up");
         }
         this.SelectedRow = _loc4_;
         this.SelectedRow.gotoAndStop("selected");
         var _loc5_:MSG_RESP_CONSORTIAINFO_TEMP = this.CorpsList[_loc3_];
         this.SelectedCorpsId = _loc5_.ConsortiaId;
         this.SelectedCorpsName = _loc5_.Name;
         this.RequestCorpsInfo(this.SelectedCorpsId);
      }
      
      private function RequestCorpsList() : void
      {
         var _loc1_:MSG_REQUEST_CONSORTIAINFO = new MSG_REQUEST_CONSORTIAINFO();
         _loc1_.PageId = this.CurPage;
         _loc1_.SeqId = GamePlayer.getInstance().seqID++;
         _loc1_.Guid = GamePlayer.getInstance().Guid;
         NetManager.Instance().sendObject(_loc1_);
      }
      
      public function RespCorpsList(param1:MSG_RESP_CONSORTIAINFO) : void
      {
         var _loc3_:MovieClip = null;
         var _loc4_:MovieClip = null;
         var _loc5_:MSG_RESP_CONSORTIAINFO_TEMP = null;
         var _loc6_:TextField = null;
         this.PageCount = param1.ConsortiaCount / 11;
         if(this.PageCount * 11 < param1.ConsortiaCount)
         {
            ++this.PageCount;
         }
         this.CorpsList = param1.Data;
         var _loc2_:int = 0;
         while(_loc2_ < this.RowCount)
         {
            _loc3_ = this._mc.getMC().getChildByName("mc_list" + _loc2_) as MovieClip;
            _loc4_ = _loc3_.getChildByName("CorpsnamePlan") as MovieClip;
            if(_loc2_ < param1.DataLen)
            {
               _loc5_ = param1.Data[_loc2_];
               _loc6_ = _loc4_.tf_corpsgrade as TextField;
               _loc6_.text = (_loc5_.RankId + 1).toString();
               _loc6_ = _loc4_.tf_corpsname as TextField;
               _loc6_.text = _loc5_.Name;
               _loc3_.visible = true;
               if(_loc5_.ConsortiaId == this.SelectedCorpsId)
               {
                  if(this.SelectedRow != null)
                  {
                     this.SelectedRow.gotoAndStop("selected");
                  }
               }
            }
            else
            {
               _loc3_.visible = false;
            }
            _loc2_++;
         }
         this.ResetPageButton();
      }
      
      private function ResetPageButton() : void
      {
         if(this.CurPage > 0)
         {
            this.LeftBtn.setBtnDisabled(false);
         }
         else
         {
            this.LeftBtn.setBtnDisabled(true);
         }
         if(this.CurPage + 1 < this.PageCount)
         {
            this.RightBtn.setBtnDisabled(false);
         }
         else
         {
            this.RightBtn.setBtnDisabled(true);
         }
         this.tf_page.text = (this.CurPage + 1).toString() + "/" + this.PageCount.toString();
      }
      
      private function RequestCorpsInfo(param1:int) : void
      {
         this.btn_enter.setBtnDisabled(true);
         var _loc2_:MSG_REQUEST_CONSORTIAPROCLAIM = new MSG_REQUEST_CONSORTIAPROCLAIM();
         _loc2_.ConsortiaId = param1;
         _loc2_.SeqId = GamePlayer.getInstance().seqID++;
         _loc2_.Guid = GamePlayer.getInstance().Guid;
         NetManager.Instance().sendObject(_loc2_);
      }
      
      public function RespCorpsInfo(param1:MSG_RESP_CONSORTIAPROCLAIM) : void
      {
         this.CorpsInfoMsg = param1;
         if(this.mc_corpsbase.numChildren > 0)
         {
            this.mc_corpsbase.removeChildAt(0);
         }
         var _loc2_:Bitmap = new Bitmap(GameKernel.getTextureInstance("corp_" + param1.HeadId));
         this.mc_corpsbase.addChild(_loc2_);
         this.tf_corpsname.htmlText = "<a href=\'event:\'>" + this.SelectedCorpsName + "</a>";
         this.tf_corpscommander.htmlText = "<a href=\'event:\'>" + param1.ConsortiaLead + "</a>";
         this.SelectedUserId = param1.ConsortiaLeadUserId;
         GameKernel.getPlayerFacebookInfo(param1.ConsortiaLeadUserId,this.getPlayerFacebookInfoCallback,param1.ConsortiaLead);
         this.tf_grade.text = (param1.consortiaLevel + 1).toString();
         this.tf_corpsmember.text = param1.MemberCount + "/" + param1.MaxMemberCount;
         this.tf_corpsranking.text = param1.Cent.toString();
         this.tf_corpsintro.text = param1.Proclaim;
         var _loc3_:int = GamePlayer.getInstance().consortiaId;
         if(GamePlayer.getInstance().consortiaId < 0)
         {
            this.btn_enter.setBtnDisabled(false);
         }
      }
      
      private function tf_corpsnameClick(param1:MouseEvent) : void
      {
         if(this.CorpsInfoMsg != null)
         {
            LoserPopUI.getInstance().ShowConsortia(this.CorpsInfoMsg.ConsortiaId);
         }
      }
      
      private function getPlayerFacebookInfoCallback(param1:FacebookUserInfo) : void
      {
         if(param1 != null && this.SelectedUserId == param1.uid)
         {
            this.tf_corpscommander.text = "<a href=\'event:\'>" + param1.first_name + "</a>";
         }
      }
      
      public function ResetButton() : void
      {
         if(GamePlayer.getInstance().consortiaId >= 0)
         {
            this.btn_enter.setBtnDisabled(true);
            this.btn_found.setBtnDisabled(true);
            this.btn_mycorps.setBtnDisabled(false);
            this.btn_leavecorps.setBtnDisabled(false);
            if(GamePlayer.getInstance().ConsortiaJob == 1)
            {
               this.btn_leavecorps.setVisible(false);
            }
            else
            {
               this.btn_leavecorps.setVisible(true);
               this.btn_disbandcorps.setVisible(false);
            }
         }
         else
         {
            this.btn_enter.setBtnDisabled(this.SelectedCorpsId == -1);
            this.btn_found.setBtnDisabled(false);
            this.btn_mycorps.setBtnDisabled(true);
            this.btn_leavecorps.setBtnDisabled(true);
            this.btn_disbandcorps.setVisible(false);
            this.btn_leavecorps.setVisible(true);
         }
      }
      
      private function tf_corpscommanderClick(param1:MouseEvent) : void
      {
         if(this.CorpsInfoMsg == null)
         {
            return;
         }
         ChatAction.getInstance().sendChatUserInfoMessage(-1,this.CorpsInfoMsg.ConsortiaLeadGuid,3);
      }
   }
}

