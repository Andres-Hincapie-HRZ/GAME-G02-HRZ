package logic.ui
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import logic.entry.GamePlayer;
   import logic.entry.HButton;
   import logic.entry.MObject;
   import logic.game.GameKernel;
   import logic.reader.ConstructionSpeedReader;
   import logic.utils.RegisteredData;
   import net.base.NetManager;
   import net.msg.sciencesystem.MSG_REQUEST_SPEEDTECH;
   
   public class ScienceSpeedPopUp extends AbstractPopUp
   {
      
      private static var instance:ScienceSpeedPopUp;
      
      private var content:MovieClip;
      
      private var typ:int = 0;
      
      public var mtyp:int = 0;
      
      private var qued:HButton;
      
      private var proid:int = 0;
      
      private var yyarr:Array = new Array();
      
      public function ScienceSpeedPopUp()
      {
         super();
         setPopUpName("ScienceSpeedPopUp");
      }
      
      public static function getInstance() : ScienceSpeedPopUp
      {
         if(instance == null)
         {
            instance = new ScienceSpeedPopUp();
         }
         return instance;
      }
      
      override public function Init() : void
      {
         if(GameKernel.popUpDisplayManager.PopDisplayList.ContainsKey(getPopUpName()))
         {
            return;
         }
         this._mc = new MObject("BuildspeedMc",380,300);
         this.initMcElement();
         GameKernel.popUpDisplayManager.Regisger(instance);
      }
      
      override public function initMcElement() : void
      {
         this.content = this._mc.getMC();
         var _loc1_:HButton = new HButton(this.content.btn_cancel);
         _loc1_.m_movie.addEventListener(MouseEvent.CLICK,this.closeHd);
         this.btnHd();
         var _loc2_:uint = 0;
         while(_loc2_ < 5)
         {
            this.content["radio" + _loc2_].xx = _loc2_;
            MovieClip(this.content["radio" + _loc2_]).buttonMode = true;
            MovieClip(this.content["radio" + _loc2_]).addEventListener(MouseEvent.CLICK,this.selectHd);
            MovieClip(this.content["mc_cash" + _loc2_]).gotoAndStop(2);
            _loc2_++;
         }
         this.content.radiocash.gotoAndStop(1);
         this.content.radiogold.gotoAndStop(2);
         this.qued = new HButton(this.content.btn_ensure);
         this.qued.m_movie.addEventListener(MouseEvent.CLICK,this.queHd);
         this.content.radiocash.buttonMode = true;
         this.content.radiogold.buttonMode = true;
         this.content.radiocash.xx = 0;
         this.content.radiogold.xx = 1;
         this.mtyp = 1;
         this.getDataarr();
         this.updatey();
         this.content.radiocash.addEventListener(MouseEvent.CLICK,this.mselectHd);
         this.content.radiogold.addEventListener(MouseEvent.CLICK,this.mselectHd);
      }
      
      private function updatey() : void
      {
         var _loc1_:uint = 1;
         while(_loc1_ <= 4)
         {
            this.content["radio" + _loc1_].y = this.yyarr[4 - _loc1_].qq;
            this.content["tf_speedtime" + _loc1_].y = this.yyarr[4 - _loc1_].ww;
            this.content["tf_cash" + _loc1_].y = this.yyarr[4 - _loc1_].ee;
            _loc1_++;
         }
      }
      
      private function getDataarr() : void
      {
         var _loc1_:Object = null;
         this.yyarr.length = 0;
         var _loc2_:uint = 1;
         while(_loc2_ <= 4)
         {
            _loc1_ = new Object();
            _loc1_.qq = this.content["radio" + _loc2_].y;
            _loc1_.ww = this.content["tf_speedtime" + _loc2_].y;
            _loc1_.ee = this.content["tf_cash" + _loc2_].y;
            this.yyarr[_loc2_ - 1] = _loc1_;
            _loc2_++;
         }
      }
      
      private function mselectHd(param1:MouseEvent) : void
      {
         var _loc2_:int = int(param1.currentTarget.xx);
         if(this.mtyp == _loc2_)
         {
            return;
         }
         if(_loc2_ == 0)
         {
            this.content.radiocash.gotoAndStop(2);
            this.content.radiogold.gotoAndStop(1);
            this.mtyp = _loc2_;
            this.speedpd();
            this.pdsd(1);
            return;
         }
         this.content.radiocash.gotoAndStop(1);
         this.content.radiogold.gotoAndStop(2);
         this.mtyp = _loc2_;
         this.speedpd();
         this.pdsd(2);
      }
      
      private function pdsd(param1:int) : void
      {
         var _loc2_:uint = 0;
         while(_loc2_ < 5)
         {
            MovieClip(this.content["mc_cash" + _loc2_]).gotoAndStop(param1);
            _loc2_++;
         }
      }
      
      private function btnHd(param1:int = 0) : void
      {
         var _loc2_:uint = 0;
         while(_loc2_ < 5)
         {
            this.content["radio" + _loc2_].gotoAndStop(1);
            _loc2_++;
         }
         this.content["radio" + param1].gotoAndStop(2);
      }
      
      private function selectHd(param1:MouseEvent) : void
      {
         this.typ = param1.currentTarget.xx;
         this.btnHd(this.typ);
         this.speedpd();
      }
      
      public function pdd(param1:Object) : void
      {
         this.content.tf_remaintime.text = String(param1.tt);
         var _loc2_:uint = 0;
         while(_loc2_ < 5)
         {
            TextField(this.content["tf_speedtime" + _loc2_]).text = String(ConstructionSpeedReader.getInstance().Read(4 - _loc2_,ConstructionSpeedReader.SPEED_TYPE_TECH).Name);
            if(4 - _loc2_ != 4)
            {
               TextField(this.content["tf_cash" + _loc2_]).text = String(ConstructionSpeedReader.getInstance().Read(4 - _loc2_,ConstructionSpeedReader.SPEED_TYPE_TECH).Credit);
            }
            else
            {
               TextField(this.content["tf_cash" + _loc2_]).text = String(Math.ceil(param1.tm / ConstructionSpeedReader.getInstance().Read(4 - _loc2_,ConstructionSpeedReader.SPEED_TYPE_TECH).Variable));
            }
            _loc2_++;
         }
         this.content.tf_allcash.text = RegisteredData.getInstance().MoneyDouHao(GamePlayer.getInstance().cash);
         this.content.tf_allgold.text = RegisteredData.getInstance().MoneyDouHao(GamePlayer.getInstance().coins);
         this.proid = param1.pro;
         this.speedpd();
      }
      
      private function speedpd() : void
      {
         if(this.mtyp == 0)
         {
            if(GamePlayer.getInstance().cash < int(TextField(this.content["tf_cash" + this.typ]).text))
            {
               this.qued.setBtnDisabled(true);
               return;
            }
            this.qued.setBtnDisabled(false);
            return;
         }
         if(GamePlayer.getInstance().coins < int(TextField(this.content["tf_cash" + this.typ]).text))
         {
            this.qued.setBtnDisabled(true);
            return;
         }
         this.qued.setBtnDisabled(false);
      }
      
      private function queHd(param1:MouseEvent) : void
      {
         this.qued.setBtnDisabled(true);
         var _loc2_:MSG_REQUEST_SPEEDTECH = new MSG_REQUEST_SPEEDTECH();
         _loc2_.SeqId = GamePlayer.getInstance().seqID++;
         _loc2_.Guid = GamePlayer.getInstance().Guid;
         _loc2_.TechId = this.proid;
         _loc2_.TechSpeedId = int(4 - this.typ);
         _loc2_.Type = this.mtyp;
         NetManager.Instance().sendObject(_loc2_);
      }
      
      private function closeHd(param1:MouseEvent) : void
      {
         this.close();
      }
      
      public function close() : void
      {
         ScienceSystemUi.getInstance().Hider();
         GameKernel.popUpDisplayManager.Hide(instance);
      }
   }
}

