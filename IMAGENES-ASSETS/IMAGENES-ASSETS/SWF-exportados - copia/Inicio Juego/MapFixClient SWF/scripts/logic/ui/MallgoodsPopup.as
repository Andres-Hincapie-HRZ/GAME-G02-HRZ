package logic.ui
{
   import com.star.frameworks.events.ActionEvent;
   import com.star.frameworks.managers.StringManager;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import logic.entry.HButton;
   import logic.entry.MObject;
   import logic.entry.ScienceSystem;
   import logic.game.GameKernel;
   import logic.game.GameMouseZoneManager;
   import logic.manager.GameInterActiveManager;
   import logic.reader.CPropsReader;
   import logic.utils.RegisteredData;
   
   public class MallgoodsPopup extends AbstractPopUp
   {
      
      private static var instance:MallgoodsPopup;
      
      private var content:MovieClip = new MovieClip();
      
      private var mobj:Object = new Object();
      
      private var arr:Array = new Array();
      
      private var bit:Bitmap;
      
      private var tip:MovieClip;
      
      private var mm:MovieClip = new MovieClip();
      
      public function MallgoodsPopup()
      {
         super();
         setPopUpName("MallgoodsPopup");
      }
      
      public static function getInstance() : MallgoodsPopup
      {
         if(instance == null)
         {
            instance = new MallgoodsPopup();
         }
         return instance;
      }
      
      override public function Init() : void
      {
         if(GameKernel.popUpDisplayManager.PopDisplayList.ContainsKey(getPopUpName()))
         {
            return;
         }
         this._mc = new MObject("PropawardPop",380,320);
         this.initMcElement();
         GameKernel.popUpDisplayManager.Regisger(instance);
      }
      
      override public function initMcElement() : void
      {
         this.content = this._mc.getMC();
         this.mm.mouseEnabled = false;
         var _loc1_:HButton = new HButton(this.content.btn_close);
         _loc1_.m_movie.addEventListener(MouseEvent.CLICK,this.clHd);
         var _loc2_:HButton = new HButton(this.content.btn_bag);
         _loc2_.m_movie.addEventListener(MouseEvent.CLICK,this.bagHd);
         _loc2_.m_movie.addEventListener(MouseEvent.ROLL_OVER,this.rooHd);
         _loc2_.m_movie.addEventListener(MouseEvent.ROLL_OUT,this.rouHd);
      }
      
      public function pdd(param1:Object) : void
      {
         var _loc2_:Object = null;
         this.mobj = param1;
         this.arr.length = 0;
         if(this.mobj.gas > 0)
         {
            _loc2_ = new Object();
            _loc2_.mm = this.mobj.gas;
            _loc2_.typ = 0;
            this.arr.push(_loc2_);
         }
         if(this.mobj.mony > 0)
         {
            _loc2_ = new Object();
            _loc2_.mm = this.mobj.mony;
            _loc2_.typ = 1;
            this.arr.push(_loc2_);
         }
         if(this.mobj.metal > 0)
         {
            _loc2_ = new Object();
            _loc2_.mm = this.mobj.metal;
            _loc2_.typ = 2;
            this.arr.push(_loc2_);
         }
         if(this.mobj.AwardCoins > 0)
         {
            _loc2_ = new Object();
            _loc2_.typ = 4;
            _loc2_.mm = this.mobj.AwardCoins;
            this.arr.push(_loc2_);
         }
         if(this.mobj.AwardBadge > 0)
         {
            _loc2_ = new Object();
            _loc2_.typ = 5;
            _loc2_.mm = this.mobj.AwardBadge;
            this.arr.push(_loc2_);
         }
         if(this.mobj.AwardHonor > 0)
         {
            _loc2_ = new Object();
            _loc2_.typ = 6;
            _loc2_.mm = this.mobj.AwardHonor;
            this.arr.push(_loc2_);
         }
         if(this.mobj.AwardActiveCredit > 0)
         {
            _loc2_ = new Object();
            _loc2_.typ = 7;
            _loc2_.mm = this.mobj.AwardActiveCredit;
            this.arr.push(_loc2_);
         }
         if(this.mobj.PirateMoney > 0)
         {
            _loc2_ = new Object();
            _loc2_.typ = 8;
            _loc2_.mm = this.mobj.PirateMoney;
            this.arr.push(_loc2_);
         }
         var _loc3_:uint = 0;
         while(_loc3_ < this.mobj.len)
         {
            _loc2_ = new Object();
            _loc2_.proid = this.mobj.arr[_loc3_];
            _loc2_.num = this.mobj.num[_loc3_];
            _loc2_.typ = 3;
            this.arr.push(_loc2_);
            _loc3_++;
         }
         var _loc4_:int = 1;
         var _loc5_:uint = uint((_loc4_ - 1) * 6);
         while(_loc5_ < _loc4_ * 6)
         {
            this.content["mc_list" + (_loc5_ - (_loc4_ - 1) * 6)].gotoAndStop(1);
            if(this.content["mc_list" + (_loc5_ - (_loc4_ - 1) * 6)].mc_base.numChildren > 1)
            {
               this.content["mc_list" + (_loc5_ - (_loc4_ - 1) * 6)].mc_base.removeChildAt(1);
            }
            this.content["mc_list" + (_loc5_ - (_loc4_ - 1) * 6)].removeEventListener(MouseEvent.MOUSE_OVER,this.MovHd);
            this.content["mc_list" + (_loc5_ - (_loc4_ - 1) * 6)].removeEventListener(MouseEvent.ROLL_OUT,this.MouHd);
            this.content["mc_list" + (_loc5_ - (_loc4_ - 1) * 6)].tf_num.selectable = false;
            if(_loc5_ < this.arr.length)
            {
               if(this.arr[_loc5_].typ == 3)
               {
                  this.content["mc_list" + (_loc5_ - (_loc4_ - 1) * 6)].tf_num.text = String(this.arr[_loc5_].num);
                  this.bit = new Bitmap(GameKernel.getTextureInstance(CPropsReader.getInstance().GetPropsInfo(this.arr[_loc5_].proid).ImageFileName));
                  this.content["mc_list" + (_loc5_ - (_loc4_ - 1) * 6)].mingz = CPropsReader.getInstance().GetPropsInfo(this.arr[_loc5_].proid).Name;
                  this.content["mc_list" + (_loc5_ - (_loc4_ - 1) * 6)].Comment = CPropsReader.getInstance().GetPropsInfo(this.arr[_loc5_].proid).Comment;
                  this.content["mc_list" + (_loc5_ - (_loc4_ - 1) * 6)].mc_base.addChild(this.bit);
               }
               else
               {
                  this.content["mc_list" + (_loc5_ - (_loc4_ - 1) * 6)].tf_num.text = RegisteredData.getInstance().MoneyDouHao(this.arr[_loc5_].mm);
                  this.content["mc_list" + (_loc5_ - (_loc4_ - 1) * 6)].mm = this.arr[_loc5_].mm;
                  if(this.arr[_loc5_].typ == 0)
                  {
                     this.bit = new Bitmap(GameKernel.getTextureInstance("BattleHe3"));
                  }
                  else if(this.arr[_loc5_].typ == 1)
                  {
                     this.bit = new Bitmap(GameKernel.getTextureInstance("BattleGold"));
                  }
                  else if(this.arr[_loc5_].typ == 2)
                  {
                     this.bit = new Bitmap(GameKernel.getTextureInstance("BattleMetal"));
                  }
                  else if(this.arr[_loc5_].typ == 4)
                  {
                     this.bit = new Bitmap(GameKernel.getTextureInstance("Props30"));
                  }
                  else if(this.arr[_loc5_].typ == 5)
                  {
                     this.bit = new Bitmap(GameKernel.getTextureInstance("Props37"));
                  }
                  else if(this.arr[_loc5_].typ == 6)
                  {
                     this.bit = new Bitmap(GameKernel.getTextureInstance("Props39"));
                  }
                  else if(this.arr[_loc5_].typ == 7)
                  {
                     this.bit = new Bitmap(GameKernel.getTextureInstance("Props50"));
                  }
                  else if(this.arr[_loc5_].typ == 8)
                  {
                     this.bit = new Bitmap(GameKernel.getTextureInstance("haidaojinbin"));
                  }
                  this.content["mc_list" + (_loc5_ - (_loc4_ - 1) * 6)].mc_base.addChild(this.bit);
               }
               this.content["mc_list" + (_loc5_ - (_loc4_ - 1) * 6)].typ = this.arr[_loc5_].typ;
               this.content["mc_list" + (_loc5_ - (_loc4_ - 1) * 6)].proid = this.arr[_loc5_].proid;
               this.content["mc_list" + (_loc5_ - (_loc4_ - 1) * 6)].addEventListener(MouseEvent.ROLL_OVER,this.MovHd);
               this.content["mc_list" + (_loc5_ - (_loc4_ - 1) * 6)].addEventListener(MouseEvent.ROLL_OUT,this.MouHd);
            }
            _loc5_++;
         }
      }
      
      private function rooHd(param1:MouseEvent) : void
      {
         GameInterActiveManager.InstallInterActiveEvent(param1.currentTarget,ActionEvent.ACTION_MOUSE_OVER,GameMouseZoneManager.ShowTip);
      }
      
      private function rouHd(param1:MouseEvent) : void
      {
         GameInterActiveManager.InstallInterActiveEvent(param1.currentTarget,ActionEvent.ACTION_MOUSE_OUT,GameMouseZoneManager.HideTip);
      }
      
      private function MovHd(param1:MouseEvent) : void
      {
         var _loc2_:TextField = null;
         var _loc3_:* = null;
         if(param1.currentTarget.typ != 3)
         {
            this.mm.graphics.clear();
            this.mm.graphics.lineStyle(1,479858);
            this.mm.graphics.beginFill(0,0.7);
            this.mm.graphics.drawRoundRect(20,20,150,25,5,5);
            this.mm.graphics.endFill();
            _loc2_ = new TextField();
            _loc2_.textColor = 16777215;
            _loc2_.selectable = false;
            _loc2_.autoSize = TextFieldAutoSize.LEFT;
            _loc3_ = "";
            if(param1.currentTarget.typ == 0)
            {
               _loc3_ = StringManager.getInstance().getMessageString("BagTXT13") + "  ";
               _loc2_.text = StringManager.getInstance().getMessageString("BagTXT14") + _loc3_ + param1.currentTarget.mm;
            }
            else if(param1.currentTarget.typ == 1)
            {
               _loc3_ = StringManager.getInstance().getMessageString("BagTXT12") + "  ";
               _loc2_.text = StringManager.getInstance().getMessageString("BagTXT14") + _loc3_ + param1.currentTarget.mm;
            }
            else if(param1.currentTarget.typ == 2)
            {
               _loc3_ = StringManager.getInstance().getMessageString("BagTXT11") + "  ";
               _loc2_.text = StringManager.getInstance().getMessageString("BagTXT14") + _loc3_ + param1.currentTarget.mm;
            }
            else if(param1.currentTarget.typ == 5)
            {
               _loc3_ = StringManager.getInstance().getMessageString("BagTXT24") + "  ";
               _loc2_.text = StringManager.getInstance().getMessageString("BagTXT14") + _loc3_ + param1.currentTarget.mm;
            }
            else if(param1.currentTarget.typ == 6)
            {
               _loc3_ = StringManager.getInstance().getMessageString("BagTXT29") + "  ";
               _loc2_.text = StringManager.getInstance().getMessageString("BagTXT14") + _loc3_ + param1.currentTarget.mm;
            }
            else if(param1.currentTarget.typ == 7)
            {
               _loc3_ = StringManager.getInstance().getMessageString("BagTXT32") + "  ";
               _loc2_.text = StringManager.getInstance().getMessageString("BagTXT14") + _loc3_ + param1.currentTarget.mm;
            }
            else if(param1.currentTarget.typ == 8)
            {
               _loc3_ = StringManager.getInstance().getMessageString("Boss49") + "  ";
               _loc2_.text = StringManager.getInstance().getMessageString("BagTXT14") + _loc3_ + param1.currentTarget.mm;
            }
            else if(param1.currentTarget.typ == 4)
            {
               _loc3_ = StringManager.getInstance().getMessageString("BagTXT31") + "  ";
               _loc2_.text = StringManager.getInstance().getMessageString("BagTXT14") + _loc3_ + param1.currentTarget.mm;
            }
            this.content.addChild(this.mm);
            this.mm.addChild(_loc2_);
            this.mm.x = param1.currentTarget.x - 18;
            this.mm.y = param1.currentTarget.y + 20;
            this.mm.mouseEnabled = false;
            _loc2_.x = 23;
            _loc2_.y = 23;
            return;
         }
         this.tip = PackUi.getInstance().TipHd(param1.currentTarget.x + 20,param1.currentTarget.y - 20,param1.currentTarget.proid,true);
         this.tip.x = param1.currentTarget.x + 20;
         this.tip.y = param1.currentTarget.y + 20;
         this.content.addChild(this.tip);
      }
      
      private function MouHd(param1:MouseEvent) : void
      {
         var _loc2_:uint = 0;
         if(this.tip != null && this.content.contains(this.tip))
         {
            this.content.removeChild(this.tip);
         }
         if(this.mm != null && this.content.contains(this.mm))
         {
            _loc2_ = 0;
            while(_loc2_ < this.mm.numChildren)
            {
               this.mm.removeChildAt(0);
               _loc2_++;
            }
            this.content.removeChild(this.mm);
         }
      }
      
      private function bagHd(param1:MouseEvent) : void
      {
         if(ScienceSystem.getinstance().yutiaojian == false)
         {
            this.close(1);
            return;
         }
         this.close(1);
         GameMouseZoneManager.NagivateToolBarByName("btn_storage",true);
      }
      
      private function clHd(param1:MouseEvent) : void
      {
         if(ScienceSystem.getinstance().yutiaojian == false)
         {
            this.close(1);
         }
         else
         {
            this.close();
         }
      }
      
      public function close(param1:int = 0) : void
      {
         if(this.tip != null && this.content.contains(this.tip))
         {
            this.content.removeChild(this.tip);
         }
         if(param1 == 0)
         {
            GameKernel.popUpDisplayManager.Hide(instance);
         }
         else
         {
            GameKernel.popUpDisplayManager.Hide(instance);
         }
         PackUi.getInstance().Bralock(true);
      }
   }
}

