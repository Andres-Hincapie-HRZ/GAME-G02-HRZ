package logic.ui
{
   import com.star.frameworks.managers.StringManager;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.utils.setTimeout;
   import logic.entry.FlagShip;
   import logic.entry.FlagShipPart;
   import logic.entry.GamePlayer;
   import logic.entry.HButton;
   import logic.entry.ScienceSystem;
   import logic.entry.props.PackPropsInfo;
   import logic.entry.props.propsInfo;
   import logic.game.GameKernel;
   import logic.reader.CPropsReader;
   import logic.reader.FlagShipReader;
   import logic.utils.UpdateResource;
   import net.base.NetManager;
   import net.msg.FlagShip.MSG_REQUEST_UNIONFLAGSHIP;
   import net.msg.FlagShip.MSG_RESP_UNIONFLAGSHIP;
   
   public class ComposeUI_FlagShip
   {
      
      private static var instance:ComposeUI_FlagShip;
      
      private var BaseMc:MovieClip;
      
      private var FlagShipMc:MovieClip;
      
      private var mc_merge:HButton;
      
      private var ShipPartMcList:Array;
      
      private var tf_page:TextField;
      
      private var btn_left:HButton;
      
      private var btn_right:HButton;
      
      private var SelectedFlagShip:FlagShip;
      
      private var FlashShipList:Array;
      
      private var PageId:int;
      
      private var OverShip:MovieClip;
      
      private var SelectedShipMc:MovieClip;
      
      private var ShipPartArray:Array;
      
      private var _PropsTip:MovieClip;
      
      private var PageCount:int;
      
      private var mc_action0:MovieClip;
      
      private var mc_action1:MovieClip;
      
      private var CanReset:Boolean;
      
      private var mc_explain:MovieClip;
      
      public function ComposeUI_FlagShip()
      {
         super();
      }
      
      public static function GetInstance() : ComposeUI_FlagShip
      {
         if(!instance)
         {
            instance = new ComposeUI_FlagShip();
         }
         return instance;
      }
      
      public function Init(param1:MovieClip) : void
      {
         this.BaseMc = param1;
         this.FlagShipMc = param1.getChildByName("mc_qijianmerge") as MovieClip;
         this.mc_merge = new HButton(this.FlagShipMc.mc_merge);
         this.mc_merge.m_movie.addEventListener(MouseEvent.CLICK,this.mc_mergeClick);
         this.InitFlagShip();
         this.InitShipPart();
         this.mc_action0 = this.FlagShipMc.getChildByName("mc_action0") as MovieClip;
         this.mc_action1 = this.FlagShipMc.getChildByName("mc_action1") as MovieClip;
         this.mc_explain = this.FlagShipMc.getChildByName("mc_explain") as MovieClip;
         this.mc_explain.addEventListener(MouseEvent.CLICK,this.mc_explainClick);
      }
      
      private function mc_explainClick(param1:MouseEvent) : void
      {
         this.mc_explain.gotoAndStop(this.mc_explain.currentFrame % 2 + 1);
      }
      
      public function Stop() : void
      {
         this.mc_action0.stop();
         this.mc_action1.stop();
      }
      
      public function Clear(param1:Boolean = true) : void
      {
         var _loc2_:Sprite = null;
         var _loc3_:XMovieClip = null;
         this.mc_action0.play();
         this.mc_action1.play();
         this.BaseMc.mouseEnabled = true;
         this.BaseMc.mouseChildren = true;
         if(param1)
         {
            this.SelectedShipMc = null;
            this.SelectedFlagShip = null;
            this.PageId = 0;
         }
         this.OverShip = null;
         for each(_loc3_ in this.ShipPartMcList)
         {
            _loc2_ = Sprite(_loc3_.m_movie.mc_base);
            if(_loc2_.numChildren > 0)
            {
               _loc2_.removeChildAt(0);
            }
            TextField(_loc3_.m_movie.txt_num).text = "";
            _loc3_.m_movie.gotoAndStop(1);
         }
         this.InitShipPartArray();
         this.ShowFlagShipList();
         this.mc_merge.setBtnDisabled(true);
         TextField(this.FlagShipMc.tf_consum).text = "";
         TextField(this.FlagShipMc.tf_belong).text = GamePlayer.getInstance().UserMoney.toString();
      }
      
      private function SelectedShipOut(param1:MouseEvent) : void
      {
         if(this._PropsTip != null && this.FlagShipMc.contains(this._PropsTip))
         {
            this.FlagShipMc.removeChild(this._PropsTip);
         }
      }
      
      private function SelectedShipOver(param1:MouseEvent) : void
      {
         if(this.SelectedFlagShip == null)
         {
            return;
         }
         this.ShowPartTip(MovieClip(this.FlagShipMc.mc_mergelist5),this.SelectedFlagShip.PropsId);
      }
      
      private function InitFlagShip() : void
      {
         var _loc3_:XMovieClip = null;
         var _loc1_:int = 0;
         while(_loc1_ < 5)
         {
            _loc3_ = new XMovieClip(this.FlagShipMc.getChildByName("mc_bluelist" + _loc1_) as MovieClip);
            _loc3_.Data = _loc1_;
            _loc3_.OnMouseOver = this.FlagShipOver;
            _loc3_.OnClick = this.FlagShipClick;
            _loc3_.m_movie.addEventListener(MouseEvent.MOUSE_OUT,this.FlagShipOut);
            _loc3_.m_movie.gotoAndStop(1);
            _loc1_++;
         }
         this.tf_page = this.FlagShipMc.getChildByName("tf_page") as TextField;
         this.btn_left = new HButton(this.FlagShipMc.getChildByName("btn_left") as MovieClip);
         this.btn_left.m_movie.addEventListener(MouseEvent.CLICK,this.btn_leftClick);
         this.btn_right = new HButton(this.FlagShipMc.getChildByName("btn_right") as MovieClip);
         this.btn_right.m_movie.addEventListener(MouseEvent.CLICK,this.btn_rightClick);
         this.FlashShipList = FlagShipReader.getInstance().GetFlagShip();
         this.PageCount = Math.ceil(this.FlashShipList.length / 5);
         var _loc2_:Sprite = Sprite(this.FlagShipMc.mc_mergelist5);
         _loc2_.addChildAt(new Bitmap(),0);
         _loc2_.addEventListener(MouseEvent.MOUSE_OVER,this.SelectedShipOver);
         _loc2_.addEventListener(MouseEvent.MOUSE_OUT,this.SelectedShipOut);
      }
      
      private function FlagShipOut(param1:MouseEvent) : void
      {
         if(this.OverShip != null && this.OverShip != this.SelectedShipMc)
         {
            this.OverShip.gotoAndStop(1);
            this.OverShip = null;
         }
         if(this._PropsTip != null && this.FlagShipMc.contains(this._PropsTip))
         {
            this.FlagShipMc.removeChild(this._PropsTip);
         }
      }
      
      private function FlagShipOver(param1:MouseEvent, param2:XMovieClip) : void
      {
         if(this.OverShip != null && this.OverShip != this.SelectedShipMc)
         {
            this.OverShip.gotoAndStop(1);
         }
         this.OverShip = param2.m_movie;
         this.OverShip.gotoAndStop(2);
         var _loc3_:FlagShip = this.FlashShipList[this.PageId * 5 + param2.Data];
         this.ShowPartTip(param2.m_movie,_loc3_.PropsId);
      }
      
      private function FlagShipClick(param1:MouseEvent, param2:XMovieClip) : void
      {
         if(this.SelectedShipMc != null)
         {
            this.SelectedShipMc.gotoAndStop(1);
         }
         this.SelectedShipMc = param2.m_movie;
         this.SelectedShipMc.gotoAndStop(2);
         this.SelectedFlagShip = this.FlashShipList[this.PageId * 5 + param2.Data];
         this.ShowFlagShip();
      }
      
      private function ShowFlagShipList() : void
      {
         var _loc3_:MovieClip = null;
         var _loc4_:FlagShip = null;
         var _loc5_:Sprite = null;
         var _loc1_:int = this.PageId * 5;
         var _loc2_:int = 0;
         while(_loc2_ < 5)
         {
            _loc3_ = this.FlagShipMc.getChildByName("mc_bluelist" + _loc2_) as MovieClip;
            _loc3_.gotoAndStop(1);
            if(_loc1_ < this.FlashShipList.length)
            {
               _loc3_.visible = true;
               _loc4_ = this.FlashShipList[_loc1_];
               _loc5_ = _loc3_.getChildByName("mc_base") as Sprite;
               if(_loc5_.numChildren > 0)
               {
                  _loc5_.removeChildAt(0);
               }
               if(_loc4_.PropsId == -1)
               {
                  _loc5_.addChildAt(new Bitmap(GameKernel.getTextureInstance("random")),0);
                  TextField(_loc3_.txt_num).text = "";
                  TextField(_loc3_.txt_name).text = StringManager.getInstance().getMessageString("Boss74");
               }
               else
               {
                  _loc5_.addChildAt(new Bitmap(GameKernel.getTextureInstance(_loc4_.PropsInfo.ImageFileName)),0);
                  TextField(_loc3_.txt_num).text = this.GerFlagShipNum(_loc4_.PropsId).toString();
                  TextField(_loc3_.txt_name).text = _loc4_.PropsInfo.Name;
               }
               if(_loc4_ == this.SelectedFlagShip)
               {
                  _loc3_.gotoAndStop(2);
               }
            }
            else
            {
               _loc3_.visible = false;
            }
            _loc1_++;
            _loc2_++;
         }
         this.ResetPageButton();
      }
      
      private function GerFlagShipNum(param1:int) : int
      {
         var _loc2_:Array = ScienceSystem.getinstance().Packarr;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length)
         {
            if(_loc2_[_loc3_].PropsId == param1)
            {
               return _loc2_[_loc3_].PropsNum;
            }
            _loc3_++;
         }
         return 0;
      }
      
      private function ResetPageButton() : void
      {
         this.btn_left.setBtnDisabled(this.PageId == 0);
         this.btn_right.setBtnDisabled(this.PageId + 1 >= this.PageCount);
         this.tf_page.text = this.PageId + 1 + "/" + this.PageCount;
      }
      
      private function btn_leftClick(param1:MouseEvent) : void
      {
         --this.PageId;
         this.ShowFlagShipList();
      }
      
      private function btn_rightClick(param1:MouseEvent) : void
      {
         ++this.PageId;
         this.ShowFlagShipList();
      }
      
      private function ShowFlagShip() : void
      {
         var _loc4_:XMovieClip = null;
         var _loc5_:Sprite = null;
         var _loc6_:FlagShipPart = null;
         var _loc7_:int = 0;
         var _loc1_:* = true;
         var _loc2_:int = 0;
         while(_loc2_ < this.ShipPartMcList.length)
         {
            _loc4_ = this.ShipPartMcList[_loc2_];
            _loc5_ = Sprite(_loc4_.m_movie.mc_base);
            if(_loc5_.numChildren > 0)
            {
               _loc5_.removeChildAt(0);
            }
            _loc6_ = this.SelectedFlagShip.NeedParts[_loc2_];
            if(_loc6_ != null)
            {
               _loc4_.m_movie.gotoAndStop(2);
               _loc5_.addChildAt(new Bitmap(GameKernel.getTextureInstance(_loc6_.PropsInfo.ImageFileName)),0);
               _loc7_ = this.GerPartCount(_loc6_.PropsInfo.Id);
               TextField(_loc4_.m_movie.txt_num).text = _loc7_ + "/" + _loc6_.Num;
               TextField(_loc4_.m_movie.txt_num).textColor = _loc7_ >= _loc6_.Num ? 65280 : 16711680;
               _loc1_ &&= _loc7_ >= _loc6_.Num;
            }
            else
            {
               TextField(_loc4_.m_movie.txt_num).text = "";
               _loc4_.m_movie.gotoAndStop(1);
            }
            _loc2_++;
         }
         if(_loc1_)
         {
            _loc1_ = GamePlayer.getInstance().UserMoney >= this.SelectedFlagShip.NeedMoney;
         }
         this.mc_merge.setBtnDisabled(!_loc1_);
         this.CanReset = false;
         var _loc3_:Sprite = Sprite(this.FlagShipMc.mc_mergelist5);
         Bitmap(_loc3_.getChildAt(0)).bitmapData = Bitmap(Sprite(this.SelectedShipMc.mc_base).getChildAt(0)).bitmapData;
         TextField(this.FlagShipMc.tf_consum).text = this.SelectedFlagShip.NeedMoney.toString();
      }
      
      private function GerPartCount(param1:int) : int
      {
         var _loc2_:PackPropsInfo = null;
         for each(_loc2_ in this.ShipPartArray)
         {
            if(_loc2_._PropsInfo.Id == param1)
            {
               return _loc2_.Num;
            }
         }
         return 0;
      }
      
      private function InitShipPartArray() : void
      {
         var _loc3_:propsInfo = null;
         var _loc4_:PackPropsInfo = null;
         this.ShipPartArray = new Array();
         var _loc1_:Array = ScienceSystem.getinstance().Packarr;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_.length)
         {
            if(_loc1_[_loc2_].LockFlag == 1)
            {
               _loc3_ = CPropsReader.getInstance().GetPropsInfo(_loc1_[_loc2_].PropsId);
               if(_loc3_.List == 34)
               {
                  _loc4_ = new PackPropsInfo();
                  _loc4_._PropsInfo = _loc3_;
                  _loc4_.Num = _loc1_[_loc2_].PropsNum;
                  this.ShipPartArray.push(_loc4_);
               }
            }
            _loc2_++;
         }
      }
      
      private function InitShipPart() : void
      {
         var _loc2_:XMovieClip = null;
         this.ShipPartMcList = new Array();
         var _loc1_:int = 0;
         while(_loc1_ < 5)
         {
            _loc2_ = new XMovieClip(this.FlagShipMc.getChildByName("mc_mergelist" + _loc1_) as MovieClip);
            _loc2_.Data = _loc1_;
            _loc2_.OnMouseOver = this.PartOver;
            _loc2_.m_movie.addEventListener(MouseEvent.MOUSE_OUT,this.PartOut);
            _loc2_.m_movie.gotoAndStop(1);
            this.ShipPartMcList.push(_loc2_);
            _loc1_++;
         }
      }
      
      private function PartOut(param1:MouseEvent) : void
      {
         if(this._PropsTip != null && this.FlagShipMc.contains(this._PropsTip))
         {
            this.FlagShipMc.removeChild(this._PropsTip);
         }
      }
      
      private function PartOver(param1:MouseEvent, param2:XMovieClip) : void
      {
         if(this.SelectedFlagShip == null)
         {
            return;
         }
         var _loc3_:FlagShipPart = this.SelectedFlagShip.NeedParts[param2.Data];
         if(_loc3_ == null)
         {
            return;
         }
         this.ShowPartTip(param2.m_movie,_loc3_.PropsId);
      }
      
      private function ShowPartTip(param1:MovieClip, param2:int) : void
      {
         if(param2 < 0)
         {
            return;
         }
         var _loc3_:Point = param1.localToGlobal(new Point(0,param1.height));
         _loc3_ = this.FlagShipMc.globalToLocal(_loc3_);
         this._PropsTip = PackUi.getInstance().TipHd(_loc3_.x,_loc3_.y,param2,true);
         this._PropsTip.x = _loc3_.x - 80;
         this._PropsTip.y = _loc3_.y;
         this.FlagShipMc.addChild(this._PropsTip);
      }
      
      private function mc_mergeClick(param1:MouseEvent) : void
      {
         var _loc2_:int = UpdateResource.getInstance().HasPackSpace(this.SelectedFlagShip.PropsId,0);
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
         var _loc3_:MSG_REQUEST_UNIONFLAGSHIP = new MSG_REQUEST_UNIONFLAGSHIP();
         _loc3_.PropsId = this.SelectedFlagShip.PropsId;
         _loc3_.SeqId = GamePlayer.getInstance().seqID++;
         _loc3_.Guid = GamePlayer.getInstance().Guid;
         NetManager.Instance().sendObject(_loc3_);
         this.BaseMc.mouseEnabled = false;
         this.BaseMc.mouseChildren = false;
      }
      
      public function Resp_MSG_RESP_UNIONFLAGSHIP(param1:MSG_RESP_UNIONFLAGSHIP) : void
      {
         var _loc3_:FlagShip = null;
         var _loc4_:FlagShipPart = null;
         var _loc2_:int = param1.PropsId;
         if(this.SelectedFlagShip != null && this.SelectedFlagShip.PropsId == -1)
         {
            _loc2_ = -1;
         }
         for each(_loc3_ in this.FlashShipList)
         {
            if(_loc3_.PropsId == _loc2_)
            {
               for each(_loc4_ in _loc3_.NeedParts)
               {
                  UpdateResource.getInstance().DeleteProps(_loc4_.PropsId,1,_loc4_.Num);
               }
               break;
            }
         }
         GamePlayer.getInstance().UserMoney = GamePlayer.getInstance().UserMoney - this.SelectedFlagShip.NeedMoney;
         ResPlaneUI.getInstance().updateResPlane();
         UpdateResource.getInstance().AddToPack(param1.PropsId,1,0);
         this.Clear(false);
         this.ShowFlagShip();
         ResPlaneUI.getInstance().PlayReward(param1.PropsId,Sprite(this.FlagShipMc.mc_mergelist5));
         if(this.mc_merge.m_movie.mouseEnabled == true)
         {
            this.CanReset = true;
            this.mc_merge.setBtnDisabled(true);
            setTimeout(this.ResetMergeButton,1000);
         }
      }
      
      private function ResetMergeButton() : void
      {
         if(this.CanReset)
         {
            this.mc_merge.setBtnDisabled(false);
            this.CanReset = false;
         }
      }
   }
}

