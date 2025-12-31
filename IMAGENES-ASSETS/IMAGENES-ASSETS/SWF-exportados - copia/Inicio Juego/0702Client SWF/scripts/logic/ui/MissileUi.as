package logic.ui
{
   import com.star.frameworks.managers.StringManager;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.filters.ColorMatrixFilter;
   import flash.text.TextFormat;
   import flash.utils.Timer;
   import logic.action.ConstructionAction;
   import logic.entry.GamePlayer;
   import logic.entry.HButton;
   import logic.entry.MObject;
   import logic.entry.ScienceSystem;
   import logic.game.GameKernel;
   import logic.reader.CScienceReader;
   import logic.utils.ColorMatrix;
   import logic.utils.McBitmap;
   import logic.utils.RegisteredData;
   import logic.utils.ScienceTip;
   import net.base.NetManager;
   import net.msg.sciencesystem.MSG_REQUEST_CREATETECH;
   
   public class MissileUi extends AbstractPopUp
   {
      
      private static var instance:MissileUi;
      
      private var str:String;
      
      public var sjarr:Array = new Array();
      
      private var tm:Timer = new Timer(1000);
      
      private var _tm:uint;
      
      private var _totm:uint;
      
      private var hh:int = 0;
      
      private var mm:int = 0;
      
      private var ss:int = 0;
      
      private var techarr:Array = new Array();
      
      public var levelarr:Array = new Array();
      
      private var pdbo:Boolean = true;
      
      private var me:uint = 0;
      
      private var tip:ScienceTip = new ScienceTip();
      
      private var _id:uint = 0;
      
      private var tf:TextFormat = new TextFormat();
      
      private var xxarr:Array = new Array();
      
      private var barr:Array = new Array();
      
      private var carr:Array = new Array();
      
      private var darr:Array = new Array();
      
      private var mc:MovieClip;
      
      private var buqian:int = 0;
      
      private var ttff:TextFormat = new TextFormat();
      
      public function MissileUi()
      {
         super();
         setPopUpName("MissileUi");
      }
      
      public static function getInstance() : MissileUi
      {
         if(instance == null)
         {
            instance = new MissileUi();
         }
         return instance;
      }
      
      override public function Init() : void
      {
         if(GameKernel.popUpDisplayManager.PopDisplayList.ContainsKey(getPopUpName()))
         {
            return;
         }
         this._mc = new MObject("MissileMc",0,0);
         this.mc = this.getPopUp().getMC();
         this.initMcElement();
         GameKernel.popUpDisplayManager.Regisger(instance);
      }
      
      override public function initMcElement() : void
      {
         var _loc1_:HButton = null;
         var _loc2_:HButton = null;
         this.tf.size = 30;
         this.tf.color = 65280;
         this.ttff.color = 16711680;
         var _loc3_:uint = 0;
         while(_loc3_ < 64)
         {
            this.levelarr.push(0);
            _loc3_++;
         }
         var _loc4_:uint = 0;
         while(_loc4_ < ScienceSystem.getinstance().levearr.length)
         {
            if(ScienceSystem.getinstance().levearr[_loc4_][0] >= 32 && ScienceSystem.getinstance().levearr[_loc4_][0] < 48)
            {
               this.levelarr[ScienceSystem.getinstance().levearr[_loc4_][0]] = ScienceSystem.getinstance().levearr[_loc4_][1];
            }
            _loc4_++;
         }
         var _loc5_:ColorMatrix = new ColorMatrix();
         _loc5_.adjustSaturation(-100);
         var _loc6_:uint = 32;
         while(_loc6_ < 48)
         {
            this.mc["mc_base" + _loc6_].gotoAndStop(1);
            this.mc["mc_base" + _loc6_].mc_plan.visible = false;
            RegisteredData.getInstance().ppd(_loc6_);
            this.mc["mc_base" + _loc6_].tj = 1;
            if(!RegisteredData.getInstance().pdd)
            {
               this.mc["mc_base" + _loc6_].gotoAndStop(2);
               this.mc["mc_base" + _loc6_].tj = 0;
               McBitmap.getInstance().mcarr[_loc6_].filters = [new ColorMatrixFilter(_loc5_)];
               McBitmap.getInstance().mcarr[_loc6_].alpha = RegisteredData.getInstance().alph;
            }
            this.mc["mc_base" + _loc6_].buttonMode = true;
            this.mc["mc_base" + _loc6_].idd = _loc6_;
            this.mc["mc_base" + _loc6_].addEventListener(MouseEvent.ROLL_OVER,this.ovHd);
            this.mc["mc_base" + _loc6_].addEventListener(MouseEvent.ROLL_OUT,this.ouHd);
            this.mc["mc_base" + _loc6_].tf_page.text = CScienceReader.getInstance().WeaponTechAry[_loc6_].title;
            if(this.levelarr[_loc6_] != 0)
            {
               this.mc["mc_base" + _loc6_].tf_page.text = String(CScienceReader.getInstance().weaponarr[_loc6_][this.levelarr[_loc6_] - 1].Title);
            }
            this.mc["mc_base" + _loc6_].mc_base.addChild(McBitmap.getInstance().mcarr[_loc6_]);
            this.mc["mc_base" + _loc6_].mc_base.idd = _loc6_;
            this.mc["mc_base" + _loc6_].mc_base.sjj = 0;
            this.mc["mc_base" + _loc6_].mc_base.addEventListener(MouseEvent.CLICK,this.raiHd);
            _loc6_++;
         }
         this.jtou();
         this.tm.addEventListener(TimerEvent.TIMER,this.ttHd);
      }
      
      private function jtou() : void
      {
         this.mc["x32_33_41"].gotoAndStop(1);
         this.mc["x32_33"].gotoAndStop(1);
         this.mc["x32_41"].gotoAndStop(1);
         this.mc["x33_34"].gotoAndStop(1);
         this.mc["x41_42"].gotoAndStop(1);
         this.mc["x42_34"].gotoAndStop(1);
         this.mc["x34_35_38"].gotoAndStop(1);
         this.mc["x34_35"].gotoAndStop(1);
         this.mc["x34_38"].gotoAndStop(1);
         this.mc["x42_43"].gotoAndStop(1);
         this.mc["x35_36"].gotoAndStop(1);
         this.mc["x36_37"].gotoAndStop(1);
         this.mc["x38_39"].gotoAndStop(1);
         this.mc["x39_40"].gotoAndStop(1);
         this.mc["x43_44"].gotoAndStop(1);
         this.mc["x44_45"].gotoAndStop(1);
         this.mc["x40_45"].gotoAndStop(1);
         this.mc["x37_46"].gotoAndStop(1);
         this.mc["x45_46"].gotoAndStop(1);
         this.mc["x37_45_46"].gotoAndStop(1);
         this.mc["x46_47"].gotoAndStop(1);
         var _loc1_:uint = 33;
         while(_loc1_ < 48)
         {
            RegisteredData.getInstance().pdd = false;
            RegisteredData.getInstance().ppd(_loc1_);
            if(RegisteredData.getInstance().pdd)
            {
               this.aa(_loc1_);
            }
            _loc1_++;
         }
         this.LineHd();
      }
      
      public function closeHd(param1:uint, param2:Boolean, param3:int = 0) : void
      {
         this._tm = 0;
         this.tm.stop();
         this.mc["mc_base" + param1].mc_plan.visible = false;
         this.pdbo = true;
         if(!param2)
         {
            RegisteredData.getInstance().hs(32,48,this.mc);
            if(param3 == 1)
            {
               return;
            }
            ConstructionAction.getInstance().addResource(0,0,RegisteredData.getInstance().money,0);
            return;
         }
         ++this.levelarr[param1];
         var _loc4_:uint = uint(this.levelarr[param1]);
         this.mc["mc_base" + param1].tf_page.text = String(CScienceReader.getInstance().weaponarr[param1][_loc4_ - 1].Title);
         RegisteredData.getInstance().hs(32,48,this.mc);
         this.xxarr.length = 0;
         this.barr.length = 0;
         this.carr.length = 0;
         this.darr.length = 0;
         this.jtou();
      }
      
      public function timeHd(param1:uint, param2:uint) : void
      {
         if(this.pdbo)
         {
            this.raiingHd();
         }
         this._id = param1;
         this._tm = param2;
         var _loc3_:uint = uint(this.levelarr[this._id]);
         this._totm = CScienceReader.getInstance().weaponarr[this._id][_loc3_].Time;
         this.mc["mc_base" + param1].mc_plan.visible = true;
         this.mc["mc_base" + param1].mc_plan.mc_planbar.width = 37 / this._totm * (this._totm - this._tm);
         RegisteredData.getInstance().zsqs(32,48,param1);
      }
      
      private function raiingHd() : void
      {
         this.pdbo = false;
         if(this.tm.running)
         {
            this.tm.stop();
         }
         this.tm.start();
      }
      
      private function ttHd(param1:TimerEvent) : void
      {
         --this._tm;
         this.mc["mc_base" + this._id].mc_plan.mc_planbar.width = 37 / this._totm * (this._totm - this._tm);
         if(this._tm <= 0)
         {
            this._tm = 0;
            this.mc["mc_base" + this._id].mc_plan.mc_planbar.width = 37;
            this.tm.stop();
         }
      }
      
      private function raiHd(param1:MouseEvent) : void
      {
         var _loc2_:uint = uint(param1.currentTarget.idd);
         RegisteredData.getInstance().ppd(_loc2_);
         if(!RegisteredData.getInstance().pdd || param1.currentTarget.tj == 0)
         {
            return;
         }
         if(this.levelarr[_loc2_] >= CScienceReader.getInstance().weaponarr[_loc2_].length)
         {
            return;
         }
         if(ScienceSystem.getinstance().zzsjarr.length >= RegisteredData.getInstance().duilie)
         {
            return;
         }
         if(ScienceSystem.getinstance().zzsjarr.length != 0)
         {
            if(ScienceSystem.getinstance().zzsjarr[0].tc >= 32 && ScienceSystem.getinstance().zzsjarr[0].tc < 48)
            {
               return;
            }
         }
         var _loc3_:int = int(this.levelarr[_loc2_]);
         if(_loc3_ <= 0)
         {
            _loc3_ = 0;
         }
         if(CScienceReader.getInstance().weaponarr[_loc2_][_loc3_].Money > GamePlayer.getInstance().UserMoney)
         {
            return;
         }
         this.buqian = CScienceReader.getInstance().weaponarr[_loc2_][_loc3_].Money;
         RegisteredData.getInstance().money = CScienceReader.getInstance().weaponarr[_loc2_][_loc3_].Money;
         var _loc4_:uint = 0;
         if(ScienceSystem.getinstance().zzsjarr.length == 0)
         {
            _loc4_ = 0;
         }
         else if(ScienceSystem.getinstance().zzsjarr[0].CreditFlag == 0)
         {
            _loc4_ = 1;
            if(GamePlayer.getInstance().cash < GamePlayer.getInstance().TechQueueCredit)
            {
               return;
            }
            ConstructionAction.getInstance().costResource(0,0,0,GamePlayer.getInstance().TechQueueCredit);
         }
         else
         {
            _loc4_ = 0;
         }
         ConstructionAction.getInstance().costResource(0,0,CScienceReader.getInstance().weaponarr[_loc2_][_loc3_].Money,0);
         var _loc5_:MSG_REQUEST_CREATETECH = new MSG_REQUEST_CREATETECH();
         _loc5_.SeqId = GamePlayer.getInstance().seqID++;
         _loc5_.Guid = GamePlayer.getInstance().Guid;
         _loc5_.TechId = _loc2_;
         _loc5_.CreditFlag = _loc4_;
         NetManager.Instance().sendObject(_loc5_);
      }
      
      private function ovHd(param1:MouseEvent) : void
      {
         var _loc4_:int = 0;
         var _loc2_:uint = uint(param1.currentTarget.idd);
         this.mc.addChild(this.tip);
         this.tip.x = param1.currentTarget.x + 20;
         this.tip.y = param1.currentTarget.y + 20;
         if(param1.currentTarget.x >= 10)
         {
            this.tip.x = param1.currentTarget.x + 20 - RegisteredData.getInstance().tiplen;
         }
         this.tip.name_txt.text = String(CScienceReader.getInstance().WeaponTechAry[_loc2_].name);
         var _loc3_:int = int(this.levelarr[_loc2_]);
         if(_loc3_ <= 0)
         {
            _loc3_ = 0;
         }
         if(this.levelarr[_loc2_] < CScienceReader.getInstance().weaponarr[_loc2_].length)
         {
            _loc4_ = int(CScienceReader.getInstance().weaponarr[_loc2_][_loc3_].Time);
            this.tip.dj_txt.text = StringManager.getInstance().getMessageString("TechnologyBtn9") + this.mc["mc_base" + _loc2_].tf_page.text;
            if(GamePlayer.getInstance().UserMoney < CScienceReader.getInstance().weaponarr[_loc2_][_loc3_].Money && ScienceSystem.getinstance().nowtechid != _loc2_)
            {
               this.tip.mny_txt.text = RegisteredData.getInstance().MoneyDouHao(CScienceReader.getInstance().weaponarr[_loc2_][_loc3_].Money) + StringManager.getInstance().getMessageString("TechnologyText0");
               this.tip.mny_txt.setTextFormat(this.ttff);
            }
            else
            {
               this.tip.mny_txt.text = RegisteredData.getInstance().MoneyDouHao(CScienceReader.getInstance().weaponarr[_loc2_][_loc3_].Money);
               this.tip.mny_txt.setTextFormat(RegisteredData.getInstance().textformat);
            }
         }
         else
         {
            _loc4_ = 0;
            this.tip.dj_txt.text = StringManager.getInstance().getMessageString("TechnologyBtn9") + CScienceReader.getInstance().weaponarr[_loc2_].length;
            this.tip.mny_txt.text = String("0");
         }
         this.hh = int(_loc4_ / (60 * 60));
         this.mm = int(_loc4_ % (60 * 60) / 60);
         this.ss = int(_loc4_ % (60 * 60) % 60);
         var _loc5_:String = this.hh.toString();
         var _loc6_:String = this.mm.toString();
         var _loc7_:String = this.ss.toString();
         if(this.hh < 10)
         {
            _loc5_ = "0" + this.hh.toString();
         }
         if(this.mm < 10)
         {
            _loc6_ = "0" + this.mm.toString();
         }
         if(this.ss < 10)
         {
            _loc7_ = "0" + this.ss.toString();
         }
         this.tip.tm_txt.text = _loc5_ + ":" + _loc6_ + ":" + _loc7_;
         var _loc8_:uint = uint(param1.currentTarget.idd);
         RegisteredData.getInstance().ppd(_loc8_);
         this.tip.xy_txt.htmlText = RegisteredData.getInstance().GetHtml(String(CScienceReader.getInstance().WeaponTechAry[_loc2_].TechMemo));
         if(this.levelarr[_loc2_] < CScienceReader.getInstance().weaponarr[_loc2_].length)
         {
            if(this.levelarr[_loc2_] != 0)
            {
               this.tip.con_txt.htmlText = RegisteredData.getInstance().GetConHtml(String(CScienceReader.getInstance().weaponarr[_loc2_][_loc3_ - 1].Comment));
            }
            else
            {
               this.tip.con_txt.htmlText = RegisteredData.getInstance().GetConHtml(String(CScienceReader.getInstance().WeaponTechAry[_loc2_].comment));
            }
            if(ScienceSystem.getinstance().zzsjarr.length == 1)
            {
               if(ScienceSystem.getinstance().zzsjarr[0].CreditFlag == 0 && ScienceSystem.getinstance().zzsjarr[0].tc >= 48 || ScienceSystem.getinstance().zzsjarr[0].tc < 32)
               {
                  if(GamePlayer.getInstance().cash < GamePlayer.getInstance().TechQueueCredit)
                  {
                     this.tip.cash_txt.text = String(GamePlayer.getInstance().TechQueueCredit + "   (cash不足)");
                     this.tip.cash_txt.setTextFormat(this.ttff);
                  }
                  else
                  {
                     this.tip.cash_txt.text = String(GamePlayer.getInstance().TechQueueCredit);
                  }
                  this.tip.pdd(0);
               }
               else
               {
                  this.tip.pdd(2);
               }
            }
            else
            {
               this.tip.pdd(2);
            }
         }
         else
         {
            this.tip.con_txt.htmlText = RegisteredData.getInstance().GetConHtml(String(CScienceReader.getInstance().weaponarr[_loc2_][_loc3_ - 1].Comment));
            this.tip.pdd(1);
         }
         if(_loc8_ == 34 || _loc8_ == 35 || _loc8_ == 36 || _loc8_ == 37 || _loc8_ == 38 || _loc8_ == 39 || _loc8_ == 40)
         {
            this.aa(33);
         }
         if(_loc8_ == 45 || _loc8_ == 46 || _loc8_ == 47)
         {
            this.aa(33);
            this.aa(38);
            this.aa(39);
            this.aa(40);
            if(_loc8_ == 46 || _loc8_ == 47)
            {
               this.aa(35);
               this.aa(36);
               this.aa(37);
               if(_loc8_ == 47)
               {
                  this.aa(46);
               }
            }
         }
         this.aa(_loc8_);
         this.LineHd();
      }
      
      private function LineHd() : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc1_:uint = 0;
         while(_loc1_ < this.xxarr.length)
         {
            _loc2_ = int(this.xxarr[_loc1_][0]);
            _loc3_ = int(this.xxarr[_loc1_][1]);
            if(_loc2_ == 0 || _loc3_ == 0)
            {
               _loc2_ = 0;
               _loc3_ = 1;
            }
            if(this.mc["x" + _loc2_ + "_" + _loc3_] != null && this.mc.contains(this.mc["x" + _loc2_ + "_" + _loc3_]))
            {
               this.mc["x" + _loc2_ + "_" + _loc3_].gotoAndStop(2);
            }
            if(_loc2_ == 32 || _loc3_ == 32)
            {
               this.mc["x" + 32 + "_" + 33 + "_" + 41].gotoAndStop(2);
            }
            if(_loc2_ == 35 || _loc3_ == 38 || _loc2_ == 34)
            {
               this.mc["x" + 34 + "_" + 35 + "_" + 38].gotoAndStop(2);
            }
            if(_loc2_ == 46 || _loc3_ == 46)
            {
               this.mc["x" + 37 + "_" + 45 + "_" + 46].gotoAndStop(2);
            }
            _loc1_++;
         }
      }
      
      private function aa(param1:uint) : void
      {
         var _loc4_:Array = null;
         this.barr.length = 0;
         this.carr.length = 0;
         this.darr.length = 0;
         this.barr = String(CScienceReader.getInstance().WeaponTechAry[param1].tech).split(";");
         this.barr.reverse();
         var _loc2_:uint = 0;
         while(_loc2_ < this.barr.length)
         {
            this.carr = this.barr[_loc2_].split(":");
            this.darr.push(this.carr);
            _loc4_ = new Array();
            _loc4_.length = 0;
            _loc4_[0] = this.darr[_loc2_][0];
            _loc4_[1] = param1;
            this.xxarr.push(_loc4_);
            _loc2_++;
         }
         var _loc3_:uint = 0;
         while(_loc3_ < this.darr.length)
         {
            if(this.darr[_loc3_][0] != 0)
            {
               this.aa(this.darr[_loc3_][0]);
            }
            _loc3_++;
         }
      }
      
      private function ouHd(param1:MouseEvent) : void
      {
         if(this.tip != null && this.mc.contains(this.tip))
         {
            this.mc.removeChild(this.tip);
         }
         this.xxarr.length = 0;
         this.barr.length = 0;
         this.carr.length = 0;
         this.darr.length = 0;
         this.jtou();
      }
   }
}

