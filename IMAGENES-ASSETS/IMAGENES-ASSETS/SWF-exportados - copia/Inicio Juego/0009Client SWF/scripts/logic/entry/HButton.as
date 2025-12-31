package logic.entry
{
   import com.star.frameworks.managers.FontManager;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextFormat;
   import logic.ui.SelectTargetUI;
   import logic.ui.tip.CustomTip;
   
   public class HButton
   {
      
      public var m_selsected:Boolean = false;
      
      public var m_statue:String = "up";
      
      public var m_movie:MovieClip;
      
      public var m_name:String;
      
      public var m_type:int = 1;
      
      private var m_selectedMc:MovieClip;
      
      private var m_signSelectedIcon:Boolean;
      
      private var m_tipTextFormat:TextFormat;
      
      private var m_tipText:String;
      
      private var m_allowShow:Boolean;
      
      private var m_TipCustomWidth:int;
      
      public var m_isShow:Boolean = true;
      
      public function HButton(param1:MovieClip, param2:int = 2, param3:Boolean = false, param4:String = "", param5:Boolean = false, param6:int = 0)
      {
         super();
         this.m_tipTextFormat = FontManager.getInstance().getContentFmt();
         this.m_movie = param1;
         this.m_movie.mouseChildren = false;
         this.m_movie.mouseEnabled = true;
         this.m_movie.tabChildren = false;
         this.m_movie.tabEnabled = false;
         this.m_movie.cacheAsBitmap = true;
         this.m_movie.buttonMode = true;
         this.m_name = param1.name;
         this.m_type = param2;
         this.m_signSelectedIcon = param3;
         this.m_tipText = param4;
         this.m_TipCustomWidth = param6;
         this.m_allowShow = param5;
         this.InitListener();
         this.m_movie.gotoAndStop("up");
      }
      
      public function get selsected() : Boolean
      {
         return this.m_selsected;
      }
      
      private function InitListener() : void
      {
         this.m_movie.addEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
         this.m_movie.addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
         this.m_movie.addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
         this.m_movie.addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
      }
      
      private function onMouseUp(param1:MouseEvent) : void
      {
         if(this.m_statue == HButtonStatue.DISABLED)
         {
            return;
         }
         if(this.m_type == HButtonType.SELECT)
         {
            this.setSelect(!this.selsected);
            if(this.m_signSelectedIcon)
            {
               if(!this.m_selectedMc)
               {
                  this.m_selectedMc = SelectTargetUI.instance.selectedMc;
                  SelectTargetUI.instance.addFrameEvent();
                  this.m_movie.addChild(this.m_selectedMc);
               }
               this.m_movie.addChild(this.m_selectedMc);
            }
         }
         else
         {
            this.m_movie.gotoAndStop("over");
            this.m_statue = HButtonStatue.OVER;
            this.m_selsected = false;
            if(Boolean(this.m_selectedMc) && Boolean(this.m_movie.getChildByName("selected")))
            {
               this.m_movie.removeChild(this.m_movie.getChildByName("selected"));
               this.m_selectedMc = null;
               SelectTargetUI.instance.removeFrameEvent();
            }
         }
      }
      
      private function onMouseDown(param1:MouseEvent) : void
      {
         if(this.m_statue == HButtonStatue.DISABLED)
         {
            return;
         }
         if(this.selsected)
         {
            return;
         }
         this.m_movie.gotoAndStop("down");
         this.m_statue = HButtonStatue.DOWN;
         CustomTip.GetInstance().Hide();
      }
      
      private function onMouseOver(param1:MouseEvent) : void
      {
         var _loc2_:Point = null;
         if(this.m_tipText != "")
         {
            if(CustomTip.isShow)
            {
               CustomTip.GetInstance().Hide();
            }
            else
            {
               _loc2_ = this.m_movie.localToGlobal(new Point(0,this.m_movie.height / this.m_movie.scaleY));
               CustomTip.GetInstance().Show(this.m_tipText,_loc2_,false,this.m_TipCustomWidth);
            }
         }
         if(this.m_statue == HButtonStatue.DISABLED)
         {
            return;
         }
         if(this.selsected)
         {
            return;
         }
         this.m_movie.gotoAndStop("over");
         this.m_statue = HButtonStatue.OVER;
      }
      
      private function onMouseOut(param1:MouseEvent) : void
      {
         CustomTip.GetInstance().Hide();
         if(this.m_statue == HButtonStatue.DISABLED)
         {
            return;
         }
         if(this.selsected)
         {
            return;
         }
         this.m_movie.gotoAndStop("up");
         this.m_statue = HButtonStatue.UP;
      }
      
      public function setSelect(param1:Boolean) : void
      {
         if(param1)
         {
            this.m_movie.gotoAndStop("selected");
            this.m_statue = HButtonStatue.SELECTED;
            this.m_selsected = true;
            if(this.m_signSelectedIcon)
            {
               if(this.m_selectedMc == null)
               {
                  this.m_selectedMc = SelectTargetUI.instance.selectedMc;
                  SelectTargetUI.instance.addFrameEvent();
               }
               this.m_movie.addChild(this.m_selectedMc);
            }
         }
         else
         {
            this.m_movie.gotoAndStop("up");
            this.m_statue = HButtonStatue.UP;
            this.m_selsected = false;
            if(Boolean(this.m_selectedMc) && Boolean(this.m_movie.getChildByName("selected")))
            {
               this.m_movie.removeChild(this.m_selectedMc);
               this.m_selectedMc = null;
               SelectTargetUI.instance.removeFrameEvent();
            }
         }
      }
      
      public function setVisible(param1:Boolean) : void
      {
         this.m_movie.visible = param1;
      }
      
      public function setBtnDisabled(param1:Boolean) : void
      {
         if(param1)
         {
            this.m_movie.gotoAndStop("disabled");
            this.m_movie.mouseEnabled = false;
            this.m_statue = HButtonStatue.DISABLED;
         }
         else
         {
            this.m_movie.gotoAndStop("up");
            this.m_movie.mouseEnabled = true;
            this.m_statue = HButtonStatue.UP;
         }
         this.m_isShow = true;
      }
      
      public function get tipTextFormat() : TextFormat
      {
         return this.m_tipTextFormat;
      }
      
      public function SetTip(param1:String) : void
      {
         this.m_tipText = param1;
      }
      
      public function GetTip() : String
      {
         return this.m_tipText;
      }
   }
}

