package logic.ui
{
   import com.star.frameworks.managers.StringManager;
   import com.star.frameworks.utils.CEffectText;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.utils.Timer;
   import logic.action.ConstructionAction;
   import logic.action.GalaxyMapAction;
   import logic.entry.FBModel;
   import logic.entry.GStar;
   import logic.entry.GamePlayer;
   import logic.entry.HButton;
   import logic.entry.MObject;
   import logic.entry.test.FBModelView;
   import logic.entry.test.MovieClipDataBox;
   import logic.game.GameKernel;
   import logic.manager.GalaxyShipManager;
   import logic.manager.InstanceManager;
   import logic.reader.InstanceConstellationsReader;
   import logic.reader.LocusReader;
   import logic.ui.tip.CustomTip;
   import logic.ui.tip.InstanceTip;
   import logic.ui.tip.LocusTip;
   import logic.utils.UpdateResource;
   import logic.widget.DataWidget;
   import net.msg.ship.MSG_RESP_JUMPGALAXYSHIP_TEMP;
   
   public class InstanceUI extends AbstractPopUp
   {
      
      private static var _instance:InstanceUI = null;
      
      private var _UI:Sprite = new Sprite();
      
      private var _BGContainer:MovieClip;
      
      private var _BGBitmap:Bitmap;
      
      private var _titlesBtns:Array = new Array();
      
      private var _dataBox:MovieClipDataBox;
      
      private var _listLen:int = 4;
      
      private var _leftPageBtn:HButton;
      
      private var _rightPageBtn:HButton;
      
      private var _copyOneBtn:HButton;
      
      private var _copyTwoBtn:HButton;
      
      private var _copyThreeBtn:HButton;
      
      private var _copyFourBtn:HButton;
      
      private var _copyBtnArr:Array = new Array();
      
      private var _copyBtnName:String = "btn_ordinary";
      
      private var _xzNum:Bitmap = new Bitmap();
      
      private var mc_constellation:MovieClip;
      
      private var _openShipBtn:HButton;
      
      private var _LocusMc:MovieClip;
      
      private var _LocusFB:FBModel;
      
      private var LocusTipStr:String;
      
      private var _LocusTimer:Timer;
      
      private var LocusMoney:int;
      
      private var LocusSP:int;
      
      private var _LocusId:int;
      
      private var _txt_time:TextField;
      
      private var ConstellationList:Array;
      
      private var SelectedConstellation:MovieClip;
      
      private var SelectedConstellationMc:XMovieClip;
      
      private var ConstellationMcList:Array;
      
      private var SelectedStar:XMovieClip;
      
      private var StarFBList:Array;
      
      private var _SelectedStar:XMovieClip;
      
      private var mc_constellationintro:MovieClip;
      
      private var ShoppPropsId:int;
      
      private var _selfFBTeamsArr:Array = new Array();
      
      private var _selfPageSize:int = 4;
      
      private var _selfCurPage:int = 0;
      
      private var _selfMaxPage:int;
      
      public function InstanceUI(param1:HHH)
      {
         super();
         setPopUpName("InstanceUI");
         this._mc = new MObject("CopyScene",380,300);
         this.initMcElement();
         this.InitTitles();
         InstanceManager.instance.AddViewToPanel();
      }
      
      public static function get instance() : InstanceUI
      {
         if(_instance == null)
         {
            _instance = new InstanceUI(new HHH());
         }
         return _instance;
      }
      
      override public function Init() : void
      {
         if(GameKernel.popUpDisplayManager.PopDisplayList.ContainsKey(getPopUpName()))
         {
            this.updateChallengeFBUI();
            GameKernel.popUpDisplayManager.Show(_instance);
            InstanceManager.instance.drawPassLine();
            this.SetLocusFB(GamePlayer.getInstance().TollGate);
            this.setSelectBtn(null,0);
            return;
         }
         GameKernel.popUpDisplayManager.Regisger(_instance);
         this.updateChallengeFBUI();
         GameKernel.popUpDisplayManager.Show(_instance);
         InstanceManager.instance.drawPassLine();
         this.SetLocusFB(GamePlayer.getInstance().TollGate);
         this.setSelectBtn(null,0);
      }
      
      public function SetLocusFB(param1:int) : void
      {
         var _loc2_:MovieClip = null;
         this._LocusId = param1;
         var _loc3_:int = 0;
         while(_loc3_ < param1)
         {
            _loc2_ = this._LocusMc.getChildByName("locuslist" + _loc3_) as MovieClip;
            _loc2_.gotoAndStop(2);
            this.SetAlpha(_loc2_,_loc3_);
            _loc3_++;
         }
         if(this._LocusFB == null)
         {
            this._LocusFB = new FBModel();
            this._LocusFB.ModelType = 2;
         }
         var _loc4_:XML = LocusReader.getInstance().GetLocusInfo(param1);
         if(_loc4_ == null)
         {
            return;
         }
         this._LocusFB.EctypeID = _loc4_.@EctypeID;
         this._LocusFB.UserTeam = _loc4_.@UserTeam;
         this.LocusMoney = _loc4_.@Comment;
         this.LocusSP = _loc4_.@Sp;
         _loc2_ = this._LocusMc.getChildByName("locuslist" + param1) as MovieClip;
         _loc2_.gotoAndStop(3);
         this.SetAlpha(_loc2_,param1);
         this.LocusTipStr = this.GetLocusTipText(param1);
      }
      
      private function GetLocusTipText(param1:int) : String
      {
         var _loc2_:String = " & ";
         if(GamePlayer.getInstance().language == 10)
         {
            _loc2_ = "~ ";
         }
         var _loc3_:XML = LocusReader.getInstance().GetLocusInfo(param1);
         return LocusTip.GetInstance().GetStringText("\n" + StringManager.getInstance().getMessageString("Boss12"),_loc3_.@Name) + LocusTip.GetInstance().GetStringText("\n\n" + StringManager.getInstance().getMessageString("Boss13"),StringManager.getInstance().getMessageString("ShipText10") + _loc3_.@Comment + _loc2_ + StringManager.getInstance().getMessageString("Boss21") + _loc3_.@Sp) + LocusTip.GetInstance().GetNumberText("\n\n" + StringManager.getInstance().getMessageString("Boss14"),_loc3_.@UserTeam) + LocusTip.GetInstance().GetNumberText("\n\n" + StringManager.getInstance().getMessageString("Boss15"),_loc3_.@NpcTeam) + LocusTip.GetInstance().GetStringText("\n\n" + StringManager.getInstance().getMessageString("Boss16"),_loc3_.@Comment2);
      }
      
      public function updateChallengeFBUI() : void
      {
         var _loc1_:int = GamePlayer.getInstance().DefyEctypeNum;
         var _loc2_:String = StringManager.getInstance().getMessageString("MainUITXT45");
         var _loc3_:String = StringManager.getInstance().getMessageString("MainUITXT46");
         if(_loc1_ > 2)
         {
            _loc2_ = _loc2_.replace("!#",0 + "");
            _loc3_ = _loc3_.replace("!#",0 + "");
         }
         else if(_loc1_ == 0)
         {
            _loc2_ = _loc2_.replace("!#",2 + "");
            _loc3_ = _loc3_.replace("!#",1 + "");
         }
         else
         {
            _loc2_ = _loc2_.replace("!#",2 - _loc1_ + "");
            _loc3_ = _loc3_.replace("!#",1 + "");
         }
         this._dataBox.getTF("tf_txt0").htmlText = _loc2_;
         this._dataBox.getTF("tf_txt1").htmlText = _loc3_;
         this._xzNum.bitmapData = BirthFont.instance.getString("x" + GamePlayer.getInstance().Badge);
      }
      
      override public function initMcElement() : void
      {
         var _loc1_:HButton = null;
         var _loc2_:MovieClip = null;
         var _loc3_:MovieClip = null;
         this._dataBox = new MovieClipDataBox(_mc.getMC());
         this._BGContainer = this._dataBox.getMC("mc_ordinary");
         this._BGBitmap = new Bitmap(GameKernel.getTextureInstance("Copyimage0"));
         this._BGBitmap.name = "background";
         this._BGContainer.addChild(this._BGBitmap);
         this.OpenSecondCopy(false);
         _loc2_ = _mc.getMC().getChildByName("btn_close") as MovieClip;
         _loc2_.addEventListener(MouseEvent.CLICK,this.onClick);
         _loc1_ = new HButton(_loc2_);
         _loc2_ = _mc.getMC().getChildByName("btn_begin") as MovieClip;
         _loc2_.addEventListener(MouseEvent.CLICK,this.onClick);
         _loc1_ = new HButton(_loc2_);
         _loc2_ = _mc.getMC().getChildByName("btn_addfleet") as MovieClip;
         _loc2_.addEventListener(MouseEvent.CLICK,this.onClick);
         _loc1_ = new HButton(_loc2_);
         _loc2_ = _mc.getMC().getChildByName("btn_left") as MovieClip;
         _loc2_.addEventListener(MouseEvent.CLICK,this.SelfFrontPage);
         this._leftPageBtn = new HButton(_loc2_);
         _loc2_ = _mc.getMC().getChildByName("btn_right") as MovieClip;
         _loc2_.addEventListener(MouseEvent.CLICK,this.SelfNextPage);
         this._rightPageBtn = new HButton(_loc2_);
         _loc2_ = _mc.getMC().getChildByName("btn_ordinary") as MovieClip;
         _loc2_.addEventListener(MouseEvent.CLICK,this.setSelectBtn);
         this._copyOneBtn = new HButton(_loc2_);
         this._copyOneBtn.setSelect(true);
         this._copyBtnArr.push(this._copyOneBtn);
         _loc2_ = _mc.getMC().getChildByName("btn_copy2") as MovieClip;
         _loc2_.addEventListener(MouseEvent.CLICK,this.setSelectBtn);
         this._copyTwoBtn = new HButton(_loc2_);
         this._copyTwoBtn.setSelect(false);
         this._copyBtnArr.push(this._copyTwoBtn);
         _loc2_ = _mc.getMC().getChildByName("btn_copy3") as MovieClip;
         _loc2_.addEventListener(MouseEvent.CLICK,this.setSelectBtn);
         this._copyThreeBtn = new HButton(_loc2_);
         this._copyThreeBtn.setSelect(false);
         this._copyBtnArr.push(this._copyThreeBtn);
         _loc2_ = _mc.getMC().getChildByName("btn_copy4") as MovieClip;
         _loc2_.addEventListener(MouseEvent.CLICK,this.setSelectBtn);
         this._copyFourBtn = new HButton(_loc2_);
         this._copyFourBtn.setSelect(false);
         this._copyBtnArr.push(this._copyFourBtn);
         this._txt_time = _mc.getMC().getChildByName("txt_time") as TextField;
         if(this._txt_time != null)
         {
            this._txt_time.visible = false;
         }
         this._xzNum.name = "XZNum";
         this._xzNum.x = 18;
         this._xzNum.y = 2;
         this._dataBox.getMC("mc_medals").addChild(this._xzNum);
         _loc2_ = this._dataBox.getMC("mc_copychallenge");
         _loc2_.addEventListener(MouseEvent.CLICK,this.onChallenge);
         _loc2_ = this._dataBox.getMC("mc_activity");
         _loc2_.addEventListener(MouseEvent.CLICK,this.onChallenge2);
         _loc2_ = this._dataBox.getMC("btn_purchase");
         _loc2_.addEventListener(MouseEvent.CLICK,this.onShopping);
         var _loc4_:int = 0;
         while(_loc4_ < this._listLen)
         {
            _loc2_ = _mc.getMC().getChildByName("mc_list" + _loc4_) as MovieClip;
            _loc2_.btn_cancel.addEventListener(MouseEvent.CLICK,this.onItemClose);
            _loc1_ = new HButton(_loc2_.btn_cancel);
            _loc2_.visible = false;
            _loc4_++;
         }
         this.InitLocusMc();
         this.InitConstellation();
      }
      
      private function InitConstellation() : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:XMovieClip = null;
         this.mc_constellation = _mc.getMC().getChildByName("mc_constellation") as MovieClip;
         this.mc_constellation.visible = false;
         this.mc_constellationintro = _mc.getMC().getChildByName("mc_constellationintro") as MovieClip;
         this.mc_constellationintro.addEventListener(MouseEvent.CLICK,this.mc_constellationintroClick);
         this.mc_constellationintro.visible = false;
         this.ConstellationList = new Array();
         this.ConstellationMcList = new Array();
         var _loc1_:int = 0;
         while(_loc1_ < 12)
         {
            _loc2_ = this.mc_constellation.getChildByName("mc_" + _loc1_) as MovieClip;
            _loc3_ = new XMovieClip(_loc2_);
            _loc2_.buttonMode = true;
            _loc3_.Data = _loc1_;
            _loc3_.OnClick = this.ConstellationClick;
            _loc3_.OnMouseOver = this.ConstellationOver;
            _loc2_.addEventListener(MouseEvent.MOUSE_OUT,this.ConstellationOut);
            this.ConstellationList.push(null);
            this.ConstellationMcList.push(_loc3_);
            _loc1_++;
         }
      }
      
      private function mc_constellationintroClick(param1:MouseEvent) : void
      {
         this.mc_constellationintro.gotoAndStop(this.mc_constellationintro.currentFrame % 2 + 1);
      }
      
      private function ShowConstellation() : void
      {
         var _loc3_:XML = null;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:String = null;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc1_:int = 0;
         while(_loc1_ < 12)
         {
            XMovieClip(this.ConstellationMcList[_loc1_]).m_movie.gotoAndStop(1);
            _loc1_++;
         }
         var _loc2_:int = 0;
         while(_loc2_ < 12)
         {
            _loc3_ = InstanceConstellationsReader.getInstance().GetConstellationsInfo(_loc2_);
            if(_loc3_ != null)
            {
               _loc4_ = _loc3_.@Start;
               _loc5_ = parseInt(_loc4_.substr(0,_loc4_.indexOf("-"))) - 1;
               _loc6_ = parseInt(_loc4_.substr(_loc4_.indexOf("-") + 1));
               _loc7_ = _loc3_.@End;
               _loc8_ = parseInt(_loc7_.substr(0,_loc7_.indexOf("-"))) - 1;
               _loc9_ = parseInt(_loc7_.substr(_loc7_.indexOf("-") + 1));
               if(_loc5_ > _loc8_)
               {
                  if(GamePlayer.getInstance().ServerDate.month <= _loc8_ && GamePlayer.getInstance().ServerDate.date <= _loc9_)
                  {
                     XMovieClip(this.ConstellationMcList[_loc2_]).m_movie.gotoAndStop(2);
                  }
                  else if(GamePlayer.getInstance().ServerDate.month >= _loc5_ && GamePlayer.getInstance().ServerDate.date >= _loc6_)
                  {
                     XMovieClip(this.ConstellationMcList[_loc2_]).m_movie.gotoAndStop(2);
                  }
               }
               else if(GamePlayer.getInstance().ServerDate.month >= _loc5_ && GamePlayer.getInstance().ServerDate.date >= _loc6_)
               {
                  if(GamePlayer.getInstance().ServerDate.month <= _loc8_ && GamePlayer.getInstance().ServerDate.date <= _loc9_)
                  {
                     XMovieClip(this.ConstellationMcList[_loc2_]).m_movie.gotoAndStop(2);
                  }
               }
            }
            _loc2_++;
         }
      }
      
      private function ConstellationOut(param1:MouseEvent) : void
      {
         CustomTip.GetInstance().Hide();
         if(this.SelectedConstellationMc != null)
         {
            this.SelectedConstellationMc.m_movie.gotoAndStop(2);
            this.SelectedConstellationMc = null;
         }
      }
      
      private function ConstellationClick(param1:MouseEvent, param2:XMovieClip) : void
      {
         CustomTip.GetInstance().Hide();
         if(param2.m_movie.currentFrame == 1)
         {
            return;
         }
         this.mc_constellation.visible = false;
         var _loc3_:MovieClip = this.GetConstellation(param2.Data);
         this.SelectedConstellation = _loc3_;
         this._mc.getMC().addChild(_loc3_);
      }
      
      private function ConstellationOver(param1:MouseEvent, param2:XMovieClip) : void
      {
         var _loc3_:XML = null;
         var _loc4_:String = null;
         var _loc5_:Point = null;
         if(param2.m_movie.currentFrame == 2)
         {
            param2.m_movie.gotoAndStop(3);
            this.SelectedConstellationMc = param2;
            _loc3_ = InstanceConstellationsReader.getInstance().GetConstellationsInfo(param2.Data);
            _loc4_ = _loc3_.@Name;
            _loc5_ = DisplayObject(param1.target).localToGlobal(new Point(param1.localX + 5,param1.localY + 5));
            CustomTip.GetInstance().Show(_loc4_,_loc5_);
         }
      }
      
      private function GetConstellation(param1:int) : MovieClip
      {
         if(this.ConstellationList[param1] == null)
         {
            this.ConstellationList[param1] = GameKernel.getMovieClipInstance("constellationplan" + param1);
            this.ConstellationList[param1].x = -286 + (382 - this.ConstellationList[param1].width) / 2;
            this.ConstellationList[param1].y = -187 + (446 - this.ConstellationList[param1].height) / 2;
         }
         this.InitConstellationMc(this.ConstellationList[param1],param1);
         return this.ConstellationList[param1];
      }
      
      private function InitConstellationMc(param1:MovieClip, param2:int) : void
      {
         var _loc5_:DisplayObject = null;
         var _loc6_:int = 0;
         var _loc7_:XML = null;
         var _loc8_:XMovieClip = null;
         var _loc9_:FBModel = null;
         this.StarFBList = new Array();
         var _loc3_:int = 0;
         while(_loc3_ < param1.numChildren)
         {
            _loc5_ = param1.getChildAt(_loc3_);
            if(_loc5_.name.indexOf("mc_base") == 0)
            {
               _loc6_ = parseInt(_loc5_.name.substr(7));
               _loc7_ = InstanceConstellationsReader.getInstance().GetStarInfo(param2,_loc6_ + 1);
               if(_loc7_ != null)
               {
                  _loc8_ = new XMovieClip(_loc5_ as MovieClip);
                  _loc8_.Data = _loc6_;
                  _loc8_.OnClick = this.StarClick;
                  _loc8_.OnMouseOver = this.StarOver;
                  _loc5_.addEventListener(MouseEvent.MOUSE_OUT,this.StarOut);
                  MovieClip(_loc5_).gotoAndStop(2);
                  _loc9_ = new FBModel();
                  _loc9_.EctypeID = _loc7_.@EctypeID;
                  _loc9_.Name = _loc7_.@Name;
                  _loc9_.ID = _loc7_.@ID;
                  _loc9_.UserTeam = _loc7_.@UserTeam;
                  _loc9_.UserShip = 1;
                  _loc9_.MaxGate = 1;
                  _loc9_.MaxUser = 1;
                  _loc9_.Comment = _loc7_.@Comment;
                  _loc9_.Comment2 = _loc7_.@Comment2;
                  _loc9_.Type = 0;
                  _loc9_.Exp = _loc7_.@Exp;
                  _loc9_.Treasure_str = _loc7_.@Treasure;
                  this.StarFBList.push(_loc9_);
               }
               else
               {
                  MovieClip(_loc5_).gotoAndStop(1);
                  this.StarFBList.push(null);
               }
            }
            _loc3_++;
         }
         var _loc4_:XButton = new XButton(param1.getChildByName("btn_close") as MovieClip);
         _loc4_.Data = param2;
         _loc4_.OnClick = this.Constellationbtn_closeClick;
      }
      
      private function StarOut(param1:MouseEvent) : void
      {
         if(this.SelectedStar != null && this.SelectedStar != this._SelectedStar)
         {
            this.SelectedStar.m_movie.gotoAndStop(2);
         }
         InstanceTip.instance.Hide();
      }
      
      private function StarOver(param1:MouseEvent, param2:XMovieClip) : void
      {
         if(param2.m_movie.currentFrame == 1)
         {
            return;
         }
         this.SelectedStar = param2;
         this.SelectedStar.m_movie.gotoAndStop(3);
         var _loc3_:Point = new Point(482,175);
         InstanceTip.instance.Show(_loc3_,this.StarFBList[param2.Data],false);
      }
      
      private function StarClick(param1:MouseEvent, param2:XMovieClip) : void
      {
         if(param2.m_movie.currentFrame == 1)
         {
            return;
         }
         if(this._SelectedStar != null)
         {
            this._SelectedStar.m_movie.gotoAndStop(2);
         }
         this._SelectedStar = param2;
         this.SelectedStar.m_movie.gotoAndStop(3);
         InstanceManager.instance.curSelectFB = this.StarFBList[param2.Data];
      }
      
      private function ClearSelectedStar() : void
      {
         if(this._SelectedStar != null)
         {
            this._SelectedStar.m_movie.gotoAndStop(2);
         }
         this._SelectedStar = null;
      }
      
      private function Constellationbtn_closeClick(param1:MouseEvent, param2:XButton) : void
      {
         var _loc3_:MovieClip = this.ConstellationList[param2.Data];
         _loc3_.parent.removeChild(_loc3_);
         this.mc_constellation.visible = true;
         this.SelectedConstellation = null;
      }
      
      private function HideSelectedConstellation() : void
      {
         if(this.SelectedConstellation == null || this.SelectedConstellation.parent == null)
         {
            return;
         }
         if(this.SelectedConstellation.parent.contains(this.SelectedConstellation))
         {
            this.SelectedConstellation.parent.removeChild(this.SelectedConstellation);
         }
         this.SelectedConstellation = null;
      }
      
      private function InitLocusMc() : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:TextField = null;
         var _loc4_:XMovieClip = null;
         this._LocusMc = GameKernel.getMovieClipInstance("Locus");
         this._LocusMc.x = -114;
         this._LocusMc.y = 28;
         this._LocusMc.visible = false;
         this._mc.getMC().addChild(this._LocusMc);
         var _loc1_:int = 0;
         while(_loc1_ < 50)
         {
            _loc2_ = this._LocusMc.getChildByName("locuslist" + _loc1_) as MovieClip;
            _loc3_ = _loc2_.getChildByName("txt_num") as TextField;
            if(_loc3_ != null)
            {
               _loc3_.text = (_loc1_ + 1).toString();
            }
            _loc2_.gotoAndStop(1);
            this.SetAlpha(_loc2_,_loc1_);
            _loc4_ = new XMovieClip(_loc2_);
            _loc4_.Data = _loc1_;
            _loc4_.OnMouseOver = this.GateMouseOver;
            _loc2_.addEventListener(MouseEvent.MOUSE_OUT,this.GateMouseOut);
            _loc1_++;
         }
         this._dataBox.getMC("mc_activity").visible = false;
         this._LocusTimer = new Timer(1000);
         this._LocusTimer.addEventListener(TimerEvent.TIMER,this.OnLocusTimer);
      }
      
      private function GateMouseOver(param1:MouseEvent, param2:XMovieClip) : void
      {
         CustomTip.GetInstance().Show(this.GetLocusTipText(param2.Data),param2.m_movie.localToGlobal(new Point(0,param2.m_movie.height)));
      }
      
      private function GateMouseOut(param1:MouseEvent) : void
      {
         CustomTip.GetInstance().Hide();
      }
      
      private function SetAlpha(param1:MovieClip, param2:int) : void
      {
         if(param2 < LocusReader.getInstance().LocusCount)
         {
            param1.visible = true;
         }
         else
         {
            param1.visible = false;
         }
      }
      
      private function onChallenge2(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = this._dataBox.getMC("mc_activity");
         if(_loc2_.currentFrame % 2 == 0)
         {
            _loc2_.prevFrame();
         }
         else
         {
            _loc2_.nextFrame();
         }
      }
      
      private function onChallenge(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = this._dataBox.getMC("mc_copychallenge");
         if(_loc2_.currentFrame % 2 == 0)
         {
            _loc2_.prevFrame();
         }
         else
         {
            _loc2_.nextFrame();
         }
      }
      
      private function onShopping(param1:MouseEvent) : void
      {
         StateHandlingUI.getInstance().Init();
         StateHandlingUI.getInstance().setParent(this.getPopUpName());
         StateHandlingUI.getInstance().getstate(this.ShoppPropsId);
         StateHandlingUI.getInstance().InitPopUp();
         GameKernel.popUpDisplayManager.Show(StateHandlingUI.getInstance(),true,true);
         StateHandlingUI.getInstance().setVisible(true);
      }
      
      private function InitTitles() : void
      {
         var _loc2_:FBModel = null;
         var _loc3_:FBModel = null;
         var _loc4_:FBModelView = null;
         var _loc1_:MovieClip = _mc.getMC().getChildByName("mc_ordinary") as MovieClip;
         var _loc5_:int = 0;
         while(_loc5_ < InstanceManager.instance.dataList.Length())
         {
            _loc3_ = InstanceManager.instance.dataList.Values()[_loc5_];
            if(_loc5_ == 0)
            {
               _loc4_ = new FBModelView(_loc1_,_loc3_);
            }
            else
            {
               _loc4_ = new FBModelView(_loc1_,_loc3_,_loc2_);
            }
            _loc2_ = _loc3_;
            InstanceManager.instance.pushViewData(_loc3_.EctypeID,_loc4_);
            _loc5_++;
         }
         var _loc6_:int = 0;
         while(_loc6_ < InstanceManager.instance.challengeDataList.Length())
         {
            _loc3_ = InstanceManager.instance.challengeDataList.Values()[_loc6_];
            if(_loc6_ == 0)
            {
               _loc4_ = new FBModelView(_loc1_,_loc3_);
            }
            else
            {
               _loc4_ = new FBModelView(_loc1_,_loc3_,_loc2_);
            }
            _loc2_ = _loc3_;
            InstanceManager.instance.pushCallengeDataView(_loc3_.EctypeID,_loc4_);
            _loc6_++;
         }
      }
      
      public function receiveData(param1:Array) : void
      {
         var _loc3_:* = undefined;
         var _loc2_:int = 0;
         while(_loc2_ < param1.length)
         {
            _loc3_ = param1[_loc2_];
            this._selfFBTeamsArr.push(_loc3_);
            _loc2_++;
         }
         this.InitSelfPage();
      }
      
      private function InitSelfPage() : void
      {
         this._selfCurPage = 0;
         this._selfMaxPage = Math.floor((this._selfFBTeamsArr.length - 1) / this._selfPageSize);
         this.freshSelfTeams();
      }
      
      private function SelfFrontPage(param1:MouseEvent = null) : void
      {
         --this._selfCurPage;
         if(this._selfCurPage < 0)
         {
            this._selfCurPage = 0;
         }
         this.freshSelfTeams();
      }
      
      private function SelfNextPage(param1:MouseEvent = null) : void
      {
         this._selfCurPage += 1;
         if(this._selfCurPage > this._selfMaxPage)
         {
            this._selfCurPage = this._selfMaxPage;
         }
         this.freshSelfTeams();
      }
      
      private function freshSelfTeams() : void
      {
         var _loc1_:HButton = null;
         var _loc2_:MovieClip = null;
         var _loc4_:* = null;
         var _loc5_:MSG_RESP_JUMPGALAXYSHIP_TEMP = null;
         var _loc6_:Bitmap = null;
         var _loc7_:Bitmap = null;
         if(this._selfCurPage == 0)
         {
            this._leftPageBtn.setBtnDisabled(true);
            this._rightPageBtn.setBtnDisabled(false);
         }
         else if(this._selfCurPage == this._selfMaxPage)
         {
            this._leftPageBtn.setBtnDisabled(false);
            this._rightPageBtn.setBtnDisabled(true);
         }
         else
         {
            this._leftPageBtn.setBtnDisabled(false);
            this._rightPageBtn.setBtnDisabled(false);
         }
         TextField(_mc.getMC().tf_page).text = "" + (this._selfCurPage + 1) + "/" + (this._selfMaxPage + 1);
         var _loc3_:int = 0;
         while(_loc3_ < this._selfPageSize)
         {
            _loc2_ = _mc.getMC().getChildByName("mc_list" + _loc3_) as MovieClip;
            _loc2_.visible = false;
            TextField(_loc2_.tf_fleetname).text = "";
            TextField(_loc2_.tf_fleetnum).text = "";
            if(_loc2_.mc_commanderbase.getChildByName("CommanderBMP"))
            {
               _loc2_.mc_commanderbase.removeChild(_loc2_.mc_commanderbase.getChildByName("CommanderBMP"));
            }
            if(_loc2_.mc_fleetbase.getChildByName("ShipBMP"))
            {
               _loc2_.mc_fleetbase.removeChild(_loc2_.mc_fleetbase.getChildByName("ShipBMP"));
            }
            _loc4_ = this._selfCurPage * this._selfPageSize + _loc3_ + "";
            if(this._selfFBTeamsArr[_loc4_])
            {
               _loc5_ = this._selfFBTeamsArr[_loc4_][1] as MSG_RESP_JUMPGALAXYSHIP_TEMP;
               if(_loc5_)
               {
                  _loc2_.visible = true;
                  TextField(_loc2_.tf_fleetname).text = "" + _loc5_.TeamName;
                  TextField(_loc2_.tf_fleetnum).text = "" + _loc5_.ShipNum;
                  _loc6_ = CommanderSceneUI.getInstance().CommanderImg(_loc5_.CommanderId);
                  _loc6_.name = "CommanderBMP";
                  _loc2_.mc_commanderbase.addChild(_loc6_);
                  _loc7_ = GalaxyShipManager.instance.getShipImg(_loc5_.BodyId);
                  _loc7_.name = "ShipBMP";
                  _loc2_.mc_fleetbase.addChild(_loc7_);
               }
            }
            _loc3_++;
         }
         _loc2_ = this._dataBox.getMC("btn_purchase");
         if(this._selfFBTeamsArr.length > 0)
         {
            LocusTip.GetInstance().Hide();
         }
      }
      
      public function openTransforUI(param1:MouseEvent = null) : void
      {
         if(!InstanceManager.instance.curSelectFB)
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("BattleTXT06"),0);
            return;
         }
         if(InstanceManager.instance.curSelectFB.ModelType == 2 && this._LocusId >= LocusReader.getInstance().LocusCount)
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("Boss19"),0);
            return;
         }
         var _loc2_:GStar = GalaxyMapAction.instance.curStar;
         ShipTransferUI.instance.RequestJumpShips(_loc2_.GalaxyId,_loc2_.GalaxyMapId,2);
      }
      
      private function onItemClose(param1:MouseEvent) : void
      {
         var _loc4_:MSG_RESP_JUMPGALAXYSHIP_TEMP = null;
         if(param1.target.name != "btn_cancel")
         {
            return;
         }
         var _loc2_:int = int(String(param1.target.parent.name).split("mc_list")[1]);
         var _loc3_:* = this._selfCurPage * this._selfPageSize + _loc2_ + "";
         if(!this._selfFBTeamsArr[_loc3_])
         {
            return;
         }
         _loc4_ = this._selfFBTeamsArr[_loc3_][1] as MSG_RESP_JUMPGALAXYSHIP_TEMP;
         this._selfFBTeamsArr.splice(_loc3_,1);
         this.freshSelfTeams();
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         switch(param1.target.name)
         {
            case "btn_addfleet":
               this.openTransforUI();
               break;
            case "btn_begin":
               this.startInstance();
               break;
            case "btn_close":
               this.Release();
         }
      }
      
      public function setSelectBtn(param1:MouseEvent = null, param2:int = 0) : void
      {
         var _loc3_:String = null;
         var _loc5_:HButton = null;
         if(param1 == null)
         {
            switch(param2)
            {
               case 0:
                  _loc3_ = "btn_ordinary";
                  break;
               case 1:
                  _loc3_ = "btn_copy2";
                  break;
               case 2:
                  _loc3_ = "btn_copy3";
                  break;
               case 3:
                  _loc3_ = "btn_copy4";
            }
         }
         else
         {
            _loc3_ = param1.target.name;
         }
         if(this._copyBtnName == _loc3_)
         {
            return;
         }
         InstanceManager.instance.curSelectFB = null;
         InstanceManager.instance.setFBSelectedFalse();
         LocusTip.GetInstance().Hide();
         this._dataBox.getMC("mc_activity").visible = false;
         this._LocusMc.visible = false;
         this.mc_constellation.visible = false;
         this.mc_constellationintro.visible = false;
         this.HideSelectedConstellation();
         this.ShoppPropsId = 932;
         this._LocusTimer.stop();
         if(this._txt_time != null)
         {
            this._txt_time.visible = false;
         }
         switch(_loc3_)
         {
            case "btn_ordinary":
               this._BGBitmap.bitmapData = GameKernel.getTextureInstance("Copyimage0");
               this.OpenSecondCopy(false);
               break;
            case "btn_copy2":
               this._BGBitmap.bitmapData = GameKernel.getTextureInstance("Copyimage1");
               this.OpenSecondCopy(true);
               break;
            case "btn_copy3":
               this._BGBitmap.bitmapData = GameKernel.getTextureInstance("Copyimage3");
               this._LocusMc.visible = true;
               InstanceManager.instance.curSelectFB = this._LocusFB;
               InstanceManager.instance.curGateId = 0;
               this._dataBox.getMC("mc_activity").visible = true;
               LocusTip.GetInstance().Show(this.LocusTipStr,new Point(482,175));
               this.OpenSecondCopy(false);
               this._LocusTimer.start();
               this._txt_time.visible = true;
               this.ShowLocusRefreshTime();
               break;
            case "btn_copy4":
               this._BGBitmap.bitmapData = GameKernel.getTextureInstance("Copyimage0");
               this.mc_constellation.visible = true;
               this.mc_constellationintro.visible = true;
               this.ClearSelectedStar();
               this.ShowConstellation();
               this.OpenSecondCopy(false);
         }
         var _loc4_:int = 0;
         while(_loc4_ < this._copyBtnArr.length)
         {
            _loc5_ = this._copyBtnArr[_loc4_] as HButton;
            if(_loc3_ == _loc5_.m_name)
            {
               _loc5_.setSelect(true);
            }
            else
            {
               _loc5_.setSelect(false);
            }
            _loc4_++;
         }
         InstanceManager.instance.UpdateViewPanel(_loc3_,this._copyBtnName);
         this._copyBtnName = _loc3_;
      }
      
      private function ShowLocusRefreshTime() : void
      {
         var _loc1_:int = int(GamePlayer.getInstance().ServerDate.getDate());
         var _loc2_:Date = new Date(GamePlayer.getInstance().ServerDate.getFullYear(),GamePlayer.getInstance().ServerDate.getMonth(),GamePlayer.getInstance().ServerDate.getDate());
         _loc2_ = new Date(_loc2_.getTime() + 1000 * 60 * 60 * 24);
         while(_loc2_.getDate() % 2 != 0)
         {
            _loc2_ = new Date(_loc2_.getTime() + 1000 * 60 * 60 * 24);
         }
         var _loc3_:Number = _loc2_.getTime() - GamePlayer.getInstance().ServerDate.getTime();
         var _loc4_:String = StringManager.getInstance().getMessageString("Boss45");
         this._txt_time.text = _loc4_.replace("@@1",DataWidget.secondFormatToTime(_loc3_ / 1000));
      }
      
      private function OnLocusTimer(param1:TimerEvent) : void
      {
         this.ShowLocusRefreshTime();
      }
      
      private function OpenSecondCopy(param1:Boolean) : void
      {
         this._dataBox.getMC("mc_copychallenge").visible = param1;
         this._dataBox.getMC("btn_purchase").visible = param1;
         this._dataBox.getMC("mc_medals").visible = param1;
         this._xzNum.bitmapData = BirthFont.instance.getString("x" + GamePlayer.getInstance().Badge);
         this._dataBox.getTF("tf_medals").visible = param1;
         this._dataBox.getTF("tf_txt0").visible = param1;
         this._dataBox.getTF("tf_txt1").visible = param1;
      }
      
      public function startInstance(param1:MouseEvent = null) : void
      {
         var _loc2_:String = null;
         var _loc3_:DisplayObjectContainer = null;
         var _loc5_:String = null;
         var _loc4_:FBModel = InstanceManager.instance.curSelectFB;
         if(_loc4_ == null)
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("BattleTXT06"),0);
            return;
         }
         if(_loc4_.Treasure_str == null)
         {
            if(_loc4_.ModelType != 2)
            {
               if(!InstanceManager.instance.checkNeeded(_loc4_))
               {
                  MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("BattleTXT03") + _loc4_.Needed,0);
                  return;
               }
            }
            else
            {
               if(this._LocusId >= LocusReader.getInstance().LocusCount)
               {
                  MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("Boss19"),0);
                  return;
               }
               if(GamePlayer.getInstance().UserMoney < this.LocusMoney)
               {
                  MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("CorpsText165"),0);
                  return;
               }
               if(GamePlayer.getInstance().SpValue < this.LocusSP)
               {
                  MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("VegetableText7"),0);
                  return;
               }
            }
         }
         if(this._selfFBTeamsArr.length == 0)
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("BattleTXT07"),0);
            return;
         }
         if(this._selfFBTeamsArr.length > InstanceManager.instance.curSelectFB.UserTeam)
         {
            _loc5_ = StringManager.getInstance().getMessageString("BattleTXT08");
            MessagePopup.getInstance().Show(_loc5_.replace("@@1",_loc4_.UserTeam),0);
            return;
         }
         if(!InstanceManager.instance.checkShipGas())
         {
            _loc2_ = StringManager.getInstance().getMessageString("BattleTXT10");
            _loc3_ = GameKernel.renderManager.getUI().getContainer();
            CEffectText.getInstance().showEffectText(_loc3_,_loc2_);
            this._selfFBTeamsArr.splice(0);
            this.freshSelfTeams();
            return;
         }
         if(_loc4_.Treasure_str != null)
         {
            if(!UpdateResource.getInstance().XiaoLaBaHd(953))
            {
               _loc2_ = StringManager.getInstance().getMessageString("Boss42");
               MessagePopup.getInstance().Show(_loc2_,0);
               return;
            }
         }
         if(_loc4_.ModelType == 1)
         {
            _loc3_ = GameKernel.renderManager.getUI().getContainer();
            if(GamePlayer.getInstance().DefyEctypeNum == 2)
            {
               if(!UpdateResource.getInstance().XiaoLaBaHd(932))
               {
                  _loc2_ = StringManager.getInstance().getMessageString("BattleTXT14");
                  CEffectText.getInstance().showEffectText(_loc3_,_loc2_);
                  return;
               }
            }
            else if(GamePlayer.getInstance().DefyEctypeNum > 2)
            {
               _loc2_ = StringManager.getInstance().getMessageString("BattleTXT15");
               CEffectText.getInstance().showEffectText(_loc3_,_loc2_);
               return;
            }
            GamePlayer.getInstance().DefyEctypeNum = GamePlayer.getInstance().DefyEctypeNum + 1;
         }
         else if(_loc4_.ModelType == 2)
         {
            GamePlayer.getInstance().SpValue = GamePlayer.getInstance().SpValue - this.LocusSP;
            PlayerInfoUI.getInstance().resetPlayerSp(GamePlayer.getInstance().SpValue);
            ConstructionAction.getInstance().costResource(0,0,this.LocusMoney,0);
         }
         InstanceManager.instance.requestStartFB(this._selfFBTeamsArr);
         this.Release();
      }
      
      public function Release(param1:MouseEvent = null) : void
      {
         this._LocusTimer.stop();
         GameKernel.popUpDisplayManager.Hide(_instance);
         this.releaseModel();
         this._selfFBTeamsArr.splice(0);
         this.freshSelfTeams();
      }
      
      public function reloadSupply() : void
      {
         this._selfFBTeamsArr.splice(0);
         this.freshSelfTeams();
         var _loc1_:GStar = GalaxyMapAction.instance.curStar;
         var _loc2_:int = InstanceManager.instance.curSelectFB ? 2 : 0;
         ShipTransferUI.instance.RequestJumpShips(_loc1_.GalaxyId,_loc1_.GalaxyMapId,_loc2_);
      }
      
      public function get selfFBTeamsArr() : Array
      {
         return this._selfFBTeamsArr;
      }
      
      public function releaseModel() : void
      {
         InstanceManager.instance.setFBSelectedFalse();
         InstanceManager.instance.curSelectFB = null;
         LocusTip.GetInstance().Hide();
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
