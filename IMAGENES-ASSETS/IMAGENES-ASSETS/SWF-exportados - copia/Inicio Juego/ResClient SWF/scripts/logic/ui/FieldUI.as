package logic.ui
{
   import com.star.frameworks.facebook.FacebookUserInfo;
   import com.star.frameworks.managers.ResManager;
   import com.star.frameworks.managers.StringManager;
   import com.star.frameworks.utils.HashSet;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.utils.Timer;
   import logic.action.ConstructionAction;
   import logic.entry.CMouseCursor;
   import logic.entry.GamePlayer;
   import logic.entry.HButton;
   import logic.entry.HButtonType;
   import logic.entry.MObject;
   import logic.game.GameKernel;
   import logic.ui.tip.CustomTip;
   import logic.widget.DataWidget;
   import net.base.NetManager;
   import net.common.MsgTypes;
   import net.msg.field.MSG_REQUEST_DELETEFIELDRESOURCE;
   import net.msg.field.MSG_REQUEST_FIELDRESOURCE;
   import net.msg.field.MSG_REQUEST_FIELDRESOURCELOG;
   import net.msg.field.MSG_REQUEST_FRIENDFIELDSTATUS;
   import net.msg.field.MSG_REQUEST_GETFIELDRESOURCE;
   import net.msg.field.MSG_REQUEST_GROWFIELDRESOURCE;
   import net.msg.field.MSG_REQUEST_HELPFIELDCENTERRESOURCE;
   import net.msg.field.MSG_REQUEST_THIEVEFIELDRESOURCE;
   import net.msg.field.MSG_RESP_FIELDRESOURCE;
   import net.msg.field.MSG_RESP_FIELDRESOURCE_TEMP;
   import net.msg.field.MSG_RESP_FRIENDFIELDSTATUS;
   import net.msg.field.MSG_RESP_FRIENDFIELDSTATUS_TEMP;
   import net.msg.field.MSG_RESP_GETFIELDRESOURCE;
   import net.msg.field.MSG_RESP_GROWFIELDRESOURCE;
   import net.msg.field.MSG_RESP_HELPFIELDCENTERRESOURCE;
   import net.msg.field.MSG_RESP_THIEVEFIELDRESOURCE;
   import net.msg.friend.FriendChatUserInfo;
   import net.msg.friend.MSG_REQUEST_FRIENDLIST;
   import net.msg.friend.MSG_RESP_FRIENDLIST;
   
   public class FieldUI extends AbstractPopUp
   {
      
      private static var instance:FieldUI;
      
      private const ROW_COUNT:int = 6;
      
      private var StarPop:MovieClip;
      
      private var SelectedStar:MovieClip;
      
      private var StarXml:XMLList;
      
      private var McSelected:MovieClip;
      
      private var tf_name:TextField;
      
      private var He3Star:TextField;
      
      private var MetalStar:TextField;
      
      private var _GalaxyMapId:int;
      
      private var _GalaxyId:int;
      
      private var _UserId:Number;
      
      private var _ObjGuid:int;
      
      private var FieldList:Array;
      
      private var FieldMsg:MSG_RESP_FIELDRESOURCE;
      
      private var SelectedStarId:int;
      
      private var _Timer:Timer;
      
      private var btn_selecte:HButton;
      
      private var btn_build:HButton;
      
      private var btn_fetch:HButton;
      
      private var btn_move:HButton;
      
      private var btn_ahead:HButton;
      
      private var btn_prop:HButton;
      
      private var btn_domain:HButton;
      
      private var BtnX1:int;
      
      private var BtnX2:int;
      
      private var BtnX3:int;
      
      private var BtnX4:int;
      
      private var BtnX5:int;
      
      private var BtnX6:int;
      
      private var McFetch:MovieClip;
      
      private var McMove:MovieClip;
      
      private var MouseOverId:int;
      
      private var McMouse:MovieClip;
      
      private var ShowFetch:Boolean;
      
      private var SelectedFunc:int;
      
      private var MoneyFieldPoint:Point;
      
      private var MoneyFieldMc:MovieClip;
      
      private var btn_left:HButton;
      
      private var btn_right:HButton;
      
      private var tf_page:TextField;
      
      private var PageId:int;
      
      private var PageCount:int;
      
      private var UserIdList:Array;
      
      private var UserNameList:Array;
      
      private var FriendMsg:MSG_RESP_FRIENDLIST;
      
      private var IdList:Array;
      
      private var IdType:int;
      
      private var BanshouMc1:MovieClip;
      
      private var BanshouMc2:MovieClip;
      
      private var RulesPop:MovieClip;
      
      private var btn_gamefriend:HButton;
      
      private var btn_fbfriend:HButton;
      
      private var _OutputCount:int;
      
      private var GalaxyIds:Array = new Array(-2,-420 - 1,-1,420 - 1,-420 * 2,-420,0,420,420 * 2,-420 + 1,1,420 + 1,2);
      
      private var SelectedFriend:XMovieClip;
      
      private var FriendFieldStatusList:HashSet = new HashSet();
      
      private var FriendType:int;
      
      public function FieldUI()
      {
         super();
         this.UserIdList = new Array();
         this.UserNameList = new Array();
         this.IdList = new Array();
         setPopUpName("FieldUI");
      }
      
      public static function getInstance() : FieldUI
      {
         if(instance == null)
         {
            instance = new FieldUI();
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
         this._mc = new MObject("StealScene",385,300);
         this.initMcElement();
         this.Clear();
         GameKernel.popUpDisplayManager.Regisger(instance);
      }
      
      override public function initMcElement() : void
      {
         var _loc1_:HButton = null;
         var _loc2_:MovieClip = null;
         this.tf_name = this._mc.getMC().getChildByName("tf_name") as TextField;
         _loc2_ = this._mc.getMC().getChildByName("btn_change") as MovieClip;
         if(_loc2_)
         {
            _loc1_ = new HButton(_loc2_);
            _loc2_.addEventListener(MouseEvent.CLICK,this.btn_changeClick);
         }
         _loc2_ = this._mc.getMC().getChildByName("btn_close") as MovieClip;
         _loc1_ = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.CloseClick);
         _loc2_ = this._mc.getMC().getChildByName("btn_back") as MovieClip;
         _loc1_ = new HButton(_loc2_,HButtonType.SIMPLE,false,StringManager.getInstance().getMessageString("VegetableText19"));
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_backClick);
         _loc2_ = this._mc.getMC().getChildByName("btn_domain") as MovieClip;
         this.btn_domain = new HButton(_loc2_,HButtonType.SIMPLE,false,StringManager.getInstance().getMessageString("VegetableText20"));
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_domainClick);
         _loc2_ = this._mc.getMC().getChildByName("btn_refurbish") as MovieClip;
         _loc1_ = new HButton(_loc2_,HButtonType.SIMPLE,false,StringManager.getInstance().getMessageString("VegetableText21"));
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_refurbishClick);
         _loc2_ = this._mc.getMC().getChildByName("btn_rule") as MovieClip;
         _loc1_ = new HButton(_loc2_,HButtonType.SIMPLE,false,StringManager.getInstance().getMessageString("VegetableText22"));
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_ruleClick);
         _loc2_ = this._mc.getMC().getChildByName("btn_selecte") as MovieClip;
         this.btn_selecte = new HButton(_loc2_,HButtonType.SIMPLE,false,StringManager.getInstance().getMessageString("VegetableText0"));
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_selecteClick);
         this.BtnX1 = _loc2_.x;
         _loc2_ = this._mc.getMC().getChildByName("btn_build") as MovieClip;
         this.btn_build = new HButton(_loc2_,HButtonType.SIMPLE,false,StringManager.getInstance().getMessageString("VegetableText1"));
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_buildClick);
         this.BtnX2 = _loc2_.x;
         _loc2_ = this._mc.getMC().getChildByName("btn_move") as MovieClip;
         this.btn_move = new HButton(_loc2_,HButtonType.SIMPLE,false,StringManager.getInstance().getMessageString("VegetableText2"));
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_moveClick);
         this.BtnX3 = _loc2_.x;
         _loc2_ = this._mc.getMC().getChildByName("btn_fetch") as MovieClip;
         this.btn_fetch = new HButton(_loc2_,HButtonType.SIMPLE,false,StringManager.getInstance().getMessageString("VegetableText3"));
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_fetchClick);
         this.BtnX4 = _loc2_.x;
         _loc2_ = this._mc.getMC().getChildByName("btn_ahead") as MovieClip;
         this.btn_ahead = new HButton(_loc2_,HButtonType.SIMPLE,false,StringManager.getInstance().getMessageString("VegetableText4"));
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_aheadClick);
         this.BtnX5 = _loc2_.x;
         _loc2_ = this._mc.getMC().getChildByName("btn_prop") as MovieClip;
         this.btn_prop = new HButton(_loc2_,HButtonType.SIMPLE,false,StringManager.getInstance().getMessageString("VegetableText5"));
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_propClick);
         this.BtnX6 = _loc2_.x;
         MovieClip(this._mc.getMC().mc_plan).gotoAndStop(9);
         var _loc3_:XMovieClip = new XMovieClip(this._mc.getMC().mc_plan);
         _loc3_.Data = -6;
         _loc3_.OnClick = this.FieldClick;
         _loc3_.OnMouseOver = this.FieldMouseOver;
         _loc3_.m_movie.addEventListener(MouseEvent.MOUSE_OUT,this.FieldMouseOut);
         this.InitStarPop();
         this.InitStatus();
         this.InitFieldList();
         this.InitFriendList();
         this._Timer = new Timer(1000);
         this._Timer.addEventListener(TimerEvent.TIMER,this.OnTimer);
         this.BanshouMc1 = GameKernel.getMovieClipInstance("BanshouMc1");
         this.BanshouMc1.x = -72;
         this.BanshouMc1.y = -39;
         this.BanshouMc2 = GameKernel.getMovieClipInstance("BanshouMc2");
         this.BanshouMc2.x = -144;
         this.BanshouMc2.y = 24;
         this._mc.getMC().addChild(this.BanshouMc1);
         this._mc.getMC().addChild(this.BanshouMc2);
         this.RulesPop = GameKernel.getMovieClipInstance("RulesPop");
         _loc1_ = new HButton(this.RulesPop.btn_close);
         _loc1_.m_movie.addEventListener(MouseEvent.CLICK,this.btn_closeClick);
         this.btn_gamefriend = new HButton(this._mc.getMC().btn_gamefriend);
         this.btn_gamefriend.m_movie.addEventListener(MouseEvent.CLICK,this.btn_gamefriendClick);
         this.btn_fbfriend = new HButton(this._mc.getMC().btn_fbfriend);
         this.btn_fbfriend.m_movie.addEventListener(MouseEvent.CLICK,this.btn_fbfriendClick);
         if(GameKernel.ForFB == 1)
         {
            this.btn_fbfriend.setVisible(false);
         }
      }
      
      private function btn_changeClick(param1:MouseEvent) : void
      {
         modifyNameUI.getInstance().Init();
         GameKernel.popUpDisplayManager.Show(modifyNameUI.getInstance());
      }
      
      private function ShowButton() : void
      {
         if(GamePlayer.getInstance().galaxyMapID == this._GalaxyMapId && GamePlayer.getInstance().galaxyID == this._GalaxyId)
         {
            this.btn_build.setVisible(true);
            this.btn_move.setVisible(true);
            this.btn_selecte.m_movie.x = this.BtnX1;
            this.btn_build.m_movie.x = this.BtnX2;
            this.btn_move.m_movie.x = this.BtnX3;
            this.btn_fetch.m_movie.x = this.BtnX4;
            this.btn_ahead.m_movie.x = this.BtnX5;
            this.btn_prop.m_movie.x = this.BtnX6;
            this.btn_domain.setBtnDisabled(false);
         }
         else
         {
            this.btn_build.setVisible(false);
            this.btn_move.setVisible(false);
            this.btn_selecte.m_movie.x = this.BtnX2;
            this.btn_fetch.m_movie.x = this.BtnX3;
            this.btn_ahead.m_movie.x = this.BtnX4;
            this.btn_prop.m_movie.x = this.BtnX5;
            this.btn_domain.setBtnDisabled(true);
         }
      }
      
      private function InitFieldList() : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:XMovieClip = null;
         this.FieldList = new Array();
         var _loc1_:int = 0;
         while(_loc1_ < 13)
         {
            _loc2_ = this._mc.getMC().getChildByName("mc_list" + _loc1_) as MovieClip;
            _loc2_.mouseChildren = false;
            _loc3_ = new XMovieClip(_loc2_);
            _loc3_.Data = -1;
            _loc3_.OnClick = this.FieldClick;
            _loc3_.OnMouseOver = this.FieldMouseOver;
            _loc2_.addEventListener(MouseEvent.MOUSE_OUT,this.FieldMouseOut);
            _loc2_.buttonMode = false;
            this.FieldList.push(_loc3_);
            if(_loc1_ == 6)
            {
               this.MoneyFieldPoint = _loc2_.localToGlobal(new Point(-60,48));
               _loc3_.Data = -6;
               this.MoneyFieldMc = _loc2_;
               _loc2_.buttonMode = true;
            }
            _loc1_++;
         }
      }
      
      private function InitFriendList() : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:MovieClip = null;
         var _loc4_:XMovieClip = null;
         var _loc1_:int = 0;
         while(_loc1_ < 6)
         {
            _loc3_ = this._mc.getMC().getChildByName("mc_friend" + _loc1_) as MovieClip;
            _loc3_.gotoAndStop(1);
            _loc4_ = new XMovieClip(_loc3_);
            _loc4_.Data = _loc1_;
            _loc4_.OnClick = this.FriendClick;
            _loc4_.m_movie.buttonMode = true;
            DisplayObject(_loc3_.btn_fix).visible = false;
            DisplayObject(_loc3_.btn_steal).visible = false;
            _loc1_++;
         }
         _loc2_ = this._mc.getMC().getChildByName("btn_left") as MovieClip;
         this.btn_left = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_leftClick);
         _loc2_ = this._mc.getMC().getChildByName("btn_right") as MovieClip;
         this.btn_right = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_rightClick);
         this.tf_page = this._mc.getMC().getChildByName("tf_page") as TextField;
      }
      
      private function FieldClick(param1:MouseEvent, param2:XMovieClip) : void
      {
         if(param2.Data == -6)
         {
            this.MoneyFieldClick();
         }
         else if(this.SelectedFunc == 2)
         {
            this.RemoveResource(param2.m_movie,param2.Data);
         }
         else if(this.SelectedFunc == 3)
         {
            this.FetchField(param2.Data);
         }
      }
      
      private function FieldMouseOver(param1:MouseEvent, param2:XMovieClip) : void
      {
         if(param2.Data == -6)
         {
            this.ShowMoneyFieldTip();
         }
         else
         {
            if(this.McMouse == null)
            {
               this.ShowFieldTip(param2.Data,param2.m_movie);
            }
            if(this._mc.getMC().contains(this.StarPop))
            {
               this._mc.getMC().removeChild(this.StarPop);
            }
         }
      }
      
      private function MoneyFieldClick() : void
      {
         var _loc1_:MSG_REQUEST_GETFIELDRESOURCE = null;
         var _loc2_:int = 0;
         var _loc3_:MSG_REQUEST_HELPFIELDCENTERRESOURCE = null;
         if(this.FieldMsg == null)
         {
            return;
         }
         if(GamePlayer.getInstance().galaxyID == this._GalaxyId && GamePlayer.getInstance().galaxyMapID == this._GalaxyMapId)
         {
            if(this.FieldMsg.FieldCenterStatus == 0)
            {
               return;
            }
            _loc1_ = new MSG_REQUEST_GETFIELDRESOURCE();
            _loc1_.GalaxyId = -1;
            _loc1_.SeqId = GamePlayer.getInstance().seqID++;
            _loc1_.Guid = GamePlayer.getInstance().Guid;
            NetManager.Instance().sendObject(_loc1_);
         }
         else
         {
            if(this.FieldMsg.FriendFlag != 1)
            {
               return;
            }
            if(this.FieldMsg.FieldCenterStatus == 1 || this.FieldMsg.FieldCenterTime > 0)
            {
               return;
            }
            _loc2_ = 0;
            while(_loc2_ < MsgTypes.MAX_HELPCOUNT)
            {
               if(this.FieldMsg.HelpGuid[_loc2_] == GamePlayer.getInstance().Guid)
               {
                  MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("VegetableText27"),0);
                  return;
               }
               _loc2_++;
            }
            _loc3_ = new MSG_REQUEST_HELPFIELDCENTERRESOURCE();
            _loc3_.ObjGuid = this._ObjGuid;
            _loc3_.SeqId = GamePlayer.getInstance().seqID++;
            _loc3_.Guid = GamePlayer.getInstance().Guid;
            NetManager.Instance().sendObject(_loc3_);
         }
      }
      
      public function RespHelp(param1:MSG_RESP_HELPFIELDCENTERRESOURCE) : void
      {
         if(this.FieldMsg == null)
         {
            return;
         }
         if(param1.ErrorCode != 0)
         {
            return;
         }
         this.ClearHelpStatus(param1);
         if(this._ObjGuid != param1.ObjGuid)
         {
            return;
         }
         MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("VegetableText28"),0);
         var _loc2_:int = 0;
         while(_loc2_ < MsgTypes.MAX_HELPCOUNT)
         {
            if(this.FieldMsg.HelpGuid[_loc2_] == -1)
            {
               this.FieldMsg.HelpGuid[_loc2_] = GamePlayer.getInstance().Guid;
               break;
            }
            _loc2_++;
         }
         var _loc3_:int = this.GetHelpCount();
         this.BanshouMc1.visible = true;
         this.BanshouMc2.visible = true;
         this.BanshouMc1.play();
         this.BanshouMc2.x = -144 + (_loc3_ - 1) * 14;
         this.BanshouMc2.play();
         if(_loc3_ < MsgTypes.MAX_HELPCOUNT)
         {
            this.ShowMoneyFieldTip(true);
            return;
         }
         this.RefreshField();
      }
      
      private function ClearHelpStatus(param1:MSG_RESP_HELPFIELDCENTERRESOURCE) : void
      {
         var _loc3_:FriendChatUserInfo = null;
         var _loc4_:MovieClip = null;
         if(this.FriendMsg == null)
         {
            return;
         }
         var _loc2_:int = 0;
         while(_loc2_ < this.FriendMsg.DataLen)
         {
            _loc3_ = this.FriendMsg.Data[_loc2_];
            if(_loc3_.Guid == param1.ObjGuid)
            {
               _loc4_ = this._mc.getMC().getChildByName("mc_friend" + _loc2_) as MovieClip;
               DisplayObject(_loc4_.btn_fix).visible = false;
            }
            _loc2_++;
         }
      }
      
      private function GetHelpCount() : int
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < MsgTypes.MAX_HELPCOUNT)
         {
            if(this.FieldMsg.HelpGuid[_loc1_] == -1)
            {
               break;
            }
            _loc1_++;
         }
         if(_loc1_ == 0)
         {
            MovieClip(this._mc.getMC().mc_plan).gotoAndStop(9);
         }
         else
         {
            MovieClip(this._mc.getMC().mc_plan).gotoAndStop(_loc1_);
         }
         return _loc1_;
      }
      
      private function GetReourceInfo(param1:int, param2:int = 0) : String
      {
         var _loc3_:String = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         this._OutputCount = param2;
         if(GamePlayer.getInstance().language == 10)
         {
            _loc3_ = CustomTip.GetInstance().GetStringText("：" + StringManager.getInstance().getMessageString("CommanderText27"),this.StarXml[param1].@Name);
         }
         else
         {
            _loc3_ = CustomTip.GetInstance().GetStringText(StringManager.getInstance().getMessageString("CommanderText27") + "：",this.StarXml[param1].@Name);
         }
         if(this.StarXml[param1].@Kind == 1)
         {
            _loc3_ += "\n\n" + CustomTip.GetInstance().GetStringText(StringManager.getInstance().getMessageString("VegetableText8"),StringManager.getInstance().getMessageString("ShipText9"));
         }
         else if(this.StarXml[param1].@Kind == 0)
         {
            _loc3_ += "\n\n" + CustomTip.GetInstance().GetStringText(StringManager.getInstance().getMessageString("VegetableText8"),StringManager.getInstance().getMessageString("ShipText8"));
         }
         else
         {
            _loc3_ += "\n\n" + CustomTip.GetInstance().GetStringText(StringManager.getInstance().getMessageString("VegetableText8"),StringManager.getInstance().getMessageString("ShipText10"));
         }
         if(param2 == 0)
         {
            _loc4_ = int(this.StarXml[param1].@Pick);
            _loc5_ = this.FieldMsg.ConsortiaPer / 100 * _loc4_;
            if(this.StarXml[param1].@Kind == 1)
            {
               _loc6_ = this.FieldMsg.TechPerGas / 100 * _loc4_;
               _loc7_ = this.FieldMsg.PropsPerGas / 100 * _loc4_;
            }
            else if(this.StarXml[param1].@Kind == 0)
            {
               _loc6_ = this.FieldMsg.TechPerMetal / 100 * _loc4_;
               _loc7_ = this.FieldMsg.PropsPerMetal / 100 * _loc4_;
            }
            else
            {
               _loc6_ = this.FieldMsg.TechPerMoney / 100 * _loc4_;
               _loc7_ = this.FieldMsg.PropsPerMoney / 100 * _loc4_;
            }
            _loc3_ += "\n\n" + CustomTip.GetInstance().GetNumberText(StringManager.getInstance().getMessageString("VegetableText23"),_loc4_.toString());
            _loc3_ += "\n\n" + CustomTip.GetInstance().GetNumberText(StringManager.getInstance().getMessageString("VegetableText24"),_loc5_.toString());
            _loc3_ += "\n\n" + CustomTip.GetInstance().GetNumberText(StringManager.getInstance().getMessageString("VegetableText25"),_loc6_.toString());
            _loc3_ += "\n\n" + CustomTip.GetInstance().GetNumberText(StringManager.getInstance().getMessageString("VegetableText26"),_loc7_.toString());
            _loc4_ += _loc5_ + _loc6_ + _loc7_;
         }
         else
         {
            _loc4_ = param2;
         }
         return _loc3_ + ("\n\n" + CustomTip.GetInstance().GetNumberText(StringManager.getInstance().getMessageString("VegetableText9"),_loc4_.toString()));
      }
      
      private function ShowFieldTip(param1:int, param2:MovieClip) : void
      {
         var _loc6_:String = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         this.MouseOverId = -1;
         if(param1 == -1)
         {
            return;
         }
         if(this.FieldMsg == null)
         {
            return;
         }
         var _loc3_:Point = param2.localToGlobal(new Point(50,0));
         var _loc4_:MSG_RESP_FIELDRESOURCE_TEMP = this.FieldMsg.Data[param1];
         if(_loc4_.Status == 1)
         {
            CustomTip.GetInstance().Show(StringManager.getInstance().getMessageString("VegetableText10"),_loc3_);
            return;
         }
         if(_loc4_.ResourceId == -1)
         {
            CustomTip.GetInstance().Show(StringManager.getInstance().getMessageString("VegetableText11"),_loc3_);
            return;
         }
         var _loc5_:String = "\n\n" + this.GetReourceInfo(_loc4_.ResourceId,_loc4_.Num);
         if(_loc4_.SpareTime > 0)
         {
            _loc6_ = DataWidget.secondFormatToTime(_loc4_.SpareTime);
            CustomTip.GetInstance().Show(_loc6_ + " " + StringManager.getInstance().getMessageString("VegetableText12") + _loc5_,_loc3_);
            this.MouseOverId = param1;
         }
         else
         {
            _loc7_ = _loc4_.Num;
            _loc5_ = CustomTip.GetInstance().GetNumberText(StringManager.getInstance().getMessageString("VegetableText13"),_loc4_.ThieveCount.toString()) + _loc5_;
            _loc8_ = _loc7_ - _loc7_ * (0.1 * _loc4_.ThieveCount);
            _loc5_ += "\n\n" + CustomTip.GetInstance().GetNumberText(StringManager.getInstance().getMessageString("VegetableText14"),_loc8_.toString());
            if(_loc4_.Guid != GamePlayer.getInstance().Guid)
            {
               if(_loc4_.ThieveFlag == 1)
               {
                  CustomTip.GetInstance().Show(StringManager.getInstance().getMessageString("VegetableText15") + "\n\n" + _loc5_,_loc3_);
               }
               else
               {
                  CustomTip.GetInstance().Show(StringManager.getInstance().getMessageString("VegetableText16") + "\n\n" + _loc5_,_loc3_);
               }
            }
            else
            {
               CustomTip.GetInstance().Show(StringManager.getInstance().getMessageString("VegetableText15") + "\n\n" + _loc5_,_loc3_);
            }
         }
      }
      
      private function ShowMoneyFieldTip(param1:Boolean = false) : void
      {
         var _loc2_:String = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(this.FieldMsg == null)
         {
            return;
         }
         this.MouseOverId = 60;
         if(this.FieldMsg.FieldCenterStatus == 0 && this.FieldMsg.FieldCenterTime == 0)
         {
            this.MoneyFieldMc.mc_anim.play();
            _loc3_ = 0;
            _loc4_ = 0;
            while(_loc4_ < MsgTypes.MAX_HELPCOUNT)
            {
               if(this.FieldMsg.HelpGuid[_loc4_] == -1)
               {
                  _loc3_++;
               }
               _loc4_++;
            }
            _loc2_ = StringManager.getInstance().getMessageString("VegetableText29");
            _loc2_ = _loc2_.replace("@@1",_loc3_.toString());
         }
         else if(this.FieldMsg.FieldCenterTime > 0)
         {
            _loc2_ = DataWidget.secondFormatToTime(this.FieldMsg.FieldCenterTime) + StringManager.getInstance().getMessageString("VegetableText30");
         }
         else
         {
            _loc2_ = StringManager.getInstance().getMessageString("VegetableText31");
         }
         _loc2_ += "\n\n" + CustomTip.GetInstance().GetStringText(StringManager.getInstance().getMessageString("VegetableText8"),StringManager.getInstance().getMessageString("ShipText26"));
         _loc2_ += "\n\n" + CustomTip.GetInstance().GetNumberText(StringManager.getInstance().getMessageString("VegetableText9"),this.StarXml[8].@Pick);
         if(param1)
         {
            CustomTip.GetInstance().Update(_loc2_);
         }
         else
         {
            CustomTip.GetInstance().Show(_loc2_,this.MoneyFieldPoint);
         }
      }
      
      private function FieldMouseOut(param1:MouseEvent) : void
      {
         CustomTip.GetInstance().Hide();
         this.MouseOverId = -1;
      }
      
      private function InitStatus() : void
      {
         this.He3Star = this._mc.getMC().tf_He3num as TextField;
         this.MetalStar = this._mc.getMC().tf_metalnum as TextField;
      }
      
      private function InitStarPop() : void
      {
         var _loc4_:MovieClip = null;
         var _loc5_:XButton = null;
         var _loc6_:MovieClip = null;
         var _loc7_:Bitmap = null;
         this.StarPop = GameKernel.getMovieClipInstance("StarPop");
         this.StarXml = GameKernel.resManager.getXml(ResManager.GAMERES,"FieldResource").* as XMLList;
         var _loc1_:int = 0;
         while(_loc1_ < 8)
         {
            _loc4_ = this.StarPop.getChildByName("mc_base" + _loc1_) as MovieClip;
            _loc5_ = new XButton(_loc4_,HButtonType.SELECT);
            _loc5_.Data = _loc1_;
            _loc5_.OnClick = this.SelectStar;
            _loc5_.OnMouseOver = this.StarMouseOver;
            _loc4_.addEventListener(MouseEvent.MOUSE_OUT,this.StarMouseOut);
            _loc6_ = _loc4_.mc_base as MovieClip;
            _loc7_ = this.GetStarImage(_loc1_);
            _loc7_.x = 20 - _loc7_.width / 2;
            _loc7_.y = 20 - _loc7_.height / 2 + 7;
            _loc6_.addChild(_loc7_);
            _loc1_++;
         }
         var _loc2_:MovieClip = this.StarPop.btn_close as MovieClip;
         var _loc3_:HButton = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.StarPop_btn_closeClick);
         this.StarPop.x = -100;
         this.StarPop.y = 65;
         this.McSelected = GameKernel.getMovieClipInstance("moban",0,0);
         this.McSelected.width = 50;
         this.McSelected.height = 50;
         this.McSelected.addEventListener(MouseEvent.CLICK,this.McSelectedClick);
      }
      
      private function GetStarImage(param1:int) : Bitmap
      {
         var _loc3_:Bitmap = null;
         var _loc2_:int = param1 / 4;
         if(_loc2_ == 0)
         {
            _loc3_ = new Bitmap(GameKernel.getTextureInstance("Metal50"));
         }
         else if(_loc2_ == 1)
         {
            _loc3_ = new Bitmap(GameKernel.getTextureInstance("He350"));
         }
         else
         {
            _loc3_ = new Bitmap(GameKernel.getTextureInstance("Kursaal50"));
         }
         _loc3_.smoothing = true;
         var _loc4_:int = param1 % 4;
         switch(_loc4_)
         {
            case 0:
               _loc3_.width = 35;
               _loc3_.height = 35;
               break;
            case 1:
               _loc3_.width = 40;
               _loc3_.height = 40;
               break;
            case 2:
               _loc3_.width = 45;
               _loc3_.height = 45;
               break;
            case 3:
               _loc3_.width = 50;
               _loc3_.height = 50;
         }
         return _loc3_;
      }
      
      public function Show(param1:int, param2:int, param3:Number, param4:String, param5:int) : void
      {
         this.Init();
         this.ShowField(param1,param2,param3,param4,param5);
         this._Timer.start();
         this.btn_gamefriendClick(null);
         this.BanshouMc1.visible = false;
         this.BanshouMc2.visible = false;
         GameKernel.popUpDisplayManager.Show(this);
         this.setVisible(true);
      }
      
      private function ShowField(param1:int, param2:int, param3:Number, param4:String, param5:int) : void
      {
         this.ClearField();
         this._GalaxyMapId = param1;
         this._GalaxyId = param2;
         this._UserId = param3;
         this._ObjGuid = param5;
         this.RequestFieldInfo();
         this.ShowButton();
         this.btn_selecteClick(null);
         if(param4 != null)
         {
            this.tf_name.text = param4;
         }
         else
         {
            this.tf_name.text = "";
         }
      }
      
      public function Close() : void
      {
         this._Timer.stop();
         GameKernel.popUpDisplayManager.Hide(this);
         if(this._mc.getMC().contains(this.StarPop))
         {
            this._mc.getMC().removeChild(this.StarPop);
         }
         CMouseCursor.getInstance().setOriginality();
      }
      
      private function RequestFieldInfo() : void
      {
         var _loc1_:MSG_REQUEST_FIELDRESOURCE = new MSG_REQUEST_FIELDRESOURCE();
         _loc1_.GalaxyId = this._GalaxyId;
         _loc1_.GalaxyMapId = this._GalaxyMapId;
         _loc1_.SeqId = GamePlayer.getInstance().seqID++;
         _loc1_.Guid = GamePlayer.getInstance().Guid;
         NetManager.Instance().sendObject(_loc1_);
      }
      
      public function RespFieldInfo(param1:MSG_RESP_FIELDRESOURCE) : void
      {
         var _loc3_:MSG_RESP_FIELDRESOURCE_TEMP = null;
         var _loc4_:int = 0;
         var _loc5_:MovieClip = null;
         var _loc6_:int = 0;
         if(param1.GalaxyMapId != this._GalaxyMapId || param1.GalaxyId != this._GalaxyId)
         {
            return;
         }
         this.FieldMsg = param1;
         var _loc2_:int = 0;
         while(_loc2_ < 12)
         {
            _loc3_ = param1.Data[_loc2_];
            if(_loc3_.GalaxyId != -1)
            {
               _loc4_ = _loc3_.GalaxyId - this._GalaxyId;
               _loc6_ = 0;
               while(_loc6_ < 13)
               {
                  if(_loc4_ == this.GalaxyIds[_loc6_])
                  {
                     _loc5_ = this._mc.getMC().getChildByName("mc_list" + _loc6_) as MovieClip;
                     _loc5_.visible = true;
                     this.SetField(_loc5_,_loc3_);
                     XMovieClip(this.FieldList[_loc6_]).Data = _loc2_;
                     break;
                  }
                  _loc6_++;
               }
            }
            _loc2_++;
         }
         this.ShowStarCount();
         this.GetHelpCount();
      }
      
      private function ShowStarCount() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc4_:MSG_RESP_FIELDRESOURCE_TEMP = null;
         var _loc3_:int = 0;
         while(_loc3_ < 12)
         {
            _loc4_ = this.FieldMsg.Data[_loc3_];
            if(_loc4_.ResourceId >= 0 && _loc4_.ResourceId <= 3)
            {
               _loc2_++;
            }
            else if(_loc4_.ResourceId >= 4 && _loc4_.ResourceId <= 7)
            {
               _loc1_++;
            }
            _loc3_++;
         }
         this.He3Star.text = _loc1_.toString();
         this.MetalStar.text = _loc2_.toString();
      }
      
      private function SetField(param1:MovieClip, param2:MSG_RESP_FIELDRESOURCE_TEMP) : void
      {
         var _loc3_:Bitmap = null;
         if(param1.mc_resbase.numChildren > 1)
         {
            param1.mc_resbase.removeChildAt(1);
         }
         if(param2.Status == 1)
         {
            param1.gotoAndStop(4);
         }
         else if(param2.ResourceId >= 0)
         {
            _loc3_ = this.GetStarImage(param2.ResourceId);
            _loc3_.x = 17 - _loc3_.width / 2 + 5;
            _loc3_.y = 17 - _loc3_.height / 2 + 10;
            param1.mc_resbase.addChild(_loc3_);
            if(param2.SpareTime == 0)
            {
               param1.gotoAndStop(3);
            }
            else
            {
               param1.gotoAndStop(2);
            }
         }
         else
         {
            param1.gotoAndStop(1);
         }
      }
      
      private function OnTimer(param1:Event) : void
      {
         var _loc3_:MSG_RESP_FIELDRESOURCE_TEMP = null;
         var _loc4_:int = 0;
         var _loc5_:XMovieClip = null;
         var _loc6_:MSG_RESP_FIELDRESOURCE_TEMP = null;
         var _loc7_:String = null;
         var _loc8_:String = null;
         if(this.IsVisible() == false)
         {
            this._Timer.stop();
            return;
         }
         if(this.FieldMsg == null)
         {
            return;
         }
         var _loc2_:int = 0;
         while(_loc2_ < 12)
         {
            _loc3_ = this.FieldMsg.Data[_loc2_];
            if(_loc3_.SpareTime > 0)
            {
               --_loc3_.SpareTime;
               if(_loc3_.SpareTime == 0)
               {
                  _loc3_.ThieveCount = 0;
                  _loc3_.ThieveFlag = 1;
               }
            }
            _loc2_++;
         }
         if(this.FieldMsg.FieldCenterStatus == 0 && this.FieldMsg.FieldCenterTime > 0)
         {
            --this.FieldMsg.FieldCenterTime;
            if(this.FieldMsg.FieldCenterTime == 0)
            {
               this.FieldMsg.FieldCenterStatus = 1;
            }
         }
         if(this.McMouse != null)
         {
            _loc4_ = this.GetSelectedFieldByPoint(new Point(this.McMouse.x,this.McMouse.y));
            if(_loc4_ < 0 || _loc4_ == 6)
            {
               CustomTip.GetInstance().Hide();
               this.MouseOverId = -1;
               return;
            }
            _loc5_ = XMovieClip(this.FieldList[_loc4_]);
            this.ShowFieldTip(_loc5_.Data,_loc5_.m_movie);
         }
         else if(this.MouseOverId >= 0 && CustomTip.isShow)
         {
            if(this.MouseOverId == 60)
            {
               this.ShowMoneyFieldTip(true);
            }
            else
            {
               _loc6_ = this.FieldMsg.Data[this.MouseOverId];
               if(_loc6_.SpareTime > 0)
               {
                  _loc7_ = DataWidget.secondFormatToTime(_loc6_.SpareTime);
                  _loc8_ = "\n\n" + this.GetReourceInfo(_loc6_.ResourceId,this._OutputCount);
                  CustomTip.GetInstance().Update(_loc7_ + " " + StringManager.getInstance().getMessageString("VegetableText12") + _loc8_);
               }
            }
         }
      }
      
      private function ClearSelectedStar() : void
      {
         this.McSelected.stopDrag();
         this._mc.getMC().removeChild(this.McSelected);
         this.SelectedStarId = -1;
         this.McMouse = null;
      }
      
      private function McSelectedClick(param1:MouseEvent) : void
      {
         if(this.FieldMsg == null)
         {
            return;
         }
         var _loc2_:int = this.GetSelectedField(param1);
         if(_loc2_ < 0 || _loc2_ == 6)
         {
            this.ClearSelectedStar();
            return;
         }
         var _loc3_:int = XMovieClip(this.FieldList[_loc2_]).Data;
         if(_loc3_ == -1)
         {
            this.ClearSelectedStar();
            return;
         }
         var _loc4_:MSG_RESP_FIELDRESOURCE_TEMP = this.FieldMsg.Data[_loc3_];
         if(_loc4_.GalaxyId == -1 || _loc4_.Status != 0 || _loc4_.ResourceId >= 0)
         {
            this.ClearSelectedStar();
            return;
         }
         var _loc5_:MSG_REQUEST_GROWFIELDRESOURCE = new MSG_REQUEST_GROWFIELDRESOURCE();
         _loc5_.GalaxyId = _loc4_.GalaxyId;
         _loc5_.ResourceId = this.SelectedStarId;
         _loc5_.SeqId = GamePlayer.getInstance().seqID++;
         _loc5_.Guid = GamePlayer.getInstance().Guid;
         NetManager.Instance().sendObject(_loc5_);
      }
      
      public function RespGrowField(param1:MSG_RESP_GROWFIELDRESOURCE) : void
      {
         var _loc2_:Object = this.GetFieldInfo(param1.GalaxyId);
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:MSG_RESP_FIELDRESOURCE_TEMP = _loc2_.FieldData;
         var _loc4_:XMovieClip = _loc2_.XBtn;
         if(param1.ErrorCode == 1)
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("VegetableText10"),0);
            _loc3_.Status = 1;
         }
         else
         {
            _loc3_.ResourceId = param1.ResourceId;
            _loc3_.SpareTime = param1.NeedTime;
            _loc3_.Num = param1.Num;
         }
         var _loc5_:MovieClip = _loc4_.m_movie;
         this.SetField(_loc5_,_loc3_);
         this.ShowStarCount();
      }
      
      private function GetFieldInfo(param1:int) : Object
      {
         var _loc3_:MSG_RESP_FIELDRESOURCE_TEMP = null;
         var _loc4_:int = 0;
         var _loc5_:Object = null;
         var _loc2_:int = 0;
         while(_loc2_ < 12)
         {
            _loc3_ = this.FieldMsg.Data[_loc2_];
            if(_loc3_.GalaxyId == param1)
            {
               _loc4_ = 0;
               while(_loc4_ < 13)
               {
                  if(XMovieClip(this.FieldList[_loc4_]).Data == _loc2_)
                  {
                     _loc5_ = new Object();
                     _loc5_.XBtn = XMovieClip(this.FieldList[_loc4_]);
                     _loc5_.FieldData = _loc3_;
                     return _loc5_;
                  }
                  _loc4_++;
               }
               break;
            }
            _loc2_++;
         }
         return null;
      }
      
      private function GetSelectedField(param1:MouseEvent) : int
      {
         var _loc2_:MovieClip = param1.target as MovieClip;
         var _loc3_:Point = _loc2_.localToGlobal(new Point(param1.localX,param1.localY));
         _loc3_ = this._mc.getMC().globalToLocal(_loc3_);
         return this.GetSelectedFieldByPoint(_loc3_);
      }
      
      private function GetSelectedFieldByPoint(param1:Point) : int
      {
         var _loc3_:MovieClip = null;
         var _loc2_:int = 0;
         while(_loc2_ < 13)
         {
            _loc3_ = this._mc.getMC().getChildByName("mc_list" + _loc2_) as MovieClip;
            if(_loc3_.x < param1.x && _loc3_.y < param1.y && param1.x < _loc3_.x + 50 && param1.y < _loc3_.y + 50)
            {
               return _loc2_;
            }
            _loc2_++;
         }
         return -1;
      }
      
      private function SelectStar(param1:MouseEvent, param2:XButton) : void
      {
         if(this.McSelected.numChildren > 0)
         {
            this.McSelected.removeChildAt(0);
         }
         this.SelectedStarId = param2.Data;
         var _loc3_:Bitmap = this.GetStarImage(param2.Data);
         _loc3_.x = -(_loc3_.width / 2);
         _loc3_.y = -(_loc3_.height / 2);
         this.McSelected.addChild(_loc3_);
         var _loc4_:MovieClip = param1.target as MovieClip;
         var _loc5_:Point = _loc4_.localToGlobal(new Point(param1.localX,param1.localY));
         _loc5_ = this._mc.getMC().globalToLocal(_loc5_);
         this.McSelected.x = _loc5_.x;
         this.McSelected.y = _loc5_.y;
         this._mc.getMC().addChild(this.McSelected);
         this.McSelected.startDrag(true);
         this._mc.getMC().removeChild(this.StarPop);
         this.McMouse = this.McSelected;
      }
      
      private function StarMouseOver(param1:MouseEvent, param2:XButton) : void
      {
         this.SelectedStar = param2.m_movie;
         this.SelectedStar.gotoAndStop("selected");
         var _loc3_:Point = param2.m_movie.localToGlobal(new Point(param2.m_movie.width,0));
         var _loc4_:String = this.GetReourceInfo(param2.Data);
         _loc4_ = _loc4_ + ("\n\n" + CustomTip.GetInstance().GetStringText(StringManager.getInstance().getMessageString("VegetableText18"),DataWidget.secondFormatToTime(this.StarXml[param2.Data].@Time)));
         CustomTip.GetInstance().Show(_loc4_,_loc3_);
      }
      
      private function StarMouseOut(param1:MouseEvent) : void
      {
         if(this.SelectedStar != null)
         {
            this.SelectedStar.gotoAndStop("up");
         }
         CustomTip.GetInstance().Hide();
         this.MouseOverId = -1;
      }
      
      private function ClearField() : void
      {
         var _loc2_:MovieClip = null;
         var _loc1_:int = 0;
         while(_loc1_ < 13)
         {
            _loc2_ = this._mc.getMC().getChildByName("mc_list" + _loc1_) as MovieClip;
            if(_loc1_ != 6 && _loc2_.mc_resbase.numChildren > 1)
            {
               _loc2_.mc_resbase.removeChildAt(1);
            }
            _loc2_.visible = _loc1_ == 6;
            _loc1_++;
         }
      }
      
      private function ClearFriend() : void
      {
         var _loc2_:MovieClip = null;
         var _loc1_:int = 0;
         while(_loc1_ < 6)
         {
            _loc2_ = this._mc.getMC().getChildByName("mc_friend" + _loc1_) as MovieClip;
            _loc2_.visible = false;
            _loc1_++;
         }
         this.PageId = 0;
         this.btn_left.setBtnDisabled(true);
         this.btn_right.setBtnDisabled(true);
         this.tf_page.text = "";
         if(this.SelectedFriend != null)
         {
            this.SelectedFriend.m_movie.gotoAndStop(1);
         }
      }
      
      private function Clear() : void
      {
         TextField(this._mc.getMC().tf_spnum).text = GamePlayer.getInstance().SpValue.toString();
         this.ClearField();
         this.ClearFriend();
      }
      
      private function CloseClick(param1:Event) : void
      {
         this.Close();
      }
      
      private function btn_backClick(param1:Event) : void
      {
         var _loc2_:String = GamePlayer.getInstance().Name;
         this.ShowField(GamePlayer.getInstance().galaxyMapID,GamePlayer.getInstance().galaxyID,GamePlayer.getInstance().userID,_loc2_,GamePlayer.getInstance().Guid);
         if(this.SelectedFriend != null)
         {
            this.SelectedFriend.m_movie.gotoAndStop(1);
         }
      }
      
      private function btn_domainClick(param1:Event) : void
      {
         this.RequestLog();
      }
      
      private function RequestLog() : void
      {
         FieldUI_DomainPop.getInstance().Show();
         var _loc1_:MSG_REQUEST_FIELDRESOURCELOG = new MSG_REQUEST_FIELDRESOURCELOG();
         _loc1_.SeqId = GamePlayer.getInstance().seqID++;
         _loc1_.Guid = GamePlayer.getInstance().Guid;
         NetManager.Instance().sendObject(_loc1_);
      }
      
      private function btn_refurbishClick(param1:Event) : void
      {
         this.Clear();
         this.RequestFieldInfo();
         this.btn_gamefriendClick(null);
      }
      
      private function btn_ruleClick(param1:Event) : void
      {
         if(this._mc.getMC().contains(this.RulesPop))
         {
            return;
         }
         this._mc.getMC().addChild(this.RulesPop);
      }
      
      private function btn_closeClick(param1:MouseEvent) : void
      {
         this._mc.getMC().removeChild(this.RulesPop);
      }
      
      private function btn_selecteClick(param1:Event) : void
      {
         if(this._mc.getMC().contains(this.StarPop))
         {
            this._mc.getMC().removeChild(this.StarPop);
         }
         CMouseCursor.getInstance().setOriginality();
         this.SelectedFunc = 0;
      }
      
      private function StarPop_btn_closeClick(param1:Event) : void
      {
         if(this._mc.getMC().contains(this.StarPop))
         {
            this._mc.getMC().removeChild(this.StarPop);
         }
      }
      
      private function btn_buildClick(param1:Event) : void
      {
         CMouseCursor.getInstance().setOriginality();
         if(this._mc.getMC().contains(this.StarPop))
         {
            this._mc.getMC().removeChild(this.StarPop);
         }
         else
         {
            this._mc.getMC().addChild(this.StarPop);
         }
         this.SelectedFunc = 1;
      }
      
      private function btn_moveClick(param1:MouseEvent) : void
      {
         if(this._mc.getMC().contains(this.StarPop))
         {
            this._mc.getMC().removeChild(this.StarPop);
         }
         CMouseCursor.getInstance().setClearHandlerState(param1);
         this.SelectedFunc = 2;
      }
      
      private function btn_fetchClick(param1:MouseEvent) : void
      {
         if(this._mc.getMC().contains(this.StarPop))
         {
            this._mc.getMC().removeChild(this.StarPop);
         }
         CMouseCursor.getInstance().setFetchHandlerState(param1);
         this.SelectedFunc = 3;
      }
      
      private function McMoveMouseDown(param1:MouseEvent) : void
      {
         this.McMove.gotoAndStop("over");
      }
      
      private function McMoveMouseUp(param1:MouseEvent) : void
      {
      }
      
      private function McFetchMouseDown(param1:MouseEvent) : void
      {
         this.McFetch.gotoAndStop("over");
      }
      
      private function McFetchMouseUp(param1:MouseEvent) : void
      {
      }
      
      private function RemoveResource(param1:MovieClip, param2:int) : void
      {
         var _loc3_:MSG_RESP_FIELDRESOURCE_TEMP = this.FieldMsg.Data[param2];
         if(_loc3_.GalaxyId < 0 || _loc3_.ResourceId < 0)
         {
            return;
         }
         _loc3_.ResourceId = -1;
         _loc3_.Status = 0;
         _loc3_.ThieveCount = 0;
         _loc3_.ThieveFlag = 0;
         this.SetField(param1,_loc3_);
         var _loc4_:MSG_REQUEST_DELETEFIELDRESOURCE = new MSG_REQUEST_DELETEFIELDRESOURCE();
         _loc4_.GalaxyId = _loc3_.GalaxyId;
         _loc4_.SeqId = GamePlayer.getInstance().seqID++;
         _loc4_.Guid = GamePlayer.getInstance().Guid;
         NetManager.Instance().sendObject(_loc4_);
      }
      
      private function FetchField(param1:int) : void
      {
         var _loc3_:MSG_REQUEST_THIEVEFIELDRESOURCE = null;
         var _loc4_:MSG_REQUEST_GETFIELDRESOURCE = null;
         var _loc2_:MSG_RESP_FIELDRESOURCE_TEMP = this.FieldMsg.Data[param1];
         if(_loc2_ == null || _loc2_.SpareTime > 0)
         {
            return;
         }
         if(GamePlayer.getInstance().galaxyID != this._GalaxyId || GamePlayer.getInstance().galaxyMapID != this._GalaxyMapId)
         {
            if(_loc2_.GalaxyId < 0)
            {
               return;
            }
            if(_loc2_.ResourceId < 0)
            {
               return;
            }
            if(_loc2_.ThieveFlag == 0)
            {
               MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("VegetableText32"),0);
               return;
            }
            if(GamePlayer.getInstance().SpValue <= 0)
            {
               MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("VegetableText7"),0);
               return;
            }
            _loc3_ = new MSG_REQUEST_THIEVEFIELDRESOURCE();
            _loc3_.ObjGuid = _loc2_.Guid;
            _loc3_.ObjGalaxyId = _loc2_.GalaxyId;
            _loc3_.SeqId = GamePlayer.getInstance().seqID++;
            _loc3_.Guid = GamePlayer.getInstance().Guid;
            NetManager.Instance().sendObject(_loc3_);
         }
         else
         {
            _loc4_ = new MSG_REQUEST_GETFIELDRESOURCE();
            _loc4_.GalaxyId = _loc2_.GalaxyId;
            _loc4_.SeqId = GamePlayer.getInstance().seqID++;
            _loc4_.Guid = GamePlayer.getInstance().Guid;
            NetManager.Instance().sendObject(_loc4_);
         }
      }
      
      public function RespGetField(param1:MSG_RESP_GETFIELDRESOURCE) : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:int = 0;
         var _loc4_:Object = null;
         var _loc5_:MSG_RESP_FIELDRESOURCE_TEMP = null;
         var _loc6_:XMovieClip = null;
         if(param1.GalaxyId == -1)
         {
            this.FieldMsg.FieldCenterStatus = 0;
            _loc3_ = 0;
            while(_loc3_ < MsgTypes.MAX_HELPCOUNT)
            {
               this.FieldMsg.HelpGuid[_loc3_] = -1;
               _loc3_++;
            }
            if(this.MouseOverId == 60)
            {
               this.ShowMoneyFieldTip(true);
            }
            _loc2_ = this.MoneyFieldMc;
            MovieClip(this._mc.getMC().mc_plan).gotoAndStop(9);
         }
         else
         {
            _loc4_ = this.GetFieldInfo(param1.GalaxyId);
            if(_loc4_ == null)
            {
               return;
            }
            _loc5_ = _loc4_.FieldData;
            _loc6_ = _loc4_.XBtn;
            _loc5_.ResourceId = -1;
            _loc5_.Status = 0;
            _loc5_.SpareTime = 0;
            this.SetField(_loc6_.m_movie,_loc5_);
            _loc2_ = _loc6_.m_movie;
         }
         ConstructionAction.getInstance().addResource(param1.Gas,param1.Metal,param1.Money,0);
         this.ShowResult(_loc2_,param1.Gas,param1.Metal,param1.Money,param1.Coins);
         GamePlayer.getInstance().coins = GamePlayer.getInstance().coins + param1.Coins;
         this.ShowStarCount();
      }
      
      public function RespThieveField(param1:MSG_RESP_THIEVEFIELDRESOURCE) : void
      {
         var _loc2_:Object = null;
         var _loc3_:MSG_RESP_FIELDRESOURCE_TEMP = null;
         var _loc4_:XMovieClip = null;
         if(param1.ErrorCode == 0)
         {
            _loc2_ = this.GetFieldInfo(param1.GalaxyId);
            if(_loc2_ == null)
            {
               return;
            }
            _loc3_ = _loc2_.FieldData;
            _loc4_ = _loc2_.XBtn;
            ++_loc3_.ThieveCount;
            _loc3_.ThieveFlag = 0;
            ConstructionAction.getInstance().addResource(param1.Gas,param1.Metal,param1.Money,0);
            this.ShowResult(_loc4_.m_movie,param1.Gas,param1.Metal,param1.Money);
            PlayerInfoUI.getInstance().updatePlayerSp();
            this.RefreshThieveStatus();
         }
         else
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("VegetableText32"),0);
            this.RefreshField();
         }
         TextField(this._mc.getMC().tf_spnum).text = GamePlayer.getInstance().SpValue.toString();
      }
      
      private function RefreshField() : void
      {
         this.ClearField();
         this.RequestFieldInfo();
      }
      
      private function RefreshThieveStatus() : void
      {
         var _loc3_:MSG_RESP_FIELDRESOURCE_TEMP = null;
         var _loc4_:FriendChatUserInfo = null;
         var _loc5_:MovieClip = null;
         if(this.FriendMsg == null)
         {
            return;
         }
         var _loc1_:Boolean = false;
         var _loc2_:int = 0;
         while(_loc2_ < 12)
         {
            _loc3_ = this.FieldMsg.Data[_loc2_];
            if(_loc3_.GalaxyId != -1 && _loc3_.ResourceId != -1 && _loc3_.ThieveFlag == 1)
            {
               _loc1_ = true;
               break;
            }
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < this.FriendMsg.DataLen)
         {
            _loc4_ = this.FriendMsg.Data[_loc2_];
            if(_loc4_.Guid == this._ObjGuid)
            {
               _loc5_ = this._mc.getMC().getChildByName("mc_friend" + _loc2_) as MovieClip;
               DisplayObject(_loc5_.btn_steal).visible = _loc1_;
            }
            _loc2_++;
         }
      }
      
      private function ShowResult(param1:MovieClip, param2:int, param3:int, param4:int, param5:int = 0) : void
      {
         var _loc6_:String = "";
         if(param2 > 0)
         {
            _loc6_ = StringManager.getInstance().getMessageString("ShipText9") + " +" + param2;
         }
         else if(param3 > 0)
         {
            _loc6_ = StringManager.getInstance().getMessageString("ShipText8") + " +" + param3;
         }
         else if(param4 > 0)
         {
            _loc6_ = StringManager.getInstance().getMessageString("ShipText10") + " +" + param4;
         }
         else if(param5 > 0)
         {
            _loc6_ = StringManager.getInstance().getMessageString("ShipText26") + " +" + param5;
         }
         var _loc7_:CustomPopup = new CustomPopup();
         var _loc8_:Point = param1.localToGlobal(new Point(0,0));
         _loc8_ = this._mc.getMC().globalToLocal(_loc8_);
         _loc7_.SetText(this._mc.getMC(),_loc6_,_loc8_);
      }
      
      private function btn_aheadClick(param1:Event) : void
      {
         if(this._mc.getMC().contains(this.StarPop))
         {
            this._mc.getMC().removeChild(this.StarPop);
         }
         this.ShowFetch = false;
         var _loc2_:int = 0;
         while(_loc2_ < 13)
         {
            this.FetchField(_loc2_);
            _loc2_++;
         }
         this.SelectedFunc = 4;
      }
      
      private function btn_propClick(param1:Event) : void
      {
         if(this._mc.getMC().contains(this.StarPop))
         {
            this._mc.getMC().removeChild(this.StarPop);
         }
         this.SelectedFunc = 5;
      }
      
      private function FriendClick(param1:MouseEvent, param2:XMovieClip) : void
      {
         if(this.SelectedFriend != null)
         {
            this.SelectedFriend.m_movie.gotoAndStop(1);
         }
         this.SelectedFriend = param2;
         this.SelectedFriend.m_movie.gotoAndStop(2);
         if(param2.Data >= this.UserIdList.length)
         {
            return;
         }
         var _loc3_:MSG_RESP_FRIENDFIELDSTATUS_TEMP = this.FriendFieldStatusList.Get(this.IdList[param2.Data]);
         if(_loc3_ == null)
         {
            return;
         }
         this.ShowField(_loc3_.GalaxyMapId,_loc3_.GalaxyId,_loc3_.UserId,this.UserNameList[param2.Data],_loc3_.Guid);
      }
      
      private function btn_leftClick(param1:MouseEvent) : void
      {
         this.btn_right.setBtnDisabled(true);
         this.btn_left.setBtnDisabled(true);
         --this.PageId;
         this.ShowFriends();
      }
      
      private function btn_rightClick(param1:MouseEvent) : void
      {
         this.btn_right.setBtnDisabled(true);
         this.btn_left.setBtnDisabled(true);
         ++this.PageId;
         this.ShowFriends();
      }
      
      private function ShowFriends() : void
      {
         if(this.FriendType == 0)
         {
            this.RequestFriends();
         }
         else
         {
            this.ShowFbFriends();
         }
      }
      
      private function ShowFbFriends() : void
      {
         var _loc3_:FriendChatUserInfo = null;
         var _loc4_:FacebookUserInfo = null;
         var _loc1_:MSG_RESP_FRIENDLIST = new MSG_RESP_FRIENDLIST();
         _loc1_.DataLen = 0;
         _loc1_.Data.splice(0);
         _loc1_.FriendCount = GameKernel.facebookFriendList.length;
         var _loc2_:int = this.PageId * this.ROW_COUNT;
         while(_loc2_ < GameKernel.facebookFriendList.length)
         {
            _loc3_ = new FriendChatUserInfo();
            _loc4_ = GameKernel.facebookFriendList[_loc2_];
            _loc3_.Name = _loc4_.first_name;
            _loc3_.UserId = _loc4_.uid;
            _loc1_.Data.push(_loc3_);
            ++_loc1_.DataLen;
            _loc2_++;
         }
         this.RespFriends(_loc1_);
      }
      
      private function RequestFriends() : void
      {
         var _loc1_:MSG_REQUEST_FRIENDLIST = new MSG_REQUEST_FRIENDLIST();
         _loc1_.PageId = this.PageId;
         _loc1_.Type = 2;
         _loc1_.Online = 0;
         _loc1_.SeqId = GamePlayer.getInstance().seqID++;
         _loc1_.Guid = GamePlayer.getInstance().Guid;
         NetManager.Instance().sendObject(_loc1_);
      }
      
      public function RespFriends(param1:MSG_RESP_FRIENDLIST) : void
      {
         var _loc3_:MovieClip = null;
         var _loc4_:FriendChatUserInfo = null;
         var _loc5_:TextField = null;
         var _loc6_:MovieClip = null;
         this.PageCount = param1.FriendCount / this.ROW_COUNT;
         if(this.PageCount * this.ROW_COUNT < param1.FriendCount)
         {
            ++this.PageCount;
         }
         this.ShowPageButton();
         this.FriendMsg = param1;
         this.IdList.splice(0);
         this.UserIdList.splice(0);
         this.UserNameList.splice(0);
         var _loc2_:int = 0;
         while(_loc2_ < this.ROW_COUNT)
         {
            _loc3_ = this._mc.getMC().getChildByName("mc_friend" + _loc2_) as MovieClip;
            if(_loc2_ < param1.DataLen)
            {
               _loc4_ = param1.Data[_loc2_];
               _loc5_ = _loc3_.getChildByName("tf_name") as TextField;
               _loc5_.text = _loc4_.Name;
               _loc6_ = _loc3_.getChildByName("mc_base") as MovieClip;
               if(_loc6_.numChildren > 0)
               {
                  _loc6_.removeChildAt(0);
               }
               _loc3_.visible = true;
               this.UserIdList.push(_loc4_.UserId);
               this.UserNameList.push(_loc4_.Name);
               if(this.FriendType == 0)
               {
                  this.IdList.push(_loc4_.Guid);
               }
               else
               {
                  this.IdList.push(_loc4_.UserId);
               }
               DisplayObject(_loc3_.btn_fix).visible = false;
               DisplayObject(_loc3_.btn_steal).visible = false;
               if(_loc4_.Guid == this._ObjGuid)
               {
                  _loc3_.gotoAndStop(2);
                  this.SelectedFriend = new XMovieClip(_loc3_);
               }
               else
               {
                  _loc3_.gotoAndStop(1);
               }
            }
            else
            {
               _loc3_.visible = false;
            }
            _loc2_++;
         }
         GameKernel.getPlayerFacebookInfoArray(this.UserIdList,this.getPlayerFacebookInfoArrayCallback,this.UserNameList);
         this.RequestFriendFieldStatus(this.FriendType,this.IdList);
      }
      
      private function getPlayerFacebookInfoArrayCallback(param1:Array) : void
      {
         var _loc2_:FacebookUserInfo = null;
         var _loc3_:int = 0;
         var _loc4_:FriendChatUserInfo = null;
         var _loc5_:MovieClip = null;
         var _loc6_:TextField = null;
         if(param1 == null)
         {
            return;
         }
         for each(_loc2_ in param1)
         {
            _loc3_ = 0;
            while(_loc3_ < this.UserIdList.length)
            {
               if(this.UserIdList[_loc3_] == _loc2_.uid)
               {
                  _loc4_ = this.FriendMsg.Data[_loc3_];
                  _loc4_.Name = _loc2_.first_name;
                  _loc5_ = this._mc.getMC().getChildByName("mc_friend" + _loc3_) as MovieClip;
                  _loc6_ = _loc5_.getChildByName("tf_name") as TextField;
                  _loc6_.text = _loc2_.first_name;
                  FleetInfoUI_Res.GetInstance().GetFacebookUserImg(_loc2_.uid,_loc2_.pic_square,this.GetFacebookUserImgCallback);
                  break;
               }
               _loc3_++;
            }
         }
      }
      
      private function GetFacebookUserImgCallback(param1:Number, param2:DisplayObject) : void
      {
         var _loc4_:MovieClip = null;
         var _loc5_:MovieClip = null;
         if(param2 == null)
         {
            return;
         }
         var _loc3_:int = 0;
         while(_loc3_ < this.UserIdList.length)
         {
            if(this.UserIdList[_loc3_] == param1)
            {
               _loc4_ = this._mc.getMC().getChildByName("mc_friend" + _loc3_) as MovieClip;
               _loc5_ = _loc4_.getChildByName("mc_base") as MovieClip;
               if(GameKernel.ForRenRen != 1)
               {
                  Bitmap(param2).smoothing = true;
               }
               param2.width = 28;
               param2.height = 28;
               _loc5_.addChild(param2);
            }
            _loc3_++;
         }
      }
      
      private function ShowPageButton() : void
      {
         if(this.PageCount == 0)
         {
            this.tf_page.text = "";
            this.btn_left.setBtnDisabled(true);
            this.btn_right.setBtnDisabled(true);
            return;
         }
         if(this.PageId == 0)
         {
            this.btn_left.setBtnDisabled(true);
         }
         else
         {
            this.btn_left.setBtnDisabled(false);
         }
         if(this.PageId + 1 < this.PageCount)
         {
            this.btn_right.setBtnDisabled(false);
         }
         else
         {
            this.btn_right.setBtnDisabled(true);
         }
         this.tf_page.text = this.PageId + 1 + "/" + this.PageCount;
      }
      
      private function RequestFriendFieldStatus(param1:int, param2:Array) : void
      {
         var _loc3_:MSG_REQUEST_FRIENDFIELDSTATUS = new MSG_REQUEST_FRIENDFIELDSTATUS();
         _loc3_.Type = param1;
         _loc3_.DataLen = 0;
         var _loc4_:int = 0;
         while(_loc4_ < MsgTypes.MAX_FRIENDFIELDSTATUS)
         {
            if(_loc4_ < param2.length)
            {
               _loc3_.Data[_loc3_.DataLen] = param2[_loc4_];
               ++_loc3_.DataLen;
            }
            _loc4_++;
         }
         _loc3_.SeqId = GamePlayer.getInstance().seqID++;
         _loc3_.Guid = GamePlayer.getInstance().Guid;
         NetManager.Instance().sendObject(_loc3_);
      }
      
      public function RespFriendFieldStatus(param1:MSG_RESP_FRIENDFIELDSTATUS) : void
      {
         var _loc3_:MSG_RESP_FRIENDFIELDSTATUS_TEMP = null;
         var _loc4_:int = 0;
         var _loc5_:FriendChatUserInfo = null;
         var _loc6_:MovieClip = null;
         var _loc2_:int = 0;
         while(_loc2_ < param1.DataLen)
         {
            _loc3_ = param1.Data[_loc2_];
            if(param1.Type == 0)
            {
               _loc4_ = int(this.IdList.indexOf(_loc3_.Guid));
               this.FriendFieldStatusList.Put(_loc3_.Guid,_loc3_);
            }
            else
            {
               _loc4_ = int(this.IdList.indexOf(_loc3_.UserId));
               this.FriendFieldStatusList.Put(_loc3_.UserId,_loc3_);
            }
            if(_loc4_ >= 0)
            {
               _loc5_ = this.FriendMsg.Data[_loc4_];
               _loc5_.Guid = _loc3_.Guid;
               _loc5_.UserId = _loc3_.UserId;
               _loc6_ = this._mc.getMC().getChildByName("mc_friend" + _loc4_) as MovieClip;
               DisplayObject(_loc6_.btn_fix).visible = _loc3_.HelpFlag == 1;
               DisplayObject(_loc6_.btn_steal).visible = _loc3_.ThieveFlag == 1;
            }
            _loc2_++;
         }
      }
      
      public function btn_gamefriendClick(param1:MouseEvent) : void
      {
         this.FriendType = 0;
         this.btn_gamefriend.setSelect(true);
         this.btn_fbfriend.setSelect(false);
         this.ClearFriend();
         this.RequestFriends();
      }
      
      public function btn_fbfriendClick(param1:MouseEvent) : void
      {
         this.FriendType = 1;
         this.btn_gamefriend.setSelect(false);
         this.btn_fbfriend.setSelect(true);
         this.ClearFriend();
         this.ShowFbFriends();
      }
   }
}

