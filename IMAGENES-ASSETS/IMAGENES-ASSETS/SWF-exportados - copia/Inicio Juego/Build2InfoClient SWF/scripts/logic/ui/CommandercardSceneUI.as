package logic.ui
{
   import com.star.frameworks.events.ActionEvent;
   import com.star.frameworks.managers.StringManager;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.utils.Timer;
   import logic.action.ConstructionAction;
   import logic.entry.GamePlayer;
   import logic.entry.HButton;
   import logic.entry.HButtonType;
   import logic.entry.MObject;
   import logic.entry.ScienceSystem;
   import logic.entry.commander.CommanderXmlInfo;
   import logic.entry.props.propsInfo;
   import logic.game.GameKernel;
   import logic.game.GameSetting;
   import logic.manager.GameInterActiveManager;
   import logic.reader.CCommanderReader;
   import logic.reader.CPropsReader;
   import logic.ui.info.BleakingLineForThai;
   import logic.utils.Commander;
   import logic.widget.ConstructionOperationWidget;
   import logic.widget.OperationEnum;
   import net.router.CommanderRouter;
   
   public class CommandercardSceneUI extends AbstractPopUp
   {
      
      private static var instance:CommandercardSceneUI;
      
      private var _majongAry:Array = new Array();
      
      private var _listAry:Array = new Array();
      
      private var m_cardUI:Array = new Array();
      
      public var backMc:MovieClip = new MovieClip();
      
      private var backCardAry:Array = new Array();
      
      private var time:Timer;
      
      private var StagWidth:int;
      
      private var StagHeight:int;
      
      public var _BeingOpenCardUI:Boolean = false;
      
      public var _CardNum:int = 0;
      
      public var _ChooseCard:int = -1;
      
      public var _ListPropsIdAry:Array = new Array();
      
      public var m_SwitchButtonAry:Array = new Array();
      
      private var m_CacheButtonAry:Array = new Array(1,1,1);
      
      private var ltip:MovieClip;
      
      private var cardIDAry:Array = new Array();
      
      public var yutiaojian:Boolean = false;
      
      public function CommandercardSceneUI()
      {
         super();
         setPopUpName("CommandercardSceneUI");
      }
      
      public static function getinstance() : CommandercardSceneUI
      {
         if(instance == null)
         {
            instance = new CommandercardSceneUI();
         }
         return instance;
      }
      
      override public function Init() : void
      {
         if(GameKernel.popUpDisplayManager.PopDisplayList.ContainsKey(getPopUpName()))
         {
            return;
         }
         this._mc = new MObject("CommandercardScene",380,290);
         this.initMcElement();
         GameKernel.popUpDisplayManager.Regisger(instance);
      }
      
      override public function initMcElement() : void
      {
         this.time = new Timer(1900);
         this.time.addEventListener(TimerEvent.TIMER,this.onTick,false,0,true);
         var _loc1_:HButton = new HButton(this._mc.getMC().btn_close);
         GameInterActiveManager.InstallInterActiveEvent(_loc1_.m_movie,ActionEvent.ACTION_CLICK,this.chickButton);
         var _loc2_:HButton = new HButton(this._mc.getMC().btn_card);
         GameInterActiveManager.InstallInterActiveEvent(_loc2_.m_movie,ActionEvent.ACTION_CLICK,this.chickButton);
         var _loc3_:HButton = new HButton(this._mc.getMC().btn_bag,HButtonType.SIMPLE,false,StringManager.getInstance().getMessageString("MainUITXT20"));
         GameInterActiveManager.InstallInterActiveEvent(_loc3_.m_movie,ActionEvent.ACTION_CLICK,this.chickButton);
         var _loc4_:int = 0;
         while(_loc4_ < 3)
         {
            this._listAry[_loc4_] = this._mc.getMC().getChildByName("mc_list" + _loc4_) as MovieClip;
            this.backCardAry[_loc4_] = new MObject("EmptycardMc",0,0);
            MovieClip(this._listAry[_loc4_]).addChild(this.backCardAry[_loc4_]);
            _loc4_++;
         }
         this._majongAry[0] = new HButton(this._mc.getMC().btn_majong0);
         GameInterActiveManager.InstallInterActiveEvent(this._majongAry[0].m_movie,ActionEvent.ACTION_CLICK,this.chickButton);
         this._majongAry[1] = new HButton(this._mc.getMC().btn_majong1);
         GameInterActiveManager.InstallInterActiveEvent(this._majongAry[1].m_movie,ActionEvent.ACTION_CLICK,this.chickButton);
         this._majongAry[2] = new HButton(this._mc.getMC().btn_majong2);
         GameInterActiveManager.InstallInterActiveEvent(this._majongAry[2].m_movie,ActionEvent.ACTION_CLICK,this.chickButton);
         var _loc5_:int = 0;
         while(_loc4_ < 3)
         {
            this.m_SwitchButtonAry[_loc4_] = true;
            _loc4_++;
         }
      }
      
      public function InitPopUp() : void
      {
         this._BeingOpenCardUI = true;
         var _loc1_:int = 0;
         while(_loc1_ < 3)
         {
            if(this._CardNum == 0)
            {
               this._majongAry[_loc1_].m_movie.tf_txt.text = String(GamePlayer.getInstance().Commander_Card) + StringManager.getInstance().getMessageString("CommanderText70");
            }
            else if(this._CardNum == 1)
            {
               this._majongAry[_loc1_].m_movie.tf_txt.text = String(GamePlayer.getInstance().Commander_Card2) + StringManager.getInstance().getMessageString("CommanderText70");
            }
            else if(this._CardNum == 2)
            {
               this._majongAry[_loc1_].m_movie.tf_txt.text = String(GamePlayer.getInstance().Commander_Card3) + StringManager.getInstance().getMessageString("CommanderText70");
            }
            _loc1_++;
         }
         this._mc.getMC().tf_cash.text = GamePlayer.getInstance().cash;
      }
      
      public function SubCash(param1:int) : void
      {
         ConstructionAction.getInstance().costResource(0,0,0,param1);
         this._mc.getMC().tf_cash.text = GamePlayer.getInstance().cash;
      }
      
      public function ShowCard() : void
      {
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:TextField = null;
         var _loc7_:String = null;
         var _loc8_:Bitmap = null;
         var _loc9_:String = null;
         var _loc10_:Bitmap = null;
         var _loc11_:String = null;
         var _loc12_:Bitmap = null;
         if(GameKernel.isFullStage)
         {
            this.StagWidth = GameSetting.GAME_FULLSCREEN_WIDTH;
            this.StagHeight = GameSetting.GAME_FULLSCREEN_HEIGHT;
         }
         else
         {
            this.StagWidth = GameKernel.renderManager.getScene().getStage().stageWidth;
            this.StagHeight = GameKernel.renderManager.getScene().getStage().stageHeight;
         }
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         while(_loc2_ < 3)
         {
            _loc3_ = new Array();
            this.backCardAry[_loc2_].getMC().visible = false;
            if(_loc2_ == this._ChooseCard)
            {
               this._ListPropsIdAry[_loc2_] = CommanderRouter.instance.m_firstCardPropsId;
               _loc3_ = this.CardInfo(CommanderRouter.instance.m_firstCardPropsId);
               _loc5_ = int(_loc3_[3]);
               this.cardIDAry[0] = _loc3_[4];
               this.m_cardUI[0] = this.ChooseColor(_loc5_);
               MovieClip(this._listAry[_loc2_]).addChild(this.m_cardUI[0]);
               this.m_cardUI[0].getMC().tf_commandername.text = _loc3_[1];
               this.m_cardUI[0].getMC().tf_content.htmlText = "<font size=\'12px\' color=\'#ffffff\'>" + _loc3_[0] + "</font>";
               if(GamePlayer.getInstance().language != 10)
               {
                  BleakingLineForThai.GetInstance().BleakThaiLanguage(this.m_cardUI[0].getMC().tf_content);
               }
               _loc4_ = int(_loc3_[2]);
               this.m_cardUI[0].getMC().mc_grade.gotoAndStop(_loc4_ + 1);
               if(_loc3_[5] < 5)
               {
                  MovieClip(this.m_cardUI[0].getMC().mc_herostar).gotoAndStop(_loc3_[5] - 1);
               }
               this._listAry[_loc2_].visible = true;
               _loc7_ = CCommanderReader.getInstance().getCommanderImage(int(_loc3_[4]));
               _loc8_ = new Bitmap(GameKernel.getTextureInstance(_loc7_));
               this.m_cardUI[0].getMC().mc_commanderbase.addChild(_loc8_);
               this._majongAry[_loc2_].m_movie.visible = false;
            }
            else if(_loc1_ == 0)
            {
               _loc1_++;
               this._ListPropsIdAry[_loc2_] = CommanderRouter.instance.m_NextCardPropsId1;
               _loc3_ = this.CardInfo(CommanderRouter.instance.m_NextCardPropsId1);
               _loc5_ = int(_loc3_[3]);
               this.cardIDAry[1] = _loc3_[4];
               this.m_cardUI[1] = this.ChooseColor(_loc5_);
               MovieClip(this._listAry[_loc2_]).addChild(this.m_cardUI[1]);
               this.m_cardUI[1].getMC().tf_commandername.text = _loc3_[1];
               this.m_cardUI[1].getMC().tf_content.htmlText = "<font size=\'12px\' color=\'#ffffff\'>" + _loc3_[0] + "</font>";
               if(GamePlayer.getInstance().language != 10)
               {
                  BleakingLineForThai.GetInstance().BleakThaiLanguage(this.m_cardUI[1].getMC().tf_content);
               }
               _loc4_ = int(_loc3_[2]);
               this.m_cardUI[1].getMC().mc_grade.gotoAndStop(_loc4_ + 1);
               if(_loc3_[5] < 5)
               {
                  MovieClip(this.m_cardUI[1].getMC().mc_herostar).gotoAndStop(_loc3_[5] - 1);
               }
               this._listAry[_loc2_].visible = true;
               _loc9_ = CCommanderReader.getInstance().getCommanderImage(int(_loc3_[4]));
               _loc10_ = new Bitmap(GameKernel.getTextureInstance(_loc9_));
               this.m_cardUI[1].getMC().mc_commanderbase.addChild(_loc10_);
               this._majongAry[_loc2_].m_movie.tf_txt.text = String(GamePlayer.getInstance().Commander_Card2) + StringManager.getInstance().getMessageString("CommanderText70");
            }
            else
            {
               this._ListPropsIdAry[_loc2_] = CommanderRouter.instance.m_NextCardPropsId2;
               _loc3_ = this.CardInfo(CommanderRouter.instance.m_NextCardPropsId2);
               _loc5_ = int(_loc3_[3]);
               this.cardIDAry[2] = _loc3_[4];
               this.m_cardUI[2] = this.ChooseColor(_loc5_);
               MovieClip(this._listAry[_loc2_]).addChild(this.m_cardUI[2]);
               this.m_cardUI[2].getMC().tf_commandername.text = _loc3_[1];
               this.m_cardUI[2].getMC().tf_content.htmlText = "<font size=\'12px\' color=\'#ffffff\'>" + _loc3_[0] + "</font>";
               if(GamePlayer.getInstance().language != 10)
               {
                  BleakingLineForThai.GetInstance().BleakThaiLanguage(this.m_cardUI[2].getMC().tf_content);
               }
               _loc4_ = int(_loc3_[2]);
               this.m_cardUI[2].getMC().mc_grade.gotoAndStop(_loc4_ + 1);
               if(_loc3_[5] < 5)
               {
                  MovieClip(this.m_cardUI[2].getMC().mc_herostar).gotoAndStop(_loc3_[5] - 1);
               }
               this._listAry[_loc2_].visible = true;
               _loc11_ = CCommanderReader.getInstance().getCommanderImage(int(_loc3_[4]));
               _loc12_ = new Bitmap(GameKernel.getTextureInstance(_loc11_));
               this.m_cardUI[2].getMC().mc_commanderbase.addChild(_loc12_);
               this._majongAry[_loc2_].m_movie.tf_txt.text = String(GamePlayer.getInstance().Commander_Card2) + StringManager.getInstance().getMessageString("CommanderText70");
            }
            _loc2_++;
         }
         this.CardEve();
      }
      
      private function GetCommanderInfo(param1:int) : CommanderXmlInfo
      {
         var _loc2_:propsInfo = CPropsReader.getInstance().GetPropsInfo(param1);
         return CCommanderReader.getInstance().GetCommanderInfo(_loc2_.SkillID);
      }
      
      private function CardEve() : void
      {
         var _loc2_:HButton = null;
         var _loc3_:HButton = null;
         var _loc1_:int = 0;
         while(_loc1_ < 3)
         {
            _loc2_ = new HButton(this.m_cardUI[_loc1_].getMC().btn_up);
            _loc3_ = new HButton(this.m_cardUI[_loc1_].getMC().btn_down);
            if(this.m_cardUI[_loc1_].getMC().tf_content.maxScrollV == 1)
            {
               _loc3_.m_movie.visible = false;
               _loc2_.m_movie.visible = false;
               this.m_cardUI[_loc1_].getMC().mc_drag.visible = false;
               this.m_cardUI[_loc1_].getMC().tf_content.width = 155;
            }
            else
            {
               _loc3_.m_movie.visible = true;
               _loc2_.m_movie.visible = true;
               this.m_cardUI[_loc1_].getMC().mc_drag.visible = true;
               this.m_cardUI[_loc1_].getMC().tf_content.width = 148;
               this.m_cardUI[_loc1_].getMC().tf_content.scrollV = 1;
            }
            _loc1_++;
         }
         this.m_cardUI[0].getMC().btn_down.addEventListener(MouseEvent.MOUSE_DOWN,this.chickButton0);
         this.m_cardUI[0].getMC().btn_up.addEventListener(MouseEvent.MOUSE_DOWN,this.chickButton0);
         this.m_cardUI[0].getMC().btn_enter.addEventListener(MouseEvent.MOUSE_OVER,this.overButton0);
         this.m_cardUI[0].getMC().btn_enter.addEventListener(MouseEvent.MOUSE_OUT,this.outButton0);
         this.m_cardUI[1].getMC().btn_down.addEventListener(MouseEvent.MOUSE_DOWN,this.chickButton1);
         this.m_cardUI[1].getMC().btn_up.addEventListener(MouseEvent.MOUSE_DOWN,this.chickButton1);
         this.m_cardUI[1].getMC().btn_enter.addEventListener(MouseEvent.MOUSE_OVER,this.overButton1);
         this.m_cardUI[1].getMC().btn_enter.addEventListener(MouseEvent.MOUSE_OUT,this.outButton1);
         this.m_cardUI[2].getMC().btn_down.addEventListener(MouseEvent.MOUSE_DOWN,this.chickButton2);
         this.m_cardUI[2].getMC().btn_up.addEventListener(MouseEvent.MOUSE_DOWN,this.chickButton2);
         this.m_cardUI[2].getMC().btn_enter.addEventListener(MouseEvent.MOUSE_OVER,this.overButton2);
         this.m_cardUI[2].getMC().btn_enter.addEventListener(MouseEvent.MOUSE_OUT,this.outButton2);
      }
      
      public function ShowSecCard() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < 3)
         {
            this._majongAry[_loc1_].m_movie.tf_txt.text = String(GamePlayer.getInstance().Commander_Card3) + StringManager.getInstance().getMessageString("CommanderText70");
            _loc1_++;
         }
         this._majongAry[this._ChooseCard].m_movie.visible = false;
      }
      
      private function ChooseColor(param1:int) : MObject
      {
         var _loc2_:MObject = null;
         var _loc3_:TextField = null;
         var _loc4_:TextFormat = null;
         if(param1 == 1)
         {
            _loc2_ = new MObject("BluecardMc",0,0);
         }
         else if(param1 == 2)
         {
            _loc2_ = new MObject("GreencardMc",0,0);
         }
         else if(param1 == 3)
         {
            _loc2_ = new MObject("YellowcardMc",0,0);
         }
         else if(param1 == 5)
         {
            _loc2_ = new MObject("GoldencardMc",0,0);
         }
         if(GamePlayer.getInstance().language == 10)
         {
            _loc3_ = _loc2_.getMC().tf_content as TextField;
            _loc4_ = _loc3_.getTextFormat();
            _loc4_.align = TextFieldAutoSize.RIGHT;
            _loc3_.setTextFormat(_loc4_);
            _loc3_.defaultTextFormat = _loc4_;
         }
         return _loc2_;
      }
      
      private function CardInfo(param1:int) : Array
      {
         var _loc2_:Array = new Array();
         var _loc3_:propsInfo = CPropsReader.getInstance().GetPropsInfo(param1);
         var _loc4_:CommanderXmlInfo = CCommanderReader.getInstance().GetCommanderInfo(_loc3_.SkillID);
         if(param1 % 9 == 0)
         {
            _loc2_[0] = CPropsReader.getInstance().GetPropsInfo(Math.ceil(param1 / 9) * 9).Comment;
            _loc2_[1] = CPropsReader.getInstance().GetPropsInfo(Math.ceil(param1 / 9) * 9).Name;
            _loc2_[2] = "1";
            _loc2_[3] = CPropsReader.getInstance().GetPropsInfo(Math.ceil(param1 / 9) * 9).CommanderType;
            _loc2_[4] = CPropsReader.getInstance().GetPropsInfo(Math.ceil(param1 / 9) * 9).SkillID;
         }
         else
         {
            _loc2_[0] = CPropsReader.getInstance().GetPropsInfo((Math.ceil(param1 / 9) - 1) * 9).Comment;
            _loc2_[1] = CPropsReader.getInstance().GetPropsInfo((Math.ceil(param1 / 9) - 1) * 9).Name;
            _loc2_[2] = String(int(param1 % 9) + 1);
            _loc2_[3] = CPropsReader.getInstance().GetPropsInfo((Math.ceil(param1 / 9) - 1) * 9).CommanderType;
            _loc2_[4] = CPropsReader.getInstance().GetPropsInfo((Math.ceil(param1 / 9) - 1) * 9).SkillID;
         }
         _loc2_[5] = _loc4_.Type;
         return _loc2_;
      }
      
      private function Refresh() : void
      {
         if(this._CardNum == 0)
         {
            return;
         }
         var _loc1_:int = 0;
         while(_loc1_ < 3)
         {
            this._CardNum = 0;
            if(MovieClip(this._listAry[_loc1_]).numChildren > 2)
            {
               MovieClip(this._listAry[_loc1_]).removeChildAt(2);
            }
            this._majongAry[_loc1_].m_movie.tf_txt.text = String(GamePlayer.getInstance().Commander_Card) + StringManager.getInstance().getMessageString("CommanderText70");
            this._majongAry[_loc1_].m_movie.visible = true;
            this.backCardAry[_loc1_].getMC().visible = true;
            this.m_CacheButtonAry[_loc1_] = 1;
            this.m_SwitchButtonAry[_loc1_] = true;
            _loc1_++;
         }
         this.removEve();
      }
      
      private function DetectionBag() : Boolean
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
            return true;
         }
         return false;
      }
      
      private function DetectionCash() : Boolean
      {
         var _loc1_:int = 0;
         if(this._CardNum == 0)
         {
            _loc1_ = GamePlayer.getInstance().Commander_Card;
         }
         else if(this._CardNum == 1)
         {
            _loc1_ = GamePlayer.getInstance().Commander_Card2;
         }
         else if(this._CardNum == 2)
         {
            _loc1_ = GamePlayer.getInstance().Commander_Card3;
         }
         if(GamePlayer.getInstance().cash < _loc1_)
         {
            ConstructionOperationWidget.currenCmd = OperationEnum.OPERATION_TYPE_NOCASH;
            PrepaidModulePopup.getInstance().setString("commandercard");
            PrepaidModulePopup.getInstance().Init();
            PrepaidModulePopup.getInstance().setParent(this);
            PrepaidModulePopup.getInstance().Show();
            return true;
         }
         return false;
      }
      
      private function chickButton0(param1:MouseEvent) : void
      {
         if(param1.currentTarget.name == "btn_up")
         {
            --this.m_cardUI[0].getMC().tf_content.scrollV;
         }
         else if(param1.currentTarget.name == "btn_down")
         {
            ++this.m_cardUI[0].getMC().tf_content.scrollV;
         }
      }
      
      private function overButton0(param1:MouseEvent) : void
      {
         var _loc4_:Boolean = false;
         var _loc2_:MovieClip = param1.currentTarget as MovieClip;
         var _loc3_:Point = _loc2_.localToGlobal(new Point(param1.currentTarget.x,param1.currentTarget.y));
         if(_loc3_.x + 160 > this.StagWidth)
         {
            _loc4_ = true;
         }
         else
         {
            _loc4_ = false;
         }
         _loc3_ = MovieClip(this._mc.getMC()).globalToLocal(new Point(_loc3_.x,_loc3_.y));
         this.ltip = Commander.getInstance().littelTip(CCommanderReader.getInstance().getCommanderDescription(this.cardIDAry[0]));
         this._mc.getMC().addChild(this.ltip);
         if(_loc4_ == false)
         {
            this.ltip.x = _loc3_.x - 185 + 25;
            this.ltip.y = _loc3_.y - 59 - 52 - 40;
         }
         else
         {
            this.ltip.x = _loc3_.x - 185 - 25;
            this.ltip.y = _loc3_.y - 59 - 52 - 40;
         }
      }
      
      private function outButton0(param1:MouseEvent) : void
      {
         this.OutRemove();
      }
      
      private function chickButton1(param1:MouseEvent) : void
      {
         if(param1.currentTarget.name == "btn_up")
         {
            --this.m_cardUI[1].getMC().tf_content.scrollV;
         }
         else if(param1.currentTarget.name == "btn_down")
         {
            ++this.m_cardUI[1].getMC().tf_content.scrollV;
         }
      }
      
      private function overButton1(param1:MouseEvent) : void
      {
         var _loc4_:Boolean = false;
         var _loc2_:MovieClip = param1.currentTarget as MovieClip;
         var _loc3_:Point = _loc2_.localToGlobal(new Point(param1.currentTarget.x,param1.currentTarget.y));
         if(_loc3_.x + 160 > this.StagWidth)
         {
            _loc4_ = true;
         }
         else
         {
            _loc4_ = false;
         }
         _loc3_ = MovieClip(this._mc.getMC()).globalToLocal(new Point(_loc3_.x,_loc3_.y));
         this.ltip = new MovieClip();
         this.ltip = Commander.getInstance().littelTip(CCommanderReader.getInstance().getCommanderDescription(this.cardIDAry[1]));
         this._mc.getMC().addChild(this.ltip);
         if(_loc4_ == false)
         {
            this.ltip.x = _loc3_.x - 185 + 25;
            this.ltip.y = _loc3_.y - 59 - 52 - 40;
         }
         else
         {
            this.ltip.x = _loc3_.x - 185 - 25;
            this.ltip.y = _loc3_.y - 59 - 52 - 40;
         }
      }
      
      private function outButton1(param1:MouseEvent) : void
      {
         this.OutRemove();
      }
      
      private function chickButton2(param1:MouseEvent) : void
      {
         if(param1.currentTarget.name == "btn_up")
         {
            --this.m_cardUI[2].getMC().tf_content.scrollV;
         }
         else if(param1.currentTarget.name == "btn_down")
         {
            ++this.m_cardUI[2].getMC().tf_content.scrollV;
         }
      }
      
      private function overButton2(param1:MouseEvent) : void
      {
         var _loc4_:Boolean = false;
         var _loc2_:MovieClip = param1.currentTarget as MovieClip;
         var _loc3_:Point = _loc2_.localToGlobal(new Point(param1.currentTarget.x,param1.currentTarget.y));
         if(_loc3_.x + 160 > this.StagWidth)
         {
            _loc4_ = true;
         }
         else
         {
            _loc4_ = false;
         }
         _loc3_ = MovieClip(this._mc.getMC()).globalToLocal(new Point(_loc3_.x,_loc3_.y));
         this.ltip = new MovieClip();
         this.ltip = Commander.getInstance().littelTip(CCommanderReader.getInstance().getCommanderDescription(this.cardIDAry[2]));
         this._mc.getMC().addChild(this.ltip);
         if(_loc4_ == false)
         {
            this.ltip.x = _loc3_.x - 185 + 25;
            this.ltip.y = _loc3_.y - 59 - 52 - 40;
         }
         else
         {
            this.ltip.x = _loc3_.x - 185 - 25;
            this.ltip.y = _loc3_.y - 59 - 52 - 40;
         }
      }
      
      private function outButton2(param1:MouseEvent) : void
      {
         this.OutRemove();
      }
      
      private function OutRemove() : void
      {
         if(this.ltip != null && this._mc.getMC().contains(this.ltip))
         {
            Commander.getInstance().CloselittelTip(this.ltip);
            this._mc.getMC().removeChild(this.ltip);
            this.ltip = null;
         }
      }
      
      private function chickButton(param1:Event) : void
      {
         if(param1.currentTarget.name == "btn_close")
         {
            this._BeingOpenCardUI = false;
            this.Refresh();
            GameKernel.popUpDisplayManager.Hide(instance);
         }
         else if(param1.currentTarget.name == "btn_card")
         {
            this.Refresh();
         }
         else if(param1.currentTarget.name == "btn_bag")
         {
            this.yutiaojian = true;
            this.addBackMC();
            PackUi.getInstance().Init();
            GameKernel.popUpDisplayManager.Show(PackUi.getInstance());
         }
         else if(param1.currentTarget.name == "btn_majong0")
         {
            this._ChooseCard = 0;
            if(this.m_SwitchButtonAry[0] == false)
            {
               return;
            }
            if(this.DetectionBag())
            {
               return;
            }
            if(this.DetectionCash())
            {
               return;
            }
            this.m_SwitchButtonAry[0] = false;
            this.m_SwitchButtonAry[1] = false;
            this.m_SwitchButtonAry[2] = false;
            this.m_CacheButtonAry[0] = 0;
            HButton(this._majongAry[0]).m_movie.visible = false;
            HButton(this._majongAry[1]).m_movie.visible = false;
            HButton(this._majongAry[2]).m_movie.visible = false;
            if(this._CardNum == 0)
            {
               CommanderRouter.instance.onSendMsgCreateCommander(2);
            }
            else if(this._CardNum != 0)
            {
               CommanderRouter.instance.onSendMsgGETSECONDCOMMANDERCARD(this._ListPropsIdAry[0]);
            }
         }
         else if(param1.currentTarget.name == "btn_majong1")
         {
            this._ChooseCard = 1;
            if(this.m_SwitchButtonAry[1] == false)
            {
               return;
            }
            if(this.DetectionBag())
            {
               return;
            }
            if(this.DetectionCash())
            {
               return;
            }
            this.m_SwitchButtonAry[0] = false;
            this.m_SwitchButtonAry[1] = false;
            this.m_SwitchButtonAry[2] = false;
            this.m_CacheButtonAry[1] = 0;
            HButton(this._majongAry[0]).m_movie.visible = false;
            HButton(this._majongAry[1]).m_movie.visible = false;
            HButton(this._majongAry[2]).m_movie.visible = false;
            if(this._CardNum == 0)
            {
               CommanderRouter.instance.onSendMsgCreateCommander(2);
            }
            else if(this._CardNum != 0)
            {
               CommanderRouter.instance.onSendMsgGETSECONDCOMMANDERCARD(this._ListPropsIdAry[1]);
            }
         }
         else if(param1.currentTarget.name == "btn_majong2")
         {
            this._ChooseCard = 2;
            if(this.m_SwitchButtonAry[2] == false)
            {
               return;
            }
            if(this.DetectionBag())
            {
               return;
            }
            if(this.DetectionCash())
            {
               return;
            }
            this.m_SwitchButtonAry[0] = false;
            this.m_SwitchButtonAry[1] = false;
            this.m_SwitchButtonAry[2] = false;
            this.m_CacheButtonAry[2] = 0;
            HButton(this._majongAry[0]).m_movie.visible = false;
            HButton(this._majongAry[1]).m_movie.visible = false;
            HButton(this._majongAry[2]).m_movie.visible = false;
            if(this._CardNum == 0)
            {
               CommanderRouter.instance.onSendMsgCreateCommander(2);
            }
            else if(this._CardNum != 0)
            {
               CommanderRouter.instance.onSendMsgGETSECONDCOMMANDERCARD(this._ListPropsIdAry[2]);
            }
         }
      }
      
      public function addBackMC() : void
      {
         this.backMc.graphics.clear();
         this.backMc.graphics.beginFill(16711935,0);
         this.backMc.graphics.drawRect(-380,-340,760,850);
         this.backMc.graphics.endFill();
         this._mc.getMC().addChild(this.backMc);
      }
      
      public function removeBackMC() : void
      {
         this._mc.getMC().removeChild(this.backMc);
      }
      
      private function removEve() : void
      {
         this.m_cardUI[0].getMC().btn_down.removeEventListener(MouseEvent.MOUSE_DOWN,this.chickButton0);
         this.m_cardUI[0].getMC().btn_up.removeEventListener(MouseEvent.MOUSE_DOWN,this.chickButton0);
         this.m_cardUI[1].getMC().btn_down.removeEventListener(MouseEvent.MOUSE_DOWN,this.chickButton1);
         this.m_cardUI[1].getMC().btn_up.removeEventListener(MouseEvent.MOUSE_DOWN,this.chickButton1);
         this.m_cardUI[2].getMC().btn_down.removeEventListener(MouseEvent.MOUSE_DOWN,this.chickButton2);
         this.m_cardUI[2].getMC().btn_up.removeEventListener(MouseEvent.MOUSE_DOWN,this.chickButton2);
      }
      
      public function Animation() : void
      {
         MovieClip(this._mc.getMC().mc_shrink).gotoAndPlay(1);
         this.time.start();
      }
      
      private function onTick(param1:TimerEvent) : void
      {
         this.m_SwitchButtonAry[0] = true;
         this.m_SwitchButtonAry[1] = true;
         this.m_SwitchButtonAry[2] = true;
         var _loc2_:int = 0;
         while(_loc2_ < 3)
         {
            if(this.m_CacheButtonAry[_loc2_] == 1)
            {
               HButton(this._majongAry[_loc2_]).m_movie.visible = true;
            }
            else
            {
               HButton(this._majongAry[_loc2_]).m_movie.visible = false;
            }
            _loc2_++;
         }
         this.time.stop();
      }
   }
}

