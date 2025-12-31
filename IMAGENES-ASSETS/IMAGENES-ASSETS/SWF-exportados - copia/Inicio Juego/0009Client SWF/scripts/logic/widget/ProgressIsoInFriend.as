package logic.widget
{
   import com.star.frameworks.events.ActionEvent;
   import com.star.frameworks.managers.StringManager;
   import com.star.frameworks.utils.CEffectText;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import logic.action.ConstructionAction;
   import logic.action.FaceBookAction;
   import logic.entry.Equiment;
   import logic.entry.GamePlayer;
   import logic.entry.HButton;
   import logic.game.GameKernel;
   import logic.manager.GameInterActiveManager;
   
   public class ProgressIsoInFriend
   {
      
      private var _mc:MovieClip;
      
      private var _equiment:Equiment;
      
      private var _isCompleted:Boolean;
      
      private var _isUsed:Boolean;
      
      private var _speedBtn:HButton;
      
      private var _cancleBtn:HButton;
      
      private var _buildNameTF:TextField;
      
      private var _costTimeTF:TextField;
      
      private var _lvTF:TextField;
      
      public function ProgressIsoInFriend(param1:Equiment)
      {
         super();
         this._mc = GameKernel.getMovieClipInstance("ConstructProgressMc");
         this._equiment = param1;
         this.Init();
         this.setConstructionName();
         this.setConstructionLv();
         this.setRemainTime();
         this.setProgressCostTime();
      }
      
      public function get Iso() : MovieClip
      {
         return this._mc;
      }
      
      public function set Iso(param1:MovieClip) : void
      {
         this._mc = param1;
      }
      
      public function get Construction() : Equiment
      {
         return this._equiment;
      }
      
      public function get IsCompleted() : Boolean
      {
         return this._isCompleted;
      }
      
      public function get CostTime() : String
      {
         return this._costTimeTF.text;
      }
      
      public function get IsUsed() : Boolean
      {
         return this._isUsed;
      }
      
      public function set IsUsed(param1:Boolean) : void
      {
         this._isUsed = param1;
      }
      
      private function Init() : void
      {
         this._buildNameTF = this.Iso.tf_buildname as TextField;
         this._costTimeTF = this.Iso.tf_time as TextField;
         this._lvTF = this.Iso.tf_LV as TextField;
         this._speedBtn = new HButton(this.Iso.btn_upgrade);
         this._cancleBtn = new HButton(this.Iso.btn_cancel);
         this._cancleBtn.setVisible(false);
         GameInterActiveManager.InstallInterActiveEvent(this._speedBtn.m_movie,ActionEvent.ACTION_CLICK,this.onHandler);
         GameInterActiveManager.InstallInterActiveEvent(this._cancleBtn.m_movie,ActionEvent.ACTION_CLICK,this.onHandler);
      }
      
      public function Destory() : void
      {
         if(Boolean(this.Iso) && this.Iso.parent != null)
         {
            this._speedBtn.m_movie.stop();
            this.Iso.stop();
            GameInterActiveManager.unInstallnterActiveEvent(this._speedBtn.m_movie,ActionEvent.ACTION_CLICK,this.onHandler);
            GameInterActiveManager.unInstallnterActiveEvent(this._cancleBtn.m_movie,ActionEvent.ACTION_CLICK,this.onHandler);
            this.Iso.parent.removeChild(this.Iso);
         }
      }
      
      public function setConstructionLv() : void
      {
         this._lvTF.text = StringManager.getInstance().getMessageString("BuildingText21") + (this._equiment.EquimentInfoData.LevelId + 2);
      }
      
      public function setConstructionName() : void
      {
         this._buildNameTF.text = this._equiment.EquimentInfoData.BuildName;
      }
      
      public function clearConstructionInfo() : void
      {
         this._lvTF.text = "";
         this._buildNameTF.text = "";
      }
      
      public function setProgressCostTime() : void
      {
         if(this._equiment.EquimentInfoData.needTime > 0)
         {
            this._costTimeTF.text = DataWidget.localToDataZone(this._equiment.EquimentInfoData.needTime);
         }
         else
         {
            this._isCompleted = true;
            this._costTimeTF.text = StringManager.getInstance().getMessageString("ItemText17");
         }
      }
      
      public function setRemainTime() : void
      {
         this._costTimeTF.text = DataWidget.localToDataZone(this._equiment.EquimentInfoData.needTime);
      }
      
      public function setSpeedBtnDisableState(param1:Boolean = true) : void
      {
         this._speedBtn.setBtnDisabled(param1);
      }
      
      public function updateSpeedCostTime(param1:int) : void
      {
         this._equiment.EquimentInfoData.needTime = param1;
         this.setRemainTime();
         this.setProgressCostTime();
      }
      
      private function onHandler(param1:MouseEvent) : void
      {
         if(FaceBookAction.getInstance().CurFaceBookFriendInfo)
         {
            if(0 == GamePlayer.getInstance().SpValue)
            {
               CEffectText.getInstance().showEffectText(GameKernel.renderManager.getUI().getContainer(),StringManager.getInstance().getMessageString("SpeedTXT02"));
               return;
            }
            ConstructionAction.getInstance().sendSpeedBuildInFriend(FaceBookAction.getInstance().CurFaceBookFriendInfo.ObjGuid,this._equiment.EquimentInfoData.IndexId);
            ConstructionAction.currentProgressIso = this;
         }
      }
   }
}

