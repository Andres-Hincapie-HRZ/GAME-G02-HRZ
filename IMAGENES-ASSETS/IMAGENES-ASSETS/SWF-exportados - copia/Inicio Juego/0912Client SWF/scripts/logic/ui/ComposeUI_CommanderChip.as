package logic.ui
{
   import com.star.frameworks.managers.StringManager;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.geom.Point;
   import flash.text.TextField;
   import logic.entry.GamePlayer;
   import logic.entry.HButton;
   import logic.entry.commander.CommanderInfo;
   import logic.entry.props.propsInfo;
   import logic.game.GameKernel;
   import logic.reader.CPropsReader;
   import logic.reader.FlagShipReader;
   import logic.ui.tip.CommanderChipTip;
   import logic.ui.tip.CommanderInfoTip;
   import net.base.NetManager;
   import net.msg.ChipLottery.CmosInfo;
   import net.msg.ChipLottery.MSG_REQUEST_CMOSLOTTERYINFO;
   import net.msg.ChipLottery.MSG_REQUEST_OPENCMOSPACK;
   import net.msg.ChipLottery.MSG_REQUEST_UNIONCMOS;
   import net.msg.ChipLottery.MSG_RESP_CMOSLOTTERYINFO;
   import net.msg.Compose.MSG_REQUEST_COMMANDERINSERTCMOS;
   import net.msg.Compose.MSG_RESP_COMMANDERINSERTCMOS;
   import net.msg.commanderMsg.MSG_REQUEST_COMMANDERINFO;
   import net.router.ChipLotteryRouter;
   import net.router.CommanderRouter;
   
   public class ComposeUI_CommanderChip
   {
      
      private static var instance:ComposeUI_CommanderChip;
      
      private var BaseMc:MovieClip;
      
      private var CommandMc:MovieClip;
      
      private var ChipMc:MovieClip;
      
      private var btn_left:HButton;
      
      private var btn_right:HButton;
      
      private var mc_explain:MovieClip;
      
      private var CommanderPageCount:int;
      
      private var CommanderPageItemCount:int = 4;
      
      private var CommanderPageId:int;
      
      private var ChipInfoMsg:MSG_RESP_CMOSLOTTERYINFO;
      
      private var SelectedChipMc:XMovieClip;
      
      private var DropMc:MovieClip;
      
      private var UnionMsg:MSG_REQUEST_UNIONCMOS;
      
      private var SelectedCommander:XMovieClip;
      
      private var SelectedCommanderIndex:int;
      
      private var CommanderInfoMsg:CommanderInfo;
      
      private var SelectedCommanderId:int;
      
      private var SetChipMsg:MSG_REQUEST_COMMANDERINSERTCMOS;
      
      private var RequestCount:int;
      
      private var GroupIdList:Array;
      
      private var SelectedChipInfo:CmosInfo;
      
      private var RubbishId:int = 4220;
      
      private var WisdomId:int = 4221;
      
      private var CurDir:Array;
      
      private var CellCount:int;
      
      private var FilterList:Array;
      
      public function ComposeUI_CommanderChip()
      {
         super();
         this.InitFilterList();
      }
      
      public static function GetInstance() : ComposeUI_CommanderChip
      {
         if(!instance)
         {
            instance = new ComposeUI_CommanderChip();
         }
         return instance;
      }
      
      public function Init(param1:MovieClip) : void
      {
         this.BaseMc = param1;
         this.CommandMc = param1.getChildByName("mc_commanderchip0") as MovieClip;
         this.ChipMc = param1.getChildByName("mc_commanderchip1") as MovieClip;
         this.InitCommandList();
         this.InitCommandChip();
         this.InitChipList();
         this.GroupIdList = new Array();
      }
      
      private function InitCommandList() : void
      {
         var _loc2_:XMovieClip = null;
         var _loc1_:int = 0;
         while(_loc1_ < 4)
         {
            _loc2_ = new XMovieClip(this.CommandMc.getChildByName("mc_headlist" + _loc1_) as MovieClip);
            _loc2_.Data = _loc1_;
            _loc2_.OnClick = this.CommanderClick;
            _loc2_.OnMouseOver = this.CommanderOver;
            _loc2_.m_movie.addEventListener(MouseEvent.MOUSE_OUT,this.CommanderOut);
            _loc2_.m_movie.gotoAndStop(1);
            _loc1_++;
         }
         this.btn_left = new HButton(this.CommandMc.getChildByName("btn_left") as MovieClip);
         this.btn_left.m_movie.addEventListener(MouseEvent.CLICK,this.btn_leftClick);
         this.btn_right = new HButton(this.CommandMc.getChildByName("btn_right") as MovieClip);
         this.btn_right.m_movie.addEventListener(MouseEvent.CLICK,this.btn_rightClick);
      }
      
      private function InitCommandChip() : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:XButton = null;
         var _loc4_:XMovieClip = null;
         var _loc5_:Sprite = null;
         var _loc6_:XMovieClip = null;
         var _loc1_:int = 0;
         while(_loc1_ < 5)
         {
            _loc2_ = this.CommandMc.getChildByName("mc_list" + _loc1_) as MovieClip;
            _loc2_.gotoAndStop(1);
            _loc3_ = new XButton(_loc2_.getChildByName("btn_excision0") as MovieClip);
            _loc3_.Data = _loc1_;
            _loc3_.OnClick = this.btn_excisionClick;
            _loc4_ = new XMovieClip(_loc2_);
            _loc4_.Data = _loc1_;
            _loc4_.OnMouseOver = this.CommanderChipOver;
            _loc4_.m_movie.addEventListener(MouseEvent.MOUSE_OUT,this.CommanderChipOut);
            _loc5_ = this.CommandMc.getChildByName("mc_pic" + _loc1_) as Sprite;
            _loc5_.addChildAt(new Bitmap(),0);
            _loc6_ = new XMovieClip(MovieClip(_loc5_));
            _loc6_.Data = _loc1_;
            _loc6_.OnMouseOver = this.CommanderChipOver;
            _loc6_.m_movie.addEventListener(MouseEvent.MOUSE_OUT,this.CommanderChipOut);
            _loc1_++;
         }
      }
      
      private function InitChipList() : void
      {
         var _loc3_:HButton = null;
         var _loc4_:XMovieClip = null;
         this.mc_explain = this.ChipMc.getChildByName("mc_explain") as MovieClip;
         this.mc_explain.gotoAndStop(1);
         this.mc_explain.addEventListener(MouseEvent.CLICK,this.mc_explainClick);
         var _loc1_:int = 0;
         while(_loc1_ < 30)
         {
            _loc4_ = new XMovieClip(this.ChipMc.getChildByName("mc_list" + _loc1_) as MovieClip);
            _loc4_.Data = _loc1_;
            _loc4_.OnMouseDown = this.ChipClick;
            _loc4_.OnMouseOver = this.ChipOver;
            _loc4_.OnDoubleClick = this.ChipDoubleClick;
            Sprite(_loc4_.m_movie.mc_base).doubleClickEnabled = true;
            _loc4_.m_movie.addEventListener(MouseEvent.MOUSE_OUT,this.ChipOut);
            _loc4_.m_movie.addEventListener(MouseEvent.MOUSE_MOVE,this.ChipMove);
            _loc4_.m_movie.gotoAndStop(1);
            _loc1_++;
         }
         this.DropMc = new MovieClip();
         var _loc2_:Bitmap = new Bitmap();
         _loc2_.x = -20;
         _loc2_.y = -20;
         this.DropMc.addChild(_loc2_);
         this.DropMc.addEventListener(MouseEvent.MOUSE_UP,this.DropMcUp);
         this.BaseMc.addChild(this.DropMc);
         this.DropMc.visible = false;
         _loc3_ = new HButton(this.ChipMc.getChildByName("btn_lock") as MovieClip);
         _loc3_.m_movie.addEventListener(MouseEvent.CLICK,this.btn_lockClick);
         _loc3_ = new HButton(this.ChipMc.getChildByName("btn_back") as MovieClip);
         _loc3_.m_movie.addEventListener(MouseEvent.CLICK,this.btn_backClick);
      }
      
      public function Clear() : void
      {
         this.RequestCount = 0;
         this.SelectedCommanderId = -1;
         this.SelectedCommanderIndex = -1;
         this.ChipInfoMsg = null;
         this.ClearCommanderInfo();
         this.SelectedChipMc = null;
         this.SelectedChipInfo = null;
         this.CommanderPageId = 0;
         this.ShowCommanderList();
         this.RequestChipList();
      }
      
      private function ClearCommanderInfo() : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:Sprite = null;
         this.CommanderInfoMsg = null;
         var _loc1_:int = 0;
         while(_loc1_ < 5)
         {
            _loc2_ = this.CommandMc.getChildByName("mc_list" + _loc1_) as MovieClip;
            _loc2_.gotoAndStop(1);
            MovieClip(_loc2_.getChildByName("btn_excision0")).visible = false;
            _loc3_ = this.CommandMc.getChildByName("mc_pic" + _loc1_) as Sprite;
            Bitmap(_loc3_.getChildAt(0)).bitmapData = null;
            TextField(this.CommandMc.getChildByName("txt_plus" + _loc1_)).text = "";
            _loc1_++;
         }
      }
      
      private function ShowCommanderList() : void
      {
         var _loc3_:MovieClip = null;
         var _loc4_:MovieClip = null;
         var _loc5_:CommanderInfo = null;
         var _loc6_:Bitmap = null;
         this.CommanderPageCount = Math.ceil(CommanderRouter.instance.m_commandInfoAry.length / this.CommanderPageItemCount);
         var _loc1_:int = this.CommanderPageId * this.CommanderPageItemCount;
         var _loc2_:int = 0;
         while(_loc2_ < this.CommanderPageItemCount)
         {
            _loc3_ = this.CommandMc.getChildByName("mc_headlist" + _loc2_) as MovieClip;
            _loc3_.gotoAndStop(1);
            _loc4_ = MovieClip(_loc3_.mc_base);
            if(_loc4_.numChildren > 0)
            {
               _loc4_.removeChildAt(0);
            }
            if(_loc1_ < CommanderRouter.instance.m_commandInfoAry.length)
            {
               _loc5_ = CommanderRouter.instance.m_commandInfoAry[_loc1_];
               _loc6_ = CommanderSceneUI.getInstance().CommanderAvararImg(_loc5_.commander_skill);
               _loc6_.width = 50;
               _loc6_.height = 50;
               _loc4_.addChildAt(_loc6_,0);
            }
            if(this.SelectedCommanderIndex == _loc1_)
            {
               _loc3_.gotoAndStop(2);
            }
            _loc1_++;
            _loc2_++;
         }
         this.ResetCommanderPageButton();
      }
      
      private function ResetCommanderPageButton() : void
      {
         this.btn_left.setBtnDisabled(this.CommanderPageId == 0);
         this.btn_right.setBtnDisabled(this.CommanderPageId + 1 >= this.CommanderPageCount);
      }
      
      private function RequestChipList() : void
      {
         var _loc1_:MSG_REQUEST_CMOSLOTTERYINFO = new MSG_REQUEST_CMOSLOTTERYINFO();
         _loc1_.SeqId = GamePlayer.getInstance().seqID++;
         _loc1_.Guid = GamePlayer.getInstance().Guid;
         NetManager.Instance().sendObject(_loc1_);
      }
      
      public function Resp_MSG_RESP_CMOSLOTTERYINFO(param1:MSG_RESP_CMOSLOTTERYINFO) : void
      {
         if(this.BaseMc == null)
         {
            return;
         }
         this.SetEnable(true);
         if(this.SelectedChipMc != null)
         {
            this.SelectedChipMc.m_movie.gotoAndStop(1);
         }
         this.SelectedChipMc = null;
         this.ChipInfoMsg = param1;
         this.ShowChipList();
      }
      
      private function SetEnable(param1:Boolean) : void
      {
         this.BaseMc.mouseChildren = param1;
         this.BaseMc.mouseChildren = param1;
      }
      
      private function ShowChipList() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < 30)
         {
            this.ShowProps(_loc1_);
            _loc1_++;
         }
      }
      
      private function ShowProps(param1:int) : void
      {
         var _loc3_:CmosInfo = null;
         var _loc4_:propsInfo = null;
         var _loc5_:Sprite = null;
         var _loc6_:Bitmap = null;
         var _loc7_:int = 0;
         var _loc8_:Sprite = null;
         var _loc2_:MovieClip = this.ChipMc.getChildByName("mc_list" + param1) as MovieClip;
         if(this.ChipInfoMsg.DataLen > param1)
         {
            _loc3_ = this.ChipInfoMsg.Data[param1];
            _loc4_ = CPropsReader.getInstance().GetPropsInfo(_loc3_.PropsId);
            _loc5_ = Sprite(_loc2_.mc_base);
            if(_loc5_.numChildren > 0)
            {
               _loc5_.removeChildAt(0);
            }
            _loc6_ = new Bitmap(GameKernel.getTextureInstance(_loc4_.ImageFileName));
            if(ChipLotteryRouter.instance.FirstShow && (_loc4_.PropsColor == 3 || _loc4_.PropsColor == 4))
            {
               _loc7_ = int(ChipLottery.LockList.indexOf(param1));
               if(_loc7_ < 0)
               {
                  ChipLottery.LockList.push(param1);
                  Sprite(_loc2_.mc_lock).visible = true;
               }
            }
            _loc6_.filters = [this.FilterList[_loc4_.PropsColor]];
            _loc5_.addChildAt(_loc6_,0);
            Sprite(_loc2_.mc_lock).visible = ChipLottery.LockList.indexOf(param1) >= 0;
            _loc2_.gotoAndStop(2);
         }
         else if(param1 < this.ChipInfoMsg.CmosPackCount)
         {
            _loc2_.gotoAndStop(2);
            _loc8_ = Sprite(_loc2_.mc_base);
            if(_loc8_.numChildren > 0)
            {
               _loc8_.removeChildAt(0);
            }
            Sprite(_loc2_.mc_lock).visible = false;
         }
         else
         {
            _loc2_.gotoAndStop(1);
            Sprite(_loc2_.mc_lock).visible = false;
         }
      }
      
      private function btn_backClick(param1:MouseEvent) : void
      {
         GameKernel.popUpDisplayManager.Hide(ComposeUI.getInstance());
         ChipLottery.getInstance().Show();
      }
      
      private function btn_lockClick(param1:MouseEvent) : void
      {
         if(this.SelectedChipMc == null)
         {
            return;
         }
         this.ChangeLockStatus(this.SelectedChipMc.Data);
      }
      
      private function ChangeLockStatus(param1:int) : void
      {
         var _loc2_:MovieClip = this.ChipMc.getChildByName("mc_list" + param1) as MovieClip;
         var _loc3_:int = int(ChipLottery.LockList.indexOf(param1));
         if(_loc3_ >= 0)
         {
            ChipLottery.LockList.splice(_loc3_,1);
            Sprite(_loc2_.mc_lock).visible = false;
         }
         else
         {
            ChipLottery.LockList.push(param1);
            Sprite(_loc2_.mc_lock).visible = true;
         }
      }
      
      private function ChipOut(param1:MouseEvent) : void
      {
         CommanderChipTip.Hide();
      }
      
      private function ChipDoubleClick(param1:MouseEvent, param2:XMovieClip) : void
      {
         if(this.SelectedCommanderId < 0)
         {
            return;
         }
         if(param2.Data >= this.ChipInfoMsg.DataLen)
         {
            return;
         }
         var _loc3_:CmosInfo = this.ChipInfoMsg.Data[param2.Data];
         if(_loc3_.PropsId == this.RubbishId)
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("Boss50"),0);
            return;
         }
         if(_loc3_.PropsId == this.WisdomId)
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("Boss51"),0);
            return;
         }
         var _loc4_:int = 0;
         while(_loc4_ < 5)
         {
            if(this.CommanderInfoMsg.ChipList[_loc4_] == -1)
            {
               this.SelectedChipInfo = _loc3_;
               this.SetChip(_loc4_,param2.Data);
               break;
            }
            _loc4_++;
         }
      }
      
      private function ChipOver(param1:MouseEvent, param2:XMovieClip) : void
      {
         if(param2.Data >= this.ChipInfoMsg.DataLen)
         {
            return;
         }
         var _loc3_:CmosInfo = this.ChipInfoMsg.Data[param2.Data];
         CommanderChipTip.Show(param2.m_movie,_loc3_);
      }
      
      private function ChipClick(param1:MouseEvent, param2:XMovieClip) : void
      {
         var _loc3_:String = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         if(param2.Data < this.ChipInfoMsg.DataLen)
         {
            if(this.SelectedChipMc != null)
            {
               this.SelectedChipMc.m_movie.gotoAndStop(1);
            }
            this.SelectedChipMc = param2;
            this.SelectedChipMc.m_movie.gotoAndStop(3);
         }
         else if(param2.m_movie.currentFrame == 1)
         {
            _loc3_ = StringManager.getInstance().getMessageString("Boss52");
            this.CellCount = param2.Data - this.ChipInfoMsg.CmosPackCount + 1;
            _loc4_ = 0;
            _loc5_ = 0;
            while(_loc5_ < this.CellCount)
            {
               _loc4_ += FlagShipReader.getInstance().GetOpenCellMoney(param2.Data - 15 - _loc5_);
               _loc5_++;
            }
            _loc3_ = _loc3_.replace("@@1",this.CellCount);
            _loc3_ = _loc3_.replace("@@2",_loc4_);
            MessagePopup.getInstance().Show(_loc3_,2,this.AddCell);
         }
      }
      
      private function AddCell() : void
      {
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
         var _loc2_:CmosInfo = null;
         var _loc3_:Sprite = null;
         if(param1.buttonDown && this.SelectedChipMc != null)
         {
            _loc2_ = CmosInfo(this.ChipInfoMsg.Data[this.SelectedChipMc.Data]);
            if(_loc2_.PropsId != this.RubbishId)
            {
               _loc3_ = Sprite(this.SelectedChipMc.m_movie.mc_base);
               Bitmap(this.DropMc.getChildAt(0)).bitmapData = Bitmap(_loc3_.getChildAt(0)).bitmapData;
               this.DropMc.visible = true;
               this.DropMc.startDrag(true);
               this.SelectedChipInfo = CmosInfo(this.ChipInfoMsg.Data[this.SelectedChipMc.Data]);
            }
         }
      }
      
      private function DropMcUp(param1:MouseEvent) : void
      {
         var _loc6_:MovieClip = null;
         var _loc7_:int = 0;
         var _loc8_:MovieClip = null;
         this.DropMc.visible = false;
         this.DropMc.stopDrag();
         var _loc2_:Point = new Point(param1.stageX,param1.stageY);
         var _loc3_:Point = this.ChipMc.globalToLocal(_loc2_);
         var _loc4_:int = -1;
         var _loc5_:int = 0;
         while(_loc5_ < 30)
         {
            _loc6_ = this.ChipMc.getChildByName("mc_list" + _loc5_) as MovieClip;
            if(_loc3_.x > _loc6_.x && _loc3_.y > _loc6_.y && _loc3_.x < _loc6_.x + 50 && _loc3_.y < _loc6_.y + 50)
            {
               _loc4_ = _loc5_;
               break;
            }
            _loc5_++;
         }
         if(_loc4_ < 0)
         {
            if(this.SelectedCommanderId >= 0)
            {
               _loc4_ = -1;
               _loc3_ = this.CommandMc.globalToLocal(_loc2_);
               _loc7_ = 0;
               while(_loc7_ < 5)
               {
                  _loc8_ = this.CommandMc.getChildByName("mc_list" + _loc7_) as MovieClip;
                  if(_loc3_.x > _loc8_.x && _loc3_.y > _loc8_.y && _loc3_.x < _loc8_.x + 50 && _loc3_.y < _loc8_.y + 50)
                  {
                     _loc4_ = _loc7_;
                     break;
                  }
                  _loc7_++;
               }
               if(_loc4_ >= 0)
               {
                  if(this.SelectedChipInfo.PropsId == this.RubbishId)
                  {
                     MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("Boss50"),0);
                     return;
                  }
                  if(this.SelectedChipInfo.PropsId == this.WisdomId)
                  {
                     MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("Boss51"),0);
                     return;
                  }
                  this.SetChip(_loc4_,this.SelectedChipMc.Data);
               }
            }
         }
      }
      
      private function SetChip(param1:int, param2:int) : void
      {
         var _loc3_:int = 0;
         if(this.CommanderInfoMsg.commander_state >= 3)
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("Boss88"),1);
            return;
         }
         if(this.CommanderInfoMsg.ChipList[param1] > 0)
         {
            this.RequestSetChip(param1,0,1);
            ChipLottery.LockList.push(this.ChipInfoMsg.DataLen - 1);
         }
         if(this.RequestSetChip(param1,param2,0))
         {
            _loc3_ = 0;
            while(_loc3_ < ChipLottery.LockList.length)
            {
               if(ChipLottery.LockList[_loc3_] > param2)
               {
                  --ChipLottery.LockList[_loc3_];
               }
               _loc3_++;
            }
            this.RequestChipList();
         }
      }
      
      private function RequestSetChip(param1:int, param2:int, param3:int) : Boolean
      {
         var _loc4_:propsInfo = null;
         var _loc5_:int = 0;
         if(param3 == 0)
         {
            _loc4_ = CPropsReader.getInstance().GetPropsInfo(this.SelectedChipInfo.PropsId);
            _loc5_ = int(this.GroupIdList.indexOf(_loc4_.GroupId));
            if(_loc5_ >= 0 && _loc5_ != param1)
            {
               MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("Boss55"),0);
               return false;
            }
         }
         ++this.RequestCount;
         this.SetEnable(false);
         if(this.SetChipMsg == null)
         {
            this.SetChipMsg = new MSG_REQUEST_COMMANDERINSERTCMOS();
         }
         this.SetChipMsg.Type = param3;
         this.SetChipMsg.CommanderId = this.SelectedCommanderId;
         this.SetChipMsg.HoleId = param1;
         this.SetChipMsg.CmosId = param2;
         this.SetChipMsg.SeqId = GamePlayer.getInstance().seqID++;
         this.SetChipMsg.Guid = GamePlayer.getInstance().Guid;
         NetManager.Instance().sendObject(this.SetChipMsg);
         if(param3 == 0 && ChipLottery.LockList.indexOf(param2) >= 0)
         {
            this.ChangeLockStatus(param2);
         }
         return true;
      }
      
      public function Resp_MSG_RESP_COMMANDERINSERTCMOS(param1:MSG_RESP_COMMANDERINSERTCMOS) : void
      {
         var _loc2_:propsInfo = null;
         if(this.RequestCount > 0)
         {
            --this.RequestCount;
            if(this.RequestCount == 0)
            {
               this.SetEnable(true);
            }
         }
         if(this.SelectedCommanderId != param1.CommanderId)
         {
            return;
         }
         if(param1.HoleId < 0)
         {
            return;
         }
         if(param1.Type == 0)
         {
            this.CommanderInfoMsg.ChipList[param1.HoleId] = this.SelectedChipInfo.PropsId;
            this.CommanderInfoMsg.ChipExpList[param1.HoleId] = this.SelectedChipInfo.Exp;
            _loc2_ = CPropsReader.getInstance().GetPropsInfo(this.SelectedChipInfo.PropsId);
            this.GroupIdList[param1.HoleId] = _loc2_.GroupId;
         }
         else
         {
            this.GroupIdList[param1.HoleId] = -1;
            this.CommanderInfoMsg.ChipList[param1.HoleId] = -1;
            this.CommanderInfoMsg.ChipExpList[param1.HoleId] = 0;
         }
         this.ShowCommanderInfo();
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
         ChipLottery.ResetLockList(param1);
      }
      
      private function mc_explainClick(param1:MouseEvent) : void
      {
         this.mc_explain.gotoAndStop(this.mc_explain.currentFrame % 2 + 1);
      }
      
      private function btn_rightClick(param1:MouseEvent) : void
      {
         ++this.CommanderPageId;
         this.ShowCommanderList();
      }
      
      private function btn_leftClick(param1:MouseEvent) : void
      {
         --this.CommanderPageId;
         this.ShowCommanderList();
      }
      
      private function CommanderOver(param1:MouseEvent, param2:XMovieClip) : void
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
      
      private function CommanderOut(param1:MouseEvent) : void
      {
         CommanderInfoTip.GetInstance().Hide();
      }
      
      private function CommanderClick(param1:MouseEvent, param2:XMovieClip) : void
      {
         var _loc3_:int = this.CommanderPageId * this.CommanderPageItemCount + param2.Data;
         if(_loc3_ >= CommanderRouter.instance.m_commandInfoAry.length)
         {
            return;
         }
         if(this.SelectedCommander != null)
         {
            this.SelectedCommander.m_movie.gotoAndStop(1);
         }
         this.SelectedCommander = param2;
         this.SelectedCommander.m_movie.gotoAndStop(2);
         this.SelectedCommanderIndex = _loc3_;
         this.SelectedCommanderId = CommanderRouter.instance.m_commandInfoAry[this.SelectedCommanderIndex].commander_commanderId;
         this.RequestCommanderInfo();
      }
      
      private function RequestCommanderInfo() : void
      {
         if(this.SelectedCommanderId == -1)
         {
            return;
         }
         var _loc1_:MSG_REQUEST_COMMANDERINFO = new MSG_REQUEST_COMMANDERINFO();
         _loc1_.ShowType = 3;
         _loc1_.CommanderId = this.SelectedCommanderId;
         _loc1_.SeqId = GamePlayer.getInstance().seqID++;
         _loc1_.Guid = GamePlayer.getInstance().Guid;
         NetManager.Instance().sendObject(_loc1_);
      }
      
      public function RespCommanderInfo(param1:CommanderInfo) : void
      {
         if(this.SelectedCommanderId != param1.commander_commanderId)
         {
            return;
         }
         this.CommanderInfoMsg = param1;
         this.ShowCommanderInfo();
      }
      
      private function ShowCommanderInfo() : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:Sprite = null;
         var _loc4_:int = 0;
         var _loc5_:Bitmap = null;
         var _loc6_:propsInfo = null;
         var _loc7_:BitmapData = null;
         var _loc8_:Number = NaN;
         this.GroupIdList.splice(0);
         var _loc1_:int = 0;
         while(_loc1_ < 5)
         {
            _loc2_ = this.CommandMc.getChildByName("mc_list" + _loc1_) as MovieClip;
            _loc2_.gotoAndStop(2);
            _loc3_ = Sprite(_loc2_.mc_base);
            if(_loc3_.numChildren > 0)
            {
               _loc3_.removeChildAt(0);
            }
            _loc4_ = int(this.CommanderInfoMsg.ChipList[_loc1_]);
            _loc5_ = Bitmap(Sprite(this.CommandMc.getChildByName("mc_pic" + _loc1_)).getChildAt(0));
            if(_loc4_ > 0)
            {
               _loc6_ = CPropsReader.getInstance().GetPropsInfo(_loc4_);
               this.GroupIdList.push(_loc6_.GroupId);
               _loc7_ = GameKernel.getTextureInstance(_loc6_.ImageFileName);
               _loc3_.addChildAt(new Bitmap(_loc7_),0);
               MovieClip(_loc2_.getChildByName("btn_excision0")).visible = true;
               _loc5_.bitmapData = _loc7_;
               _loc5_.width = 20;
               _loc5_.height = 20;
               _loc8_ = _loc6_.ChipValue;
               if(_loc8_ < 1)
               {
                  TextField(this.CommandMc.getChildByName("txt_plus" + _loc1_)).text = "+" + Number(_loc8_ * 100) + "%";
               }
               else
               {
                  TextField(this.CommandMc.getChildByName("txt_plus" + _loc1_)).text = "+" + _loc8_;
               }
            }
            else
            {
               TextField(this.CommandMc.getChildByName("txt_plus" + _loc1_)).text = "+0";
               _loc5_.bitmapData = null;
               this.GroupIdList.push(-1);
               MovieClip(_loc2_.getChildByName("btn_excision0")).visible = false;
            }
            _loc1_++;
         }
      }
      
      private function CommanderChipOut(param1:MouseEvent) : void
      {
         CommanderChipTip.Hide();
      }
      
      private function CommanderChipOver(param1:Event, param2:XMovieClip) : void
      {
         if(this.SelectedCommanderId < 0)
         {
            return;
         }
         if(this.CommanderInfoMsg.ChipList[param2.Data] < 0)
         {
            return;
         }
         var _loc3_:CmosInfo = new CmosInfo();
         _loc3_.Exp = this.CommanderInfoMsg.ChipExpList[param2.Data];
         _loc3_.PropsId = this.CommanderInfoMsg.ChipList[param2.Data];
         CommanderChipTip.Show(param2.m_movie,_loc3_);
      }
      
      private function btn_excisionClick(param1:Event, param2:XButton) : void
      {
         if(this.CommanderInfoMsg.commander_state >= 3)
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("Boss88"),1);
            return;
         }
         if(this.CommanderInfoMsg.ChipList[param2.Data] > 0)
         {
            if(this.ChipInfoMsg.CmosPackCount <= this.ChipInfoMsg.DataLen)
            {
               MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("Boss56"),0);
               return;
            }
            this.RequestSetChip(param2.Data,0,1);
            ChipLottery.LockList.push(this.ChipInfoMsg.DataLen);
         }
         this.RequestChipList();
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
   }
}

