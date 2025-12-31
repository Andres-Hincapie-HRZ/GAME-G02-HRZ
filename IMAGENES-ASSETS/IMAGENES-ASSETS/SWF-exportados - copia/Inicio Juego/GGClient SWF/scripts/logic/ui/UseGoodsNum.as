package logic.ui
{
   import com.star.frameworks.events.ActionEvent;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import logic.entry.GamePlayer;
   import logic.entry.HButton;
   import logic.entry.ScienceSystem;
   import logic.game.GameKernel;
   import logic.impl.IModulePopUp;
   import logic.manager.GameInterActiveManager;
   import net.base.NetManager;
   import net.msg.sciencesystem.MSG_REQUEST_USEPROPS;
   
   public class UseGoodsNum implements IModulePopUp
   {
      
      private static var instance:UseGoodsNum;
      
      private var content:MovieClip;
      
      private var obj:Object;
      
      private var bit:Bitmap;
      
      private var MaxNum:int = 0;
      
      private var jy:int = 0;
      
      private var btn_front:HButton;
      
      private var btn_next:HButton;
      
      private var proid:int;
      
      private var flg:int;
      
      private var mc_build:HButton;
      
      protected var _popWnd:MovieClip;
      
      private var mc_cancel:HButton;
      
      public function UseGoodsNum()
      {
         super();
      }
      
      public static function getInstance() : UseGoodsNum
      {
         if(instance == null)
         {
            instance = new UseGoodsNum();
         }
         return instance;
      }
      
      public function Init() : void
      {
         if(this._popWnd)
         {
            GameInterActiveManager.unInstallnterActiveEvent(this.mc_build.m_movie,ActionEvent.ACTION_CLICK,this.onHandler);
            GameInterActiveManager.unInstallnterActiveEvent(this.mc_cancel.m_movie,ActionEvent.ACTION_CLICK,this.onHandler);
            return;
         }
         this._popWnd = GameKernel.getMovieClipInstance("BatchusePop");
         this._popWnd.x = GameKernel.getInstance().stage.stageWidth - this._popWnd.width * 0.5 >> 1;
         this._popWnd.x += this._popWnd.width * 0.25 + GameKernel.fullRect.x;
         this._popWnd.y = 300;
         this.initMcElement();
      }
      
      public function initMcElement() : void
      {
         this.content = this._popWnd;
         this.mc_cancel = new HButton(this.content.btn_cancel);
         this.mc_build = new HButton(this.content.btn_ensure);
         this.btn_front = new HButton(this.content.btn_front);
         this.btn_next = new HButton(this.content.btn_next);
         TextField(this.content.tf_num).restrict = "0-9";
         TextField(this.content.tf_num).addEventListener(Event.CHANGE,this.changeHd);
         this.btn_front.m_movie.addEventListener(MouseEvent.CLICK,this.tzHd);
         this.btn_next.m_movie.addEventListener(MouseEvent.CLICK,this.tzHd);
         GameInterActiveManager.unInstallnterActiveEvent(this.mc_build.m_movie,ActionEvent.ACTION_CLICK,this.onHandler);
         GameInterActiveManager.unInstallnterActiveEvent(this.mc_cancel.m_movie,ActionEvent.ACTION_CLICK,this.onHandler);
      }
      
      public function pdd(param1:Object) : void
      {
         this.mc_build.setBtnDisabled(false);
         this.obj = param1;
         this.bit = new Bitmap(GameKernel.getTextureInstance(this.obj.bit));
         if(this.content.mc_base.numChildren >= 2)
         {
            this.content.mc_base.removeChildAt(1);
         }
         this.content.mc_base.addChild(this.bit);
         this.MaxNum = this.obj.num;
         this.proid = this.obj.proid;
         this.flg = this.obj.flg;
         this.content.tf_num.text = 1;
         this.content.tf_content.htmlText = String(this.obj.con);
         this.pdbtnHd(1);
      }
      
      private function tzHd(param1:MouseEvent) : void
      {
         if(param1.currentTarget.name == "btn_next")
         {
            if(this.content.tf_num.text < this.MaxNum)
            {
               this.content.tf_num.text = this.MaxNum.toString();
            }
         }
         else if(this.content.tf_num.text > 1)
         {
            this.content.tf_num.text = 1;
         }
         this.jy = this.content.tf_num.text;
         this.pdbtnHd(this.jy);
      }
      
      private function pdbtnHd(param1:int = 0) : void
      {
         this.btn_front.setBtnDisabled(false);
         this.btn_next.setBtnDisabled(false);
         if(param1 == 1 && param1 == this.MaxNum)
         {
            this.btn_front.setBtnDisabled(true);
            this.btn_next.setBtnDisabled(true);
         }
         else if(param1 == 1 && param1 < this.MaxNum)
         {
            this.btn_front.setBtnDisabled(true);
            this.btn_next.setBtnDisabled(false);
         }
         else
         {
            if(param1 > 1 && param1 < this.MaxNum)
            {
               return;
            }
            if(param1 > 1 && param1 == this.MaxNum)
            {
               this.btn_front.setBtnDisabled(false);
               this.btn_next.setBtnDisabled(true);
            }
         }
      }
      
      private function changeHd(param1:Event) : void
      {
         if(this.content.tf_num.text == "")
         {
            this.content.tf_num.text = this.jy;
         }
         if(this.content.tf_num.text >= this.MaxNum)
         {
            this.content.tf_num.text = this.MaxNum.toString();
         }
         else if(this.content.tf_num.text <= 0)
         {
            this.content.tf_num.text = 1;
         }
         this.jy = this.content.tf_num.text;
         this.pdbtnHd(this.jy);
      }
      
      private function ssuHd(param1:MouseEvent) : void
      {
         this.mc_build.setBtnDisabled(true);
         PackUi.getInstance().Hider();
         ScienceSystem.getinstance().yutiaojian = false;
         var _loc2_:MSG_REQUEST_USEPROPS = new MSG_REQUEST_USEPROPS();
         _loc2_.SeqId = GamePlayer.getInstance().seqID++;
         _loc2_.Guid = GamePlayer.getInstance().Guid;
         _loc2_.PropsId = this.proid;
         _loc2_.LockFlag = this.flg;
         _loc2_.Num = int(this.content.tf_num.text);
         NetManager.Instance().sendObject(_loc2_);
         this.Hide(true);
      }
      
      private function closeHd(param1:MouseEvent) : void
      {
         this.Hide(true);
         PackUi.getInstance().Hider(1);
      }
      
      public function Show() : void
      {
         if(GameKernel.renderManager.getUI().getContainer().contains(this._popWnd))
         {
            return;
         }
         this.AddEvent();
         GameKernel.renderManager.lockScene(true);
         GameKernel.renderManager.getUI().addComponent(this._popWnd);
      }
      
      public function Hide(param1:Boolean = true) : void
      {
         if(GameKernel.renderManager.getUI().getContainer().contains(this._popWnd))
         {
            GameKernel.renderManager.getUI().removeComponent(this._popWnd);
            GameKernel.renderManager.lockScene(false);
            this.Remove();
         }
      }
      
      public function getModulePopUp() : DisplayObject
      {
         return this._popWnd;
      }
      
      public function AddEvent() : void
      {
         GameInterActiveManager.InstallInterActiveEvent(this.mc_build.m_movie,ActionEvent.ACTION_CLICK,this.onHandler);
         GameInterActiveManager.InstallInterActiveEvent(this.mc_cancel.m_movie,ActionEvent.ACTION_CLICK,this.onHandler);
      }
      
      public function Remove() : void
      {
         GameInterActiveManager.unInstallnterActiveEvent(this.mc_build.m_movie,ActionEvent.ACTION_CLICK,this.onHandler);
         GameInterActiveManager.unInstallnterActiveEvent(this.mc_cancel.m_movie,ActionEvent.ACTION_CLICK,this.onHandler);
      }
      
      private function onHandler(param1:MouseEvent) : void
      {
         this.mc_build.setBtnDisabled(false);
         switch(param1.target.name)
         {
            case "btn_ensure":
               this.ssuHd(param1);
               this.Hide();
               break;
            case "btn_cancel":
               this.closeHd(param1);
         }
      }
   }
}

