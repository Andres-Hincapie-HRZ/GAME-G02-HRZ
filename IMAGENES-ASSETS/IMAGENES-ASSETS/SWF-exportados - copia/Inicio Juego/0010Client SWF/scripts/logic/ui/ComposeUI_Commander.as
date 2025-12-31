package logic.ui
{
   import com.star.frameworks.managers.StringManager;
   import com.star.frameworks.utils.HashSet;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import logic.entry.DiamondInfo;
   import logic.entry.GamePlayer;
   import logic.entry.HButton;
   import logic.entry.ScienceSystem;
   import logic.entry.commander.CommanderInfo;
   import logic.entry.props.propsInfo;
   import logic.game.GameKernel;
   import logic.reader.CPropsReader;
   import logic.ui.tip.CaptionTip;
   import logic.ui.tip.CommanderInfoTip;
   import logic.ui.tip.CustomTip;
   import logic.utils.UpdateResource;
   import net.base.NetManager;
   import net.msg.Compose.MSG_REQUEST_COMMANDERINSERTSTONE;
   import net.msg.Compose.MSG_RESP_COMMANDERINSERTSTONE;
   import net.msg.commanderMsg.MSG_REQUEST_COMMANDERINFO;
   import net.router.CommanderRouter;
   
   public class ComposeUI_Commander
   {
      
      private static var instance:ComposeUI_Commander;
      
      private var BaseMc:MovieClip;
      
      private var mc_commander:MovieClip;
      
      private var DiamondListMc:MovieClip;
      
      private var Commander_btn_left:HButton;
      
      private var Commander_btn_right:HButton;
      
      private var Diamond_btn_left:HButton;
      
      private var Diamond_btn_right:HButton;
      
      private var tf_page:TextField;
      
      private var ItemList:Array = new Array();
      
      private var InsertBtnList:Array = new Array();
      
      private var DeleteBtnList:Array = new Array();
      
      private var PageId:int;
      
      private var PageCount:int;
      
      private const PageItemCount:int = 20;
      
      private var _PropsTip:MovieClip;
      
      private var SelectedDiamond:MovieClip;
      
      private var SelectedDiamondId:int;
      
      private var CommanderPageId:int;
      
      private var CommanderPageCount:int;
      
      private const CommanderPageItemCount:int = 4;
      
      private var SelectedCommanderMc:MovieClip;
      
      private var SelectedCommanderInfo:CommanderInfo;
      
      private var CommanderInfoMsg:CommanderInfo;
      
      private var InsertedDiamondList:Array = new Array();
      
      private var AddDiamondTempList:Array = new Array();
      
      private var MergeAnimMc:MovieClip;
      
      private var btn_allexcision:HButton;
      
      private var InsertNum:int;
      
      private var SelectedInsertItemId:int;
      
      private var RateList:Array = new Array("BlastHurt","Blast","DoubleHit","RepairShield","Assault","Endure","Shield","Exp");
      
      private var CommanderValueList:Array = new Array();
      
      private var DeleteAll:Boolean = false;
      
      private var DiamondPack:Array;
      
      public function ComposeUI_Commander()
      {
         super();
      }
      
      public static function GetInstance() : ComposeUI_Commander
      {
         if(!instance)
         {
            instance = new ComposeUI_Commander();
         }
         return instance;
      }
      
      public function Init(param1:MovieClip) : void
      {
         this.BaseMc = param1;
         this.InitDiamond();
         this.InitCommander();
      }
      
      private function InitDiamond() : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:XButton = null;
         var _loc4_:CaptionTip = null;
         this.DiamondListMc = this.BaseMc.mc_card2 as MovieClip;
         var _loc1_:int = 0;
         while(_loc1_ < this.PageItemCount)
         {
            _loc2_ = this.DiamondListMc.getChildByName("mc_list" + _loc1_) as MovieClip;
            _loc3_ = new XButton(_loc2_);
            _loc3_.Data = _loc1_;
            _loc3_.OnMouseOver = this.DiamondMouseOver;
            _loc3_.OnMouseDown = this.DiamondMouseDown;
            _loc3_.OnDoubleClick = this.DiamondDoubleClick;
            _loc2_.addEventListener(MouseEvent.MOUSE_OUT,this.DiamondMouseOut);
            _loc2_.addEventListener(MouseEvent.MOUSE_MOVE,this.DiamondMouseMove);
            _loc1_++;
         }
         this.Diamond_btn_left = new HButton(this.DiamondListMc.btn_left);
         this.Diamond_btn_left.m_movie.addEventListener(MouseEvent.CLICK,this.Diamond_btn_leftClick);
         this.Diamond_btn_right = new HButton(this.DiamondListMc.btn_right);
         this.Diamond_btn_right.m_movie.addEventListener(MouseEvent.CLICK,this.Diamond_btn_rightClick);
         this.tf_page = this.DiamondListMc.tf_page as TextField;
         _loc1_ = 0;
         while(_loc1_ < 12)
         {
            _loc4_ = new CaptionTip(this.DiamondListMc.getChildByName("pic_" + _loc1_) as MovieClip,StringManager.getInstance().getMessageString("CorpsText" + int(134 + _loc1_)));
            _loc1_++;
         }
      }
      
      private function InitCommander() : void
      {
         var _loc1_:int = 0;
         var _loc2_:XMovieClip = null;
         var _loc3_:MovieClip = null;
         var _loc4_:XButton = null;
         var _loc5_:MovieClip = null;
         var _loc6_:HButton = null;
         this.mc_commander = this.BaseMc.mc_commander as MovieClip;
         this.Commander_btn_left = new HButton(this.mc_commander.btn_left);
         this.Commander_btn_left.m_movie.addEventListener(MouseEvent.CLICK,this.Commander_btn_leftClick);
         this.Commander_btn_right = new HButton(this.mc_commander.btn_right);
         this.Commander_btn_right.m_movie.addEventListener(MouseEvent.CLICK,this.Commander_btn_rightClick);
         _loc1_ = 0;
         while(_loc1_ < this.CommanderPageItemCount)
         {
            _loc5_ = this.mc_commander.getChildByName("mc_headlist" + _loc1_) as MovieClip;
            _loc5_.buttonMode = true;
            _loc2_ = new XMovieClip(_loc5_);
            _loc2_.Data = _loc1_;
            _loc2_.OnClick = this.mc_headlistClick;
            _loc2_.OnMouseOver = this.mc_headlistMouseOver;
            _loc5_.addEventListener(MouseEvent.MOUSE_OUT,this.mc_headlistMouseOut);
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < 12)
         {
            _loc3_ = this.mc_commander.getChildByName("mc_list" + _loc1_) as MovieClip;
            _loc2_ = new XMovieClip(_loc3_.mc_base);
            _loc2_.Data = _loc1_;
            _loc2_.OnMouseOver = this.ItemMouseOver;
            _loc2_.OnDoubleClick = this.ItemDoubleClick;
            _loc3_.mc_base.addEventListener(MouseEvent.MOUSE_OUT,this.ItemMouseOut);
            this.ItemList.push(_loc3_);
            _loc3_ = this.mc_commander.getChildByName("btn_enchase" + _loc1_) as MovieClip;
            _loc4_ = new XButton(_loc3_);
            _loc4_.Data = _loc1_;
            _loc4_.OnClick = this.InsertBtnClick;
            this.InsertBtnList.push(_loc4_);
            _loc3_ = this.mc_commander.getChildByName("btn_excision" + _loc1_) as MovieClip;
            _loc4_ = new XButton(_loc3_);
            _loc4_.Data = _loc1_;
            _loc4_.OnClick = this.DeleteBtnClick;
            this.DeleteBtnList.push(_loc4_);
            _loc1_++;
         }
         this.btn_allexcision = new HButton(this.mc_commander.btn_allexcision);
         this.btn_allexcision.m_movie.addEventListener(MouseEvent.CLICK,this.btn_allexcisionClick);
         if(this.mc_commander.getChildByName("btn_allxiangqian") != null)
         {
            _loc6_ = new HButton(this.mc_commander.btn_allxiangqian);
            _loc6_.m_movie.addEventListener(MouseEvent.CLICK,this.btn_allxiangqianClick);
         }
         this.MergeAnimMc = GameKernel.getMovieClipInstance("MergeAnimMc");
         this.mc_commander.addChild(this.MergeAnimMc);
         this.MergeAnimMc.visible = false;
         this.MergeAnimMc.stop();
      }
      
      private function InsertBtnClick(param1:MouseEvent, param2:XButton) : void
      {
         if(this.CommanderInfoMsg.commander_state >= 3)
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("CorpsText166"),1);
            return;
         }
         var _loc3_:Object = this.AddDiamondTempList[param2.Data];
         if(_loc3_ != null && _loc3_.LockFlag == 0)
         {
            this.SelectedInsertItemId = param2.Data;
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("CorpsText148"),2,this.InsertDiamond);
         }
         else
         {
            this.RequestInsertDiamond(param2.Data,0);
         }
      }
      
      private function btn_allxiangqianClick(param1:MouseEvent) : void
      {
         var _loc3_:Object = null;
         if(this.CommanderInfoMsg.commander_state >= 3)
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("CorpsText166"),1);
            return;
         }
         var _loc2_:int = 0;
         while(_loc2_ < 12)
         {
            _loc3_ = this.AddDiamondTempList[_loc2_];
            if(_loc3_ != null && _loc3_.LockFlag == 0)
            {
               MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("CorpsText148"),2,this.InsertAll);
               return;
            }
            _loc2_++;
         }
         this.InsertAll();
      }
      
      private function InsertAll() : void
      {
         var _loc2_:Object = null;
         this.InsertNum = 0;
         var _loc1_:int = 0;
         while(_loc1_ < 12)
         {
            _loc2_ = this.AddDiamondTempList[_loc1_];
            if(_loc2_ != null)
            {
               ++this.InsertNum;
               this.RequestInsertDiamond(_loc1_,0);
            }
            _loc1_++;
         }
      }
      
      private function InsertDiamond() : void
      {
         this.RequestInsertDiamond(this.SelectedInsertItemId,0);
      }
      
      private function DeleteBtnClick(param1:MouseEvent, param2:XButton) : void
      {
         this.DeleteDiamond(param2.Data);
      }
      
      private function DeleteDiamond(param1:int) : void
      {
         var _loc2_:int = 0;
         if(this.CommanderInfoMsg.commander_state >= 3)
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("CorpsText166"),1);
            return;
         }
         if(this.InsertedDiamondList[param1] > 0)
         {
            _loc2_ = UpdateResource.getInstance().HasPackSpace(this.InsertedDiamondList[param1],1);
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
            this.RequestInsertDiamond(param1,1);
         }
      }
      
      private function RequestInsertDiamond(param1:int, param2:int) : void
      {
         var _loc4_:Object = null;
         var _loc3_:MSG_REQUEST_COMMANDERINSERTSTONE = new MSG_REQUEST_COMMANDERINSERTSTONE();
         _loc3_.Type = param2;
         _loc3_.CommanderId = this.SelectedCommanderInfo.commander_commanderId;
         _loc3_.HoleId = param1;
         if(param2 == 0)
         {
            _loc4_ = this.AddDiamondTempList[param1];
            if(_loc4_ == null)
            {
               return;
            }
            _loc3_.PropsId = _loc4_.PropsId;
            _loc3_.LockFlag = _loc4_.LockFlag;
         }
         else
         {
            this.btn_allexcision.setBtnDisabled(true);
            _loc3_.PropsId = this.InsertedDiamondList[param1];
         }
         _loc3_.SeqId = GamePlayer.getInstance().seqID++;
         _loc3_.Guid = GamePlayer.getInstance().Guid;
         NetManager.Instance().sendObject(_loc3_);
         this.mc_commander.mouseChildren = false;
         this.DiamondListMc.mouseChildren = false;
         if(param2 == 0)
         {
            this.MergeAnimMc.x = MovieClip(this.ItemList[param1]).x;
            this.MergeAnimMc.y = MovieClip(this.ItemList[param1]).y;
            this.MergeAnimMc.gotoAndPlay(1);
            this.MergeAnimMc.visible = true;
            this.MergeAnimMc.addEventListener(Event.EXIT_FRAME,this.MergeAnimMcExitFrame);
         }
      }
      
      private function MergeAnimMcExitFrame(param1:Event) : void
      {
         var _loc2_:MovieClip = param1.target as MovieClip;
         if(_loc2_.currentFrame == _loc2_.totalFrames)
         {
            this.MergeAnimMc.removeEventListener(Event.EXIT_FRAME,this.MergeAnimMcExitFrame);
            this.MergeAnimMc.visible = false;
            this.MergeAnimMc.stop();
            this.mc_commander.mouseChildren = true;
            this.DiamondListMc.mouseChildren = true;
         }
      }
      
      public function RespInsetDiamond(param1:MSG_RESP_COMMANDERINSERTSTONE) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Object = null;
         var _loc4_:Array = null;
         var _loc5_:propsInfo = null;
         var _loc6_:Boolean = false;
         var _loc7_:MovieClip = null;
         var _loc8_:MovieClip = null;
         var _loc9_:int = 0;
         if(param1.Type == 0)
         {
            _loc3_ = this.AddDiamondTempList[param1.HoleId];
            if(_loc3_ == null)
            {
               return;
            }
            _loc4_ = ScienceSystem.getinstance().Packarr;
            _loc2_ = 0;
            while(_loc2_ < _loc4_.length)
            {
               if(ScienceSystem.getinstance().Packarr[_loc2_].StorageType == 0)
               {
                  _loc5_ = CPropsReader.getInstance().GetPropsInfo(ScienceSystem.getinstance().Packarr[_loc2_].PropsId);
                  if(_loc5_ != null && _loc5_.Id == _loc3_.PropsId && ScienceSystem.getinstance().Packarr[_loc2_].LockFlag == _loc3_.LockFlag)
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
            this.AddDiamondTempList[param1.HoleId] = null;
            this.InsertedDiamondList[param1.HoleId] = param1.PropsId;
            HButton(this.InsertBtnList[param1.HoleId]).setVisible(false);
            HButton(this.DeleteBtnList[param1.HoleId]).setVisible(true);
            this.SelectedCommanderInfo.commander_Stone[param1.HoleId] = param1.PropsId;
            --this.SelectedCommanderInfo.commander_StoneHole;
         }
         else
         {
            this.btn_allexcision.setBtnDisabled(false);
            this.mc_commander.mouseChildren = true;
            this.DiamondListMc.mouseChildren = true;
            UpdateResource.getInstance().AddToPack(param1.PropsId,1,param1.LockFlag);
            _loc6_ = false;
            _loc2_ = 0;
            while(_loc2_ < this.DiamondPack.length)
            {
               _loc3_ = this.DiamondPack[_loc2_];
               if(_loc3_.PropsId == param1.PropsId && _loc3_.LockFlag == param1.LockFlag)
               {
                  ++_loc3_.num;
                  _loc6_ = true;
                  break;
               }
               _loc2_++;
            }
            if(!_loc6_)
            {
               _loc3_ = new Object();
               _loc3_.PropsId = param1.PropsId;
               _loc3_.LockFlag = param1.LockFlag;
               _loc3_.aDiamondInfo = CPropsReader.getInstance().GetDiamond(param1.PropsId);
               _loc3_.num = 1;
               this.DiamondPack.push(_loc3_);
               this.DiamondPack.sortOn(["LockFlag","PropsId"]);
            }
            this.AddDiamondTempList[param1.HoleId] = null;
            this.InsertedDiamondList[param1.HoleId] = -1;
            HButton(this.InsertBtnList[param1.HoleId]).setVisible(false);
            HButton(this.DeleteBtnList[param1.HoleId]).setVisible(false);
            _loc7_ = this.ItemList[param1.HoleId];
            _loc7_.gotoAndStop(2);
            _loc8_ = _loc7_.mc_base;
            if(_loc8_.numChildren > 1)
            {
               _loc8_.removeChildAt(1);
            }
            this.ShowDiamond();
            this.ShowCommanderValue();
            this.SelectedCommanderInfo.commander_Stone[param1.HoleId] = -1;
            ++this.SelectedCommanderInfo.commander_StoneHole;
            if(this.DeleteAll)
            {
               this.DeleteAll = false;
               _loc9_ = param1.HoleId + 1;
               while(_loc9_ < 12)
               {
                  if(this.InsertedDiamondList[_loc9_] > 0)
                  {
                     this.DeleteAll = true;
                     this.DeleteDiamond(_loc9_);
                     break;
                  }
                  _loc9_++;
               }
            }
         }
         if(this.InsertNum > 0)
         {
            --this.InsertNum;
            if(this.InsertNum <= 0)
            {
               ComposeUI.getInstance().Invalid(true);
            }
         }
      }
      
      private function Commander_btn_leftClick(param1:MouseEvent) : void
      {
         --this.CommanderPageId;
         this.ShowCommanderList();
      }
      
      private function Commander_btn_rightClick(param1:MouseEvent) : void
      {
         ++this.CommanderPageId;
         this.ShowCommanderList();
      }
      
      private function ShowCommanderValue() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:DiamondInfo = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:String = null;
         var _loc8_:int = 0;
         var _loc9_:TextField = null;
         var _loc10_:Number = NaN;
         this.ClearCommanderValue();
         _loc1_ = 0;
         while(_loc1_ < 12)
         {
            _loc2_ = int(this.InsertedDiamondList[_loc1_]);
            if(_loc2_ != -1 && _loc2_ != -2)
            {
               _loc2_ = Math.abs(_loc2_);
               _loc3_ = CPropsReader.getInstance().GetDiamond(_loc2_);
               _loc4_ = _loc3_.GemKindID - 1;
               if(_loc3_.PropsInfo.List < 40)
               {
                  if(_loc3_.GemKindID >= 13 && _loc3_.GemKindID <= 20)
                  {
                     this.CommanderValueList[_loc4_] += _loc3_.GemValue;
                  }
                  else
                  {
                     if(_loc4_ > 3)
                     {
                        _loc5_ = Number(_loc3_.GemValue) * 1000;
                     }
                     else
                     {
                        _loc5_ = int(_loc3_.GemValue);
                     }
                     if(this.CommanderValueList[_loc4_] == "")
                     {
                        this.CommanderValueList[_loc4_] = _loc5_.toString();
                     }
                     else
                     {
                        this.CommanderValueList[_loc4_] = (int(this.CommanderValueList[_loc4_]) + _loc5_).toString();
                     }
                  }
               }
               else
               {
                  _loc6_ = 0;
                  while(_loc6_ < 12)
                  {
                     _loc7_ = CPropsReader.getInstance().ValueNameList[_loc6_];
                     if(_loc3_.GemaValueList[_loc7_] != null)
                     {
                        if(this.RateList.indexOf(_loc7_) >= 0)
                        {
                           _loc8_ = Number(_loc3_.GemaValueList[_loc7_]) * 1000;
                        }
                        else
                        {
                           _loc8_ = int(_loc3_.GemaValueList[_loc7_]);
                        }
                        if(this.CommanderValueList[_loc6_] == "")
                        {
                           this.CommanderValueList[_loc6_] = _loc8_.toString();
                        }
                        else
                        {
                           this.CommanderValueList[_loc6_] = (int(this.CommanderValueList[_loc6_]) + _loc8_).toString();
                        }
                     }
                     _loc6_++;
                  }
               }
            }
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < 12)
         {
            _loc9_ = this.DiamondListMc.getChildByName("tf_" + _loc1_) as TextField;
            if(this.CommanderValueList[_loc1_] > 0 || this.CommanderValueList[_loc1_] != "")
            {
               if(_loc1_ > 3)
               {
                  _loc10_ = int(this.CommanderValueList[_loc1_]) / 10;
                  _loc9_.text = "+" + _loc10_ + "%";
               }
               else
               {
                  _loc9_.text = " + " + this.CommanderValueList[_loc1_].toString();
               }
            }
            else
            {
               _loc9_.text = "";
            }
            _loc1_++;
         }
      }
      
      private function ClearCommanderValue() : void
      {
         var _loc2_:TextField = null;
         var _loc1_:int = 0;
         while(_loc1_ < 12)
         {
            this.CommanderValueList[_loc1_] = "";
            _loc2_ = this.DiamondListMc.getChildByName("tf_" + _loc1_) as TextField;
            _loc2_.text = "";
            _loc1_++;
         }
      }
      
      private function mc_headlistClick(param1:MouseEvent, param2:XMovieClip) : void
      {
         var _loc3_:int = this.CommanderPageId * this.CommanderPageItemCount + param2.Data;
         if(_loc3_ >= CommanderRouter.instance.m_commandInfoAry.length)
         {
            return;
         }
         if(this.SelectedCommanderMc != null)
         {
            this.SelectedCommanderMc.gotoAndStop(1);
         }
         this.SelectedCommanderMc = param2.m_movie;
         this.SelectedCommanderMc.gotoAndStop(2);
         this.SelectedCommanderInfo = CommanderRouter.instance.m_commandInfoAry[_loc3_];
         this.CommanderInfoMsg = null;
         this.ClearCommander();
         this.InitDiamondPack();
         this.ShowDiamond();
         this.RequestCommanderInfo();
      }
      
      private function mc_headlistMouseOver(param1:MouseEvent, param2:XMovieClip) : void
      {
         var _loc3_:int = this.CommanderPageId * this.CommanderPageItemCount + param2.Data;
         if(_loc3_ >= CommanderRouter.instance.m_commandInfoAry.length)
         {
            return;
         }
         var _loc4_:CommanderInfo = CommanderRouter.instance.m_commandInfoAry[_loc3_];
         var _loc5_:MovieClip = param2.m_movie;
         var _loc6_:Point = _loc5_.localToGlobal(new Point(0,_loc5_.height));
         CommanderInfoTip.GetInstance().ShowCommanderInfo(_loc4_.commander_commanderId,_loc4_.commander_skill,_loc6_);
      }
      
      private function mc_headlistMouseOut(param1:MouseEvent) : void
      {
         CommanderInfoTip.GetInstance().Hide();
      }
      
      private function RequestCommanderInfo() : void
      {
         if(this.SelectedCommanderInfo == null)
         {
            return;
         }
         var _loc1_:MSG_REQUEST_COMMANDERINFO = new MSG_REQUEST_COMMANDERINFO();
         _loc1_.ShowType = 2;
         _loc1_.CommanderId = this.SelectedCommanderInfo.commander_commanderId;
         _loc1_.SeqId = GamePlayer.getInstance().seqID++;
         _loc1_.Guid = GamePlayer.getInstance().Guid;
         NetManager.Instance().sendObject(_loc1_);
      }
      
      public function RespCommanderInfo(param1:CommanderInfo) : void
      {
         this.CommanderInfoMsg = param1;
         if(this.SelectedCommanderInfo == null || this.SelectedCommanderInfo.commander_commanderId != param1.commander_commanderId)
         {
            this.CommanderInfoMsg = null;
            return;
         }
         this.ShowCommanderInfo();
      }
      
      private function GetMiniLevel(param1:int) : int
      {
         var _loc4_:int = 0;
         var _loc2_:int = int(param1 / 4);
         var _loc3_:int = param1 % 4;
         if(_loc2_ == 0)
         {
            _loc4_ = _loc3_ + 1;
         }
         else if(_loc2_ == 1)
         {
            _loc4_ = 6 + _loc3_ * 2;
         }
         else if(_loc2_ == 2)
         {
            _loc4_ = 15 + _loc3_ * 3;
         }
         return _loc4_;
      }
      
      private function ShowCommanderInfo() : void
      {
         var _loc1_:MovieClip = null;
         var _loc2_:MovieClip = null;
         var _loc4_:int = 0;
         var _loc5_:DiamondInfo = null;
         var _loc6_:Bitmap = null;
         var _loc7_:int = 0;
         var _loc3_:int = 0;
         while(_loc3_ < this.ItemList.length)
         {
            _loc1_ = this.ItemList[_loc3_];
            _loc4_ = int(this.CommanderInfoMsg.commander_Stone[_loc3_]);
            if(_loc4_ != -1)
            {
               _loc5_ = CPropsReader.getInstance().GetDiamond(_loc4_);
               _loc1_.gotoAndStop(2);
               _loc2_ = _loc1_.mc_base as MovieClip;
               _loc6_ = new Bitmap(GameKernel.getTextureInstance(_loc5_.PropsInfo.ImageFileName));
               _loc2_.addChild(_loc6_);
               this.InsertedDiamondList[_loc3_] = _loc4_;
               HButton(this.InsertBtnList[_loc3_]).setVisible(false);
               HButton(this.DeleteBtnList[_loc3_]).setVisible(true);
            }
            else
            {
               _loc7_ = this.GetMiniLevel(_loc3_);
               if(this.CommanderInfoMsg.commander_level >= _loc7_ - 1)
               {
                  _loc1_.gotoAndStop(2);
                  this.InsertedDiamondList[_loc3_] = -1;
               }
               else
               {
                  _loc1_.gotoAndStop(1);
                  this.InsertedDiamondList[_loc3_] = -2;
               }
               HButton(this.InsertBtnList[_loc3_]).setVisible(false);
               HButton(this.DeleteBtnList[_loc3_]).setVisible(false);
            }
            _loc3_++;
         }
         this.ShowCommanderValue();
      }
      
      private function btn_allexcisionClick(param1:MouseEvent) : void
      {
         var _loc3_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:Boolean = false;
         if(this.CommanderInfoMsg == null)
         {
            return;
         }
         var _loc2_:HashSet = new HashSet();
         _loc3_ = 0;
         while(_loc3_ < 12)
         {
            if(this.InsertedDiamondList[_loc3_] > 0)
            {
               _loc5_ = 0;
               if(_loc2_.ContainsKey(this.InsertedDiamondList[_loc3_]))
               {
                  _loc5_ = _loc2_.Get(this.InsertedDiamondList[_loc3_]);
               }
               (++_loc2_).Put(this.InsertedDiamondList[_loc3_],_loc5_);
            }
            _loc3_++;
         }
         var _loc4_:int = 0;
         _loc3_ = 0;
         while(true)
         {
            if(_loc3_ >= _loc2_.Length())
            {
               _loc3_ = 0;
               while(_loc3_ < 12)
               {
                  if(this.InsertedDiamondList[_loc3_] > 0)
                  {
                     this.DeleteAll = true;
                     this.DeleteDiamond(_loc3_);
                     break;
                  }
                  _loc3_++;
               }
               return;
            }
            _loc6_ = int(_loc2_.Keys()[_loc3_]);
            _loc7_ = _loc2_.Get(_loc6_);
            _loc8_ = false;
            _loc3_ = 0;
            while(_loc3_ < ScienceSystem.getinstance().Packarr.length)
            {
               if(ScienceSystem.getinstance().Packarr[_loc3_].PropsId == _loc6_ && ScienceSystem.getinstance().Packarr[_loc3_].LockFlag == 1)
               {
                  if(ScienceSystem.getinstance().Packarr[_loc3_].PropsNum + _loc7_ <= 9999)
                  {
                     _loc8_ = true;
                     break;
                  }
                  MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("BagTXT20"),0);
                  return;
               }
               _loc3_++;
            }
            if(_loc8_ == false)
            {
               if(GamePlayer.getInstance().PropsPack - ScienceSystem.getinstance().Packarr.length - _loc4_ <= 0)
               {
                  break;
               }
               _loc4_++;
            }
            _loc3_++;
         }
         MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("CommanderText12"),10);
      }
      
      private function ClearCommander() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         _loc1_ = 0;
         while(_loc1_ < this.ItemList.length)
         {
            MovieClip(this.ItemList[_loc1_]).gotoAndStop(1);
            _loc2_ = MovieClip(this.ItemList[_loc1_].mc_base);
            if(_loc2_.numChildren > 1)
            {
               _loc2_.removeChildAt(1);
            }
            this.InsertedDiamondList[_loc1_] = -2;
            this.AddDiamondTempList[_loc1_] = null;
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this.InsertBtnList.length)
         {
            HButton(this.InsertBtnList[_loc1_]).setVisible(false);
            HButton(this.DeleteBtnList[_loc1_]).setVisible(false);
            _loc1_++;
         }
      }
      
      private function ShowCommanderList() : void
      {
         var _loc3_:MovieClip = null;
         var _loc4_:MovieClip = null;
         var _loc5_:CommanderInfo = null;
         var _loc6_:Bitmap = null;
         this.CommanderPageCount = CommanderRouter.instance.m_commandInfoAry.length / this.CommanderPageItemCount;
         if(this.CommanderPageCount * this.CommanderPageItemCount < CommanderRouter.instance.m_commandInfoAry.length)
         {
            ++this.CommanderPageCount;
         }
         var _loc1_:int = this.CommanderPageId * this.CommanderPageItemCount;
         var _loc2_:int = 0;
         while(_loc2_ < this.CommanderPageItemCount)
         {
            _loc3_ = this.mc_commander.getChildByName("mc_headlist" + _loc2_) as MovieClip;
            _loc3_.gotoAndStop(1);
            _loc4_ = MovieClip(_loc3_.mc_base);
            if(_loc4_.numChildren > 1)
            {
               _loc4_.removeChildAt(1);
            }
            if(_loc1_ < CommanderRouter.instance.m_commandInfoAry.length)
            {
               _loc5_ = CommanderRouter.instance.m_commandInfoAry[_loc1_];
               _loc6_ = CommanderSceneUI.getInstance().CommanderAvararImg(_loc5_.commander_skill);
               _loc6_.width = 50;
               _loc6_.height = 50;
               _loc4_.addChild(_loc6_);
               if(this.SelectedCommanderInfo == _loc5_)
               {
                  _loc3_.gotoAndStop(2);
               }
            }
            _loc1_++;
            _loc2_++;
         }
         this.ResetCommanderPageButton();
      }
      
      private function ResetCommanderPageButton() : void
      {
         this.Commander_btn_left.setBtnDisabled(this.CommanderPageId == 0);
         this.Commander_btn_right.setBtnDisabled(this.CommanderPageId + 1 >= this.CommanderPageCount);
      }
      
      public function Clear() : void
      {
         this.PageId = 0;
         this.InitDiamondPack();
         this.ShowDiamond();
         this.ClearCommander();
         this.CommanderPageId = 0;
         this.SelectedCommanderInfo = null;
         this.ShowCommanderList();
         this.ClearCommanderValue();
         this.mc_commander.mouseChildren = true;
         this.DiamondListMc.mouseChildren = true;
      }
      
      private function DiamondMouseOver(param1:MouseEvent, param2:XButton) : void
      {
         var _loc3_:int = this.PageId * this.PageItemCount + param2.Data;
         if(_loc3_ < 0 || _loc3_ >= this.DiamondPack.length)
         {
            return;
         }
         var _loc4_:Object = this.DiamondPack[_loc3_];
         var _loc5_:DiamondInfo = _loc4_.aDiamondInfo;
         this.ShowDiamondTip(param2.m_movie,_loc4_.PropsId);
      }
      
      private function DiamondMouseOut(param1:MouseEvent) : void
      {
         if(this._PropsTip != null && this._PropsTip.parent != null && this._PropsTip.parent.contains(this._PropsTip))
         {
            this._PropsTip.parent.removeChild(this._PropsTip);
         }
      }
      
      private function ItemMouseOver(param1:MouseEvent, param2:XMovieClip) : void
      {
         var _loc4_:* = null;
         var _loc5_:Point = null;
         var _loc3_:int = int(this.InsertedDiamondList[param2.Data]);
         if(_loc3_ == -1 || _loc3_ == -2)
         {
            _loc4_ = "";
            if(_loc3_ == -2 && param2.Data > 0)
            {
               _loc4_ = StringManager.getInstance().getMessageString("CorpsText" + int(148 + param2.Data)) + "\n\n";
            }
            _loc4_ += StringManager.getInstance().getMessageString("CorpsText" + int(160 + param2.Data % 4));
            _loc5_ = param2.m_movie.localToGlobal(new Point(0,param2.m_movie.height));
            CustomTip.GetInstance().Show(_loc4_,_loc5_);
            return;
         }
         _loc3_ = Math.abs(_loc3_);
         this.ShowDiamondTip(param2.m_movie,_loc3_);
      }
      
      private function ItemMouseOut(param1:MouseEvent) : void
      {
         if(this._PropsTip != null && this._PropsTip.parent != null && this._PropsTip.parent.contains(this._PropsTip))
         {
            this._PropsTip.parent.removeChild(this._PropsTip);
         }
      }
      
      private function ItemDoubleClick(param1:MouseEvent, param2:XMovieClip) : void
      {
         if(this.InsertedDiamondList[param2.Data] >= -2)
         {
            return;
         }
         var _loc3_:MovieClip = this.ItemList[param2.Data];
         _loc3_.gotoAndStop(2);
         var _loc4_:MovieClip = _loc3_.mc_base as MovieClip;
         if(_loc4_.numChildren > 1)
         {
            _loc4_.removeChildAt(1);
         }
         this.CancelInsertDiamond(param2.Data);
         this.ShowDiamond();
         this.ShowCommanderValue();
         HButton(this.DeleteBtnList[param2.Data]).setVisible(false);
         HButton(this.InsertBtnList[param2.Data]).setVisible(false);
      }
      
      private function CancelInsertDiamond(param1:int) : void
      {
         var _loc2_:Object = this.AddDiamondTempList[param1];
         if(_loc2_ != null)
         {
            if(_loc2_.num <= 0)
            {
               this.DiamondPack.push(_loc2_);
               this.DiamondPack.sortOn(["LockFlag","PropsId"]);
            }
            ++_loc2_.num;
            this.AddDiamondTempList[param1] = null;
            this.InsertedDiamondList[param1] = -1;
         }
      }
      
      private function ShowDiamondTip(param1:MovieClip, param2:int) : void
      {
         if(param2 < 0)
         {
            return;
         }
         var _loc3_:Point = param1.localToGlobal(new Point(0,param1.height));
         _loc3_ = this.BaseMc.globalToLocal(_loc3_);
         this._PropsTip = PackUi.getInstance().TipHd(_loc3_.x,_loc3_.y,param2,true);
         this._PropsTip.x = _loc3_.x - 80;
         this._PropsTip.y = _loc3_.y;
         this.BaseMc.addChild(this._PropsTip);
      }
      
      private function DiamondMouseDown(param1:MouseEvent, param2:XButton) : void
      {
         var _loc3_:int = this.PageId * this.PageItemCount + param2.Data;
         if(_loc3_ < 0 || _loc3_ >= this.DiamondPack.length)
         {
            return;
         }
         var _loc4_:Point = param2.m_movie.localToGlobal(new Point(0,0));
         _loc4_ = this.BaseMc.globalToLocal(_loc4_);
         var _loc5_:Object = this.DiamondPack[_loc3_];
         var _loc6_:DiamondInfo = _loc5_.aDiamondInfo;
         var _loc7_:MovieClip = this.GetPropsImage(_loc6_.PropsInfo.ImageFileName,_loc4_.x,_loc4_.y);
         this.SelectedDiamond = _loc7_;
         this.SelectedDiamondId = _loc3_;
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
      
      private function DiamondMouseMove(param1:MouseEvent) : void
      {
         if(param1.buttonDown && this.SelectedDiamond != null && !this.BaseMc.contains(this.SelectedDiamond))
         {
            this.SelectedDiamond.addEventListener(MouseEvent.MOUSE_UP,this.SelectedDiamondMouseUp);
            this.BaseMc.addChild(this.SelectedDiamond);
            this.SelectedDiamond.startDrag(true);
         }
      }
      
      private function SelectedDiamondMouseUp(param1:MouseEvent) : void
      {
         var _loc7_:MovieClip = null;
         var _loc2_:Boolean = false;
         var _loc3_:Object = this.DiamondPack[this.SelectedDiamondId];
         var _loc4_:DiamondInfo = _loc3_.aDiamondInfo;
         var _loc5_:Point = this.BaseMc.localToGlobal(new Point(this.SelectedDiamond.x,this.SelectedDiamond.y));
         _loc5_ = this.mc_commander.globalToLocal(_loc5_);
         var _loc6_:int = 0;
         while(_loc6_ < 12)
         {
            _loc7_ = this.ItemList[_loc6_];
            if(_loc5_.x >= _loc7_.x && _loc5_.x < _loc7_.x + 40 && _loc5_.y >= _loc7_.y && _loc5_.y < _loc7_.y + 40)
            {
               this.AddDiamond(_loc6_);
               break;
            }
            _loc6_++;
         }
         this.SelectedDiamond.stopDrag();
         this.BaseMc.removeChild(this.SelectedDiamond);
         this.SelectedDiamond = null;
      }
      
      private function DiamondDoubleClick(param1:MouseEvent, param2:XButton) : void
      {
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc3_:int = this.PageId * this.PageItemCount + param2.Data;
         if(_loc3_ < 0 || _loc3_ >= this.DiamondPack.length)
         {
            return;
         }
         var _loc4_:Object = this.DiamondPack[_loc3_];
         var _loc5_:DiamondInfo = _loc4_.aDiamondInfo;
         this.SelectedDiamondId = _loc3_;
         var _loc6_:Boolean = false;
         var _loc7_:int = _loc5_.GemColor % 5 - 1;
         _loc8_ = 0;
         while(_loc8_ < 3)
         {
            _loc9_ = _loc8_ * 4 + _loc7_;
            if(this.InsertedDiamondList[_loc9_] == -1)
            {
               this.AddDiamond(_loc9_);
               _loc6_ = true;
               break;
            }
            _loc8_++;
         }
         if(!_loc6_)
         {
            _loc7_ = 3;
            _loc8_ = 0;
            while(_loc8_ < 3)
            {
               _loc9_ = _loc8_ * 4 + _loc7_;
               if(this.InsertedDiamondList[_loc9_] == -1)
               {
                  this.AddDiamond(_loc9_);
                  _loc6_ = true;
                  break;
               }
               _loc8_++;
            }
         }
         if(!_loc6_)
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("CorpsText133"),0);
         }
         this.SelectedDiamond = null;
      }
      
      private function AddDiamond(param1:int) : void
      {
         if(this.CommanderInfoMsg == null)
         {
            return;
         }
         if(this.InsertedDiamondList[param1] == -2 || this.InsertedDiamondList[param1] > 0)
         {
            return;
         }
         if(this.SelectedDiamondId < 0 || this.SelectedDiamondId >= this.DiamondPack.length)
         {
            return;
         }
         var _loc2_:Object = this.DiamondPack[this.SelectedDiamondId];
         var _loc3_:DiamondInfo = _loc2_.aDiamondInfo;
         var _loc4_:int = param1 % 4 + 1;
         if(_loc3_.GemColor != _loc4_ && _loc4_ != 4)
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("CorpsText" + int(129 + _loc4_)),0);
            return;
         }
         this.CancelInsertDiamond(param1);
         var _loc5_:Bitmap = new Bitmap(GameKernel.getTextureInstance(_loc3_.PropsInfo.ImageFileName));
         var _loc6_:MovieClip = this.ItemList[param1];
         _loc6_.gotoAndStop(2);
         var _loc7_:MovieClip = _loc6_.mc_base as MovieClip;
         if(_loc7_.numChildren > 1)
         {
            _loc7_.removeChildAt(1);
         }
         _loc7_.addChild(_loc5_);
         this.AddDiamondTempList[param1] = _loc2_;
         this.InsertedDiamondList[param1] = -_loc3_.PropsId;
         HButton(this.DeleteBtnList[param1]).setVisible(false);
         HButton(this.InsertBtnList[param1]).setVisible(true);
         --_loc2_.num;
         if(_loc2_.num <= 0)
         {
            this.SelectedDiamondId = this.DiamondPack.indexOf(_loc2_);
            if(this.SelectedDiamondId >= 0)
            {
               this.DiamondPack.splice(this.SelectedDiamondId,1);
            }
         }
         this.ShowDiamond();
         this.ShowCommanderValue();
      }
      
      private function InitDiamondPack() : void
      {
         var _loc3_:propsInfo = null;
         var _loc4_:DiamondInfo = null;
         var _loc5_:Object = null;
         this.DiamondPack = new Array();
         var _loc1_:Array = ScienceSystem.getinstance().Packarr;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_.length)
         {
            if(ScienceSystem.getinstance().Packarr[_loc2_].StorageType == 0)
            {
               _loc3_ = CPropsReader.getInstance().GetPropsInfo(ScienceSystem.getinstance().Packarr[_loc2_].PropsId);
               if(_loc3_ != null && _loc3_.PackID == 3)
               {
                  _loc4_ = CPropsReader.getInstance().GetDiamond(ScienceSystem.getinstance().Packarr[_loc2_].PropsId);
                  if(_loc4_.GemColor != 0)
                  {
                     _loc5_ = new Object();
                     _loc5_.PropsId = ScienceSystem.getinstance().Packarr[_loc2_].PropsId;
                     _loc5_.LockFlag = ScienceSystem.getinstance().Packarr[_loc2_].LockFlag;
                     _loc5_.aDiamondInfo = _loc4_;
                     _loc5_.num = ScienceSystem.getinstance().Packarr[_loc2_].PropsNum;
                     this.DiamondPack.push(_loc5_);
                  }
               }
            }
            _loc2_++;
         }
         this.DiamondPack.sortOn(["LockFlag","PropsId"]);
         this.PageCount = this.DiamondPack.length / this.PageItemCount;
         if(this.PageCount * this.PageItemCount < this.DiamondPack.length)
         {
            ++this.PageCount;
         }
      }
      
      private function ShowDiamond() : void
      {
         var _loc3_:MovieClip = null;
         var _loc4_:MovieClip = null;
         var _loc5_:TextField = null;
         var _loc6_:DisplayObject = null;
         var _loc7_:Object = null;
         var _loc8_:DiamondInfo = null;
         var _loc9_:Bitmap = null;
         var _loc1_:int = this.PageId * this.PageItemCount;
         var _loc2_:int = 0;
         while(_loc2_ < this.PageItemCount)
         {
            _loc3_ = this.DiamondListMc.getChildByName("mc_list" + _loc2_) as MovieClip;
            _loc4_ = _loc3_.mc_base as MovieClip;
            if(_loc4_.numChildren > 1)
            {
               _loc4_.removeChildAt(1);
            }
            _loc5_ = _loc3_.tf_num as TextField;
            _loc6_ = _loc3_.mc_lock as DisplayObject;
            _loc6_.visible = false;
            _loc5_.text = "";
            if(_loc1_ < this.DiamondPack.length)
            {
               _loc7_ = this.DiamondPack[_loc1_];
               _loc8_ = _loc7_.aDiamondInfo;
               _loc9_ = new Bitmap(GameKernel.getTextureInstance(_loc8_.PropsInfo.ImageFileName));
               _loc4_.addChild(_loc9_);
               _loc5_.text = _loc7_.num.toString();
               _loc6_.visible = _loc7_.LockFlag == 1;
            }
            _loc1_++;
            _loc2_++;
         }
         this.ResetPageButton();
      }
      
      private function ResetPageButton() : void
      {
         this.Diamond_btn_left.setBtnDisabled(this.PageId == 0);
         this.Diamond_btn_right.setBtnDisabled(this.PageId + 1 >= this.PageCount);
         if(this.PageCount == 0)
         {
            this.tf_page.text = "";
         }
         else
         {
            this.tf_page.text = this.PageId + 1 + "/" + this.PageCount;
         }
      }
      
      private function Diamond_btn_leftClick(param1:MouseEvent) : void
      {
         --this.PageId;
         this.ShowDiamond();
      }
      
      private function Diamond_btn_rightClick(param1:MouseEvent) : void
      {
         ++this.PageId;
         this.ShowDiamond();
      }
   }
}

