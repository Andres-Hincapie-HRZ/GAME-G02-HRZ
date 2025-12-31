package logic.ui
{
   import com.star.frameworks.managers.StringManager;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import logic.action.ConstructionAction;
   import logic.entry.DiamondInfo;
   import logic.entry.GamePlayer;
   import logic.entry.HButton;
   import logic.entry.ScienceSystem;
   import logic.entry.props.propsInfo;
   import logic.game.GameKernel;
   import logic.reader.CPropsReader;
   import logic.reader.CcorpsReader;
   import logic.utils.UpdateResource;
   import net.base.NetManager;
   import net.msg.Compose.MSG_REQUEST_COMMANDERUNIONSTONE;
   import net.msg.Compose.MSG_RESP_COMMANDERUNIONSTONE;
   
   public class ComposeUI_Diamond
   {
      
      private static var instance:ComposeUI_Diamond;
      
      private var BaseMc:MovieClip;
      
      private var ComposeBase:MovieClip;
      
      private var btn_compose:HButton;
      
      private var btn_allcompose:HButton;
      
      private var DiamondListMc:MovieClip;
      
      private var PageId:int;
      
      private var PageCount:int;
      
      private const PageItemCount:int = 35;
      
      private var SelectedDiamond:MovieClip;
      
      private var SelectedDiamondId:int;
      
      private var btn_left:HButton;
      
      private var btn_right:HButton;
      
      private var tf_page:TextField;
      
      private var ResultItem:MovieClip;
      
      private var ComposeDiamond:Object;
      
      private var _PropsTip:MovieClip;
      
      private var DiamondPack:Array;
      
      private var allcompose:Boolean;
      
      private var ComposeNum:int;
      
      public function ComposeUI_Diamond()
      {
         super();
      }
      
      public static function GetInstance() : ComposeUI_Diamond
      {
         if(!instance)
         {
            instance = new ComposeUI_Diamond();
         }
         return instance;
      }
      
      public function Init(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:XMovieClip = null;
         var _loc6_:MovieClip = null;
         var _loc7_:XButton = null;
         this.BaseMc = param1;
         this.ComposeBase = param1.mc_gem;
         _loc2_ = 0;
         while(_loc2_ < 4)
         {
            _loc4_ = this.ComposeBase.getChildByName("mc_list" + _loc2_) as MovieClip;
            _loc4_.mc_base.doubleClickEnabled = true;
            _loc4_.mc_base.addEventListener(MouseEvent.DOUBLE_CLICK,this.ItemDoubleClick);
            _loc5_ = new XMovieClip(_loc4_);
            _loc5_.OnMouseOver = this.DiamondMouseOver2;
            _loc4_.addEventListener(MouseEvent.MOUSE_OUT,this.DiamondMouseOut);
            _loc4_.stop();
            _loc2_++;
         }
         this.ResultItem = this.ComposeBase.getChildByName("mc_list4") as MovieClip;
         var _loc3_:XMovieClip = new XMovieClip(this.ResultItem);
         _loc3_.OnMouseOver = this.DiamondMouseOver3;
         this.ResultItem.addEventListener(MouseEvent.MOUSE_OUT,this.DiamondMouseOut);
         this.btn_compose = new HButton(this.ComposeBase.btn_compose);
         this.btn_compose.m_movie.addEventListener(MouseEvent.CLICK,this.btn_composeClick);
         this.btn_allcompose = new HButton(this.ComposeBase.btn_allcompose);
         this.btn_allcompose.m_movie.addEventListener(MouseEvent.CLICK,this.btn_allcomposeClick);
         this.DiamondListMc = param1.mc_card3;
         _loc2_ = 0;
         while(_loc2_ < this.PageItemCount)
         {
            _loc6_ = this.DiamondListMc.getChildByName("mc_list" + _loc2_) as MovieClip;
            _loc7_ = new XButton(_loc6_);
            _loc7_.Data = _loc2_;
            _loc7_.OnMouseOver = this.DiamondMouseOver;
            _loc7_.OnMouseDown = this.DiamondMouseDown;
            _loc7_.OnDoubleClick = this.DiamondDoubleClick;
            _loc6_.addEventListener(MouseEvent.MOUSE_OUT,this.DiamondMouseOut);
            _loc6_.addEventListener(MouseEvent.MOUSE_MOVE,this.DiamondMouseMove);
            _loc2_++;
         }
         this.btn_left = new HButton(this.DiamondListMc.btn_left);
         this.btn_left.m_movie.addEventListener(MouseEvent.CLICK,this.btn_leftClick);
         this.btn_right = new HButton(this.DiamondListMc.btn_right);
         this.btn_right.m_movie.addEventListener(MouseEvent.CLICK,this.btn_rightClick);
         this.tf_page = this.DiamondListMc.tf_page as TextField;
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
         _loc5_ = this.ComposeBase.globalToLocal(_loc5_);
         var _loc6_:int = 0;
         while(_loc6_ < 4)
         {
            _loc7_ = this.ComposeBase.getChildByName("mc_list" + _loc6_) as MovieClip;
            if(_loc5_.x >= _loc7_.x && _loc5_.x < _loc7_.x + 40 && _loc5_.y >= _loc7_.y && _loc5_.y < _loc7_.y + 40)
            {
               this.AddDiamond();
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
         this.AddDiamond();
      }
      
      private function AddDiamond() : void
      {
         var _loc3_:DisplayObject = null;
         var _loc4_:MovieClip = null;
         var _loc7_:MovieClip = null;
         var _loc8_:Bitmap = null;
         if(this.SelectedDiamondId < 0 || this.SelectedDiamondId >= this.DiamondPack.length)
         {
            return;
         }
         var _loc1_:Object = this.DiamondPack[this.SelectedDiamondId];
         var _loc2_:DiamondInfo = _loc1_.aDiamondInfo;
         if(_loc1_.num < 4)
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("CommanderText127"),0);
            this.ClearComposeItem();
            this.ShowDiamond();
            return;
         }
         this.ClearComposeItem();
         var _loc5_:int = 0;
         while(_loc5_ < 4)
         {
            _loc7_ = this.ComposeBase.getChildByName("mc_list" + _loc5_) as MovieClip;
            _loc7_.gotoAndStop(3);
            _loc8_ = new Bitmap(GameKernel.getTextureInstance(_loc2_.PropsInfo.ImageFileName));
            _loc8_.x = 0;
            _loc8_.y = 0;
            _loc7_.mc_base.addChild(_loc8_);
            _loc3_ = _loc7_.mc_lock as DisplayObject;
            _loc3_.visible = _loc1_.LockFlag == 1;
            _loc4_ = this.ComposeBase.getChildByName("mc_line" + _loc5_) as MovieClip;
            _loc4_.gotoAndStop(2);
            _loc5_++;
         }
         _loc2_ = CPropsReader.getInstance().GetDiamond(_loc2_.PropsId + 1);
         var _loc6_:Bitmap = new Bitmap(GameKernel.getTextureInstance(_loc2_.PropsInfo.ImageFileName));
         _loc6_.x = 0;
         _loc6_.y = 0;
         this.ResultItem.mc_base1.addChild(_loc6_);
         this.ResultItem.gotoAndStop(2);
         _loc4_ = this.ComposeBase.getChildByName("mc_line4") as MovieClip;
         _loc4_.gotoAndStop(2);
         _loc3_ = this.ResultItem.mc_lock as DisplayObject;
         _loc3_.visible = _loc1_.LockFlag == 1;
         this.btn_compose.setBtnDisabled(false);
         this.btn_allcompose.setBtnDisabled(false);
         this.ResetComposeDiamond();
      }
      
      private function ResetComposeDiamond() : void
      {
         var _loc1_:Object = this.DiamondPack[this.SelectedDiamondId];
         this.ComposeDiamond = _loc1_;
         this.ComposeDiamond.num -= 4;
         if(this.ComposeDiamond.num <= 0)
         {
            this.DiamondPack.splice(this.SelectedDiamondId,1);
         }
         this.ShowDiamond();
      }
      
      private function ClearComposeItem() : void
      {
         var _loc1_:DisplayObject = null;
         var _loc4_:int = 0;
         var _loc5_:MovieClip = null;
         var _loc6_:MovieClip = null;
         var _loc7_:MovieClip = null;
         if(this.ComposeDiamond != null)
         {
            this.InitDiamondPack();
         }
         var _loc2_:int = 0;
         while(_loc2_ < 4)
         {
            _loc5_ = this.ComposeBase.getChildByName("mc_list" + _loc2_) as MovieClip;
            _loc5_.gotoAndStop(2);
            _loc6_ = _loc5_.mc_base as MovieClip;
            if(_loc6_.numChildren > 1)
            {
               _loc6_.removeChildAt(1);
            }
            _loc1_ = _loc5_.mc_lock as DisplayObject;
            _loc1_.visible = false;
            _loc2_++;
         }
         var _loc3_:MovieClip = this.ComposeBase.getChildByName("mc_list4") as MovieClip;
         if(_loc3_.mc_base1.numChildren > 1)
         {
            _loc3_.mc_base1.removeChildAt(1);
         }
         _loc3_.gotoAndStop(1);
         _loc1_ = _loc3_.mc_lock as DisplayObject;
         _loc1_.visible = false;
         while(_loc4_ < 5)
         {
            _loc7_ = this.ComposeBase.getChildByName("mc_line" + _loc4_) as MovieClip;
            _loc7_.gotoAndStop(1);
            _loc4_++;
         }
         this.btn_compose.setBtnDisabled(true);
         this.btn_allcompose.setBtnDisabled(true);
      }
      
      public function Clear() : void
      {
         this.ComposeDiamond = null;
         this.ClearComposeItem();
         this.ShowMoney();
         this.InitDiamondPack();
         this.PageId = 0;
         this.ShowDiamond();
         this.BaseMc.mouseEnabled = true;
         this.BaseMc.mouseChildren = true;
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
                  if(_loc4_.GemLevel < 4)
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
            if(_loc1_ < this.DiamondPack.length)
            {
               _loc7_ = this.DiamondPack[_loc1_];
               _loc8_ = _loc7_.aDiamondInfo;
               _loc9_ = new Bitmap(GameKernel.getTextureInstance(_loc8_.PropsInfo.ImageFileName));
               _loc4_.addChild(_loc9_);
               _loc5_.text = _loc7_.num.toString();
               _loc6_.visible = _loc7_.LockFlag == 1;
            }
            else
            {
               _loc6_.visible = false;
               _loc5_.text = "";
            }
            _loc1_++;
            _loc2_++;
         }
         this.ResetPageButton();
      }
      
      private function ResetPageButton() : void
      {
         this.btn_left.setBtnDisabled(this.PageId == 0);
         this.btn_right.setBtnDisabled(this.PageId + 1 >= this.PageCount);
         if(this.PageCount == 0)
         {
            this.tf_page.text = "";
         }
         else
         {
            this.tf_page.text = this.PageId + 1 + "/" + this.PageCount;
         }
      }
      
      private function ShowMoney() : void
      {
         var _loc2_:XML = null;
         TextField(this.ComposeBase.tf_nowcash).text = GamePlayer.getInstance().cash.toString();
         TextField(this.ComposeBase.tf_nowgold).text = GamePlayer.getInstance().UserMoney.toString();
         var _loc1_:TextField = this.ComposeBase.tf_needgold as TextField;
         _loc1_.text = GamePlayer.getInstance().Commander_CardUnion.toString();
         if(GamePlayer.getInstance().UserMoney < GamePlayer.getInstance().Commander_CardUnion)
         {
            _loc1_.textColor = 16711680;
         }
         else
         {
            _loc1_.textColor = 65280;
         }
         if(GamePlayer.getInstance().ConsortiaUnionLevel >= 0 && GamePlayer.getInstance().ConsortiaThrowValue >= GamePlayer.getInstance().ConsortiaUnionValue)
         {
            _loc2_ = CcorpsReader.getInstance().GetComposeUpgradeInfo(GamePlayer.getInstance().ConsortiaUnionLevel);
            TextField(this.ComposeBase.tf_advance).text = _loc2_.@Odds + "%";
         }
         else
         {
            TextField(this.ComposeBase.tf_advance).text = "0%";
         }
         TextField(this.ComposeBase.tf_rate).text = "100%";
      }
      
      private function ItemDoubleClick(param1:MouseEvent) : void
      {
         this.ClearComposeItem();
         this.ComposeDiamond = null;
         this.InitDiamondPack();
         this.ShowDiamond();
      }
      
      private function DiamondMouseOver2(param1:MouseEvent, param2:XMovieClip) : void
      {
         if(this.ComposeDiamond == null)
         {
            return;
         }
         var _loc3_:Object = this.ComposeDiamond;
         var _loc4_:DiamondInfo = _loc3_.aDiamondInfo;
         this.ShowDiamondTip(param2.m_movie,_loc3_.PropsId);
      }
      
      private function DiamondMouseOver3(param1:MouseEvent, param2:XMovieClip) : void
      {
         if(this.ComposeDiamond == null)
         {
            return;
         }
         var _loc3_:Object = this.ComposeDiamond;
         var _loc4_:DiamondInfo = _loc3_.aDiamondInfo;
         this.ShowDiamondTip(param2.m_movie,_loc3_.PropsId + 1);
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
      
      private function btn_composeClick(param1:MouseEvent) : void
      {
         this.allcompose = false;
         this.Compose();
      }
      
      private function btn_allcomposeClick(param1:MouseEvent) : void
      {
         FleetNumUI.getInstance().Show(this.BaseMc,int(this.ComposeDiamond.num / 4 + 1),this.ComposeAll,StringManager.getInstance().getMessageString("CorpsText164"));
      }
      
      private function ComposeAll(param1:int) : void
      {
         var _loc2_:int = 0;
         if(param1 > 0)
         {
            _loc2_ = UpdateResource.getInstance().HasPackSpace(this.ComposeDiamond.PropsId + 1,this.ComposeDiamond.LockFlag);
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
            this.allcompose = true;
            this.ComposeNum = param1;
            this.Compose();
         }
      }
      
      private function Compose() : Boolean
      {
         if(GamePlayer.getInstance().UserMoney < GamePlayer.getInstance().Commander_CardUnion)
         {
            this.BaseMc.mouseEnabled = true;
            this.BaseMc.mouseChildren = true;
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("CorpsText165"),1);
            return false;
         }
         var _loc1_:int = UpdateResource.getInstance().HasPackSpace(this.ComposeDiamond.PropsId + 1,this.ComposeDiamond.LockFlag);
         if(_loc1_ == 1)
         {
            this.BaseMc.mouseEnabled = true;
            this.BaseMc.mouseChildren = true;
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("CommanderText12"),10);
            return false;
         }
         if(_loc1_ == 2)
         {
            this.BaseMc.mouseEnabled = true;
            this.BaseMc.mouseChildren = true;
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("BagTXT20"),0);
            return false;
         }
         var _loc2_:MSG_REQUEST_COMMANDERUNIONSTONE = new MSG_REQUEST_COMMANDERUNIONSTONE();
         _loc2_.PropsId = this.ComposeDiamond.PropsId;
         _loc2_.LockFlag = this.ComposeDiamond.LockFlag;
         _loc2_.SeqId = GamePlayer.getInstance().seqID++;
         _loc2_.Guid = GamePlayer.getInstance().Guid;
         NetManager.Instance().sendObject(_loc2_);
         this.BaseMc.mouseEnabled = false;
         this.BaseMc.mouseChildren = false;
         return true;
      }
      
      public function RespComposeMsg(param1:MSG_RESP_COMMANDERUNIONSTONE) : void
      {
         var _loc3_:int = 0;
         var _loc7_:propsInfo = null;
         UpdateResource.getInstance().AddToPack(param1.PropsId,1,param1.LockFlag);
         ConstructionAction.getInstance().costResource(0,0,GamePlayer.getInstance().Commander_CardUnion,0);
         var _loc2_:Array = ScienceSystem.getinstance().Packarr;
         _loc3_ = 0;
         while(_loc3_ < _loc2_.length)
         {
            if(ScienceSystem.getinstance().Packarr[_loc3_].StorageType == 0)
            {
               _loc7_ = CPropsReader.getInstance().GetPropsInfo(ScienceSystem.getinstance().Packarr[_loc3_].PropsId);
               if(_loc7_ != null && _loc7_.Id == this.ComposeDiamond.PropsId && ScienceSystem.getinstance().Packarr[_loc3_].LockFlag == param1.LockFlag)
               {
                  ScienceSystem.getinstance().Packarr[_loc3_].PropsNum = ScienceSystem.getinstance().Packarr[_loc3_].PropsNum - 4;
                  if(ScienceSystem.getinstance().Packarr[_loc3_].PropsNum <= 0)
                  {
                     ScienceSystem.getinstance().Packarr.splice(_loc3_,1);
                  }
                  break;
               }
            }
            _loc3_++;
         }
         var _loc4_:int = int(this.ComposeDiamond.PropsId);
         var _loc5_:int = int(this.ComposeDiamond.LockFlag);
         this.ComposeDiamond = null;
         this.InitDiamondPack();
         this.ShowDiamond();
         this.ClearComposeItem();
         var _loc6_:* = true;
         _loc3_ = 0;
         while(_loc3_ < this.DiamondPack.length)
         {
            if(this.DiamondPack[_loc3_].PropsId == _loc4_ && this.DiamondPack[_loc3_].LockFlag == _loc5_ && this.DiamondPack[_loc3_].num >= 4)
            {
               this.SelectedDiamondId = _loc3_;
               this.AddDiamond();
               if(this.allcompose)
               {
                  --this.ComposeNum;
                  if(this.ComposeNum > 0)
                  {
                     _loc6_ = !this.Compose();
                  }
                  else
                  {
                     this.allcompose = false;
                  }
               }
            }
            _loc3_++;
         }
         this.BaseMc.mouseEnabled = _loc6_;
         this.BaseMc.mouseChildren = _loc6_;
      }
      
      private function btn_leftClick(param1:Event) : void
      {
         --this.PageId;
         this.ShowDiamond();
      }
      
      private function btn_rightClick(param1:Event) : void
      {
         ++this.PageId;
         this.ShowDiamond();
      }
   }
}

