package logic.ui
{
   import com.star.frameworks.facebook.FacebookUserInfo;
   import com.star.frameworks.managers.StringManager;
   import com.star.frameworks.utils.CEffectText;
   import com.star.frameworks.utils.StringUitl;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.filters.DropShadowFilter;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.utils.Timer;
   import logic.action.ChatAction;
   import logic.action.ConstructionAction;
   import logic.entry.ChannelEnum;
   import logic.entry.GamePlayer;
   import logic.entry.HButton;
   import logic.entry.MObject;
   import logic.entry.ScienceSystem;
   import logic.entry.props.propsInfo;
   import logic.game.GameKernel;
   import logic.reader.CPropsReader;
   import logic.reader.CScienceReader;
   import logic.ui.info.BleakingLineForThai;
   import logic.utils.UpdateResource;
   import net.base.NetManager;
   import net.msg.sciencesystem.MSG_REQUEST_GAINLOTTERY;
   
   public class LotteryUi extends AbstractPopUp
   {
      
      private static var instance:LotteryUi;
      
      private var content:MovieClip;
      
      private var ran:int = 0;
      
      private var num:int = 0;
      
      private var wp:int = 0;
      
      private var newran:int = 0;
      
      private var bo:Boolean = true;
      
      private var dd:int = 0;
      
      private var hw:int = 5;
      
      private var dy:int = 0;
      
      private var sn:int = 0;
      
      private var ss:Timer = new Timer(50);
      
      private var jx:int = 0;
      
      private var cishu:int = 0;
      
      private var typ:int = 1;
      
      private var bit:Bitmap;
      
      private var btn_lottery:HButton;
      
      private var close_mc:HButton;
      
      private var tip:MovieClip;
      
      private var cost:int = 5;
      
      private var jpobj:Object;
      
      private var ins:Boolean = true;
      
      public function LotteryUi()
      {
         super();
         setPopUpName("LotteryUi");
      }
      
      public static function getInstance() : LotteryUi
      {
         if(instance == null)
         {
            instance = new LotteryUi();
         }
         return instance;
      }
      
      override public function Init() : void
      {
         if(GameKernel.popUpDisplayManager.PopDisplayList.ContainsKey(getPopUpName()))
         {
            this.reset();
            return;
         }
         this._mc = new MObject("LotteryScene",380,320);
         this.initMcElement();
         GameKernel.popUpDisplayManager.Regisger(instance);
      }
      
      override public function initMcElement() : void
      {
         this.content = this._mc.getMC();
         this.close_mc = new HButton(this.content.btn_close);
         this.close_mc.m_movie.addEventListener(MouseEvent.CLICK,this.closeHd);
         this.typ = 1;
         this.content.mc_pop2.btn_check0.gotoAndStop(2);
         this.content.mc_pop2.btn_check1.gotoAndStop(1);
         this.reset(true);
         this.ss.addEventListener(TimerEvent.TIMER,this.ttHd);
         this.btn_lottery = new HButton(this.content.btn_lottery);
         this.btn_lottery.m_movie.addEventListener(MouseEvent.CLICK,this.beginHd);
         this.content.mc_pop2.visible = false;
         this.content.mc_pop1.visible = false;
         this.content.mc_pop2.btn_check0.buttonMode = true;
         this.content.mc_pop2.btn_check1.buttonMode = true;
         this.content.mc_pop2.btn_check0.addEventListener(MouseEvent.CLICK,this.checkHd);
         this.content.mc_pop2.btn_check1.addEventListener(MouseEvent.CLICK,this.checkHd);
         this.content.mc_pop1.btn_ensure.addEventListener(MouseEvent.CLICK,this.jiguoHd);
         this.content.mc_pop2.btn_close.addEventListener(MouseEvent.CLICK,this.bulaileHd);
         this.content.mc_pop2.btn_next.addEventListener(MouseEvent.CLICK,this.nextHd);
         this.content.mc_pop1.x = -145;
         this.content.mc_pop1.y = -18;
         this.content.mc_pop2.x = -145;
         this.content.mc_pop2.y = -18;
         this.kaishi();
      }
      
      private function kaishi() : void
      {
         var _loc1_:Object = null;
         var _loc2_:uint = 0;
         while(_loc2_ < CScienceReader.getInstance().Lotteryarr.length)
         {
            _loc1_ = new Object();
            _loc1_ = CScienceReader.getInstance().Lotteryarr[_loc2_];
            this.bit = new Bitmap(GameKernel.getTextureInstance(_loc1_.ImageFileName));
            this.content["mc" + _loc1_.OrderID].mc_base.addChild(this.bit);
            this.content["mc" + _loc1_.OrderID].tf_modulenum.text = String(_loc1_.Num);
            this.content["mc" + _loc1_.OrderID].ii = _loc1_.OrderID;
            this.content["mc" + _loc1_.OrderID].buttonMode = true;
            this.content["mc" + _loc1_.OrderID].nn = _loc1_.Name;
            this.content["mc" + _loc1_.OrderID].Comment = _loc1_.Comment;
            this.content["mc" + _loc1_.OrderID].addEventListener(MouseEvent.ROLL_OVER,this.rooHd);
            this.content["mc" + _loc1_.OrderID].addEventListener(MouseEvent.ROLL_OUT,this.rouHd);
            _loc2_++;
         }
      }
      
      private function rooHd(param1:MouseEvent) : void
      {
         if(!this.ins)
         {
            return;
         }
         this.tip = this.tipHd(param1.currentTarget.nn,param1.currentTarget.Comment);
         this.tip.x = param1.currentTarget.x + 60;
         this.tip.y = param1.currentTarget.y + 30;
         this.content.addChild(this.tip);
      }
      
      private function tipHd(param1:String, param2:String) : MovieClip
      {
         var _loc3_:MovieClip = new MovieClip();
         var _loc4_:TextField = new TextField();
         _loc4_.textColor = 13417082;
         _loc4_.autoSize = TextFieldAutoSize.LEFT;
         _loc4_.selectable = false;
         _loc4_.wordWrap = false;
         _loc4_.text = param1.toString();
         var _loc5_:int = 30;
         var _loc6_:int = 32;
         var _loc7_:String = StringManager.getInstance().getMessageString("ItemText9") + "\n" + param2;
         var _loc8_:TextField = new TextField();
         _loc8_.autoSize = TextFieldAutoSize.LEFT;
         _loc8_.selectable = false;
         _loc8_.wordWrap = true;
         _loc8_.width = _loc4_.width + 2 * _loc5_;
         _loc8_.textColor = 16777215;
         _loc8_.htmlText = _loc7_;
         _loc8_.y = _loc4_.y + _loc4_.height + 5;
         _loc8_.x = -_loc5_;
         BleakingLineForThai.GetInstance().BleakThaiLanguage(_loc8_,16777215);
         var _loc9_:MovieClip = new MovieClip();
         _loc9_.graphics.clear();
         _loc9_.graphics.lineStyle(1,479858);
         _loc9_.graphics.beginFill(0,0.7);
         _loc9_.graphics.drawRoundRect(-_loc6_,0,_loc4_.width + 2 * _loc6_,_loc8_.y + _loc8_.height + 5,10,10);
         _loc9_.graphics.endFill();
         _loc9_.filters = [new DropShadowFilter()];
         _loc3_.addChild(_loc9_);
         _loc3_.addChild(_loc4_);
         _loc3_.addChild(_loc8_);
         _loc3_.mouseEnabled = false;
         _loc9_.mouseEnabled = false;
         _loc4_.mouseEnabled = false;
         _loc8_.mouseEnabled = false;
         return _loc3_;
      }
      
      private function rouHd(param1:MouseEvent) : void
      {
         this.deletetip();
      }
      
      private function checkHd(param1:MouseEvent) : void
      {
         if(param1.currentTarget.name == "btn_check0")
         {
            if(this.typ == 1)
            {
               return;
            }
            this.content.mc_pop2.btn_check0.gotoAndStop(2);
            this.content.mc_pop2.btn_check1.gotoAndStop(1);
            this.typ = 1;
            return;
         }
         if(this.typ == 2)
         {
            return;
         }
         this.content.mc_pop2.btn_check0.gotoAndStop(1);
         this.content.mc_pop2.btn_check1.gotoAndStop(2);
         this.typ = 2;
      }
      
      private function closeresultsHd(param1:MouseEvent) : void
      {
      }
      
      private function ccHd(param1:MouseEvent) : void
      {
      }
      
      private function ttHd(param1:TimerEvent) : void
      {
         var _loc2_:int = 0;
         if(this.bo)
         {
            ++this.ran;
            if(this.ran == 18)
            {
               this.ran = 0;
               ++this.num;
            }
         }
         if(this.num == 2)
         {
            if(this.ran == this.dd)
            {
               if(this.bo)
               {
                  this.dy = 0;
                  this.newran = this.ran;
                  this.update(this.newran);
               }
               this.bo = false;
               if(this.newran == this.wp)
               {
                  ++this.jx;
                  if(this.jx == 20)
                  {
                     this.jx = 0;
                     this.ss.stop();
                     this.upstop(this.wp);
                     this.completeHd();
                     return;
                  }
                  return;
               }
               ++this.dy;
               if(this.dy == this.sn * 2 + 5)
               {
                  this.dy = 0;
                  ++this.sn;
                  ++this.newran;
                  if(this.newran == 18)
                  {
                     this.newran = 0;
                  }
                  _loc2_ = this.newran - 1;
                  if(_loc2_ < 0)
                  {
                     _loc2_ = 18 + _loc2_;
                  }
                  this.qqstop(_loc2_);
                  this.upstop(this.newran);
               }
               return;
            }
         }
         if(this.bo)
         {
            this.update(this.ran);
         }
      }
      
      private function qqstop(param1:int) : void
      {
         this.content["mc" + param1].gotoAndStop(1);
      }
      
      private function jiguoHd(param1:MouseEvent) : void
      {
         this.content.mc_pop1.visible = false;
      }
      
      private function bulaileHd(param1:MouseEvent) : void
      {
         this.content.mc_pop2.visible = false;
      }
      
      private function nextHd(param1:MouseEvent) : void
      {
         if(GamePlayer.getInstance().PropsPack - ScienceSystem.getinstance().Packarr.length == 0)
         {
            StoragepopupTip.getInstance().Init();
            StoragepopupTip.getInstance().Show();
            if(GamePlayer.getInstance().PropsPack == PackUi.getInstance().maxNum)
            {
               StoragepopupTip.getInstance().ppd(2);
            }
            else
            {
               StoragepopupTip.getInstance().ppd(1);
            }
            return;
         }
         if(this.typ == 1)
         {
            if(GamePlayer.getInstance().cash < this.cost)
            {
               CEffectText.getInstance().showEffectText(GameKernel.renderManager.getUI().getContainer(),StringManager.getInstance().getMessageString("BuildingText3"));
               return;
            }
         }
         else if(GamePlayer.getInstance().coins < this.cost)
         {
            CEffectText.getInstance().showEffectText(GameKernel.renderManager.getUI().getContainer(),StringManager.getInstance().getMessageString("BuildingText16"));
            return;
         }
         var _loc2_:MSG_REQUEST_GAINLOTTERY = new MSG_REQUEST_GAINLOTTERY();
         _loc2_.SeqId = GamePlayer.getInstance().seqID++;
         _loc2_.Guid = GamePlayer.getInstance().Guid;
         _loc2_.Type = this.typ;
         NetManager.Instance().sendObject(_loc2_);
         this.content.mc_pop2.visible = false;
         this.btn_lottery.setBtnDisabled(true);
         this.close_mc.setBtnDisabled(true);
      }
      
      private function completeHd() : void
      {
         var _loc3_:propsInfo = null;
         this.ss.stop();
         this.btn_lottery.setBtnDisabled(false);
         this.close_mc.setBtnDisabled(false);
         this.ins = true;
         var _loc1_:String = "";
         var _loc2_:int = int(this.jpobj.Num);
         if(this.jpobj.LotteryType == 0 || this.jpobj.LotteryType == 5 || this.jpobj.LotteryType == 6 || this.jpobj.LotteryType == 7)
         {
            _loc3_ = CPropsReader.getInstance().GetPropsInfo(this.jpobj.PropsId);
            _loc1_ = _loc3_.Name + "  x " + this.jpobj.Num;
            this.content.mc_pop1.tf_goods.text = _loc1_.toString();
            UpdateResource.getInstance().AddToPack(this.jpobj.PropsId,this.jpobj.Num,this.jpobj.LockFlag);
         }
         switch(this.jpobj.LotteryType)
         {
            case 0:
               break;
            case 1:
               _loc1_ = StringManager.getInstance().getMessageString("ShipText26") + "  x " + this.jpobj.Coins;
               this.content.mc_pop1.tf_goods.text = _loc1_.toString();
               GamePlayer.getInstance().coins = GamePlayer.getInstance().coins + this.jpobj.Coins;
               _loc2_ = int(this.jpobj.Coins);
               break;
            case 2:
               _loc1_ = StringManager.getInstance().getMessageString("ShipText10") + "  x " + this.jpobj.Money;
               this.content.mc_pop1.tf_goods.text = _loc1_.toString();
               ConstructionAction.getInstance().addResource(0,0,this.jpobj.Money,0);
               _loc2_ = int(this.jpobj.Money);
               break;
            case 3:
               _loc1_ = StringManager.getInstance().getMessageString("ShipText9") + "  x " + this.jpobj.Gas;
               this.content.mc_pop1.tf_goods.text = _loc1_.toString();
               ConstructionAction.getInstance().addResource(this.jpobj.Gas,0,0,0);
               _loc2_ = int(this.jpobj.Gas);
               break;
            case 4:
               _loc1_ = StringManager.getInstance().getMessageString("ShipText8") + "  x " + this.jpobj.Metal;
               this.content.mc_pop1.tf_goods.text = _loc1_.toString();
               ConstructionAction.getInstance().addResource(0,this.jpobj.Metal,0,0);
               _loc2_ = int(this.jpobj.Metal);
         }
         --this.cishu;
         if(this.jpobj.BroFlag == 1 && this.jpobj.LotteryId != 9)
         {
            GameKernel.getPlayerFacebookInfo(this.jpobj.UserId,this.getPlayerFacebookInfo,this.jpobj.Name);
         }
         this.content.tf_num.text = this.cishu.toString();
         this.deletetip();
         if(GameKernel.ForFB != 1 && GameKernel.ForRenRen != 1)
         {
            EnjoyUi.getInstance().ShowLotterReport(this.jpobj.LotteryType,this.jpobj.PropsId,_loc2_);
         }
         else
         {
            this.content.mc_pop1.visible = true;
         }
      }
      
      private function getPlayerFacebookInfo(param1:FacebookUserInfo) : void
      {
         var _loc3_:String = null;
         var _loc4_:uint = 0;
         var _loc5_:* = null;
         var _loc2_:String = "";
         if(param1 == null)
         {
            return;
         }
         _loc2_ = param1.first_name;
         if(param1.first_name == null)
         {
            _loc2_ = param1.uid.toString();
         }
         _loc3_ = "";
         _loc4_ = 0;
         while(_loc4_ < CScienceReader.getInstance().Lotteryarr.length)
         {
            if(CScienceReader.getInstance().Lotteryarr[_loc4_].OrderID == this.jpobj.LotteryId)
            {
               _loc3_ = CScienceReader.getInstance().Lotteryarr[_loc4_].Name;
            }
            _loc4_++;
         }
         _loc2_ = _loc2_.replace("\r","");
         _loc2_ = _loc2_.replace("\n","");
         _loc5_ = StringManager.getInstance().getMessageString("MainUITXT38") + "<a href=\'event:" + this.jpobj.UserId + "," + _loc2_ + "\'>" + "[" + _loc2_ + "]" + "</a>" + StringManager.getInstance().getMessageString("MainUITXT39") + "<font color=\'#99FFFF\'>" + "[" + _loc3_ + "]" + "</font>";
         ChatAction.getInstance().appendMsgContent(StringUitl.Trim(_loc5_),ChannelEnum.CHANNEL_SYSTEM,_loc2_);
      }
      
      private function beginHd(param1:MouseEvent) : void
      {
         var _loc3_:String = null;
         if(this.ss.running)
         {
            return;
         }
         if(this.cishu == 0)
         {
            _loc3_ = StringManager.getInstance().getMessageString("MainUITXT35");
            this.content.mc_pop2.tf_txt.htmlText = _loc3_.toString();
            this.content.mc_pop2.tf_allcash.text = GamePlayer.getInstance().cash.toString();
            this.content.mc_pop2.tf_allgold.text = GamePlayer.getInstance().coins.toString();
            this.content.mc_pop2.visible = true;
            BleakingLineForThai.GetInstance().BleakThaiLanguage(this.content.mc_pop2.tf_txt,7119868);
            return;
         }
         if(GamePlayer.getInstance().PropsPack - ScienceSystem.getinstance().Packarr.length == 0)
         {
            StoragepopupTip.getInstance().Init();
            StoragepopupTip.getInstance().Show();
            if(GamePlayer.getInstance().PropsPack == PackUi.getInstance().maxNum)
            {
               StoragepopupTip.getInstance().ppd(2);
            }
            else
            {
               StoragepopupTip.getInstance().ppd(1);
            }
            return;
         }
         var _loc2_:MSG_REQUEST_GAINLOTTERY = new MSG_REQUEST_GAINLOTTERY();
         _loc2_.SeqId = GamePlayer.getInstance().seqID++;
         _loc2_.Guid = GamePlayer.getInstance().Guid;
         _loc2_.Type = 0;
         NetManager.Instance().sendObject(_loc2_);
         this.btn_lottery.setBtnDisabled(true);
         this.close_mc.setBtnDisabled(true);
      }
      
      public function readResoutdAndBegin(param1:Object) : void
      {
         this.jpobj = new Object();
         this.jpobj = param1;
         this.wp = this.jpobj.LotteryId;
         this.reset();
         this.ss.reset();
         this.ss.start();
         this.ins = false;
      }
      
      private function update(param1:int) : void
      {
         this.content["mc" + param1].gotoAndPlay(2);
      }
      
      private function upstop(param1:int) : void
      {
         this.content["mc" + param1].gotoAndStop(2);
      }
      
      private function deletetip() : void
      {
         var _loc1_:uint = 0;
         if(this.tip != null && this.content.contains(this.tip))
         {
            _loc1_ = 0;
            while(_loc1_ < this.tip.numChildren)
            {
               this.tip.removeChildAt(0);
               _loc1_++;
            }
            this.content.removeChild(this.tip);
         }
      }
      
      private function reset(param1:Boolean = false) : void
      {
         var _loc2_:uint = 0;
         while(_loc2_ < 18)
         {
            this.content["mc" + _loc2_].gotoAndStop(1);
            _loc2_++;
         }
         this.deletetip();
         if(GamePlayer.getInstance().VipBuffer)
         {
            this.cishu = 3 - GamePlayer.getInstance().LotteryStatus;
         }
         else if(GamePlayer.getInstance().LotteryStatus == 0)
         {
            this.cishu = 1;
         }
         else
         {
            this.cishu = 0;
         }
         this.cost = GamePlayer.getInstance().LotteryCredit;
         this.content.tf_num.text = this.cishu.toString();
         if(param1)
         {
            return;
         }
         this.content.mc_pop2.visible = false;
         this.content.mc_pop1.visible = false;
         this.hw = 6;
         this.dd = this.wp - this.hw;
         this.sn = 0;
         if(this.dd < 0)
         {
            this.dd = 18 + this.dd;
         }
         this.ran = 0;
         this.num = 0;
         this.newran = 0;
         this.bo = true;
         this.dy = 0;
         this.jx = 0;
      }
      
      private function closeHd(param1:MouseEvent) : void
      {
         GameKernel.popUpDisplayManager.Hide(instance);
      }
   }
}

