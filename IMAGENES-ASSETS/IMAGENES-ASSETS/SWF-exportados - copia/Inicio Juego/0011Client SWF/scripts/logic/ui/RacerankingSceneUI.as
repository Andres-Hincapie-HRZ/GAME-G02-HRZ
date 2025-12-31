package logic.ui
{
   import com.star.frameworks.events.ActionEvent;
   import com.star.frameworks.facebook.FacebookUserInfo;
   import com.star.frameworks.managers.StringManager;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import logic.entry.HButton;
   import logic.entry.HButtonStatue;
   import logic.entry.MObject;
   import logic.game.GameKernel;
   import logic.manager.GameInterActiveManager;
   import net.msg.gymkhanaMSg.MSG_RESP_RACINGRANK_TEMP;
   import net.router.GymkhanaRouter;
   
   public class RacerankingSceneUI extends AbstractPopUp
   {
      
      private static var instance:RacerankingSceneUI = null;
      
      private var raceAry:Array = new Array();
      
      private var UserIdList:Array = new Array();
      
      private var UserNameList:Array = new Array();
      
      private var m_ary:Array = new Array();
      
      private var btn_homepage:HButton;
      
      private var btn_uppage:HButton;
      
      private var btn_downpage:HButton;
      
      private var btn_lastpage:HButton;
      
      private var m_max:int;
      
      public function RacerankingSceneUI()
      {
         super();
         setPopUpName("RacerankingSceneUI");
      }
      
      public static function getInstance() : RacerankingSceneUI
      {
         if(instance == null)
         {
            instance = new RacerankingSceneUI();
         }
         return instance;
      }
      
      override public function Init() : void
      {
         if(GameKernel.popUpDisplayManager.PopDisplayList.ContainsKey(getPopUpName()))
         {
            return;
         }
         this._mc = new MObject("RacerankingScene",378,308);
         GameKernel.popUpDisplayManager.Regisger(instance);
         this.initMcElement();
      }
      
      override public function initMcElement() : void
      {
         var _loc2_:MovieClip = null;
         this.btn_homepage = new HButton(this._mc.getMC().btn_homepage);
         this.btn_uppage = new HButton(this._mc.getMC().btn_uppage);
         this.btn_downpage = new HButton(this._mc.getMC().btn_downpage);
         this.btn_lastpage = new HButton(this._mc.getMC().btn_lastpage);
         new HButton(this._mc.getMC().btn_close);
         GameInterActiveManager.InstallInterActiveEvent(_mc.getMC().btn_close,ActionEvent.ACTION_CLICK,this.chickButton);
         GameInterActiveManager.InstallInterActiveEvent(_mc.getMC().btn_homepage,ActionEvent.ACTION_CLICK,this.chickButton);
         GameInterActiveManager.InstallInterActiveEvent(_mc.getMC().btn_uppage,ActionEvent.ACTION_CLICK,this.chickButton);
         GameInterActiveManager.InstallInterActiveEvent(_mc.getMC().btn_downpage,ActionEvent.ACTION_CLICK,this.chickButton);
         GameInterActiveManager.InstallInterActiveEvent(_mc.getMC().btn_lastpage,ActionEvent.ACTION_CLICK,this.chickButton);
         var _loc1_:int = 0;
         while(_loc1_ < 6)
         {
            _loc2_ = GameKernel.getMovieClipInstance("Race_rankinglist");
            _loc2_.gotoAndStop(1);
            GameInterActiveManager.InstallInterActiveEvent(_loc2_,ActionEvent.ACTION_CLICK,this.chooseSelect);
            this.raceAry.push(_loc2_);
            _loc1_++;
         }
      }
      
      private function clearList() : void
      {
         var _loc2_:MovieClip = null;
         var _loc1_:int = 0;
         while(_loc1_ < 6)
         {
            _loc2_ = this._mc.getMC().getChildByName("mc_list" + _loc1_) as MovieClip;
            while(_loc2_.numChildren > 1)
            {
               _loc2_.removeChildAt(1);
            }
            _loc1_++;
         }
      }
      
      public function showList(param1:Array) : void
      {
         var _loc4_:MSG_RESP_RACINGRANK_TEMP = null;
         var _loc5_:MovieClip = null;
         var _loc6_:MovieClip = null;
         var _loc7_:int = 0;
         var _loc8_:String = null;
         this.clearList();
         this._mc.getMC().tf_page.text = GymkhanaRouter.getinstance().m_racingPageId + 1;
         if(GymkhanaRouter.getinstance().m_racingPageId > 0)
         {
            this.btn_homepage.m_movie.gotoAndStop("up");
            this.btn_uppage.m_movie.gotoAndStop("up");
            this.btn_homepage.m_statue = HButtonStatue.UP;
            this.btn_uppage.m_statue = HButtonStatue.UP;
         }
         else
         {
            this.btn_homepage.m_movie.gotoAndStop("disabled");
            this.btn_uppage.m_movie.gotoAndStop("disabled");
            this.btn_homepage.m_statue = HButtonStatue.DISABLED;
            this.btn_uppage.m_statue = HButtonStatue.DISABLED;
         }
         var _loc2_:int = GymkhanaRouter.getinstance().m_userCount / 6;
         if(GymkhanaRouter.getinstance().m_userCount % 6 != 0)
         {
            _loc2_++;
         }
         this.m_max = _loc2_;
         if(GymkhanaRouter.getinstance().m_racingPageId != _loc2_ - 1)
         {
            this.btn_downpage.m_movie.gotoAndStop("up");
            this.btn_lastpage.m_movie.gotoAndStop("up");
            this.btn_downpage.m_statue = HButtonStatue.UP;
            this.btn_lastpage.m_statue = HButtonStatue.UP;
         }
         else
         {
            this.btn_downpage.m_movie.gotoAndStop("disabled");
            this.btn_lastpage.m_movie.gotoAndStop("disabled");
            this.btn_downpage.m_statue = HButtonStatue.DISABLED;
            this.btn_lastpage.m_statue = HButtonStatue.DISABLED;
         }
         this.m_ary = param1;
         var _loc3_:int = 0;
         while(_loc3_ < param1.length)
         {
            _loc4_ = param1[_loc3_] as MSG_RESP_RACINGRANK_TEMP;
            _loc5_ = this.raceAry[_loc3_];
            _loc6_ = this._mc.getMC().getChildByName("mc_list" + _loc3_) as MovieClip;
            _loc6_.addChild(_loc5_);
            _loc5_.txt_ranking.text = _loc4_.RankId;
            _loc5_.txt_name.text = _loc4_.Name;
            _loc7_ = _loc4_.GameServerId + 1;
            if(_loc7_ >= 10)
            {
               _loc8_ = StringManager.getInstance().getMessageString("Boss189") + _loc7_;
            }
            else
            {
               _loc8_ = StringManager.getInstance().getMessageString("Boss189") + "0" + _loc7_;
            }
            _loc5_.txt_service.text = _loc8_;
            this.UserIdList.push(_loc4_.UserId);
            this.UserNameList.push(_loc4_.Name);
            _loc3_++;
         }
         GameKernel.getPlayerFacebookInfoArray(this.UserIdList,this.getPlayerFacebookInfoArrayCallback,this.UserNameList);
      }
      
      private function getPlayerFacebookInfoArrayCallback(param1:Array) : void
      {
         var _loc2_:FacebookUserInfo = null;
         if(param1 == null)
         {
            return;
         }
         for each(_loc2_ in param1)
         {
            FleetInfoUI_Res.GetInstance().GetFacebookUserImg(_loc2_.uid,_loc2_.pic_square,this.GetFacebookUserImgCallback);
         }
      }
      
      private function GetFacebookUserImgCallback(param1:Number, param2:DisplayObject) : void
      {
         var _loc4_:MSG_RESP_RACINGRANK_TEMP = null;
         var _loc5_:MovieClip = null;
         var _loc6_:MovieClip = null;
         if(param2 == null)
         {
            return;
         }
         var _loc3_:int = 0;
         while(_loc3_ < this.m_ary.length)
         {
            _loc4_ = this.m_ary[_loc3_] as MSG_RESP_RACINGRANK_TEMP;
            if(_loc4_.UserId == param1)
            {
               _loc5_ = this.raceAry[_loc3_] as MovieClip;
               if(_loc5_ == null)
               {
                  return;
               }
               _loc6_ = _loc5_.getChildByName("mc_headbase") as MovieClip;
               if(_loc6_.numChildren > 0)
               {
                  _loc6_.removeChildAt(0);
               }
               if(param2 != null)
               {
                  param2.width = 40;
                  param2.height = 40;
                  _loc6_.addChild(param2);
               }
            }
            _loc3_++;
         }
      }
      
      private function chickButton(param1:Event) : void
      {
         if(param1.currentTarget.name == "btn_close")
         {
            GymkhanaUI.getInstance().removeBackMC();
            this.closeEve();
         }
         else if(param1.currentTarget.name == "btn_homepage")
         {
            if(GymkhanaRouter.getinstance().m_racingPageId != 0)
            {
               GymkhanaRouter.getinstance().REQUEST_RACINGRANK(0);
            }
         }
         else if(param1.currentTarget.name == "btn_uppage")
         {
            if(GymkhanaRouter.getinstance().m_racingPageId != 0)
            {
               GymkhanaRouter.getinstance().REQUEST_RACINGRANK(GymkhanaRouter.getinstance().m_racingPageId - 1);
            }
         }
         else if(param1.currentTarget.name == "btn_downpage")
         {
            if(GymkhanaRouter.getinstance().m_racingPageId != this.m_max - 1)
            {
               GymkhanaRouter.getinstance().REQUEST_RACINGRANK(GymkhanaRouter.getinstance().m_racingPageId + 1);
            }
         }
         else if(param1.currentTarget.name == "btn_lastpage")
         {
            if(GymkhanaRouter.getinstance().m_racingPageId != this.m_max - 1)
            {
               GymkhanaRouter.getinstance().REQUEST_RACINGRANK(this.m_max - 1);
            }
         }
      }
      
      public function closeEve() : void
      {
         GameKernel.popUpDisplayManager.Hide(instance);
      }
      
      public function chooseSelect(param1:Event) : void
      {
      }
   }
}

