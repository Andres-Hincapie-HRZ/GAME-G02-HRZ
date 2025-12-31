package logic.ui
{
   import com.star.frameworks.events.ActionEvent;
   import com.star.frameworks.managers.StringManager;
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.utils.Timer;
   import logic.entry.GamePlayer;
   import logic.entry.HButton;
   import logic.entry.MObject;
   import logic.entry.ScienceSystem;
   import logic.game.GameKernel;
   import logic.manager.GameInterActiveManager;
   import logic.reader.CScienceReader;
   import logic.utils.*;
   import logic.widget.ConstructionOperationWidget;
   import logic.widget.DataWidget;
   import logic.widget.OperationEnum;
   import net.base.NetManager;
   import net.msg.sciencesystem.MSG_REQUEST_CANCELTECH;
   
   public class ScienceSystemUi extends AbstractPopUp
   {
      
      private static var instance:ScienceSystemUi;
      
      public static var IsOpen:Boolean = false;
      
      private var content:MovieClip;
      
      private var js1:uint = 4;
      
      private var js2:uint = 1;
      
      private var jsd1:uint = 4;
      
      private var jsd2:uint = 1;
      
      private var Emmc:MovieClip = new MovieClip();
      
      private var jjmc:MovieClip;
      
      private var uiarr:Array = new Array();
      
      private var speed_btn:HButton;
      
      private var cancel_btn:HButton;
      
      private var ld:Loader;
      
      private var hh:int = 0;
      
      private var mm:int = 0;
      
      private var ss:int = 0;
      
      public var arr:Array = new Array();
      
      private var tm:Timer = new Timer(1000);
      
      public var ldarr:Array = new Array();
      
      private var tip:ScienceUiTip;
      
      private var Speedtip:ScienceUiTip;
      
      private var btntip:MovieClip;
      
      private var quxiao:int = 0;
      
      private var backgr:MovieClip;
      
      public function ScienceSystemUi()
      {
         super();
         setPopUpName("ScienceSystemUi");
      }
      
      public static function getInstance() : ScienceSystemUi
      {
         if(instance == null)
         {
            instance = new ScienceSystemUi();
         }
         return instance;
      }
      
      override public function Init() : void
      {
         if(GameKernel.popUpDisplayManager.PopDisplayList.ContainsKey(getPopUpName()))
         {
            ScienceSystemUi.IsOpen = true;
            return;
         }
         this._mc = new MObject("TechnologyScene",380,310);
         this.initMcElement();
         GameKernel.popUpDisplayManager.Regisger(instance);
      }
      
      override public function initMcElement() : void
      {
         this.content = this._mc.getMC();
         this.content["mc_time0"].tf_remaintime.text = "";
         this.content["mc_time0"].tf_lv.text = "";
         this.content["mc_time0"].visible = false;
         var _loc1_:HButton = new HButton(this.content.btn_close);
         GameInterActiveManager.InstallInterActiveEvent(_loc1_.m_movie,ActionEvent.ACTION_CLICK,this.onCloseWnd);
         this.content.addChild(this.Emmc);
         TrajectoryUi.getInstance().Init();
         OpticsUi.getInstance().Init();
         MissileUi.getInstance().Init();
         FlattopUi.getInstance().Init();
         AirshipUi.getInstance().Init();
         BuildChargeUI.getInstance().Init();
         ResgatherUi.getInstance().Init();
         var _loc2_:uint = 0;
         while(_loc2_ < 7)
         {
            this.content["btn" + _loc2_].buttonMode = true;
            this.content["btn" + _loc2_].gotoAndStop(1);
            this.content["btn" + _loc2_].cs = this.jsd2;
            this.content["btn" + _loc2_].nns = _loc2_;
            this.content["btn" + _loc2_].addEventListener(MouseEvent.MOUSE_OVER,this.ovHd);
            this.content["btn" + _loc2_].addEventListener(MouseEvent.MOUSE_OUT,this.ouHd);
            this.content["btn" + _loc2_].addEventListener(MouseEvent.MOUSE_DOWN,this.ddHd);
            this.content["btn" + _loc2_].addEventListener(MouseEvent.MOUSE_UP,this.upHd);
            this.content["btn" + _loc2_].xx = _loc2_;
            switch(_loc2_)
            {
               case 6:
                  this.jjmc = ResgatherUi.getInstance().getPopUp().getMC();
                  break;
               case 5:
                  this.jjmc = BuildChargeUI.getInstance().getPopUp().getMC();
                  break;
               case 0:
                  this.jjmc = TrajectoryUi.getInstance().getPopUp().getMC();
                  break;
               case 1:
                  this.jjmc = OpticsUi.getInstance().getPopUp().getMC();
                  break;
               case 2:
                  this.jjmc = MissileUi.getInstance().getPopUp().getMC();
                  break;
               case 3:
                  this.jjmc = FlattopUi.getInstance().getPopUp().getMC();
                  break;
               case 4:
                  this.jjmc = AirshipUi.getInstance().getPopUp().getMC();
            }
            MovieClip(this.content["mc_time0"].btn_tech).buttonMode = true;
            MovieClip(this.content["mc_time0"].btn_tech).addEventListener(MouseEvent.ROLL_OVER,this.btntechovHd);
            MovieClip(this.content["mc_time0"].btn_tech).addEventListener(MouseEvent.ROLL_OUT,this.btntechouHd);
            MovieClip(this.content["mc_time0"].btn_tech).addEventListener(MouseEvent.CLICK,this.tzhuanHd);
            this.uiarr.push(this.jjmc);
            _loc2_++;
         }
         this.content.btn6.cs = this.jsd1;
         this.content.btn6.gotoAndStop(4);
         this.Emmc.addChild(this.uiarr[6]);
         this.speed_btn = new HButton(this.content.mc_time0.btn_speed);
         this.cancel_btn = new HButton(this.content.mc_time0.btn_cancel);
         this.cancel_btn.m_movie.xx = 0;
         this.speed_btn.m_movie.xx = 0;
         this.cancel_btn.m_movie.addEventListener(MouseEvent.CLICK,this.closeHd);
         this.speed_btn.m_movie.addEventListener(MouseEvent.ROLL_OVER,this.speedOvHd);
         this.speed_btn.m_movie.addEventListener(MouseEvent.ROLL_OUT,this.speedOuHd);
         this.cancel_btn.m_movie.addEventListener(MouseEvent.ROLL_OVER,this.speedOvHd);
         this.cancel_btn.m_movie.addEventListener(MouseEvent.ROLL_OUT,this.speedOuHd);
         this.speed_btn.m_movie.addEventListener(MouseEvent.CLICK,this.speedHd);
         this.tm.addEventListener(TimerEvent.TIMER,this.ttHd);
      }
      
      public function sjj(param1:Object) : void
      {
         if(0 == this.arr.length)
         {
            this.arr.push(param1);
         }
         if(this.tm.running)
         {
            return;
         }
         this.tm.start();
         this.Sgigi();
      }
      
      private function tzhuanHd(param1:MouseEvent) : void
      {
         var _loc3_:uint = 0;
         var _loc5_:MovieClip = null;
         var _loc2_:uint = uint(param1.currentTarget.parent.name.substring(7));
         var _loc4_:uint = 0;
         while(_loc4_ < this.arr.length)
         {
            if(_loc2_ == this.arr[_loc4_].CreditFlag)
            {
               _loc3_ = uint(this.arr[_loc4_].tc);
               break;
            }
            _loc4_++;
         }
         if(_loc3_ < 16)
         {
            _loc5_ = this.content["btn" + 0];
         }
         else if(_loc3_ >= 16 && _loc3_ < 32)
         {
            _loc5_ = this.content["btn" + 1];
         }
         else if(_loc3_ >= 32 && _loc3_ < 48)
         {
            _loc5_ = this.content["btn" + 2];
         }
         else if(_loc3_ >= 48 && _loc3_ < 64)
         {
            _loc5_ = this.content["btn" + 3];
         }
         else if(_loc3_ >= 70 && _loc3_ < 89)
         {
            _loc5_ = this.content["btn" + 4];
         }
         else if(_loc3_ >= 89 && _loc3_ < 97)
         {
            _loc5_ = this.content["btn" + 5];
         }
         else if(_loc3_ >= 100 && _loc3_ < 111)
         {
            _loc5_ = this.content["btn" + 6];
         }
         if(_loc5_.cs == 4)
         {
            return;
         }
         var _loc6_:uint = 0;
         while(_loc6_ < 7)
         {
            this.content["btn" + _loc6_].cs = this.jsd2;
            this.content["btn" + _loc6_].gotoAndStop(1);
            _loc6_++;
         }
         _loc5_.cs = this.jsd1;
         _loc5_.gotoAndStop(this.jsd1);
         this.Emmc.removeChildAt(0);
         this.Emmc.addChild(this.uiarr[_loc5_.xx]);
      }
      
      private function btntechovHd(param1:MouseEvent) : void
      {
         var _loc2_:uint = uint(param1.currentTarget.parent.name.substring(7));
         this.tip = new ScienceUiTip();
         this.content.addChild(this.tip);
         if(_loc2_ == 0)
         {
            this.tip.x = -275;
         }
         else
         {
            this.tip.x = -50;
         }
         this.tip.y = 200;
         var _loc3_:uint = 0;
         while(_loc3_ < this.arr.length)
         {
            if(_loc2_ == this.arr[_loc3_].CreditFlag)
            {
               this.tip.addChild(McBitmap.getInstance().mcarr1[this.arr[_loc3_].tc]);
               if(this.arr[_loc3_].tc < 64)
               {
                  this.tip.name_txt.text = String(CScienceReader.getInstance().WeaponTechAry[this.arr[_loc3_].tc].name);
               }
               else if(this.arr[_loc3_].tc >= 70 && this.arr[_loc3_].tc < 97)
               {
                  this.tip.name_txt.text = String(CScienceReader.getInstance().DefenceTechAry[this.arr[_loc3_].tc].name);
               }
               else if(this.arr[_loc3_].tc >= 100 && this.arr[_loc3_].tc < 111)
               {
                  this.tip.name_txt.text = String(CScienceReader.getInstance().TechArr[this.arr[_loc3_].tc].name);
               }
            }
            _loc3_++;
         }
         this.tip.pdd();
      }
      
      private function btntechouHd(param1:MouseEvent) : void
      {
         if(this.tip != null && this.content.contains(this.tip))
         {
            this.content.removeChild(this.tip);
         }
      }
      
      private function Sgigi() : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc1_:uint = 0;
         while(_loc1_ < this.arr.length)
         {
            if(this.ldarr.length != 0)
            {
               this.ldarr.length = 0;
            }
            if(this.arr[_loc1_].CreditFlag == 0)
            {
               this.content["mc_time0"].visible = true;
               _loc2_ = this.hh.toString();
               _loc3_ = this.mm.toString();
               this.content["mc_time0"].tf_remaintime.text = DataWidget.localToDataZone(this.arr[_loc1_].needtime);
               this.content["mc_time0"].tf_lv.text = String("Lv" + this.arr[_loc1_].leve + "→" + uint(this.arr[_loc1_].leve + 1));
            }
            _loc1_++;
         }
      }
      
      private function ttHd(param1:TimerEvent) : void
      {
         var _loc2_:uint = 0;
         while(_loc2_ < this.arr.length)
         {
            if(this.arr[_loc2_].needtime > 0)
            {
               --this.arr[_loc2_].needtime;
               this.hh = int(this.arr[_loc2_].needtime / (60 * 60));
               this.mm = int(this.arr[_loc2_].needtime % (60 * 60) / 60);
               this.ss = int(this.arr[_loc2_].needtime % (60 * 60) % 60);
               if(this.arr[_loc2_].CreditFlag == 0)
               {
                  this.content["mc_time0"].tf_remaintime.text = DataWidget.localToDataZone(this.arr[_loc2_].needtime);
                  ScienceSystem.getinstance().ScienceObj.needtime = this.arr[_loc2_].needtime;
                  this.content["mc_time0"].tf_lv.text = String("Lv" + this.arr[_loc2_].leve + "→" + uint(this.arr[_loc2_].leve + 1));
               }
               if(this.arr[_loc2_].needtime == 0)
               {
                  this.arr[_loc2_].needtime = 0;
                  if(this.arr[_loc2_].CreditFlag == 0)
                  {
                     this.content["mc_time0"].visible = false;
                     this.content["mc_time0"].tf_remaintime.text = "";
                  }
                  this.arr.splice(_loc2_,1);
                  if(this.arr.length == 0)
                  {
                     this.tm.stop();
                  }
               }
            }
            _loc2_++;
         }
      }
      
      private function closeHd(param1:MouseEvent) : void
      {
         this.quxiao = param1.currentTarget.xx;
         this.backgr = new MovieClip();
         MoveEfect.getInstance().BlackHd(this.content,this.backgr);
         ConstructionOperationWidget.currenCmd = OperationEnum.OPERATION_TYPE_CANCEL_UPGRADE;
         UpgradeModulesPopUp.getInstance().Init();
         UpgradeModulesPopUp.getInstance().Show();
      }
      
      public function Hider() : void
      {
         if(this.backgr != null && this.content.contains(this.backgr))
         {
            this.content.removeChild(this.backgr);
         }
      }
      
      public function CANCEL() : void
      {
         var _loc1_:MSG_REQUEST_CANCELTECH = null;
         var _loc2_:uint = 0;
         if(this.content["mc_time" + this.quxiao].tf_remaintime.text == "")
         {
            return;
         }
         _loc1_ = new MSG_REQUEST_CANCELTECH();
         _loc1_.SeqId = GamePlayer.getInstance().seqID++;
         _loc1_.Guid = GamePlayer.getInstance().Guid;
         _loc2_ = 0;
         while(_loc2_ < this.arr.length)
         {
            if(this.arr[_loc2_].CreditFlag == this.quxiao)
            {
               _loc1_.TechId = this.arr[_loc2_].tc;
            }
            _loc2_++;
         }
         NetManager.Instance().sendObject(_loc1_);
      }
      
      public function qkong(param1:uint, param2:int = 0) : void
      {
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         while(_loc4_ < this.arr.length)
         {
            if(this.arr[_loc4_].tc == param1)
            {
               _loc3_ = uint(this.arr[_loc4_].CreditFlag);
               this.arr.splice(_loc4_,1);
               break;
            }
            _loc4_++;
         }
         _loc3_ = 0;
         if(param2 == 0)
         {
            this.content["mc_time" + _loc3_].tf_remaintime.text = "";
            this.content["mc_time" + _loc3_].tf_lv.text = "";
            this.content["mc_time" + _loc3_].visible = false;
         }
         if(this.arr.length == 0)
         {
            this.tm.stop();
         }
      }
      
      private function upHd(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = param1.currentTarget as MovieClip;
         if(_loc2_.cs == this.jsd1)
         {
            return;
         }
         var _loc3_:uint = 0;
         while(_loc3_ < 7)
         {
            this.content["btn" + _loc3_].cs = this.jsd2;
            this.content["btn" + _loc3_].gotoAndStop(1);
            _loc3_++;
         }
         _loc2_.cs = this.jsd1;
         _loc2_.gotoAndStop(this.jsd1);
         this.Emmc.removeChildAt(0);
         this.Emmc.addChild(this.uiarr[_loc2_.xx]);
      }
      
      private function ddHd(param1:MouseEvent) : void
      {
         param1.currentTarget.gotoAndStop(3);
      }
      
      private function ovHd(param1:MouseEvent) : void
      {
         var _loc2_:uint = uint(param1.currentTarget.cs);
         param1.currentTarget.gotoAndStop(_loc2_ + 1);
         this.btntip = new MovieClip();
         var _loc3_:TextField = new TextField();
         this.btntip.addChild(_loc3_);
         var _loc4_:int = int(param1.currentTarget.nns);
         var _loc5_:String = "";
         if(_loc4_ == 0)
         {
            _loc5_ = StringManager.getInstance().getMessageString("TechnologyBtn2");
         }
         else if(_loc4_ == 1)
         {
            _loc5_ = StringManager.getInstance().getMessageString("TechnologyBtn3");
         }
         else if(_loc4_ == 2)
         {
            _loc5_ = StringManager.getInstance().getMessageString("TechnologyBtn4");
         }
         else if(_loc4_ == 3)
         {
            _loc5_ = StringManager.getInstance().getMessageString("TechnologyBtn5");
         }
         else if(_loc4_ == 4)
         {
            _loc5_ = StringManager.getInstance().getMessageString("TechnologyBtn6");
         }
         else if(_loc4_ == 5)
         {
            _loc5_ = StringManager.getInstance().getMessageString("TechnologyBtn8");
         }
         else if(_loc4_ == 6)
         {
            _loc5_ = StringManager.getInstance().getMessageString("TechnologyBtn7");
         }
         _loc3_.textColor = 16777215;
         _loc3_.x = 2;
         _loc3_.selectable = false;
         _loc3_.autoSize = TextFieldAutoSize.LEFT;
         _loc3_.text = _loc5_;
         this.btntip.graphics.clear();
         this.btntip.graphics.lineStyle(1,479858);
         this.btntip.graphics.beginFill(0,0.7);
         this.btntip.graphics.drawRoundRect(0,0,_loc3_.width + 4,20,2,2);
         this.btntip.graphics.endFill();
         this.content.addChild(this.btntip);
         this.btntip.x = param1.currentTarget.x + 20;
         this.btntip.y = param1.currentTarget.y + 30;
      }
      
      private function ouHd(param1:MouseEvent) : void
      {
         var _loc2_:uint = uint(param1.currentTarget.cs);
         param1.currentTarget.gotoAndStop(_loc2_);
         if(this.btntip != null && this.content.contains(this.btntip))
         {
            this.content.removeChild(this.btntip);
         }
      }
      
      private function speedOvHd(param1:MouseEvent) : void
      {
         this.Speedtip = new ScienceUiTip();
         this.content.addChild(this.Speedtip);
         this.Speedtip.name_txt.wordWrap = false;
         if(param1.currentTarget.name == "btn_cancel")
         {
            this.Speedtip.x = param1.currentTarget.parent.x + 180;
            this.Speedtip.y = param1.currentTarget.parent.y + 30;
            this.Speedtip.name_txt.text = StringManager.getInstance().getMessageString("TechnologyBtn11");
         }
         else
         {
            this.Speedtip.x = param1.currentTarget.parent.x + 145;
            this.Speedtip.y = param1.currentTarget.parent.y + 30;
            this.Speedtip.name_txt.text = StringManager.getInstance().getMessageString("TechnologyText1");
         }
         this.Speedtip.speedtip();
      }
      
      private function speedOuHd(param1:MouseEvent) : void
      {
         if(this.Speedtip != null && this.content.contains(this.Speedtip))
         {
            this.content.removeChild(this.Speedtip);
         }
      }
      
      private function speedHd(param1:MouseEvent) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         this.backgr = new MovieClip();
         MoveEfect.getInstance().BlackHd(this.content,this.backgr);
         ScienceSpeedPopUp.getInstance().Init();
         GameKernel.popUpDisplayManager.Show(ScienceSpeedPopUp.getInstance());
         var _loc2_:Object = new Object();
         var _loc5_:int = int(param1.currentTarget.xx);
         var _loc6_:uint = 0;
         while(_loc6_ < this.arr.length)
         {
            if(this.arr[_loc6_].CreditFlag == _loc5_)
            {
               _loc3_ = int(this.arr[_loc6_].tc);
               _loc4_ = int(this.arr[_loc6_].needtime);
            }
            _loc6_++;
         }
         _loc2_.pro = _loc3_;
         _loc2_.tm = this.arr[0].needtime;
         _loc2_.tt = this.content["mc_time0"].tf_remaintime.text;
         ScienceSpeedPopUp.getInstance().pdd(_loc2_);
      }
      
      public function onCloseWnd(param1:MouseEvent) : void
      {
         ScienceSystemUi.IsOpen = false;
         GameKernel.popUpDisplayManager.Hide(instance);
         this.arr.pop();
         if(this.arr.length == 0)
         {
            return;
         }
         ScienceSystem.getinstance().CloseScienceSystemUI(this.arr[0].tc);
      }
   }
}

