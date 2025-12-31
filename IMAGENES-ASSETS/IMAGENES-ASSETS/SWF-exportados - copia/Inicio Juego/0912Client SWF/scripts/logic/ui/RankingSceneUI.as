package logic.ui
{
   import com.star.frameworks.events.ActionEvent;
   import com.star.frameworks.facebook.FacebookUserInfo;
   import com.star.frameworks.managers.StringManager;
   import com.star.frameworks.utils.CEffectText;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.geom.Point;
   import flash.text.StyleSheet;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   import logic.action.ChatAction;
   import logic.entry.GamePlayer;
   import logic.entry.HButton;
   import logic.entry.HButtonStatue;
   import logic.entry.MObject;
   import logic.entry.Rank.*;
   import logic.game.GameKernel;
   import logic.game.GameMouseZoneManager;
   import logic.manager.GalaxyManager;
   import logic.manager.GameInterActiveManager;
   import net.router.LeaguerangeRouter;
   import net.router.RankRouter;
   
   public class RankingSceneUI extends AbstractPopUp
   {
      
      private static var instance:RankingSceneUI = null;
      
      public var m_IsHit:int = 0;
      
      private var m_mcRanking:Array = new Array();
      
      private var m_corpspageNum:int = 0;
      
      private var m_rankfightpageNum:int = 0;
      
      private var backMc:MovieClip = new MovieClip();
      
      private var m_GuidAry:Array = new Array();
      
      private var m_Guid:int;
      
      private var _synthesisranking:HButton;
      
      private var _hitrangking:HButton;
      
      private var _close:HButton;
      
      private var _myranking:HButton;
      
      private var _uppage:MovieClip;
      
      private var _downpage:MovieClip;
      
      private var _corpsrank:HButton;
      
      private var _homepage:MovieClip;
      
      private var _lastpage:MovieClip;
      
      private var _Buppage:HButton;
      
      private var _Bdownpage:HButton;
      
      private var _Bhomepage:HButton;
      
      private var _Blastpage:HButton;
      
      private var UserIdList:Array = new Array();
      
      private var UserNameList:Array = new Array();
      
      private var _nameMCAry:Array = new Array();
      
      private var _guidMCAry:Array = new Array();
      
      private var _listMCAry:Array = new Array();
      
      public function RankingSceneUI()
      {
         super();
         setPopUpName("RankingSceneUI");
      }
      
      public static function getInstance() : RankingSceneUI
      {
         if(instance == null)
         {
            instance = new RankingSceneUI();
         }
         return instance;
      }
      
      override public function Init() : void
      {
         if(GameKernel.popUpDisplayManager.PopDisplayList.ContainsKey(getPopUpName()))
         {
            return;
         }
         this._mc = new MObject("RankingScene",378,308);
         GameKernel.popUpDisplayManager.Regisger(instance);
         this.initMcElement();
      }
      
      override public function initMcElement() : void
      {
         var _loc1_:HButton = new HButton(this._mc.getMC().btn_honor);
         GameInterActiveManager.InstallInterActiveEvent(_loc1_.m_movie,ActionEvent.ACTION_CLICK,this.chickButton);
         var _loc2_:HButton = new HButton(this._mc.getMC().btn_search);
         GameInterActiveManager.InstallInterActiveEvent(_loc2_.m_movie,ActionEvent.ACTION_CLICK,this.chickButton);
         this._mc.getMC().tf_input.restrict = "0-9";
         this._mc.getMC().tf_input.addEventListener(ActionEvent.ACTION_CLICK,this.chickButton);
         this._synthesisranking = new HButton(this._mc.getMC().btn_synthesisranking);
         this._mc.getMC().btn_synthesisranking.gotoAndStop(4);
         this._hitrangking = new HButton(this._mc.getMC().btn_treasurerangking);
         this._close = new HButton(this._mc.getMC().btn_close);
         this._myranking = new HButton(this._mc.getMC().btn_corpsranking);
         this._corpsrank = new HButton(this._mc.getMC().btn_hitranking);
         this._uppage = this._mc.getMC().btn_uppage as MovieClip;
         this._downpage = this._mc.getMC().btn_downpage as MovieClip;
         this._homepage = this._mc.getMC().btn_homepage;
         this._lastpage = this._mc.getMC().btn_lastpage;
         this._Buppage = new HButton(this._mc.getMC().btn_uppage);
         this._Bdownpage = new HButton(this._mc.getMC().btn_downpage);
         this._Bhomepage = new HButton(this._mc.getMC().btn_homepage);
         this._Blastpage = new HButton(this._mc.getMC().btn_lastpage);
         GameInterActiveManager.InstallInterActiveEvent(this._synthesisranking.m_movie,ActionEvent.ACTION_CLICK,this.chickButton);
         GameInterActiveManager.InstallInterActiveEvent(this._synthesisranking.m_movie,ActionEvent.ACTION_MOUSE_OVER,this.overButton);
         GameInterActiveManager.InstallInterActiveEvent(this._synthesisranking.m_movie,ActionEvent.ACTION_ROLL_OUT,this.outButton);
         GameInterActiveManager.InstallInterActiveEvent(this._hitrangking.m_movie,ActionEvent.ACTION_CLICK,this.chickButton);
         GameInterActiveManager.InstallInterActiveEvent(this._hitrangking.m_movie,ActionEvent.ACTION_MOUSE_OVER,this.overButton);
         GameInterActiveManager.InstallInterActiveEvent(this._hitrangking.m_movie,ActionEvent.ACTION_ROLL_OUT,this.outButton);
         GameInterActiveManager.InstallInterActiveEvent(this._corpsrank.m_movie,ActionEvent.ACTION_CLICK,this.chickButton);
         GameInterActiveManager.InstallInterActiveEvent(this._corpsrank.m_movie,ActionEvent.ACTION_MOUSE_OVER,this.overButton);
         GameInterActiveManager.InstallInterActiveEvent(this._corpsrank.m_movie,ActionEvent.ACTION_ROLL_OUT,this.outButton);
         GameInterActiveManager.InstallInterActiveEvent(this._close.m_movie,ActionEvent.ACTION_CLICK,this.chickButton);
         GameInterActiveManager.InstallInterActiveEvent(this._myranking.m_movie,ActionEvent.ACTION_CLICK,this.chickButton);
         GameInterActiveManager.InstallInterActiveEvent(this._myranking.m_movie,ActionEvent.ACTION_MOUSE_OVER,this.overButton);
         GameInterActiveManager.InstallInterActiveEvent(this._myranking.m_movie,ActionEvent.ACTION_ROLL_OUT,this.outButton);
         GameInterActiveManager.InstallInterActiveEvent(this._Buppage.m_movie,ActionEvent.ACTION_CLICK,this.chickButton);
         GameInterActiveManager.InstallInterActiveEvent(this._Bdownpage.m_movie,ActionEvent.ACTION_CLICK,this.chickButton);
         GameInterActiveManager.InstallInterActiveEvent(this._uppage,ActionEvent.ACTION_MOUSE_OVER,this.overButton);
         GameInterActiveManager.InstallInterActiveEvent(this._uppage,ActionEvent.ACTION_ROLL_OUT,this.outButton);
         GameInterActiveManager.InstallInterActiveEvent(this._downpage,ActionEvent.ACTION_MOUSE_OVER,this.overButton);
         GameInterActiveManager.InstallInterActiveEvent(this._downpage,ActionEvent.ACTION_ROLL_OUT,this.outButton);
         GameInterActiveManager.InstallInterActiveEvent(this._Bhomepage.m_movie,ActionEvent.ACTION_CLICK,this.chickButton);
         GameInterActiveManager.InstallInterActiveEvent(this._homepage,ActionEvent.ACTION_MOUSE_OVER,this.overButton);
         GameInterActiveManager.InstallInterActiveEvent(this._homepage,ActionEvent.ACTION_ROLL_OUT,this.outButton);
         GameInterActiveManager.InstallInterActiveEvent(this._Blastpage.m_movie,ActionEvent.ACTION_CLICK,this.chickButton);
         GameInterActiveManager.InstallInterActiveEvent(this._lastpage,ActionEvent.ACTION_MOUSE_OVER,this.overButton);
         GameInterActiveManager.InstallInterActiveEvent(this._lastpage,ActionEvent.ACTION_ROLL_OUT,this.outButton);
         var _loc3_:int = 0;
         while(_loc3_ < 6)
         {
            this._listMCAry[_loc3_] = this._mc.getMC().getChildByName("mc_list" + _loc3_) as MovieClip;
            this._listMCAry[_loc3_].addEventListener(ActionEvent.ACTION_CLICK,this.chooseList);
            _loc3_++;
         }
      }
      
      public function InitPopUp() : void
      {
         this._mc.getMC().btn_synthesisranking.gotoAndStop(4);
         this._mc.getMC().btn_treasurerangking.gotoAndStop(1);
         this._mc.getMC().btn_hitranking.gotoAndStop(1);
         this._mc.getMC().btn_corpsranking.gotoAndStop(1);
      }
      
      private function removeMC() : void
      {
         var _loc2_:MovieClip = null;
         var _loc1_:int = 0;
         while(_loc1_ < 6)
         {
            _loc2_ = this._mc.getMC().getChildByName("mc_list" + _loc1_) as MovieClip;
            if(_loc2_.numChildren >= 1)
            {
               _loc2_.removeChildAt(0);
            }
            _loc1_++;
         }
      }
      
      public function showList() : void
      {
         var _loc3_:TextFormat = null;
         var _loc4_:RankUserInfo = null;
         var _loc5_:MovieClip = null;
         var _loc6_:MovieClip = null;
         var _loc7_:RankUserInfo = null;
         var _loc8_:* = null;
         var _loc9_:* = null;
         var _loc10_:String = null;
         var _loc11_:StyleSheet = null;
         var _loc12_:String = null;
         var _loc13_:StyleSheet = null;
         if(GamePlayer.getInstance().language == 0 || GamePlayer.getInstance().language == 100)
         {
            TextField(this._mc.getMC().tf_title).text = "  " + StringManager.getInstance().getMessageString("CommanderText25") + "   " + StringManager.getInstance().getMessageString("CommanderText26") + " " + StringManager.getInstance().getMessageString("CommanderText27") + "/ID" + "           " + StringManager.getInstance().getMessageString("CommanderText28") + "            " + StringManager.getInstance().getMessageString("CommanderText29") + "            " + StringManager.getInstance().getMessageString("CommanderText30") + "         " + StringManager.getInstance().getMessageString("RankingTXT03");
         }
         else if(GamePlayer.getInstance().language == 1)
         {
            TextField(this._mc.getMC().tf_title).text = StringManager.getInstance().getMessageString("CommanderText25") + " " + StringManager.getInstance().getMessageString("CommanderText26") + " " + StringManager.getInstance().getMessageString("CommanderText27") + "/ID" + "                   " + StringManager.getInstance().getMessageString("CommanderText28") + "                   " + StringManager.getInstance().getMessageString("CommanderText29") + "                   " + StringManager.getInstance().getMessageString("CommanderText30") + "         " + StringManager.getInstance().getMessageString("RankingTXT03");
         }
         else if(GamePlayer.getInstance().language == 2)
         {
            TextField(this._mc.getMC().tf_title).text = StringManager.getInstance().getMessageString("CommanderText25") + "   " + StringManager.getInstance().getMessageString("CommanderText26") + " " + StringManager.getInstance().getMessageString("CommanderText27") + "/ID" + "              " + StringManager.getInstance().getMessageString("CommanderText28") + "                 " + StringManager.getInstance().getMessageString("CommanderText29") + "                      " + StringManager.getInstance().getMessageString("CommanderText30") + "              " + StringManager.getInstance().getMessageString("RankingTXT03");
         }
         else if(GamePlayer.getInstance().language == 3)
         {
            TextField(this._mc.getMC().tf_title).text = "   " + StringManager.getInstance().getMessageString("CommanderText25") + "       " + StringManager.getInstance().getMessageString("CommanderText26") + "  " + StringManager.getInstance().getMessageString("CommanderText27") + "/ID" + "                   " + StringManager.getInstance().getMessageString("CommanderText28") + "                 " + StringManager.getInstance().getMessageString("CommanderText29") + "                     " + StringManager.getInstance().getMessageString("CommanderText30") + "    " + StringManager.getInstance().getMessageString("RankingTXT03");
         }
         else if(GamePlayer.getInstance().language == 4)
         {
            TextField(this._mc.getMC().tf_title).text = StringManager.getInstance().getMessageString("CommanderText25") + " " + StringManager.getInstance().getMessageString("CommanderText26") + " " + StringManager.getInstance().getMessageString("CommanderText27") + "/ID" + "               " + StringManager.getInstance().getMessageString("CommanderText28") + "                  " + StringManager.getInstance().getMessageString("CommanderText29") + "                  " + StringManager.getInstance().getMessageString("CommanderText30") + " " + StringManager.getInstance().getMessageString("RankingTXT03");
         }
         else if(GamePlayer.getInstance().language == 5)
         {
            TextField(this._mc.getMC().tf_title).text = "   " + StringManager.getInstance().getMessageString("CommanderText25") + " " + StringManager.getInstance().getMessageString("CommanderText26") + " " + StringManager.getInstance().getMessageString("CommanderText27") + "/ID" + "                        " + StringManager.getInstance().getMessageString("CommanderText28") + "                 " + StringManager.getInstance().getMessageString("CommanderText29") + "                         " + StringManager.getInstance().getMessageString("CommanderText30") + "              " + StringManager.getInstance().getMessageString("RankingTXT03");
         }
         else if(GamePlayer.getInstance().language == 6)
         {
            TextField(this._mc.getMC().tf_title).text = " " + StringManager.getInstance().getMessageString("CommanderText25") + " " + StringManager.getInstance().getMessageString("CommanderText26") + " " + StringManager.getInstance().getMessageString("CommanderText27") + "/ID" + "                   " + StringManager.getInstance().getMessageString("CommanderText28") + "                 " + StringManager.getInstance().getMessageString("CommanderText29") + "                      " + StringManager.getInstance().getMessageString("CommanderText30") + "      " + StringManager.getInstance().getMessageString("RankingTXT03");
         }
         else if(GamePlayer.getInstance().language == 7)
         {
            TextField(this._mc.getMC().tf_title).text = "  " + StringManager.getInstance().getMessageString("CommanderText25") + "       " + StringManager.getInstance().getMessageString("CommanderText26") + "     " + StringManager.getInstance().getMessageString("CommanderText27") + "/ID" + "                   " + StringManager.getInstance().getMessageString("CommanderText28") + "                 " + StringManager.getInstance().getMessageString("CommanderText29") + "             " + StringManager.getInstance().getMessageString("CommanderText30") + "      " + StringManager.getInstance().getMessageString("RankingTXT03");
         }
         else if(GamePlayer.getInstance().language == 8)
         {
            TextField(this._mc.getMC().tf_title).text = "  " + StringManager.getInstance().getMessageString("CommanderText25") + " " + StringManager.getInstance().getMessageString("CommanderText26") + "     " + StringManager.getInstance().getMessageString("CommanderText27") + "/ID" + "              " + StringManager.getInstance().getMessageString("CommanderText28") + "             " + StringManager.getInstance().getMessageString("CommanderText29") + "                 " + StringManager.getInstance().getMessageString("CommanderText30") + "      " + StringManager.getInstance().getMessageString("RankingTXT03");
         }
         else if(GamePlayer.getInstance().language == 9)
         {
            TextField(this._mc.getMC().tf_title).text = " " + StringManager.getInstance().getMessageString("CommanderText25") + " " + StringManager.getInstance().getMessageString("CommanderText26") + "  " + StringManager.getInstance().getMessageString("CommanderText27") + "/ID" + "              " + StringManager.getInstance().getMessageString("CommanderText28") + "               " + StringManager.getInstance().getMessageString("CommanderText29") + "                 " + StringManager.getInstance().getMessageString("CommanderText30") + "     " + StringManager.getInstance().getMessageString("RankingTXT03");
         }
         else if(GamePlayer.getInstance().language == 10)
         {
            _loc3_ = TextField(this._mc.getMC().tf_title).getTextFormat();
            _loc3_.align = TextFormatAlign.RIGHT;
            TextField(this._mc.getMC().tf_title).setTextFormat(_loc3_);
            TextField(this._mc.getMC().tf_title).defaultTextFormat = _loc3_;
            TextField(this._mc.getMC().tf_title).text = StringManager.getInstance().getMessageString("RankingTXT03") + "            " + StringManager.getInstance().getMessageString("CommanderText30") + "            " + StringManager.getInstance().getMessageString("CommanderText29") + "       " + StringManager.getInstance().getMessageString("CommanderText28") + "           " + StringManager.getInstance().getMessageString("CommanderText27") + "    " + StringManager.getInstance().getMessageString("CommanderText26") + "       " + StringManager.getInstance().getMessageString("CommanderText25");
         }
         else if(GamePlayer.getInstance().language == 11)
         {
            TextField(this._mc.getMC().tf_title).text = " " + StringManager.getInstance().getMessageString("CommanderText25") + " " + StringManager.getInstance().getMessageString("CommanderText26") + "  " + StringManager.getInstance().getMessageString("CommanderText27") + "/ID" + "              " + StringManager.getInstance().getMessageString("CommanderText28") + "               " + StringManager.getInstance().getMessageString("CommanderText29") + "              " + StringManager.getInstance().getMessageString("CommanderText30") + " " + StringManager.getInstance().getMessageString("RankingTXT03");
         }
         else if(GamePlayer.getInstance().language == 12)
         {
            TextField(this._mc.getMC().tf_title).text = " " + StringManager.getInstance().getMessageString("CommanderText25") + " " + StringManager.getInstance().getMessageString("CommanderText26") + "  " + StringManager.getInstance().getMessageString("CommanderText27") + "/ID" + "              " + StringManager.getInstance().getMessageString("CommanderText28") + "               " + StringManager.getInstance().getMessageString("CommanderText29") + "              " + StringManager.getInstance().getMessageString("CommanderText30") + " " + StringManager.getInstance().getMessageString("RankingTXT03");
         }
         else if(GamePlayer.getInstance().language == 13)
         {
            TextField(this._mc.getMC().tf_title).text = "  " + StringManager.getInstance().getMessageString("CommanderText25") + "   " + StringManager.getInstance().getMessageString("CommanderText26") + " " + StringManager.getInstance().getMessageString("CommanderText27") + "/ID" + "                     " + StringManager.getInstance().getMessageString("CommanderText28") + "                   " + StringManager.getInstance().getMessageString("CommanderText29") + "                " + StringManager.getInstance().getMessageString("CommanderText30") + "       " + StringManager.getInstance().getMessageString("RankingTXT03");
         }
         else if(GamePlayer.getInstance().language == 14)
         {
            TextField(this._mc.getMC().tf_title).text = " " + StringManager.getInstance().getMessageString("CommanderText25") + " " + StringManager.getInstance().getMessageString("CommanderText26") + " " + StringManager.getInstance().getMessageString("CommanderText27") + "/ID" + "              " + StringManager.getInstance().getMessageString("CommanderText28") + "                   " + StringManager.getInstance().getMessageString("CommanderText29") + "                      " + StringManager.getInstance().getMessageString("CommanderText30") + "       " + StringManager.getInstance().getMessageString("RankingTXT03");
         }
         this.removeMC();
         this.UserIdList.splice(0);
         this.UserNameList.splice(0);
         var _loc1_:int = 0;
         while(_loc1_ < RankRouter.getinstance().m_rankuserinfoAry.length)
         {
            _loc4_ = RankRouter.getinstance().m_rankuserinfoAry[_loc1_] as RankUserInfo;
            this.UserIdList.push(_loc4_.UserId);
            this.UserNameList.push(_loc4_.Name);
            _loc1_++;
         }
         this.m_mcRanking.length = 0;
         this._nameMCAry.length = 0;
         this._guidMCAry.length = 0;
         this.m_GuidAry.length = 0;
         var _loc2_:int = 0;
         while(_loc2_ < RankRouter.getinstance().m_rankuserinfoAry.length)
         {
            _loc5_ = this._mc.getMC().getChildByName("mc_list" + _loc2_) as MovieClip;
            _loc6_ = GameKernel.getMovieClipInstance("RankingcontainerMc");
            _loc6_.gotoAndStop("up");
            this.m_mcRanking.push(_loc6_);
            _loc7_ = RankRouter.getinstance().m_rankuserinfoAry[_loc2_] as RankUserInfo;
            TextField(_loc6_.tf_grade).text = String(_loc7_.RankId + 1);
            TextField(_loc6_.tf_id).text = "(ID:" + String(_loc7_.Guid) + ")";
            _loc8_ = "<a href=\'event:" + _loc7_.Guid + "\'>" + _loc7_.Name + "</a>";
            if(_loc6_.tf_name.styleSheet == null)
            {
               _loc10_ = "a:link{text-decoration: underline;} a:hover{color:#ff0000;text-decoration: underline;} a:active{text-decoration: underline;}";
               _loc11_ = new StyleSheet();
               _loc11_.parseCSS(_loc10_);
               _loc6_.tf_name.styleSheet = _loc11_;
            }
            _loc6_.tf_name.htmlText = _loc8_;
            if(!_loc6_.tf_name.hasEventListener(TextEvent.LINK))
            {
               GameInterActiveManager.InstallInterActiveEvent(_loc6_.tf_name,TextEvent.LINK,this.onGoforward);
            }
            TextField(_loc6_.tf_LV).text = String(_loc7_.Level + 1);
            _loc9_ = "<a href=\'event:" + _loc7_.ConsortiaId + "\'>" + _loc7_.ConsortiaName + "</a>";
            if(_loc6_.tf_corps.styleSheet == null)
            {
               _loc12_ = "a:link{text-decoration: underline;} a:hover{color:#ff0000;text-decoration: underline;} a:active{text-decoration: underline;}";
               _loc13_ = new StyleSheet();
               _loc13_.parseCSS(_loc12_);
               _loc6_.tf_corps.styleSheet = _loc13_;
            }
            _loc6_.tf_corps.htmlText = _loc9_;
            if(!_loc6_.tf_corps.hasEventListener(TextEvent.LINK))
            {
               GameInterActiveManager.InstallInterActiveEvent(_loc6_.tf_corps,TextEvent.LINK,this._onGoforward);
            }
            TextField(_loc6_.tf_hit).text = String(_loc7_.KillTotal);
            TextField(_loc6_.tf_attack).text = String(_loc7_.Assault);
            _loc5_.addChild(_loc6_);
            _loc2_++;
         }
         GameKernel.getPlayerFacebookInfoArray(this.UserIdList,this.getPlayerFacebookInfoArrayCallback,this.UserNameList);
         TextField(this._mc.getMC().tf_page).text = String(RankRouter.getinstance().m_pageID + 1) + "/" + String(RankRouter.getinstance().m_maxPagenum);
         if(RankRouter.getinstance().m_pageID > 0)
         {
            this._uppage.gotoAndStop("up");
            this._homepage.gotoAndStop("up");
            this._Buppage.m_statue = HButtonStatue.UP;
            this._Bhomepage.m_statue = HButtonStatue.UP;
         }
         else
         {
            this._uppage.gotoAndStop("disabled");
            this._homepage.gotoAndStop("disabled");
            this._Buppage.m_statue = HButtonStatue.DISABLED;
            this._Bhomepage.m_statue = HButtonStatue.DISABLED;
         }
         if(RankRouter.getinstance().m_pageID + 1 == RankRouter.getinstance().m_maxPagenum)
         {
            this._downpage.gotoAndStop("disabled");
            this._lastpage.gotoAndStop("disabled");
            this._Bdownpage.m_statue = HButtonStatue.DISABLED;
            this._Blastpage.m_statue = HButtonStatue.DISABLED;
         }
         else
         {
            this._downpage.gotoAndStop("up");
            this._lastpage.gotoAndStop("up");
            this._Bdownpage.m_statue = HButtonStatue.UP;
            this._Blastpage.m_statue = HButtonStatue.UP;
         }
      }
      
      private function onGoforward(param1:TextEvent) : void
      {
         ChatAction.getInstance().sendChatUserInfoMessage(-1,int(param1.text),3);
      }
      
      private function _onGoforward(param1:TextEvent) : void
      {
         LoserPopUI.getInstance().ShowConsortia(int(param1.text));
      }
      
      public function showcorpslist() : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:MovieClip = null;
         var _loc4_:CorpsRankInfo = null;
         var _loc5_:Bitmap = null;
         var _loc6_:* = null;
         var _loc7_:* = null;
         var _loc8_:String = null;
         var _loc9_:StyleSheet = null;
         var _loc10_:String = null;
         var _loc11_:StyleSheet = null;
         if(GamePlayer.getInstance().language == 0)
         {
            TextField(this._mc.getMC().tf_title).text = "    " + StringManager.getInstance().getMessageString("CommanderText25") + "     " + StringManager.getInstance().getMessageString("CommanderText31") + "   " + StringManager.getInstance().getMessageString("CommanderText32") + "           " + StringManager.getInstance().getMessageString("CommanderText28") + "         " + StringManager.getInstance().getMessageString("CommanderText33") + "        " + StringManager.getInstance().getMessageString("CommanderText34") + "         " + StringManager.getInstance().getMessageString("CommanderText35");
         }
         else if(GamePlayer.getInstance().language == 1)
         {
            TextField(this._mc.getMC().tf_title).text = "   " + StringManager.getInstance().getMessageString("CommanderText25") + " " + StringManager.getInstance().getMessageString("CommanderText31") + " " + StringManager.getInstance().getMessageString("CommanderText32") + "                              " + StringManager.getInstance().getMessageString("CommanderText28") + "         " + StringManager.getInstance().getMessageString("CommanderText33") + "          " + StringManager.getInstance().getMessageString("CommanderText34") + "         " + StringManager.getInstance().getMessageString("CommanderText35");
         }
         else if(GamePlayer.getInstance().language == 2)
         {
            TextField(this._mc.getMC().tf_title).text = "   " + StringManager.getInstance().getMessageString("CommanderText25") + "  " + StringManager.getInstance().getMessageString("CommanderText31") + " " + StringManager.getInstance().getMessageString("CommanderText32") + "                  " + StringManager.getInstance().getMessageString("CommanderText28") + "      " + StringManager.getInstance().getMessageString("CommanderText33") + "             " + StringManager.getInstance().getMessageString("CommanderText34") + "           " + StringManager.getInstance().getMessageString("CommanderText35");
         }
         else if(GamePlayer.getInstance().language == 3)
         {
            TextField(this._mc.getMC().tf_title).text = "        " + StringManager.getInstance().getMessageString("CommanderText25") + " " + StringManager.getInstance().getMessageString("CommanderText31") + " " + StringManager.getInstance().getMessageString("CommanderText32") + "                        " + StringManager.getInstance().getMessageString("CommanderText28") + "     " + StringManager.getInstance().getMessageString("CommanderText33") + "             " + StringManager.getInstance().getMessageString("CommanderText34") + "             " + StringManager.getInstance().getMessageString("CommanderText35");
         }
         else if(GamePlayer.getInstance().language == 4)
         {
            TextField(this._mc.getMC().tf_title).text = "" + StringManager.getInstance().getMessageString("CommanderText25") + " " + StringManager.getInstance().getMessageString("CommanderText31") + " " + StringManager.getInstance().getMessageString("CommanderText32") + "                      " + StringManager.getInstance().getMessageString("CommanderText28") + "     " + StringManager.getInstance().getMessageString("CommanderText33") + "             " + StringManager.getInstance().getMessageString("CommanderText34") + "         " + StringManager.getInstance().getMessageString("CommanderText35");
         }
         else if(GamePlayer.getInstance().language == 5)
         {
            TextField(this._mc.getMC().tf_title).text = "        " + StringManager.getInstance().getMessageString("CommanderText25") + "     " + StringManager.getInstance().getMessageString("CommanderText31") + " " + StringManager.getInstance().getMessageString("CommanderText32") + "                        " + StringManager.getInstance().getMessageString("CommanderText28") + "       " + StringManager.getInstance().getMessageString("CommanderText33") + "              " + StringManager.getInstance().getMessageString("CommanderText34") + "      " + StringManager.getInstance().getMessageString("CommanderText35");
         }
         else if(GamePlayer.getInstance().language == 6)
         {
            TextField(this._mc.getMC().tf_title).text = "      " + StringManager.getInstance().getMessageString("CommanderText25") + "     " + StringManager.getInstance().getMessageString("CommanderText31") + " " + StringManager.getInstance().getMessageString("CommanderText32") + "                     " + StringManager.getInstance().getMessageString("CommanderText28") + "       " + StringManager.getInstance().getMessageString("CommanderText33") + "              " + StringManager.getInstance().getMessageString("CommanderText34") + "             " + StringManager.getInstance().getMessageString("CommanderText35");
         }
         else if(GamePlayer.getInstance().language == 7)
         {
            TextField(this._mc.getMC().tf_title).text = "        " + StringManager.getInstance().getMessageString("CommanderText25") + "     " + StringManager.getInstance().getMessageString("CommanderText31") + " " + StringManager.getInstance().getMessageString("CommanderText32") + "              " + StringManager.getInstance().getMessageString("CommanderText28") + "         " + StringManager.getInstance().getMessageString("CommanderText33") + "              " + StringManager.getInstance().getMessageString("CommanderText34") + "             " + StringManager.getInstance().getMessageString("CommanderText35");
         }
         else if(GamePlayer.getInstance().language == 8)
         {
            TextField(this._mc.getMC().tf_title).text = "     " + StringManager.getInstance().getMessageString("CommanderText25") + "  " + StringManager.getInstance().getMessageString("CommanderText31") + " " + StringManager.getInstance().getMessageString("CommanderText32") + "            " + StringManager.getInstance().getMessageString("CommanderText28") + "         " + StringManager.getInstance().getMessageString("CommanderText33") + "        " + StringManager.getInstance().getMessageString("CommanderText34") + "          " + StringManager.getInstance().getMessageString("CommanderText35");
         }
         else if(GamePlayer.getInstance().language == 9)
         {
            TextField(this._mc.getMC().tf_title).text = "     " + StringManager.getInstance().getMessageString("CommanderText25") + "  " + StringManager.getInstance().getMessageString("CommanderText31") + " " + StringManager.getInstance().getMessageString("CommanderText32") + "                " + StringManager.getInstance().getMessageString("CommanderText28") + "         " + StringManager.getInstance().getMessageString("CommanderText33") + "             " + StringManager.getInstance().getMessageString("CommanderText34") + "          " + StringManager.getInstance().getMessageString("CommanderText35");
         }
         else if(GamePlayer.getInstance().language == 10)
         {
            TextField(this._mc.getMC().tf_title).text = StringManager.getInstance().getMessageString("CommanderText35") + "                  " + StringManager.getInstance().getMessageString("CommanderText34") + "              " + StringManager.getInstance().getMessageString("CommanderText33") + "   " + StringManager.getInstance().getMessageString("CommanderText28") + "    " + StringManager.getInstance().getMessageString("CommanderText32") + " " + StringManager.getInstance().getMessageString("CommanderText31") + "     " + StringManager.getInstance().getMessageString("CommanderText25");
         }
         else if(GamePlayer.getInstance().language == 11)
         {
            TextField(this._mc.getMC().tf_title).text = "     " + StringManager.getInstance().getMessageString("CommanderText25") + "  " + StringManager.getInstance().getMessageString("CommanderText31") + " " + StringManager.getInstance().getMessageString("CommanderText32") + "                " + StringManager.getInstance().getMessageString("CommanderText28") + "         " + StringManager.getInstance().getMessageString("CommanderText33") + "             " + StringManager.getInstance().getMessageString("CommanderText34") + "          " + StringManager.getInstance().getMessageString("CommanderText35");
         }
         else if(GamePlayer.getInstance().language == 12)
         {
            TextField(this._mc.getMC().tf_title).text = " " + StringManager.getInstance().getMessageString("CommanderText25") + "  " + StringManager.getInstance().getMessageString("CommanderText31") + " " + StringManager.getInstance().getMessageString("CommanderText32") + "            " + StringManager.getInstance().getMessageString("CommanderText28") + "     " + StringManager.getInstance().getMessageString("CommanderText33") + "     " + StringManager.getInstance().getMessageString("CommanderText34") + "       " + StringManager.getInstance().getMessageString("CommanderText35");
         }
         else if(GamePlayer.getInstance().language == 13)
         {
            TextField(this._mc.getMC().tf_title).text = "      " + StringManager.getInstance().getMessageString("CommanderText25") + "      " + StringManager.getInstance().getMessageString("CommanderText31") + " " + StringManager.getInstance().getMessageString("CommanderText32") + "                       " + StringManager.getInstance().getMessageString("CommanderText28") + "     " + StringManager.getInstance().getMessageString("CommanderText33") + "               " + StringManager.getInstance().getMessageString("CommanderText34") + "       " + StringManager.getInstance().getMessageString("CommanderText35");
         }
         else if(GamePlayer.getInstance().language == 14)
         {
            TextField(this._mc.getMC().tf_title).text = "      " + StringManager.getInstance().getMessageString("CommanderText25") + "      " + StringManager.getInstance().getMessageString("CommanderText31") + " " + StringManager.getInstance().getMessageString("CommanderText32") + "                       " + StringManager.getInstance().getMessageString("CommanderText28") + "     " + StringManager.getInstance().getMessageString("CommanderText33") + "               " + StringManager.getInstance().getMessageString("CommanderText34") + "       " + StringManager.getInstance().getMessageString("CommanderText35");
         }
         this.removeMC();
         this.m_mcRanking.length = 0;
         var _loc1_:int = 0;
         while(_loc1_ < RankRouter.getinstance().m_CorpsRankAry.length)
         {
            _loc2_ = this._mc.getMC().getChildByName("mc_list" + _loc1_) as MovieClip;
            _loc3_ = GameKernel.getMovieClipInstance("CorpscontainerMc");
            _loc3_.gotoAndStop("up");
            this.m_mcRanking.push(_loc3_);
            _loc4_ = RankRouter.getinstance().m_CorpsRankAry[_loc1_] as CorpsRankInfo;
            _loc5_ = new Bitmap(GameKernel.getTextureInstance("corp_" + _loc4_.HeadId));
            _loc5_.width = _loc3_.mc_headbase.width;
            _loc5_.height = _loc3_.mc_headbase.height;
            _loc3_.mc_headbase.addChild(_loc5_);
            TextField(_loc3_.tf_grade).text = String(_loc4_.RankId + 1);
            _loc6_ = "<a href=\'event:" + _loc4_.ConsortiaId + "\'>" + _loc4_.Name + "</a>";
            if(_loc3_.tf_name.styleSheet == null)
            {
               _loc8_ = "a:link{text-decoration: underline;} a:hover{color:#ff0000;text-decoration: underline;} a:active{text-decoration: underline;}";
               _loc9_ = new StyleSheet();
               _loc9_.parseCSS(_loc8_);
               _loc3_.tf_name.styleSheet = _loc9_;
            }
            _loc3_.tf_name.htmlText = _loc6_;
            if(!_loc3_.tf_name.hasEventListener(TextEvent.LINK))
            {
               GameInterActiveManager.InstallInterActiveEvent(_loc3_.tf_name,TextEvent.LINK,this._onGoforward);
            }
            TextField(_loc3_.tf_LV).text = String(_loc4_.Level + 1);
            TextField(_loc3_.tf_members).text = String(_loc4_.Member) + "/" + String(_loc4_.MaxMember);
            TextField(_loc3_.tf_honor).text = String(_loc4_.ThrowWealth);
            _loc7_ = "<a href=\'event:" + String(_loc1_) + "\'>" + _loc4_.HoldGalaxy + "</a>";
            if(_loc3_.tf_demesne.styleSheet == null)
            {
               _loc10_ = "a:link{text-decoration: underline;} a:hover{color:#ff0000;text-decoration: underline;} a:active{text-decoration: underline;}";
               _loc11_ = new StyleSheet();
               _loc11_.parseCSS(_loc10_);
               _loc3_.tf_demesne.styleSheet = _loc11_;
            }
            _loc3_.tf_demesne.htmlText = _loc7_;
            if(!_loc3_.tf_demesne.hasEventListener(MouseEvent.MOUSE_OVER))
            {
               GameInterActiveManager.InstallInterActiveEvent(_loc3_.tf_demesne,MouseEvent.MOUSE_OVER,this.showHoldGalaxy);
            }
            if(!_loc3_.tf_demesne.hasEventListener(MouseEvent.MOUSE_OUT))
            {
               GameInterActiveManager.InstallInterActiveEvent(_loc3_.tf_demesne,MouseEvent.MOUSE_OUT,this.closeHoldGalaxy);
            }
            _loc2_.addChild(_loc3_);
            _loc1_++;
         }
         TextField(this._mc.getMC().tf_page).text = String(this.m_corpspageNum + 1) + "/" + String(RankRouter.getinstance().m_maxPagenum);
         if(this.m_corpspageNum > 0)
         {
            this._uppage.gotoAndStop("up");
            this._homepage.gotoAndStop("up");
            this._Buppage.m_statue = HButtonStatue.UP;
            this._Bhomepage.m_statue = HButtonStatue.UP;
         }
         else
         {
            this._uppage.gotoAndStop("disabled");
            this._homepage.gotoAndStop("disabled");
            this._Buppage.m_statue = HButtonStatue.DISABLED;
            this._Bhomepage.m_statue = HButtonStatue.DISABLED;
         }
         if(this.m_corpspageNum + 1 >= RankRouter.getinstance().m_maxPagenum)
         {
            this._downpage.gotoAndStop("disabled");
            this._lastpage.gotoAndStop("disabled");
            this._Bdownpage.m_statue = HButtonStatue.DISABLED;
            this._Blastpage.m_statue = HButtonStatue.DISABLED;
         }
         else
         {
            this._downpage.gotoAndStop("up");
            this._lastpage.gotoAndStop("up");
            this._Bdownpage.m_statue = HButtonStatue.UP;
            this._Blastpage.m_statue = HButtonStatue.UP;
         }
      }
      
      private function showHoldGalaxy(param1:MouseEvent) : void
      {
         var _loc2_:String = param1.currentTarget.parent.parent.name;
         _loc2_ = _loc2_.substr(7);
         var _loc3_:Array = new Array();
         var _loc4_:TextField = new TextField();
         _loc3_.length = 0;
         var _loc5_:int = int(_loc2_);
         var _loc6_:Array = RankRouter.getinstance().m_HoldGalaxyAreaAry[_loc5_];
         var _loc7_:int = 0;
         while(_loc7_ < _loc6_.length)
         {
            if(_loc6_[_loc7_] >= 0)
            {
               _loc4_.text = StringManager.getInstance().getMessageString("RankingTXT05") + String(_loc6_[_loc7_] + 1) + StringManager.getInstance().getMessageString("RankingTXT04");
               _loc3_.push(_loc4_.text);
            }
            _loc7_++;
         }
         if(_loc3_.length == 0)
         {
            return;
         }
         var _loc8_:TextField = param1.currentTarget as TextField;
         var _loc9_:Point = _loc8_.localToGlobal(new Point(0,0));
         _loc9_ = this._mc.getMC().globalToLocal(_loc9_);
         Suspension.getInstance();
         Suspension.getInstance().Init(_loc4_.textWidth + 10,_loc3_.length * 20,1);
         Suspension.getInstance().setLocationXY(_loc9_.x + 40,_loc9_.y + 10);
         var _loc10_:int = 0;
         while(_loc10_ < _loc3_.length)
         {
            Suspension.getInstance().putRectOnlyOne(_loc10_,_loc3_[_loc10_],_loc4_.textWidth + 10);
            _loc10_++;
         }
         this._mc.getMC().addChild(Suspension.getInstance());
      }
      
      private function closeHoldGalaxy(param1:MouseEvent) : void
      {
         if(Suspension.getInstance().parent == null)
         {
            return;
         }
         if(Suspension.getInstance() == null)
         {
            return;
         }
         this._mc.getMC().removeChild(Suspension.getInstance());
         Suspension.getInstance().delinstance();
      }
      
      public function showfightlist() : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:MovieClip = null;
         var _loc4_:RankFightInfo = null;
         var _loc5_:Bitmap = null;
         var _loc6_:HButton = null;
         var _loc7_:Point = null;
         if(GamePlayer.getInstance().language == 0)
         {
            TextField(this._mc.getMC().tf_title).text = " " + StringManager.getInstance().getMessageString("CommanderText110") + "              " + StringManager.getInstance().getMessageString("CommanderText107") + "                   " + StringManager.getInstance().getMessageString("CommanderText29") + "                 " + StringManager.getInstance().getMessageString("CommanderText108") + "            " + StringManager.getInstance().getMessageString("CommanderText109");
         }
         else if(GamePlayer.getInstance().language == 1)
         {
            TextField(this._mc.getMC().tf_title).text = StringManager.getInstance().getMessageString("CommanderText110") + "                   " + StringManager.getInstance().getMessageString("CommanderText107") + "                                " + StringManager.getInstance().getMessageString("CommanderText29") + "                        " + StringManager.getInstance().getMessageString("CommanderText108") + "          " + StringManager.getInstance().getMessageString("CommanderText109");
         }
         else if(GamePlayer.getInstance().language == 2)
         {
            TextField(this._mc.getMC().tf_title).text = StringManager.getInstance().getMessageString("CommanderText110") + "   " + StringManager.getInstance().getMessageString("CommanderText107") + "                                    " + StringManager.getInstance().getMessageString("CommanderText29") + "                                    " + StringManager.getInstance().getMessageString("CommanderText108") + "     " + StringManager.getInstance().getMessageString("CommanderText109");
         }
         else if(GamePlayer.getInstance().language == 3)
         {
            TextField(this._mc.getMC().tf_title).text = StringManager.getInstance().getMessageString("CommanderText110") + "            " + StringManager.getInstance().getMessageString("CommanderText107") + "                                       " + StringManager.getInstance().getMessageString("CommanderText29") + "                                  " + StringManager.getInstance().getMessageString("CommanderText108") + "       " + StringManager.getInstance().getMessageString("CommanderText109");
         }
         else if(GamePlayer.getInstance().language == 4)
         {
            TextField(this._mc.getMC().tf_title).text = StringManager.getInstance().getMessageString("CommanderText110") + "       " + StringManager.getInstance().getMessageString("CommanderText107") + "                                       " + StringManager.getInstance().getMessageString("CommanderText29") + "                              " + StringManager.getInstance().getMessageString("CommanderText108") + "       " + StringManager.getInstance().getMessageString("CommanderText109");
         }
         else if(GamePlayer.getInstance().language == 5)
         {
            TextField(this._mc.getMC().tf_title).text = StringManager.getInstance().getMessageString("CommanderText110") + "   " + StringManager.getInstance().getMessageString("CommanderText107") + "                                         " + StringManager.getInstance().getMessageString("CommanderText29") + "                                    " + StringManager.getInstance().getMessageString("CommanderText108") + "     " + StringManager.getInstance().getMessageString("CommanderText109");
         }
         else if(GamePlayer.getInstance().language == 6)
         {
            TextField(this._mc.getMC().tf_title).text = StringManager.getInstance().getMessageString("CommanderText110") + "          " + StringManager.getInstance().getMessageString("CommanderText107") + "                                         " + StringManager.getInstance().getMessageString("CommanderText29") + "                              " + StringManager.getInstance().getMessageString("CommanderText108") + "           " + StringManager.getInstance().getMessageString("CommanderText109");
         }
         else if(GamePlayer.getInstance().language == 7)
         {
            TextField(this._mc.getMC().tf_title).text = StringManager.getInstance().getMessageString("CommanderText110") + "       " + StringManager.getInstance().getMessageString("CommanderText107") + "                                             " + StringManager.getInstance().getMessageString("CommanderText29") + "                      " + StringManager.getInstance().getMessageString("CommanderText108") + "           " + StringManager.getInstance().getMessageString("CommanderText109");
         }
         else if(GamePlayer.getInstance().language == 8)
         {
            TextField(this._mc.getMC().tf_title).text = StringManager.getInstance().getMessageString("CommanderText110") + "       " + StringManager.getInstance().getMessageString("CommanderText107") + "                                   " + StringManager.getInstance().getMessageString("CommanderText29") + "                      " + StringManager.getInstance().getMessageString("CommanderText108") + "        " + StringManager.getInstance().getMessageString("CommanderText109");
         }
         else if(GamePlayer.getInstance().language == 9)
         {
            TextField(this._mc.getMC().tf_title).text = StringManager.getInstance().getMessageString("CommanderText110") + "     " + StringManager.getInstance().getMessageString("CommanderText107") + "                                       " + StringManager.getInstance().getMessageString("CommanderText29") + "                   " + StringManager.getInstance().getMessageString("CommanderText108") + "       " + StringManager.getInstance().getMessageString("CommanderText109");
         }
         else if(GamePlayer.getInstance().language == 10)
         {
            TextField(this._mc.getMC().tf_title).text = StringManager.getInstance().getMessageString("CommanderText109") + "               " + StringManager.getInstance().getMessageString("CommanderText108") + "                      " + StringManager.getInstance().getMessageString("CommanderText29") + "                               " + StringManager.getInstance().getMessageString("CommanderText107") + "     " + StringManager.getInstance().getMessageString("CommanderText110");
         }
         else if(GamePlayer.getInstance().language == 11)
         {
            TextField(this._mc.getMC().tf_title).text = StringManager.getInstance().getMessageString("CommanderText110") + "     " + StringManager.getInstance().getMessageString("CommanderText107") + "                                       " + StringManager.getInstance().getMessageString("CommanderText29") + "                                " + StringManager.getInstance().getMessageString("CommanderText108") + "      " + StringManager.getInstance().getMessageString("CommanderText109");
         }
         else if(GamePlayer.getInstance().language == 12)
         {
            TextField(this._mc.getMC().tf_title).text = StringManager.getInstance().getMessageString("CommanderText110") + "     " + StringManager.getInstance().getMessageString("CommanderText107") + "                                       " + StringManager.getInstance().getMessageString("CommanderText29") + "                       " + StringManager.getInstance().getMessageString("CommanderText108") + "      " + StringManager.getInstance().getMessageString("CommanderText109");
         }
         else if(GamePlayer.getInstance().language == 13)
         {
            TextField(this._mc.getMC().tf_title).text = StringManager.getInstance().getMessageString("CommanderText110") + "         " + StringManager.getInstance().getMessageString("CommanderText107") + "                                       " + StringManager.getInstance().getMessageString("CommanderText29") + "                                        " + StringManager.getInstance().getMessageString("CommanderText108") + "            " + StringManager.getInstance().getMessageString("CommanderText109");
         }
         else if(GamePlayer.getInstance().language == 14)
         {
            TextField(this._mc.getMC().tf_title).text = StringManager.getInstance().getMessageString("CommanderText110") + "         " + StringManager.getInstance().getMessageString("CommanderText107") + "                                       " + StringManager.getInstance().getMessageString("CommanderText29") + "                                        " + StringManager.getInstance().getMessageString("CommanderText108") + "                " + StringManager.getInstance().getMessageString("CommanderText109");
         }
         this.removeMC();
         this.m_mcRanking.length = 0;
         this.UserIdList.splice(0);
         this.UserNameList.splice(0);
         var _loc1_:int = 0;
         while(_loc1_ < RankRouter.getinstance().m_RankFightAry.length)
         {
            _loc2_ = this._mc.getMC().getChildByName("mc_list" + _loc1_) as MovieClip;
            _loc3_ = GameKernel.getMovieClipInstance("NowbattlerMc");
            _loc3_.gotoAndStop("up");
            this.m_mcRanking.push(_loc3_);
            _loc4_ = RankRouter.getinstance().m_RankFightAry[_loc1_] as RankFightInfo;
            _loc5_ = new Bitmap(GalaxyManager.getStarTexture(_loc4_.StarType));
            _loc5_.width = _loc3_.mc_headbase.width;
            _loc5_.height = _loc3_.mc_headbase.height;
            _loc3_.mc_headbase.addChild(_loc5_);
            _loc6_ = new HButton(_loc3_.btn_enter);
            _loc6_.m_movie.addEventListener(ActionEvent.ACTION_CLICK,this.clickEnter);
            this.UserIdList.push(_loc4_.UserId);
            this.UserNameList.push(_loc4_.UserName);
            TextField(_loc3_.tf_grade).text = String(_loc1_ + this.m_rankfightpageNum * 6 + 1);
            TextField(_loc3_.tf_name).text = _loc4_.UserName;
            TextField(_loc3_.tf_corps).text = _loc4_.ConsortiaName;
            _loc7_ = GalaxyManager.getStarCoordinate(_loc4_.GalaxyId);
            TextField(_loc3_.tf_coordinates).text = String(_loc7_.x) + "," + String(_loc7_.y);
            _loc2_.addChild(_loc3_);
            _loc1_++;
         }
         GameKernel.getPlayerFacebookInfoArray(this.UserIdList,this.getPlayerFacebookInfoArrayCallback,this.UserNameList);
      }
      
      public function setpage() : void
      {
         TextField(this._mc.getMC().tf_page).text = String(this.m_rankfightpageNum + 1) + "/" + String(RankRouter.getinstance().m_maxPagenum);
         if(this.m_rankfightpageNum > 0)
         {
            this._uppage.gotoAndStop("up");
            this._homepage.gotoAndStop("up");
            this._Buppage.m_statue = HButtonStatue.UP;
            this._Bhomepage.m_statue = HButtonStatue.UP;
         }
         else
         {
            this._uppage.gotoAndStop("disabled");
            this._homepage.gotoAndStop("disabled");
            this._Buppage.m_statue = HButtonStatue.DISABLED;
            this._Bhomepage.m_statue = HButtonStatue.DISABLED;
         }
         if(this.m_rankfightpageNum + 1 >= RankRouter.getinstance().m_maxPagenum)
         {
            this._downpage.gotoAndStop("disabled");
            this._lastpage.gotoAndStop("disabled");
            this._Bdownpage.m_statue = HButtonStatue.DISABLED;
            this._Blastpage.m_statue = HButtonStatue.DISABLED;
         }
         else
         {
            this._downpage.gotoAndStop("up");
            this._lastpage.gotoAndStop("up");
            this._Bdownpage.m_statue = HButtonStatue.UP;
            this._Blastpage.m_statue = HButtonStatue.UP;
         }
      }
      
      private function clickEnter(param1:Event) : void
      {
         var _loc2_:String = param1.currentTarget.parent.parent.name;
         _loc2_ = _loc2_.substring(7);
         var _loc3_:int = int(_loc2_);
         var _loc4_:Point = GalaxyManager.getStarCoordinate(RankRouter.getinstance().m_RankFightAry[_loc3_].GalaxyId);
         GameMouseZoneManager.NagivateToolBarByName("btn_universe",true);
         GotoGalaxyUI.instance.GotoGalaxy(_loc4_.x,_loc4_.y);
         GameKernel.popUpDisplayManager.Hide(instance);
      }
      
      private function overButton(param1:Event) : void
      {
         if(param1.currentTarget.name == "btn_synthesisranking")
         {
            if(this.m_IsHit == 0)
            {
               this._synthesisranking.m_movie.gotoAndStop(4);
            }
         }
         else if(param1.currentTarget.name == "btn_treasurerangking")
         {
            if(this.m_IsHit == 1)
            {
               this._hitrangking.m_movie.gotoAndStop(4);
            }
         }
         else if(param1.currentTarget.name == "btn_hitranking")
         {
            if(this.m_IsHit == 2)
            {
               this._corpsrank.m_movie.gotoAndStop(4);
            }
         }
         else if(param1.currentTarget.name == "btn_corpsranking")
         {
            if(this.m_IsHit == 3)
            {
               this._mc.getMC().btn_corpsranking.gotoAndStop(4);
            }
         }
         else if(param1.currentTarget.name == "btn_uppage")
         {
            if(this.m_IsHit == 2)
            {
               if(this.m_corpspageNum > 0)
               {
                  this._uppage.gotoAndStop("over");
               }
               else
               {
                  this._uppage.gotoAndStop("disabled");
               }
            }
            else if(RankRouter.getinstance().m_pageID > 0)
            {
               this._uppage.gotoAndStop("over");
            }
            else
            {
               this._uppage.gotoAndStop("disabled");
            }
         }
         else if(param1.currentTarget.name == "btn_downpage")
         {
            if(this.m_IsHit == 2)
            {
               if(this.m_corpspageNum + 1 == RankRouter.getinstance().m_maxPagenum)
               {
                  this._downpage.gotoAndStop("disabled");
               }
               else
               {
                  this._downpage.gotoAndStop("over");
               }
            }
            else if(RankRouter.getinstance().m_pageID + 1 == RankRouter.getinstance().m_maxPagenum)
            {
               this._downpage.gotoAndStop("disabled");
            }
            else
            {
               this._downpage.gotoAndStop("over");
            }
         }
         else if(param1.currentTarget.name == "btn_homepage")
         {
            if(this.m_IsHit == 2)
            {
               if(this.m_corpspageNum > 0)
               {
                  this._homepage.gotoAndStop("over");
               }
               else
               {
                  this._homepage.gotoAndStop("disabled");
               }
            }
            else if(RankRouter.getinstance().m_pageID > 0)
            {
               this._homepage.gotoAndStop("over");
            }
            else
            {
               this._homepage.gotoAndStop("disabled");
            }
         }
         else if(param1.currentTarget.name == "btn_lastpage")
         {
            if(this.m_IsHit == 2)
            {
               if(this.m_corpspageNum + 1 == RankRouter.getinstance().m_maxPagenum)
               {
                  this._lastpage.gotoAndStop("disabled");
               }
               else
               {
                  this._lastpage.gotoAndStop("over");
               }
            }
            else if(RankRouter.getinstance().m_pageID + 1 == RankRouter.getinstance().m_maxPagenum)
            {
               this._lastpage.gotoAndStop("disabled");
            }
            else
            {
               this._lastpage.gotoAndStop("over");
            }
         }
      }
      
      private function outButton(param1:Event) : void
      {
         if(param1.currentTarget.name == "btn_synthesisranking")
         {
            if(this.m_IsHit == 0)
            {
               this._synthesisranking.m_movie.gotoAndStop(4);
            }
         }
         else if(param1.currentTarget.name == "btn_treasurerangking")
         {
            if(this.m_IsHit == 1)
            {
               this._hitrangking.m_movie.gotoAndStop(4);
            }
         }
         else if(param1.currentTarget.name == "btn_hitranking")
         {
            if(this.m_IsHit == 2)
            {
               this._corpsrank.m_movie.gotoAndStop(4);
            }
         }
         else if(param1.currentTarget.name == "btn_corpsranking")
         {
            if(this.m_IsHit == 3)
            {
               this._mc.getMC().btn_corpsranking.gotoAndStop(4);
            }
         }
         else if(param1.currentTarget.name == "btn_uppage")
         {
            if(this.m_IsHit == 2)
            {
               if(this.m_corpspageNum > 0)
               {
                  this._uppage.gotoAndStop("up");
               }
               else
               {
                  this._uppage.gotoAndStop("disabled");
               }
            }
            else if(RankRouter.getinstance().m_pageID > 0)
            {
               this._uppage.gotoAndStop("up");
            }
            else
            {
               this._uppage.gotoAndStop("disabled");
            }
         }
         else if(param1.currentTarget.name == "btn_downpage")
         {
            if(this.m_IsHit == 2)
            {
               if(this.m_corpspageNum + 1 == RankRouter.getinstance().m_maxPagenum)
               {
                  this._downpage.gotoAndStop("disabled");
               }
               else
               {
                  this._downpage.gotoAndStop("up");
               }
            }
            else if(RankRouter.getinstance().m_pageID + 1 == RankRouter.getinstance().m_maxPagenum)
            {
               this._downpage.gotoAndStop("disabled");
            }
            else
            {
               this._downpage.gotoAndStop("up");
            }
         }
         else if(param1.currentTarget.name == "btn_homepage")
         {
            if(this.m_IsHit == 2)
            {
               if(this.m_corpspageNum > 0)
               {
                  this._homepage.gotoAndStop("up");
               }
               else
               {
                  this._homepage.gotoAndStop("disabled");
               }
            }
            else if(RankRouter.getinstance().m_pageID > 0)
            {
               this._homepage.gotoAndStop("up");
            }
            else
            {
               this._homepage.gotoAndStop("disabled");
            }
         }
         else if(param1.currentTarget.name == "btn_lastpage")
         {
            if(this.m_IsHit == 2)
            {
               if(this.m_corpspageNum + 1 == RankRouter.getinstance().m_maxPagenum)
               {
                  this._lastpage.gotoAndStop("disabled");
               }
               else
               {
                  this._lastpage.gotoAndStop("up");
               }
            }
            else if(RankRouter.getinstance().m_pageID + 1 == RankRouter.getinstance().m_maxPagenum)
            {
               this._lastpage.gotoAndStop("disabled");
            }
            else
            {
               this._lastpage.gotoAndStop("up");
            }
         }
      }
      
      private function restoreList(param1:int) : void
      {
         var _loc2_:MovieClip = this._mc.getMC().getChildByName("mc_list" + param1) as MovieClip;
         var _loc3_:MovieClip = _loc2_.getChildAt(0) as MovieClip;
         _loc3_.gotoAndStop("up");
      }
      
      private function LightChoose(param1:int) : void
      {
         var _loc2_:MovieClip = this._mc.getMC().getChildByName("mc_list" + param1) as MovieClip;
         var _loc3_:MovieClip = _loc2_.getChildAt(0) as MovieClip;
         this.m_Guid = param1;
         _loc3_.gotoAndStop("selected");
      }
      
      private function chooseList(param1:Event) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc2_:String = param1.currentTarget.name;
         _loc2_ = _loc2_.substring(7);
         var _loc3_:int = int(_loc2_);
         if(this.m_IsHit == 0)
         {
            _loc4_ = 0;
            while(_loc4_ < RankRouter.getinstance().m_rankuserinfoAry.length)
            {
               this.restoreList(_loc4_);
               _loc4_++;
            }
            if(_loc3_ < RankRouter.getinstance().m_rankuserinfoAry.length)
            {
               this.LightChoose(_loc3_);
            }
         }
         else if(this.m_IsHit == 1)
         {
            _loc5_ = 0;
            while(_loc5_ < RankRouter.getinstance().m_rankuserinfoAry.length)
            {
               this.restoreList(_loc5_);
               _loc5_++;
            }
            if(_loc3_ < RankRouter.getinstance().m_rankuserinfoAry.length)
            {
               this.LightChoose(_loc3_);
            }
         }
         else if(this.m_IsHit == 2)
         {
            _loc6_ = 0;
            while(_loc6_ < RankRouter.getinstance().m_CorpsRankAry.length)
            {
               this.restoreList(_loc6_);
               _loc6_++;
            }
            if(_loc3_ < RankRouter.getinstance().m_CorpsRankAry.length)
            {
               this.LightChoose(_loc3_);
            }
         }
      }
      
      private function chickButton(param1:MouseEvent) : void
      {
         if(param1.currentTarget.name == "btn_synthesisranking")
         {
            this.m_IsHit = 0;
            this._mc.getMC().btn_synthesisranking.gotoAndStop(4);
            this._mc.getMC().btn_treasurerangking.gotoAndStop("up");
            this._mc.getMC().btn_hitranking.gotoAndStop("up");
            this._mc.getMC().btn_corpsranking.gotoAndStop("up");
            RankRouter.getinstance().sendMsgRANKCENT(-1);
         }
         else if(param1.currentTarget.name == "btn_treasurerangking")
         {
            this.m_IsHit = 1;
            this._mc.getMC().btn_treasurerangking.gotoAndStop(4);
            this._mc.getMC().btn_synthesisranking.gotoAndStop("up");
            this._mc.getMC().btn_hitranking.gotoAndStop("up");
            this._mc.getMC().btn_corpsranking.gotoAndStop("up");
            RankRouter.getinstance().sengMsgRANKKILLTOTAL(-1);
         }
         else if(param1.currentTarget.name == "btn_hitranking")
         {
            this.m_IsHit = 2;
            this._mc.getMC().btn_hitranking.gotoAndStop(4);
            this._mc.getMC().btn_synthesisranking.gotoAndStop("up");
            this._mc.getMC().btn_treasurerangking.gotoAndStop("up");
            this._mc.getMC().btn_corpsranking.gotoAndStop("up");
            this.m_corpspageNum = 0;
            RankRouter.getinstance().sengMsgCONSORTIARANK(this.m_corpspageNum);
            this.showcorpslist();
         }
         else if(param1.currentTarget.name == "btn_corpsranking")
         {
            this.m_IsHit = 3;
            this._mc.getMC().btn_corpsranking.gotoAndStop(4);
            this._mc.getMC().btn_hitranking.gotoAndStop("up");
            this._mc.getMC().btn_synthesisranking.gotoAndStop("up");
            this._mc.getMC().btn_treasurerangking.gotoAndStop("up");
            this.m_rankfightpageNum = 0;
            RankRouter.getinstance().sendMsgRANKFIGHT(this.m_rankfightpageNum);
            this.showfightlist();
         }
         else if(param1.currentTarget.name == "btn_close")
         {
            this.m_IsHit = 0;
            GameKernel.popUpDisplayManager.Hide(instance);
         }
         else if(param1.currentTarget.name == "btn_uppage")
         {
            if(this.m_IsHit == 0 && RankRouter.getinstance().m_pageID > 0)
            {
               RankRouter.getinstance().sendMsgRANKCENT(RankRouter.getinstance().m_pageID - 1);
            }
            else if(this.m_IsHit == 1 && RankRouter.getinstance().m_pageID > 0)
            {
               RankRouter.getinstance().sengMsgRANKKILLTOTAL(RankRouter.getinstance().m_pageID - 1);
            }
            else if(this.m_IsHit == 2 && this.m_corpspageNum > 0)
            {
               --this.m_corpspageNum;
               RankRouter.getinstance().sengMsgCONSORTIARANK(this.m_corpspageNum);
            }
            else if(this.m_IsHit == 3 && this.m_rankfightpageNum > 0)
            {
               --this.m_rankfightpageNum;
               RankRouter.getinstance().sendMsgRANKFIGHT(this.m_rankfightpageNum);
            }
         }
         else if(param1.currentTarget.name == "btn_downpage")
         {
            if(this.m_IsHit == 0 && RankRouter.getinstance().m_pageID < RankRouter.getinstance().m_maxPagenum - 1)
            {
               RankRouter.getinstance().sendMsgRANKCENT(RankRouter.getinstance().m_pageID + 1);
            }
            else if(this.m_IsHit == 1 && RankRouter.getinstance().m_pageID < RankRouter.getinstance().m_maxPagenum - 1)
            {
               RankRouter.getinstance().sengMsgRANKKILLTOTAL(RankRouter.getinstance().m_pageID + 1);
            }
            else if(this.m_IsHit == 2 && this.m_corpspageNum < RankRouter.getinstance().m_maxPagenum - 1)
            {
               ++this.m_corpspageNum;
               RankRouter.getinstance().sengMsgCONSORTIARANK(this.m_corpspageNum);
            }
            else if(this.m_IsHit == 3 && this.m_rankfightpageNum < RankRouter.getinstance().m_maxPagenum - 1)
            {
               ++this.m_rankfightpageNum;
               RankRouter.getinstance().sendMsgRANKFIGHT(this.m_rankfightpageNum);
            }
         }
         else if(param1.currentTarget.name == "btn_homepage")
         {
            if(this.m_IsHit == 0 && RankRouter.getinstance().m_pageID > 0)
            {
               RankRouter.getinstance().m_pageID = 0;
               RankRouter.getinstance().sendMsgRANKCENT(RankRouter.getinstance().m_pageID);
            }
            else if(this.m_IsHit == 1 && RankRouter.getinstance().m_pageID > 0)
            {
               RankRouter.getinstance().m_pageID = 0;
               RankRouter.getinstance().sengMsgRANKKILLTOTAL(RankRouter.getinstance().m_pageID);
            }
            else if(this.m_IsHit == 2 && this.m_corpspageNum > 0)
            {
               this.m_corpspageNum = 0;
               RankRouter.getinstance().sengMsgCONSORTIARANK(this.m_corpspageNum);
            }
            else if(this.m_IsHit == 3 && this.m_rankfightpageNum > 0)
            {
               this.m_rankfightpageNum = 0;
               RankRouter.getinstance().sendMsgRANKFIGHT(this.m_rankfightpageNum);
            }
         }
         else if(param1.currentTarget.name == "btn_lastpage")
         {
            if(this.m_IsHit == 0 && RankRouter.getinstance().m_pageID < RankRouter.getinstance().m_maxPagenum - 1)
            {
               RankRouter.getinstance().m_pageID = RankRouter.getinstance().m_maxPagenum - 1;
               RankRouter.getinstance().sendMsgRANKCENT(RankRouter.getinstance().m_pageID);
            }
            else if(this.m_IsHit == 1 && RankRouter.getinstance().m_pageID < RankRouter.getinstance().m_maxPagenum - 1)
            {
               RankRouter.getinstance().m_pageID = RankRouter.getinstance().m_maxPagenum - 1;
               RankRouter.getinstance().sengMsgRANKKILLTOTAL(RankRouter.getinstance().m_pageID);
            }
            else if(this.m_IsHit == 2 && this.m_corpspageNum < RankRouter.getinstance().m_maxPagenum - 1)
            {
               this.m_corpspageNum = RankRouter.getinstance().m_maxPagenum - 1;
               RankRouter.getinstance().sengMsgCONSORTIARANK(this.m_corpspageNum);
            }
            else if(this.m_IsHit == 3 && this.m_rankfightpageNum < RankRouter.getinstance().m_maxPagenum - 1)
            {
               this.m_rankfightpageNum = RankRouter.getinstance().m_maxPagenum - 1;
               RankRouter.getinstance().sendMsgRANKFIGHT(this.m_rankfightpageNum);
            }
         }
         else if(param1.currentTarget.name == "btn_search")
         {
            if(this._mc.getMC().tf_input.text == StringManager.getInstance().getMessageString("RankingTXT01") || this._mc.getMC().tf_input.text == "")
            {
               CEffectText.getInstance().showEffectText(GameKernel.renderManager.getUI().getContainer(),StringManager.getInstance().getMessageString("RankingTXT01"));
               return;
            }
            if(this.m_IsHit == 0)
            {
               RankRouter.getinstance().sendMsgRANKCENT(-1,this._mc.getMC().tf_input.text);
            }
            else if(this.m_IsHit == 1)
            {
               RankRouter.getinstance().sengMsgRANKKILLTOTAL(-1,this._mc.getMC().tf_input.text);
            }
         }
         else if(param1.currentTarget.name == "tf_input")
         {
            this._mc.getMC().tf_input.text = "";
         }
         else if(param1.currentTarget.name == "btn_honor")
         {
            this.addBackMC();
            LeaguerangeSceneUI.getInstance().Init();
            LeaguerangeSceneUI.getInstance().setParent("RankingSceneUI");
            LeaguerangeRouter.getInstance().sendMsgRANKMATCH(-1,-1);
            GameKernel.popUpDisplayManager.Show(LeaguerangeSceneUI.getInstance());
         }
      }
      
      public function noFind() : void
      {
         CEffectText.getInstance().showEffectText(GameKernel.renderManager.getUI().getContainer(),StringManager.getInstance().getMessageString("RankingTXT02"));
      }
      
      public function addBackMC() : void
      {
         this.backMc.graphics.clear();
         this.backMc.graphics.beginFill(16711935,0);
         this.backMc.graphics.drawRect(-380,-340,760,850);
         this.backMc.graphics.endFill();
         this._mc.getMC().addChild(this.backMc);
      }
      
      public function removeBackMC() : void
      {
         this._mc.getMC().removeChild(this.backMc);
      }
      
      private function getPlayerFacebookInfoArrayCallback(param1:Array) : void
      {
         var _loc2_:FacebookUserInfo = null;
         var _loc3_:int = 0;
         var _loc4_:RankUserInfo = null;
         var _loc5_:MovieClip = null;
         var _loc6_:* = null;
         var _loc7_:String = null;
         var _loc8_:StyleSheet = null;
         if(param1 == null)
         {
            return;
         }
         for each(_loc2_ in param1)
         {
            if(this.m_IsHit != 3)
            {
               _loc3_ = 0;
               while(_loc3_ < RankRouter.getinstance().m_rankuserinfoAry.length)
               {
                  _loc4_ = RankRouter.getinstance().m_rankuserinfoAry[_loc3_] as RankUserInfo;
                  if(_loc4_.UserId == _loc2_.uid)
                  {
                     _loc5_ = this.m_mcRanking[_loc3_] as MovieClip;
                     _loc6_ = "<a href=\'event:" + _loc4_.Guid + "\'>" + _loc2_.first_name + "</a>";
                     if(_loc5_.tf_name.styleSheet == null)
                     {
                        _loc7_ = "a:link{text-decoration: underline;} a:hover{color:#ff0000;text-decoration: underline;} a:active{text-decoration: underline;}";
                        _loc8_ = new StyleSheet();
                        _loc8_.parseCSS(_loc7_);
                        _loc5_.tf_name.styleSheet = _loc8_;
                     }
                     _loc5_.tf_name.htmlText = _loc6_;
                     if(!_loc5_.tf_name.hasEventListener(TextEvent.LINK))
                     {
                        GameInterActiveManager.InstallInterActiveEvent(_loc5_.tf_name,TextEvent.LINK,this.onGoforward);
                     }
                  }
                  _loc3_++;
               }
               FleetInfoUI_Res.GetInstance().GetFacebookUserImg(_loc2_.uid,_loc2_.pic_square,this.GetFacebookUserImgCallback);
            }
         }
      }
      
      private function GetFacebookUserImgCallback(param1:Number, param2:DisplayObject) : void
      {
         var _loc4_:RankUserInfo = null;
         var _loc5_:MovieClip = null;
         var _loc6_:MovieClip = null;
         if(param2 == null)
         {
            return;
         }
         var _loc3_:int = 0;
         while(_loc3_ < RankRouter.getinstance().m_rankuserinfoAry.length)
         {
            _loc4_ = RankRouter.getinstance().m_rankuserinfoAry[_loc3_] as RankUserInfo;
            if(_loc4_.UserId == param1)
            {
               _loc5_ = this.m_mcRanking[_loc3_] as MovieClip;
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
   }
}

