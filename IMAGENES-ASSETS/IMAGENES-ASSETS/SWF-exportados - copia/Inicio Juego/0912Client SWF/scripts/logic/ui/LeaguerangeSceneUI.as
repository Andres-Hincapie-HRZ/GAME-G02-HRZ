package logic.ui
{
   import com.star.frameworks.events.ActionEvent;
   import com.star.frameworks.managers.StringManager;
   import com.star.frameworks.utils.CEffectText;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.text.StyleSheet;
   import flash.text.TextField;
   import logic.action.ChatAction;
   import logic.entry.HButton;
   import logic.entry.MObject;
   import logic.entry.Rank.LeaguerangeInfo;
   import logic.game.GameKernel;
   import logic.manager.GameInterActiveManager;
   import net.router.LeaguerangeRouter;
   
   public class LeaguerangeSceneUI extends AbstractPopUp
   {
      
      public static var instance:LeaguerangeSceneUI = null;
      
      private var listMCAry:Array = new Array();
      
      private var _prev:HButton;
      
      private var _first:HButton;
      
      private var _next:HButton;
      
      private var _last:HButton;
      
      private var parent:String;
      
      public function LeaguerangeSceneUI()
      {
         super();
         setPopUpName("LeaguerangeSceneUI");
      }
      
      public static function getInstance() : LeaguerangeSceneUI
      {
         if(instance == null)
         {
            instance = new LeaguerangeSceneUI();
         }
         return instance;
      }
      
      override public function Init() : void
      {
         if(GameKernel.popUpDisplayManager.PopDisplayList.ContainsKey(getPopUpName()))
         {
            return;
         }
         this._mc = new MObject("LeaguerangeScene",378,308);
         GameKernel.popUpDisplayManager.Regisger(instance);
         this.initMcElement();
      }
      
      override public function initMcElement() : void
      {
         var _loc4_:int = 0;
         var _loc5_:MovieClip = null;
         var _loc1_:HButton = new HButton(this._mc.getMC().btn_close);
         GameInterActiveManager.InstallInterActiveEvent(_loc1_.m_movie,ActionEvent.ACTION_CLICK,this.clickButton);
         this._mc.getMC().tf_inputid.addEventListener(MouseEvent.CLICK,this.clickButton);
         var _loc2_:HButton = new HButton(this._mc.getMC().btn_search);
         GameInterActiveManager.InstallInterActiveEvent(_loc2_.m_movie,ActionEvent.ACTION_CLICK,this.clickButton);
         var _loc3_:HButton = new HButton(this._mc.getMC().btn_mytop);
         GameInterActiveManager.InstallInterActiveEvent(_loc3_.m_movie,ActionEvent.ACTION_CLICK,this.clickButton);
         this.listMCAry.length = 0;
         while(_loc4_ < 10)
         {
            _loc5_ = this._mc.getMC().getChildByName("mc_list" + _loc4_) as MovieClip;
            this.listMCAry.push(_loc5_);
            _loc4_++;
         }
         this._prev = new HButton(this._mc.getMC().btn_prev);
         GameInterActiveManager.InstallInterActiveEvent(this._prev.m_movie,ActionEvent.ACTION_CLICK,this.clickButton);
         this._first = new HButton(this._mc.getMC().btn_first);
         GameInterActiveManager.InstallInterActiveEvent(this._first.m_movie,ActionEvent.ACTION_CLICK,this.clickButton);
         this._next = new HButton(this._mc.getMC().btn_next);
         GameInterActiveManager.InstallInterActiveEvent(this._next.m_movie,ActionEvent.ACTION_CLICK,this.clickButton);
         this._last = new HButton(this._mc.getMC().btn_last);
         GameInterActiveManager.InstallInterActiveEvent(this._last.m_movie,ActionEvent.ACTION_CLICK,this.clickButton);
      }
      
      public function setParent(param1:String) : void
      {
         this.parent = param1;
      }
      
      public function InitPopUp() : void
      {
         this.clearListMC();
         this.showListMC();
         this.showButtonMC();
      }
      
      private function clearListMC() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         while(_loc1_ < 10)
         {
            _loc2_ = this.listMCAry[_loc1_] as MovieClip;
            _loc2_.tf_ranking.text = "";
            _loc2_.tf_username.text = "";
            _loc2_.tf_rank.text = "";
            _loc2_.tf_record.text = "";
            _loc2_.tf_victory.text = "";
            _loc2_.tf_failure.text = "";
            _loc2_.tf_draw.text = "";
            _loc2_.tf_rate.text = "";
            _loc2_.tf_zranking.text = "";
            _loc1_++;
         }
      }
      
      private function showListMC() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         var _loc3_:LeaguerangeInfo = null;
         var _loc4_:* = null;
         var _loc5_:String = null;
         var _loc6_:StyleSheet = null;
         var _loc7_:int = 0;
         this._mc.getMC().tf_page.text = String(LeaguerangeRouter.getInstance().PageId + 1) + "/" + String(LeaguerangeRouter.getInstance().MaxPageId);
         while(_loc1_ < LeaguerangeRouter.getInstance().DataLen)
         {
            _loc2_ = this.listMCAry[_loc1_] as MovieClip;
            _loc3_ = LeaguerangeRouter.getInstance().leaguerangeInfoAry[_loc1_] as LeaguerangeInfo;
            _loc2_.tf_zranking.text = String(10 * LeaguerangeRouter.getInstance().PageId + _loc1_ + 1);
            _loc2_.tf_ranking.text = String(_loc3_.MatchWeekTop);
            _loc4_ = "<a href=\'event:" + _loc3_.Guid + "\'>" + _loc3_.UserName + "</a>";
            if(_loc2_.tf_username.styleSheet == null)
            {
               _loc5_ = "a:link{text-decoration: underline;} a:hover{color:#ff0000;text-decoration: underline;} a:active{text-decoration: underline;}";
               _loc6_ = new StyleSheet();
               _loc6_.parseCSS(_loc5_);
               _loc2_.tf_username.styleSheet = _loc6_;
            }
            _loc2_.tf_username.htmlText = _loc4_;
            if(!_loc2_.tf_username.hasEventListener(TextEvent.LINK))
            {
               GameInterActiveManager.InstallInterActiveEvent(_loc2_.tf_username,TextEvent.LINK,this.onGoforward);
            }
            _loc2_.tf_rank.text = String(_loc3_.MatchLevel + 1);
            _loc2_.tf_record.text = String(_loc3_.MatchWin * 3 + _loc3_.MatchDogfall + _loc3_.MatchLost);
            _loc2_.tf_victory.text = String(_loc3_.MatchWin);
            _loc2_.tf_failure.text = String(_loc3_.MatchLost);
            _loc2_.tf_draw.text = String(_loc3_.MatchDogfall);
            if(_loc3_.MatchWin + _loc3_.MatchLost + _loc3_.MatchDogfall == 0)
            {
               _loc2_.tf_rate.text = "0%";
            }
            else
            {
               _loc7_ = _loc3_.MatchWin * 100 / (_loc3_.MatchWin + _loc3_.MatchLost + _loc3_.MatchDogfall);
               _loc2_.tf_rate.text = String(_loc7_) + "%";
            }
            _loc1_++;
         }
      }
      
      private function showButtonMC() : void
      {
         if(LeaguerangeRouter.getInstance().PageId > 0)
         {
            this._prev.setBtnDisabled(false);
            this._first.setBtnDisabled(false);
         }
         else
         {
            this._prev.setBtnDisabled(true);
            this._first.setBtnDisabled(true);
         }
         if(LeaguerangeRouter.getInstance().PageId < LeaguerangeRouter.getInstance().MaxPageId - 1)
         {
            this._next.setBtnDisabled(false);
            this._last.setBtnDisabled(false);
         }
         else
         {
            this._next.setBtnDisabled(true);
            this._last.setBtnDisabled(true);
         }
      }
      
      private function onGoforward(param1:TextEvent) : void
      {
         ChatAction.getInstance().sendChatUserInfoMessage(-1,int(param1.text),3);
      }
      
      private function clickButton(param1:Event) : void
      {
         if(param1.currentTarget.name == "btn_close")
         {
            if(this.parent == "RankingSceneUI")
            {
               RankingSceneUI.getInstance().removeBackMC();
               this.parent = "";
            }
            GameKernel.popUpDisplayManager.Hide(instance);
         }
         else if(param1.currentTarget.name == "btn_mytop")
         {
            LeaguerangeRouter.getInstance().sendMsgRANKMATCH(-1,-1);
         }
         else if(param1.currentTarget.name == "tf_inputid")
         {
            TextField(this._mc.getMC().tf_inputid).text = "";
            TextField(this._mc.getMC().tf_inputid).restrict = "0-9";
         }
         else if(param1.currentTarget.name == "btn_search")
         {
            if(this._mc.getMC().tf_inputid.text == StringManager.getInstance().getMessageString("RankingTXT01") || this._mc.getMC().tf_inputid.text == "")
            {
               CEffectText.getInstance().showEffectText(GameKernel.renderManager.getUI().getContainer(),StringManager.getInstance().getMessageString("RankingTXT01"));
               return;
            }
            LeaguerangeRouter.getInstance().sendMsgRANKMATCH(this._mc.getMC().tf_inputid.text,-1);
         }
         else if(param1.currentTarget.name == "btn_prev")
         {
            if(LeaguerangeRouter.getInstance().PageId > 0)
            {
               --LeaguerangeRouter.getInstance().PageId;
               LeaguerangeRouter.getInstance().sendMsgRANKMATCH(-1,LeaguerangeRouter.getInstance().PageId);
            }
         }
         else if(param1.currentTarget.name == "btn_first")
         {
            if(LeaguerangeRouter.getInstance().PageId > 0)
            {
               LeaguerangeRouter.getInstance().sendMsgRANKMATCH(-1,0);
            }
         }
         else if(param1.currentTarget.name == "btn_next")
         {
            if(LeaguerangeRouter.getInstance().PageId < LeaguerangeRouter.getInstance().MaxPageId - 1)
            {
               ++LeaguerangeRouter.getInstance().PageId;
               LeaguerangeRouter.getInstance().sendMsgRANKMATCH(-1,LeaguerangeRouter.getInstance().PageId);
            }
         }
         else if(param1.currentTarget.name == "btn_last")
         {
            if(LeaguerangeRouter.getInstance().PageId < LeaguerangeRouter.getInstance().MaxPageId - 1)
            {
               LeaguerangeRouter.getInstance().sendMsgRANKMATCH(-1,LeaguerangeRouter.getInstance().MaxPageId - 1);
            }
         }
      }
      
      public function noFind() : void
      {
         CEffectText.getInstance().showEffectText(GameKernel.renderManager.getUI().getContainer(),StringManager.getInstance().getMessageString("RankingTXT02"));
      }
   }
}

