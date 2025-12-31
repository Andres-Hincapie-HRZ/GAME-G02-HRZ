package logic.ui
{
   import com.star.frameworks.managers.ResManager;
   import com.star.frameworks.managers.StringManager;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.utils.setTimeout;
   import gs.TweenLite;
   import gs.easing.Linear;
   import logic.entry.GamePlayer;
   import logic.entry.HButton;
   import logic.entry.MObject;
   import logic.entry.props.propsInfo;
   import logic.game.GameKernel;
   import logic.reader.CPropsReader;
   import logic.reader.FlagShipReader;
   import logic.ui.tip.CommanderChipTip;
   import logic.ui.tip.CustomTip;
   import net.base.NetManager;
   import net.msg.ChipLottery.CmosInfo;
   import net.msg.ChipLottery.MSG_REQUEST_CMOSLOTTERYINFO;
   import net.msg.ChipLottery.MSG_REQUEST_GAINCMOSLOTTERY;
   import net.msg.ChipLottery.MSG_REQUEST_OPENCMOSPACK;
   import net.msg.ChipLottery.MSG_REQUEST_SELLPROPS;
   import net.msg.ChipLottery.MSG_REQUEST_UNIONCMOS;
   import net.msg.ChipLottery.MSG_RESP_CMOSLOTTERYINFO;
   import net.msg.ChipLottery.MSG_RESP_GAINCMOSLOTTERY;
   import net.msg.mall.MSG_REQUEST_BUYGOODS;
   import net.msg.mall.MSG_RESP_BUYGOODS;
   import net.router.ChipLotteryRouter;
   
   public class ChipLottery extends AbstractPopUp
   {
      
      private static var instance:ChipLottery;
      
      public static var LockList:Array = new Array();
      
      private var btn_priatecoin:HButton;
      
      private var btn_mall:HButton;
      
      private var txt_num:TextField;
      
      private var txt_mall:TextField;
      
      private var btn_mergeList:Array;
      
      private var btn_mergeList2:Array;
      
      private var btn_upgradeList:Array;
      
      private var btn_upgradeList2:Array;
      
      private var mc_base:MovieClip;
      
      private var mc_explain:MovieClip;
      
      private var BaseMc:MovieClip;
      
      private var ChipInfoMsg:MSG_RESP_CMOSLOTTERYINFO;
      
      private var LotteryType:int;
      
      private var LotteryXML:XML;
      
      private var SelectedChipMc:XMovieClip;
      
      private var btn_allcollect:HButton;
      
      private var btn_lock:HButton;
      
      private var DropMc:MovieClip;
      
      private var UnionMsg:MSG_REQUEST_UNIONCMOS;
      
      private var MergeCount:int;
      
      private var SellMsg:MSG_REQUEST_SELLPROPS;
      
      private var RubbishId:int = 4220;
      
      private var WisdomId:int = 4221;
      
      private var LotteryAllStatus:Boolean;
      
      private var CellCount:int;
      
      private var btn_allsale:HButton;
      
      private var btn_merge5:MovieClip;
      
      private var btn_merge5_2:MovieClip;
      
      private var mc_blue:Sprite;
      
      private var mc_greenmerge:Sprite;
      
      private var FilterList:Array;
      
      private var btn_dianquan:HButton;
      
      private var MergeAllId:int;
      
      private var CoinsCount:int;
      
      private var btn_bag:HButton;
      
      public function ChipLottery()
      {
         super();
         setPopUpName("ChipLottery");
      }
      
      public static function getInstance() : ChipLottery
      {
         if(instance == null)
         {
            instance = new ChipLottery();
         }
         return instance;
      }
      
      public static function ResetLockList(param1:int) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < LockList.length)
         {
            if(LockList[_loc2_] > param1)
            {
               --LockList[_loc2_];
            }
            _loc2_++;
         }
      }
      
      override public function Init() : void
      {
         if(GameKernel.popUpDisplayManager.PopDisplayList.ContainsKey(getPopUpName()))
         {
            this.Clear();
            return;
         }
         this._mc = new MObject("CommanderchipScene",385,300);
         this.initMcElement();
         this.Clear();
         GameKernel.popUpDisplayManager.Regisger(instance);
      }
      
      override public function initMcElement() : void
      {
         var _loc1_:HButton = null;
         var _loc4_:XMovieClip = null;
         var _loc5_:XButton = null;
         this.BaseMc = this._mc.getMC();
         this.btn_priatecoin = new HButton(this.BaseMc.getChildByName("btn_priatecoin") as MovieClip);
         this.btn_priatecoin.m_movie.addEventListener(MouseEvent.CLICK,this.btn_priatecoinClick);
         this.btn_dianquan = new HButton(this.BaseMc.getChildByName("btn_dianquan") as MovieClip);
         this.btn_dianquan.m_movie.addEventListener(MouseEvent.CLICK,this.btn_dianquanClick);
         this.btn_mall = new HButton(this.BaseMc.getChildByName("btn_mall") as MovieClip);
         this.btn_mall.m_movie.addEventListener(MouseEvent.CLICK,this.btn_mallClick);
         this.btn_mall.SetTip(StringManager.getInstance().getMessageString("Boss81"));
         this.txt_num = this.BaseMc.getChildByName("txt_num") as TextField;
         this.txt_mall = this.BaseMc.getChildByName("txt_mall") as TextField;
         this.btn_allcollect = new HButton(this.BaseMc.getChildByName("btn_allcollect") as MovieClip);
         this.btn_allcollect.m_movie.addEventListener(MouseEvent.CLICK,this.btn_allcollectClick);
         this.btn_allsale = new HButton(this.BaseMc.getChildByName("btn_allsale") as MovieClip);
         this.btn_allsale.m_movie.addEventListener(MouseEvent.CLICK,this.btn_allsaleClick);
         this.btn_lock = new HButton(this.BaseMc.getChildByName("btn_lock") as MovieClip);
         this.btn_lock.m_movie.addEventListener(MouseEvent.CLICK,this.btn_lockClick);
         _loc1_ = new HButton(this.BaseMc.getChildByName("brn_unload") as MovieClip);
         _loc1_.m_movie.addEventListener(MouseEvent.CLICK,this.brn_unloadClick);
         this.btn_bag = new HButton(this.BaseMc.getChildByName("btn_bag") as MovieClip);
         this.btn_bag.m_movie.addEventListener(MouseEvent.CLICK,this.btn_bagClick);
         this.btn_bag.SetTip(StringManager.getInstance().getMessageString("Boss82"));
         _loc1_ = new HButton(this.BaseMc.getChildByName("btn_buyexp") as MovieClip);
         _loc1_.m_movie.addEventListener(MouseEvent.CLICK,this.btn_buyexpClick);
         this.mc_explain = this.BaseMc.getChildByName("mc_explain") as MovieClip;
         this.mc_explain.addEventListener(MouseEvent.CLICK,this.mc_explainClick);
         _loc1_ = new HButton(this.BaseMc.getChildByName("btn_close") as MovieClip);
         _loc1_.m_movie.addEventListener(MouseEvent.CLICK,this.btn_closeClick);
         this.mc_base = this.BaseMc.getChildByName("mc_base") as MovieClip;
         this.btn_mergeList = new Array();
         this.btn_upgradeList = new Array();
         this.mc_blue = this.BaseMc.getChildByName("mc_blue") as Sprite;
         this.InitMergeButton(this.mc_blue,this.btn_mergeList,this.btn_upgradeList);
         this.btn_merge5 = this.mc_blue.getChildByName("btn_merge4") as MovieClip;
         this.btn_merge5.addFrameScript(1,this.Showbtn_merge5);
         this.btn_mergeList2 = new Array();
         this.btn_upgradeList2 = new Array();
         this.mc_greenmerge = this.BaseMc.getChildByName("mc_greenmerge") as Sprite;
         this.InitMergeButton(this.mc_greenmerge,this.btn_mergeList2,this.btn_upgradeList2);
         this.btn_merge5_2 = this.mc_greenmerge.getChildByName("btn_merge4") as MovieClip;
         this.btn_merge5_2.addFrameScript(1,this.Showbtn_merge5);
         var _loc2_:int = 0;
         while(_loc2_ < 30)
         {
            _loc4_ = new XMovieClip(this.BaseMc.getChildByName("mc_list" + _loc2_) as MovieClip);
            _loc4_.Data = _loc2_;
            _loc4_.OnMouseDown = this.ChipClick;
            _loc4_.OnMouseOver = this.ChipOver;
            _loc4_.OnDoubleClick = this.ChipDoubleClick;
            Sprite(_loc4_.m_movie.mc_base).doubleClickEnabled = true;
            _loc4_.m_movie.addEventListener(MouseEvent.MOUSE_OUT,this.ChipOut);
            _loc4_.m_movie.addEventListener(MouseEvent.MOUSE_MOVE,this.ChipMove);
            _loc5_ = new XButton(_loc4_.m_movie.btn_buy as MovieClip);
            _loc5_.Data = _loc2_;
            _loc5_.OnClick = this.btn_buyClick;
            _loc2_++;
         }
         this.DropMc = new MovieClip();
         var _loc3_:Bitmap = new Bitmap();
         _loc3_.x = -20;
         _loc3_.y = -20;
         this.DropMc.addChild(_loc3_);
         this.DropMc.addEventListener(MouseEvent.MOUSE_UP,this.DropMcUp);
         this.BaseMc.addChild(this.DropMc);
         this.DropMc.visible = false;
         this.InitFilterList();
      }
      
      private function InitFilterList() : void
      {
         var _loc1_:GlowFilter = null;
         this.FilterList = new Array();
         this.FilterList.push(null);
         _loc1_ = new GlowFilter();
         _loc1_.blurX = 10;
         _loc1_.blurY = 10;
         _loc1_.color = 65280;
         this.FilterList.push(_loc1_);
         _loc1_ = new GlowFilter();
         _loc1_.blurX = 10;
         _loc1_.blurY = 10;
         _loc1_.color = 255;
         this.FilterList.push(_loc1_);
         _loc1_ = new GlowFilter();
         _loc1_.blurX = 10;
         _loc1_.blurY = 10;
         _loc1_.color = 16711935;
         this.FilterList.push(_loc1_);
         _loc1_ = new GlowFilter();
         _loc1_.blurX = 10;
         _loc1_.blurY = 10;
         _loc1_.color = 16750848;
         this.FilterList.push(_loc1_);
         _loc1_ = new GlowFilter();
         _loc1_.blurX = 10;
         _loc1_.blurY = 10;
         _loc1_.color = 16711680;
         this.FilterList.push(_loc1_);
         _loc1_ = new GlowFilter();
         _loc1_.blurX = 10;
         _loc1_.blurY = 10;
         _loc1_.color = 6710886;
         this.FilterList.push(_loc1_);
      }
      
      private function InitMergeButton(param1:Sprite, param2:Array, param3:Array) : void
      {
         var _loc6_:XMovieClip = null;
         var _loc7_:MovieClip = null;
         var _loc4_:int = 0;
         while(_loc4_ < 5)
         {
            _loc6_ = new XMovieClip(param1.getChildByName("btn_merge" + _loc4_) as MovieClip);
            _loc6_.Data = _loc4_;
            _loc6_.OnClick = this.btn_mergeClick;
            _loc6_.m_movie.buttonMode = true;
            _loc6_.OnMouseOver = this.btn_mergeOver;
            param2.push(_loc6_);
            _loc6_.m_movie.addEventListener(MouseEvent.MOUSE_OUT,this.btn_mergeOut);
            _loc6_.m_movie.gotoAndStop(1);
            _loc4_++;
         }
         var _loc5_:int = 0;
         while(_loc5_ < 4)
         {
            _loc7_ = param1.getChildByName("btn_upgrade" + _loc5_) as MovieClip;
            _loc7_.gotoAndStop(1);
            param3.push(_loc7_);
            _loc5_++;
         }
      }
      
      private function Showbtn_merge5() : void
      {
         if(this.btn_merge5.currentFrame == 1)
         {
            return;
         }
         var _loc1_:Number = this.btn_merge5.alpha <= 0.3 ? 1 : 0.3;
         TweenLite.to(this.btn_merge5,1,{
            "alpha":_loc1_,
            "ease":Linear,
            "onComplete":this.Showbtn_merge5
         });
         TweenLite.to(this.btn_merge5_2,1,{
            "alpha":_loc1_,
            "ease":Linear,
            "onComplete":this.Showbtn_merge5
         });
      }
      
      private function btn_mergeOver(param1:Event, param2:XMovieClip) : void
      {
         var _loc3_:String = StringManager.getInstance().getMessageString("Boss62");
         if(this.LotteryType == 0)
         {
            _loc3_ += StringManager.getInstance().getMessageString("Boss63");
         }
         else
         {
            _loc3_ += StringManager.getInstance().getMessageString("AuctionText8");
         }
         _loc3_ = _loc3_.replace("@@1",this.GetMoney(param2.Data + 1));
         var _loc4_:Point = param2.m_movie.localToGlobal(new Point(0,param2.m_movie.height + 20));
         CustomTip.GetInstance().Show(_loc3_,_loc4_);
      }
      
      private function btn_mergeOut(param1:MouseEvent) : void
      {
         CustomTip.GetInstance().Hide();
      }
      
      public function Clear() : void
      {
         var _loc2_:XMovieClip = null;
         var _loc3_:MovieClip = null;
         var _loc4_:XMovieClip = null;
         var _loc5_:MovieClip = null;
         var _loc6_:XMovieClip = null;
         var _loc7_:Sprite = null;
         this.LotteryAllStatus = false;
         this.SetEnable(false);
         var _loc1_:int = 0;
         while(_loc1_ < 30)
         {
            _loc6_ = new XMovieClip(this.BaseMc.getChildByName("mc_list" + _loc1_) as MovieClip);
            _loc6_.m_movie.gotoAndStop(1);
            _loc7_ = Sprite(_loc6_.m_movie.mc_base);
            if(_loc7_.numChildren > 0)
            {
               _loc7_.removeChildAt(0);
            }
            _loc1_++;
         }
         for each(_loc2_ in this.btn_mergeList)
         {
            _loc2_.m_movie.gotoAndStop(1);
         }
         for each(_loc3_ in this.btn_upgradeList)
         {
            _loc3_.gotoAndStop(1);
         }
         for each(_loc4_ in this.btn_mergeList2)
         {
            _loc4_.m_movie.gotoAndStop(1);
         }
         for each(_loc5_ in this.btn_upgradeList2)
         {
            _loc5_.gotoAndStop(1);
         }
         this.RequestLotteryInfo();
         if(this.SelectedChipMc != null)
         {
            this.SelectedChipMc.m_movie.gotoAndStop(1);
            this.SelectedChipMc = null;
         }
         this.MergeCount = 0;
      }
      
      public function Show() : void
      {
         this.Init();
         GameKernel.popUpDisplayManager.Show(this);
         this.btn_priatecoinClick(null);
      }
      
      private function RequestLotteryInfo() : void
      {
         var _loc1_:MSG_REQUEST_CMOSLOTTERYINFO = new MSG_REQUEST_CMOSLOTTERYINFO();
         _loc1_.SeqId = GamePlayer.getInstance().seqID++;
         _loc1_.Guid = GamePlayer.getInstance().Guid;
         NetManager.Instance().sendObject(_loc1_);
      }
      
      public function Resp_MSG_RESP_CMOSLOTTERYINFO(param1:MSG_RESP_CMOSLOTTERYINFO, param2:Boolean = true) : void
      {
         var _loc4_:* = 0;
         var _loc5_:int = 0;
         if(this.SelectedChipMc != null)
         {
            this.SelectedChipMc.m_movie.gotoAndPlay(1);
         }
         this.SelectedChipMc = null;
         if(this.BaseMc == null)
         {
            return;
         }
         --this.MergeCount;
         if(this.MergeCount > 0)
         {
            return;
         }
         this.SetEnable(true);
         this.ChipInfoMsg = param1;
         this.txt_num.text = param1.PirateMoney.toString();
         this.txt_mall.text = GamePlayer.getInstance().cash.toString();
         XMovieClip(this.btn_mergeList[0]).m_movie.gotoAndStop(2);
         XMovieClip(this.btn_mergeList2[0]).m_movie.gotoAndStop(2);
         var _loc3_:int = 1;
         while(_loc3_ < 5)
         {
            _loc4_ = 1 << _loc3_ - 1;
            _loc5_ = (_loc4_ & param1.LotteryPhase) > 0 ? 2 : 1;
            XMovieClip(this.btn_mergeList[_loc3_]).m_movie.gotoAndStop(_loc5_);
            MovieClip(this.btn_upgradeList[_loc3_ - 1]).gotoAndStop(_loc5_);
            XMovieClip(this.btn_mergeList2[_loc3_]).m_movie.gotoAndStop(_loc5_);
            MovieClip(this.btn_upgradeList2[_loc3_ - 1]).gotoAndStop(_loc5_);
            _loc3_++;
         }
         if(param2)
         {
            this.ShowAllProps(ChipLotteryRouter.instance.FirstShow);
         }
         if(this.LotteryAllStatus && param2)
         {
            setTimeout(this.LotteryAll,500);
         }
      }
      
      public function Resp_MSG_RESP_GAINCMOSLOTTERY(param1:MSG_RESP_GAINCMOSLOTTERY) : void
      {
         if(param1.Type == 0)
         {
            this.ChipInfoMsg.PirateMoney -= param1.Credit;
         }
         else
         {
            GamePlayer.getInstance().cash = GamePlayer.getInstance().cash - param1.Credit;
            ResPlaneUI.getInstance().updateResPlane();
         }
         this.SetEnable(true);
         if(param1.Guid != GamePlayer.getInstance().Guid)
         {
            return;
         }
         this.ChipInfoMsg.LotteryPhase = param1.LotteryPhase;
         var _loc2_:CmosInfo = new CmosInfo();
         _loc2_.PropsId = param1.PropsId;
         this.ChipInfoMsg.Data[this.ChipInfoMsg.DataLen] = _loc2_;
         this.Resp_MSG_RESP_CMOSLOTTERYINFO(this.ChipInfoMsg,false);
         this.ShowProps(this.ChipInfoMsg.DataLen++,true,true);
         if(this.LotteryAllStatus)
         {
            setTimeout(this.LotteryAll,500);
         }
      }
      
      private function ShowAllProps(param1:Boolean) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < 30)
         {
            this.ShowProps(_loc2_,false,param1);
            _loc2_++;
         }
      }
      
      private function ShowProps(param1:int, param2:Boolean = false, param3:Boolean = false) : void
      {
         var _loc5_:CmosInfo = null;
         var _loc6_:propsInfo = null;
         var _loc7_:Sprite = null;
         var _loc8_:Bitmap = null;
         var _loc9_:int = 0;
         var _loc10_:Sprite = null;
         var _loc4_:MovieClip = this.BaseMc.getChildByName("mc_list" + param1) as MovieClip;
         if(this.ChipInfoMsg.DataLen > param1)
         {
            _loc5_ = this.ChipInfoMsg.Data[param1];
            _loc6_ = CPropsReader.getInstance().GetPropsInfo(_loc5_.PropsId);
            _loc7_ = Sprite(_loc4_.mc_base);
            if(_loc7_.numChildren > 0)
            {
               _loc7_.removeChildAt(0);
            }
            _loc8_ = new Bitmap(GameKernel.getTextureInstance(_loc6_.ImageFileName));
            if(param3 && (_loc6_.PropsColor == 3 || _loc6_.PropsColor == 4))
            {
               _loc9_ = int(LockList.indexOf(param1));
               if(_loc9_ < 0)
               {
                  LockList.push(param1);
                  Sprite(_loc4_.mc_lock).visible = true;
                  Sprite(_loc4_.btn_buy).visible = false;
               }
            }
            _loc8_.filters = [this.FilterList[_loc6_.PropsColor]];
            _loc7_.addChildAt(_loc8_,0);
            Sprite(_loc4_.mc_lock).visible = LockList.indexOf(param1) >= 0;
            Sprite(_loc4_.btn_buy).visible = !Sprite(_loc4_.mc_lock).visible;
            _loc4_.gotoAndStop(1);
            if(param2)
            {
               MapShowAnimation.GetInstance().ShowMap(_loc8_,1);
            }
         }
         else
         {
            Sprite(_loc4_.btn_buy).visible = false;
            if(param1 < this.ChipInfoMsg.CmosPackCount)
            {
               _loc4_.gotoAndStop(1);
               _loc10_ = Sprite(_loc4_.mc_base);
               if(_loc10_.numChildren > 0)
               {
                  _loc10_.removeChildAt(0);
               }
               Sprite(_loc4_.mc_lock).visible = false;
            }
            else
            {
               _loc4_.gotoAndStop(3);
            }
         }
      }
      
      private function HasMoney(param1:int) : Boolean
      {
         var _loc2_:int = this.GetMoney(param1);
         if(this.LotteryType == 0)
         {
            if(_loc2_ > this.ChipInfoMsg.PirateMoney)
            {
               MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("Boss57"),0);
               return false;
            }
         }
         else if(_loc2_ > GamePlayer.getInstance().cash)
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("Boss58"),0);
            return false;
         }
         return true;
      }
      
      private function GetMoney(param1:int) : int
      {
         var _loc3_:XML = null;
         var _loc2_:int = 0;
         if(this.LotteryXML == null)
         {
            this.LotteryXML = GameKernel.resManager.getXml(ResManager.GAMERES,"CmosLottery");
         }
         for each(_loc3_ in this.LotteryXML.List)
         {
            if(_loc3_.@Level == param1)
            {
               if(this.LotteryType == 0)
               {
                  _loc2_ = int(_loc3_.@Money);
                  break;
               }
               _loc2_ = int(_loc3_.@Credit);
               break;
            }
         }
         return _loc2_;
      }
      
      private function btn_buyexpClick(param1:MouseEvent) : void
      {
         MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("Boss87"),2,this.BuyExp);
      }
      
      private function BuyExp() : void
      {
         if(GamePlayer.getInstance().cash < 50)
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("Boss58"),0);
            return;
         }
         if(this.ChipInfoMsg.CmosPackCount - this.ChipInfoMsg.DataLen <= 0)
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("Boss56"),0);
            return;
         }
         var _loc1_:MSG_REQUEST_BUYGOODS = new MSG_REQUEST_BUYGOODS();
         _loc1_.PropsId = 4221;
         _loc1_.Num = 1;
         _loc1_.Type = 0;
         _loc1_.SeqId = GamePlayer.getInstance().seqID++;
         _loc1_.Guid = GamePlayer.getInstance().Guid;
         NetManager.Instance().sendObject(_loc1_);
         this.SetEnable(false);
      }
      
      public function OnBuyExp(param1:MSG_RESP_BUYGOODS) : void
      {
         this.SetEnable(true);
         GamePlayer.getInstance().cash = GamePlayer.getInstance().cash - param1.Price;
         this.txt_mall.text = GamePlayer.getInstance().cash.toString();
         ResPlaneUI.getInstance().updateResPlane();
         var _loc2_:CmosInfo = new CmosInfo();
         _loc2_.PropsId = param1.PropsId;
         this.ChipInfoMsg.Data[this.ChipInfoMsg.DataLen] = _loc2_;
         this.ShowProps(this.ChipInfoMsg.DataLen++,true,true);
      }
      
      private function btn_mergeClick(param1:Event, param2:XMovieClip) : void
      {
         this.Lottery(param2.Data);
      }
      
      private function Lottery(param1:int) : Boolean
      {
         if(param1 > 0 && (this.ChipInfoMsg.LotteryPhase & 1 << param1 - 1) <= 0)
         {
            return false;
         }
         if(!this.HasMoney(param1 + 1))
         {
            return false;
         }
         if(this.ChipInfoMsg.CmosPackCount - this.ChipInfoMsg.DataLen <= 0)
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("Boss56"),0);
            return false;
         }
         var _loc2_:MSG_REQUEST_GAINCMOSLOTTERY = new MSG_REQUEST_GAINCMOSLOTTERY();
         _loc2_.Type = this.LotteryType;
         _loc2_.PhaseId = param1;
         _loc2_.SeqId = GamePlayer.getInstance().seqID++;
         _loc2_.Guid = GamePlayer.getInstance().Guid;
         NetManager.Instance().sendObject(_loc2_);
         this.SetEnable(false);
         return true;
      }
      
      private function ChipOut(param1:MouseEvent) : void
      {
         CommanderChipTip.Hide();
      }
      
      private function ChipOver(param1:MouseEvent, param2:XMovieClip) : void
      {
         if(param2.Data >= this.ChipInfoMsg.DataLen)
         {
            return;
         }
         this.ShowPartTip(param2.m_movie,CmosInfo(this.ChipInfoMsg.Data[param2.Data]));
      }
      
      private function ShowPartTip(param1:MovieClip, param2:CmosInfo) : void
      {
         if(param2.PropsId < 0)
         {
            return;
         }
         CommanderChipTip.Show(param1,param2);
      }
      
      private function ChipDoubleClick(param1:MouseEvent, param2:XMovieClip) : void
      {
         this.ChipClick(param1,param2);
         this.btn_lockClick(param1);
      }
      
      private function ChipClick2(param1:MouseEvent, param2:XMovieClip) : void
      {
      }
      
      private function ChipClick(param1:MouseEvent, param2:XMovieClip) : void
      {
         var _loc3_:String = null;
         var _loc4_:int = 0;
         if(param2.Data < this.ChipInfoMsg.DataLen)
         {
            if(this.SelectedChipMc != null)
            {
               this.SelectedChipMc.m_movie.gotoAndStop(1);
            }
            this.SelectedChipMc = param2;
            this.SelectedChipMc.m_movie.gotoAndStop(2);
            this.btn_allcollect.setBtnDisabled(false);
         }
         else if(param2.m_movie.currentFrame == 3)
         {
            _loc3_ = StringManager.getInstance().getMessageString("Boss52");
            this.CellCount = param2.Data - this.ChipInfoMsg.CmosPackCount + 1;
            this.CoinsCount = 0;
            _loc4_ = 0;
            while(_loc4_ < this.CellCount)
            {
               this.CoinsCount += FlagShipReader.getInstance().GetOpenCellMoney(param2.Data - 15 - _loc4_);
               _loc4_++;
            }
            _loc3_ = _loc3_.replace("@@1",this.CellCount);
            _loc3_ = _loc3_.replace("@@2",this.CoinsCount);
            MessagePopup.getInstance().Show(_loc3_,2,this.AddCell);
         }
      }
      
      private function AddCell() : void
      {
         if(GamePlayer.getInstance().cash < this.CoinsCount)
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("AuctionText31"),0);
            return;
         }
         GamePlayer.getInstance().cash = GamePlayer.getInstance().cash - this.CoinsCount;
         ResPlaneUI.getInstance().updateResPlane();
         var _loc1_:MSG_REQUEST_OPENCMOSPACK = new MSG_REQUEST_OPENCMOSPACK();
         var _loc2_:int = 0;
         while(_loc2_ < this.CellCount)
         {
            _loc1_.SeqId = GamePlayer.getInstance().seqID++;
            _loc1_.Guid = GamePlayer.getInstance().Guid;
            NetManager.Instance().sendObject(_loc1_);
            _loc2_++;
         }
      }
      
      private function ChipMove(param1:MouseEvent) : void
      {
         var _loc2_:Sprite = null;
         if(param1.buttonDown && this.SelectedChipMc != null)
         {
            if(LockList.indexOf(this.SelectedChipMc.Data) < 0 && CmosInfo(this.ChipInfoMsg.Data[this.SelectedChipMc.Data]).PropsId != this.RubbishId)
            {
               _loc2_ = Sprite(this.SelectedChipMc.m_movie.mc_base);
               Bitmap(this.DropMc.getChildAt(0)).bitmapData = Bitmap(_loc2_.getChildAt(0)).bitmapData;
               this.DropMc.visible = true;
               this.DropMc.startDrag(true);
            }
         }
      }
      
      private function DropMcUp(param1:MouseEvent) : void
      {
         var _loc5_:MovieClip = null;
         var _loc6_:CmosInfo = null;
         this.DropMc.visible = false;
         this.DropMc.stopDrag();
         var _loc2_:Point = new Point(param1.stageX,param1.stageY);
         _loc2_ = this.BaseMc.globalToLocal(_loc2_);
         var _loc3_:int = -1;
         var _loc4_:int = 0;
         while(_loc4_ < 30)
         {
            _loc5_ = this.BaseMc.getChildByName("mc_list" + _loc4_) as MovieClip;
            if(_loc2_.x > _loc5_.x && _loc2_.y > _loc5_.y && _loc2_.x < _loc5_.x + 50 && _loc2_.y < _loc5_.y + 50)
            {
               _loc3_ = _loc4_;
               break;
            }
            _loc4_++;
         }
         if(_loc3_ >= 0 && _loc3_ != this.SelectedChipMc.Data && _loc3_ < this.ChipInfoMsg.DataLen)
         {
            _loc6_ = this.ChipInfoMsg.Data[_loc3_];
            if(_loc6_.PropsId == this.RubbishId)
            {
               MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("Boss53"),0);
            }
            else if(_loc6_.PropsId == this.WisdomId)
            {
               MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("Boss54"),0);
            }
            else if((_loc6_.PropsId + 1) % 10 == 0)
            {
               MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("Boss69"),0);
            }
            else
            {
               this.SetEnable(false);
               this.Merge(this.SelectedChipMc.Data,_loc3_);
            }
         }
      }
      
      private function Merge(param1:int, param2:int) : void
      {
         if(this.UnionMsg == null)
         {
            this.UnionMsg = new MSG_REQUEST_UNIONCMOS();
         }
         this.UnionMsg.CmosId1 = param2;
         this.UnionMsg.CmosId2 = param1;
         this.UnionMsg.SeqId = GamePlayer.getInstance().seqID++;
         this.UnionMsg.Guid = GamePlayer.getInstance().Guid;
         NetManager.Instance().sendObject(this.UnionMsg);
         ResetLockList(param1);
      }
      
      private function btn_allcollectClick(param1:MouseEvent) : void
      {
         if(this.SelectedChipMc == null)
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("Boss66"),0);
            return;
         }
         if(this.ChipInfoMsg.DataLen == 1)
         {
            return;
         }
         var _loc2_:CmosInfo = this.ChipInfoMsg.Data[this.SelectedChipMc.Data];
         if(_loc2_.PropsId == this.RubbishId)
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("Boss53"),0);
            return;
         }
         if(_loc2_.PropsId == this.WisdomId)
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("Boss54"),0);
            return;
         }
         if((_loc2_.PropsId + 1) % 10 == 0)
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("Boss69"),0);
            return;
         }
         this.MergeAllId = this.SelectedChipMc.Data;
         MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("Boss86"),2,this.DoMergeAll);
      }
      
      private function DoMergeAll() : void
      {
         var _loc7_:MovieClip = null;
         var _loc8_:Sprite = null;
         var _loc1_:int = this.MergeAllId;
         var _loc2_:Array = new Array();
         var _loc3_:int = 0;
         while(_loc3_ < this.ChipInfoMsg.DataLen)
         {
            if(CmosInfo(this.ChipInfoMsg.Data[_loc3_]).PropsId != this.RubbishId)
            {
               if(_loc1_ == _loc3_)
               {
                  _loc2_.push(_loc3_);
               }
               else if(LockList.indexOf(_loc3_) < 0)
               {
                  if(_loc1_ != _loc3_)
                  {
                     _loc7_ = this.BaseMc.getChildByName("mc_list" + _loc3_) as MovieClip;
                     _loc8_ = Sprite(_loc7_.mc_base);
                     MapShowAnimation.GetInstance().ThrowMap(_loc8_.getChildAt(0) as Bitmap,this.SelectedChipMc.m_movie.parent as Sprite,1,this.SelectedChipMc.m_movie.x,this.SelectedChipMc.m_movie.y);
                  }
                  _loc2_.push(_loc3_);
               }
            }
            _loc3_++;
         }
         if(_loc2_.length <= 1)
         {
            return;
         }
         this.SetEnable(false);
         var _loc4_:int = int(_loc2_.indexOf(_loc1_));
         this.MergeCount = 0;
         var _loc5_:int = _loc4_ - 1;
         while(_loc5_ >= 0)
         {
            this.Merge(_loc2_[_loc5_],_loc1_--);
            ++this.MergeCount;
            _loc5_--;
         }
         var _loc6_:int = _loc4_ + 1;
         while(_loc6_ < _loc2_.length)
         {
            this.Merge(_loc2_[_loc6_] - this.MergeCount,_loc1_);
            ++this.MergeCount;
            _loc6_++;
         }
      }
      
      private function brn_unloadClick(param1:MouseEvent) : void
      {
         if(this.LotteryAllStatus)
         {
            this.LotteryAllStatus = false;
            this.SetEnable(true);
            return;
         }
         this.LotteryAllStatus = true;
         this.SetEnable(false);
         this.LotteryAll();
      }
      
      private function btn_bagClick(param1:MouseEvent) : void
      {
         this.btn_closeClick(null);
         ComposeUI.getInstance().ShowCommanderChip();
      }
      
      private function LotteryAll() : void
      {
         if(this.MergeCount <= 0)
         {
            this.SaleAll(true);
         }
         if(this.MergeCount == 0)
         {
            this._LotteryAll();
         }
      }
      
      private function _LotteryAll() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 3;
         while(_loc2_ >= 0)
         {
            if((this.ChipInfoMsg.LotteryPhase & 1 << _loc2_) > 0)
            {
               _loc1_ = _loc2_ + 1;
               break;
            }
            _loc2_--;
         }
         if(_loc1_ == 4 || this.Lottery(_loc1_) == false)
         {
            this.LotteryAllStatus = false;
            this.SetEnable(true);
         }
      }
      
      private function SetEnable(param1:Boolean) : void
      {
         if(this.LotteryAllStatus)
         {
            this.mc_blue.mouseChildren = false;
            this.mc_greenmerge.mouseChildren = false;
            this.btn_allcollect.setBtnDisabled(true);
            this.btn_lock.setBtnDisabled(true);
            this.btn_allsale.setBtnDisabled(true);
            this.btn_mall.setBtnDisabled(true);
            this.btn_priatecoin.setBtnDisabled(true);
            this.btn_dianquan.setBtnDisabled(true);
            this.btn_bag.setBtnDisabled(true);
            return;
         }
         if(param1)
         {
            this.mc_blue.mouseChildren = true;
            this.mc_greenmerge.mouseChildren = true;
            this.btn_allcollect.setBtnDisabled(false);
            this.btn_lock.setBtnDisabled(false);
            this.btn_allsale.setBtnDisabled(false);
            this.btn_mall.setBtnDisabled(false);
            this.btn_priatecoin.setBtnDisabled(false);
            this.btn_dianquan.setBtnDisabled(false);
            this.btn_bag.setBtnDisabled(false);
         }
         this.BaseMc.mouseEnabled = param1;
         this.BaseMc.mouseChildren = param1;
      }
      
      private function btn_buyClick(param1:MouseEvent, param2:XButton) : void
      {
         var _loc3_:MovieClip = this.BaseMc.getChildByName("mc_list" + param2.Data) as MovieClip;
         var _loc4_:Sprite = Sprite(_loc3_.mc_base);
         MapShowAnimation.GetInstance().RemoveMap(_loc4_.getChildAt(0) as Bitmap,this.btn_allsale.m_movie.parent as Sprite,1,2);
         var _loc5_:CmosInfo = this.ChipInfoMsg.Data[param2.Data];
         var _loc6_:propsInfo = CPropsReader.getInstance().GetPropsInfo(_loc5_.PropsId);
         this.ShowPirateCoin(_loc6_.CostPirateCoin.toString(),param2.m_movie);
         this.SellChip(param2.Data);
         this.SetEnable(false);
      }
      
      private function ShowPirateCoin(param1:String, param2:Sprite) : void
      {
         param1 = StringManager.getInstance().getMessageString("Boss63") + "+" + param1;
         var _loc3_:CustomPopup = new CustomPopup();
         var _loc4_:Point = param2.localToGlobal(new Point(0,0));
         _loc4_ = this._mc.getMC().globalToLocal(_loc4_);
         _loc3_.SetText(this._mc.getMC(),param1,_loc4_,0,60,1);
      }
      
      private function btn_allsaleClick(param1:MouseEvent) : void
      {
         this.SaleAll();
      }
      
      private function SaleAll(param1:Boolean = true) : void
      {
         var _loc3_:int = 0;
         var _loc4_:CmosInfo = null;
         var _loc5_:MovieClip = null;
         var _loc6_:Sprite = null;
         var _loc7_:propsInfo = null;
         var _loc8_:CmosInfo = null;
         if(param1)
         {
            _loc3_ = 0;
            while(_loc3_ < this.ChipInfoMsg.DataLen)
            {
               _loc4_ = this.ChipInfoMsg.Data[_loc3_];
               if(_loc4_.PropsId == this.RubbishId)
               {
                  _loc5_ = this.BaseMc.getChildByName("mc_list" + _loc3_) as MovieClip;
                  _loc6_ = Sprite(_loc5_.mc_base);
                  MapShowAnimation.GetInstance().RemoveMap(_loc6_.getChildAt(0) as Bitmap,this.btn_allsale.m_movie.parent as Sprite,1,2);
                  _loc7_ = CPropsReader.getInstance().GetPropsInfo(_loc4_.PropsId);
                  this.ShowPirateCoin(_loc7_.CostPirateCoin.toString(),_loc5_.btn_buy);
               }
               _loc3_++;
            }
         }
         this.MergeCount = 0;
         var _loc2_:int = 0;
         while(_loc2_ < this.ChipInfoMsg.DataLen)
         {
            _loc8_ = this.ChipInfoMsg.Data[_loc2_];
            if(_loc8_.PropsId == this.RubbishId)
            {
               this.SellChip(_loc2_ - this.MergeCount);
               ++this.MergeCount;
            }
            _loc2_++;
         }
         if(this.MergeCount > 0)
         {
            this.SetEnable(false);
         }
      }
      
      private function SellChip(param1:int) : void
      {
         if(this.SellMsg == null)
         {
            this.SellMsg = new MSG_REQUEST_SELLPROPS();
         }
         this.SellMsg.Type = 1;
         this.SellMsg.Id = param1;
         this.SellMsg.Num = 1;
         this.SellMsg.SeqId = GamePlayer.getInstance().seqID++;
         this.SellMsg.Guid = GamePlayer.getInstance().Guid;
         NetManager.Instance().sendObject(this.SellMsg);
         ResetLockList(param1);
      }
      
      private function btn_lockClick(param1:MouseEvent) : void
      {
         if(this.SelectedChipMc == null)
         {
            return;
         }
         var _loc2_:MovieClip = this.BaseMc.getChildByName("mc_list" + this.SelectedChipMc.Data) as MovieClip;
         var _loc3_:int = int(LockList.indexOf(this.SelectedChipMc.Data));
         if(_loc3_ >= 0)
         {
            LockList.splice(_loc3_,1);
            Sprite(_loc2_.mc_lock).visible = false;
            Sprite(_loc2_.btn_buy).visible = true;
         }
         else
         {
            LockList.push(this.SelectedChipMc.Data);
            Sprite(_loc2_.mc_lock).visible = true;
            Sprite(_loc2_.btn_buy).visible = false;
         }
      }
      
      private function mc_explainClick(param1:MouseEvent) : void
      {
         this.mc_explain.gotoAndStop(this.mc_explain.currentFrame % 2 + 1);
      }
      
      private function btn_closeClick(param1:MouseEvent) : void
      {
         this.LotteryAllStatus = false;
         GameKernel.popUpDisplayManager.Hide(this);
      }
      
      private function btn_mallClick(param1:MouseEvent) : void
      {
         GameKernel.popUpDisplayManager.Hide(this);
         SaleForPriatecoinUI.getInstance().Init();
         GameKernel.popUpDisplayManager.Show(SaleForPriatecoinUI.getInstance());
         SaleForPriatecoinUI.getInstance().SetPriateCoins(this.ChipInfoMsg.PirateMoney);
      }
      
      private function btn_dianquanClick(param1:MouseEvent) : void
      {
         if(this.btn_dianquan.selsected)
         {
            return;
         }
         this.LotteryType = 1;
         this.Clear();
         this.btn_dianquan.setSelect(true);
         this.btn_priatecoin.setSelect(false);
         this.mc_base.removeChildAt(1);
         this.mc_base.addChild(new Bitmap(GameKernel.getTextureInstance("map")));
         this.mc_blue.visible = false;
         this.mc_greenmerge.visible = true;
      }
      
      private function btn_priatecoinClick(param1:MouseEvent) : void
      {
         if(this.btn_priatecoin.selsected)
         {
            return;
         }
         this.LotteryType = 0;
         this.Clear();
         this.btn_dianquan.setSelect(false);
         this.btn_priatecoin.setSelect(true);
         if(this.mc_base.numChildren > 1)
         {
            this.mc_base.removeChildAt(1);
         }
         this.mc_base.addChild(new Bitmap(GameKernel.getTextureInstance("map0")));
         this.mc_blue.visible = true;
         this.mc_greenmerge.visible = false;
      }
   }
}

