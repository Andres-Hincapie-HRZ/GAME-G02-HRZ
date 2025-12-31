package logic.ui
{
   import com.star.frameworks.managers.StringManager;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.utils.setTimeout;
   import logic.action.ConstructionAction;
   import logic.entry.GamePlayer;
   import logic.entry.HButton;
   import logic.entry.HButtonType;
   import logic.entry.MObject;
   import logic.entry.ScienceSystem;
   import logic.entry.ScrollPropsInfo;
   import logic.entry.commander.CommanderXmlInfo;
   import logic.entry.props.PackPropsInfo;
   import logic.entry.props.propsInfo;
   import logic.game.GameKernel;
   import logic.game.GameMouseZoneManager;
   import logic.reader.CCommanderReader;
   import logic.reader.CPropsReader;
   import logic.reader.CcorpsReader;
   import logic.ui.tip.CustomTip;
   import logic.utils.UpdateResource;
   import net.base.NetManager;
   import net.msg.Compose.MSG_REQUEST_UNIONCOMMANDERCARD;
   import net.msg.Compose.MSG_REQUEST_UNIONDOUBLESKILLCARD;
   import net.msg.Compose.MSG_RESP_UNIONCOMMANDERCARD;
   import net.msg.Compose.MSG_RESP_UNIONDOUBLESKILLCARD;
   
   public class ComposeUI extends AbstractPopUp
   {
      
      private static var instance:ComposeUI;
      
      private const CardItemCount:int = 15;
      
      private const GoodsItemCount:int = 15;
      
      private var btn_ronghe:HButton;
      
      private var btn_qianghua:HButton;
      
      private var btn_hecheng:HButton;
      
      private var btn_qijianmerge:HButton;
      
      private var btn_samecard:HButton;
      
      private var btn_othercard:HButton;
      
      private var Card_btn_left:HButton;
      
      private var Card_btn_right:HButton;
      
      private var Goods_btn_left:HButton;
      
      private var Goods_btn_right:HButton;
      
      private var Card_tf_page:TextField;
      
      private var Goods_tf_page:TextField;
      
      private var SelectedBtn:HButton;
      
      private var SelectedBtn2:HButton;
      
      private var btn_compose:HButton;
      
      private var CardPageCount:int;
      
      private var CardPageIndex:int;
      
      private var GoodsPageCount:int;
      
      private var GoodsPageIndex:int;
      
      private var CardItemList:Array = new Array();
      
      private var GoodsItemList:Array = new Array();
      
      private var PackCard:Array = new Array();
      
      private var PackGoods:Array = new Array();
      
      private var DeletePackCard:Array = new Array();
      
      private var DeletePackGoods:Array = new Array();
      
      private var _PropsTip:MovieClip;
      
      private var McCardBase1:MovieClip;
      
      private var McCardBase2:MovieClip;
      
      private var McCardBase3:MovieClip;
      
      private var McCardBase4:MovieClip;
      
      private var GoodsBase:MovieClip;
      
      private var ResultBase:MovieClip;
      
      private var SameCard1:int;
      
      private var SameCard2:int;
      
      private var OtherCard1:int;
      
      private var OtherCard2:int;
      
      private var OtherCard3:int;
      
      private var DoubleCard1:int;
      
      private var DoubleCard2:int;
      
      private var ComposeGoodsId:int;
      
      private var ComposeGoods_Rate:int;
      
      private var ComposeGoodsLockFlag:int;
      
      private var SelectedCardId:int;
      
      private var LasSelectedCardId:int;
      
      private var SelectedGoodsId:int;
      
      private var ComposeType:int;
      
      private var mc_samecard:MovieClip;
      
      private var ResultPropsImg:Bitmap;
      
      private var ResultCardId:int;
      
      private var DoubleComposeResultCardId:int;
      
      private var CorpsSuccessRate:int;
      
      private var btn_buy:HButton;
      
      private var btn_help:HButton;
      
      private var McHelp:MovieClip;
      
      private var mc_doubleskill:Sprite;
      
      private var DoubleComposeMode:Boolean;
      
      private var _ScrollPropsInfo:ScrollPropsInfo;
      
      private var _ScrollPropsInfoLockFlag:int;
      
      private var _ScrollNum:int;
      
      private var btn_qijianupgrade:HButton;
      
      private var SuccessRate:int = 0;
      
      private var addRate:int = 0;
      
      private var btn_commanderchip:HButton;
      
      private var HasChip:Boolean;
      
      private var SelectedItem:MovieClip;
      
      public function ComposeUI()
      {
         super();
         setPopUpName("ComposeUI");
      }
      
      public static function getInstance() : ComposeUI
      {
         if(instance == null)
         {
            instance = new ComposeUI();
         }
         return instance;
      }
      
      override public function Init() : void
      {
         if(GameKernel.popUpDisplayManager.PopDisplayList.ContainsKey(getPopUpName()))
         {
            this.Invalid(true);
            this.Clear();
            return;
         }
         this._mc = new MObject("ComposeScene",385,300);
         this.initMcElement();
         this.Clear();
         GameKernel.popUpDisplayManager.Regisger(instance);
      }
      
      override public function initMcElement() : void
      {
         var _loc1_:HButton = null;
         var _loc2_:MovieClip = null;
         _loc2_ = this._mc.getMC().getChildByName("btn_close") as MovieClip;
         _loc1_ = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.CloseClick);
         _loc2_ = this._mc.getMC().getChildByName("btn_ronghe") as MovieClip;
         this.btn_ronghe = new HButton(_loc2_,HButtonType.SIMPLE,false,StringManager.getInstance().getMessageString("CorpsText127"));
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_rongheClick);
         _loc2_ = this._mc.getMC().getChildByName("btn_qianghua") as MovieClip;
         this.btn_qianghua = new HButton(_loc2_,HButtonType.SIMPLE,false,StringManager.getInstance().getMessageString("CorpsText128"));
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_qianghuaClick);
         _loc2_ = this._mc.getMC().getChildByName("btn_hecheng") as MovieClip;
         this.btn_hecheng = new HButton(_loc2_,HButtonType.SIMPLE,false,StringManager.getInstance().getMessageString("CorpsText129"));
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_hechengClick);
         _loc2_ = this._mc.getMC().getChildByName("btn_qijianmerge") as MovieClip;
         this.HasChip = _loc2_ != null;
         if(this.HasChip)
         {
            this.btn_qijianmerge = new HButton(_loc2_,HButtonType.SIMPLE,false,StringManager.getInstance().getMessageString("Boss75"));
            _loc2_.addEventListener(MouseEvent.CLICK,this.btn_qijianmergeClick);
         }
         if(this.HasChip)
         {
            _loc2_ = this._mc.getMC().getChildByName("btn_commanderchip") as MovieClip;
            this.btn_commanderchip = new HButton(_loc2_,HButtonType.SIMPLE,false,StringManager.getInstance().getMessageString("Boss78"));
            _loc2_.addEventListener(MouseEvent.CLICK,this.btn_commanderchipClick);
         }
         _loc2_ = this._mc.getMC().mc_samecard.getChildByName("btn_samecard") as MovieClip;
         this.btn_samecard = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_samecardClick);
         _loc2_ = this._mc.getMC().mc_samecard.getChildByName("btn_othercard") as MovieClip;
         this.btn_othercard = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_othercardClick);
         _loc2_ = this._mc.getMC().mc_samecard.getChildByName("btn_compose") as MovieClip;
         this.btn_compose = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_composeClick);
         _loc2_ = this._mc.getMC().getChildByName("btn_mall") as MovieClip;
         _loc1_ = new HButton(_loc2_,HButtonType.SIMPLE,false,StringManager.getInstance().getMessageString("MainUITXT4"));
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_mallClick);
         _loc2_ = this._mc.getMC().getChildByName("btn_bag") as MovieClip;
         _loc1_ = new HButton(_loc2_,HButtonType.SIMPLE,false,StringManager.getInstance().getMessageString("MainUITXT20"));
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_bagClick);
         _loc2_ = this._mc.getMC().mc_samecard.getChildByName("btn_buy") as MovieClip;
         this.btn_buy = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_buyClick);
         _loc2_ = this._mc.getMC().getChildByName("btn_help") as MovieClip;
         this.btn_help = new HButton(_loc2_,HButtonType.SIMPLE,false,StringManager.getInstance().getMessageString("IconText39"));
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_helpClick);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_helpClick);
         this.McHelp = GameKernel.getMovieClipInstance("HelpMc4");
         this.McHelp.addEventListener(MouseEvent.CLICK,this.CloseHelp);
         this.InitCard();
         this.InitGoods();
         this.InitComposeItem();
         ComposeUI_Diamond.GetInstance().Init(this._mc.getMC());
         ComposeUI_Commander.GetInstance().Init(this._mc.getMC());
         var _loc3_:MovieClip = this._mc.getMC().getChildByName("mc_qijianmerge") as MovieClip;
         if(this.HasChip)
         {
            ComposeUI_FlagShip.GetInstance().Init(this._mc.getMC());
            ComposeUI_CommanderChip.GetInstance().Init(this._mc.getMC());
         }
      }
      
      private function InitComposeItem() : void
      {
         this.mc_samecard = this._mc.getMC().getChildByName("mc_samecard") as MovieClip;
         this.McCardBase1 = this.mc_samecard.mc_list0 as MovieClip;
         this.McCardBase1.mc_base1.doubleClickEnabled = true;
         this.McCardBase1.mc_base1.addEventListener(MouseEvent.DOUBLE_CLICK,this.McCardBase1DoubleClick);
         this.McCardBase1.mc_base1.addEventListener(MouseEvent.MOUSE_OVER,this.McCardBase1MouseOver);
         this.McCardBase1.mc_base1.addEventListener(MouseEvent.MOUSE_OUT,this.CardMouseOut);
         this.McCardBase1.stop();
         this.McCardBase2 = this.mc_samecard.mc_list1 as MovieClip;
         this.McCardBase2.mc_base1.doubleClickEnabled = true;
         this.McCardBase2.mc_base1.addEventListener(MouseEvent.DOUBLE_CLICK,this.McCardBase2DoubleClick);
         this.McCardBase2.mc_base1.addEventListener(MouseEvent.MOUSE_OVER,this.McCardBase2MouseOver);
         this.McCardBase2.mc_base1.addEventListener(MouseEvent.MOUSE_OUT,this.CardMouseOut);
         this.McCardBase2.stop();
         this.McCardBase3 = this.mc_samecard.mc_list2 as MovieClip;
         this.McCardBase3.mc_base1.doubleClickEnabled = true;
         this.McCardBase3.mc_base1.addEventListener(MouseEvent.DOUBLE_CLICK,this.McCardBase3DoubleClick);
         this.McCardBase3.mc_base1.addEventListener(MouseEvent.MOUSE_OVER,this.McCardBase3MouseOver);
         this.McCardBase3.mc_base1.addEventListener(MouseEvent.MOUSE_OUT,this.CardMouseOut);
         this.McCardBase3.mc_base1.stop();
         this.McCardBase4 = this.mc_samecard.mc_list3 as MovieClip;
         this.McCardBase4.mc_base1.doubleClickEnabled = true;
         this.McCardBase4.mc_base1.addEventListener(MouseEvent.DOUBLE_CLICK,this.McCardBase4DoubleClick);
         this.McCardBase4.mc_base1.addEventListener(MouseEvent.MOUSE_OVER,this.McCardBase4MouseOver);
         this.McCardBase4.mc_base1.addEventListener(MouseEvent.MOUSE_OUT,this.CardMouseOut);
         this.McCardBase4.stop();
         this.GoodsBase = this.mc_samecard.mc_list4 as MovieClip;
         this.GoodsBase.doubleClickEnabled = true;
         this.GoodsBase.addEventListener(MouseEvent.DOUBLE_CLICK,this.GoodsBaseDoubleClick);
         this.GoodsBase.addEventListener(MouseEvent.MOUSE_OVER,this.GoodsBaseMouseOver);
         this.GoodsBase.addEventListener(MouseEvent.MOUSE_OUT,this.CardMouseOut);
         this.GoodsBase.stop();
         this.GoodsBase.mouseChildren = false;
         this.ResultBase = this.mc_samecard.mc_list5 as MovieClip;
         this.ResultBase.addEventListener(MouseEvent.MOUSE_OVER,this.ResultBaseMouseOver);
         this.ResultBase.addEventListener(MouseEvent.MOUSE_OUT,this.CardMouseOut);
         this.ResultBase.stop();
         this.ResultBase.visible = true;
         this.mc_doubleskill = Sprite(this.mc_samecard.getChildByName("mc_doubleskill"));
         var _loc1_:MovieClip = this.mc_doubleskill.getChildByName("mc_explain") as MovieClip;
         _loc1_.stop();
         _loc1_.addEventListener(MouseEvent.MOUSE_OVER,this.mc_explainOver);
         _loc1_.addEventListener(MouseEvent.MOUSE_OUT,this.mc_explainOut);
         var _loc2_:MovieClip = this.mc_doubleskill.getChildByName("mc_base") as MovieClip;
         _loc2_.addEventListener(MouseEvent.MOUSE_OVER,this.mc_baseOver);
         _loc2_.addEventListener(MouseEvent.MOUSE_OUT,this.mc_baseOut);
      }
      
      private function InitCard() : void
      {
         var _loc3_:MovieClip = null;
         var _loc4_:MovieClip = null;
         var _loc5_:XButton = null;
         var _loc1_:MovieClip = this._mc.getMC().getChildByName("mc_card") as MovieClip;
         var _loc2_:int = 0;
         while(_loc2_ < this.CardItemCount)
         {
            _loc4_ = _loc1_.getChildByName("mc_list" + _loc2_) as MovieClip;
            _loc5_ = new XButton(_loc4_);
            _loc5_.Data = _loc2_;
            _loc5_.OnMouseOver = this.CardMouseOver;
            _loc5_.OnMouseDown = this.CardMouseDown;
            _loc5_.OnDoubleClick = this.CardDoubleClick;
            _loc4_.addEventListener(MouseEvent.MOUSE_OUT,this.CardMouseOut);
            _loc4_.addEventListener(MouseEvent.MOUSE_MOVE,this.CardMouseMove);
            this.CardItemList.push(_loc5_);
            _loc2_++;
         }
         _loc3_ = _loc1_.getChildByName("btn_left") as MovieClip;
         this.Card_btn_left = new HButton(_loc3_);
         _loc3_.addEventListener(MouseEvent.CLICK,this.Card_btn_leftClick);
         _loc3_ = _loc1_.getChildByName("btn_right") as MovieClip;
         this.Card_btn_right = new HButton(_loc3_);
         _loc3_.addEventListener(MouseEvent.CLICK,this.Card_btn_rightClick);
         this.Card_tf_page = _loc1_.getChildByName("tf_page") as TextField;
      }
      
      private function InitGoods() : void
      {
         var _loc3_:MovieClip = null;
         var _loc4_:MovieClip = null;
         var _loc5_:XButton = null;
         var _loc1_:MovieClip = this._mc.getMC().getChildByName("mc_goods") as MovieClip;
         var _loc2_:int = 0;
         while(_loc2_ < this.GoodsItemCount)
         {
            _loc4_ = _loc1_.getChildByName("mc_list" + _loc2_) as MovieClip;
            _loc5_ = new XButton(_loc4_);
            _loc5_.Data = _loc2_;
            _loc5_.OnMouseOver = this.GoodsMouseOver;
            _loc5_.OnDoubleClick = this.GoodsDoubleClick;
            _loc5_.OnMouseDown = this.GoodsMouseDown;
            _loc4_.addEventListener(MouseEvent.MOUSE_OUT,this.CardMouseOut);
            _loc4_.addEventListener(MouseEvent.MOUSE_MOVE,this.GoodsMouseMove);
            this.GoodsItemList.push(_loc5_);
            _loc2_++;
         }
         _loc3_ = _loc1_.getChildByName("btn_left") as MovieClip;
         this.Goods_btn_left = new HButton(_loc3_);
         _loc3_.addEventListener(MouseEvent.CLICK,this.Goods_btn_leftClick);
         _loc3_ = _loc1_.getChildByName("btn_right") as MovieClip;
         this.Goods_btn_right = new HButton(_loc3_);
         _loc3_.addEventListener(MouseEvent.CLICK,this.Goods_btn_rightClick);
         this.Goods_tf_page = _loc1_.getChildByName("tf_page") as TextField;
      }
      
      private function Clear() : void
      {
         var _loc2_:XML = null;
         this.DoubleComposeMode = false;
         this.CardPageIndex = 0;
         this.GoodsPageIndex = 0;
         this.ShowMoney();
         var _loc1_:TextField = this._mc.getMC().mc_samecard.tf_needgold as TextField;
         _loc1_.text = GamePlayer.getInstance().Commander_CardUnion.toString();
         if(GamePlayer.getInstance().UserMoney < GamePlayer.getInstance().Commander_CardUnion)
         {
            _loc1_.textColor = 16711680;
         }
         else
         {
            _loc1_.textColor = 65280;
         }
         this.btn_compose.setBtnDisabled(true);
         if(GamePlayer.getInstance().ConsortiaUnionLevel >= 0 && GamePlayer.getInstance().ConsortiaThrowValue >= GamePlayer.getInstance().ConsortiaUnionValue)
         {
            _loc2_ = CcorpsReader.getInstance().GetComposeUpgradeInfo(GamePlayer.getInstance().ConsortiaUnionLevel);
            TextField(this._mc.getMC().mc_samecard.tf_advance).text = _loc2_.@Odds + "%";
            this.CorpsSuccessRate = _loc2_.@Odds;
         }
         else
         {
            TextField(this._mc.getMC().mc_samecard.tf_advance).text = "0%";
            TextField(this._mc.getMC().mc_samecard.tf_advance).addEventListener(MouseEvent.MOUSE_OVER,this.tf_advanceOver);
            TextField(this._mc.getMC().mc_samecard.tf_advance).addEventListener(MouseEvent.MOUSE_OUT,this.tf_advanceOut);
            this.CorpsSuccessRate = 0;
         }
         this.btn_rongheClick(null);
         this._ShowDoubleCompose(false);
      }
      
      public function ShowDiamond() : void
      {
         this.Init();
         this.btn_qianghuaClick(null);
         GameKernel.popUpDisplayManager.Show(this);
      }
      
      public function ShowCommanderChip() : void
      {
         this.Init();
         this.btn_commanderchipClick(null);
         GameKernel.popUpDisplayManager.Show(this);
      }
      
      private function tf_advanceOver(param1:MouseEvent) : void
      {
         var _loc2_:String = StringManager.getInstance().getMessageString("CorpsText86");
         _loc2_ = _loc2_.replace("@@1",GamePlayer.getInstance().ConsortiaUnionValue);
         var _loc3_:Point = TextField(this._mc.getMC().mc_samecard.tf_advance).localToGlobal(new Point(0,TextField(this._mc.getMC().mc_samecard.tf_advance).height));
         CustomTip.GetInstance().Show(_loc2_,_loc3_);
      }
      
      private function tf_advanceOut(param1:MouseEvent) : void
      {
         CustomTip.GetInstance().Hide();
      }
      
      private function InitPackArray() : void
      {
         var _loc1_:PackPropsInfo = null;
         var _loc4_:propsInfo = null;
         this.DeletePackCard.splice(0);
         this.DeletePackGoods.splice(0);
         this.PackCard.splice(0);
         this.PackGoods.splice(0);
         var _loc2_:Array = ScienceSystem.getinstance().Packarr;
         var _loc3_:int = 0;
         while(_loc3_ < ScienceSystem.getinstance().Packarr.length)
         {
            if(ScienceSystem.getinstance().Packarr[_loc3_].StorageType == 0)
            {
               _loc4_ = CPropsReader.getInstance().GetPropsInfo(ScienceSystem.getinstance().Packarr[_loc3_].PropsId);
               if(_loc4_ != null)
               {
                  if(_loc4_.PackID == 1 && (this.DoubleComposeMode || ScienceSystem.getinstance().Packarr[_loc3_].PropsId % 9 < 8) && ScienceSystem.getinstance().Packarr[_loc3_].LockFlag == 0)
                  {
                     if(this.DoubleComposeMode == false || _loc4_.SkillID == this._ScrollPropsInfo.Skill1 || _loc4_.SkillID == this._ScrollPropsInfo.Skill0)
                     {
                        _loc1_ = new PackPropsInfo();
                        _loc1_.Num = ScienceSystem.getinstance().Packarr[_loc3_].PropsNum;
                        _loc1_.LockFlag = ScienceSystem.getinstance().Packarr[_loc3_].LockFlag;
                        _loc1_._PropsInfo = _loc4_;
                        _loc1_.Id = ScienceSystem.getinstance().Packarr[_loc3_].PropsId;
                        _loc1_.Grade = _loc1_.Id % 9;
                        _loc1_.CommanderType = int(_loc4_.CommanderType);
                        _loc1_.aCommanderInfo = CCommanderReader.getInstance().GetCommanderInfo(_loc4_.SkillID);
                        _loc1_.Type = _loc1_.aCommanderInfo.Type;
                        this.PackCard.push(_loc1_);
                     }
                  }
                  else if(_loc4_.List == 16)
                  {
                     _loc1_ = new PackPropsInfo();
                     _loc1_.Num = ScienceSystem.getinstance().Packarr[_loc3_].PropsNum;
                     _loc1_.LockFlag = ScienceSystem.getinstance().Packarr[_loc3_].LockFlag;
                     _loc1_._PropsInfo = _loc4_;
                     _loc1_.Id = ScienceSystem.getinstance().Packarr[_loc3_].PropsId;
                     this.PackGoods.push(_loc1_);
                  }
               }
            }
            _loc3_++;
         }
         this.PackCard.sortOn(["Grade","Type","CommanderType","Id"],Array.NUMERIC);
         this.PackGoods.sortOn("Id",Array.NUMERIC);
         this.btn_buy.setVisible(this.PackGoods.length == 0);
      }
      
      private function CloseClick(param1:Event) : void
      {
         if(this.HasChip)
         {
            ComposeUI_FlagShip.GetInstance().Stop();
         }
         GameKernel.popUpDisplayManager.Hide(this);
      }
      
      private function btn_rongheClick(param1:Event) : void
      {
         this.SetPanleVisible(true,false,false);
         this.ResetSelectedBtn(this.btn_ronghe);
         this.btn_samecardClick(null);
         this.btn_help.setVisible(true);
      }
      
      private function _ShowDoubleCompose(param1:Boolean) : void
      {
         this.mc_doubleskill.visible = param1;
         this.btn_samecard.setVisible(!param1);
         this.btn_othercard.setVisible(!param1);
         this.McCardBase2.visible = !param1;
         MovieClip(this.mc_samecard.mc_line1).visible = !param1;
         this.btn_ronghe.setVisible(!param1);
         this.btn_qianghua.setVisible(!param1);
         this.btn_hecheng.setVisible(!param1);
         if(this.btn_qijianmerge)
         {
            this.btn_qijianmerge.setVisible(!param1);
         }
         if(this.btn_commanderchip)
         {
            this.btn_commanderchip.setVisible(!param1);
         }
         TextField(this._mc.getMC().mc_samecard.tf_advance).visible = !param1;
      }
      
      private function SetPanleVisible(param1:Boolean, param2:Boolean, param3:Boolean, param4:Boolean = false, param5:Boolean = false, param6:Boolean = false) : void
      {
         this._mc.getMC().mc_samecard.visible = param1;
         this._mc.getMC().mc_card.visible = param1;
         this._mc.getMC().mc_goods.visible = param1;
         this._mc.getMC().mc_gem.visible = param2;
         this._mc.getMC().mc_card3.visible = param2;
         this._mc.getMC().mc_commander.visible = param3;
         this._mc.getMC().mc_card2.visible = param3;
         if(this.HasChip)
         {
            this._mc.getMC().mc_qijianmerge.visible = param4;
            this._mc.getMC().mc_commanderchip0.visible = param6;
            this._mc.getMC().mc_commanderchip1.visible = param6;
         }
      }
      
      private function btn_qijianmergeClick(param1:MouseEvent) : void
      {
         this.SetPanleVisible(false,false,false,true);
         this.ResetSelectedBtn(this.btn_qijianmerge);
         ComposeUI_FlagShip.GetInstance().Clear();
         this.btn_help.setVisible(false);
         this.CloseHelp(null);
      }
      
      private function btn_commanderchipClick(param1:MouseEvent) : void
      {
         this.SetPanleVisible(false,false,false,false,false,true);
         this.ResetSelectedBtn(this.btn_commanderchip);
         ComposeUI_CommanderChip.GetInstance().Clear();
         this.btn_help.setVisible(false);
         this.CloseHelp(null);
      }
      
      private function btn_qianghuaClick(param1:Event) : void
      {
         this.SetPanleVisible(false,true,false);
         this.ResetSelectedBtn(this.btn_qianghua);
         ComposeUI_Diamond.GetInstance().Clear();
         this.btn_help.setVisible(false);
         this.CloseHelp(null);
      }
      
      private function btn_hechengClick(param1:Event) : void
      {
         this.SetPanleVisible(false,false,true);
         this.ResetSelectedBtn(this.btn_hecheng);
         ComposeUI_Commander.GetInstance().Clear();
         this.btn_help.setVisible(false);
         this.CloseHelp(null);
      }
      
      private function btn_samecardClick(param1:Event) : void
      {
         this.ResetSelectedBtn2(this.btn_samecard);
         this.ClearComposeItem();
         this.McCardBase1.gotoAndStop(4);
         this.McCardBase2.gotoAndStop(4);
         this.McCardBase3.gotoAndStop(1);
         this.McCardBase4.gotoAndStop(1);
         this.GoodsBase.gotoAndStop(1);
         this.ShowProps();
         this.ComposeType = 1;
      }
      
      private function btn_othercardClick(param1:Event) : void
      {
         this.ResetSelectedBtn2(this.btn_othercard);
         this.ClearComposeItem();
         this.McCardBase1.gotoAndStop(2);
         this.McCardBase2.gotoAndStop(2);
         this.McCardBase3.gotoAndStop(2);
         this.McCardBase4.gotoAndStop(1);
         this.GoodsBase.gotoAndStop(1);
         this.ShowProps();
         this.ComposeType = 2;
      }
      
      private function ShowProps() : void
      {
         this.InitPackArray();
         this.ShowCurPageCard();
         this.ShowCurPageGoods();
      }
      
      private function ClearComposeItem() : void
      {
         var _loc2_:MovieClip = null;
         if(this.McCardBase1.mc_base1.numChildren > 0)
         {
            this.McCardBase1.mc_base1.removeChildAt(0);
            this.McCardBase1.prevFrame();
         }
         if(this.McCardBase2.mc_base1.numChildren > 0)
         {
            this.McCardBase2.mc_base1.removeChildAt(0);
            this.McCardBase2.prevFrame();
         }
         if(this.McCardBase3.mc_base1.numChildren > 0)
         {
            this.McCardBase3.mc_base1.removeChildAt(0);
            this.McCardBase3.prevFrame();
         }
         if(this.McCardBase4.mc_base1.numChildren > 0)
         {
            this.McCardBase4.mc_base1.removeChildAt(0);
         }
         this.GoodsBase.gotoAndStop(1);
         if(this.ResultBase.numChildren > 3)
         {
            this.ResultBase.removeChildAt(3);
            this.ResultBase.gotoAndStop(1);
         }
         var _loc1_:int = 0;
         while(_loc1_ < 6)
         {
            _loc2_ = this.mc_samecard.getChildByName("mc_line" + _loc1_) as MovieClip;
            _loc2_.gotoAndStop(1);
            _loc1_++;
         }
         this.SameCard1 = -1;
         this.SameCard2 = -1;
         this.OtherCard1 = -1;
         this.OtherCard2 = -1;
         this.OtherCard3 = -1;
         this.DoubleCard1 = -1;
         this.DoubleCard2 = -1;
         this.ComposeGoodsId = -1;
         this.ResultCardId = -1;
         this.SelectedCardId = -1;
         TextField(this._mc.getMC().mc_samecard.tf_rate).text = "";
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
      
      private function ResetSelectedBtn2(param1:HButton) : void
      {
         if(this.SelectedBtn2 != null)
         {
            this.SelectedBtn2.setSelect(false);
         }
         this.SelectedBtn2 = param1;
         this.SelectedBtn2.setSelect(true);
      }
      
      private function ShowCardTip(param1:MovieClip, param2:int) : void
      {
         if(param2 < 0)
         {
            return;
         }
         var _loc3_:Point = param1.localToGlobal(new Point(0,param1.height));
         _loc3_ = this._mc.getMC().globalToLocal(_loc3_);
         this._PropsTip = PackUi.getInstance().TipHd(_loc3_.x,_loc3_.y,param2,true);
         this._PropsTip.x = _loc3_.x - 80;
         this._PropsTip.y = _loc3_.y;
         this._mc.getMC().addChild(this._PropsTip);
      }
      
      private function CardMouseOver(param1:MouseEvent, param2:XButton) : void
      {
         var _loc3_:int = this.CardPageIndex * this.CardItemCount + param2.Data;
         var _loc4_:PackPropsInfo = this.PackCard[_loc3_];
         this.ShowCardTip(param2.m_movie,_loc4_.Id);
      }
      
      private function CardMouseOut(param1:MouseEvent) : void
      {
         if(this._PropsTip != null && this._PropsTip.parent != null && this._PropsTip.parent.contains(this._PropsTip))
         {
            this._PropsTip.parent.removeChild(this._PropsTip);
         }
      }
      
      private function ShowGoodsTip(param1:MovieClip, param2:int) : void
      {
         if(param2 < 0)
         {
            return;
         }
         var _loc3_:Point = param1.localToGlobal(new Point(0,param1.height));
         _loc3_ = this._mc.getMC().globalToLocal(_loc3_);
         this._PropsTip = PackUi.getInstance().TipHd(_loc3_.x,_loc3_.y,param2,true);
         this._PropsTip.x = _loc3_.x - 20;
         this._PropsTip.y = _loc3_.y - 20;
         this._mc.getMC().addChild(this._PropsTip);
      }
      
      private function GoodsMouseOver(param1:MouseEvent, param2:XButton) : void
      {
         var _loc3_:int = this.GoodsPageIndex * this.GoodsItemCount + param2.Data;
         var _loc4_:PackPropsInfo = this.PackGoods[_loc3_];
         this.ShowGoodsTip(param2.m_movie,_loc4_.Id);
      }
      
      private function DoubleComposeCard() : void
      {
         var _loc1_:MSG_REQUEST_UNIONDOUBLESKILLCARD = new MSG_REQUEST_UNIONDOUBLESKILLCARD();
         _loc1_.Card1 = this.DoubleCard1;
         _loc1_.Card2 = this.DoubleCard2;
         _loc1_.Goods = this._ScrollPropsInfo.PropsId;
         _loc1_.GoodsLockFlag = this._ScrollPropsInfoLockFlag;
         _loc1_.Chip = this.ComposeGoodsId;
         _loc1_.ChipLockFlag = this.ComposeGoodsLockFlag;
         _loc1_.SeqId = GamePlayer.getInstance().seqID++;
         _loc1_.Guid = GamePlayer.getInstance().Guid;
         NetManager.Instance().sendObject(_loc1_);
         --this._ScrollNum;
         if(this._ScrollNum == 0)
         {
            this.CloseClick(null);
         }
         TextField(this.mc_doubleskill.getChildByName("txt_num")).text = this._ScrollNum.toString();
         this.Invalid(false);
         this.ClearDoubleCompose();
         this.btn_compose.setBtnDisabled(true);
      }
      
      private function ComposeCard() : void
      {
         var _loc2_:int = 0;
         if(this.DoubleComposeMode)
         {
            this.DoubleComposeCard();
            return;
         }
         var _loc1_:MSG_REQUEST_UNIONCOMMANDERCARD = new MSG_REQUEST_UNIONCOMMANDERCARD();
         _loc1_.Goods = this.ComposeGoodsId;
         _loc1_.GoodsLockFlag = this.ComposeGoodsLockFlag;
         if(this.ComposeType == 1)
         {
            _loc2_ = UpdateResource.getInstance().HasPackSpace(this.SameCard1 + 1);
            if(_loc2_ == 1)
            {
               MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("CommanderText12"),10);
               return;
            }
            if(_loc2_ == 2)
            {
               MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("BagTXT20"),0);
               return;
            }
            _loc1_.Card1 = this.SameCard1;
            _loc1_.Card2 = this.SameCard2;
            _loc1_.Card3 = -1;
         }
         else
         {
            _loc2_ = UpdateResource.getInstance().HasPackSpace(this.OtherCard2 + 1);
            if(_loc2_ == 1)
            {
               MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("CommanderText12"),10);
               return;
            }
            if(_loc2_ == 2)
            {
               MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("BagTXT20"),0);
               return;
            }
            _loc1_.Card1 = this.OtherCard1;
            _loc1_.Card2 = this.OtherCard2;
            _loc1_.Card3 = this.OtherCard3;
         }
         _loc1_.SeqId = GamePlayer.getInstance().seqID++;
         _loc1_.Guid = GamePlayer.getInstance().Guid;
         NetManager.Instance().sendObject(_loc1_);
         this.Invalid(false);
         this.ClearComposeItem();
         this.btn_compose.setBtnDisabled(true);
      }
      
      private function btn_composeClick(param1:MouseEvent) : void
      {
         if(this.SuccessRate + this.addRate < 100)
         {
            if(this.DoubleComposeMode)
            {
               MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("Boss35"),2,this.ComposeCard);
            }
            else
            {
               MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("CorpsText126"),2,this.ComposeCard);
            }
         }
         else
         {
            this.ComposeCard();
         }
      }
      
      private function Goods_btn_leftClick(param1:Event) : void
      {
         --this.GoodsPageIndex;
         this.ShowCurPageGoods();
         this.ResetGoodsPageButton();
      }
      
      private function Goods_btn_rightClick(param1:Event) : void
      {
         ++this.GoodsPageIndex;
         this.ShowCurPageGoods();
         this.ResetGoodsPageButton();
      }
      
      private function Card_btn_leftClick(param1:Event) : void
      {
         --this.CardPageIndex;
         this.ShowCurPageCard();
         this.ResetCardPageButton();
      }
      
      private function Card_btn_rightClick(param1:Event) : void
      {
         ++this.CardPageIndex;
         this.ShowCurPageCard();
         this.ResetCardPageButton();
      }
      
      private function ShowCurPageCard() : void
      {
         var _loc3_:XButton = null;
         var _loc4_:MovieClip = null;
         var _loc5_:TextField = null;
         var _loc6_:PackPropsInfo = null;
         var _loc7_:Bitmap = null;
         var _loc1_:int = this.CardPageIndex * this.CardItemCount;
         var _loc2_:int = 0;
         while(_loc2_ < this.CardItemCount)
         {
            _loc3_ = this.CardItemList[_loc2_];
            _loc4_ = _loc3_.m_movie.mc_base;
            if(_loc4_.numChildren > 0)
            {
               _loc4_.removeChildAt(0);
            }
            _loc5_ = _loc3_.m_movie.tf_num as TextField;
            _loc5_.text = "";
            if(_loc1_ < this.PackCard.length)
            {
               _loc6_ = this.PackCard[_loc1_];
               _loc7_ = new Bitmap(GameKernel.getTextureInstance(_loc6_._PropsInfo.ImageFileName));
               _loc4_.addChild(_loc7_);
               _loc5_.text = _loc6_.Num.toString();
               _loc3_.setBtnDisabled(false);
            }
            else
            {
               _loc3_.setBtnDisabled(true);
            }
            _loc1_++;
            _loc2_++;
         }
         this.ResetCardPageButton();
      }
      
      private function ResetCardPageButton() : void
      {
         this.CardPageCount = this.PackCard.length / this.CardItemCount;
         if(this.CardPageCount * this.CardItemCount < this.PackCard.length)
         {
            ++this.CardPageCount;
         }
         if(this.CardPageCount == 0)
         {
            this.Card_tf_page.text = "1/1";
            this.Card_btn_left.setBtnDisabled(true);
            this.Card_btn_right.setBtnDisabled(true);
            return;
         }
         if(this.CardPageIndex > 0)
         {
            this.Card_btn_left.setBtnDisabled(false);
         }
         else
         {
            this.Card_btn_left.setBtnDisabled(true);
         }
         if(this.CardPageIndex + 1 < this.CardPageCount)
         {
            this.Card_btn_right.setBtnDisabled(false);
         }
         else
         {
            this.Card_btn_right.setBtnDisabled(true);
         }
         this.Card_tf_page.text = this.CardPageIndex + 1 + "/" + this.CardPageCount;
      }
      
      private function ShowCurPageGoods() : void
      {
         var _loc3_:XButton = null;
         var _loc4_:MovieClip = null;
         var _loc5_:TextField = null;
         var _loc6_:PackPropsInfo = null;
         var _loc7_:Bitmap = null;
         var _loc8_:MovieClip = null;
         var _loc1_:int = this.GoodsPageIndex * this.GoodsItemCount;
         var _loc2_:int = 0;
         while(_loc2_ < this.GoodsItemCount)
         {
            _loc3_ = this.GoodsItemList[_loc2_];
            _loc4_ = _loc3_.m_movie.mc_base;
            if(_loc4_.numChildren > 0)
            {
               _loc4_.removeChildAt(0);
            }
            if(_loc4_.numChildren > 0)
            {
               _loc4_.removeChildAt(0);
            }
            _loc5_ = _loc3_.m_movie.tf_num as TextField;
            _loc5_.text = "";
            if(_loc1_ < this.PackGoods.length)
            {
               _loc6_ = this.PackGoods[_loc1_];
               _loc7_ = new Bitmap(GameKernel.getTextureInstance(_loc6_._PropsInfo.ImageFileName));
               _loc4_.addChild(_loc7_);
               _loc5_.text = _loc6_.Num.toString();
               if(_loc6_.LockFlag == 1)
               {
                  _loc8_ = GameKernel.getMovieClipInstance("lock");
                  _loc8_.width = 13;
                  _loc8_.height = 15;
                  _loc8_.x = 27;
                  _loc4_.addChild(_loc8_);
               }
               _loc3_.setBtnDisabled(false);
            }
            else
            {
               _loc3_.setBtnDisabled(true);
            }
            _loc1_++;
            _loc2_++;
         }
         this.ResetGoodsPageButton();
      }
      
      private function ResetGoodsPageButton() : void
      {
         this.GoodsPageCount = this.PackGoods.length / this.GoodsItemCount;
         if(this.GoodsPageCount * this.GoodsItemCount < this.PackGoods.length)
         {
            ++this.GoodsPageCount;
         }
         if(this.GoodsPageCount == 0)
         {
            this.Goods_tf_page.text = "1/1";
            this.Goods_btn_left.setBtnDisabled(true);
            this.Goods_btn_right.setBtnDisabled(true);
            return;
         }
         if(this.GoodsPageIndex > 0)
         {
            this.Goods_btn_left.setBtnDisabled(false);
         }
         else
         {
            this.Goods_btn_left.setBtnDisabled(true);
         }
         if(this.GoodsPageIndex + 1 < this.GoodsPageCount)
         {
            this.Goods_btn_right.setBtnDisabled(false);
         }
         else
         {
            this.Goods_btn_right.setBtnDisabled(true);
         }
         this.Goods_tf_page.text = this.GoodsPageIndex + 1 + "/" + this.GoodsPageCount;
      }
      
      private function CardMouseDown(param1:MouseEvent, param2:XButton) : void
      {
         var _loc3_:Point = param2.m_movie.localToGlobal(new Point(0,0));
         _loc3_ = this._mc.getMC().globalToLocal(_loc3_);
         var _loc4_:int = this.CardPageIndex * this.CardItemCount + param2.Data;
         var _loc5_:PackPropsInfo = this.PackCard[_loc4_];
         var _loc6_:MovieClip = this.GetPropsImage(_loc5_._PropsInfo.ImageFileName,_loc3_.x,_loc3_.y);
         this.SelectedItem = _loc6_;
         this.SelectedCardId = _loc4_;
      }
      
      private function CardMouseMove(param1:MouseEvent) : void
      {
         if(param1.buttonDown && this.SelectedItem != null && !this._mc.getMC().contains(this.SelectedItem))
         {
            this.SelectedItem.addEventListener(MouseEvent.MOUSE_UP,this.SelectedItemMouseUp);
            this._mc.getMC().addChild(this.SelectedItem);
            this.SelectedItem.startDrag(true);
         }
      }
      
      private function GoodsMouseDown(param1:MouseEvent, param2:XButton) : void
      {
         var _loc3_:Point = param2.m_movie.localToGlobal(new Point(0,0));
         _loc3_ = this._mc.getMC().globalToLocal(_loc3_);
         var _loc4_:int = this.GoodsPageIndex * this.GoodsItemCount + param2.Data;
         var _loc5_:PackPropsInfo = this.PackGoods[_loc4_];
         var _loc6_:MovieClip = this.GetPropsImage(_loc5_._PropsInfo.ImageFileName,_loc3_.x,_loc3_.y);
         this.SelectedItem = _loc6_;
         this.SelectedGoodsId = _loc4_;
      }
      
      private function GoodsMouseMove(param1:MouseEvent) : void
      {
         if(param1.buttonDown && this.SelectedItem != null && !this._mc.getMC().contains(this.SelectedItem))
         {
            this.SelectedItem.addEventListener(MouseEvent.MOUSE_UP,this.SelectedGoodsItemMouseUp);
            this._mc.getMC().addChild(this.SelectedItem);
            this.SelectedItem.startDrag(true);
         }
      }
      
      private function AutoFindCard() : void
      {
         var _loc1_:MovieClip = null;
         var _loc2_:Bitmap = null;
         var _loc3_:PackPropsInfo = null;
         if(this.DoubleComposeMode)
         {
            return;
         }
         if(this.ComposeType == 1 && this.SameCard2 == -1 && this.SelectedCardId < this.PackCard.length)
         {
            _loc3_ = this.PackCard[this.SelectedCardId];
            if(_loc3_.Id == this.SameCard1)
            {
               _loc2_ = new Bitmap(GameKernel.getTextureInstance(_loc3_._PropsInfo.ImageFileName));
               _loc2_.x = 0;
               _loc2_.y = 0;
               _loc1_ = this.McCardBase2;
               this.SameCard2 = _loc3_.Id;
               this.ResetCard(-1,this.SameCard2);
            }
         }
         if(_loc1_ != null)
         {
            if(_loc1_.mc_base1.numChildren > 0)
            {
               _loc1_.mc_base1.removeChildAt(0);
            }
            _loc1_.mc_base1.addChild(_loc2_);
            _loc1_.nextFrame();
            this.ShowResult();
         }
      }
      
      private function CardDoubleClick(param1:MouseEvent, param2:XButton) : void
      {
         this.AddCard();
      }
      
      private function AddCard() : void
      {
         var _loc3_:MovieClip = null;
         var _loc1_:PackPropsInfo = this.PackCard[this.SelectedCardId];
         var _loc2_:Bitmap = new Bitmap(GameKernel.getTextureInstance(_loc1_._PropsInfo.ImageFileName));
         _loc2_.x = 0;
         _loc2_.y = 0;
         if(this.DoubleComposeMode)
         {
            if(this.DoubleCard1 == -1 && this.CheckCard(_loc1_.Id,this.DoubleCard2))
            {
               _loc3_ = this.McCardBase1;
               this.DoubleCard1 = _loc1_.Id;
               this.ResetCard(-1,this.DoubleCard1);
            }
            else if(this.DoubleCard2 == -1 && this.CheckCard(this.DoubleCard1,_loc1_.Id))
            {
               _loc3_ = this.McCardBase3;
               this.DoubleCard2 = _loc1_.Id;
               this.ResetCard(-1,this.DoubleCard2);
            }
         }
         else if(this.ComposeType == 1)
         {
            if(this.SameCard1 == -1 && this.CheckCard(_loc1_.Id,this.SameCard2))
            {
               _loc3_ = this.McCardBase1;
               this.SameCard1 = _loc1_.Id;
               this.ResetCard(-1,this.SameCard1);
            }
            else if(this.SameCard2 == -1 && this.CheckCard(this.SameCard1,_loc1_.Id))
            {
               _loc3_ = this.McCardBase2;
               this.SameCard2 = _loc1_.Id;
               this.ResetCard(-1,this.SameCard2);
            }
         }
         else if(this.OtherCard1 == -1 && this.CheckCard(_loc1_.Id,this.OtherCard2,this.OtherCard3))
         {
            _loc3_ = this.McCardBase2;
            this.OtherCard1 = _loc1_.Id;
            this.ResetCard(-1,this.OtherCard1);
         }
         else if(this.OtherCard2 == -1 && this.CheckCard(this.OtherCard1,_loc1_.Id,this.OtherCard3))
         {
            _loc3_ = this.McCardBase1;
            this.OtherCard2 = _loc1_.Id;
            this.ResetCard(-1,this.OtherCard2);
         }
         else if(this.OtherCard3 == -1 && this.CheckCard(this.OtherCard1,this.OtherCard2,_loc1_.Id))
         {
            _loc3_ = this.McCardBase3;
            this.OtherCard3 = _loc1_.Id;
            this.ResetCard(-1,this.OtherCard3);
         }
         if(_loc3_ != null)
         {
            if(_loc3_.mc_base1.numChildren > 0)
            {
               _loc3_.mc_base1.removeChildAt(0);
            }
            _loc3_.mc_base1.addChild(_loc2_);
            _loc3_.nextFrame();
            this.ShowResult();
            this.AutoFindCard();
         }
         this.SelectedItem = null;
      }
      
      private function GetPropsImage(param1:String, param2:int = 0, param3:int = 0) : MovieClip
      {
         var _loc4_:MovieClip = GameKernel.getMovieClipInstance("moban",param2,param3);
         var _loc5_:Bitmap = new Bitmap(GameKernel.getTextureInstance(param1));
         _loc5_.x = -20;
         _loc5_.y = -20;
         _loc4_.addChild(_loc5_);
         _loc4_.width = 50;
         _loc4_.height = 50;
         return _loc4_;
      }
      
      private function IsInBase(param1:MovieClip, param2:Point) : Boolean
      {
         if(param2.x >= param1.x && param2.x < param1.x + 40 && param2.y >= param1.y && param2.y < param1.y + 40)
         {
            return true;
         }
         return false;
      }
      
      private function CheckCard(param1:int, param2:int, param3:int = -1) : Boolean
      {
         var _loc4_:int = 0;
         var _loc5_:CommanderXmlInfo = null;
         var _loc6_:int = 0;
         var _loc7_:CommanderXmlInfo = null;
         var _loc8_:CommanderXmlInfo = null;
         var _loc9_:CommanderXmlInfo = null;
         var _loc10_:CommanderXmlInfo = null;
         if(this.DoubleComposeMode)
         {
            if(param1 == -1)
            {
               _loc4_ = CPropsReader.getInstance().GetPropsInfo(param2).SkillID;
               return _loc4_ == this._ScrollPropsInfo.Skill0 || _loc4_ == this._ScrollPropsInfo.Skill1;
            }
            if(param2 == -1)
            {
               _loc4_ = CPropsReader.getInstance().GetPropsInfo(param1).SkillID;
               return _loc4_ == this._ScrollPropsInfo.Skill0 || _loc4_ == this._ScrollPropsInfo.Skill1;
            }
            _loc4_ = CPropsReader.getInstance().GetPropsInfo(param1).SkillID;
            if(_loc4_ == this._ScrollPropsInfo.Skill0)
            {
               _loc4_ = CPropsReader.getInstance().GetPropsInfo(param2).SkillID;
               return _loc4_ == this._ScrollPropsInfo.Skill1;
            }
            if(_loc4_ == this._ScrollPropsInfo.Skill1)
            {
               _loc4_ = CPropsReader.getInstance().GetPropsInfo(param2).SkillID;
               return _loc4_ == this._ScrollPropsInfo.Skill0;
            }
            return false;
         }
         if(this.ComposeType == 1)
         {
            if(param1 == -1 || param2 == -1)
            {
               return true;
            }
            if(param1 != param2)
            {
               return this.ShowCheckMessage();
            }
            return true;
         }
         if(param1 != -1)
         {
            _loc5_ = this.GetCommanderInfo(param1);
            _loc6_ = param1 % 9;
            if(param2 != -1)
            {
               _loc7_ = this.GetCommanderInfo(param2);
               if(param2 % 9 != _loc6_ || _loc7_.Type != _loc5_.Type)
               {
                  return this.ShowCheckMessage();
               }
            }
            if(param3 != -1)
            {
               _loc8_ = this.GetCommanderInfo(param3);
               if(param3 % 9 != _loc6_ || _loc8_.Type != _loc5_.Type)
               {
                  return this.ShowCheckMessage();
               }
            }
            return true;
         }
         if(param2 == -1 || param3 == -1)
         {
            return true;
         }
         _loc9_ = this.GetCommanderInfo(param2);
         _loc10_ = this.GetCommanderInfo(param3);
         if(param2 % 9 != param3 % 9 || _loc9_.Type != _loc10_.Type)
         {
            return this.ShowCheckMessage();
         }
         return true;
      }
      
      private function GetCommanderInfo(param1:int) : CommanderXmlInfo
      {
         var _loc2_:propsInfo = CPropsReader.getInstance().GetPropsInfo(param1);
         return CCommanderReader.getInstance().GetCommanderInfo(_loc2_.SkillID);
      }
      
      private function ShowCheckMessage() : Boolean
      {
         if(this.ComposeType == 1)
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("CommanderText79"),0);
         }
         else
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("CommanderText80"),0);
         }
         return false;
      }
      
      private function SelectedItemMouseUp(param1:MouseEvent) : void
      {
         var _loc6_:int = 0;
         var _loc7_:MovieClip = null;
         var _loc2_:Boolean = false;
         var _loc3_:PackPropsInfo = this.PackCard[this.SelectedCardId];
         var _loc4_:Bitmap = new Bitmap(GameKernel.getTextureInstance(_loc3_._PropsInfo.ImageFileName));
         _loc4_.x = 0;
         _loc4_.y = 0;
         var _loc5_:Point = this._mc.getMC().localToGlobal(new Point(this.SelectedItem.x,this.SelectedItem.y));
         _loc5_ = this.mc_samecard.globalToLocal(_loc5_);
         if(this.DoubleComposeMode)
         {
            if(this.IsInBase(this.McCardBase1,_loc5_) && this.CheckCard(_loc3_.Id,this.DoubleCard2))
            {
               _loc6_ = this.DoubleCard1;
               _loc7_ = this.McCardBase1;
               this.DoubleCard1 = _loc3_.Id;
               this.ResetCard(_loc6_,this.DoubleCard1);
            }
            else if(this.IsInBase(this.McCardBase3,_loc5_) && this.CheckCard(this.DoubleCard1,_loc3_.Id))
            {
               _loc6_ = this.DoubleCard2;
               _loc7_ = this.McCardBase3;
               this.DoubleCard2 = _loc3_.Id;
               this.ResetCard(_loc6_,this.DoubleCard2);
            }
         }
         else if(this.ComposeType == 1)
         {
            if(this.IsInBase(this.McCardBase1,_loc5_) && this.CheckCard(_loc3_.Id,this.SameCard2))
            {
               _loc6_ = this.SameCard1;
               _loc7_ = this.McCardBase1;
               this.SameCard1 = _loc3_.Id;
               this.ResetCard(_loc6_,this.SameCard1);
            }
            else if(this.IsInBase(this.McCardBase2,_loc5_) && this.CheckCard(this.SameCard1,_loc3_.Id))
            {
               _loc6_ = this.SameCard2;
               _loc7_ = this.McCardBase2;
               this.SameCard2 = _loc3_.Id;
               this.ResetCard(_loc6_,this.SameCard2);
            }
         }
         else if(this.IsInBase(this.McCardBase2,_loc5_) && this.CheckCard(_loc3_.Id,this.OtherCard2,this.OtherCard3))
         {
            _loc6_ = this.OtherCard1;
            _loc7_ = this.McCardBase2;
            this.OtherCard1 = _loc3_.Id;
            this.ResetCard(_loc6_,this.OtherCard1);
         }
         else if(this.IsInBase(this.McCardBase1,_loc5_) && this.CheckCard(this.OtherCard1,_loc3_.Id,this.OtherCard3))
         {
            _loc6_ = this.OtherCard2;
            _loc7_ = this.McCardBase1;
            this.OtherCard2 = _loc3_.Id;
            this.ResetCard(_loc6_,this.OtherCard2);
         }
         else if(this.IsInBase(this.McCardBase3,_loc5_) && this.CheckCard(this.OtherCard1,this.OtherCard2,_loc3_.Id))
         {
            _loc6_ = this.OtherCard3;
            _loc7_ = this.McCardBase3;
            this.OtherCard3 = _loc3_.Id;
            this.ResetCard(_loc6_,this.OtherCard3);
         }
         if(_loc7_ != null)
         {
            if(_loc7_.mc_base1.numChildren > 0)
            {
               _loc7_.mc_base1.removeChildAt(0);
            }
            _loc7_.mc_base1.addChild(_loc4_);
            _loc7_.nextFrame();
            this.ShowResult();
            this.AutoFindCard();
         }
         this.SelectedItem.stopDrag();
         if(this._mc.getMC().contains(this.SelectedItem))
         {
            this._mc.getMC().removeChild(this.SelectedItem);
         }
         this.SelectedItem = null;
      }
      
      private function ShowLine() : void
      {
         if(this.DoubleComposeMode)
         {
            MovieClip(this.mc_samecard.mc_line0).gotoAndStop(this.DoubleCard1 != -1 ? 2 : 1);
            MovieClip(this.mc_samecard.mc_line2).gotoAndStop(this.DoubleCard2 != -1 ? 2 : 1);
         }
         else if(this.ComposeType == 1)
         {
            MovieClip(this.mc_samecard.mc_line0).gotoAndStop(this.SameCard1 != -1 ? 2 : 1);
            MovieClip(this.mc_samecard.mc_line1).gotoAndStop(this.SameCard2 != -1 ? 2 : 1);
            MovieClip(this.mc_samecard.mc_line2).gotoAndStop(1);
         }
         else
         {
            MovieClip(this.mc_samecard.mc_line0).gotoAndStop(this.OtherCard2 != -1 ? 2 : 1);
            MovieClip(this.mc_samecard.mc_line1).gotoAndStop(this.OtherCard1 != -1 ? 2 : 1);
            MovieClip(this.mc_samecard.mc_line2).gotoAndStop(this.OtherCard3 != -1 ? 2 : 1);
         }
      }
      
      private function ShowResultCard() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:propsInfo = null;
         this.ResultCardId = -1;
         if(this.ResultBase.numChildren > 3)
         {
            this.ResultBase.removeChildAt(3);
            this.ResultBase.gotoAndStop(1);
         }
         if(this.DoubleComposeMode)
         {
            if(this.DoubleCard1 == -1 || this.DoubleCard2 == -1)
            {
               return;
            }
            _loc1_ = this.DoubleCard1 % 9;
            _loc2_ = this.DoubleCard2 % 9;
            this.ResultCardId = this.DoubleComposeResultCardId + (_loc1_ + _loc2_) / 2;
         }
         else if(this.ComposeType == 1)
         {
            if(this.SameCard1 != -1)
            {
               this.ResultCardId = this.SameCard1 + 1;
            }
            else if(this.SameCard2 != -1)
            {
               this.ResultCardId = this.SameCard2 + 1;
            }
         }
         else if(this.OtherCard1 != -1)
         {
            this.ResultCardId = this.OtherCard1 + 1;
         }
         if(this.ResultCardId > 0)
         {
            _loc3_ = CPropsReader.getInstance().GetPropsInfo(this.ResultCardId);
            this.ResultPropsImg = new Bitmap(GameKernel.getTextureInstance(_loc3_.ImageFileName));
            this.ResultPropsImg.x = 8;
            this.ResultPropsImg.y = 8;
            this.ResultBase.gotoAndStop(2);
            this.ResultBase.addChild(this.ResultPropsImg);
         }
      }
      
      private function ShowResult() : void
      {
         this.ShowSuccessRate();
         this.ShowComposeButton();
         this.ShowLine();
         this.ShowResultCard();
      }
      
      private function GoodsDoubleClick(param1:MouseEvent, param2:XButton) : void
      {
         var _loc3_:int = this.GoodsPageIndex * this.GoodsItemCount + param2.Data;
         this.SelectedItem = null;
         this.SetGoods(_loc3_);
      }
      
      private function SelectedGoodsItemMouseUp(param1:MouseEvent) : void
      {
         var _loc2_:Point = this._mc.getMC().localToGlobal(new Point(this.SelectedItem.x,this.SelectedItem.y));
         _loc2_ = this.mc_samecard.globalToLocal(_loc2_);
         if(this.IsInBase(this.GoodsBase,_loc2_))
         {
            this.SetGoods(this.SelectedGoodsId);
         }
         this.SelectedItem.stopDrag();
         if(this._mc.getMC().contains(this.SelectedItem))
         {
            this._mc.getMC().removeChild(this.SelectedItem);
         }
         this.SelectedItem = null;
      }
      
      private function SetGoods(param1:int) : void
      {
         var _loc2_:PackPropsInfo = this.PackGoods[param1];
         this.ResetGoods(_loc2_.Id,_loc2_.LockFlag);
         this.ComposeGoodsId = _loc2_.Id;
         this.ComposeGoods_Rate = _loc2_._PropsInfo.Probability;
         this.ComposeGoodsLockFlag = _loc2_.LockFlag;
         this.GoodsBase.gotoAndStop(2);
         this.ShowSuccessRate();
      }
      
      private function ShowSuccessRate() : void
      {
         if(this.DoubleComposeMode == false)
         {
            if(this.ComposeType == 1)
            {
               if(this.SameCard1 != -1)
               {
                  this.SuccessRate = CCommanderReader.getInstance().GetComposeRate(this.SameCard1 % 9);
               }
               else if(this.SameCard2 != -1)
               {
                  this.SuccessRate = CCommanderReader.getInstance().GetComposeRate(this.SameCard2 % 9);
               }
            }
            else if(this.OtherCard1 != -1)
            {
               this.SuccessRate = CCommanderReader.getInstance().GetComposeRate(this.OtherCard1 % 9);
            }
            else if(this.OtherCard2 != -1)
            {
               this.SuccessRate = CCommanderReader.getInstance().GetComposeRate(this.OtherCard2 % 9);
            }
            else if(this.OtherCard3 != -1)
            {
               this.SuccessRate = CCommanderReader.getInstance().GetComposeRate(this.OtherCard3 % 9);
            }
            this.addRate = 0;
            this.addRate += this.CorpsSuccessRate;
         }
         else
         {
            this.SuccessRate = 70;
            this.addRate = 0;
         }
         if(this.ComposeGoodsId != -1)
         {
            this.addRate += this.ComposeGoods_Rate;
         }
         if(this.SuccessRate > 100)
         {
            this.SuccessRate = 100;
         }
         TextField(this._mc.getMC().mc_samecard.tf_rate).htmlText = this.SuccessRate + "% <font color=\'#00FF00\'>+" + this.addRate + "%</font>";
      }
      
      private function McCardBase1DoubleClick(param1:MouseEvent) : void
      {
         if(this.McCardBase1.mc_base1.numChildren > 0)
         {
            this.McCardBase1.mc_base1.removeChildAt(0);
            this.McCardBase1.prevFrame();
         }
         if(this.DoubleComposeMode)
         {
            this.ResetCard(this.DoubleCard1,-1);
            this.DoubleCard1 = -1;
         }
         else if(this.ComposeType == 1)
         {
            this.ResetCard(this.SameCard1,-1);
            this.SameCard1 = -1;
         }
         else
         {
            this.ResetCard(this.OtherCard2,-1);
            this.OtherCard2 = -1;
         }
         this.ShowResult();
      }
      
      private function McCardBase2DoubleClick(param1:MouseEvent) : void
      {
         if(this.McCardBase2.mc_base1.numChildren > 0)
         {
            this.McCardBase2.mc_base1.removeChildAt(0);
            this.McCardBase2.prevFrame();
         }
         if(this.ComposeType == 1)
         {
            this.ResetCard(this.SameCard2,-1);
            this.SameCard2 = -1;
         }
         else
         {
            this.ResetCard(this.OtherCard1,-1);
            this.OtherCard1 = -1;
         }
         this.ShowResult();
      }
      
      private function McCardBase3DoubleClick(param1:MouseEvent) : void
      {
         if(this.McCardBase3.mc_base1.numChildren > 0)
         {
            this.McCardBase3.mc_base1.removeChildAt(0);
            this.McCardBase3.prevFrame();
         }
         if(this.DoubleComposeMode)
         {
            this.ResetCard(this.DoubleCard2,-1);
            this.DoubleCard2 = -1;
         }
         else
         {
            this.ResetCard(this.OtherCard3,-1);
            this.OtherCard3 = -1;
         }
         this.ShowResult();
      }
      
      private function McCardBase4DoubleClick(param1:MouseEvent) : void
      {
      }
      
      private function GoodsBaseDoubleClick(param1:MouseEvent) : void
      {
         this.GoodsBase.gotoAndStop(1);
         this.ResetGoods(-1,-1);
         this.ComposeGoodsId = -1;
         this.ShowSuccessRate();
      }
      
      private function McCardBase1MouseOver(param1:MouseEvent) : void
      {
         if(this.ComposeType == 1)
         {
            this.ShowCardTip(this.McCardBase1,this.SameCard1);
         }
         else
         {
            this.ShowCardTip(this.McCardBase1,this.OtherCard2);
         }
      }
      
      private function McCardBase2MouseOver(param1:MouseEvent) : void
      {
         if(this.ComposeType == 1)
         {
            this.ShowCardTip(this.McCardBase2,this.SameCard2);
         }
         else
         {
            this.ShowCardTip(this.McCardBase2,this.OtherCard1);
         }
      }
      
      private function McCardBase3MouseOver(param1:MouseEvent) : void
      {
         this.ShowCardTip(this.McCardBase3,this.OtherCard3);
      }
      
      private function McCardBase4MouseOver(param1:MouseEvent) : void
      {
      }
      
      private function GoodsBaseMouseOver(param1:MouseEvent) : void
      {
         this.ShowCardTip(this.GoodsBase,this.ComposeGoodsId);
      }
      
      private function ResultBaseMouseOver(param1:MouseEvent) : void
      {
         this.ShowCardTip(this.ResultBase,this.ResultCardId);
      }
      
      private function ResetCard(param1:int, param2:int) : void
      {
         var _loc4_:PackPropsInfo = null;
         if(param1 == param2)
         {
            return;
         }
         var _loc3_:int = 0;
         while(_loc3_ < this.PackCard.length)
         {
            _loc4_ = this.PackCard[_loc3_];
            if(_loc4_.Id == param1)
            {
               ++_loc4_.Num;
            }
            else if(_loc4_.Id == param2)
            {
               --_loc4_.Num;
               if(_loc4_.Num <= 0)
               {
                  this.DeletePackCard.push(_loc4_);
                  this.PackCard.splice(_loc3_,1);
                  continue;
               }
            }
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < this.DeletePackCard.length)
         {
            _loc4_ = this.DeletePackCard[_loc3_];
            if(_loc4_.Id == param1)
            {
               ++_loc4_.Num;
               this.PackCard.push(_loc4_);
               this.DeletePackCard.splice(_loc3_,1);
               break;
            }
            _loc3_++;
         }
         this.PackCard.sortOn(["Grade","Type","CommanderType","Id"],Array.NUMERIC);
         this.ShowCurPageCard();
      }
      
      private function ResetGoods(param1:int, param2:int) : void
      {
         var _loc4_:PackPropsInfo = null;
         if(this.ComposeGoodsId == param1 && this.ComposeGoodsLockFlag == param2)
         {
            return;
         }
         var _loc3_:int = 0;
         while(_loc3_ < this.PackGoods.length)
         {
            _loc4_ = this.PackGoods[_loc3_];
            if(_loc4_.Id == this.ComposeGoodsId && _loc4_.LockFlag == this.ComposeGoodsLockFlag)
            {
               ++_loc4_.Num;
            }
            else if(_loc4_.Id == param1 && _loc4_.LockFlag == param2)
            {
               --_loc4_.Num;
               if(_loc4_.Num <= 0)
               {
                  this.DeletePackGoods.push(_loc4_);
                  this.PackGoods.splice(_loc3_,1);
                  continue;
               }
            }
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < this.DeletePackGoods.length)
         {
            _loc4_ = this.DeletePackGoods[_loc3_];
            if(_loc4_.Id == this.ComposeGoodsId && _loc4_.LockFlag == this.ComposeGoodsLockFlag)
            {
               ++_loc4_.Num;
               this.PackGoods.push(_loc4_);
               this.DeletePackGoods.splice(_loc3_,1);
               break;
            }
            _loc3_++;
         }
         this.PackGoods.sortOn("Id",Array.NUMERIC);
         this.ShowCurPageGoods();
      }
      
      private function ShowComposeButton() : void
      {
         if(this.DoubleComposeMode)
         {
            this.btn_compose.setBtnDisabled(this.DoubleCard1 == -1 || this.DoubleCard2 == -1);
         }
         else if(this.ComposeType == 1)
         {
            this.btn_compose.setBtnDisabled(!(this.SameCard1 != -1 && this.SameCard2 != -1 && GamePlayer.getInstance().UserMoney > GamePlayer.getInstance().Commander_CardUnion));
         }
         else
         {
            this.btn_compose.setBtnDisabled(!(this.OtherCard1 != -1 && this.OtherCard2 != -1 && this.OtherCard3 != -1 && GamePlayer.getInstance().UserMoney > GamePlayer.getInstance().Commander_CardUnion));
         }
      }
      
      public function resp_MSG_RESP_UNIONDOUBLESKILLCARD(param1:MSG_RESP_UNIONDOUBLESKILLCARD) : void
      {
         this.Invalid(true);
         var _loc2_:int = 0;
         var _loc3_:Array = ScienceSystem.getinstance().Packarr;
         while(_loc2_ < ScienceSystem.getinstance().Packarr.length)
         {
            if(ScienceSystem.getinstance().Packarr[_loc2_].StorageType == 0)
            {
               if(param1.PropsId != -1)
               {
                  if(ScienceSystem.getinstance().Packarr[_loc2_].LockFlag != 1)
                  {
                     if(ScienceSystem.getinstance().Packarr[_loc2_].PropsId == param1.Card1)
                     {
                        --ScienceSystem.getinstance().Packarr[_loc2_].PropsNum;
                     }
                     if(ScienceSystem.getinstance().Packarr[_loc2_].PropsId == param1.Card2)
                     {
                        --ScienceSystem.getinstance().Packarr[_loc2_].PropsNum;
                     }
                  }
               }
               if(ScienceSystem.getinstance().Packarr[_loc2_].PropsId == param1.Goods && ScienceSystem.getinstance().Packarr[_loc2_].LockFlag == param1.GoodsLockFlag)
               {
                  --ScienceSystem.getinstance().Packarr[_loc2_].PropsNum;
               }
               else if(ScienceSystem.getinstance().Packarr[_loc2_].PropsId == param1.Chip && ScienceSystem.getinstance().Packarr[_loc2_].LockFlag == param1.ChipLockFlag)
               {
                  --ScienceSystem.getinstance().Packarr[_loc2_].PropsNum;
               }
               if(ScienceSystem.getinstance().Packarr[_loc2_].PropsNum <= 0)
               {
                  ScienceSystem.getinstance().Packarr.splice(_loc2_,1);
                  continue;
               }
            }
            _loc2_++;
         }
         if(param1.PropsId != -1)
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("CommanderText77"),0);
            UpdateResource.getInstance().AddToPack(param1.PropsId,1,0);
         }
         else
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("CommanderText78"),0);
         }
         this.InitPackArray();
         this.ShowCurPageCard();
         this.ShowCurPageGoods();
      }
      
      public function RespCompose(param1:MSG_RESP_UNIONCOMMANDERCARD) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Array = null;
         var _loc4_:propsInfo = null;
         var _loc5_:PackPropsInfo = null;
         this.Invalid(true);
         if(param1.PropsId != -1)
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("CommanderText77"),0);
            UpdateResource.getInstance().AddToPack(param1.PropsId,1,0);
            _loc2_ = 0;
            _loc3_ = ScienceSystem.getinstance().Packarr;
            while(_loc2_ < ScienceSystem.getinstance().Packarr.length)
            {
               if(ScienceSystem.getinstance().Packarr[_loc2_].StorageType == 0)
               {
                  if(ScienceSystem.getinstance().Packarr[_loc2_].LockFlag != 1)
                  {
                     if(ScienceSystem.getinstance().Packarr[_loc2_].PropsId == param1.Card1)
                     {
                        --ScienceSystem.getinstance().Packarr[_loc2_].PropsNum;
                     }
                     if(ScienceSystem.getinstance().Packarr[_loc2_].PropsId == param1.Card2)
                     {
                        --ScienceSystem.getinstance().Packarr[_loc2_].PropsNum;
                     }
                     if(ScienceSystem.getinstance().Packarr[_loc2_].PropsId == param1.Card3)
                     {
                        --ScienceSystem.getinstance().Packarr[_loc2_].PropsNum;
                     }
                  }
                  if(ScienceSystem.getinstance().Packarr[_loc2_].PropsId == param1.Goods && ScienceSystem.getinstance().Packarr[_loc2_].LockFlag == param1.GoodsLockFlag)
                  {
                     --ScienceSystem.getinstance().Packarr[_loc2_].PropsNum;
                  }
                  if(ScienceSystem.getinstance().Packarr[_loc2_].PropsNum <= 0)
                  {
                     ScienceSystem.getinstance().Packarr.splice(_loc2_,1);
                     continue;
                  }
               }
               _loc2_++;
            }
            _loc4_ = CPropsReader.getInstance().GetPropsInfo(param1.PropsId);
            this.ResultPropsImg = new Bitmap(GameKernel.getTextureInstance(_loc4_.ImageFileName));
            this.ResultPropsImg.x = 8;
            this.ResultPropsImg.y = 8;
            this.ResultBase.gotoAndStop(2);
            this.ResultBase.addChild(this.ResultPropsImg);
            MovieClip(this.mc_samecard.mc_line5).gotoAndStop(2);
            setTimeout(this.ShowComplete,1000);
         }
         else
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("CommanderText78"),0);
            this.DeleteCard(param1.Card2);
            this.DeleteCard(param1.Card3);
         }
         ConstructionAction.getInstance().costResource(0,0,GamePlayer.getInstance().Commander_CardUnion,0);
         this.InitPackArray();
         this.ShowCurPageCard();
         this.ShowCurPageGoods();
         this.ShowMoney();
         if(this.ComposeType == 1)
         {
            _loc2_ = 0;
            while(_loc2_ < this.PackCard.length)
            {
               _loc5_ = this.PackCard[_loc2_];
               if(_loc5_.Id == param1.Card1)
               {
                  if(_loc5_.Num > 1)
                  {
                     this.SelectedCardId = _loc2_;
                     this.AddCard();
                  }
                  break;
               }
               _loc2_++;
            }
         }
      }
      
      private function DeleteCard(param1:int) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < ScienceSystem.getinstance().Packarr.length)
         {
            if(ScienceSystem.getinstance().Packarr[_loc2_].LockFlag != 1 && ScienceSystem.getinstance().Packarr[_loc2_].StorageType == 0)
            {
               if(ScienceSystem.getinstance().Packarr[_loc2_].PropsId == param1)
               {
                  --ScienceSystem.getinstance().Packarr[_loc2_].PropsNum;
                  if(ScienceSystem.getinstance().Packarr[_loc2_].PropsNum <= 0)
                  {
                     ScienceSystem.getinstance().Packarr.splice(_loc2_,1);
                  }
                  break;
               }
            }
            _loc2_++;
         }
      }
      
      private function ShowComplete() : void
      {
         if(this.SameCard1 == -1)
         {
            this.ResultBase.gotoAndStop(1);
            if(this.ResultBase.numChildren > 3)
            {
               this.ResultBase.removeChildAt(3);
               this.ResultPropsImg = null;
            }
         }
         MovieClip(this.mc_samecard.mc_line5).gotoAndStop(1);
      }
      
      private function ShowMoney() : void
      {
         TextField(this._mc.getMC().mc_samecard.tf_nowcash).text = GamePlayer.getInstance().cash.toString();
         TextField(this._mc.getMC().mc_samecard.tf_nowgold).text = GamePlayer.getInstance().UserMoney.toString();
      }
      
      private function btn_mallClick(param1:MouseEvent) : void
      {
         GameKernel.popUpDisplayManager.Hide(this);
         GameMouseZoneManager.NagivateToolBarByName("btn_mall",true);
      }
      
      private function btn_bagClick(param1:MouseEvent) : void
      {
         GameKernel.popUpDisplayManager.Hide(this);
         GameMouseZoneManager.NagivateToolBarByName("btn_storage",true);
      }
      
      private function btn_buyClick(param1:MouseEvent) : void
      {
         var _loc2_:int = -1;
         var _loc3_:int = -1;
         var _loc4_:int = -1;
         var _loc5_:Array = CPropsReader.getInstance().List16;
         if(_loc5_.length > 0)
         {
            _loc2_ = int(_loc5_[0].Id);
         }
         if(_loc5_.length > 1)
         {
            _loc3_ = int(_loc5_[1].Id);
         }
         if(_loc5_.length > 2)
         {
            _loc4_ = int(_loc5_[2].Id);
         }
         StateHandlingUI.getInstance().Init();
         StateHandlingUI.getInstance().setParent("ComposeUI");
         StateHandlingUI.getInstance().getstate(_loc2_,_loc3_,_loc4_);
         StateHandlingUI.getInstance().InitPopUp();
         GameKernel.popUpDisplayManager.Show(StateHandlingUI.getInstance());
         PropsBuyUI.getInstance().ShowCreateCorpsUI = 2;
      }
      
      public function RefreshGoods() : void
      {
         if(this.ComposeType == 1)
         {
            this.btn_samecardClick(null);
         }
         else
         {
            this.btn_othercardClick(null);
         }
      }
      
      private function btn_helpClick(param1:MouseEvent) : void
      {
         this._mc.getMC().addChild(this.McHelp);
      }
      
      private function CloseHelp(param1:MouseEvent) : void
      {
         if(this._mc.getMC().contains(this.McHelp))
         {
            this._mc.getMC().removeChild(this.McHelp);
         }
      }
      
      public function ShowDoubleCompose(param1:int, param2:int, param3:int) : void
      {
         this._ScrollNum = param3;
         this._ScrollPropsInfo = CPropsReader.getInstance().ScrollPropsInfoList.Get(param1);
         this._ScrollPropsInfoLockFlag = param2;
         this.Init();
         this.DoubleCard1 = -1;
         this.DoubleCard2 = -1;
         this.DoubleComposeMode = true;
         this.ShowProps();
         this._ShowDoubleCompose(true);
         this.ClearDoubleCompose();
         this.DoubleComposeResultCardId = CPropsReader.getInstance().GetCommanderProID(this._ScrollPropsInfo.SkillID);
         var _loc4_:propsInfo = CPropsReader.getInstance().GetPropsInfo(this._ScrollPropsInfo.PropsId);
         var _loc5_:Sprite = this.mc_doubleskill.getChildByName("mc_base") as Sprite;
         if(_loc5_.numChildren > 1)
         {
            Bitmap(_loc5_.getChildAt(1)).bitmapData.dispose();
            _loc5_.removeChildAt(1);
         }
         var _loc6_:Bitmap = new Bitmap(GameKernel.getTextureInstance(_loc4_.ImageFileName));
         _loc5_.addChild(_loc6_);
         TextField(this.mc_doubleskill.getChildByName("txt_name")).text = _loc4_.Name;
         TextField(this.mc_doubleskill.getChildByName("txt_num")).text = this._ScrollNum.toString();
         GameKernel.popUpDisplayManager.Show(this);
      }
      
      private function ClearDoubleCompose() : void
      {
         this.ClearComposeItem();
         this.McCardBase1.gotoAndStop(4);
         this.McCardBase3.gotoAndStop(4);
         this.ShowMoney();
         var _loc1_:TextField = this._mc.getMC().mc_samecard.tf_needgold as TextField;
         _loc1_.text = "0";
         TextField(this._mc.getMC().mc_samecard.tf_rate).text = "70%";
      }
      
      private function ShowDoubleComposeRate() : void
      {
         TextField(this._mc.getMC().mc_samecard.tf_rate).text = "70% <font color=\'#00FF00\'>+" + this.addRate + "%</font>";
      }
      
      private function mc_explainOut(param1:MouseEvent) : void
      {
         CustomTip.GetInstance().Hide();
      }
      
      private function mc_explainOver(param1:MouseEvent) : void
      {
         var _loc2_:Point = new Point(param1.stageX,param1.stageY);
         CustomTip.GetInstance().Show(StringManager.getInstance().getMessageString("Boss39"),_loc2_);
      }
      
      private function mc_baseOut(param1:MouseEvent) : void
      {
         if(this._PropsTip != null && this._PropsTip.parent != null && this._PropsTip.parent.contains(this._PropsTip))
         {
            this._PropsTip.parent.removeChild(this._PropsTip);
         }
      }
      
      private function mc_baseOver(param1:MouseEvent) : void
      {
         this.ShowCardTip(param1.target as MovieClip,this.DoubleComposeResultCardId);
      }
   }
}

