package logic.ui
{
   import com.star.frameworks.facebook.FacebookClient;
   import com.star.frameworks.managers.StringManager;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import logic.entry.GamePlayer;
   import logic.entry.HButton;
   import logic.entry.MObject;
   import logic.entry.commander.CommanderXmlInfo;
   import logic.entry.props.propsInfo;
   import logic.game.GameKernel;
   import logic.reader.CCommanderReader;
   import logic.reader.CPropsReader;
   import logic.ui.info.BleakingLineForThai;
   import logic.ui.tip.PropsTip;
   import logic.utils.UpdateResource;
   import net.base.NetManager;
   import net.msg.MSG_REQUEST_REFRESHWALL;
   import net.msg.MSG_RESP_REFRESHWALL;
   import net.msg.fightMsg.FightRobResource;
   import net.msg.fightMsg.MSG_RESP_FIGHTRESULT;
   
   public class EnjoyUi extends AbstractPopUp
   {
      
      private static var instance:EnjoyUi;
      
      private var McBase:MovieClip;
      
      private var _PropsId:int;
      
      private var _PropsTipPoint:Point;
      
      private var MsgContent:String;
      
      private var MsgTitle:String;
      
      private var PublshMsg:String;
      
      private var ImageFileName:String;
      
      public function EnjoyUi()
      {
         super();
         setPopUpName("EnjoyUi");
      }
      
      public static function getInstance() : EnjoyUi
      {
         if(instance == null)
         {
            instance = new EnjoyUi();
         }
         return instance;
      }
      
      override public function Init() : void
      {
         if(GameKernel.popUpDisplayManager.PopDisplayList.ContainsKey(getPopUpName()))
         {
            return;
         }
         this._mc = new MObject("EnjoyUi",385,300);
         this.initMcElement();
         GameKernel.popUpDisplayManager.Regisger(instance);
      }
      
      override public function initMcElement() : void
      {
         var _loc1_:HButton = new HButton(this._mc.getMC().getChildByName("btn_enjoyaward") as MovieClip);
         _loc1_.m_movie.addEventListener(MouseEvent.CLICK,this.btn_enjoyawardClick);
         var _loc2_:HButton = new HButton(this._mc.getMC().getChildByName("btn_cancel") as MovieClip);
         _loc2_.m_movie.addEventListener(MouseEvent.CLICK,this.btn_cancelClick);
         this.McBase = this._mc.getMC().mc_award as MovieClip;
         this.McBase = this.McBase.mc_base as MovieClip;
         this.McBase.addEventListener(MouseEvent.MOUSE_OVER,this.McBaseOver);
         this.McBase.addEventListener(MouseEvent.MOUSE_OUT,this.McBaseOut);
         this._PropsTipPoint = this.McBase.localToGlobal(new Point(0,this.McBase.height));
      }
      
      public function ShowBattleReport2(param1:String, param2:MSG_RESP_FIGHTRESULT) : void
      {
         var _loc3_:String = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         this.Init();
         this.ImageFileName = "http://static.go2.browsergame.com/en/images/publish2/";
         if(GameKernel.PublishUrl != null && GameKernel.PublishUrl != "")
         {
            this.ImageFileName = GameKernel.PublishUrl;
         }
         this.RequestPublicInfo(0);
         this.ShowType(2);
         if(param2.Victory == 1)
         {
            if(param1 == GamePlayer.getInstance().Name)
            {
               this.ImageFileName += StringManager.getInstance().getMessageString("Boss9");
               MovieClip(this._mc.getMC().mc_enjoyreport.mc_win).visible = false;
               MovieClip(this._mc.getMC().mc_enjoyreport.mc_lose).visible = true;
               _loc3_ = FightRobResource(param2.Prize[0]).RoleName;
               _loc4_ = param2.DefendShipNumber;
               _loc5_ = param2.DefendLossNumber;
               _loc6_ = param2.AttackShipNumber;
               _loc7_ = param2.AttackLossNumber;
               MovieClip(this._mc.getMC().mc_enjoyreport.mc_reportname).gotoAndStop(2);
               this.MsgContent = StringManager.getInstance().getMessageString("EmailText23");
               this.PublshMsg = StringManager.getInstance().getMessageString("EmailText24");
               this.MsgTitle = StringManager.getInstance().getMessageString("EmailText36");
            }
            else
            {
               this.ImageFileName += StringManager.getInstance().getMessageString("Boss8");
               MovieClip(this._mc.getMC().mc_enjoyreport.mc_win).visible = true;
               MovieClip(this._mc.getMC().mc_enjoyreport.mc_lose).visible = false;
               _loc3_ = param1;
               _loc6_ = param2.DefendShipNumber;
               _loc7_ = param2.DefendLossNumber;
               _loc4_ = param2.AttackShipNumber;
               _loc5_ = param2.AttackLossNumber;
               MovieClip(this._mc.getMC().mc_enjoyreport.mc_reportname).gotoAndStop(1);
               this.MsgContent = StringManager.getInstance().getMessageString("EmailText25");
               this.PublshMsg = StringManager.getInstance().getMessageString("EmailText26");
               this.MsgTitle = StringManager.getInstance().getMessageString("EmailText37");
            }
         }
         else if(param1 == GamePlayer.getInstance().Name)
         {
            this.ImageFileName += StringManager.getInstance().getMessageString("Boss8");
            MovieClip(this._mc.getMC().mc_enjoyreport.mc_win).visible = true;
            MovieClip(this._mc.getMC().mc_enjoyreport.mc_lose).visible = false;
            _loc3_ = FightRobResource(param2.Prize[0]).RoleName;
            _loc4_ = param2.DefendShipNumber;
            _loc5_ = param2.DefendLossNumber;
            _loc6_ = param2.AttackShipNumber;
            _loc7_ = param2.AttackLossNumber;
            MovieClip(this._mc.getMC().mc_enjoyreport.mc_reportname).gotoAndStop(1);
            this.MsgContent = StringManager.getInstance().getMessageString("EmailText21");
            this.PublshMsg = StringManager.getInstance().getMessageString("EmailText22");
            this.MsgTitle = StringManager.getInstance().getMessageString("EmailText35");
         }
         else
         {
            this.ImageFileName += StringManager.getInstance().getMessageString("Boss9");
            MovieClip(this._mc.getMC().mc_enjoyreport.mc_win).visible = false;
            MovieClip(this._mc.getMC().mc_enjoyreport.mc_lose).visible = true;
            _loc3_ = param1;
            _loc6_ = param2.DefendShipNumber;
            _loc7_ = param2.DefendLossNumber;
            _loc4_ = param2.AttackShipNumber;
            _loc5_ = param2.AttackLossNumber;
            MovieClip(this._mc.getMC().mc_enjoyreport.mc_reportname).gotoAndStop(2);
            this.MsgContent = StringManager.getInstance().getMessageString("EmailText27");
            this.PublshMsg = StringManager.getInstance().getMessageString("EmailText28");
            this.MsgTitle = StringManager.getInstance().getMessageString("EmailText38");
         }
         if(GameKernel.youselfFaceBook != null && GameKernel.youselfFaceBook.FacebookName != null && GameKernel.youselfFaceBook.FacebookName != "")
         {
            this.PublshMsg = this.PublshMsg.replace("@@1",GameKernel.youselfFaceBook.FacebookName);
            this.MsgTitle = this.MsgTitle.replace("@@1",GameKernel.youselfFaceBook.FacebookName);
         }
         else
         {
            this.PublshMsg = this.PublshMsg.replace("@@1",GamePlayer.getInstance().Name);
            this.MsgTitle = this.MsgTitle.replace("@@1",GamePlayer.getInstance().Name);
         }
         TextField(this._mc.getMC().mc_enjoyreport.tf_selfname).text = GamePlayer.getInstance().Name;
         TextField(this._mc.getMC().mc_enjoyreport.txt_enemyname).text = _loc3_;
         TextField(this._mc.getMC().mc_enjoyreport.tf_selfnum).text = _loc4_.toString();
         TextField(this._mc.getMC().mc_enjoyreport.tf_selfloss).text = _loc5_.toString();
         TextField(this._mc.getMC().mc_enjoyreport.tf_enemynum).text = _loc6_.toString();
         TextField(this._mc.getMC().mc_enjoyreport.tf_enemyloss).text = _loc7_.toString();
         TextField(this._mc.getMC().txt_award).text = this.MsgContent;
         this.BleakForThai();
         GameKernel.popUpDisplayManager.Show(this);
      }
      
      public function ShowBattleReport(param1:String, param2:MSG_RESP_FIGHTRESULT) : void
      {
         this.Init();
         this.ImageFileName = "http://static.go2.browsergame.com/en/images/publish2/";
         if(GameKernel.PublishUrl != null && GameKernel.PublishUrl != "")
         {
            this.ImageFileName = GameKernel.PublishUrl;
         }
         this.ImageFileName += StringManager.getInstance().getMessageString("Boss4");
         this.RequestPublicInfo(0);
         this.ShowType(2);
         if(param2.Victory == 1)
         {
            MovieClip(this._mc.getMC().mc_enjoyreport.mc_win).visible = true;
            MovieClip(this._mc.getMC().mc_enjoyreport.mc_lose).visible = false;
            this.MsgContent = StringManager.getInstance().getMessageString("EmailText6");
            this.PublshMsg = StringManager.getInstance().getMessageString("EmailText7");
            this.MsgTitle = StringManager.getInstance().getMessageString("EmailText13");
         }
         else
         {
            MovieClip(this._mc.getMC().mc_enjoyreport.mc_win).visible = false;
            MovieClip(this._mc.getMC().mc_enjoyreport.mc_lose).visible = true;
            this.MsgContent = StringManager.getInstance().getMessageString("EmailText8");
            this.PublshMsg = StringManager.getInstance().getMessageString("EmailText9");
            this.MsgTitle = StringManager.getInstance().getMessageString("EmailText14");
         }
         if(GameKernel.youselfFaceBook != null && GameKernel.youselfFaceBook.FacebookName != null && GameKernel.youselfFaceBook.FacebookName != "")
         {
            this.PublshMsg = this.PublshMsg.replace("@@1",GameKernel.youselfFaceBook.FacebookName);
            this.MsgTitle = this.MsgTitle.replace("@@1",GameKernel.youselfFaceBook.FacebookName);
         }
         else
         {
            this.PublshMsg = this.PublshMsg.replace("@@1",GamePlayer.getInstance().Name);
            this.MsgTitle = this.MsgTitle.replace("@@1",GamePlayer.getInstance().Name);
         }
         TextField(this._mc.getMC().mc_enjoyreport.tf_selfname).text = GamePlayer.getInstance().Name;
         TextField(this._mc.getMC().mc_enjoyreport.txt_enemyname).text = param1;
         TextField(this._mc.getMC().mc_enjoyreport.tf_selfnum).text = param2.AttackShipNumber.toString();
         TextField(this._mc.getMC().mc_enjoyreport.tf_selfloss).text = param2.AttackLossNumber.toString();
         TextField(this._mc.getMC().mc_enjoyreport.tf_enemynum).text = param2.DefendShipNumber.toString();
         TextField(this._mc.getMC().mc_enjoyreport.tf_enemyloss).text = param2.DefendLossNumber.toString();
         TextField(this._mc.getMC().txt_award).text = this.MsgContent;
         this.BleakForThai();
         if(param2.Victory == 1)
         {
            MovieClip(this._mc.getMC().mc_enjoyreport.mc_reportname).gotoAndStop(1);
         }
         else if(param2.Victory == 0)
         {
            MovieClip(this._mc.getMC().mc_enjoyreport.mc_reportname).gotoAndStop(2);
         }
         else if(param2.Victory == 2)
         {
            MovieClip(this._mc.getMC().mc_enjoyreport.mc_reportname).gotoAndStop(3);
         }
         GameKernel.popUpDisplayManager.Show(this);
      }
      
      private function BleakForThai() : void
      {
         if(GamePlayer.getInstance().language == 7)
         {
            BleakingLineForThai.GetInstance().BleakThaiLanguage(TextField(this._mc.getMC().txt_award),2408447);
         }
      }
      
      public function ShowLotterReport(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:Bitmap = null;
         var _loc8_:propsInfo = null;
         var _loc9_:CommanderXmlInfo = null;
         this.Init();
         this.ImageFileName = "http://static.go2.browsergame.com/en/images/publish2/";
         if(GameKernel.PublishUrl != null && GameKernel.PublishUrl != "")
         {
            this.ImageFileName = GameKernel.PublishUrl;
         }
         this.RequestPublicInfo(0);
         _loc4_ = StringManager.getInstance().getMessageString("EmailText4");
         this.PublshMsg = StringManager.getInstance().getMessageString("EmailText5");
         this.MsgTitle = StringManager.getInstance().getMessageString("EmailText12");
         if(GameKernel.youselfFaceBook != null && GameKernel.youselfFaceBook.FacebookName != null && GameKernel.youselfFaceBook.FacebookName != "")
         {
            this.PublshMsg = this.PublshMsg.replace("@@1",GameKernel.youselfFaceBook.FacebookName);
            this.MsgTitle = this.MsgTitle.replace("@@1",GameKernel.youselfFaceBook.FacebookName);
         }
         else
         {
            this.PublshMsg = this.PublshMsg.replace("@@1",GamePlayer.getInstance().Name);
            this.MsgTitle = this.MsgTitle.replace("@@1",GamePlayer.getInstance().Name);
         }
         this._PropsId = -1;
         this.ShowType(1);
         switch(param1)
         {
            case 1:
               _loc5_ = StringManager.getInstance().getMessageString("ShipText26");
               _loc6_ = "Giftmoney2";
               this.ImageFileName = this.ImageFileName + _loc6_ + ".jpg";
               break;
            case 2:
               _loc5_ = StringManager.getInstance().getMessageString("ShipText10");
               _loc6_ = "BattleGold";
               this.ImageFileName = this.ImageFileName + _loc6_ + ".jpg";
               break;
            case 3:
               _loc5_ = StringManager.getInstance().getMessageString("ShipText9");
               _loc6_ = "BattleHe3";
               this.ImageFileName = this.ImageFileName + _loc6_ + ".jpg";
               break;
            case 4:
               _loc5_ = StringManager.getInstance().getMessageString("ShipText8");
               _loc6_ = "BattleMetal";
               this.ImageFileName = this.ImageFileName + _loc6_ + ".jpg";
               break;
            default:
               _loc8_ = CPropsReader.getInstance().GetPropsInfo(param2);
               _loc5_ = _loc8_.Name;
               _loc6_ = _loc8_.ImageFileName;
               this._PropsId = param2;
               if(_loc8_.PackID == 1)
               {
                  _loc9_ = CCommanderReader.getInstance().GetCommanderInfo(_loc8_.SkillID);
                  this.ImageFileName = this.ImageFileName + "card" + _loc9_.CommanderType + ".jpg";
                  break;
               }
               this.ImageFileName = this.ImageFileName + "Props" + param2 + ".jpg";
         }
         _loc7_ = new Bitmap(GameKernel.getTextureInstance(_loc6_));
         _loc7_.width = this.McBase.width;
         _loc7_.height = this.McBase.height;
         if(this.McBase.numChildren > 0)
         {
            this.McBase.removeChildAt(0);
         }
         this.McBase.addChild(_loc7_);
         TextField(this._mc.getMC().mc_award.tf_awardnum).text = "x" + param3;
         TextField(this._mc.getMC().txt_award).text = _loc4_;
         this.BleakForThai();
         GameKernel.popUpDisplayManager.Show(this);
      }
      
      public function PublishMessage(param1:String, param2:String, param3:String, param4:String, param5:String) : void
      {
         if(GameKernel.ForFB == 1 || GameKernel.ForRenRen == 1)
         {
            return;
         }
         this.Init();
         this.ShowType(3);
         this.RequestPublicInfo(0);
         this.MsgContent = param2;
         if(GameKernel.youselfFaceBook != null && GameKernel.youselfFaceBook.FacebookName != null && GameKernel.youselfFaceBook.FacebookName != "")
         {
            this.PublshMsg = param3.replace("@@1",GameKernel.youselfFaceBook.FacebookName);
            this.MsgTitle = param1.replace("@@1",GameKernel.youselfFaceBook.FacebookName);
         }
         else
         {
            this.PublshMsg = param3.replace("@@1",GamePlayer.getInstance().Name);
            this.MsgTitle = param1.replace("@@1",GamePlayer.getInstance().Name);
         }
         TextField(this._mc.getMC().txt_award).text = this.MsgContent;
         this.BleakForThai();
         this.ImageFileName = "http://static.go2.browsergame.com/en/images/publish2/";
         if(GameKernel.PublishUrl != null && GameKernel.PublishUrl != "")
         {
            this.ImageFileName = GameKernel.PublishUrl;
         }
         this.ImageFileName = this.ImageFileName + param5 + ".jpg";
         var _loc6_:MovieClip = MovieClip(this._mc.getMC().mc_novice.mc_base);
         if(_loc6_.numChildren > 0)
         {
            _loc6_.removeChildAt(0);
         }
         var _loc7_:Bitmap = new Bitmap(GameKernel.getTextureInstance(param4));
         _loc7_.smoothing = true;
         _loc7_.width = 40;
         _loc7_.height = 40;
         _loc6_.addChild(_loc7_);
         GameKernel.popUpDisplayManager.Show(this);
      }
      
      private function ShowType(param1:int) : void
      {
         if(param1 == 1)
         {
            MovieClip(this._mc.getMC().getChildByName("mc_enjoyreport")).visible = false;
            MovieClip(this._mc.getMC().getChildByName("mc_award")).visible = true;
            MovieClip(this._mc.getMC().getChildByName("mc_novice")).visible = false;
         }
         else if(param1 == 2)
         {
            MovieClip(this._mc.getMC().getChildByName("mc_enjoyreport")).visible = true;
            MovieClip(this._mc.getMC().getChildByName("mc_award")).visible = false;
            MovieClip(this._mc.getMC().getChildByName("mc_novice")).visible = false;
         }
         else if(param1 == 3)
         {
            MovieClip(this._mc.getMC().getChildByName("mc_enjoyreport")).visible = false;
            MovieClip(this._mc.getMC().getChildByName("mc_award")).visible = false;
            MovieClip(this._mc.getMC().getChildByName("mc_novice")).visible = true;
         }
      }
      
      private function McBaseOver(param1:MouseEvent) : void
      {
         if(this._PropsId < 0)
         {
            return;
         }
         PropsTip.GetInstance().Show(this._PropsId,this._PropsTipPoint);
      }
      
      private function McBaseOut(param1:MouseEvent) : void
      {
         PropsTip.GetInstance().Hide();
      }
      
      private function btn_enjoyawardClick(param1:Event) : void
      {
         FacebookClient.PublishStream3(this.MsgTitle,this.PublshMsg,"","",this.ImageFileName,GamePlayer.getInstance().gameUrl,this.PublishStream3Callback);
         this.RequestPublicInfo(1);
         this.btn_cancelClick(param1);
      }
      
      private function PublishStream3Callback(param1:Boolean) : void
      {
         if(!param1)
         {
            FacebookClient.CallPublishPermission();
         }
      }
      
      private function RequestPublicInfo(param1:int) : void
      {
         TextField(this._mc.getMC().txt_news).text = "";
         var _loc2_:MSG_REQUEST_REFRESHWALL = new MSG_REQUEST_REFRESHWALL();
         _loc2_.SeqId = GamePlayer.getInstance().seqID++;
         _loc2_.Guid = GamePlayer.getInstance().Guid;
         _loc2_.Type = param1;
         NetManager.Instance().sendObject(_loc2_);
      }
      
      public function Resp_MSG_RESP_REFRESHWALL(param1:MSG_RESP_REFRESHWALL) : void
      {
         if(param1.PropsId < 0)
         {
            return;
         }
         var _loc2_:propsInfo = CPropsReader.getInstance().GetPropsInfo(param1.PropsId);
         if(param1.Type == 1)
         {
            if(UpdateResource.getInstance().AddToPack(param1.PropsId,param1.Num,1) == false)
            {
               MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("EmailText10"),1);
            }
            ++GamePlayer.getInstance().Badge;
         }
         else
         {
            TextField(this._mc.getMC().txt_news).htmlText = StringManager.getInstance().getMessageString("EmailText3") + "<font color=\'#FF0000\'>" + _loc2_.Name + StringManager.getInstance().getMessageString("EmailText42") + "</font>";
            BleakingLineForThai.GetInstance().BleakThaiLanguage(TextField(this._mc.getMC().txt_news),2408447);
         }
      }
      
      private function btn_cancelClick(param1:Event) : void
      {
         GameKernel.popUpDisplayManager.Hide(this);
      }
   }
}

