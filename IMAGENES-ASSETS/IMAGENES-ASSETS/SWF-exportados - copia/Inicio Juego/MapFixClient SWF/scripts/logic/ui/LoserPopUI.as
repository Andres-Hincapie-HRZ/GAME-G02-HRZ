package logic.ui
{
   import com.star.frameworks.events.ActionEvent;
   import com.star.frameworks.managers.StringManager;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.geom.Point;
   import flash.text.StyleSheet;
   import flash.text.TextField;
   import logic.action.ChatAction;
   import logic.entry.GamePlayer;
   import logic.entry.HButton;
   import logic.entry.MObject;
   import logic.game.GameKernel;
   import logic.ui.tip.CustomTip;
   import net.base.NetManager;
   import net.msg.corpsMsg.MSG_REQUEST_INSERTFLAGCONSORTIAIMEMBER;
   import net.msg.corpsMsg.MSG_RESP_INSERTFLAGCONSORTIAIMEMBER;
   import net.msg.corpsMsg.MSG_RESP_INSERTFLAGCONSORTIAIMEMBER_TEMP;
   
   public class LoserPopUI extends AbstractPopUp
   {
      
      private static var instance:LoserPopUI;
      
      private var btn_left:HButton;
      
      private var btn_right:HButton;
      
      private var tf_page:TextField;
      
      private var RowList:Array;
      
      private var PageId:int;
      
      private var ConsortiaId:int;
      
      private var PageCount:int;
      
      private var mc_base:MovieClip;
      
      private var tf_name:TextField;
      
      private var tf_LV:TextField;
      
      private var tf_integral:TextField;
      
      private var tf_resplanet:TextField;
      
      private var tf_resplanetPoint:Point;
      
      private var _ForWar:Boolean;
      
      private var SelectedItem:XMovieClip;
      
      private var CorpsMsg:MSG_RESP_INSERTFLAGCONSORTIAIMEMBER;
      
      public function LoserPopUI()
      {
         super();
         this.RowList = new Array();
         setPopUpName("LoserPopUI");
      }
      
      public static function getInstance() : LoserPopUI
      {
         if(instance == null)
         {
            instance = new LoserPopUI();
         }
         return instance;
      }
      
      override public function Init() : void
      {
         if(GameKernel.popUpDisplayManager.PopDisplayList.ContainsKey(getPopUpName()))
         {
            this.Clear();
            this.RequestList();
            return;
         }
         this._mc = new MObject("LoserPop",385,300);
         this.initMcElement();
         this.Clear();
         this.RequestList();
         GameKernel.popUpDisplayManager.Regisger(instance);
      }
      
      override public function initMcElement() : void
      {
         var _loc1_:HButton = null;
         var _loc2_:MovieClip = null;
         var _loc4_:MovieClip = null;
         var _loc5_:XMovieClip = null;
         var _loc6_:TextField = null;
         var _loc7_:String = null;
         var _loc8_:StyleSheet = null;
         _loc2_ = this._mc.getMC().getChildByName("btn_cancel") as MovieClip;
         _loc1_ = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.CloseClick);
         _loc2_ = this._mc.getMC().getChildByName("btn_left") as MovieClip;
         this.btn_left = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_leftClick);
         _loc2_ = this._mc.getMC().getChildByName("btn_right") as MovieClip;
         this.btn_right = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_rightClick);
         this.tf_page = this._mc.getMC().getChildByName("tf_page") as TextField;
         this.mc_base = this._mc.getMC().getChildByName("mc_base") as MovieClip;
         this.tf_name = this._mc.getMC().getChildByName("tf_name") as TextField;
         this.tf_LV = this._mc.getMC().getChildByName("tf_LV") as TextField;
         this.tf_integral = this._mc.getMC().getChildByName("tf_integral") as TextField;
         this.tf_resplanet = this._mc.getMC().getChildByName("tf_resplanet") as TextField;
         this.tf_resplanet.addEventListener(MouseEvent.MOUSE_OVER,this.tf_resplanetOver);
         this.tf_resplanet.addEventListener(MouseEvent.MOUSE_OUT,this.tf_resplanetOut);
         this.tf_resplanetPoint = this.tf_resplanet.localToGlobal(new Point(this.tf_resplanet.width,0));
         var _loc3_:int = 0;
         while(_loc3_ < 10)
         {
            _loc4_ = this._mc.getMC().getChildByName("mc_list" + _loc3_) as MovieClip;
            _loc4_.buttonMode = true;
            _loc4_.gotoAndStop(1);
            _loc5_ = new XMovieClip(_loc4_);
            _loc5_.Data = _loc3_;
            _loc5_.OnClick = this.ItemClick;
            _loc5_.OnMouseOver = this.ItemMouseOver;
            _loc6_ = TextField(_loc4_.tf_corpsname);
            _loc6_.addEventListener(ActionEvent.ACTION_TEXT_LINK,this.UserNameClick2);
            _loc7_ = "a:link{text-decoration: underline;} a:hover{color:#ff0000;text-decoration: underline;} a:active{text-decoration: underline;}";
            _loc8_ = new StyleSheet();
            _loc8_.parseCSS(_loc7_);
            _loc4_.tf_corpsname.styleSheet = _loc8_;
            this.RowList.push(_loc4_);
            _loc3_++;
         }
      }
      
      public function ShowConsortia(param1:int, param2:Boolean = false) : void
      {
         this._ForWar = param2;
         this.ConsortiaId = param1;
         this.Init();
         GameKernel.popUpDisplayManager.Show(LoserPopUI.getInstance());
         this.setVisible(true);
      }
      
      private function ItemClick(param1:Event, param2:XMovieClip) : void
      {
         var _loc3_:MSG_RESP_INSERTFLAGCONSORTIAIMEMBER_TEMP = null;
         if(this._ForWar)
         {
            _loc3_ = this.CorpsMsg.Data[param2.Data];
            MyCorpsUI_Pirate.getInstance().SelecteUser(_loc3_);
            this.CloseClick(param1);
         }
      }
      
      private function ItemMouseOver(param1:Event, param2:XMovieClip) : void
      {
         if(this.SelectedItem != null)
         {
            this.SelectedItem.m_movie.gotoAndStop(1);
         }
         this.SelectedItem = param2;
         this.SelectedItem.m_movie.gotoAndStop(2);
      }
      
      private function Clear() : void
      {
         var _loc2_:MovieClip = null;
         var _loc1_:int = 0;
         while(_loc1_ < 10)
         {
            _loc2_ = this.RowList[_loc1_];
            _loc2_.visible = false;
            _loc1_++;
         }
         this.PageId = 0;
         this.PageCount = 0;
         this.ShowPageButton();
      }
      
      private function CloseClick(param1:Event) : void
      {
         GameKernel.popUpDisplayManager.Hide(this);
      }
      
      private function btn_leftClick(param1:MouseEvent) : void
      {
         --this.PageId;
         this.btn_left.setBtnDisabled(true);
         this.btn_right.setBtnDisabled(true);
         this.RequestList();
      }
      
      private function btn_rightClick(param1:MouseEvent) : void
      {
         ++this.PageId;
         this.btn_left.setBtnDisabled(true);
         this.btn_right.setBtnDisabled(true);
         this.RequestList();
      }
      
      private function RequestList() : void
      {
         this.CorpsMsg = null;
         var _loc1_:MSG_REQUEST_INSERTFLAGCONSORTIAIMEMBER = new MSG_REQUEST_INSERTFLAGCONSORTIAIMEMBER();
         _loc1_.ConsortiaId = this.ConsortiaId;
         _loc1_.PageId = this.PageId;
         _loc1_.SeqId = GamePlayer.getInstance().seqID++;
         _loc1_.Guid = GamePlayer.getInstance().Guid;
         NetManager.Instance().sendObject(_loc1_);
      }
      
      public function RespList(param1:MSG_RESP_INSERTFLAGCONSORTIAIMEMBER) : void
      {
         var _loc5_:MovieClip = null;
         var _loc6_:MSG_RESP_INSERTFLAGCONSORTIAIMEMBER_TEMP = null;
         if(this.SelectedItem != null)
         {
            this.SelectedItem.m_movie.gotoAndStop(1);
         }
         this.CorpsMsg = param1;
         if(this.mc_base.numChildren > 0)
         {
            this.mc_base.removeChildAt(0);
         }
         var _loc2_:Bitmap = new Bitmap(GameKernel.getTextureInstance("corp_" + param1.HeadId));
         _loc2_.width = 55;
         _loc2_.height = 55;
         _loc2_.smoothing = true;
         this.mc_base.addChild(_loc2_);
         this.tf_name.text = param1.Name;
         this.tf_LV.text = (param1.Level + 1).toString();
         this.tf_integral.text = param1.ThrowWealth.toString();
         this.tf_resplanet.text = param1.HoldGalaxy.toString();
         this.PageCount = param1.MemberCount / 10;
         if(this.PageCount * 10 < param1.MemberCount)
         {
            ++this.PageCount;
         }
         var _loc3_:int = this.PageId * 10 + 1;
         var _loc4_:int = 0;
         while(_loc4_ < 10)
         {
            _loc5_ = this.RowList[_loc4_];
            if(_loc4_ < param1.DataLen)
            {
               _loc6_ = param1.Data[_loc4_];
               _loc5_.visible = true;
               TextField(_loc5_.tf_ranking).text = _loc3_.toString();
               TextField(_loc5_.tf_corpsname).htmlText = "<a href=\'event:" + _loc4_ + "\'>" + _loc6_.Name + "</a>";
               TextField(_loc5_.tf_attack).text = _loc6_.Assault.toString();
               TextField(_loc5_.tf_position).text = StringManager.getInstance().getMessageString("CorpsText" + int(14 + _loc6_.Job));
               TextField(_loc5_.tf_location).text = StringManager.getInstance().getMessageString("CorpsText125").replace("@@1",int(_loc6_.GalaxyArea + 1).toString());
            }
            else
            {
               _loc5_.visible = false;
            }
            _loc3_++;
            _loc4_++;
         }
         this.ShowPageButton();
      }
      
      private function UserNameClick2(param1:TextEvent) : void
      {
         var _loc3_:MSG_RESP_INSERTFLAGCONSORTIAIMEMBER_TEMP = null;
         if(this.CorpsMsg == null)
         {
            return;
         }
         var _loc2_:int = int(param1.text);
         if(_loc2_ < this.CorpsMsg.DataLen)
         {
            _loc3_ = this.CorpsMsg.Data[_loc2_];
            ChatAction.getInstance().sendChatUserInfoMessage(-1,_loc3_.Guid,3);
         }
      }
      
      private function ShowPageButton() : void
      {
         this.btn_left.setBtnDisabled(this.PageId == 0);
         this.btn_right.setBtnDisabled(this.PageId + 1 >= this.PageCount);
         if(this.PageCount > 0)
         {
            this.tf_page.text = this.PageId + 1 + "/" + this.PageCount;
         }
         else
         {
            this.tf_page.text = "";
         }
      }
      
      private function tf_resplanetOver(param1:MouseEvent) : void
      {
         var _loc2_:* = null;
         var _loc3_:int = 0;
         if(this.CorpsMsg != null)
         {
            _loc2_ = "";
            _loc3_ = 0;
            while(_loc3_ < this.CorpsMsg.HoldGalaxy)
            {
               if(_loc3_ > 0)
               {
                  _loc2_ += "\n\n";
               }
               _loc2_ += StringManager.getInstance().getMessageString("CorpsText125").replace("@@1",int(this.CorpsMsg.HoldGalaxyArea[_loc3_] + 1).toString());
               _loc3_++;
            }
            if(_loc2_ != "")
            {
               CustomTip.GetInstance().Show(_loc2_,this.tf_resplanetPoint);
            }
         }
      }
      
      private function tf_resplanetOut(param1:MouseEvent) : void
      {
         CustomTip.GetInstance().Hide();
      }
   }
}

