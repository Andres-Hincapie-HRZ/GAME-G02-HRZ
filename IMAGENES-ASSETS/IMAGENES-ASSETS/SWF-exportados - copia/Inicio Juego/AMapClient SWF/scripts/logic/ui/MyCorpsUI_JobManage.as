package logic.ui
{
   import com.star.frameworks.managers.StringManager;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldType;
   import logic.entry.GamePlayer;
   import logic.entry.HButton;
   import logic.entry.MObject;
   import logic.game.GameKernel;
   import net.base.NetManager;
   import net.msg.corpsMsg.MSG_REQUEST_CONSORTIAUPDATEJOBNAME;
   
   public class MyCorpsUI_JobManage extends AbstractPopUp
   {
      
      private static var instance:MyCorpsUI_JobManage;
      
      private var SelectedList:MovieClip;
      
      private var FirstList:XMovieClip;
      
      public function MyCorpsUI_JobManage()
      {
         super();
         setPopUpName("MyCorpsUI_JobManage");
      }
      
      public static function getInstance() : MyCorpsUI_JobManage
      {
         if(instance == null)
         {
            instance = new MyCorpsUI_JobManage();
         }
         return instance;
      }
      
      override public function Init() : void
      {
         if(GameKernel.popUpDisplayManager.PopDisplayList.ContainsKey(getPopUpName()))
         {
            return;
         }
         this._mc = new MObject("JobmanageMcPop",385,300);
         this.initMcElement();
         GameKernel.popUpDisplayManager.Regisger(instance);
      }
      
      override public function initMcElement() : void
      {
         var _loc1_:HButton = null;
         var _loc2_:MovieClip = null;
         var _loc4_:MovieClip = null;
         var _loc5_:XButton = null;
         var _loc6_:TextField = null;
         var _loc7_:XMovieClip = null;
         _loc2_ = this._mc.getMC().getChildByName("btn_close") as MovieClip;
         _loc1_ = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.CloseClick);
         var _loc3_:int = 0;
         while(_loc3_ < 5)
         {
            _loc4_ = this._mc.getMC().getChildByName("mc_list" + _loc3_) as MovieClip;
            _loc5_ = new XButton(_loc4_.btn_change);
            _loc5_.Data = _loc3_;
            _loc5_.OnClick = this.ChnageButtonClick;
            _loc4_.btn_change.visible = true;
            _loc5_ = new XButton(_loc4_.btn_ensure);
            _loc5_.Data = _loc3_;
            _loc5_.OnClick = this.ChangeEnsureClik;
            _loc4_.btn_ensure.visible = false;
            _loc6_ = TextField(_loc4_.tf_job);
            _loc6_.type = TextFieldType.DYNAMIC;
            _loc7_ = new XMovieClip(_loc4_);
            _loc7_.Data = _loc3_;
            _loc7_.OnClick = this.ListClick;
            _loc4_.stop();
            if(_loc3_ == 0)
            {
               this.FirstList = _loc7_;
            }
            _loc3_++;
         }
      }
      
      private function ShowJobName() : void
      {
         var _loc2_:MovieClip = null;
         var _loc1_:int = 0;
         while(_loc1_ < 5)
         {
            _loc2_ = this._mc.getMC().getChildByName("mc_list" + _loc1_) as MovieClip;
            TextField(_loc2_.tf_job).text = MyCorpsUI.getInstance()._ConsortiaJobName[(_loc1_ + 1) % 5];
            _loc1_++;
         }
      }
      
      public function Show() : void
      {
         this.Init();
         this.ShowJobName();
         this.ListClick(null,this.FirstList);
         GameKernel.popUpDisplayManager.Show(this);
      }
      
      private function CloseClick(param1:MouseEvent) : void
      {
         GameKernel.popUpDisplayManager.Hide(this);
         MyCorpsUI.getInstance().Refresh();
      }
      
      private function ChangeEnsureClik(param1:MouseEvent, param2:XButton) : void
      {
         var _loc3_:MovieClip = this._mc.getMC().getChildByName("mc_list" + param2.Data) as MovieClip;
         var _loc4_:TextField = TextField(_loc3_.tf_job);
         _loc4_.type = TextFieldType.DYNAMIC;
         _loc3_.btn_ensure.visible = false;
         _loc3_.btn_change.visible = true;
         _loc4_.text = _loc4_.text.replace(/^\s*/g,"");
         _loc4_.text = _loc4_.text.replace(/\s*$/g,"");
         if(_loc4_.text == "")
         {
            _loc4_.text = MyCorpsUI.getInstance()._ConsortiaJobName[(param2.Data + 1) % 5];
            return;
         }
         MyCorpsUI.getInstance()._ConsortiaJobName[(param2.Data + 1) % 5] = _loc4_.text;
         var _loc5_:MSG_REQUEST_CONSORTIAUPDATEJOBNAME = new MSG_REQUEST_CONSORTIAUPDATEJOBNAME();
         _loc5_.JobName.Name0 = MyCorpsUI.getInstance()._ConsortiaJobName[0];
         _loc5_.JobName.Name1 = MyCorpsUI.getInstance()._ConsortiaJobName[1];
         _loc5_.JobName.Name2 = MyCorpsUI.getInstance()._ConsortiaJobName[2];
         _loc5_.JobName.Name3 = MyCorpsUI.getInstance()._ConsortiaJobName[3];
         _loc5_.JobName.Name4 = MyCorpsUI.getInstance()._ConsortiaJobName[4];
         _loc5_.SeqId = GamePlayer.getInstance().seqID++;
         _loc5_.Guid = GamePlayer.getInstance().Guid;
         NetManager.Instance().sendObject(_loc5_);
      }
      
      private function ChnageButtonClick(param1:MouseEvent, param2:XButton) : void
      {
         var _loc3_:MovieClip = this._mc.getMC().getChildByName("mc_list" + param2.Data) as MovieClip;
         var _loc4_:TextField = TextField(_loc3_.tf_job);
         _loc4_.text = "";
         _loc4_.type = TextFieldType.INPUT;
         _loc3_.btn_ensure.visible = true;
         _loc3_.btn_change.visible = false;
         _loc4_.stage.focus = _loc4_;
      }
      
      private function ListClick(param1:MouseEvent, param2:XMovieClip) : void
      {
         if(this.SelectedList != null)
         {
            this.SelectedList.gotoAndStop(1);
         }
         this.SelectedList = param2.m_movie;
         this.SelectedList.gotoAndStop(2);
         switch(param2.Data)
         {
            case 0:
               this.ShowRightString(new Array(73,74,75,76,77,78,79,80));
               break;
            case 1:
               this.ShowRightString(new Array(73,75,76,77,80));
               break;
            case 2:
               this.ShowRightString(new Array(77,80));
               break;
            case 3:
               this.ShowRightString(new Array("80"));
               break;
            case 4:
               this.ShowRightString(new Array());
         }
      }
      
      private function ShowRightString(param1:Array) : void
      {
         var _loc2_:int = 0;
         TextField(this._mc.getMC().tf_popedom).text = "";
         for each(_loc2_ in param1)
         {
            TextField(this._mc.getMC().tf_popedom).appendText(StringManager.getInstance().getMessageString("CorpsText" + _loc2_) + "\n");
         }
      }
   }
}

