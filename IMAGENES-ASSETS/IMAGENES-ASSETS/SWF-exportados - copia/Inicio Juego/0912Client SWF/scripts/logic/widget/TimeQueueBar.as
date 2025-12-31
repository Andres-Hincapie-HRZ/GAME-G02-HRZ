package logic.widget
{
   import com.star.frameworks.display.Container;
   import com.star.frameworks.events.ActionEvent;
   import com.star.frameworks.managers.StringManager;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import logic.game.GameKernel;
   import logic.manager.GameInterActiveManager;
   import logic.reader.CPropsReader;
   import logic.ui.tip.CustomTip;
   import net.msg.constructionMsg.MSG_RESP_TIMEQUEUE_TEMP;
   
   public class TimeQueueBar
   {
      
      private var mBuff:Container;
      
      private var mBitMap:Bitmap;
      
      private var mTmp:MSG_RESP_TIMEQUEUE_TEMP;
      
      private var mRemainTime:int;
      
      private var mIsCompleted:Boolean;
      
      private var mTxt:String;
      
      public function TimeQueueBar(param1:MSG_RESP_TIMEQUEUE_TEMP)
      {
         super();
         this.mTmp = param1;
         this.mRemainTime = this.mTmp.SpareTime--;
         this.initBuffIcon();
      }
      
      public function get Type() : int
      {
         if(this.mTmp)
         {
            return this.mTmp.Type;
         }
         return -1;
      }
      
      public function get RemainTime() : int
      {
         return this.mTmp.SpareTime;
      }
      
      public function get IsCompleted() : Boolean
      {
         return this.mIsCompleted;
      }
      
      public function get TimeQueue() : MSG_RESP_TIMEQUEUE_TEMP
      {
         return this.mTmp;
      }
      
      private function initBuffIcon() : void
      {
         var _loc1_:BitmapData = null;
         var _loc2_:String = null;
         if(this.mTmp.Type == 6)
         {
            _loc2_ = "Props49";
         }
         else
         {
            _loc2_ = CPropsReader.getInstance().GetPropsInfo(BufferQueueManager.toolList[this.mTmp.Type]).ImageFileName;
         }
         if(this.mTmp.Type == 0)
         {
            _loc1_ = GameKernel.getTextureInstance(_loc2_);
            this.mTxt = StringManager.getInstance().getMessageString("BuildingText5") + "\n" + StringManager.getInstance().getMessageString("BuildingText6") + StringManager.wrapperString(DataWidget.localToDataZone(this.mTmp.SpareTime),"#ff0000");
         }
         else if(this.mTmp.Type == 1)
         {
            _loc1_ = GameKernel.getTextureInstance(_loc2_);
            this.mTxt = StringManager.getInstance().getMessageString("BuildingText5") + "\n" + StringManager.getInstance().getMessageString("BuildingText6") + StringManager.wrapperString(DataWidget.localToDataZone(this.mTmp.SpareTime),"#ff0000");
         }
         else if(this.mTmp.Type == 2)
         {
            _loc1_ = GameKernel.getTextureInstance(_loc2_);
            this.mTxt = StringManager.getInstance().getMessageString("ItemText0") + "\n" + StringManager.getInstance().getMessageString("BuildingText6") + StringManager.wrapperString(DataWidget.localToDataZone(this.mTmp.SpareTime),"#ff0000");
         }
         else if(this.mTmp.Type == 3)
         {
            _loc1_ = GameKernel.getTextureInstance(_loc2_);
            this.mTxt = StringManager.getInstance().getMessageString("ItemText1") + "\n" + StringManager.getInstance().getMessageString("BuildingText6") + StringManager.wrapperString(DataWidget.localToDataZone(this.mTmp.SpareTime),"#ff0000");
         }
         else if(this.mTmp.Type == 4)
         {
            _loc1_ = GameKernel.getTextureInstance(_loc2_);
            this.mTxt = StringManager.getInstance().getMessageString("ItemText2") + "\n" + StringManager.getInstance().getMessageString("BuildingText6") + StringManager.wrapperString(DataWidget.localToDataZone(this.mTmp.SpareTime),"#ff0000");
         }
         else if(this.mTmp.Type == 5)
         {
            _loc1_ = GameKernel.getTextureInstance(_loc2_);
            this.mTxt = StringManager.getInstance().getMessageString("ItemText15") + "\n" + StringManager.getInstance().getMessageString("BuildingText6") + StringManager.wrapperString(DataWidget.localToDataZone(this.mTmp.SpareTime),"#ff0000");
         }
         else if(this.mTmp.Type == 6)
         {
            _loc1_ = GameKernel.getTextureInstance(_loc2_);
            this.mTxt = StringManager.getInstance().getMessageString("ItemText24") + "\n" + StringManager.getInstance().getMessageString("BuildingText6") + StringManager.wrapperString(DataWidget.localToDataZone(this.mTmp.SpareTime),"#ff0000");
         }
         else if(this.mTmp.Type == 7)
         {
            _loc1_ = GameKernel.getTextureInstance(_loc2_);
            this.mTxt = StringManager.getInstance().getMessageString("Boss31") + "\n" + StringManager.getInstance().getMessageString("BuildingText6") + StringManager.wrapperString(DataWidget.localToDataZone(this.mTmp.SpareTime),"#ff0000");
         }
         else if(this.mTmp.Type >= 10)
         {
            _loc1_ = GameKernel.getTextureInstance(_loc2_);
            this.mTxt = StringManager.getInstance().getMessageString("Boss" + int(27 + this.mTmp.Type - 10)) + "\n" + StringManager.getInstance().getMessageString("BuildingText6") + StringManager.wrapperString(DataWidget.localToDataZone(this.mTmp.SpareTime),"#ff0000");
         }
         this.mBuff = new Container();
         this.mBuff.name = "BuffIcon" + this.mTmp.Type;
         this.mBuff.setEnable(true);
         this.mBitMap = new Bitmap(_loc1_);
         this.mBuff.addChild(this.mBitMap);
         this.mBuff.scaleX = this.mBuff.scaleY = 0.7;
         GameInterActiveManager.InstallInterActiveEvent(this.mBuff,ActionEvent.ACTION_MOUSE_OVER,this.onOver);
         GameInterActiveManager.InstallInterActiveEvent(this.mBuff,ActionEvent.ACTION_MOUSE_OUT,this.onOut);
      }
      
      public function setProgress() : void
      {
         var _loc1_:int = 0;
         var _loc2_:String = null;
         if(--this.mTmp.SpareTime > 0)
         {
            if(BufferQueueManager.curSelectTargetType != -1)
            {
               switch(BufferQueueManager.curSelectTargetType)
               {
                  case 0:
                     if(this.mTmp.Type == 0)
                     {
                        _loc1_ = BufferQueueManager.getInstance().getTimeQueueSpareTime(this.mTmp.Type);
                        _loc2_ = StringManager.getInstance().getMessageString("BuildingText5") + "\n" + StringManager.getInstance().getMessageString("BuildingText6") + StringManager.wrapperString(DataWidget.localToDataZone(_loc1_),"#ff0000");
                        CustomTip.GetInstance().Update(_loc2_);
                     }
                     break;
                  case 1:
                     if(this.mTmp.Type == 1)
                     {
                        _loc1_ = BufferQueueManager.getInstance().getTimeQueueSpareTime(this.mTmp.Type);
                        _loc2_ = StringManager.getInstance().getMessageString("ItemText3") + "\n" + StringManager.getInstance().getMessageString("BuildingText6") + StringManager.wrapperString(DataWidget.localToDataZone(_loc1_),"#ff0000");
                        CustomTip.GetInstance().Update(_loc2_);
                     }
                     break;
                  case 2:
                     if(this.mTmp.Type == 2)
                     {
                        _loc1_ = BufferQueueManager.getInstance().getTimeQueueSpareTime(this.mTmp.Type);
                        _loc2_ = StringManager.getInstance().getMessageString("ItemText0") + "\n" + StringManager.getInstance().getMessageString("BuildingText6") + StringManager.wrapperString(DataWidget.localToDataZone(_loc1_),"#ff0000");
                        CustomTip.GetInstance().Update(_loc2_);
                     }
                     break;
                  case 3:
                     if(this.mTmp.Type == 3)
                     {
                        _loc1_ = BufferQueueManager.getInstance().getTimeQueueSpareTime(this.mTmp.Type);
                        _loc2_ = StringManager.getInstance().getMessageString("ItemText1") + "\n" + StringManager.getInstance().getMessageString("BuildingText6") + StringManager.wrapperString(DataWidget.localToDataZone(_loc1_),"#ff0000");
                        CustomTip.GetInstance().Update(_loc2_);
                     }
                     break;
                  case 4:
                     if(this.mTmp.Type == 4)
                     {
                        _loc1_ = BufferQueueManager.getInstance().getTimeQueueSpareTime(this.mTmp.Type);
                        _loc2_ = StringManager.getInstance().getMessageString("ItemText2") + "\n" + StringManager.getInstance().getMessageString("BuildingText6") + StringManager.wrapperString(DataWidget.localToDataZone(_loc1_),"#ff0000");
                        CustomTip.GetInstance().Update(_loc2_);
                     }
                     break;
                  case 5:
                     if(this.mTmp.Type == 5)
                     {
                        _loc1_ = BufferQueueManager.getInstance().getTimeQueueSpareTime(this.mTmp.Type);
                        _loc2_ = StringManager.getInstance().getMessageString("ItemText15") + "\n" + StringManager.getInstance().getMessageString("BuildingText6") + StringManager.wrapperString(DataWidget.localToDataZone(_loc1_),"#ff0000");
                        CustomTip.GetInstance().Update(_loc2_);
                     }
                     break;
                  case 6:
                     if(this.mTmp.Type == 6)
                     {
                        _loc1_ = BufferQueueManager.getInstance().getTimeQueueSpareTime(this.mTmp.Type);
                        _loc2_ = StringManager.getInstance().getMessageString("ItemText24") + "\n" + StringManager.getInstance().getMessageString("BuildingText6") + StringManager.wrapperString(DataWidget.localToDataZone(_loc1_),"#ff0000");
                        CustomTip.GetInstance().Update(_loc2_);
                     }
                     break;
                  case 7:
                     if(this.mTmp.Type == 7)
                     {
                        _loc1_ = BufferQueueManager.getInstance().getTimeQueueSpareTime(this.mTmp.Type);
                        _loc2_ = StringManager.getInstance().getMessageString("Boss31") + "\n" + StringManager.getInstance().getMessageString("BuildingText6") + StringManager.wrapperString(DataWidget.localToDataZone(_loc1_),"#ff0000");
                        CustomTip.GetInstance().Update(_loc2_);
                     }
               }
               if(BufferQueueManager.curSelectTargetType >= 10)
               {
                  _loc1_ = BufferQueueManager.getInstance().getTimeQueueSpareTime(BufferQueueManager.curSelectTargetType);
                  _loc2_ = StringManager.getInstance().getMessageString("Boss" + int(27 + BufferQueueManager.curSelectTargetType - 10)) + "\n" + StringManager.getInstance().getMessageString("BuildingText6") + StringManager.wrapperString(DataWidget.localToDataZone(_loc1_),"#ff0000");
                  CustomTip.GetInstance().Update(_loc2_);
               }
            }
         }
         else
         {
            this.mIsCompleted = true;
            CustomTip.GetInstance().Hide();
         }
      }
      
      private function onOver(param1:MouseEvent) : void
      {
         BufferQueueManager.curSelectTargetType = this.mTmp.Type;
         var _loc2_:Point = this.getDisplay().localToGlobal(new Point());
         _loc2_.x += this.getDisplay().width;
         _loc2_.y += this.getDisplay().height;
         var _loc3_:int = BufferQueueManager.getInstance().getTimeQueueSpareTime(BufferQueueManager.curSelectTargetType);
         if(this.mTmp.Type == 0)
         {
            this.mTxt = StringManager.getInstance().getMessageString("BuildingText5") + "\n" + StringManager.getInstance().getMessageString("BuildingText6") + StringManager.wrapperString(DataWidget.localToDataZone(_loc3_),"#ff0000");
         }
         else if(this.mTmp.Type == 1)
         {
            this.mTxt = StringManager.getInstance().getMessageString("ItemText3") + "\n" + StringManager.getInstance().getMessageString("BuildingText6") + StringManager.wrapperString(DataWidget.localToDataZone(_loc3_),"#ff0000");
         }
         else if(this.mTmp.Type == 2)
         {
            this.mTxt = StringManager.getInstance().getMessageString("ItemText0") + "\n" + StringManager.getInstance().getMessageString("BuildingText6") + StringManager.wrapperString(DataWidget.localToDataZone(_loc3_),"#ff0000");
         }
         else if(this.mTmp.Type == 3)
         {
            this.mTxt = StringManager.getInstance().getMessageString("ItemText1") + "\n" + StringManager.getInstance().getMessageString("BuildingText6") + StringManager.wrapperString(DataWidget.localToDataZone(_loc3_),"#ff0000");
         }
         else if(this.mTmp.Type == 4)
         {
            this.mTxt = StringManager.getInstance().getMessageString("ItemText2") + "\n" + StringManager.getInstance().getMessageString("BuildingText6") + StringManager.wrapperString(DataWidget.localToDataZone(_loc3_),"#ff0000");
         }
         else if(this.mTmp.Type == 6)
         {
            this.mTxt = StringManager.getInstance().getMessageString("ItemText24") + "\n" + StringManager.getInstance().getMessageString("BuildingText6") + StringManager.wrapperString(DataWidget.localToDataZone(_loc3_),"#ff0000");
         }
         else if(this.mTmp.Type == 7)
         {
            this.mTxt = StringManager.getInstance().getMessageString("Boss31") + "\n" + StringManager.getInstance().getMessageString("BuildingText6") + StringManager.wrapperString(DataWidget.localToDataZone(_loc3_),"#ff0000");
         }
         else if(this.mTmp.Type >= 10)
         {
            this.mTxt = StringManager.getInstance().getMessageString("Boss" + int(27 + this.mTmp.Type - 10)) + "\n" + StringManager.getInstance().getMessageString("BuildingText6") + StringManager.wrapperString(DataWidget.localToDataZone(_loc3_),"#ff0000");
         }
         CustomTip.GetInstance().Show(this.mTxt,_loc2_);
      }
      
      private function onOut(param1:MouseEvent) : void
      {
         BufferQueueManager.curSelectTargetType = -1;
         CustomTip.GetInstance().Update("");
         CustomTip.GetInstance().Hide();
      }
      
      public function Destory() : void
      {
         GameInterActiveManager.unInstallnterActiveEvent(this.mBuff,ActionEvent.ACTION_MOUSE_OVER,this.onOver);
         GameInterActiveManager.unInstallnterActiveEvent(this.mBuff,ActionEvent.ACTION_MOUSE_OUT,this.onOut);
         this.mBuff.removeChild(this.mBitMap);
         this.mBitMap.bitmapData.dispose();
         this.mBitMap = null;
         this.mBuff = null;
      }
      
      public function getDisplay() : Container
      {
         return this.mBuff;
      }
   }
}

