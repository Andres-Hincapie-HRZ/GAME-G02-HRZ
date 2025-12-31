package logic.ui
{
   import com.star.frameworks.events.ActionEvent;
   import com.star.frameworks.managers.ResManager;
   import com.star.frameworks.managers.StringManager;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.utils.Timer;
   import logic.action.ConstructionAction;
   import logic.entry.FBModel;
   import logic.entry.GamePlayer;
   import logic.entry.HButton;
   import logic.entry.HButtonType;
   import logic.entry.MObject;
   import logic.entry.ScienceSystem;
   import logic.entry.props.propsInfo;
   import logic.game.GameCommandManager;
   import logic.game.GameKernel;
   import logic.manager.InstanceManager;
   import logic.reader.CPropsReader;
   import logic.ui.info.BleakingLineForThai;
   import logic.ui.tip.CaptionTip;
   import logic.utils.UpdateResource;
   import logic.widget.NotifyWidget;
   import net.base.NetManager;
   import net.msg.task.MSG_REQUEST_GAINDAILYAWARD;
   import net.msg.task.MSG_REQUEST_TASKGAIN;
   import net.msg.task.MSG_REQUEST_TASKINFO;
   import net.msg.task.MSG_RESP_GAINDAILYAWARD;
   import net.msg.task.MSG_RESP_TASKGAIN;
   import net.msg.task.MSG_RESP_TASKINFO;
   import net.msg.task.MSG_RESP_TASKINFO_TEMP;
   
   public class TaskSceneUI extends AbstractPopUp
   {
      
      private static var instance:TaskSceneUI;
      
      public static var _TaskName:String;
      
      private var SelectedTypeButton:XButton;
      
      private var SelectedTaskButton:XButton;
      
      private var SelectedType:int;
      
      private var btn_task0:XButton;
      
      private var btn_task1:XButton;
      
      private var btn_task2:XButton;
      
      private var btn_task3:XButton;
      
      private var btn_achieve:XButton;
      
      private var btn_main:XButton;
      
      private var btn_left:HButton;
      
      private var btn_right:HButton;
      
      private var tf_page:TextField;
      
      private var PageIndex:int;
      
      private var PageCount:int;
      
      private var Comment1:String;
      
      private var Comment2:String;
      
      private var He3:int;
      
      private var Metal:int;
      
      private var Money:int;
      
      private var PropsId:int;
      
      private var PropsNum:int;
      
      private var SelectedPage:int;
      
      private var MsgTaskInfo:MSG_RESP_TASKINFO;
      
      private var MainTaskData:MSG_RESP_TASKINFO_TEMP;
      
      private var SelectedTaskData:MSG_RESP_TASKINFO_TEMP;
      
      private var PropsPoint:Point;
      
      private var ExtentTaskList:Array = new Array();
      
      private var EctypeTaskList:Array = new Array();
      
      private var _PropsTip:MovieClip;
      
      private var _isShow:Boolean;
      
      private var _Timer:Timer;
      
      private var NormalColor:int = 13417082;
      
      private var SpecialColor1:int = 65280;
      
      private var SpecialColor2:int = 65280;
      
      private var SpecialColor3:int = 6710886;
      
      private var EctypeTask1:XButton;
      
      private var PropsMcBase:MovieClip;
      
      private var LocationArray:Array;
      
      private var LactionId:int;
      
      private var mc_daytask:MovieClip;
      
      private var tf_tasktxt:TextField;
      
      private var tf_describe:TextField;
      
      private var btn_daytask:HButton;
      
      private var MaintaskPlan:MovieClip;
      
      private var CopytaskPlan:MovieClip;
      
      private var PointCount:int;
      
      private var MainTaskList:Array = new Array();
      
      public var TaskCountCallback:Function;
      
      private var bGetTaskCount:Boolean = false;
      
      private var CanAwardList:Array = new Array();
      
      public function TaskSceneUI()
      {
         super();
         this._isShow = false;
         setPopUpName("TaskSceneUI");
      }
      
      public static function getInstance() : TaskSceneUI
      {
         if(instance == null)
         {
            instance = new TaskSceneUI();
         }
         return instance;
      }
      
      public function StartTaskTimer() : void
      {
         this._Timer = new Timer(3 * 60 * 1000);
         this._Timer.addEventListener(TimerEvent.TIMER,this.OnTimer);
      }
      
      public function set IsShow(param1:Boolean) : void
      {
         this._isShow = param1;
      }
      
      private function OnTimer(param1:Event) : void
      {
         this.RequestTaskList();
      }
      
      override public function Init() : void
      {
         NotifyWidget.getInstance().removeNotify(1);
         if(GameKernel.popUpDisplayManager.PopDisplayList.ContainsKey(getPopUpName()))
         {
            this.Clear();
            this.FirstShow();
            return;
         }
         this._mc = new MObject("TaskScene",385,300);
         this.initMcElement();
         GameKernel.popUpDisplayManager.Regisger(instance);
         this.Clear();
         this.FirstShow();
      }
      
      public function ShowProgressTask() : void
      {
         this.Init();
         GameKernel.popUpDisplayManager.Show(this);
         this.btn_task0Click(null,this.btn_task0);
      }
      
      public function ShowDayTask() : void
      {
         this.Init();
         GameKernel.popUpDisplayManager.Show(this);
         this.btn_task3Click(null,this.btn_task3);
      }
      
      override public function initMcElement() : void
      {
         var _loc1_:MovieClip = null;
         var _loc2_:XButton = null;
         var _loc3_:CaptionTip = null;
         var _loc4_:TextField = null;
         _loc1_ = this._mc.getMC().getChildByName("btn_close") as MovieClip;
         _loc2_ = new XButton(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.CloseClick);
         _loc1_ = this._mc.getMC().getChildByName("btn_achieve") as MovieClip;
         this.btn_achieve = new XButton(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.btn_achieveClick);
         _loc1_ = this._mc.getMC().getChildByName("btn_task0") as MovieClip;
         this.btn_task0 = new XButton(_loc1_);
         this.btn_task0.OnClick = this.btn_task0Click;
         _loc1_ = this._mc.getMC().getChildByName("btn_task1") as MovieClip;
         this.btn_task1 = new XButton(_loc1_);
         this.btn_task1.OnClick = this.btn_task1Click;
         this.btn_task1.setBtnDisabled(true);
         _loc1_ = this._mc.getMC().getChildByName("btn_task2") as MovieClip;
         this.btn_task2 = new XButton(_loc1_);
         this.btn_task2.OnClick = this.btn_task2Click;
         this.btn_task2.setBtnDisabled(true);
         _loc1_ = this._mc.getMC().getChildByName("btn_task3") as MovieClip;
         this.btn_task3 = new XButton(_loc1_);
         this.btn_task3.OnClick = this.btn_task3Click;
         _loc1_ = this._mc.getMC().getChildByName("btn_left") as MovieClip;
         this.btn_left = new HButton(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.btn_leftClick);
         _loc1_ = this._mc.getMC().getChildByName("btn_right") as MovieClip;
         this.btn_right = new HButton(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.btn_rightClick);
         this.tf_page = this._mc.getMC().getChildByName("tf_page") as TextField;
         this.tf_tasktxt = this._mc.getMC().getChildByName("tf_tasktxt") as TextField;
         this.tf_describe = this._mc.getMC().getChildByName("tf_describe") as TextField;
         this.InitTaskUi();
         this.InitEctypeTaskUi();
         this.InitAward();
         MovieClip(this._mc.getMC().mc_res).stop();
         MovieClip(this._mc.getMC().mc_prop).stop();
         this.PropsMcBase = this._mc.getMC().mc_prop.getChildByName("mc_base") as MovieClip;
         this.PropsMcBase.addEventListener(MouseEvent.MOUSE_OVER,this.PropsImgMouseOver);
         this.PropsMcBase.addEventListener(MouseEvent.MOUSE_OUT,this.PropsImgMouseOut);
         this.PropsPoint = this.PropsMcBase.localToGlobal(new Point(0,50));
         this.LocationArray = new Array();
         _loc3_ = new CaptionTip(this._mc.getMC().mc_res.mc_metal,StringManager.getInstance().getMessageString("ShipText8"));
         this.LocationArray.push(new Point(this._mc.getMC().mc_res.mc_metal.x,this._mc.getMC().mc_res.mc_metal.y));
         _loc3_ = new CaptionTip(this._mc.getMC().mc_res.mc_gold,StringManager.getInstance().getMessageString("ShipText10"));
         this.LocationArray.push(new Point(this._mc.getMC().mc_res.mc_gold.x,this._mc.getMC().mc_res.mc_gold.y));
         _loc3_ = new CaptionTip(this._mc.getMC().mc_res.mc_He3,StringManager.getInstance().getMessageString("ShipText9"));
         this.LocationArray.push(new Point(this._mc.getMC().mc_res.mc_He3.x,this._mc.getMC().mc_res.mc_He3.y));
         _loc3_ = new CaptionTip(this._mc.getMC().mc_res.mc_giftmoney,StringManager.getInstance().getMessageString("ShipText26"));
         this.LocationArray.push(new Point(this._mc.getMC().mc_res.mc_giftmoney.x,this._mc.getMC().mc_res.mc_giftmoney.y));
         _loc3_ = new CaptionTip(this._mc.getMC().mc_res.mc_metal0,StringManager.getInstance().getMessageString("TaskText7"));
         _loc4_ = this._mc.getMC().getChildByName("tf_content") as TextField;
         _loc4_.addEventListener(ActionEvent.ACTION_TEXT_LINK,this.tf_contentClick);
      }
      
      private function InitTaskUi() : void
      {
         var _loc1_:MovieClip = null;
         var _loc2_:XButton = null;
         this.MaintaskPlan = GameKernel.getMovieClipInstance("MaintaskPlan");
         _loc1_ = this.MaintaskPlan.getChildByName("mc_maintask") as MovieClip;
         this.btn_main = new XButton(_loc1_);
         this.btn_main.data = -1;
         this.btn_main.OnClick = this.MainTaskClick;
         var _loc3_:int = 0;
         while(_loc3_ < 6)
         {
            _loc1_ = this.MaintaskPlan.getChildByName("mc_list" + _loc3_) as MovieClip;
            _loc2_ = new XButton(_loc1_);
            _loc2_.data = _loc3_;
            _loc2_.OnClick = this.TaskListClick;
            _loc3_++;
         }
      }
      
      private function InitEctypeTaskUi() : void
      {
         var _loc1_:MovieClip = null;
         var _loc2_:XButton = null;
         this.CopytaskPlan = GameKernel.getMovieClipInstance("CopytaskPlan");
         _loc1_ = this.CopytaskPlan.getChildByName("btn_daytask") as MovieClip;
         this.btn_daytask = new HButton(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.btn_daytaskClick);
         var _loc3_:int = 0;
         while(_loc3_ < 8)
         {
            _loc1_ = this.CopytaskPlan.getChildByName("mc_list" + _loc3_) as MovieClip;
            _loc2_ = new XButton(_loc1_);
            _loc2_.data = _loc3_;
            _loc2_.OnClick = this.EctypeTaskListClick;
            if(_loc3_ == 0)
            {
               this.EctypeTask1 = _loc2_;
            }
            _loc3_++;
         }
      }
      
      private function PropsImgMouseOver(param1:MouseEvent) : void
      {
         var _loc2_:Point = this._mc.getMC().globalToLocal(this.PropsPoint);
         this._PropsTip = PackUi.getInstance().TipHd(_loc2_.x,_loc2_.y,this.PropsId,true);
         this._PropsTip.x = _loc2_.x - 20;
         this._PropsTip.y = _loc2_.y - 20;
         this._mc.getMC().addChild(this._PropsTip);
      }
      
      private function PropsImgMouseOut(param1:MouseEvent) : void
      {
         if(this._PropsTip != null && this._mc.getMC().contains(this._PropsTip))
         {
            this._mc.getMC().removeChild(this._PropsTip);
         }
      }
      
      private function FirstShow() : void
      {
         this.RequestTaskList();
         this._isShow = true;
         this.btn_task0Click(null,this.btn_task0);
      }
      
      private function ShowPageButton() : void
      {
         if(this.PageCount == 0)
         {
            this.tf_page.text = "";
            this.btn_right.setBtnDisabled(true);
            this.btn_left.setBtnDisabled(true);
            return;
         }
         if(this.PageIndex > 0)
         {
            this.btn_left.setBtnDisabled(false);
         }
         else
         {
            this.btn_left.setBtnDisabled(true);
         }
         if(this.PageIndex + 1 < this.PageCount)
         {
            this.btn_right.setBtnDisabled(false);
         }
         else
         {
            this.btn_right.setBtnDisabled(true);
         }
         this.tf_page.text = this.PageIndex + 1 + "/" + this.PageCount;
      }
      
      private function CloseClick(param1:Event) : void
      {
         this._isShow = false;
         GameKernel.popUpDisplayManager.Hide(this);
      }
      
      private function ShowTaskUi(param1:MovieClip) : void
      {
         var _loc2_:MovieClip = this._mc.getMC().mc_base as MovieClip;
         if(_loc2_.numChildren > 0)
         {
            _loc2_.removeChildAt(0);
         }
         _loc2_.addChild(param1);
      }
      
      private function btn_achieveClick(param1:Event) : void
      {
         var _loc3_:int = 0;
         if(this.MsgTaskInfo == null)
         {
            return;
         }
         if(this.PropsId != -1)
         {
            _loc3_ = UpdateResource.getInstance().HasPackSpace(this.PropsId,1,this.PropsNum);
            if(_loc3_ == 1)
            {
               MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("CommanderText12"),10);
               return;
            }
            if(_loc3_ == 2)
            {
               MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("BattleTXT11"),0);
               return;
            }
         }
         this.btn_achieve.setBtnDisabled(true);
         var _loc2_:MSG_REQUEST_TASKGAIN = new MSG_REQUEST_TASKGAIN();
         if(this.SelectedTaskData == this.MainTaskData)
         {
            _loc2_.Type = 0;
         }
         else
         {
            _loc2_.Type = 1;
         }
         _loc2_.TaskId = this.SelectedTaskData.TaskId;
         _loc2_.SeqId = GamePlayer.getInstance().seqID++;
         _loc2_.Guid = GamePlayer.getInstance().Guid;
         NetManager.Instance().sendObject(_loc2_);
         if(this.SelectedTaskData.Type != 2 && this.SelectedTaskData.TaskId == 0)
         {
            EnjoyUi.getInstance().PublishMessage(StringManager.getInstance().getMessageString("EmailText32"),StringManager.getInstance().getMessageString("EmailText17"),StringManager.getInstance().getMessageString("EmailText18"),"TaskIcon",StringManager.getInstance().getMessageString("Boss6"));
         }
      }
      
      private function AddToPack(param1:int, param2:int) : void
      {
         UpdateResource.getInstance().AddToPack(param1,param2,1);
      }
      
      public function RespTaskGain(param1:MSG_RESP_TASKGAIN) : void
      {
         var _loc2_:int = 0;
         var _loc3_:MSG_RESP_TASKINFO_TEMP = null;
         var _loc4_:XML = null;
         var _loc5_:MSG_RESP_TASKINFO_TEMP = null;
         ConstructionAction.getInstance().addResource(param1.Gas,param1.Metal,param1.Money,0);
         GamePlayer.getInstance().coins = GamePlayer.getInstance().coins + param1.Coins;
         if(param1.PropsId >= 0)
         {
            this.AddToPack(param1.PropsId,param1.PropsNum);
         }
         if(param1.Type == 0)
         {
            if(param1.NextTaskId == -1)
            {
               this.MainTaskData.CompleteFlag = 1;
               this.MainTaskData.GainFlag = 1;
            }
            else
            {
               this.MainTaskData.TaskId = param1.NextTaskId;
               this.MainTaskData.CompleteFlag = param1.CompleteFlag;
               this.MainTaskData.GainFlag = 0;
            }
            this.ShowMainTask();
            this.GetMainTaskList();
            this.ResetExtentTaskList();
            this.ShowTaskList();
         }
         else if(param1.TaskId < 1000)
         {
            _loc2_ = 0;
            while(_loc2_ < this.ExtentTaskList.length)
            {
               _loc3_ = this.ExtentTaskList[_loc2_];
               if(_loc3_.TaskId == param1.TaskId)
               {
                  if(_loc3_.TaskId == 500)
                  {
                  }
                  _loc4_ = this.GetExtendTask(_loc3_.TaskId,_loc3_.LevelId + 1);
                  if(_loc4_ != null)
                  {
                     ++_loc3_.LevelId;
                     _loc3_.CompleteFlag = param1.CompleteFlag;
                     _loc3_.GainFlag = 0;
                     if(!this.CheckExtentTask(_loc4_))
                     {
                        this.ExtentTaskList.splice(_loc2_,1);
                     }
                     break;
                  }
                  _loc3_.CompleteFlag = 1;
                  _loc3_.GainFlag = 1;
                  this.ExtentTaskList.splice(_loc2_,1);
                  break;
               }
               _loc2_++;
            }
            this.ShowTaskList();
         }
         else
         {
            for each(_loc5_ in this.EctypeTaskList)
            {
               if(_loc5_.TaskId == param1.TaskId)
               {
                  --_loc5_.Type;
                  if(_loc5_.Type > 0)
                  {
                     _loc5_.LevelId = param1.NextTaskId;
                     _loc5_.CompleteFlag = 0;
                     _loc5_.GainFlag = 0;
                  }
                  else
                  {
                     _loc5_.CompleteFlag = 1;
                     _loc5_.GainFlag = 1;
                  }
               }
            }
            this.ShowEctypeTask();
         }
         if(this.SelectedTaskButton != null)
         {
            this.SelectedTaskButton.setSelect(false);
         }
         if(this.SelectedTaskButton == null || !this.SelectedTaskButton.m_movie.visible)
         {
            if(this.SelectedType == 0)
            {
               this.SelectedTaskButton = this.btn_main;
            }
            else
            {
               this.ShowEctypeTaskInfoById(0);
               this.SetSelectedTaskButton(this.EctypeTask1);
            }
         }
         if(this.SelectedTaskButton.m_movie.visible)
         {
            this.SelectedTaskButton.DoClick();
         }
         this.CallbackTaskCount();
      }
      
      private function CheckExtentTask(param1:XML) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         var _loc2_:int = int(param1.@MainTaskDepend);
         if(_loc2_ == -1)
         {
            return true;
         }
         return this.MainTaskList.indexOf(_loc2_) >= 0;
      }
      
      private function btn_task0Click(param1:MouseEvent, param2:XButton) : void
      {
         this.PageIndex = 0;
         this.ShowTaskUi(this.MaintaskPlan);
         this.SetSelectedTypeButton(param2);
         this.SelectedType = 0;
         this.ShowTask();
      }
      
      private function btn_task1Click(param1:MouseEvent, param2:XButton) : void
      {
         this.SetSelectedTypeButton(param2);
         this.SelectedType = 1;
      }
      
      private function btn_task2Click(param1:MouseEvent, param2:XButton) : void
      {
         this.SetSelectedTypeButton(param2);
         this.SelectedType = 2;
      }
      
      private function btn_task3Click(param1:MouseEvent, param2:XButton) : void
      {
         this.PageIndex = 0;
         this.ShowTaskUi(this.CopytaskPlan);
         this.SetSelectedTypeButton(param2);
         this.SelectedType = 3;
         this.ShowTask();
      }
      
      public function RequestTaskList() : void
      {
         var _loc1_:MSG_REQUEST_TASKINFO = new MSG_REQUEST_TASKINFO();
         _loc1_.SeqId = GamePlayer.getInstance().seqID++;
         _loc1_.Guid = GamePlayer.getInstance().Guid;
         NetManager.Instance().sendObject(_loc1_);
      }
      
      private function Clear() : void
      {
         var _loc2_:TextField = null;
         var _loc3_:MovieClip = null;
         this.MsgTaskInfo = null;
         this.PageIndex = 0;
         this.PageCount = 0;
         this.ShowPageButton();
         this.btn_main.setVisible(false);
         var _loc1_:int = 0;
         while(_loc1_ < 6)
         {
            _loc3_ = this.MaintaskPlan.getChildByName("mc_list" + _loc1_) as MovieClip;
            _loc3_.visible = false;
            _loc1_++;
         }
         _loc2_ = this._mc.getMC().getChildByName("tf_content") as TextField;
         _loc2_.text = "";
         _loc2_ = this._mc.getMC().getChildByName("tf_aim") as TextField;
         _loc2_.text = "";
         _loc2_ = this._mc.getMC().mc_res.getChildByName("tf_metal") as TextField;
         _loc2_.text = "";
         _loc2_ = this._mc.getMC().mc_res.getChildByName("tf_He3") as TextField;
         _loc2_.text = "";
         _loc2_ = this._mc.getMC().mc_res.getChildByName("tf_gold") as TextField;
         _loc2_.text = "";
         this.btn_achieve.setBtnDisabled(true);
      }
      
      public function RespTaskList(param1:MSG_RESP_TASKINFO) : void
      {
         if(!this._isShow)
         {
            this.CheckNewTask(param1);
            this.MsgTaskInfo = param1;
            this.MainTaskData = null;
            if(this.bGetTaskCount == false)
            {
               return;
            }
         }
         this.bGetTaskCount = false;
         this.MsgTaskInfo = param1;
         this.MainTaskData = null;
         this.RespMainTask(param1);
         this.GetMainTaskList();
         this.ResetExtentTaskList();
         this.GetEctypeTaskList();
         this.ShowTask();
         this.CallbackTaskCount();
      }
      
      private function GetEctypeTaskList() : void
      {
         var _loc2_:MSG_RESP_TASKINFO_TEMP = null;
         var _loc3_:XML = null;
         this.PointCount = 0;
         this.EctypeTaskList.splice(0);
         var _loc1_:int = 0;
         while(_loc1_ < this.MsgTaskInfo.DataLen)
         {
            _loc2_ = this.MsgTaskInfo.Data[_loc1_];
            if(_loc2_.Type == 2)
            {
               _loc3_ = this.GetEctypeTask(_loc2_.TaskId,0);
               if(_loc3_.@HideFlag != "1")
               {
                  if(_loc2_.Num > 0)
                  {
                     if(_loc2_.TaskId == 1009)
                     {
                        if(_loc2_.Num == _loc3_.@MaxOperation)
                        {
                           this.PointCount += int(_loc3_.@PointAward);
                        }
                     }
                     else
                     {
                        this.PointCount += _loc3_.@PointAward * _loc2_.Num;
                     }
                     if(_loc2_.Num == _loc3_.@MaxOperation)
                     {
                        _loc2_.CompleteFlag = 2;
                     }
                  }
                  this.EctypeTaskList.push(_loc2_);
               }
            }
            _loc1_++;
         }
         this.EctypeTaskList.sortOn("CompleteFlag",Array.NUMERIC);
      }
      
      private function RespMainTask(param1:MSG_RESP_TASKINFO) : void
      {
         var _loc3_:MSG_RESP_TASKINFO_TEMP = null;
         var _loc2_:int = 0;
         while(_loc2_ < param1.DataLen)
         {
            _loc3_ = param1.Data[_loc2_];
            if(_loc3_.Type == 0)
            {
               this.MainTaskData = _loc3_;
               break;
            }
            _loc2_++;
         }
      }
      
      private function CheckNewTask(param1:MSG_RESP_TASKINFO) : void
      {
         var _loc2_:XML = null;
         var _loc4_:MSG_RESP_TASKINFO_TEMP = null;
         if(this._isShow)
         {
            return;
         }
         this.RespMainTask(param1);
         this.GetMainTaskList();
         var _loc3_:int = 0;
         while(_loc3_ < param1.DataLen)
         {
            _loc4_ = param1.Data[_loc3_];
            if(_loc4_.Type != 2 && _loc4_.CompleteFlag == 1 && _loc4_.GainFlag == 0)
            {
               if(_loc4_.Type == 1)
               {
                  _loc2_ = this.GetExtendTask(_loc4_.TaskId,_loc4_.LevelId);
                  if(_loc2_ == null || this.MainTaskList.indexOf(_loc2_.@MainTaskDepend) < 0)
                  {
                     _loc2_ = null;
                  }
               }
               else
               {
                  _loc2_ = this.GetMainTask(_loc4_.TaskId);
               }
               if(_loc2_ != null)
               {
                  TaskSceneUI._TaskName = _loc2_.@TaskName;
                  NotifyWidget.getInstance().addNotify(1);
                  return;
               }
            }
            _loc3_++;
         }
      }
      
      private function ResetExtentTaskList() : void
      {
         var _loc2_:MSG_RESP_TASKINFO_TEMP = null;
         this.ExtentTaskList.splice(0);
         var _loc1_:int = 0;
         while(_loc1_ < this.MsgTaskInfo.DataLen)
         {
            _loc2_ = this.MsgTaskInfo.Data[_loc1_];
            if(_loc2_.Type == 1 && _loc2_.GainFlag == 0)
            {
               if(this.CheckExtentTask(this.GetExtendTask(_loc2_.TaskId,_loc2_.LevelId)))
               {
                  this.ExtentTaskList.push(_loc2_);
               }
            }
            _loc1_++;
         }
      }
      
      private function SetSelectedTypeButton(param1:XButton) : void
      {
         if(this.SelectedTypeButton != null)
         {
            this.SelectedTypeButton.setSelect(false);
         }
         this.SelectedTypeButton = param1;
         this.SelectedTypeButton.setSelect(true);
      }
      
      private function MainTaskClick(param1:MouseEvent, param2:XButton) : void
      {
         this.ShowTaskTitle();
         if(this.MainTaskData == null)
         {
            return;
         }
         this.SetSelectedTaskButton(this.btn_main);
         var _loc3_:XML = this.GetMainTask(this.MainTaskData.TaskId);
         this.ShowTaskInfo(_loc3_,this.MainTaskData);
      }
      
      private function ShowTaskInfo(param1:XML, param2:MSG_RESP_TASKINFO_TEMP, param3:String = "", param4:String = "") : void
      {
         var _loc7_:TextField = null;
         var _loc9_:propsInfo = null;
         var _loc10_:Bitmap = null;
         this.SelectedTaskData = param2;
         this.Comment1 = param1.@Comment1;
         this.Comment2 = param1.@Comment2;
         this.He3 = param1.@He3Award;
         this.Metal = param1.@MetalAward;
         this.Money = param1.@MoneyAward;
         this.PropsId = param1.@ItemAward;
         var _loc5_:int = int(param1.@PointAward);
         var _loc6_:int = int(param1.@CoinsAward);
         this.PropsNum = param1.@ItemNum;
         if(param4 == null)
         {
            this.Comment2 = "";
         }
         else
         {
            this.Comment2 = this.Comment2.replace("@@1",param4);
         }
         if(param2.CompleteFlag == 0)
         {
            this.btn_achieve.setBtnDisabled(true);
            this.Comment2 += "<font color=\'#FF0000\'>" + StringManager.getInstance().getMessageString("ItemText4");
         }
         else if(param2.TaskId > 1000)
         {
            this.Comment2 += "<font color=\'#00FF00\'>" + StringManager.getInstance().getMessageString("TaskText2");
         }
         else if(param2.GainFlag == 0)
         {
            this.Comment2 += "<font color=\'#00FF00\'>" + StringManager.getInstance().getMessageString("ItemText5");
            this.btn_achieve.setBtnDisabled(false);
         }
         else
         {
            this.Comment2 += "<font color=\'#00FF00\'>" + StringManager.getInstance().getMessageString("ItemText6");
            this.btn_achieve.setBtnDisabled(true);
         }
         _loc7_ = this._mc.getMC().getChildByName("tf_content") as TextField;
         _loc7_.htmlText = this.Comment1.replace("@@1",param3);
         BleakingLineForThai.GetInstance().BleakThaiLanguage(_loc7_,13417082);
         _loc7_ = this._mc.getMC().getChildByName("tf_aim") as TextField;
         _loc7_.htmlText = this.Comment2 + "</font>";
         if(this.Metal == -1 && this.He3 == -1 && this.Money == -1 && _loc6_ == -1)
         {
            MovieClip(this._mc.getMC().mc_res).gotoAndStop("disabled");
         }
         else
         {
            MovieClip(this._mc.getMC().mc_res).gotoAndStop("up");
            this.LactionId = 0;
            this.SetLocation(this.Metal,this._mc.getMC().mc_res.mc_metal,this._mc.getMC().mc_res.tf_metal);
            this.SetLocation(this.Money,this._mc.getMC().mc_res.mc_gold,this._mc.getMC().mc_res.tf_gold);
            this.SetLocation(this.He3,this._mc.getMC().mc_res.mc_He3,this._mc.getMC().mc_res.tf_He3);
            this.SetLocation(_loc6_,this._mc.getMC().mc_res.mc_giftmoney,this._mc.getMC().mc_res.tf_giftgold);
            this.SetLocation(_loc5_,this._mc.getMC().mc_res.mc_metal0,this._mc.getMC().mc_res.tf_jifen);
         }
         var _loc8_:TextField = this._mc.getMC().mc_prop.getChildByName("tf_num") as TextField;
         if(this.PropsId == -1 || this.PropsNum == 0)
         {
            MovieClip(this._mc.getMC().mc_prop).gotoAndStop("disabled");
            this.PropsMcBase.visible = false;
            _loc8_.visible = false;
         }
         else
         {
            MovieClip(this._mc.getMC().mc_prop).gotoAndStop("up");
            this.PropsMcBase.visible = true;
            _loc9_ = CPropsReader.getInstance().GetPropsInfo(this.PropsId);
            _loc10_ = new Bitmap(GameKernel.getTextureInstance(_loc9_.ImageFileName));
            if(this.PropsMcBase.numChildren > 0)
            {
               this.PropsMcBase.removeChildAt(0);
            }
            this.PropsMcBase.addChild(_loc10_);
            _loc8_.visible = true;
            _loc8_.text = this.PropsNum.toString();
         }
      }
      
      private function SetLocation(param1:int, param2:MovieClip, param3:TextField) : void
      {
         if(param1 > 0)
         {
            param3.text = param1.toString();
            param2.visible = true;
            param3.visible = true;
            param2.x = this.LocationArray[this.LactionId].x;
            param2.y = this.LocationArray[this.LactionId].y;
            param3.x = param2.x + param2.width;
            param3.y = param2.y;
            ++this.LactionId;
         }
         else
         {
            param2.visible = false;
            param3.visible = false;
         }
      }
      
      private function TaskListClick(param1:MouseEvent, param2:XButton) : void
      {
         this.ShowTaskTitle();
         if(this.MsgTaskInfo == null)
         {
            return;
         }
         this.SetSelectedTaskButton(param2);
         var _loc3_:int = this.PageIndex * 6 + param2.data;
         if(_loc3_ >= this.ExtentTaskList.length)
         {
            return;
         }
         var _loc4_:MSG_RESP_TASKINFO_TEMP = this.ExtentTaskList[_loc3_];
         var _loc5_:XML = this.GetExtendTask(_loc4_.TaskId,_loc4_.LevelId);
         this.ShowTaskInfo(_loc5_,_loc4_);
      }
      
      private function EctypeTaskListClick(param1:MouseEvent, param2:XButton) : void
      {
         this.ShowTaskTitle();
         if(this.MsgTaskInfo == null)
         {
            return;
         }
         this.SetSelectedTaskButton(param2);
         var _loc3_:int = this.PageIndex * 8 + param2.data;
         if(_loc3_ >= this.EctypeTaskList.length)
         {
            return;
         }
         this.ShowEctypeTaskInfoById(_loc3_);
      }
      
      private function ShowEctypeTaskInfoById(param1:int) : void
      {
         var _loc5_:int = 0;
         var _loc7_:String = null;
         if(param1 >= 0 && param1 >= this.EctypeTaskList.length)
         {
            return;
         }
         var _loc2_:MSG_RESP_TASKINFO_TEMP = this.EctypeTaskList[param1];
         var _loc3_:XML = this.GetEctypeTask(_loc2_.TaskId,0);
         var _loc4_:int = _loc2_.LevelId;
         if(param1 == 1009)
         {
            _loc5_ = _loc2_.Num;
         }
         else
         {
            _loc5_ = _loc3_.@MaxOperation - _loc2_.Num;
         }
         var _loc6_:String = _loc5_.toString();
         var _loc8_:FBModel = InstanceManager.instance.getFBModelByEctype(_loc4_);
         if(_loc8_ != null)
         {
            _loc7_ = _loc8_.Name;
         }
         this.ShowTaskInfo(_loc3_,_loc2_,_loc6_,_loc7_);
         this.btn_achieve.setVisible(false);
      }
      
      private function SetSelectedTaskButton(param1:XButton) : void
      {
         if(this.SelectedTaskButton != null)
         {
            this.SelectedTaskButton.setSelect(false);
         }
         this.SelectedTaskButton = param1;
         this.SelectedTaskButton.setSelect(true);
         this.SelectedPage = this.PageIndex;
      }
      
      private function btn_leftClick(param1:Event) : void
      {
         --this.PageIndex;
         if(this.SelectedType == 0)
         {
            this.ShowTaskList();
         }
         else if(this.SelectedType == 3)
         {
            this.ShowEctypeTask();
         }
      }
      
      private function btn_rightClick(param1:Event) : void
      {
         ++this.PageIndex;
         if(this.SelectedType == 0)
         {
            this.ShowTaskList();
         }
         else if(this.SelectedType == 3)
         {
            this.ShowEctypeTask();
         }
      }
      
      private function ShowMainTask() : void
      {
         if(this.MsgTaskInfo == null)
         {
            return;
         }
         var _loc1_:MovieClip = this.MaintaskPlan.getChildByName("mc_maintask") as MovieClip;
         var _loc2_:TextField = _loc1_.getChildByName("tf_name") as TextField;
         if(this.MainTaskData == null || this.MainTaskData.GainFlag == 1)
         {
            this.btn_main.setVisible(false);
            return;
         }
         this.btn_main.setVisible(true);
         var _loc3_:XML = this.GetMainTask(this.MainTaskData.TaskId);
         _loc2_.text = _loc3_.@TaskName;
         this.SetTaskTextField(_loc2_,this.MainTaskData.CompleteFlag);
      }
      
      private function SetTaskTextField(param1:TextField, param2:int) : void
      {
         var _loc3_:TextFormat = param1.getTextFormat();
         if(param2 == 0)
         {
            _loc3_.color = this.NormalColor;
         }
         else if(param2 == 1)
         {
            _loc3_.color = this.SpecialColor1;
         }
         else if(param2 == 2)
         {
            _loc3_.color = this.SpecialColor2;
         }
         else if(param2 == 3)
         {
            _loc3_.color = this.SpecialColor3;
         }
         param1.setTextFormat(_loc3_);
      }
      
      private function GetMainTaskList() : void
      {
         var _loc3_:XML = null;
         var _loc4_:int = 0;
         this.MainTaskList.splice(0);
         var _loc1_:XML = GameKernel.resManager.getXml(ResManager.GAMERES,"MainTask");
         var _loc2_:XMLList = _loc1_.List[0].children();
         for each(_loc3_ in _loc2_)
         {
            _loc4_ = int(_loc3_.@TaskID);
            this.MainTaskList.push(_loc4_);
            if(_loc3_.@TaskID == this.MainTaskData.TaskId)
            {
               break;
            }
         }
      }
      
      private function GetMainTask(param1:int) : XML
      {
         var _loc2_:XML = null;
         var _loc5_:XML = null;
         var _loc3_:XML = GameKernel.resManager.getXml(ResManager.GAMERES,"MainTask");
         var _loc4_:XMLList = _loc3_.List[0].children();
         for each(_loc5_ in _loc4_)
         {
            if(_loc5_.@TaskID == param1)
            {
               _loc2_ = _loc5_;
               break;
            }
         }
         return _loc2_;
      }
      
      public function GetTaskCount(param1:Function) : void
      {
         this.TaskCountCallback = param1;
         this.Init();
         this.RequestTaskList();
         this._isShow = false;
         this.bGetTaskCount = true;
      }
      
      private function CallbackTaskCount() : void
      {
         var _loc4_:MSG_RESP_TASKINFO_TEMP = null;
         var _loc7_:XML = null;
         if(this.TaskCountCallback == null)
         {
            return;
         }
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(this.MainTaskData != null && this.MainTaskData.CompleteFlag == 0)
         {
            _loc1_++;
         }
         else if(this.MainTaskData != null && this.MainTaskData.CompleteFlag == 1 && this.MainTaskData.GainFlag == 0)
         {
            _loc2_++;
         }
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < this.ExtentTaskList.length)
         {
            _loc4_ = this.ExtentTaskList[_loc3_];
            if(_loc4_.CompleteFlag == 0)
            {
               _loc1_++;
            }
            else if(_loc4_.GainFlag == 0)
            {
               _loc2_++;
            }
            _loc3_++;
         }
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < this.EctypeTaskList.length)
         {
            _loc4_ = this.EctypeTaskList[_loc3_];
            _loc7_ = this.GetEctypeTask(_loc4_.TaskId,0);
            if(_loc4_.Num == 0)
            {
               _loc5_++;
            }
            else if(_loc7_.@MaxOperation == _loc4_.Num)
            {
               _loc6_++;
            }
            else
            {
               _loc5_++;
            }
            _loc3_++;
         }
         this.TaskCountCallback(_loc2_,_loc1_,_loc6_,_loc5_);
      }
      
      private function ShowTaskList() : void
      {
         var _loc3_:MovieClip = null;
         var _loc4_:MSG_RESP_TASKINFO_TEMP = null;
         var _loc5_:XML = null;
         var _loc6_:TextField = null;
         var _loc1_:int = this.PageIndex * 6;
         var _loc2_:int = 0;
         while(_loc2_ < 6)
         {
            _loc3_ = this.MaintaskPlan.getChildByName("mc_list" + _loc2_) as MovieClip;
            if(_loc1_ < this.ExtentTaskList.length)
            {
               _loc4_ = this.ExtentTaskList[_loc1_];
               _loc5_ = this.GetExtendTask(_loc4_.TaskId,_loc4_.LevelId);
               _loc6_ = _loc3_.getChildByName("tf_name") as TextField;
               _loc6_.text = _loc5_.@TaskName;
               this.SetTaskTextField(_loc6_,_loc4_.CompleteFlag);
               _loc3_.visible = true;
            }
            else
            {
               _loc3_.visible = false;
            }
            _loc1_++;
            _loc2_++;
         }
         this.PageCount = this.ExtentTaskList.length / 6;
         if(this.PageCount * 6 < this.ExtentTaskList.length)
         {
            ++this.PageCount;
         }
         this.ShowPageButton();
         if(this.SelectedTaskButton)
         {
            if(this.PageIndex == this.SelectedPage)
            {
               this.SelectedTaskButton.setSelect(true);
            }
            else
            {
               this.SelectedTaskButton.setSelect(false);
            }
         }
      }
      
      private function GetExtendTask(param1:int, param2:int) : XML
      {
         var _loc4_:XML = null;
         var _loc5_:XML = null;
         var _loc6_:XMLList = null;
         var _loc3_:XML = GameKernel.resManager.getXml(ResManager.GAMERES,"ExtendTask");
         for each(_loc5_ in _loc3_.List)
         {
            if(_loc5_.@TaskID == param1)
            {
               _loc6_ = _loc5_.children();
               if(param2 <= _loc6_.length() - 1)
               {
                  _loc4_ = _loc6_[param2];
               }
               break;
            }
         }
         return _loc4_;
      }
      
      private function GetEctypeTask(param1:int, param2:int) : XML
      {
         var _loc4_:XML = null;
         var _loc5_:XML = null;
         var _loc6_:XMLList = null;
         var _loc7_:XML = null;
         var _loc3_:XML = GameKernel.resManager.getXml(ResManager.GAMERES,"DailyTask");
         for each(_loc5_ in _loc3_.List)
         {
            _loc6_ = _loc5_.children();
            for each(_loc7_ in _loc6_)
            {
               if(_loc7_.@TaskID == param1)
               {
                  return _loc7_;
               }
            }
         }
         return _loc4_;
      }
      
      private function ShowTask() : void
      {
         this.SelectedPage = -1;
         if(this.SelectedTaskButton != null)
         {
            this.SelectedTaskButton.setSelect(false);
            this.SelectedTaskButton = null;
         }
         this.PageIndex = 0;
         if(this.SelectedType == 0)
         {
            this.ShowMainTask();
            this.ShowTaskList();
            if(GamePlayer.getInstance().language != 7 && GamePlayer.getInstance().language != 10)
            {
               this.MainTaskClick(null,this.btn_main);
            }
         }
         else
         {
            this.ShowEctypeTask();
            this.btn_daytaskClick(null);
         }
      }
      
      private function ShowEctypeTask() : void
      {
         var _loc3_:MovieClip = null;
         var _loc4_:MSG_RESP_TASKINFO_TEMP = null;
         var _loc5_:XML = null;
         var _loc6_:TextField = null;
         if(this.MsgTaskInfo == null)
         {
            return;
         }
         var _loc1_:int = this.PageIndex * 8;
         var _loc2_:int = 0;
         while(_loc2_ < 8)
         {
            _loc3_ = this.CopytaskPlan.getChildByName("mc_list" + _loc2_) as MovieClip;
            if(_loc1_ < this.EctypeTaskList.length)
            {
               _loc3_.visible = true;
               _loc4_ = this.EctypeTaskList[_loc1_];
               _loc5_ = this.GetEctypeTask(_loc4_.TaskId,0);
               _loc6_ = _loc3_.getChildByName("tf_name") as TextField;
               _loc6_.text = _loc5_.@TaskName;
               if(_loc4_.Num == 0)
               {
                  this.SetTaskTextField(_loc6_,0);
               }
               else if(_loc5_.@MaxOperation == _loc4_.Num)
               {
                  this.SetTaskTextField(_loc6_,3);
               }
               else
               {
                  this.SetTaskTextField(_loc6_,2);
               }
               _loc3_.visible = true;
            }
            else
            {
               _loc3_.visible = false;
            }
            _loc1_++;
            _loc2_++;
         }
         this.PageCount = this.EctypeTaskList.length / 8;
         if(this.PageCount * 8 < this.EctypeTaskList.length)
         {
            ++this.PageCount;
         }
         this.ShowPageButton();
      }
      
      private function btn_daytaskClick(param1:MouseEvent) : void
      {
         var _loc2_:TextField = null;
         this.mc_daytask.visible = true;
         this.tf_tasktxt.text = "";
         _loc2_ = this._mc.getMC().getChildByName("tf_content") as TextField;
         _loc2_.htmlText = StringManager.getInstance().getMessageString("MailText52");
         BleakingLineForThai.GetInstance().BleakThaiLanguage(_loc2_,13417082);
         _loc2_ = this._mc.getMC().getChildByName("tf_aim") as TextField;
         _loc2_.text = StringManager.getInstance().getMessageString("TaskText1") + this.PointCount.toString();
         this.tf_describe.text = StringManager.getInstance().getMessageString("MailText53");
         this.btn_achieve.setVisible(false);
         if(this.SelectedTaskButton != null)
         {
            this.SelectedTaskButton.setSelect(false);
         }
         this.ShowAward();
      }
      
      private function ShowTaskTitle() : void
      {
         this.mc_daytask.visible = false;
         this.tf_tasktxt.text = StringManager.getInstance().getMessageString("TaskText0");
         this.tf_describe.text = StringManager.getInstance().getMessageString("MailText54");
         this.btn_achieve.setVisible(true);
      }
      
      private function InitAward() : void
      {
         var _loc3_:XButton = null;
         var _loc1_:XML = GameKernel.resManager.getXml(ResManager.GAMERES,"DailyAward");
         this.mc_daytask = this._mc.getMC().getChildByName("mc_daytask") as MovieClip;
         var _loc2_:int = 0;
         while(_loc2_ < 4)
         {
            _loc3_ = new XButton(this.mc_daytask.getChildByName("mc_integral" + _loc2_) as MovieClip,HButtonType.SIMPLE,false,_loc1_.Level[_loc2_].@comment);
            _loc3_.Data = _loc2_;
            _loc3_.OnClick = this.AwardBtnClick;
            this.CanAwardList.push(0);
            _loc2_++;
         }
      }
      
      private function AwardBtnClick(param1:MouseEvent, param2:XButton) : void
      {
         if(this.MsgTaskInfo == null)
         {
            return;
         }
         var _loc3_:int = int(this.MsgTaskInfo.AwardData.indexOf(param2.Data));
         if(_loc3_ >= 0 && _loc3_ < this.MsgTaskInfo.AwardLen)
         {
            return;
         }
         if(this.CanAwardList[param2.Data] != 1)
         {
            return;
         }
         if(GamePlayer.getInstance().PropsPack - ScienceSystem.getinstance().Packarr.length <= 0)
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("CommanderText12"),10);
            return;
         }
         var _loc4_:MSG_REQUEST_GAINDAILYAWARD = new MSG_REQUEST_GAINDAILYAWARD();
         _loc4_.DailyAwardId = param2.Data;
         _loc4_.SeqId = GamePlayer.getInstance().seqID++;
         _loc4_.Guid = GamePlayer.getInstance().Guid;
         NetManager.Instance().sendObject(_loc4_);
      }
      
      private function ShowAward() : void
      {
         var _loc1_:XML = GameKernel.resManager.getXml(ResManager.GAMERES,"DailyAward");
         this.CanAwardList[0] = this.SetAwardText(TextField(this.mc_daytask.tf_integral0),_loc1_.Level[0]);
         this.CanAwardList[1] = this.SetAwardText(TextField(this.mc_daytask.tf_integral1),_loc1_.Level[1]);
         this.CanAwardList[2] = this.SetAwardText(TextField(this.mc_daytask.tf_integral2),_loc1_.Level[2]);
         this.CanAwardList[3] = this.SetAwardText(TextField(this.mc_daytask.tf_integral3),_loc1_.Level[3]);
      }
      
      private function SetAwardText(param1:TextField, param2:XML) : int
      {
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         if(this.MsgTaskInfo == null)
         {
            return _loc3_;
         }
         var _loc4_:String = StringManager.getInstance().getMessageString("TaskText3");
         _loc4_ = _loc4_.replace("@@1",param2.@PointDepend);
         var _loc6_:int = int(param2.@AwardID);
         _loc5_ = int(this.MsgTaskInfo.AwardData.indexOf(_loc6_));
         if(_loc5_ >= 0 && _loc5_ < this.MsgTaskInfo.AwardLen)
         {
            _loc4_ += "\n<font color=\'#666666\'>(" + StringManager.getInstance().getMessageString("TaskText4") + ")</font>";
            _loc3_ = 0;
         }
         else if(param2.@PointDepend > this.PointCount)
         {
            _loc4_ += "\n<font color=\'#FF0000\'>(" + StringManager.getInstance().getMessageString("TaskText5") + ")</font>";
            _loc3_ = 0;
         }
         else
         {
            _loc4_ += "\n<font color=\'#00FF00\'>(" + StringManager.getInstance().getMessageString("TaskText6") + ")</font>";
            _loc3_ = 1;
         }
         param1.htmlText = _loc4_;
         return _loc3_;
      }
      
      public function RespAward(param1:MSG_RESP_GAINDAILYAWARD) : void
      {
         var _loc2_:String = null;
         this.MsgTaskInfo.AwardData[this.MsgTaskInfo.AwardLen] = param1.DailyAwardId;
         ++this.MsgTaskInfo.AwardLen;
         UpdateResource.getInstance().AddToPack(param1.PropsId,param1.PropsNum,param1.LockFlag);
         var _loc3_:propsInfo = CPropsReader.getInstance().GetPropsInfo(param1.PropsId);
         var _loc4_:String = StringManager.getInstance().getMessageString("TaskText8") + _loc3_.Name + " X " + param1.PropsNum;
         MessagePopup.getInstance().Show(_loc4_,0);
         MessagePopup.getInstance().Show(_loc4_,1);
         this.ShowAward();
      }
      
      private function tf_contentClick(param1:TextEvent) : void
      {
         var _loc2_:int = int(param1.text);
         GameCommandManager.getInstance().Execute(_loc2_);
      }
   }
}

