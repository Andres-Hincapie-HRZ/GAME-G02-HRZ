package logic.ui
{
   import com.star.frameworks.facebook.FacebookUserInfo;
   import com.star.frameworks.managers.StringManager;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.StyleSheet;
   import flash.text.TextField;
   import logic.action.ChatAction;
   import logic.entry.GalaxyType;
   import logic.entry.HButton;
   import logic.entry.HButtonType;
   import logic.entry.MObject;
   import logic.entry.shipmodel.ShipbodyInfo;
   import logic.game.GameKernel;
   import logic.game.GameMouseZoneManager;
   import logic.manager.FightManager;
   import logic.manager.GalaxyManager;
   import logic.manager.InstanceManager;
   import logic.reader.CShipmodelReader;
   import net.msg.fightMsg.FightRobResource;
   import net.msg.fightMsg.FightTotalExp;
   import net.msg.fightMsg.FightTotalKill;
   import net.msg.fightMsg.MSG_RESP_FIGHTRESULT;
   
   public class FightResultUI extends AbstractPopUp
   {
      
      private static var _instance:FightResultUI = null;
      
      private var btn_left:HButton;
      
      private var btn_right:HButton;
      
      private var btn_overcopy:HButton;
      
      private var tf_page:TextField;
      
      private var CurRowCount:int;
      
      private var style:StyleSheet;
      
      private var _seleteBtns:Array = new Array();
      
      private var _itemRubbish:Array = new Array();
      
      private var pageSize:int = 5;
      
      private var curPage:int = 0;
      
      private var maxPage:int = 0;
      
      private var pageData:Array;
      
      private var _fightResult:MSG_RESP_FIGHTRESULT = null;
      
      private var _baseMc:MovieClip;
      
      private var KillLen:int;
      
      private var ExpLen:int;
      
      private var PrizeLen:int;
      
      public function FightResultUI(param1:HHH)
      {
         super();
         setPopUpName("FightResultUI");
         this.initMcElement();
      }
      
      public static function get instance() : FightResultUI
      {
         if(_instance == null)
         {
            _instance = new FightResultUI(new HHH());
         }
         return _instance;
      }
      
      override public function Init() : void
      {
         this.GetPlayerName();
         this.initResult();
         InstanceManager.instance.InitResultButtons();
         if(GameKernel.popUpDisplayManager.PopDisplayList.ContainsKey(getPopUpName()))
         {
            GameKernel.popUpDisplayManager.Show(_instance);
            return;
         }
         GameKernel.popUpDisplayManager.Regisger(_instance);
         GameKernel.popUpDisplayManager.Show(_instance);
      }
      
      override public function initMcElement() : void
      {
         var _loc1_:HButton = null;
         var _loc2_:MovieClip = null;
         this._mc = new MObject("BattlereportScene",385,300);
         _loc2_ = this._mc.getMC().btn_left as MovieClip;
         _loc2_.addEventListener(MouseEvent.CLICK,this.onClick);
         this.btn_left = new HButton(_loc2_);
         _loc2_ = this._mc.getMC().btn_right as MovieClip;
         _loc2_.addEventListener(MouseEvent.CLICK,this.onClick);
         this.btn_right = new HButton(_loc2_);
         this.tf_page = this._mc.getMC().tf_page as TextField;
         _loc2_ = this._mc.getMC().getChildByName("btn_hitlist") as MovieClip;
         _loc2_.addEventListener(MouseEvent.CLICK,this.onClick);
         _loc1_ = new HButton(_loc2_,HButtonType.SELECT);
         _loc1_.setSelect(true);
         this._seleteBtns.push(_loc1_);
         _loc2_ = this._mc.getMC().getChildByName("btn_experiencelist") as MovieClip;
         _loc2_.addEventListener(MouseEvent.CLICK,this.onClick);
         _loc1_ = new HButton(_loc2_,HButtonType.SELECT);
         this._seleteBtns.push(_loc1_);
         _loc2_ = this._mc.getMC().getChildByName("btn_topattack") as MovieClip;
         _loc2_.addEventListener(MouseEvent.CLICK,this.onClick);
         _loc1_ = new HButton(_loc2_,HButtonType.SELECT);
         this._seleteBtns.push(_loc1_);
         _loc2_ = this._mc.getMC().getChildByName("btn_personalhit") as MovieClip;
         _loc2_.addEventListener(MouseEvent.CLICK,this.onClick);
         _loc1_ = new HButton(_loc2_,HButtonType.SELECT);
         this._seleteBtns.push(_loc1_);
         _loc2_ = this._mc.getMC().getChildByName("btn_close") as MovieClip;
         _loc2_.addEventListener(MouseEvent.CLICK,this.onClick);
         _loc1_ = new HButton(_loc2_);
         this._seleteBtns.push(_loc1_);
         _loc2_ = this._mc.getMC().getChildByName("btn_nextcopy") as MovieClip;
         _loc2_.visible = false;
         _loc2_.addEventListener(MouseEvent.CLICK,this.onClick);
         _loc1_ = new HButton(_loc2_);
         this._seleteBtns.push(_loc1_);
         _loc2_ = this._mc.getMC().getChildByName("btn_overcopy") as MovieClip;
         _loc2_.visible = false;
         _loc2_.addEventListener(MouseEvent.CLICK,this.onClick);
         this.btn_overcopy = new HButton(_loc2_);
         this._seleteBtns.push(_loc1_);
         var _loc3_:String = "a:link{text-decoration: underline;} a:hover{color:#ff0000;text-decoration: underline;} a:active{text-decoration: underline;}";
         this.style = new StyleSheet();
         this.style.parseCSS(_loc3_);
      }
      
      private function onClick(param1:MouseEvent = null) : void
      {
         var _loc4_:MovieClip = null;
         var _loc5_:String = null;
         var _loc6_:ShipbodyInfo = null;
         var _loc7_:Bitmap = null;
         this.clearBase();
         if(!this._fightResult)
         {
            return;
         }
         var _loc2_:int = 0;
         var _loc3_:String = "btn_hitlist";
         if(param1)
         {
            _loc3_ = param1.target.name;
         }
         this.btn_left.setBtnDisabled(true);
         this.btn_right.setBtnDisabled(true);
         switch(_loc3_)
         {
            case "btn_hitlist":
            case "btn_experiencelist":
            case "btn_personalhit":
               this.curPage = 0;
               this.freshSelectBtns(_loc3_);
               this.freshPage();
               break;
            case "btn_topattack":
               if(this._fightResult.TopAssault_Value <= 0)
               {
                  break;
               }
               _loc4_ = GameKernel.getMovieClipInstance("TopattackPlan");
               (_loc4_.tf_subjection as TextField).addEventListener(MouseEvent.CLICK,this.topattackNameClick);
               _loc4_.tf_subjection.styleSheet = this.style;
               if(this._fightResult.TopAssault_BodyId != -1)
               {
                  _loc6_ = CShipmodelReader.getInstance().getShipBodyInfo(this._fightResult.TopAssault_BodyId);
                  _loc7_ = new Bitmap(GameKernel.getTextureInstance(_loc6_.SmallIcon));
                  (_loc4_.tf_airshipbase as MovieClip).addChild(_loc7_);
               }
               (_loc4_.tf_airshipname as TextField).text = this._fightResult.TopAssault_ModelName;
               (_loc4_.tf_topattack as TextField).text = StringManager.getInstance().getMessageString("CorpsText70") + this._fightResult.TopAssault_Value;
               this._baseMc.addChild(_loc4_);
               this._itemRubbish.push(_loc4_);
               this.freshSelectBtns(_loc3_);
               _loc5_ = this._fightResult.TopAssault_Owner;
               if(this._fightResult.TopAssault_UserId > 0)
               {
                  (_loc4_.tf_subjection as TextField).htmlText = StringManager.getInstance().getMessageString("CorpsText69") + "<a href=\'event:\'>" + _loc5_ + "</a>";
                  GameKernel.getPlayerFacebookInfo(this._fightResult.TopAssault_UserId,this.getPlayerFacebookInfoCallback,this._fightResult.TopAssault_Owner);
                  break;
               }
               (_loc4_.tf_subjection as TextField).htmlText = StringManager.getInstance().getMessageString("CorpsText69") + "<a href=\'event:\'>" + _loc5_ + "</a>";
               break;
            case "btn_personalexperience":
               break;
            case "btn_nextcopy":
               InstanceManager.instance.requestNextFB();
               this.HidenUI();
               break;
            case "btn_overcopy":
               this.ReleaseFB();
               break;
            case "btn_close":
               this.Release();
               break;
            case "btn_left":
               this.frontPage();
               break;
            case "btn_right":
               this.nextPage();
         }
      }
      
      private function frontPage() : void
      {
         --this.curPage;
         if(this.curPage < 0)
         {
            this.curPage = 0;
         }
         this.freshPage();
      }
      
      private function nextPage() : void
      {
         this.curPage += 1;
         this.freshPage();
      }
      
      private function ClearImg() : void
      {
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc1_:String = this.getSelectBtn();
         if(_loc1_ == "btn_personalhit")
         {
            _loc2_ = 0;
            while(_loc2_ < this.pageSize)
            {
               _loc3_ = this._itemRubbish[_loc2_];
               if(_loc3_ != null)
               {
                  if(MovieClip(_loc3_.mc_playerbase).numChildren > 0)
                  {
                     MovieClip(_loc3_.mc_playerbase).removeChildAt(0);
                  }
               }
               _loc2_++;
            }
         }
      }
      
      private function AddBodyImg(param1:MovieClip, param2:int) : void
      {
         var _loc4_:Bitmap = null;
         if(param1.numChildren > 0)
         {
            param1.removeChildAt(0);
         }
         var _loc3_:ShipbodyInfo = CShipmodelReader.getInstance().getShipBodyInfo(param2);
         if(_loc3_ != null)
         {
            _loc4_ = new Bitmap(GameKernel.getTextureInstance(_loc3_.SmallIcon));
            param1.addChild(_loc4_);
         }
      }
      
      private function AddCommanderImg(param1:MovieClip, param2:int) : void
      {
         if(param1.numChildren > 0)
         {
            param1.removeChildAt(0);
         }
         var _loc3_:Bitmap = CommanderSceneUI.getInstance().CommanderAvararImg(param2);
         param1.addChild(_loc3_);
      }
      
      private function freshPage(param1:int = 0) : void
      {
         var _loc2_:XTextField = null;
         var _loc5_:FightTotalKill = null;
         var _loc6_:FightTotalExp = null;
         var _loc7_:FightRobResource = null;
         var _loc8_:int = 0;
         var _loc9_:MovieClip = null;
         var _loc10_:MovieClip = null;
         var _loc11_:MovieClip = null;
         if(param1 == 0)
         {
            this.ClearImg();
         }
         var _loc3_:String = this.getSelectBtn();
         var _loc4_:int = 0;
         switch(_loc3_)
         {
            case "btn_hitlist":
               this.CurRowCount = this.KillLen;
               _loc8_ = 0;
               while(_loc8_ < this.pageSize)
               {
                  _loc9_ = this._itemRubbish[_loc8_];
                  if(_loc9_ == null)
                  {
                     _loc9_ = GameKernel.getMovieClipInstance("HitlistPlan");
                     _loc9_.y = _loc8_ * 53;
                     this._baseMc.addChild(_loc9_);
                     this._itemRubbish.push(_loc9_);
                     _loc2_ = new XTextField(_loc9_.tf_subjection);
                     _loc2_.Data = _loc8_;
                     _loc2_.OnClick = this.KillNameClick;
                     _loc9_.tf_subjection.styleSheet = this.style;
                  }
                  _loc4_ = this.curPage * this.pageSize + _loc8_;
                  _loc5_ = this._fightResult.Kill[_loc4_] as FightTotalKill;
                  if((Boolean(_loc5_)) && _loc5_.Num > 0)
                  {
                     _loc9_.visible = true;
                     (_loc9_.tf_array as TextField).text = _loc4_ + 1 + "";
                     (_loc9_.tf_subjection as TextField).htmlText = StringManager.getInstance().getMessageString("CorpsText69") + "<a href=\'event:\'>" + _loc5_.RoleName + "</a>";
                     (_loc9_.tf_airshipname as TextField).text = _loc5_.ModelName;
                     (_loc9_.tf_hitnum as TextField).text = StringManager.getInstance().getMessageString("MailText18") + _loc5_.Num;
                     this.AddBodyImg(_loc9_.tf_airshipbase as MovieClip,_loc5_.BodyId);
                  }
                  else
                  {
                     _loc9_.visible = false;
                  }
                  _loc8_++;
               }
               break;
            case "btn_experiencelist":
               this.CurRowCount = this.ExpLen;
               _loc8_ = 0;
               while(_loc8_ < this.pageSize)
               {
                  _loc10_ = this._itemRubbish[_loc8_];
                  if(_loc10_ == null)
                  {
                     _loc10_ = GameKernel.getMovieClipInstance("ExperciencelistPlan");
                     _loc10_.y = _loc8_ * 53;
                     this._baseMc.addChild(_loc10_);
                     this._itemRubbish.push(_loc10_);
                     _loc2_ = new XTextField(_loc10_.tf_subjection);
                     _loc2_.Data = _loc8_;
                     _loc2_.OnClick = this.ExpNameClick;
                     _loc10_.tf_subjection.styleSheet = this.style;
                  }
                  _loc6_ = this._fightResult.Exp[this.curPage * this.pageSize + _loc8_] as FightTotalExp;
                  if((Boolean(_loc6_)) && _loc6_.Exp > 0)
                  {
                     _loc10_.visible = true;
                     (_loc10_.tf_commandername as TextField).text = _loc6_.CommanderName;
                     (_loc10_.tf_Lv as TextField).text = "LV: " + (_loc6_.LevelId + 1);
                     (_loc10_.tf_expercience as TextField).text = "EXP: " + _loc6_.Exp;
                     (_loc10_.tf_subjection as TextField).htmlText = StringManager.getInstance().getMessageString("CorpsText69") + "<a href=\'event:\'>" + _loc6_.RoleName + "</a>";
                     this.AddCommanderImg(_loc10_.tf_commanderbase as MovieClip,_loc6_.HeadId);
                  }
                  else
                  {
                     _loc10_.visible = false;
                  }
                  _loc8_++;
               }
               break;
            case "btn_personalhit":
               this.CurRowCount = this.PrizeLen;
               _loc8_ = 0;
               while(_loc8_ < this.pageSize)
               {
                  _loc11_ = this._itemRubbish[_loc8_];
                  if(_loc11_ == null)
                  {
                     _loc11_ = GameKernel.getMovieClipInstance("ResachievePlan");
                     _loc11_.y = _loc8_ * 53;
                     this._baseMc.addChild(_loc11_);
                     this._itemRubbish.push(_loc11_);
                     _loc2_ = new XTextField(_loc11_.tf_name);
                     _loc2_.Data = _loc8_;
                     _loc2_.OnClick = this.PrizeNameClick;
                     _loc11_.tf_name.styleSheet = this.style;
                  }
                  _loc7_ = this._fightResult.Prize[this.curPage * this.pageSize + _loc8_] as FightRobResource;
                  if((Boolean(_loc7_)) && _loc7_.RoleName != "")
                  {
                     _loc11_.visible = true;
                     (_loc11_.tf_metal as TextField).text = "" + _loc7_.Metal;
                     (_loc11_.tf_gas as TextField).text = "" + _loc7_.Gas;
                     (_loc11_.tf_money as TextField).text = "" + _loc7_.Money;
                     (_loc11_.tf_name as TextField).htmlText = "<a href=\'event:\'>" + _loc7_.RoleName + "</a>";
                  }
                  else
                  {
                     _loc11_.visible = false;
                  }
                  _loc8_++;
               }
         }
         if(param1 == 0)
         {
            this.SetPageButton();
         }
      }
      
      private function SetPageButton() : void
      {
         this.btn_left.setBtnDisabled(this.curPage == 0);
         this.btn_right.setBtnDisabled(this.CurRowCount <= 5 || this.curPage > 0);
         if(this.CurRowCount > 5)
         {
            this.tf_page.text = this.curPage + 1 + "/2";
         }
         else
         {
            this.tf_page.text = this.curPage + 1 + "/1";
         }
      }
      
      private function freshSelectBtns(param1:String) : void
      {
         var _loc2_:HButton = null;
         var _loc3_:int = 0;
         while(_loc3_ < this._seleteBtns.length)
         {
            _loc2_ = this._seleteBtns[_loc3_] as HButton;
            if(param1 == _loc2_.m_name)
            {
               _loc2_.setSelect(true);
            }
            else
            {
               _loc2_.setSelect(false);
            }
            _loc3_++;
         }
      }
      
      private function getSelectBtn() : String
      {
         var _loc1_:HButton = null;
         var _loc2_:int = 0;
         while(_loc2_ < this._seleteBtns.length)
         {
            _loc1_ = this._seleteBtns[_loc2_] as HButton;
            if(_loc1_.selsected)
            {
               return _loc1_.m_name;
            }
            _loc2_++;
         }
         return "";
      }
      
      public function InitFBButtons() : void
      {
         var _loc3_:MovieClip = null;
         var _loc1_:Boolean = false;
         var _loc2_:Boolean = false;
         if(!this._fightResult)
         {
            return;
         }
         switch(this._fightResult.Type)
         {
            case -1:
               _loc1_ = true;
               _loc2_ = true;
               break;
            case -2:
               _loc1_ = false;
               _loc2_ = true;
               break;
            case 0:
               _loc1_ = false;
               _loc2_ = false;
               break;
            case 1:
               _loc1_ = false;
               _loc2_ = false;
         }
         _loc3_ = this._mc.getMC().getChildByName("btn_nextcopy") as MovieClip;
         _loc3_.visible = _loc1_;
         _loc3_ = this._mc.getMC().getChildByName("btn_overcopy") as MovieClip;
         _loc3_.visible = _loc2_;
      }
      
      private function clearBase() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this._itemRubbish.length)
         {
            this._baseMc.removeChild(this._itemRubbish[_loc1_]);
            _loc1_++;
         }
         this._itemRubbish.splice(0);
      }
      
      private function initResult() : void
      {
         if(!this._fightResult)
         {
            return;
         }
         this._baseMc = this._mc.getMC().mc_base as MovieClip;
         (this._mc.getMC().tf_attacknum as TextField).text = "" + this._fightResult.AttackShipNumber;
         (this._mc.getMC().tf_attackloss as TextField).text = "" + this._fightResult.AttackLossNumber;
         (this._mc.getMC().tf_defensenum as TextField).text = "" + this._fightResult.DefendShipNumber;
         (this._mc.getMC().tf_defenseloss as TextField).text = "" + this._fightResult.DefendLossNumber;
         if(this._fightResult.Victory == 0)
         {
            this._mc.getMC().mc_txt0.gotoAndStop(2);
            this._mc.getMC().mc_txt1.gotoAndStop(3);
         }
         else if(this._fightResult.Victory == 1)
         {
            this._mc.getMC().mc_txt0.gotoAndStop(1);
            this._mc.getMC().mc_txt1.gotoAndStop(4);
         }
         else if(this._fightResult.Victory == 2)
         {
            this._mc.getMC().mc_txt0.gotoAndStop(5);
            this._mc.getMC().mc_txt1.gotoAndStop(6);
         }
         this.onClick();
      }
      
      public function Release() : void
      {
         if(!GalaxyManager.instance.isMineHome())
         {
            GameMouseZoneManager.NagivateToolBarByName("btn_universe",true);
         }
         else if(this._fightResult != null && this._fightResult.Type == 0)
         {
            FightManager.instance.CleanFight();
            GalaxyManager.instance.sendRequestGalaxy();
         }
         if(GalaxyManager.instance.enterStar.Type == GalaxyType.GT_3)
         {
            FightManager.instance.CleanFight();
         }
         this.ReleaseFB();
      }
      
      public function ReleaseFB() : void
      {
         if(this._fightResult != null && this._fightResult.Type == 1)
         {
            GameKernel.popUpDisplayManager.Hide(this);
         }
         else
         {
            GameKernel.popUpDisplayManager.Hide(this);
         }
         if(this._fightResult != null && this._fightResult.Type < 0 && InstanceManager.instance.curEctype != 1001)
         {
            InstanceManager.instance.exitInstance();
         }
         this._fightResult = null;
         InstanceMenuUI.instance.hiden();
         this.InitFBButtons();
      }
      
      public function HidenUI() : void
      {
         GameKernel.popUpDisplayManager.Hide(this);
         if(this._fightResult.Type != 0)
         {
            this._fightResult = null;
            return;
         }
         this._fightResult = null;
         this.InitFBButtons();
      }
      
      public function setFightResult(param1:MSG_RESP_FIGHTRESULT) : void
      {
         this._fightResult = param1;
      }
      
      public function getFightResult() : MSG_RESP_FIGHTRESULT
      {
         return this._fightResult;
      }
      
      private function GetPlayerName() : void
      {
         var _loc1_:FightTotalKill = null;
         var _loc2_:FightTotalExp = null;
         var _loc3_:FightRobResource = null;
         if(this._fightResult == null)
         {
            return;
         }
         this.KillLen = 0;
         this.ExpLen = 0;
         this.PrizeLen = 0;
         for each(_loc1_ in this._fightResult.Kill)
         {
            if(_loc1_.Num <= 0)
            {
               break;
            }
            ++this.KillLen;
         }
         for each(_loc2_ in this._fightResult.Exp)
         {
            if(_loc2_.Exp <= 0)
            {
               break;
            }
            ++this.ExpLen;
         }
         for each(_loc3_ in this._fightResult.Prize)
         {
            if(_loc3_.RoleName == "")
            {
               break;
            }
            ++this.PrizeLen;
         }
      }
      
      private function getPlayerFacebookInfoArrayCallback(param1:Array) : void
      {
         var _loc3_:FacebookUserInfo = null;
         var _loc2_:String = this.getSelectBtn();
         if(_loc2_ == "btn_personalhit")
         {
            for each(_loc3_ in param1)
            {
               FleetInfoUI_Res.GetInstance().GetFacebookUserImg(_loc3_.uid,_loc3_.pic_square,this.GetFacebookUserImgCallback);
            }
         }
         this.freshPage(1);
      }
      
      private function GetFacebookUserImgCallback(param1:Number, param2:DisplayObject) : void
      {
         if(param2 != null)
         {
            this.freshUserImg(param1,param2);
         }
      }
      
      private function freshUserImg(param1:Number, param2:DisplayObject) : void
      {
         var _loc5_:FightRobResource = null;
         var _loc6_:int = 0;
         var _loc7_:MovieClip = null;
         var _loc3_:String = this.getSelectBtn();
         var _loc4_:int = this.curPage * this.pageSize;
         if(_loc3_ == "btn_personalhit")
         {
            _loc6_ = 0;
            while(_loc6_ < this.pageSize)
            {
               _loc4_ += _loc6_;
               _loc5_ = this._fightResult.Prize[_loc4_] as FightRobResource;
               if((_loc5_) && _loc5_.RoleName != "" && _loc5_.UserId == param1)
               {
                  _loc7_ = this._itemRubbish[_loc6_];
                  if(MovieClip(_loc7_.mc_playerbase).numChildren > 0)
                  {
                     MovieClip(_loc7_.mc_playerbase).removeChildAt(0);
                  }
                  _loc7_.mc_playerbase.addChild(param2);
               }
               _loc6_++;
            }
         }
      }
      
      private function KillNameClick(param1:MouseEvent, param2:XTextField) : void
      {
         var _loc3_:int = this.curPage * this.pageSize + param2.Data;
         var _loc4_:FightTotalKill = this._fightResult.Kill[_loc3_] as FightTotalKill;
         if(GameKernel.flashVar["SessionKey"] != undefined)
         {
            ChatAction.getInstance().sendChatUserInfoMessage(-1,-1,3,_loc4_.UserId);
         }
         else
         {
            ChatAction.getInstance().sendChatUserInfoMessage(-1,-1,3,-1,_loc4_.RoleName);
         }
      }
      
      private function ExpNameClick(param1:MouseEvent, param2:XTextField) : void
      {
         PlayerInfoPopUp.Module = true;
         var _loc3_:int = this.curPage * this.pageSize + param2.Data;
         var _loc4_:FightTotalExp = this._fightResult.Exp[_loc3_] as FightTotalExp;
         if(GameKernel.flashVar["SessionKey"] != undefined)
         {
            ChatAction.getInstance().sendChatUserInfoMessage(-1,-1,3,_loc4_.UserId);
         }
         else
         {
            ChatAction.getInstance().sendChatUserInfoMessage(-1,-1,3,-1,_loc4_.RoleName);
         }
      }
      
      private function PrizeNameClick(param1:MouseEvent, param2:XTextField) : void
      {
         PlayerInfoPopUp.Module = true;
         var _loc3_:int = this.curPage * this.pageSize + param2.Data;
         var _loc4_:FightRobResource = this._fightResult.Prize[_loc3_] as FightRobResource;
         if(GameKernel.flashVar["SessionKey"] != undefined)
         {
            ChatAction.getInstance().sendChatUserInfoMessage(-1,-1,3,_loc4_.UserId);
         }
         else
         {
            ChatAction.getInstance().sendChatUserInfoMessage(-1,-1,3,-1,_loc4_.RoleName);
         }
      }
      
      private function topattackNameClick(param1:MouseEvent) : void
      {
         PlayerInfoPopUp.Module = true;
         if(GameKernel.flashVar["SessionKey"] != undefined)
         {
            ChatAction.getInstance().sendChatUserInfoMessage(-1,-1,3,this._fightResult.TopAssault_UserId);
         }
         else
         {
            ChatAction.getInstance().sendChatUserInfoMessage(-1,-1,3,-1,this._fightResult.TopAssault_Owner);
         }
      }
      
      private function getPlayerFacebookInfoCallback(param1:FacebookUserInfo) : void
      {
         var _loc2_:MovieClip = null;
         if(param1 == null)
         {
            return;
         }
         if(this.getSelectBtn() == "btn_topattack" && this._itemRubbish.length > 0)
         {
            _loc2_ = this._itemRubbish[0];
            (_loc2_.tf_subjection as TextField).htmlText = StringManager.getInstance().getMessageString("CorpsText69") + "<a href=\'event:\'>" + param1.first_name + "</a>";
         }
      }
   }
}

class HHH
{
   
   public function HHH()
   {
      super();
   }
}
