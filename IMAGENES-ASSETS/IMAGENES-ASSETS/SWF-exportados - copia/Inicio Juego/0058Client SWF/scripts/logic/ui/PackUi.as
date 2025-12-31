package logic.ui
{
   import com.star.frameworks.events.ActionEvent;
   import com.star.frameworks.managers.StringManager;
   import com.star.frameworks.utils.CEffectText;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import logic.action.ChatAction;
   import logic.action.ConstructionAction;
   import logic.entry.GamePlayer;
   import logic.entry.HButton;
   import logic.entry.MObject;
   import logic.entry.ScienceSystem;
   import logic.entry.props.propsInfo;
   import logic.entry.shipmodel.ShippartInfo;
   import logic.game.GameKernel;
   import logic.manager.GameInterActiveManager;
   import logic.reader.CPropsReader;
   import logic.reader.CShipmodelReader;
   import logic.utils.BluecardUi;
   import logic.utils.Commander;
   import logic.utils.GreencardUi;
   import logic.utils.MoveEfect;
   import logic.utils.PackTip;
   import logic.utils.UpdateResource;
   import logic.utils.YellowcardUi;
   import logic.widget.BufferQueueManager;
   import logic.widget.ConstructionOperationWidget;
   import logic.widget.OperationEnum;
   import net.base.NetManager;
   import net.msg.sciencesystem.MSG_REQUEST_DELETEPROPS;
   import net.msg.sciencesystem.MSG_REQUEST_PROPSMOVE;
   import net.msg.sciencesystem.MSG_REQUEST_UNBINDCOMMANDERCARD;
   import net.msg.sciencesystem.MSG_REQUEST_USEPROPS;
   import net.router.ShipmodelRouter;
   
   public class PackUi extends AbstractPopUp
   {
      
      private static var instance:PackUi;
      
      private var content:MovieClip;
      
      private var btn0:MovieClip;
      
      private var btn1:MovieClip;
      
      private var btn2:MovieClip;
      
      private var btn3:MovieClip;
      
      private var btn4:MovieClip;
      
      private var pilian_btn:HButton;
      
      private var btnarr:Array = new Array();
      
      private var nnss:uint = 0;
      
      private var js1:uint = 1;
      
      private var js2:uint = 4;
      
      private var gezhf:uint;
      
      private var totalpage:uint = 1;
      
      private var dangqpage:uint = 1;
      
      private var goodsarr:Array = new Array();
      
      private var tip:MovieClip;
      
      private var yjarr:Array = new Array();
      
      private var proid:uint = 0;
      
      private var Num:uint = 0;
      
      private var LockFlag:int = 0;
      
      private var obj:Object = new Object();
      
      private var wdpage:uint = 1;
      
      private var total:uint = 1;
      
      private var bit:Bitmap;
      
      private var smc:MovieClip;
      
      private var movbo:Boolean = true;
      
      private var qqarr:Array = new Array();
      
      private var ggarr:Array = new Array();
      
      private var pronum:uint = 0;
      
      private var prid:int;
      
      private var flg:int;
      
      private var Juntarr:Array = new Array();
      
      private var ffbtn:HButton;
      
      private var startdragtype:int;
      
      private var carmc:MovieClip;
      
      private var btn_look:HButton;
      
      private var btn_compose:HButton;
      
      private var jbtn_look:HButton;
      
      private var btn_clear:HButton;
      
      private var colors:int = 0;
      
      private var leve:int = 0;
      
      private var conname:String = "";
      
      private var concome:String = "";
      
      private var xx:Number = 0;
      
      private var yy:Number = 0;
      
      private var backMc:MovieClip = new MovieClip();
      
      private var lockarr:Array = new Array();
      
      private var btn_left:HButton;
      
      private var btn_right:HButton;
      
      private var btn_uppage:HButton;
      
      private var btn_downpage:HButton;
      
      private var heise:MovieClip;
      
      private var kkt:String = "<font size=\'12\' color=\'#ff0000\'>";
      
      private var eet:String = "<font size=\'12\' color=\'#ffffff\'>";
      
      private var wbb:String = "</font>";
      
      private var btntip:MovieClip;
      
      private var mer:int = 0;
      
      private var ttyy:int = 0;
      
      private var pdqztj:int = 0;
      
      public var maxNum:int = 200;
      
      private var _DeleteNum:int = 0;
      
      public function PackUi()
      {
         super();
         setPopUpName("PackUi");
      }
      
      public static function getInstance() : PackUi
      {
         if(instance == null)
         {
            instance = new PackUi();
         }
         return instance;
      }
      
      override public function Init() : void
      {
         if(GameKernel.popUpDisplayManager.PopDisplayList.ContainsKey(getPopUpName()))
         {
            this.begin();
            return;
         }
         this._mc = new MObject("StorageScene",380,300);
         this.initMcElement();
         GameKernel.popUpDisplayManager.Regisger(instance);
      }
      
      override public function initMcElement() : void
      {
         this.content = this._mc.getMC();
         this.content.mc_storagepop.visible = false;
         this.content.btn_bagpop.visible = false;
         this.content.mc_bagcontainer.visible = false;
         this.content.mc_bagcontainer.tf_num.mouseEnabled = false;
         this.content.mc_bagcontainer.mc_lock.mouseEnabled = false;
         this.content.mc_bagcontainer.mc_base.removeChildAt(0);
         this.content.mc_bagcontainer.removeChildAt(0);
         this.content.mc_bagcontainer.gotoAndStop(1);
         BluecardUi.getInstance().Init();
         GreencardUi.getInstance().Init();
         YellowcardUi.getInstance().Init();
         this.content.setChildIndex(this.content.btn_bagpop,this.content.numChildren - 1);
         var _loc1_:HButton = new HButton(this.content.btn_close);
         GameInterActiveManager.InstallInterActiveEvent(_loc1_.m_movie,ActionEvent.ACTION_CLICK,this.onCloseWnd);
         this.btn0 = this.content.btn_all as MovieClip;
         this.btn1 = this.content.btn_res as MovieClip;
         this.btn2 = this.content.btn_equip as MovieClip;
         this.btn3 = this.content.btn_card as MovieClip;
         this.btn4 = this.content.btn_paper as MovieClip;
         this.btnarr[0] = this.btn0;
         this.btnarr[1] = this.btn1;
         this.btnarr[2] = this.btn2;
         this.btnarr[3] = this.btn3;
         this.btnarr[4] = this.btn4;
         var _loc2_:uint = 0;
         while(_loc2_ < 5)
         {
            this.btnarr[_loc2_].buttonMode = true;
            this.btnarr[_loc2_].nns = _loc2_;
            this.btnarr[_loc2_].addEventListener(MouseEvent.ROLL_OVER,this.ovHd);
            this.btnarr[_loc2_].addEventListener(MouseEvent.ROLL_OUT,this.ouHd);
            this.btnarr[_loc2_].addEventListener(MouseEvent.MOUSE_DOWN,this.ddHd);
            this.btnarr[_loc2_].addEventListener(MouseEvent.MOUSE_UP,this.upHd);
            this.yjarr[_loc2_] = new HButton(this.content.mc_storagepop["btn" + _loc2_]);
            this.yjarr[_loc2_].m_movie.addEventListener(MouseEvent.CLICK,this.youjHd);
            _loc2_++;
         }
         this.ffbtn = new HButton(this.content.btn_bagpop.btn0);
         var _loc3_:HButton = new HButton(this.content.btn_bagpop.btn1);
         this.ffbtn.m_movie.addEventListener(MouseEvent.CLICK,this.ffbtnHd);
         _loc3_.m_movie.addEventListener(MouseEvent.CLICK,this.fhbtnHd);
         this.btn_uppage = new HButton(this.content.btn_uppage);
         this.btn_downpage = new HButton(this.content.btn_downpage);
         this.btn_left = new HButton(this.content.btn_left);
         this.btn_right = new HButton(this.content.btn_right);
         this.btn_uppage.setBtnDisabled(true);
         this.btn_downpage.setBtnDisabled(true);
         this.btn_uppage.m_movie.addEventListener(MouseEvent.CLICK,this.ssHd);
         this.btn_downpage.m_movie.addEventListener(MouseEvent.CLICK,this.xxHd);
         this.btn_left.setBtnDisabled(true);
         this.btn_right.setBtnDisabled(true);
         this.begin();
         this.btn_look = new HButton(this.content.mc_storagepop.btn_look);
         this.btn_compose = new HButton(this.content.mc_storagepop.btn_compose);
         this.jbtn_look = new HButton(this.content.btn_bagpop.btn_look);
         this.pilian_btn = new HButton(this.content.mc_storagepop.btn_batchuse);
         this.btn_clear = new HButton(this.content.mc_storagepop.btn_clear);
         this.btn_look.setBtnDisabled(true);
         this.jbtn_look.setBtnDisabled(true);
         this.btn_compose.setBtnDisabled(true);
         this.btn_compose.m_movie.addEventListener(MouseEvent.CLICK,this.HCHd);
         this.btn_look.m_movie.addEventListener(MouseEvent.CLICK,this.LookHd);
         this.jbtn_look.m_movie.addEventListener(MouseEvent.CLICK,this.LookHd);
         this.pilian_btn.m_movie.addEventListener(MouseEvent.CLICK,this.pilinHd);
         this.btn_clear.m_movie.addEventListener(MouseEvent.CLICK,this.clearHd);
      }
      
      private function HCHd(param1:MouseEvent) : void
      {
         if(ConstructionAction.getInstance().getComposeCenterNumber() == -1)
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("CorpsText102"),0);
            this.content["mc_base" + this.mer].gotoAndStop(1);
            this.content.mc_storagepop.visible = false;
            return;
         }
         this.closeHd(1);
         ComposeUI.getInstance().ShowDiamond();
      }
      
      public function HeiseDownHd(param1:MouseEvent) : void
      {
         this.Hider(1);
         MoveEfect.getInstance().DeleteFun(param1.currentTarget as MovieClip);
         this.content.mc_storagepop.visible = false;
         this.content.btn_bagpop.visible = false;
         if(this.carmc != null && this.content.contains(this.carmc))
         {
            this.content.removeChild(this.carmc);
            Commander.getInstance().CloseEnHd();
         }
         if(this.ttyy == 0)
         {
            this.content["mc_base" + this.mer].gotoAndStop(1);
         }
         else
         {
            this.content["mc_storagebase" + this.mer].gotoAndStop(1);
         }
      }
      
      public function Usefalse() : void
      {
         if(this.content == null)
         {
            return;
         }
         if(this.content["mc_base" + this.mer] != null)
         {
            this.content["mc_base" + this.mer].gotoAndStop(1);
         }
      }
      
      private function begin() : void
      {
         this.dangqpage = 1;
         this.goodsarr.length = 0;
         this.wdpage = 1;
         this.nnss = 0;
         var _loc1_:uint = 0;
         while(_loc1_ < ScienceSystem.getinstance().Packarr.length)
         {
            this.goodsarr.push(ScienceSystem.getinstance().Packarr[_loc1_]);
            _loc1_++;
         }
         this.Juntarr.length = 0;
         var _loc2_:uint = 0;
         while(_loc2_ < ScienceSystem.getinstance().Juntarr.length)
         {
            this.Juntarr.push(ScienceSystem.getinstance().Juntarr[_loc2_]);
            _loc2_++;
         }
         var _loc3_:uint = 0;
         while(_loc3_ < 5)
         {
            this.btnarr[_loc3_].gotoAndStop(this.js1);
            this.btnarr[_loc3_].cs = this.js1;
            this.btnarr[_loc3_].ii = _loc3_;
            _loc3_++;
         }
         this.btnarr[0].gotoAndStop(this.js2);
         this.btnarr[0].cs = this.js2;
         this.BtnHD();
         this.content.tf_page.text = this.dangqpage + "/" + this.totalpage;
         this.content.tf_cash.text = GamePlayer.getInstance().cash;
         this.content.tf_gold.text = GamePlayer.getInstance().UserMoney;
         this.pageHd(this.dangqpage);
         this.Warehouse(this.wdpage);
      }
      
      private function BtnHD() : void
      {
         this.gezhf = GamePlayer.getInstance().PropsPack;
         if(this.gezhf < this.maxNum)
         {
            this.totalpage = Math.ceil((this.gezhf + 1) / 25);
         }
         else
         {
            this.totalpage = Math.ceil(this.gezhf / 25);
         }
         this.btn_uppage.setBtnDisabled(true);
         this.btn_downpage.setBtnDisabled(true);
         if(this.totalpage > this.dangqpage)
         {
            this.btn_downpage.setBtnDisabled(false);
         }
         this.btn_right.setBtnDisabled(true);
         this.btn_left.setBtnDisabled(true);
         if(this.wdpage < Math.ceil(GamePlayer.getInstance().PropsCorpsPack / 25))
         {
            this.btn_right.setBtnDisabled(false);
         }
      }
      
      private function ssHd(param1:MouseEvent) : void
      {
         if(this.dangqpage == 1)
         {
            return;
         }
         this.btn_downpage.setBtnDisabled(false);
         --this.dangqpage;
         if(this.dangqpage == 1)
         {
            this.btn_uppage.setBtnDisabled(true);
         }
         this.content.tf_page.text = this.dangqpage + "/" + this.totalpage;
         this.pageHd(this.dangqpage);
      }
      
      private function xxHd(param1:MouseEvent) : void
      {
         if(this.dangqpage == this.totalpage)
         {
            return;
         }
         this.btn_uppage.setBtnDisabled(false);
         if(this.dangqpage == this.totalpage - 1)
         {
            this.btn_downpage.setBtnDisabled(true);
         }
         ++this.dangqpage;
         this.content.tf_page.text = this.dangqpage + "/" + this.totalpage;
         this.pageHd(this.dangqpage);
      }
      
      private function pageHd(param1:uint) : void
      {
         var _loc2_:MovieClip = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:propsInfo = null;
         this.content.mc_storagepop.visible = false;
         var _loc3_:uint = (param1 - 1) * 25;
         while(_loc3_ < param1 * 25)
         {
            _loc2_ = new MovieClip();
            _loc2_.graphics.clear();
            _loc2_.graphics.beginFill(16711935,0);
            _loc2_.graphics.drawCircle(0,0,2);
            this.ggarr.push(_loc2_);
            this.content.addChild(this.ggarr[_loc3_ - (param1 - 1) * 25]);
            this.ggarr[_loc3_ - (param1 - 1) * 25].x = this.content["mc_base" + (_loc3_ - (param1 - 1) * 25)].x;
            this.ggarr[_loc3_ - (param1 - 1) * 25].y = this.content["mc_base" + (_loc3_ - (param1 - 1) * 25)].y;
            this.content["mc_base" + (_loc3_ - (param1 - 1) * 25)].gotoAndStop(1);
            TextField(this.content["mc_base" + (_loc3_ - (param1 - 1) * 25)].tf_num).text = "";
            TextField(this.content["mc_base" + (_loc3_ - (param1 - 1) * 25)].tf_num).selectable = false;
            TextField(this.content["mc_base" + (_loc3_ - (param1 - 1) * 25)].tf_num).mouseEnabled = false;
            this.content["mc_base" + (_loc3_ - (param1 - 1) * 25)].removeEventListener(MouseEvent.ROLL_OVER,this.MovHd);
            this.content["mc_base" + (_loc3_ - (param1 - 1) * 25)].removeEventListener(MouseEvent.ROLL_OUT,this.MouHd);
            this.content["mc_base" + (_loc3_ - (param1 - 1) * 25)].removeEventListener(MouseEvent.ROLL_OVER,this.ovHd);
            this.content["mc_base" + (_loc3_ - (param1 - 1) * 25)].removeEventListener(MouseEvent.ROLL_OUT,this.ouHd);
            if(this.content["mc_base" + (_loc3_ - (param1 - 1) * 25)].mc_base.numChildren > 1)
            {
               this.content["mc_base" + (_loc3_ - (param1 - 1) * 25)].mc_base.removeChildAt(1);
            }
            this.content["mc_base" + (_loc3_ - (param1 - 1) * 25)].mc_lock.mouseEnabled = false;
            this.content["mc_base" + (_loc3_ - (param1 - 1) * 25)].mc_lock.visible = false;
            this.content["mc_base" + (_loc3_ - (param1 - 1) * 25)].typ = 0;
            this.content["mc_base" + (_loc3_ - (param1 - 1) * 25)].buttonMode = false;
            this.content["mc_base" + (_loc3_ - (param1 - 1) * 25)].nns = 0;
            if(this.goodsarr.length > _loc3_)
            {
               _loc6_ = CPropsReader.getInstance().GetPropsInfo(this.goodsarr[_loc3_].PropsId);
               if(_loc6_.PackID == 1)
               {
                  this.bit = new Bitmap(GameKernel.getTextureInstance(_loc6_.ImageFileName));
                  this.content["mc_base" + (_loc3_ - (param1 - 1) * 25)].colors = _loc6_.CommanderType;
                  this.content["mc_base" + (_loc3_ - (param1 - 1) * 25)].mingz = _loc6_.Name;
                  this.content["mc_base" + (_loc3_ - (param1 - 1) * 25)].Comment = _loc6_.Comment;
                  this.content["mc_base" + (_loc3_ - (param1 - 1) * 25)].leve = _loc6_.Id % 9 + 1;
               }
               else
               {
                  this.bit = new Bitmap(GameKernel.getTextureInstance(_loc6_.ImageFileName));
                  this.content["mc_base" + (_loc3_ - (param1 - 1) * 25)].mingz = _loc6_.Name;
                  this.content["mc_base" + (_loc3_ - (param1 - 1) * 25)].Comment = _loc6_.Comment;
               }
               TextField(this.content["mc_base" + (_loc3_ - (param1 - 1) * 25)].tf_num).text = String(this.goodsarr[_loc3_].PropsNum);
               this.content["mc_base" + (_loc3_ - (param1 - 1) * 25)].mc_base.addChild(this.bit);
               this.bit.width = 40;
               this.bit.height = 40;
               if(this.goodsarr[_loc3_].LockFlag == 1)
               {
                  this.content["mc_base" + (_loc3_ - (param1 - 1) * 25)].mc_lock.visible = true;
               }
               this.content["mc_base" + (_loc3_ - (param1 - 1) * 25)].typ = 1;
               this.content["mc_base" + (_loc3_ - (param1 - 1) * 25)].proid = this.goodsarr[_loc3_].PropsId;
               this.content["mc_base" + (_loc3_ - (param1 - 1) * 25)].num = this.goodsarr[_loc3_].PropsNum;
               this.content["mc_base" + (_loc3_ - (param1 - 1) * 25)].LockFlag = this.goodsarr[_loc3_].LockFlag;
               this.content["mc_base" + (_loc3_ - (param1 - 1) * 25)].PackID = _loc6_.PackID;
               this.content["mc_base" + (_loc3_ - (param1 - 1) * 25)].addEventListener(MouseEvent.ROLL_OVER,this.MovHd);
               this.content["mc_base" + (_loc3_ - (param1 - 1) * 25)].addEventListener(MouseEvent.ROLL_OUT,this.MouHd);
               this.content["mc_base" + (_loc3_ - (param1 - 1) * 25)].buttonMode = true;
            }
            _loc4_ = this.gezhf - ScienceSystem.getinstance().Packarr.length;
            _loc5_ = ScienceSystem.getinstance().Packarr.length - this.goodsarr.length;
            if(_loc3_ >= this.goodsarr.length + _loc4_)
            {
               this.content["mc_base" + (_loc3_ - (param1 - 1) * 25)].gotoAndStop(3);
               this.content["mc_base" + (_loc3_ - (param1 - 1) * 25)].typ = 3;
               this.content["mc_base" + (_loc3_ - (param1 - 1) * 25)].buttonMode = false;
            }
            this.content.tf_baggrid.text = String(ScienceSystem.getinstance().Packarr.length + "/" + this.gezhf);
            if(_loc3_ > this.gezhf)
            {
               this.content["mc_base" + (_loc3_ - (param1 - 1) * 25)].gotoAndStop(4);
               this.content["mc_base" + (_loc3_ - (param1 - 1) * 25)].typ = 3;
               this.content["mc_base" + (_loc3_ - (param1 - 1) * 25)].buttonMode = false;
            }
            else if(_loc3_ == this.gezhf)
            {
               this.content["mc_base" + (_loc3_ - (param1 - 1) * 25)].gotoAndStop(2);
               this.content["mc_base" + (_loc3_ - (param1 - 1) * 25)].typ = 2;
               this.content["mc_base" + (_loc3_ - (param1 - 1) * 25)].nns = -1;
               this.content["mc_base" + (_loc3_ - (param1 - 1) * 25)].addEventListener(MouseEvent.ROLL_OVER,this.ovHd);
               this.content["mc_base" + (_loc3_ - (param1 - 1) * 25)].addEventListener(MouseEvent.ROLL_OUT,this.ouHd);
               this.content["mc_base" + (_loc3_ - (param1 - 1) * 25)].buttonMode = true;
            }
            this.content["mc_base" + (_loc3_ - (param1 - 1) * 25)].ii = _loc3_ - (param1 - 1) * 25;
            this.content["mc_base" + (_loc3_ - (param1 - 1) * 25)].addEventListener(MouseEvent.CLICK,this.usegoodsHd);
            this.content["mc_base" + (_loc3_ - (param1 - 1) * 25)].dragtype = 0;
            this.content["mc_base" + (_loc3_ - (param1 - 1) * 25)].addEventListener(MouseEvent.MOUSE_DOWN,this.startDragHd);
            _loc3_++;
         }
      }
      
      private function viHd(param1:MouseEvent) : void
      {
         if(this.content.mc_storagepop.visible == false)
         {
            return;
         }
         this.content.mc_storagepop.visible = false;
      }
      
      private function startDragHd(param1:MouseEvent) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:String = null;
         if(MainUI.shirtKeyDown)
         {
            ChatAction.specialType = ChatAction.TOOL_TYPE;
            _loc3_ = ChatAction.specialType.toString() + "," + param1.currentTarget.proid + "," + param1.currentTarget.mingz;
            ChatUI.toolObj.Type = ChatAction.specialType;
            ChatUI.toolObj.Proid = param1.currentTarget.proid;
            ChatUI.toolObj.Name = param1.currentTarget.mingz;
            ChatUI.getInstance().copySysteNotice("[" + param1.currentTarget.mingz + "]/");
            return;
         }
         if(this.tip != null && this.content.contains(this.tip))
         {
            this.content.removeChild(this.tip);
            this.tip = null;
         }
         this.content.mc_storagepop.visible = false;
         this.content.btn_bagpop.visible = false;
         this.content.mc_bagcontainer.mouseEnabled = false;
         this.content.mc_bagcontainer.mc_base.mouseEnabled = false;
         if(this.carmc != null && this.content.contains(this.carmc))
         {
            this.content.removeChild(this.carmc);
         }
         this.smc = this.content.mc_bagcontainer;
         this.smc.visible = true;
         this.smc.graphics.clear();
         this.smc.graphics.beginFill(1129062,0);
         this.smc.graphics.drawRect(-30,-30,60,60);
         this.smc.graphics.endFill();
         if(param1.currentTarget.typ == 0)
         {
            this.content.mc_storagepop.visible = false;
            return;
         }
         if(param1.currentTarget.typ == 1)
         {
            _loc2_ = uint(param1.currentTarget.proid);
            this.bit = new Bitmap(GameKernel.getTextureInstance(CPropsReader.getInstance().GetPropsInfo(_loc2_).ImageFileName));
            this.smc.mc_base.addChild(this.bit);
            if(this.smc != null && this.content.contains(this.smc))
            {
               this.content.removeChild(this.smc);
            }
            this.content.addChild(this.smc);
            this.smc.startDrag();
            this.movbo = true;
            this.smc.x = param1.currentTarget.x;
            this.smc.y = param1.currentTarget.y;
            this.pronum = param1.currentTarget.num;
            this.prid = param1.currentTarget.proid;
            this.flg = param1.currentTarget.LockFlag;
            this.startdragtype = param1.currentTarget.dragtype;
            if(this.flg == 1)
            {
               this.smc.mc_lock.visible = true;
            }
            else if(this.flg == 0)
            {
               this.smc.mc_lock.visible = false;
            }
            this.smc.tf_num.text = this.pronum;
            this.content.addEventListener(MouseEvent.MOUSE_MOVE,this.onMove);
            this.smc.removeEventListener(MouseEvent.MOUSE_UP,this.stopDragHd);
         }
         else if(param1.currentTarget.typ == 2)
         {
            return;
         }
      }
      
      private function stopDragHd(param1:MouseEvent) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:int = 0;
         var _loc4_:MSG_REQUEST_PROPSMOVE = null;
         var _loc5_:uint = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:MSG_REQUEST_PROPSMOVE = null;
         this.smc.stopDrag();
         this.content.mc_storagepop.visible = false;
         if(this.startdragtype == 0)
         {
            _loc2_ = (this.wdpage - 1) * 25;
            while(_loc2_ < this.wdpage * 25)
            {
               if(this.smc.hitTestObject(this.qqarr[_loc2_ - (this.wdpage - 1) * 25]))
               {
                  if(this.content["mc_storagebase" + (_loc2_ - (this.wdpage - 1) * 25)].typ == 2 || this.content["mc_storagebase" + (_loc2_ - (this.wdpage - 1) * 25)].typ == 3)
                  {
                     break;
                  }
                  if(UpdateResource.getInstance().panduanjuntuan(this.prid,this.flg) == false)
                  {
                     if(this.smc != null && this.content.contains(this.smc))
                     {
                        this.content.removeChild(this.smc);
                     }
                     ConstructionOperationWidget.currenCmd = OperationEnum.OPERATION_TYPE_BAGALL;
                     MallBuyModulesPopup.getInstance().setparent("packUi");
                     MallBuyModulesPopup.getInstance().Init();
                     MallBuyModulesPopup.getInstance().Show();
                     return;
                  }
                  _loc3_ = UpdateResource.getInstance().MoveMaxjun(this.prid,this.flg);
                  if(this.pronum > 1)
                  {
                     this.heise = new MovieClip();
                     MoveEfect.getInstance().BlackHd(this.content,this.heise);
                     FriendspeedpopupUI.getInstance().Init();
                     FriendspeedpopupUI.getInstance().Show();
                     if(_loc3_ < this.pronum)
                     {
                        FriendspeedpopupUI.getInstance().pdd(_loc3_,this.prid,this.flg,0);
                        break;
                     }
                     FriendspeedpopupUI.getInstance().pdd(this.pronum,this.prid,this.flg,0);
                     break;
                  }
                  if(this.pronum == 1)
                  {
                     if(_loc3_ == 0)
                     {
                        if(this.smc != null && this.content.contains(this.smc))
                        {
                           this.content.removeChild(this.smc);
                        }
                        return;
                     }
                     _loc4_ = new MSG_REQUEST_PROPSMOVE();
                     _loc4_.SeqId = GamePlayer.getInstance().seqID++;
                     _loc4_.Guid = GamePlayer.getInstance().Guid;
                     _loc4_.Type = 0;
                     _loc4_.PropsId = this.prid;
                     _loc4_.PropsNum = this.pronum;
                     _loc4_.LockFlag = this.flg;
                     NetManager.Instance().sendObject(_loc4_);
                  }
                  break;
               }
               _loc2_++;
            }
         }
         else
         {
            _loc5_ = (this.dangqpage - 1) * 25;
            while(_loc5_ < this.dangqpage * 25)
            {
               if(this.smc.hitTestObject(this.ggarr[_loc5_ - (this.dangqpage - 1) * 25]))
               {
                  if(this.content["mc_base" + (_loc5_ - (this.dangqpage - 1) * 25)].typ == 2 || this.content["mc_base" + (_loc5_ - (this.dangqpage - 1) * 25)].typ == 3)
                  {
                     break;
                  }
                  _loc6_ = UpdateResource.getInstance().HasPackSpace(this.prid,this.flg,0);
                  if(_loc6_ != 0)
                  {
                     if(this.smc != null && this.content.contains(this.smc))
                     {
                        this.content.removeChild(this.smc);
                     }
                     StoragepopupTip.getInstance().Init();
                     StoragepopupTip.getInstance().Show();
                     if(GamePlayer.getInstance().PropsPack == this.maxNum)
                     {
                        StoragepopupTip.getInstance().ppd(2);
                     }
                     else
                     {
                        StoragepopupTip.getInstance().ppd(1);
                     }
                     return;
                  }
                  _loc7_ = UpdateResource.getInstance().MoveMax(this.prid,this.flg);
                  if(this.pronum > 1)
                  {
                     this.heise = new MovieClip();
                     MoveEfect.getInstance().BlackHd(this.content,this.heise);
                     FriendspeedpopupUI.getInstance().Init();
                     FriendspeedpopupUI.getInstance().Show();
                     if(_loc7_ < this.pronum)
                     {
                        FriendspeedpopupUI.getInstance().pdd(_loc7_,this.prid,this.flg,1);
                        break;
                     }
                     FriendspeedpopupUI.getInstance().pdd(this.pronum,this.prid,this.flg,1);
                     break;
                  }
                  if(this.pronum == 1)
                  {
                     if(_loc7_ == 0)
                     {
                        if(this.smc != null && this.content.contains(this.smc))
                        {
                           this.content.removeChild(this.smc);
                        }
                        return;
                     }
                     _loc8_ = new MSG_REQUEST_PROPSMOVE();
                     _loc8_.SeqId = GamePlayer.getInstance().seqID++;
                     _loc8_.Guid = GamePlayer.getInstance().Guid;
                     _loc8_.Type = 1;
                     _loc8_.PropsId = this.prid;
                     _loc8_.PropsNum = this.pronum;
                     _loc8_.LockFlag = this.flg;
                     NetManager.Instance().sendObject(_loc8_);
                  }
                  break;
               }
               _loc5_++;
            }
         }
         if(this.smc != null && this.content.contains(this.smc))
         {
            this.content.removeChild(this.smc);
         }
      }
      
      private function onMove(param1:MouseEvent) : void
      {
         if(this.movbo)
         {
            this.smc.mouseEnabled = true;
            this.smc.addEventListener(MouseEvent.MOUSE_UP,this.stopDragHd);
            this.movbo = false;
            param1.updateAfterEvent();
            return;
         }
      }
      
      private function usegoodsHd(param1:MouseEvent) : void
      {
         var _loc2_:propsInfo = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(MainUI.shirtKeyDown)
         {
            return;
         }
         this.content.btn_bagpop.visible = false;
         if(this.smc != null && this.content.contains(this.smc))
         {
            this.content.removeChild(this.smc);
         }
         if(param1.currentTarget.typ == 0 || param1.currentTarget.typ == 3)
         {
            this.content.mc_storagepop.visible = false;
            return;
         }
         if(param1.currentTarget.typ == 1)
         {
            this.ttyy = 0;
            param1.currentTarget.gotoAndStop(5);
            this.mer = param1.currentTarget.ii;
            this.content.mc_storagepop.visible = true;
            this.btn_look.setBtnDisabled(true);
            this.btn_clear.setBtnDisabled(true);
            this.heise = new MovieClip();
            MoveEfect.getInstance().BlackHd(this.content,this.heise,0);
            this.content.setChildIndex(this.content.mc_storagepop,this.content.numChildren - 1);
            this.proid = param1.currentTarget.proid;
            this.LockFlag = param1.currentTarget.LockFlag;
            this.Num = param1.currentTarget.num;
            this.colors = param1.currentTarget.colors;
            this.leve = param1.currentTarget.leve + 1;
            this.conname = param1.currentTarget.mingz;
            this.concome = param1.currentTarget.Comment;
            this.xx = param1.currentTarget.x;
            this.yy = param1.currentTarget.y;
            _loc2_ = CPropsReader.getInstance().GetPropsInfo(param1.currentTarget.proid);
            _loc3_ = _loc2_.ShipPartID;
            _loc4_ = _loc2_.ShipBodyID;
            this.yjarr[0].setBtnDisabled(false);
            if(_loc2_.PackID == 1)
            {
               this.btn_look.setBtnDisabled(false);
               if(this.LockFlag == 1)
               {
                  this.btn_clear.setBtnDisabled(false);
               }
               if(!CommanderSceneUI.getInstance().Judge(_loc2_.SkillID))
               {
                  this.yjarr[0].setBtnDisabled(true);
               }
            }
            else if(_loc2_.PackID == 0)
            {
               if(this.pdqztj == 1)
               {
                  this.yjarr[0].setBtnDisabled(true);
               }
               else if(_loc4_ >= 0)
               {
                  if(ShipmodelRouter.instance.ExistsBody(_loc4_))
                  {
                     this.yjarr[0].setBtnDisabled(true);
                  }
               }
               else if(ShipmodelRouter.instance.ExistsPart(_loc3_))
               {
                  this.yjarr[0].setBtnDisabled(true);
               }
            }
            else if(this.proid == 921 || this.proid == 903 || this.proid == 904 || this.proid == 924 || this.proid == 922 || this.proid == 925 || this.proid == 901 || this.proid == 926 || this.proid == 929 || this.proid == 4489 || this.proid == 4490 || this.proid == 932 || this.proid == 944 || this.proid == 953 || this.proid >= 3000 && this.proid <= 3004 || this.proid == 3200 || this.proid >= 4413 && this.proid <= 4420 || this.proid == 4424)
            {
               this.yjarr[0].setBtnDisabled(true);
            }
            if(this.proid == 902 || this.proid == 937)
            {
               if(BufferQueueManager.getInstance().isExists(1) || BufferQueueManager.getInstance().isExists(6))
               {
                  this.yjarr[0].setBtnDisabled(true);
               }
            }
            this.btn_compose.setBtnDisabled(true);
            if(param1.currentTarget.PackID == 3)
            {
               this.yjarr[0].setBtnDisabled(true);
               this.btn_compose.setBtnDisabled(false);
            }
            this.pilian_btn.setBtnDisabled(true);
            if(this.proid >= 912 && this.proid <= 920 || this.proid == 931 || this.proid == 934 || this.proid == 933 || this.proid == 935 || this.proid == 928 || this.proid == 938 || this.proid == 3101)
            {
               this.pilian_btn.setBtnDisabled(false);
            }
            if(this.proid == 905 || this.proid == 906 || this.proid == 907 || this.proid == 930 || this.proid == 939 || this.proid == 940 || this.proid == 941)
            {
               this.pilian_btn.setBtnDisabled(false);
            }
            this.content.mc_storagepop.x = param1.currentTarget.x + 15;
            this.content.mc_storagepop.y = param1.currentTarget.y + 15;
            this.yjarr[2].setBtnDisabled(true);
            if(this.LockFlag == 1)
            {
               this.yjarr[1].setBtnDisabled(true);
            }
            else
            {
               this.yjarr[1].setBtnDisabled(false);
            }
         }
         else if(param1.currentTarget.typ == 2)
         {
            if(this.btntip != null && this.content.contains(this.btntip))
            {
               this.content.removeChild(this.btntip);
            }
            StoragepopupTip.getInstance().Init();
            StoragepopupTip.getInstance().Show();
            StoragepopupTip.getInstance().ppd();
         }
      }
      
      private function clearHd(param1:MouseEvent) : void
      {
         var _loc2_:int = UpdateResource.getInstance().HasPackSpace(this.proid,0,1);
         if(_loc2_ == 1)
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("CommanderText12"),10);
            return;
         }
         if(_loc2_ == 2)
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("BattleTXT11"),0);
            return;
         }
         if(GamePlayer.getInstance().cash < 100)
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("CommanderText13"),0);
            return;
         }
         MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("Boss43"),2,this._ClearHd);
      }
      
      private function _ClearHd() : void
      {
         var _loc1_:MSG_REQUEST_UNBINDCOMMANDERCARD = new MSG_REQUEST_UNBINDCOMMANDERCARD();
         _loc1_.SeqId = GamePlayer.getInstance().seqID++;
         _loc1_.Guid = GamePlayer.getInstance().Guid;
         _loc1_.PropsId = this.proid;
         NetManager.Instance().sendObject(_loc1_);
      }
      
      public function Hider(param1:int = 0) : void
      {
         if(this.heise != null && this.content.contains(this.heise))
         {
            this.content.removeChild(this.heise);
         }
         if(param1 != 0)
         {
            if(this.ttyy == 0)
            {
               this.content["mc_base" + this.mer].gotoAndStop(1);
            }
            else
            {
               this.content["mc_storagebase" + this.mer].gotoAndStop(1);
            }
         }
      }
      
      public function Bralock(param1:Boolean) : void
      {
         if(!param1)
         {
            this.heise = new MovieClip();
            MoveEfect.getInstance().BlackHd(this.content,this.heise);
         }
         else if(this.heise != null && this.content.contains(this.heise))
         {
            this.content.removeChild(this.heise);
         }
      }
      
      private function youjHd(param1:MouseEvent) : void
      {
         var _loc3_:propsInfo = null;
         var _loc4_:MSG_REQUEST_USEPROPS = null;
         var _loc5_:MSG_REQUEST_USEPROPS = null;
         var _loc2_:uint = uint(param1.currentTarget.name.substring(3));
         this.Hider();
         if(this.tip != null && this.content.contains(this.tip))
         {
            this.content.removeChild(this.tip);
            this.tip = null;
         }
         switch(_loc2_)
         {
            case 0:
               ScienceSystem.getinstance().yutiaojian = false;
               _loc3_ = CPropsReader.getInstance().GetPropsInfo(this.proid);
               if(this.proid >= 908 && this.proid <= 911 || _loc3_.List >= 34 && _loc3_.List <= 39 || _loc3_.List == 33 || _loc3_.List == 26 || _loc3_.List == 27 || _loc3_.List == 28 || _loc3_.List == 29 || _loc3_.List == 31 || _loc3_.List == 32)
               {
                  if(GamePlayer.getInstance().PropsPack - ScienceSystem.getinstance().Packarr.length <= 0)
                  {
                     if(this.btntip != null && this.content.contains(this.btntip))
                     {
                        this.content.removeChild(this.btntip);
                     }
                     StoragepopupTip.getInstance().Init();
                     StoragepopupTip.getInstance().Show();
                     if(GamePlayer.getInstance().PropsPack == this.maxNum)
                     {
                        StoragepopupTip.getInstance().ppd(2);
                     }
                     else
                     {
                        StoragepopupTip.getInstance().ppd(1);
                     }
                     this.content.mc_storagepop.visible = false;
                     this.content["mc_base" + this.mer].gotoAndStop(1);
                     return;
                  }
                  if(_loc3_.List == 33)
                  {
                     this.closeHd();
                     ComposeUI.getInstance().ShowDoubleCompose(this.proid,this.flg,this.Num);
                     break;
                  }
                  _loc5_ = new MSG_REQUEST_USEPROPS();
                  _loc5_.SeqId = GamePlayer.getInstance().seqID++;
                  _loc5_.Guid = GamePlayer.getInstance().Guid;
                  _loc5_.PropsId = this.proid;
                  _loc5_.LockFlag = this.flg;
                  _loc5_.Num = 1;
                  NetManager.Instance().sendObject(_loc5_);
                  this.content.mc_storagepop.visible = false;
                  return;
               }
               _loc4_ = new MSG_REQUEST_USEPROPS();
               _loc4_.SeqId = GamePlayer.getInstance().seqID++;
               _loc4_.Guid = GamePlayer.getInstance().Guid;
               _loc4_.PropsId = this.proid;
               _loc4_.LockFlag = this.flg;
               _loc4_.Num = 1;
               NetManager.Instance().sendObject(_loc4_);
               break;
            case 1:
               if(ConstructionAction.getInstance().getTradePortNumber() == -1)
               {
                  MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("BuildingText14"),0);
                  this.content["mc_base" + this.mer].gotoAndStop(1);
                  break;
               }
               this.obj.PropsId = this.proid;
               this.obj.num = this.Num;
               this.heise = new MovieClip();
               MoveEfect.getInstance().BlackHd(this.content,this.heise);
               SaleUi.getInstance().Init();
               GameKernel.popUpDisplayManager.Show(SaleUi.getInstance());
               SaleUi.getInstance().fuzhiHd(this.obj);
               break;
            case 3:
               FleetNumUI.getInstance().Show(this._mc.getMC(),this.Num,this.DeleteGoods2,StringManager.getInstance().getMessageString("Boss194"),true,1);
               break;
            case 4:
               this.content.mc_storagepop.visible = false;
               this.Hider(1);
         }
         this.content.mc_storagepop.visible = false;
      }
      
      public function DeleteGoods() : void
      {
         var _loc1_:MSG_REQUEST_DELETEPROPS = new MSG_REQUEST_DELETEPROPS();
         _loc1_.SeqId = GamePlayer.getInstance().seqID++;
         _loc1_.Guid = GamePlayer.getInstance().Guid;
         _loc1_.PropsId = this.proid;
         _loc1_.LockFlag = this.LockFlag;
         NetManager.Instance().sendObject(_loc1_);
      }
      
      public function DeleteGoods2(param1:int) : void
      {
         this._DeleteNum = param1;
         var _loc2_:int = 0;
         while(_loc2_ < param1)
         {
            this.DeleteGoods();
            _loc2_++;
         }
      }
      
      public function updateuseHd() : void
      {
         --this._DeleteNum;
         if(this._DeleteNum > 0)
         {
            CEffectText.getInstance().showEffectText(GameKernel.renderManager.getUI().getContainer(),StringManager.getInstance().getMessageString("Boss196"),false,false);
            return;
         }
         CEffectText.getInstance().Hide();
         if(this.tip != null && this.content.contains(this.tip))
         {
            this.content.removeChild(this.tip);
         }
         this.tip = null;
         this.fuzhiHd(this.nnss);
         this.junfuzhiHd(this.nnss);
      }
      
      public function addHd() : void
      {
         this.fuzhiHd(this.nnss);
         this.gezhf = GamePlayer.getInstance().PropsPack;
         if(this.gezhf < this.maxNum)
         {
            this.totalpage = Math.ceil((this.gezhf + 1) / 25);
         }
         else
         {
            this.totalpage = Math.ceil(this.gezhf / 25);
         }
         if(this.totalpage > this.dangqpage)
         {
            this.btn_downpage.setBtnDisabled(false);
         }
         this.content.tf_page.text = this.dangqpage + "/" + this.totalpage;
         this.content.tf_cash.text = GamePlayer.getInstance().cash;
         this.content.tf_gold.text = GamePlayer.getInstance().UserMoney;
         this.pageHd(this.dangqpage);
      }
      
      private function LookHd(param1:MouseEvent) : void
      {
         this.Hider();
         this.content.mc_storagepop.visible = false;
         this.content.btn_bagpop.visible = false;
         this.heise = new MovieClip();
         MoveEfect.getInstance().BlackHd(this.content,this.heise,0);
         this.carmc = Commander.getInstance().CommanderTip(this.xx - 20,this.yy - 20,this.proid,true);
         if(this.xx > 80)
         {
            this.carmc.x -= 180;
         }
         if(this.yy > 80)
         {
            this.carmc.y -= 270;
         }
         this.content.addChild(this.carmc);
      }
      
      private function pilinHd(param1:MouseEvent) : void
      {
         this.content.mc_storagepop.visible = false;
         this.Hider();
         this.heise = new MovieClip();
         MoveEfect.getInstance().BlackHd(this.content,this.heise);
         UseGoodsNum.getInstance().Init();
         UseGoodsNum.getInstance().Show();
         var _loc2_:Object = new Object();
         _loc2_.bit = CPropsReader.getInstance().GetPropsInfo(this.proid).ImageFileName;
         _loc2_.num = this.Num;
         _loc2_.proid = this.proid;
         _loc2_.flg = this.flg;
         _loc2_.con = CPropsReader.getInstance().GetPropsInfo(this.proid).Comment;
         UseGoodsNum.getInstance().pdd(_loc2_);
      }
      
      public function TipHd(param1:Number = 0, param2:Number = 0, param3:int = 0, param4:Boolean = false) : MovieClip
      {
         var _loc18_:ShippartInfo = null;
         var _loc23_:uint = 0;
         var _loc24_:uint = 0;
         var _loc25_:String = null;
         var _loc26_:String = null;
         var _loc27_:int = 0;
         var _loc28_:int = 0;
         var _loc29_:int = 0;
         var _loc30_:int = 0;
         if(this.tip == null)
         {
            this.tip = new PackTip();
         }
         this.tip.mouseEnabled = false;
         var _loc5_:String = "";
         var _loc6_:String = "";
         this.tip.ms_txt.htmlText = StringManager.getInstance().getMessageString("ItemText9");
         this.tip.xinji_txt.visible = false;
         var _loc7_:int = 0;
         var _loc8_:Boolean = false;
         var _loc9_:int = 0;
         var _loc10_:propsInfo = CPropsReader.getInstance().GetPropsInfo(param3);
         _loc9_ = _loc10_.SuspendID;
         if(_loc10_.PackID == 1)
         {
            if(!param4)
            {
               return Commander.getInstance().CommanderTip(param1,param2,param3);
            }
            if(param3 % 9 == 0)
            {
               _loc7_ = 1;
            }
            else
            {
               _loc7_ = int(param3 % 9) + 1;
            }
            _loc5_ = _loc10_.Name;
            _loc6_ = _loc10_.Comment;
         }
         else
         {
            _loc5_ = _loc10_.Name;
            _loc6_ = _loc10_.Comment;
         }
         var _loc11_:int = _loc10_.ShipPartID;
         var _loc12_:int = _loc10_.ShipBodyID;
         this.pdqztj = 0;
         var _loc13_:Array = new Array();
         _loc13_.length = 0;
         _loc13_ = _loc10_.FrontID.split(";");
         var _loc14_:Array = new Array();
         _loc14_.length = 0;
         _loc14_ = _loc10_.FrontComment.split("、");
         var _loc15_:int = 0;
         var _loc16_:String = "";
         var _loc17_:Array = new Array();
         _loc17_.length = 0;
         if(_loc10_.PackID == 0)
         {
            _loc23_ = 0;
            while(_loc23_ < _loc13_.length)
            {
               _loc15_ = 0;
               if(_loc12_ >= 0)
               {
                  _loc18_ = CShipmodelReader.getInstance().getShipPartInfo(_loc12_);
                  if(ShipmodelRouter.instance.ExistsBody(_loc12_))
                  {
                     this.tip.ms_txt.htmlText = StringManager.getInstance().getMessageString("ItemText9") + StringManager.getInstance().getMessageString("ItemText8");
                  }
                  else
                  {
                     this.tip.ms_txt.htmlText = StringManager.getInstance().getMessageString("ItemText9");
                  }
               }
               else
               {
                  _loc18_ = CShipmodelReader.getInstance().getShipPartInfo(_loc11_);
                  if(ShipmodelRouter.instance.ExistsPart(_loc11_))
                  {
                     this.tip.ms_txt.htmlText = StringManager.getInstance().getMessageString("ItemText9") + StringManager.getInstance().getMessageString("ItemText8");
                  }
                  else
                  {
                     this.tip.ms_txt.htmlText = StringManager.getInstance().getMessageString("ItemText9");
                  }
               }
               if(_loc13_[_loc23_] == -1)
               {
                  this.pdqztj = 0;
                  break;
               }
               if(_loc12_ >= 0)
               {
                  if(!ShipmodelRouter.instance.ExistsBody(_loc13_[_loc23_]))
                  {
                     this.pdqztj = 1;
                     _loc15_ = 1;
                  }
                  else
                  {
                     _loc15_ = 0;
                  }
                  _loc17_.push(_loc15_);
               }
               else
               {
                  if(!ShipmodelRouter.instance.ExistsPart(_loc13_[_loc23_]))
                  {
                     this.pdqztj = 1;
                     _loc15_ = 1;
                  }
                  else
                  {
                     _loc15_ = 0;
                  }
                  _loc17_.push(_loc15_);
               }
               _loc23_++;
            }
            if(this.pdqztj == 1)
            {
               _loc24_ = 0;
               while(_loc24_ < _loc14_.length)
               {
                  if(_loc24_ < _loc14_.length - 1)
                  {
                     _loc14_[_loc24_] += "、";
                  }
                  if(_loc17_[_loc24_] == 1)
                  {
                     _loc16_ += this.kkt + _loc14_[_loc24_] + this.wbb;
                  }
                  else
                  {
                     _loc16_ += this.eet + _loc14_[_loc24_] + this.wbb;
                  }
                  _loc24_++;
               }
               this.tip.qztj_txt.htmlText = _loc16_;
            }
         }
         else if(_loc10_.PackID == 1)
         {
            this.tip.xinji_txt.visible = true;
            this.tip.xinji_txt.htmlText = StringManager.getInstance().getMessageString("CommanderText8" + _loc7_);
            _loc8_ = true;
         }
         this.tip.name_txt.text = _loc5_.toString();
         this.tip.con_txt.htmlText = _loc6_.toString();
         var _loc19_:* = "";
         if(_loc9_ == 2)
         {
            _loc25_ = StringManager.getInstance().getMessageString("Text0");
            _loc26_ = StringManager.getInstance().getMessageString("Text1");
            _loc27_ = _loc18_._MinAssault;
            _loc28_ = _loc18_._MaxAssault;
            _loc29_ = _loc18_._MinRange;
            _loc30_ = _loc18_._MaxRange;
            _loc19_ = "<font color=\'#ccba7a\'>" + _loc25_ + "</font>" + "　" + "<font color=\'#ffffff\'>" + _loc27_ + "-" + _loc28_ + "</font>" + "\n" + "<font color=\'#ccba7a\'>" + _loc26_ + "</font>" + "　" + "<font color=\'#ffffff\'>" + _loc29_ + "-" + _loc30_ + "</font>";
            this.tip.SuspendID_text.htmlText = _loc19_;
         }
         else if(_loc9_ == 3)
         {
            _loc19_ = "<font color=\'#ffffff\'>";
            _loc19_ = _loc19_ + _loc18_.Comment + "</font>";
            this.tip.SuspendID_text.htmlText = _loc19_;
         }
         this.tip.pdd(this.pdqztj,_loc8_,_loc9_);
         var _loc20_:BitmapData = new BitmapData(this.tip.width + 50,this.tip.height + 50,true,0);
         _loc20_.draw(this.tip);
         var _loc21_:Bitmap = new Bitmap(_loc20_);
         var _loc22_:MovieClip = new MovieClip();
         _loc22_.addChild(_loc21_);
         _loc22_.mouseEnabled = false;
         _loc22_.x = param1;
         _loc22_.y = param2;
         return _loc22_;
      }
      
      private function MovHd(param1:MouseEvent) : void
      {
         this.tip = this.TipHd(param1.currentTarget.y - 20,param1.currentTarget.y - 20,param1.currentTarget.proid,true);
         this.tip.mouseEnabled = false;
         this.tip.x = param1.currentTarget.x - 20;
         if(param1.currentTarget.x >= 100)
         {
            this.tip.x = param1.currentTarget.x - this.tip.width + 30;
         }
         this.content.addChild(this.tip);
      }
      
      private function MouHd(param1:MouseEvent) : void
      {
         if(this.tip != null)
         {
            if(this.content.contains(this.tip))
            {
               this.content.removeChild(this.tip);
            }
            this.tip = null;
         }
      }
      
      private function upHd(param1:MouseEvent) : void
      {
         var _loc2_:uint = 0;
         while(_loc2_ < this.btnarr.length)
         {
            this.btnarr[_loc2_].gotoAndStop(this.js1);
            this.btnarr[_loc2_].cs = this.js1;
            _loc2_++;
         }
         param1.currentTarget.gotoAndStop(this.js2);
         param1.currentTarget.cs = this.js2;
         this.nnss = param1.currentTarget.ii;
         this.dangqpage = 1;
         this.wdpage = 1;
         this.content.tf_page.text = this.dangqpage + "/" + this.totalpage;
         TextField(this.content.tf_storagepage).text = this.wdpage + "/" + this.total;
         this.fuzhiHd(this.nnss);
         this.junfuzhiHd(this.nnss);
         this.btn_downpage.setBtnDisabled(true);
         this.btn_uppage.setBtnDisabled(true);
         if(this.gezhf >= 25)
         {
            this.btn_downpage.setBtnDisabled(false);
         }
         this.btn_left.setBtnDisabled(true);
         this.btn_right.setBtnDisabled(true);
         if(GamePlayer.getInstance().PropsCorpsPack > 25)
         {
            this.btn_right.setBtnDisabled(false);
         }
      }
      
      private function fuzhiHd(param1:uint) : void
      {
         var _loc3_:propsInfo = null;
         this.goodsarr.length = 0;
         var _loc2_:uint = 0;
         while(_loc2_ < ScienceSystem.getinstance().Packarr.length)
         {
            _loc3_ = CPropsReader.getInstance().GetPropsInfo(ScienceSystem.getinstance().Packarr[_loc2_].PropsId);
            switch(param1)
            {
               case 0:
                  this.goodsarr.push(ScienceSystem.getinstance().Packarr[_loc2_]);
                  break;
               case 2:
                  if(_loc3_.PackID == 3)
                  {
                     this.goodsarr.push(ScienceSystem.getinstance().Packarr[_loc2_]);
                  }
                  break;
               case 1:
                  if(_loc3_.PackID == 2)
                  {
                     this.goodsarr.push(ScienceSystem.getinstance().Packarr[_loc2_]);
                  }
                  break;
               case 3:
                  if(_loc3_.PackID == 1)
                  {
                     this.goodsarr.push(ScienceSystem.getinstance().Packarr[_loc2_]);
                  }
                  break;
               case 4:
                  if(_loc3_.PackID == 0)
                  {
                     this.goodsarr.push(ScienceSystem.getinstance().Packarr[_loc2_]);
                  }
            }
            _loc2_++;
         }
         this.content.tf_page.text = this.dangqpage + "/" + this.totalpage;
         this.pageHd(this.dangqpage);
      }
      
      private function junfuzhiHd(param1:uint) : void
      {
         var _loc3_:propsInfo = null;
         this.Juntarr.length = 0;
         var _loc2_:uint = 0;
         while(_loc2_ < ScienceSystem.getinstance().Juntarr.length)
         {
            _loc3_ = CPropsReader.getInstance().GetPropsInfo(ScienceSystem.getinstance().Juntarr[_loc2_].PropsId);
            switch(param1)
            {
               case 0:
                  this.Juntarr.push(ScienceSystem.getinstance().Juntarr[_loc2_]);
                  break;
               case 2:
                  if(_loc3_.PackID == 3)
                  {
                     this.Juntarr.push(ScienceSystem.getinstance().Juntarr[_loc2_]);
                  }
                  break;
               case 1:
                  if(_loc3_.PackID == 2)
                  {
                     this.Juntarr.push(ScienceSystem.getinstance().Juntarr[_loc2_]);
                  }
                  break;
               case 3:
                  if(_loc3_.PackID == 1)
                  {
                     this.Juntarr.push(ScienceSystem.getinstance().Juntarr[_loc2_]);
                  }
                  break;
               case 4:
                  if(_loc3_.PackID == 0)
                  {
                     this.Juntarr.push(ScienceSystem.getinstance().Juntarr[_loc2_]);
                  }
            }
            _loc2_++;
         }
         TextField(this.content.tf_storagepage).text = this.wdpage + "/" + this.total;
         this.Warehouse(this.wdpage);
      }
      
      private function ddHd(param1:MouseEvent) : void
      {
         param1.currentTarget.gotoAndStop(3);
      }
      
      private function ovHd(param1:MouseEvent) : void
      {
         var _loc5_:uint = 0;
         if(param1.currentTarget.nns != -1)
         {
            _loc5_ = uint(param1.currentTarget.cs);
            param1.currentTarget.gotoAndStop(_loc5_ + 1);
         }
         if(this.btntip != null && this.content.contains(this.btntip))
         {
            this.content.removeChild(this.btntip);
         }
         this.btntip = new MovieClip();
         var _loc2_:TextField = new TextField();
         this.btntip.addChild(_loc2_);
         var _loc3_:int = int(param1.currentTarget.nns);
         var _loc4_:String = "";
         this.btntip.x = param1.currentTarget.x + 25;
         this.btntip.y = param1.currentTarget.y + 30;
         if(_loc3_ == 0)
         {
            _loc4_ = StringManager.getInstance().getMessageString("BagTXT05");
         }
         else if(_loc3_ == 1)
         {
            _loc4_ = StringManager.getInstance().getMessageString("BagTXT06");
         }
         else if(_loc3_ == 2)
         {
            _loc4_ = StringManager.getInstance().getMessageString("BagTXT07");
         }
         else if(_loc3_ == 3)
         {
            _loc4_ = StringManager.getInstance().getMessageString("BagTXT08");
         }
         else if(_loc3_ == 4)
         {
            _loc4_ = StringManager.getInstance().getMessageString("BagTXT09");
         }
         else if(_loc3_ == -1)
         {
            _loc4_ = StringManager.getInstance().getMessageString("BagTXT10");
            this.btntip.x = param1.currentTarget.x + 10;
            this.btntip.y = param1.currentTarget.y + 10;
         }
         _loc2_.textColor = 16777215;
         _loc2_.x = 2;
         _loc2_.selectable = false;
         _loc2_.autoSize = TextFieldAutoSize.LEFT;
         _loc2_.text = _loc4_;
         this.btntip.graphics.clear();
         this.btntip.graphics.lineStyle(1,479858);
         this.btntip.graphics.beginFill(0,0.7);
         this.btntip.graphics.drawRoundRect(0,0,_loc2_.width + 4,20,2,2);
         this.btntip.graphics.endFill();
         this.content.addChild(this.btntip);
      }
      
      private function ouHd(param1:MouseEvent) : void
      {
         var _loc2_:uint = 0;
         if(param1.currentTarget.nns != -1)
         {
            _loc2_ = uint(param1.currentTarget.cs);
            param1.currentTarget.gotoAndStop(_loc2_);
         }
         if(this.btntip != null && this.content.contains(this.btntip))
         {
            this.content.removeChild(this.btntip);
         }
      }
      
      private function onCloseWnd(param1:MouseEvent) : void
      {
         this.closeHd();
      }
      
      public function closeHd(param1:int = 0, param2:Boolean = true) : void
      {
         if(!param2)
         {
            ScienceSystem.getinstance().Juntarr.length = 0;
         }
         if(CommandercardSceneUI.getinstance().yutiaojian)
         {
            CommandercardSceneUI.getinstance().yutiaojian = false;
            GameKernel.popUpDisplayManager.Hide(instance);
            CommandercardSceneUI.getinstance().removeBackMC();
            if(this.tip != null && this.content.contains(this.tip))
            {
               this.content.removeChild(this.tip);
               this.tip = null;
            }
            this.Hider();
            return;
         }
         if(param1 == 0)
         {
            GameKernel.popUpDisplayManager.Hide(instance);
         }
         else
         {
            GameKernel.popUpDisplayManager.Hide(instance);
         }
         if(this.tip != null && this.content.contains(this.tip))
         {
            this.content.removeChild(this.tip);
            this.tip = null;
         }
         this.Hider();
      }
      
      public function updatejunarr() : void
      {
         this.wdpage = Math.ceil(this.Juntarr.length / 25);
         this.Juntarr.length = 0;
         var _loc1_:uint = 0;
         while(_loc1_ < ScienceSystem.getinstance().Juntarr.length)
         {
            this.Juntarr.push(ScienceSystem.getinstance().Juntarr[_loc1_]);
            _loc1_++;
         }
         this.Warehouse(this.wdpage);
      }
      
      private function Warehouse(param1:int = 1) : void
      {
         var _loc3_:MovieClip = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:Boolean = false;
         var _loc8_:propsInfo = null;
         this.content.btn_bagpop.visible = false;
         var _loc2_:int = GamePlayer.getInstance().PropsCorpsPack;
         if(_loc2_ == 0)
         {
            ScienceSystem.getinstance().Juntarr.length = 0;
            this.Juntarr.length = 0;
         }
         var _loc4_:uint = uint((param1 - 1) * 25);
         while(_loc4_ < param1 * 25)
         {
            this.content["mc_storagebase" + (_loc4_ - (param1 - 1) * 25)].gotoAndStop(1);
            _loc3_ = new MovieClip();
            _loc3_.graphics.clear();
            _loc3_.graphics.beginFill(16711935,0);
            _loc3_.graphics.drawCircle(0,0,2);
            this.qqarr.push(_loc3_);
            this.content.addChild(this.qqarr[_loc4_ - (param1 - 1) * 25]);
            this.qqarr[_loc4_ - (param1 - 1) * 25].x = this.content["mc_storagebase" + (_loc4_ - (param1 - 1) * 25)].x;
            this.qqarr[_loc4_ - (param1 - 1) * 25].y = this.content["mc_storagebase" + (_loc4_ - (param1 - 1) * 25)].y;
            TextField(this.content["mc_storagebase" + (_loc4_ - (param1 - 1) * 25)].tf_num).text = "";
            TextField(this.content["mc_storagebase" + (_loc4_ - (param1 - 1) * 25)].tf_num).selectable = false;
            TextField(this.content["mc_storagebase" + (_loc4_ - (param1 - 1) * 25)].tf_num).mouseEnabled = false;
            this.content["mc_storagebase" + (_loc4_ - (param1 - 1) * 25)].removeEventListener(MouseEvent.ROLL_OVER,this.MovHd);
            this.content["mc_storagebase" + (_loc4_ - (param1 - 1) * 25)].removeEventListener(MouseEvent.ROLL_OUT,this.MouHd);
            if(this.content["mc_storagebase" + (_loc4_ - (param1 - 1) * 25)].mc_base.numChildren > 1)
            {
               this.content["mc_storagebase" + (_loc4_ - (param1 - 1) * 25)].mc_base.removeChildAt(1);
            }
            this.content["mc_storagebase" + (_loc4_ - (param1 - 1) * 25)].mouseEnabled = false;
            this.content["mc_storagebase" + (_loc4_ - (param1 - 1) * 25)].mc_lock.visible = false;
            this.content["mc_storagebase" + (_loc4_ - (param1 - 1) * 25)].typ = 0;
            if(this.Juntarr.length > _loc4_)
            {
               _loc8_ = CPropsReader.getInstance().GetPropsInfo(this.Juntarr[_loc4_].PropsId);
               if(_loc8_.PackID == 1)
               {
                  this.bit = new Bitmap(GameKernel.getTextureInstance(_loc8_.ImageFileName));
                  this.content["mc_storagebase" + (_loc4_ - (param1 - 1) * 25)].colors = _loc8_.CommanderType;
                  this.content["mc_storagebase" + (_loc4_ - (param1 - 1) * 25)].mingz = _loc8_.Name;
                  this.content["mc_storagebase" + (_loc4_ - (param1 - 1) * 25)].Comment = _loc8_.Comment;
                  this.content["mc_storagebase" + (_loc4_ - (param1 - 1) * 25)].leve = _loc8_.Id % 9 + 1;
               }
               else
               {
                  this.bit = new Bitmap(GameKernel.getTextureInstance(_loc8_.ImageFileName));
                  this.content["mc_storagebase" + (_loc4_ - (param1 - 1) * 25)].mingz = _loc8_.Name;
                  this.content["mc_storagebase" + (_loc4_ - (param1 - 1) * 25)].Comment = _loc8_.Comment;
               }
               TextField(this.content["mc_storagebase" + (_loc4_ - (param1 - 1) * 25)].tf_num).text = String(this.Juntarr[_loc4_].PropsNum);
               this.content["mc_storagebase" + (_loc4_ - (param1 - 1) * 25)].mc_base.addChild(this.bit);
               this.bit.width = 40;
               this.bit.height = 40;
               if(this.Juntarr[_loc4_].LockFlag == 1)
               {
                  this.content["mc_storagebase" + (_loc4_ - (param1 - 1) * 25)].mc_lock.visible = true;
               }
               this.content["mc_storagebase" + (_loc4_ - (param1 - 1) * 25)].typ = 1;
               this.content["mc_storagebase" + (_loc4_ - (param1 - 1) * 25)].proid = this.Juntarr[_loc4_].PropsId;
               this.content["mc_storagebase" + (_loc4_ - (param1 - 1) * 25)].num = this.Juntarr[_loc4_].PropsNum;
               this.content["mc_storagebase" + (_loc4_ - (param1 - 1) * 25)].LockFlag = this.Juntarr[_loc4_].LockFlag;
               this.content["mc_storagebase" + (_loc4_ - (param1 - 1) * 25)].addEventListener(MouseEvent.ROLL_OVER,this.MovHd);
               this.content["mc_storagebase" + (_loc4_ - (param1 - 1) * 25)].addEventListener(MouseEvent.ROLL_OUT,this.MouHd);
            }
            _loc5_ = _loc2_ - ScienceSystem.getinstance().Juntarr.length;
            _loc6_ = ScienceSystem.getinstance().Juntarr.length - this.Juntarr.length;
            _loc7_ = true;
            if(_loc4_ >= this.Juntarr.length + _loc5_)
            {
               this.content["mc_storagebase" + (_loc4_ - (param1 - 1) * 25)].gotoAndStop(3);
               this.content["mc_storagebase" + (_loc4_ - (param1 - 1) * 25)].typ = 3;
               this.content["mc_storagebase" + (_loc4_ - (param1 - 1) * 25)].buttonMode = false;
               _loc7_ = false;
            }
            this.content.tf_storagegrid.text = String(ScienceSystem.getinstance().Juntarr.length + "/" + _loc2_);
            if(_loc4_ >= _loc2_)
            {
               this.content["mc_storagebase" + (_loc4_ - (param1 - 1) * 25)].gotoAndStop(4);
               this.content["mc_storagebase" + (_loc4_ - (param1 - 1) * 25)].typ = 2;
            }
            this.content["mc_storagebase" + (_loc4_ - (param1 - 1) * 25)].ii = _loc4_ - (param1 - 1) * 25;
            this.content["mc_storagebase" + (_loc4_ - (param1 - 1) * 25)].addEventListener(MouseEvent.CLICK,this.ffHd);
            this.content["mc_storagebase" + (_loc4_ - (param1 - 1) * 25)].dragtype = 1;
            this.content["mc_storagebase" + (_loc4_ - (param1 - 1) * 25)].addEventListener(MouseEvent.MOUSE_DOWN,this.startDragHd);
            if(this.content["mc_storagebase" + (_loc4_ - (param1 - 1) * 25)].typ == 0 || this.content["mc_storagebase" + (_loc4_ - (param1 - 1) * 25)].typ == 2)
            {
               this.content["mc_storagebase" + (_loc4_ - (param1 - 1) * 25)].buttonMode = false;
            }
            else if(_loc7_)
            {
               this.content["mc_storagebase" + (_loc4_ - (param1 - 1) * 25)].buttonMode = true;
            }
            _loc4_++;
         }
         if(_loc2_ < this.maxNum)
         {
            this.total = Math.ceil((_loc2_ + 1) / 25);
         }
         else
         {
            this.total = Math.ceil(_loc2_ / 25);
         }
         TextField(this.content.tf_storagepage).text = this.wdpage + "/" + this.total;
         this.btn_left.m_movie.addEventListener(MouseEvent.CLICK,this.llffHd);
         this.btn_right.m_movie.addEventListener(MouseEvent.CLICK,this.rrffHd);
      }
      
      private function llffHd(param1:MouseEvent) : void
      {
         if(this.wdpage == 1)
         {
            return;
         }
         this.btn_right.setBtnDisabled(false);
         --this.wdpage;
         if(this.wdpage == 1)
         {
            this.btn_left.setBtnDisabled(true);
         }
         TextField(this.content.tf_storagepage).text = this.wdpage + "/" + this.total;
         this.Warehouse(this.wdpage);
      }
      
      private function rrffHd(param1:MouseEvent) : void
      {
         if(this.wdpage == this.total)
         {
            return;
         }
         this.btn_left.setBtnDisabled(false);
         if(this.wdpage == this.total - 1)
         {
            this.btn_right.setBtnDisabled(true);
         }
         ++this.wdpage;
         TextField(this.content.tf_storagepage).text = this.wdpage + "/" + this.total;
         this.Warehouse(this.wdpage);
      }
      
      private function ffHd(param1:MouseEvent) : void
      {
         var _loc2_:uint = 0;
         if(this.smc != null && this.content.contains(this.smc))
         {
            this.content.removeChild(this.smc);
         }
         this.content.mc_storagepop.visible = false;
         if(this.tip != null && this.content.contains(this.tip))
         {
            this.content.removeChild(this.tip);
            this.tip = null;
         }
         if(param1.currentTarget.typ == 0 || param1.currentTarget.typ == 2 || param1.currentTarget.typ == 3)
         {
            this.content.mc_storagepop.visible = false;
            this.content.btn_bagpop.visible = false;
            return;
         }
         this.content.btn_bagpop.x = param1.currentTarget.x + 5;
         this.content.btn_bagpop.y = param1.currentTarget.y + 5;
         this.content.btn_bagpop.visible = true;
         this.heise = new MovieClip();
         MoveEfect.getInstance().BlackHd(this.content,this.heise,0);
         this.content.setChildIndex(this.content.btn_bagpop,this.content.numChildren - 1);
         MoveEfect.getInstance().PackYM(this.content.btn_bagpop);
         this.jbtn_look.setBtnDisabled(true);
         if(CPropsReader.getInstance().GetPropsInfo(param1.currentTarget.proid).PackID == 1)
         {
            this.jbtn_look.setBtnDisabled(false);
            this.colors = param1.currentTarget.colors;
            this.leve = param1.currentTarget.leve + 1;
            this.conname = param1.currentTarget.mingz;
            this.concome = param1.currentTarget.Comment;
            this.xx = param1.currentTarget.x;
            this.yy = param1.currentTarget.y;
         }
         this.pronum = param1.currentTarget.num;
         this.prid = param1.currentTarget.proid;
         this.proid = param1.currentTarget.proid;
         this.flg = param1.currentTarget.LockFlag;
         this.ttyy = 1;
         param1.currentTarget.gotoAndStop(5);
         this.mer = param1.currentTarget.ii;
         if(ScienceSystem.getinstance().Packarr.length >= GamePlayer.getInstance().PropsPack)
         {
            this.ffbtn.setBtnDisabled(true);
            _loc2_ = 0;
            while(_loc2_ < this.goodsarr.length)
            {
               if(this.prid == this.goodsarr[_loc2_].PropsId)
               {
                  this.ffbtn.setBtnDisabled(false);
               }
               _loc2_++;
            }
            return;
         }
         this.ffbtn.setBtnDisabled(false);
      }
      
      private function fhbtnHd(param1:MouseEvent) : void
      {
         this.content.btn_bagpop.visible = false;
         this.content["mc_storagebase" + this.mer].gotoAndStop(1);
         this.Hider();
      }
      
      private function ffbtnHd(param1:MouseEvent) : void
      {
         this.content.btn_bagpop.visible = false;
         this.Hider();
         var _loc2_:int = UpdateResource.getInstance().MoveMax(this.prid,this.flg);
         if(this.pronum > 1)
         {
            this.heise = new MovieClip();
            MoveEfect.getInstance().BlackHd(this.content,this.heise);
            FriendspeedpopupUI.getInstance().Init();
            FriendspeedpopupUI.getInstance().Show();
            if(_loc2_ < this.pronum)
            {
               FriendspeedpopupUI.getInstance().pdd(_loc2_,this.prid,this.flg,1);
            }
            else
            {
               FriendspeedpopupUI.getInstance().pdd(this.pronum,this.prid,this.flg,1);
            }
            return;
         }
         if(_loc2_ == 0)
         {
            return;
         }
         var _loc3_:MSG_REQUEST_PROPSMOVE = new MSG_REQUEST_PROPSMOVE();
         _loc3_.SeqId = GamePlayer.getInstance().seqID++;
         _loc3_.Guid = GamePlayer.getInstance().Guid;
         _loc3_.Type = 1;
         _loc3_.PropsId = this.prid;
         _loc3_.PropsNum = this.pronum;
         _loc3_.LockFlag = this.flg;
         NetManager.Instance().sendObject(_loc3_);
      }
   }
}

