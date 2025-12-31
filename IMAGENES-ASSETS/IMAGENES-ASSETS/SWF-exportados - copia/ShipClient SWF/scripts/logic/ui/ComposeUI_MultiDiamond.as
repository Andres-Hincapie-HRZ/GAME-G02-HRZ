package logic.ui
{
   import com.star.frameworks.managers.StringManager;
   import com.star.frameworks.utils.HashSet;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import logic.action.ConstructionAction;
   import logic.entry.DiamondInfo;
   import logic.entry.GamePlayer;
   import logic.entry.HButton;
   import logic.entry.HButtonType;
   import logic.entry.ScienceSystem;
   import logic.entry.props.propsInfo;
   import logic.game.GameKernel;
   import logic.reader.CPropsReader;
   import logic.utils.UpdateResource;
   import net.base.NetManager;
   import net.msg.Compose.MSG_REQUEST_COMMANDERPROPERTYSTONE;
   import net.msg.Compose.MSG_RESP_COMMANDERPROPERTYSTONE;
   
   public class ComposeUI_MultiDiamond
   {
      
      private static var instance:ComposeUI_MultiDiamond;
      
      private var BaseMc:MovieClip;
      
      private var mc_check:MovieClip;
      
      private var mc_base:MovieClip;
      
      private var mc_b1:MovieClip;
      
      private var mc_b2:MovieClip;
      
      private var mc_b0:MovieClip;
      
      private var btn_up:HButton;
      
      private var btn_down:HButton;
      
      private var MultiDiamond:MovieClip;
      
      private var btn_merge:HButton;
      
      private var btn_up0:HButton;
      
      private var btn_down0:HButton;
      
      private const PageItemCount:int = 15;
      
      private var btn_left:HButton;
      
      private var btn_right:HButton;
      
      private var tf_page:TextField;
      
      private var mc_scroll:MovieClip;
      
      private var MultiType:int;
      
      private var ItemList:Array;
      
      private var txt_num:TextField;
      
      private var txt_gold:TextField;
      
      private var PageCount:int;
      
      private var PageId:int;
      
      private var MultiList:Array;
      
      private var DiamondList:HashSet;
      
      private var ItemListHeight:int;
      
      private var ItemHeight:int;
      
      private var ScrollHeight:int;
      
      private var ListHeight:int;
      
      private var MaxValue:int;
      
      private var mc_locate:MovieClip;
      
      private var LocateY:int;
      
      private var ScrollRect:Rectangle;
      
      private var SelectedItem:XMovieClip;
      
      private var OverItem:XMovieClip;
      
      private var SelectedGem:DiamondInfo;
      
      private var ShowGemList:Array;
      
      private var SelectedBase:XButton;
      
      private var OverBase:XButton;
      
      private var _PropsTip:MovieClip;
      
      private var ComposeList:Array;
      
      private var RemoveMap:HashSet;
      
      private var SelectedLockFlag:int;
      
      private var ComposeCount:int;
      
      private var RequestMsg:MSG_REQUEST_COMMANDERPROPERTYSTONE;
      
      private var btn_left0:HButton;
      
      private var btn_right0:HButton;
      
      private var tf_page0:TextField;
      
      private var ResultList:Array;
      
      private var ResultPageId:int;
      
      private var ResultPageCount:int;
      
      private var CompouseMoney:int = 10000;
      
      private var mc_lock:MovieClip;
      
      private var OtherLevel:int;
      
      public function ComposeUI_MultiDiamond()
      {
         super();
      }
      
      public static function GetInstance() : ComposeUI_MultiDiamond
      {
         if(!instance)
         {
            instance = new ComposeUI_MultiDiamond();
         }
         return instance;
      }
      
      public function Init(param1:MovieClip) : void
      {
         var _loc2_:XMovieClip = null;
         var _loc7_:MovieClip = null;
         var _loc8_:XButton = null;
         var _loc9_:MovieClip = null;
         var _loc10_:XButton = null;
         var _loc11_:MovieClip = null;
         this.BaseMc = param1;
         this.MultiDiamond = param1.mc_mergegem;
         this.mc_check = MovieClip(this.MultiDiamond.mc_check);
         this.mc_check.addEventListener(MouseEvent.CLICK,this.mc_checkClick);
         this.mc_base = MovieClip(this.MultiDiamond.mc_mergebase.mc_base);
         this.mc_base.addEventListener(MouseEvent.MOUSE_OVER,this.mc_baseOver);
         this.mc_base.addEventListener(MouseEvent.MOUSE_OUT,this.mc_baseOut);
         this.mc_lock = MovieClip(this.MultiDiamond.mc_mergebase.mc_lock);
         this.mc_b0 = MovieClip(this.MultiDiamond.mc_b0);
         _loc2_ = new XMovieClip(this.mc_b0);
         _loc2_.Data = 0;
         _loc2_.OnMouseOver = this.mc_bOver;
         _loc2_.OnDoubleClick = this.mc_bDoubleClick;
         _loc2_.m_movie.addEventListener(MouseEvent.MOUSE_OUT,this.mc_bOut);
         this.mc_b1 = MovieClip(this.MultiDiamond.mc_b1);
         _loc2_ = new XMovieClip(this.mc_b1);
         _loc2_.Data = 1;
         _loc2_.OnMouseOver = this.mc_bOver;
         _loc2_.OnDoubleClick = this.mc_bDoubleClick;
         _loc2_.m_movie.addEventListener(MouseEvent.MOUSE_OUT,this.mc_bOut);
         this.mc_b2 = MovieClip(this.MultiDiamond.mc_b2);
         _loc2_ = new XMovieClip(this.mc_b2);
         _loc2_.Data = 2;
         _loc2_.OnMouseOver = this.mc_bOver;
         _loc2_.OnDoubleClick = this.mc_bDoubleClick;
         _loc2_.m_movie.addEventListener(MouseEvent.MOUSE_OUT,this.mc_bOut);
         this.btn_up = new HButton(MovieClip(this.MultiDiamond.btn_up));
         this.btn_up.m_movie.addEventListener(MouseEvent.CLICK,this.btn_upClick);
         this.btn_down = new HButton(MovieClip(this.MultiDiamond.btn_down));
         this.btn_down.m_movie.addEventListener(MouseEvent.CLICK,this.btn_downClick);
         this.ScrollHeight = this.btn_down.m_movie.y - this.btn_up.m_movie.y - this.btn_down.m_movie.height * 2;
         this.ListHeight = this.btn_down.m_movie.y - this.btn_up.m_movie.y;
         this.btn_merge = new HButton(MovieClip(this.MultiDiamond.btn_merge));
         this.btn_merge.m_movie.addEventListener(MouseEvent.CLICK,this.btn_mergeClick);
         this.btn_up0 = new HButton(MovieClip(this.MultiDiamond.btn_up0));
         this.btn_up0.m_movie.addEventListener(MouseEvent.CLICK,this.btn_up0Click);
         this.btn_down0 = new HButton(MovieClip(this.MultiDiamond.btn_down0));
         this.btn_down0.m_movie.addEventListener(MouseEvent.CLICK,this.btn_down0Click);
         this.mc_scroll = this.MultiDiamond.mc_scroll;
         this.mc_scroll.addEventListener(MouseEvent.MOUSE_DOWN,this.mc_scrollDown);
         var _loc3_:int = 0;
         while(_loc3_ < this.PageItemCount)
         {
            _loc7_ = this.MultiDiamond.getChildByName("mc_list" + _loc3_) as MovieClip;
            _loc8_ = new XButton(_loc7_);
            _loc8_.Data = _loc3_;
            _loc8_.OnMouseOver = this.DiamondMouseOver;
            _loc8_.OnMouseDown = this.DiamondMouseDown;
            _loc8_.OnDoubleClick = this.DiamondDoubleClick;
            _loc7_.addEventListener(MouseEvent.MOUSE_OUT,this.DiamondMouseOut);
            _loc7_.addEventListener(MouseEvent.MOUSE_MOVE,this.DiamondMouseMove);
            _loc7_.gotoAndStop(1);
            _loc9_ = this.MultiDiamond.getChildByName("mc_list0" + _loc3_) as MovieClip;
            _loc10_ = new XButton(_loc9_);
            _loc10_.Data = _loc3_;
            _loc10_.OnMouseOver = this.DiamondMouseOver1;
            _loc10_.OnMouseDown = this.DiamondMouseDown1;
            _loc9_.addEventListener(MouseEvent.MOUSE_OUT,this.DiamondMouseOut1);
            _loc9_.gotoAndStop(1);
            _loc3_++;
         }
         this.btn_left = new HButton(MovieClip(this.MultiDiamond.btn_left));
         this.btn_left.m_movie.addEventListener(MouseEvent.CLICK,this.btn_leftClick);
         this.btn_right = new HButton(MovieClip(this.MultiDiamond.btn_right));
         this.btn_right.m_movie.addEventListener(MouseEvent.CLICK,this.btn_rightClick);
         this.tf_page = TextField(this.MultiDiamond.tf_page);
         this.btn_left0 = new HButton(MovieClip(this.MultiDiamond.btn_left0));
         this.btn_left0.m_movie.addEventListener(MouseEvent.CLICK,this.btn_left0Click);
         this.btn_right0 = new HButton(MovieClip(this.MultiDiamond.btn_right0));
         this.btn_right0.m_movie.addEventListener(MouseEvent.CLICK,this.btn_right0Click);
         this.tf_page0 = TextField(this.MultiDiamond.tf_page0);
         this.txt_num = TextField(this.MultiDiamond.txt_num);
         this.txt_num.addEventListener(Event.CHANGE,this.txt_numChange);
         this.txt_num.restrict = "0-9";
         this.txt_gold = TextField(this.MultiDiamond.txt_gold);
         this.ItemList = new Array();
         var _loc4_:int = int(CPropsReader.getInstance().MultiList4.length + CPropsReader.getInstance().MultiList3.length);
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            _loc11_ = GameKernel.getMovieClipInstance("mergelist");
            this.ItemHeight = _loc11_.height;
            _loc2_ = new XMovieClip(_loc11_);
            _loc2_.Data = _loc5_;
            _loc2_.OnMouseOver = this.ItemOver;
            _loc2_.OnClick = this.ItemDown;
            _loc2_.m_movie.addEventListener(MouseEvent.MOUSE_OUT,this.ItemOut);
            _loc11_.gotoAndStop(1);
            this.ItemList.push(_loc11_);
            _loc5_++;
         }
         var _loc6_:HButton = new HButton(MovieClip(this.MultiDiamond.btn_explain),HButtonType.SIMPLE,false,StringManager.getInstance().getMessageString("Boss124"),false,250);
         this.mc_locate = MovieClip(this.MultiDiamond.mc_locate);
         this.LocateY = this.mc_locate.y;
         this.MultiList = new Array();
         this.DiamondList = new HashSet();
         this.ScrollRect = new Rectangle();
         this.ShowGemList = new Array();
         this.RemoveMap = new HashSet();
         this.ComposeList = new Array();
         this.ResultList = new Array();
      }
      
      public function Clear() : void
      {
         this.ResultList.splice(0);
         this.ResultPageCount = 0;
         this.ResultPageId = 0;
         this.mc_b2.visible = true;
         this.ShowMultiList();
      }
      
      private function _Clear() : void
      {
         var _loc3_:MovieClip = null;
         var _loc1_:int = 0;
         while(_loc1_ < this.ItemList.length)
         {
            MovieClip(this.ItemList[_loc1_]).visible = false;
            _loc1_++;
         }
         while(this.mc_locate.numChildren > 0)
         {
            this.mc_locate.removeChildAt(0);
         }
         var _loc2_:int = 0;
         while(_loc2_ < this.PageItemCount)
         {
            _loc3_ = this.MultiDiamond.getChildByName("mc_list" + _loc2_) as MovieClip;
            if(_loc3_.numChildren > 3)
            {
               _loc3_.removeChildAt(1);
            }
            TextField(_loc3_.tf_num).text = "";
            MovieClip(_loc3_.mc_lock).visible = false;
            _loc2_++;
         }
         this.PageCount = 0;
         this.PageId = 0;
         this.RestPageButton();
         this.ClearComposeShow();
         this.SelectedItem = null;
         this.OverItem = null;
         this.SelectedGem = null;
         this.SelectedBase = null;
         this.OverBase = null;
         this.mc_locate.y = this.LocateY;
      }
      
      private function ClearComposeShow() : void
      {
         if(this.mc_base.numChildren > 1)
         {
            this.mc_base.removeChildAt(1);
         }
         if(this.mc_b0.numChildren > 2)
         {
            this.mc_b0.removeChildAt(1);
         }
         if(this.mc_b1.numChildren > 2)
         {
            this.mc_b1.removeChildAt(1);
         }
         if(this.mc_b2.numChildren > 2)
         {
            this.mc_b2.removeChildAt(1);
         }
         MovieClip(this.mc_b0.mc_lock).visible = false;
         MovieClip(this.mc_b1.mc_lock).visible = false;
         MovieClip(this.mc_b2.mc_lock).visible = false;
         this.mc_lock.visible = false;
         this.txt_num.text = "0";
         this.SelectedLockFlag = -1;
         this.OtherLevel = -1;
         this.MaxValue = 0;
         this.btn_merge.setBtnDisabled(true);
         this.ComposeCount = 0;
         this.ComposeList[0] = null;
         this.ComposeList[1] = null;
         this.ComposeList[2] = null;
      }
      
      private function RestPageButton() : void
      {
         this.btn_left.setBtnDisabled(this.PageId == 0);
         this.btn_right.setBtnDisabled(this.PageId + 1 >= this.PageCount);
         if(this.PageCount == 0)
         {
            this.tf_page.text + "0/0";
         }
         else
         {
            this.tf_page.text = this.PageId + 1 + "/" + this.PageCount;
         }
      }
      
      private function ShowMultiList() : void
      {
         this._Clear();
         this.MultiList.splice(0);
         this.ShowGemList.splice(0);
         this.DiamondList.removeAll();
         this.RemoveMap.removeAll();
         this.GetMultiList3();
         this.GetMultiList4();
         this._ShowMultiList();
         this.txt_gold.text = this.CompouseMoney.toString();
         if(GamePlayer.getInstance().UserMoney < this.CompouseMoney)
         {
            this.txt_gold.textColor = 16711680;
         }
         else
         {
            this.txt_gold.textColor = 65280;
         }
         this.ShowResultList();
         this.RestResultButton();
      }
      
      private function _ShowMultiList() : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:Object = null;
         var _loc1_:int = 0;
         while(_loc1_ < this.ItemList.length)
         {
            _loc2_ = this.ItemList[_loc1_];
            if(_loc1_ < this.MultiList.length)
            {
               _loc2_.visible = true;
               _loc3_ = this.MultiList[_loc1_];
               TextField(_loc2_.txt_name).text = _loc3_.text;
               if(_loc3_.text.indexOf("(0)") > 0)
               {
                  TextField(_loc2_.txt_name).textColor = 8684676;
               }
               else
               {
                  TextField(_loc2_.txt_name).textColor = 5618431;
               }
               _loc2_.gotoAndStop(1);
               _loc2_.x = 0;
               _loc2_.y = this.mc_locate.numChildren * this.ItemHeight;
               this.mc_locate.addChild(_loc2_);
            }
            else
            {
               _loc2_.visible = false;
            }
            _loc1_++;
         }
         this.ItemListHeight = this.MultiList.length * this.ItemHeight;
         if(this.ItemListHeight > this.ListHeight)
         {
            this.mc_scroll.height = this.ScrollHeight * int(this.ScrollHeight / (this.ItemListHeight - this.ListHeight));
            if(this.mc_scroll.height > this.ScrollHeight)
            {
               this.mc_scroll.height = this.ScrollHeight;
            }
            if(this.mc_scroll.height < 10)
            {
               this.mc_scroll.height = 15;
            }
         }
         else
         {
            this.mc_scroll.height = this.ScrollHeight;
         }
         this.mc_scroll.y = this.btn_up.m_movie.y + this.btn_up.m_movie.height;
         this.ScrollRect.left = this.mc_scroll.x;
         this.ScrollRect.top = this.btn_up.m_movie.y + this.btn_up.m_movie.height;
         this.ScrollRect.right = this.ScrollRect.left;
         this.ScrollRect.bottom = this.ScrollRect.top + this.ScrollHeight - this.mc_scroll.height;
      }
      
      private function ShowDiamondList() : void
      {
         var _loc1_:int = this.SelectedGem.PropsInfo.List == 40 ? 0 : 1;
         if(this.MultiType != _loc1_)
         {
            this.ResultList.splice(0);
            this.ResultPageCount = 0;
            this.ResultPageId = 0;
            this.ShowResultList();
            this.RestResultButton();
         }
         this.MultiType = _loc1_;
         this.SelectedLockFlag = -1;
         this.OtherLevel = -1;
         if(this.MultiType == 0)
         {
            this.mc_b2.visible = true;
            this.GetDiamondList3();
         }
         else
         {
            this.mc_b2.visible = false;
            this.GetDiamondList4();
         }
         this.PageId = 0;
         this.PageCount = Math.ceil(this.ShowGemList.length / this.PageItemCount);
         this._ShowDiamondList();
         this.RestPageButton();
         this.ClearComposeShow();
         var _loc2_:Bitmap = new Bitmap(GameKernel.getTextureInstance(this.SelectedGem.PropsInfo.ImageFileName));
         this.mc_base.addChildAt(_loc2_,1);
         this.mc_lock.visible = false;
      }
      
      private function _ShowDiamondList() : void
      {
         var _loc3_:MovieClip = null;
         var _loc4_:propsInfo = null;
         var _loc5_:Bitmap = null;
         var _loc1_:int = this.PageId * this.PageItemCount;
         var _loc2_:int = 0;
         while(_loc2_ < this.PageItemCount)
         {
            _loc3_ = this.MultiDiamond.getChildByName("mc_list" + _loc2_) as MovieClip;
            if(_loc3_.numChildren > 3)
            {
               _loc3_.removeChildAt(1);
            }
            if(_loc1_ < this.ShowGemList.length)
            {
               TextField(_loc3_.tf_num).text = this.ShowGemList[_loc1_].PropsNum.toString();
               MovieClip(_loc3_.mc_lock).visible = this.ShowGemList[_loc1_].LockFlag == 1;
               _loc4_ = CPropsReader.getInstance().GetPropsInfo(this.ShowGemList[_loc1_].PropsId);
               _loc5_ = new Bitmap(GameKernel.getTextureInstance(_loc4_.ImageFileName));
               _loc3_.addChildAt(_loc5_,1);
            }
            else
            {
               TextField(_loc3_.tf_num).text = "";
               MovieClip(_loc3_.mc_lock).visible = false;
            }
            _loc1_++;
            _loc2_++;
         }
      }
      
      private function AddCompose(param1:Object) : void
      {
         if(this.MultiType == 0)
         {
            this.AddCompose3(param1);
         }
         else
         {
            this.AddCompose4(param1);
         }
         this.PageCount = Math.ceil(this.ShowGemList.length / this.PageItemCount);
         this._ShowDiamondList();
         this.RestPageButton();
      }
      
      private function RemoveCompose(param1:Object) : void
      {
         if(this.MultiType == 0)
         {
            this.RemoveCompose3(param1);
         }
         else
         {
            this.RemoveCompose4(param1);
         }
         this.MaxValue = 0;
         this.txt_num.text = this.MaxValue.toString();
         this.PageCount = Math.ceil(this.ShowGemList.length / this.PageItemCount);
         this._ShowDiamondList();
         this.RestPageButton();
      }
      
      private function ShowResultList() : void
      {
         var _loc3_:MovieClip = null;
         var _loc4_:propsInfo = null;
         var _loc5_:Bitmap = null;
         this.ResultPageCount = Math.ceil(this.ResultList.length / this.PageItemCount);
         var _loc1_:int = this.ResultPageId * this.PageItemCount;
         var _loc2_:int = 0;
         while(_loc2_ < this.PageItemCount)
         {
            _loc3_ = this.MultiDiamond.getChildByName("mc_list0" + _loc2_) as MovieClip;
            if(_loc3_.numChildren > 3)
            {
               _loc3_.removeChildAt(1);
            }
            if(_loc1_ < this.ResultList.length)
            {
               TextField(_loc3_.tf_num).text = this.ResultList[_loc1_].Num.toString();
               MovieClip(_loc3_.mc_lock).visible = this.ResultList[_loc1_].LockFlag == 1;
               _loc4_ = CPropsReader.getInstance().GetPropsInfo(this.ResultList[_loc1_].PropsId);
               _loc5_ = new Bitmap(GameKernel.getTextureInstance(_loc4_.ImageFileName));
               _loc3_.addChildAt(_loc5_,1);
            }
            else
            {
               TextField(_loc3_.tf_num).text = "";
               MovieClip(_loc3_.mc_lock).visible = false;
            }
            _loc1_++;
            _loc2_++;
         }
      }
      
      private function RestResultButton() : void
      {
         this.btn_left0.setBtnDisabled(this.ResultPageId == 0);
         this.btn_right0.setBtnDisabled(this.ResultPageId + 1 >= this.ResultPageCount);
         if(this.ResultPageCount == 0)
         {
            this.tf_page0.text + "0/0";
         }
         else
         {
            this.tf_page0.text = this.ResultPageId + 1 + "/" + this.ResultPageCount;
         }
      }
      
      private function GetMultiList3() : void
      {
         var _loc3_:DiamondInfo = null;
         var _loc4_:Object = null;
         var _loc1_:Array = CPropsReader.getInstance().MultiList3;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_.length)
         {
            _loc3_ = _loc1_[_loc2_];
            this.GetDiamone3(_loc3_);
            this.GetMaxValue3(_loc3_);
            if(this.mc_check.currentFrame == 1 || this.MaxValue > 0)
            {
               _loc4_ = new Object();
               _loc4_.text = _loc3_.PropsInfo.Name + " (" + this.MaxValue + ")";
               _loc4_.aDiamondInfo = _loc3_;
               this.MultiList.push(_loc4_);
            }
            _loc2_++;
         }
      }
      
      private function GetMaxValue3(param1:DiamondInfo) : void
      {
         var _loc4_:int = 0;
         var _loc2_:int = 99999;
         var _loc3_:int = 99999;
         this.MaxValue = 0;
         if(this.DiamondList.Length() > 0)
         {
            for each(_loc4_ in param1.ResultGemList)
            {
               _loc2_ = Math.min(this._GetMaxValue3(_loc4_,0),_loc2_);
               _loc3_ = Math.min(this._GetMaxValue3(_loc4_,1),_loc3_);
            }
            this.MaxValue = _loc2_ + _loc3_;
         }
      }
      
      private function _GetMaxValue3(param1:int, param2:int) : int
      {
         var _loc6_:Object = null;
         var _loc3_:int = 0;
         var _loc4_:String = param1 + "_" + param2;
         var _loc5_:Array = this.DiamondList.Get(_loc4_);
         if(_loc5_ != null)
         {
            for each(_loc6_ in _loc5_)
            {
               _loc3_ += _loc6_.PropsNum;
            }
         }
         return _loc3_;
      }
      
      private function GetDiamone3(param1:DiamondInfo) : void
      {
         var _loc4_:propsInfo = null;
         var _loc5_:DiamondInfo = null;
         var _loc6_:int = 0;
         var _loc7_:String = null;
         var _loc8_:Array = null;
         this.DiamondList.removeAll();
         this.RemoveMap.removeAll();
         var _loc2_:Array = ScienceSystem.getinstance().Packarr;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length)
         {
            if(_loc2_[_loc3_].StorageType == 0)
            {
               _loc4_ = CPropsReader.getInstance().GetPropsInfo(_loc2_[_loc3_].PropsId);
               if(_loc4_ != null && _loc4_.PackID == 3 && _loc4_.List < 40)
               {
                  _loc5_ = CPropsReader.getInstance().GetDiamond(_loc2_[_loc3_].PropsId);
                  if(param1.GemLevel == _loc5_.GemLevel)
                  {
                     _loc6_ = int(param1.ResultGemList.indexOf(_loc5_.GemID.toString()));
                     if(_loc6_ >= 0)
                     {
                        _loc7_ = _loc5_.GemID + "_" + _loc2_[_loc3_].LockFlag;
                        _loc8_ = this.DiamondList.Get(_loc7_);
                        if(_loc8_ == null)
                        {
                           _loc8_ = new Array();
                           this.DiamondList.Put(_loc7_,_loc8_);
                        }
                        _loc8_.push(_loc2_[_loc3_]);
                     }
                  }
               }
            }
            _loc3_++;
         }
      }
      
      private function GetDiamondList3() : void
      {
         this.GetDiamone3(this.SelectedGem);
         this.GetMaxValue3(this.SelectedGem);
         this._GetDiamondList3();
      }
      
      private function _GetDiamondList3() : void
      {
         var _loc1_:String = null;
         var _loc2_:String = null;
         this.ShowGemList.splice(0);
         if(this.SelectedLockFlag == -1 || this.SelectedLockFlag == 0)
         {
            for each(_loc1_ in this.SelectedGem.ResultGemList)
            {
               this.PushGemToList(_loc1_,0);
            }
         }
         if(this.SelectedLockFlag == -1 || this.SelectedLockFlag == 1)
         {
            for each(_loc2_ in this.SelectedGem.ResultGemList)
            {
               this.PushGemToList(_loc2_,1);
            }
         }
      }
      
      private function PushGemToList(param1:String, param2:int) : void
      {
         var _loc5_:Object = null;
         var _loc6_:DiamondInfo = null;
         var _loc3_:String = param1 + "_" + param2;
         var _loc4_:Array = this.DiamondList.Get(_loc3_);
         if(_loc4_ != null)
         {
            for each(_loc5_ in _loc4_)
            {
               _loc6_ = CPropsReader.getInstance().GetDiamond(_loc5_.PropsId);
               if(this.MultiType == 0)
               {
                  this.ShowGemList.push(_loc5_);
               }
               else if(this.OtherLevel == -1 || _loc6_.GemLevel == this.OtherLevel - 1)
               {
                  this.ShowGemList.push(_loc5_);
               }
            }
         }
      }
      
      private function AddCompose3(param1:Object) : void
      {
         var _loc2_:DiamondInfo = CPropsReader.getInstance().GetDiamond(param1.PropsId);
         var _loc3_:String = _loc2_.GemID + "_" + param1.LockFlag;
         var _loc4_:Array = this.DiamondList.Get(_loc3_);
         if(_loc4_ != null)
         {
            this.DiamondList.Remove(_loc3_);
            this.RemoveMap.Put(_loc3_,_loc4_);
            this.SelectedLockFlag = param1.LockFlag;
         }
         if(this.RemoveMap.Length() == 3)
         {
            this.MaxValue = Math.min(this.ComposeList[0].PropsNum,this.ComposeList[1].PropsNum,this.ComposeList[2].PropsNum);
            this.txt_num.text = "1";
            this.btn_merge.setBtnDisabled(false);
         }
         this._GetDiamondList3();
      }
      
      private function RemoveCompose3(param1:Object) : void
      {
         var _loc2_:DiamondInfo = CPropsReader.getInstance().GetDiamond(param1.PropsId);
         var _loc3_:String = _loc2_.GemID + "_" + param1.LockFlag;
         var _loc4_:Array = this.RemoveMap.Get(_loc3_);
         if(_loc4_ != null)
         {
            this.RemoveMap.Remove(_loc3_);
            this.DiamondList.Put(_loc3_,_loc4_);
            if(this.RemoveMap.Length() <= 0)
            {
               this.SelectedLockFlag = -1;
            }
            this.btn_merge.setBtnDisabled(true);
         }
         this._GetDiamondList3();
      }
      
      private function GetMultiList4() : void
      {
         var _loc3_:DiamondInfo = null;
         var _loc4_:Object = null;
         var _loc1_:Array = CPropsReader.getInstance().MultiList4;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_.length)
         {
            _loc3_ = _loc1_[_loc2_];
            this.GetDiamone4(_loc3_);
            this.GetMaxValue4(_loc3_);
            if(this.mc_check.currentFrame == 1 || this.MaxValue > 0)
            {
               _loc4_ = new Object();
               _loc4_.text = _loc3_.PropsInfo.Name + " (" + this.MaxValue + ")";
               _loc4_.aDiamondInfo = _loc3_;
               this.MultiList.push(_loc4_);
            }
            _loc2_++;
         }
      }
      
      private function GetMaxValue4(param1:DiamondInfo) : void
      {
         this.MaxValue = 0;
         if(this.DiamondList.Length() > 0)
         {
            this._GetMaxValue4(param1,0);
            this._GetMaxValue4(param1,1);
         }
      }
      
      private function _GetMaxValue4(param1:DiamondInfo, param2:int) : void
      {
         var _loc7_:Object = null;
         var _loc8_:Array = null;
         var _loc9_:Object = null;
         var _loc10_:int = 0;
         var _loc11_:Object = null;
         var _loc12_:Object = null;
         var _loc13_:DiamondInfo = null;
         var _loc14_:int = 0;
         var _loc15_:int = 0;
         var _loc16_:Object = null;
         var _loc17_:DiamondInfo = null;
         var _loc18_:int = 0;
         var _loc19_:int = 0;
         var _loc3_:String = param1.Gem1ID + "_" + param2;
         var _loc4_:Array = this.DiamondList.Get(_loc3_);
         if(_loc4_ == null)
         {
            return;
         }
         _loc3_ = "40_" + param2;
         var _loc5_:Array = this.DiamondList.Get(_loc3_);
         if(_loc5_ == null)
         {
            return;
         }
         var _loc6_:Array = new Array();
         for each(_loc7_ in _loc4_)
         {
            _loc11_ = new Object();
            _loc11_.PropsId = _loc7_.PropsId;
            _loc11_.PropsNum = _loc7_.PropsNum;
            _loc6_.push(_loc11_);
         }
         _loc8_ = new Array();
         for each(_loc9_ in _loc5_)
         {
            _loc12_ = new Object();
            _loc12_.PropsId = _loc9_.PropsId;
            _loc12_.PropsNum = _loc9_.PropsNum;
            _loc8_.push(_loc12_);
         }
         _loc10_ = 0;
         while(_loc10_ < _loc6_.length)
         {
            _loc13_ = CPropsReader.getInstance().GetDiamond(_loc6_[_loc10_].PropsId);
            _loc14_ = param1.GemLevel * 2;
            _loc15_ = 0;
            while(_loc15_ < _loc8_.length)
            {
               _loc16_ = _loc8_[_loc15_];
               _loc17_ = CPropsReader.getInstance().GetDiamond(_loc16_.PropsId);
               _loc18_ = _loc17_.GemLevel + _loc13_.GemLevel;
               if(_loc18_ == _loc14_)
               {
                  _loc19_ = Math.min(_loc6_[_loc10_].PropsNum,_loc16_.PropsNum);
                  this.MaxValue += _loc19_;
                  _loc6_[_loc10_].PropsNum -= _loc19_;
                  if(_loc6_[_loc10_].PropsNum == 0)
                  {
                     _loc6_.splice(_loc10_,1);
                  }
                  _loc16_.PropsNum -= _loc19_;
                  if(_loc16_.PropsNum == 0)
                  {
                     _loc8_.splice(_loc15_,1);
                  }
                  _loc10_ = -1;
                  break;
               }
               _loc15_++;
            }
            _loc10_++;
         }
      }
      
      private function GetDiamone4(param1:DiamondInfo) : void
      {
         var _loc5_:propsInfo = null;
         var _loc6_:DiamondInfo = null;
         var _loc7_:int = 0;
         var _loc8_:String = null;
         var _loc9_:Array = null;
         this.DiamondList.removeAll();
         this.RemoveMap.removeAll();
         var _loc2_:Array = ScienceSystem.getinstance().Packarr;
         var _loc3_:int = param1.GemLevel * 2;
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_.length)
         {
            if(_loc2_[_loc4_].StorageType == 0)
            {
               _loc5_ = CPropsReader.getInstance().GetPropsInfo(_loc2_[_loc4_].PropsId);
               if(_loc5_ != null && _loc5_.PackID == 3 && _loc5_.List < 41)
               {
                  _loc6_ = CPropsReader.getInstance().GetDiamond(_loc2_[_loc4_].PropsId);
                  _loc7_ = _loc3_ - _loc6_.GemLevel;
                  if(_loc6_.GemColor == param1.GemColor && _loc7_ >= 0 && _loc7_ <= 4)
                  {
                     _loc8_ = null;
                     if(_loc6_.PropsId >= param1.Gem1ID && _loc6_.PropsId <= param1.Gem1ID + 4)
                     {
                        _loc8_ = param1.Gem1ID + "_" + _loc2_[_loc4_].LockFlag;
                     }
                     else if(_loc5_.List == 40)
                     {
                        _loc8_ = "40_" + _loc2_[_loc4_].LockFlag;
                     }
                     if(_loc8_)
                     {
                        _loc9_ = this.DiamondList.Get(_loc8_);
                        if(_loc9_ == null)
                        {
                           _loc9_ = new Array();
                           this.DiamondList.Put(_loc8_,_loc9_);
                        }
                        _loc9_.push(_loc2_[_loc4_]);
                     }
                  }
               }
            }
            _loc4_++;
         }
      }
      
      private function GetDiamondList4() : void
      {
         this.GetDiamone4(this.SelectedGem);
         this.GetMaxValue4(this.SelectedGem);
         this._GetDiamondList4();
      }
      
      private function _GetDiamondList4() : void
      {
         this.ShowGemList.splice(0);
         if(this.SelectedLockFlag == -1 || this.SelectedLockFlag == 0)
         {
            this.PushGemToList(this.SelectedGem.Gem1ID.toString(),0);
            this.PushGemToList("40",0);
         }
         if(this.SelectedLockFlag == -1 || this.SelectedLockFlag == 1)
         {
            this.PushGemToList(this.SelectedGem.Gem1ID.toString(),1);
            this.PushGemToList("40",1);
         }
      }
      
      private function AddCompose4(param1:Object) : void
      {
         var _loc3_:String = null;
         var _loc2_:DiamondInfo = CPropsReader.getInstance().GetDiamond(param1.PropsId);
         if(_loc2_.PropsId >= this.SelectedGem.Gem1ID && _loc2_.PropsId <= this.SelectedGem.Gem1ID + 4)
         {
            _loc3_ = this.SelectedGem.Gem1ID + "_" + param1.LockFlag;
         }
         else
         {
            _loc3_ = "40_" + param1.LockFlag;
         }
         var _loc4_:Array = this.DiamondList.Get(_loc3_);
         if(_loc4_ != null)
         {
            this.DiamondList.Remove(_loc3_);
            this.RemoveMap.Put(_loc3_,_loc4_);
            this.SelectedLockFlag = param1.LockFlag;
            this.OtherLevel = this.SelectedGem.GemLevel * 2 + 1 - _loc2_.GemLevel;
         }
         if(this.RemoveMap.Length() == 2)
         {
            this.MaxValue = Math.min(this.ComposeList[0].PropsNum,this.ComposeList[1].PropsNum);
            this.txt_num.text = "1";
            this.btn_merge.setBtnDisabled(false);
         }
         this._GetDiamondList4();
      }
      
      private function RemoveCompose4(param1:Object) : void
      {
         var _loc3_:String = null;
         var _loc5_:DiamondInfo = null;
         var _loc2_:DiamondInfo = CPropsReader.getInstance().GetDiamond(param1.PropsId);
         if(_loc2_.PropsId >= this.SelectedGem.Gem1ID && _loc2_.PropsId <= this.SelectedGem.Gem1ID + 4)
         {
            _loc3_ = this.SelectedGem.Gem1ID + "_" + param1.LockFlag;
         }
         else
         {
            _loc3_ = "40_" + param1.LockFlag;
         }
         var _loc4_:Array = this.RemoveMap.Get(_loc3_);
         if(_loc4_ != null)
         {
            this.RemoveMap.Remove(_loc3_);
            this.DiamondList.Put(_loc3_,_loc4_);
            if(this.RemoveMap.Length() <= 0)
            {
               this.SelectedLockFlag = -1;
               this.OtherLevel = -1;
            }
            else
            {
               if(this.ComposeList[0] != null)
               {
                  _loc5_ = CPropsReader.getInstance().GetDiamond(this.ComposeList[0].PropsId);
               }
               else
               {
                  _loc5_ = CPropsReader.getInstance().GetDiamond(this.ComposeList[1].PropsId);
               }
               this.OtherLevel = this.SelectedGem.GemLevel * 2 + 1 - _loc5_.GemLevel;
            }
            this.btn_merge.setBtnDisabled(true);
         }
         this._GetDiamondList4();
      }
      
      private function btn_rightClick(param1:MouseEvent) : void
      {
         ++this.PageId;
         this._ShowDiamondList();
         this.RestPageButton();
      }
      
      private function btn_leftClick(param1:MouseEvent) : void
      {
         --this.PageId;
         this._ShowDiamondList();
         this.RestPageButton();
      }
      
      private function btn_right0Click(param1:MouseEvent) : void
      {
         ++this.PageId;
         this.ShowResultList();
         this.RestResultButton();
      }
      
      private function btn_left0Click(param1:MouseEvent) : void
      {
         --this.PageId;
         this.ShowResultList();
         this.RestResultButton();
      }
      
      private function btn_down0Click(param1:MouseEvent) : void
      {
         if(this.MaxValue == 0)
         {
            this.txt_num.text = "0";
            return;
         }
         if(this.txt_num.text == "")
         {
            this.txt_num.text = this.MaxValue.toString();
            return;
         }
         var _loc2_:int = parseInt(this.txt_num.text);
         _loc2_--;
         if(_loc2_ < 1)
         {
            this.txt_num.text = "1";
         }
         else
         {
            this.txt_num.text = _loc2_.toString();
         }
      }
      
      private function btn_up0Click(param1:MouseEvent) : void
      {
         if(this.txt_num.text == "")
         {
            this.txt_num.text = this.MaxValue.toString();
            return;
         }
         var _loc2_:int = parseInt(this.txt_num.text);
         if(++_loc2_ > this.MaxValue)
         {
            this.txt_num.text = this.MaxValue.toString();
         }
         else
         {
            this.txt_num.text = _loc2_.toString();
         }
      }
      
      private function DiamondMouseMove(param1:MouseEvent) : void
      {
      }
      
      private function DiamondMouseOut(param1:MouseEvent) : void
      {
         if(Boolean(this.OverBase) && this.OverBase != this.SelectedBase)
         {
            this.OverBase.m_movie.gotoAndStop(1);
         }
         this.HidDiamondTip();
      }
      
      private function DiamondDoubleClick(param1:MouseEvent, param2:XButton) : void
      {
         if(param2.Data >= this.ShowGemList.length)
         {
            return;
         }
         this.HidDiamondTip();
         this._AddCompose(param2.Data);
      }
      
      private function DiamondMouseOut1(param1:MouseEvent) : void
      {
         this.HidDiamondTip();
      }
      
      private function DiamondMouseDown1(param1:MouseEvent, param2:XButton) : void
      {
      }
      
      private function DiamondMouseOver1(param1:MouseEvent, param2:XButton) : void
      {
         if(param2.Data >= this.ResultList.length)
         {
            return;
         }
         var _loc3_:Object = this.ResultList[param2.Data];
         this.ShowDiamondTip(param2.m_movie,_loc3_.PropsId);
      }
      
      private function _AddCompose(param1:int) : void
      {
         var _loc5_:MovieClip = null;
         var _loc6_:Bitmap = null;
         var _loc2_:int = 3;
         var _loc3_:int = 0;
         var _loc4_:propsInfo = CPropsReader.getInstance().GetPropsInfo(this.ShowGemList[param1].PropsId);
         if(this.MultiType == 1)
         {
            if(_loc4_.List == 40)
            {
               _loc3_ = 1;
            }
            _loc2_ = 2;
         }
         while(_loc3_ < _loc2_)
         {
            if(this.ComposeList[_loc3_] == null)
            {
               this.ComposeList[_loc3_] = this.ShowGemList[param1];
               this.AddCompose(this.ShowGemList[param1]);
               _loc5_ = this.MultiDiamond.getChildByName("mc_b" + _loc3_) as MovieClip;
               if(_loc5_.numChildren > 2)
               {
                  _loc5_.removeChildAt(1);
               }
               this.mc_lock.visible = this.ComposeList[_loc3_].LockFlag == 1;
               MovieClip(_loc5_.mc_lock).visible = this.mc_lock.visible;
               _loc6_ = new Bitmap(GameKernel.getTextureInstance(_loc4_.ImageFileName));
               _loc6_.x = 3;
               _loc6_.y = 3;
               _loc5_.addChildAt(_loc6_,1);
               break;
            }
            _loc3_++;
         }
      }
      
      private function DiamondMouseDown(param1:MouseEvent, param2:XButton) : void
      {
         if(this.SelectedBase)
         {
            this.SelectedBase.m_movie.gotoAndStop(1);
         }
         if(param2.Data >= this.ShowGemList.length)
         {
            return;
         }
         this.SelectedBase = param2;
         this.SelectedBase.m_movie.gotoAndStop(2);
      }
      
      private function DiamondMouseOver(param1:MouseEvent, param2:XButton) : void
      {
         if(param2.Data >= this.ShowGemList.length)
         {
            return;
         }
         if(Boolean(this.OverBase) && this.OverBase != this.SelectedBase)
         {
            this.OverBase.m_movie.gotoAndStop(1);
         }
         this.OverBase = param2;
         this.OverBase.m_movie.gotoAndStop(2);
         this.ShowDiamondTip(param2.m_movie,this.ShowGemList[this.PageId * this.PageItemCount + param2.Data].PropsId);
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
      
      private function HidDiamondTip() : void
      {
         if(Boolean(this._PropsTip) && Boolean(this._PropsTip.parent))
         {
            this._PropsTip.parent.removeChild(this._PropsTip);
         }
      }
      
      private function ItemDown(param1:MouseEvent, param2:XMovieClip) : void
      {
         if(this.SelectedItem != null)
         {
            this.SelectedItem.m_movie.gotoAndStop(1);
         }
         this.SelectedItem = param2;
         param2.m_movie.gotoAndStop(2);
         this.SelectedGem = this.MultiList[param2.Data].aDiamondInfo;
         this.ShowDiamondList();
      }
      
      private function ItemOver(param1:MouseEvent, param2:XMovieClip) : void
      {
         if(Boolean(this.OverItem) && this.SelectedItem != this.OverItem)
         {
            this.OverItem.m_movie.gotoAndStop(1);
         }
         this.OverItem = param2;
         param2.m_movie.gotoAndStop(2);
      }
      
      private function ItemOut(param1:MouseEvent) : void
      {
         if(Boolean(this.OverItem) && this.SelectedItem != this.OverItem)
         {
            this.OverItem.m_movie.gotoAndStop(1);
         }
      }
      
      private function CheckConditon() : Boolean
      {
         var _loc1_:int = UpdateResource.getInstance().HasPackSpace(this.SelectedGem.PropsId,this.SelectedLockFlag);
         if(_loc1_ == 1 || GamePlayer.getInstance().PropsPack - ScienceSystem.getinstance().Packarr.length <= 0)
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
         return true;
      }
      
      private function btn_mergeClick(param1:MouseEvent) : void
      {
         if(GamePlayer.getInstance().UserMoney < this.CompouseMoney)
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("CorpsText165"),1);
            this.ComposeCount == 0;
            this.BaseMc.mouseEnabled = true;
            this.BaseMc.mouseChildren = true;
            return;
         }
         if(this.CheckConditon() == false)
         {
            return;
         }
         this.ComposeCount = parseInt(this.txt_num.text);
         if(this.ComposeCount > 0)
         {
            this.RequestMsg = new MSG_REQUEST_COMMANDERPROPERTYSTONE();
            this.RequestMsg.Type = this.MultiType;
            this.RequestMsg.LockFlag = this.SelectedLockFlag;
            this.RequestMsg.ObjStoneId = this.SelectedGem.PropsId;
            if(this.MultiType == 0)
            {
               this.RequestMsg.SrcStoneId1 = this.ComposeList[0].PropsId;
               this.RequestMsg.SrcStoneId2 = this.ComposeList[1].PropsId;
               this.RequestMsg.SrcStoneId3 = this.ComposeList[2].PropsId;
            }
            else
            {
               this.RequestMsg.SrcStoneId1 = this.ComposeList[0].PropsId;
               this.RequestMsg.SrcStoneId2 = this.ComposeList[1].PropsId;
            }
            this.SendMsg();
         }
      }
      
      private function SendMsg() : void
      {
         MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("Boss125"),0);
         this.RequestMsg.SeqId = GamePlayer.getInstance().seqID++;
         this.RequestMsg.Guid = GamePlayer.getInstance().Guid;
         NetManager.Instance().sendObject(this.RequestMsg);
         this.BaseMc.mouseEnabled = false;
         this.BaseMc.mouseChildren = false;
      }
      
      public function Resp_MSG_RESP_COMMANDERPROPERTYSTONE(param1:MSG_RESP_COMMANDERPROPERTYSTONE) : void
      {
         var _loc3_:Object = null;
         var _loc4_:Object = null;
         UpdateResource.getInstance().AddToPack(param1.ObjStoneId,1,param1.LockFlag);
         UpdateResource.getInstance().DeleteProps(param1.SrcStoneId1,param1.LockFlag,1);
         UpdateResource.getInstance().DeleteProps(param1.SrcStoneId2,param1.LockFlag,1);
         ConstructionAction.getInstance().costResource(0,0,this.CompouseMoney,0);
         var _loc2_:Boolean = false;
         for each(_loc3_ in this.ResultList)
         {
            if(_loc3_.PropsId == param1.ObjStoneId && _loc3_.LockFlag == param1.LockFlag)
            {
               _loc2_ = true;
               _loc3_.Num += 1;
               break;
            }
         }
         if(_loc2_ == false)
         {
            _loc4_ = new Object();
            _loc4_.PropsId = param1.ObjStoneId;
            _loc4_.LockFlag = param1.LockFlag;
            _loc4_.Num = 1;
            this.ResultList.push(_loc4_);
         }
         if(param1.Type == 0)
         {
            UpdateResource.getInstance().DeleteProps(param1.SrcStoneId3,param1.LockFlag,1);
         }
         --this.ComposeCount;
         if(this.ComposeCount == 0)
         {
            this.BaseMc.mouseEnabled = true;
            this.BaseMc.mouseChildren = true;
            this.ShowMultiList();
         }
         else if(this.CheckConditon() == false)
         {
            this.ComposeCount = 0;
            this.BaseMc.mouseEnabled = true;
            this.BaseMc.mouseChildren = true;
            this.ShowMultiList();
         }
         else
         {
            this.ShowResultList();
            this.SendMsg();
         }
      }
      
      private function btn_downClick(param1:MouseEvent) : void
      {
         if(this.LocateY - this.mc_locate.y >= this.ItemListHeight - this.ListHeight - 10)
         {
            return;
         }
         this.mc_locate.y -= this.ItemHeight;
         this.RestScrollBar();
      }
      
      private function btn_upClick(param1:MouseEvent) : void
      {
         if(this.mc_locate.y + this.ItemHeight + 10 >= this.LocateY)
         {
            return;
         }
         this.mc_locate.y += this.ItemHeight;
         this.RestScrollBar();
      }
      
      private function RestScrollBar() : void
      {
         this.mc_scroll.y = this.btn_up.m_movie.y + this.btn_up.m_movie.height + (this.ScrollHeight - this.mc_scroll.height) * (this.LocateY - this.mc_locate.y) / this.ItemListHeight;
      }
      
      private function mc_bOut(param1:MouseEvent) : void
      {
         this.HidDiamondTip();
      }
      
      private function mc_bOver(param1:MouseEvent, param2:XMovieClip) : void
      {
         if(this.ComposeList[param2.Data] == null)
         {
            return;
         }
         this.ShowDiamondTip(param2.m_movie,this.ComposeList[param2.Data].PropsId);
      }
      
      private function mc_bDoubleClick(param1:MouseEvent, param2:XMovieClip) : void
      {
         if(this.ComposeList[param2.Data] == null)
         {
            return;
         }
         this.HidDiamondTip();
         this.RemoveCompose(this.ComposeList[param2.Data]);
         this.ComposeList[param2.Data] = null;
         param2.m_movie.removeChildAt(1);
         MovieClip(param2.m_movie.mc_lock).visible = false;
      }
      
      private function mc_baseOut(param1:MouseEvent) : void
      {
         this.HidDiamondTip();
      }
      
      private function mc_baseOver(param1:MouseEvent) : void
      {
         if(this.SelectedGem == null)
         {
            return;
         }
         this.ShowDiamondTip(this.mc_base,this.SelectedGem.PropsId);
      }
      
      private function mc_checkClick(param1:MouseEvent) : void
      {
         this.mc_check.gotoAndStop(this.mc_check.currentFrame % 2 + 1);
         this.ShowMultiList();
      }
      
      private function mc_scrollUp(param1:MouseEvent) : void
      {
         this.mc_scroll.stopDrag();
         this.mc_scroll.removeEventListener(Event.ENTER_FRAME,this.mc_scrollEnter);
         this.mc_scroll.stage.removeEventListener(MouseEvent.MOUSE_UP,this.mc_scrollUp);
      }
      
      private function mc_scrollDown(param1:MouseEvent) : void
      {
         this.mc_scroll.startDrag(false,this.ScrollRect);
         this.mc_scroll.addEventListener(Event.ENTER_FRAME,this.mc_scrollEnter);
         this.mc_scroll.stage.addEventListener(MouseEvent.MOUSE_UP,this.mc_scrollUp);
      }
      
      private function mc_scrollEnter(param1:Event) : void
      {
         if(this.mc_scroll.height == this.ScrollHeight)
         {
            return;
         }
         this.mc_locate.y = this.LocateY - this.ItemListHeight * (this.mc_scroll.y - this.btn_up.m_movie.y - this.btn_up.m_movie.height) / (this.ScrollHeight - this.mc_scroll.height);
         if(this.LocateY - this.mc_locate.y >= this.ItemListHeight - this.ListHeight - 10)
         {
            this.mc_locate.y = this.LocateY - this.ItemListHeight + this.ListHeight;
         }
      }
      
      private function txt_numChange(param1:Event) : void
      {
         if(this.MaxValue == 0)
         {
            this.txt_num.text = "0";
         }
         if(this.txt_num.text == "")
         {
            this.txt_num.text = "1";
         }
         var _loc2_:int = parseInt(this.txt_num.text);
         if(_loc2_ > this.MaxValue)
         {
            this.txt_num.text = this.MaxValue.toString();
         }
      }
   }
}

