package logic.ui
{
   import com.star.frameworks.events.ActionEvent;
   import com.star.frameworks.facebook.FacebookUserInfo;
   import com.star.frameworks.managers.StringManager;
   import flash.display.MovieClip;
   import flash.events.TextEvent;
   import flash.geom.Point;
   import flash.text.StyleSheet;
   import flash.text.TextField;
   import logic.action.ChatAction;
   import logic.entry.GamePlayer;
   import logic.game.GameKernel;
   import logic.game.GameMouseZoneManager;
   import logic.manager.GalaxyManager;
   import logic.widget.DataWidget;
   import net.base.NetManager;
   import net.msg.corpsMsg.MSG_REQUEST_CONSORTIAEVENT;
   import net.msg.corpsMsg.MSG_RESP_CONSORTIAEVENT;
   import net.msg.corpsMsg.MSG_RESP_CONSORTIAEVENT_TEMP;
   
   public class MyCorpsUI_Matterlist implements MyCorpsUI_Base
   {
      
      private static var instance:MyCorpsUI_Matterlist;
      
      public var McList:Array;
      
      public var PageIndex:int;
      
      public var PageCount:int;
      
      private var _PageRows:int;
      
      private var MatterlistMsg:MSG_RESP_CONSORTIAEVENT;
      
      private var ListType:int;
      
      private var UserIdList:Array;
      
      private var RowIdList:Array;
      
      private var UserNameList:Array;
      
      private var TextFieldColor:int;
      
      public function MyCorpsUI_Matterlist(param1:int)
      {
         var _loc5_:MovieClip = null;
         this.UserIdList = new Array();
         this.RowIdList = new Array();
         this.UserNameList = new Array();
         super();
         if(param1 > 0)
         {
            this._PageRows = param1;
         }
         this.ListType = -1;
         this.PageIndex = 0;
         this.McList = new Array();
         var _loc2_:String = "a:link{text-decoration: underline;} a:hover{color:#ff0000;text-decoration: underline;} a:active{text-decoration: underline;}";
         var _loc3_:StyleSheet = new StyleSheet();
         _loc3_.parseCSS(_loc2_);
         var _loc4_:int = 0;
         while(_loc4_ < this._PageRows)
         {
            _loc5_ = GameKernel.getMovieClipInstance("MatterlistPlan",0,0,false);
            _loc5_.tf_matter.styleSheet = _loc3_;
            TextField(_loc5_.tf_matter).addEventListener(ActionEvent.ACTION_TEXT_LINK,this.tf_matterClick);
            this.McList.push(_loc5_);
            _loc4_++;
         }
      }
      
      public static function getInstance(param1:int = -1) : MyCorpsUI_Matterlist
      {
         if(instance == null)
         {
            instance = new MyCorpsUI_Matterlist(param1);
         }
         return instance;
      }
      
      public function GetList(param1:int = -1) : Array
      {
         if(param1 >= 0)
         {
            this.PageIndex = param1;
            this.RequestMatterlist();
         }
         return this.McList;
      }
      
      public function SetEventType(param1:int) : void
      {
         this.PageIndex = 0;
         this.PageCount = 0;
         this.ListType = param1;
         this.RequestMatterlist();
      }
      
      public function GetPageIndex() : int
      {
         return this.PageIndex;
      }
      
      public function GetPageCount() : int
      {
         return this.PageCount;
      }
      
      public function NextPage() : Array
      {
         if(this.PageIndex + 1 < this.PageCount)
         {
            ++this.PageIndex;
            this.RequestMatterlist();
         }
         return this.McList;
      }
      
      public function PrePage() : Array
      {
         if(this.PageIndex > 0)
         {
            --this.PageIndex;
            this.RequestMatterlist();
         }
         return this.McList;
      }
      
      public function GetHeadString() : String
      {
         return StringManager.getInstance().getMessageString("CorpsText103");
      }
      
      private function ClearList() : void
      {
         var _loc2_:MovieClip = null;
         var _loc1_:int = 0;
         while(_loc1_ < this._PageRows)
         {
            _loc2_ = this.McList[_loc1_] as MovieClip;
            _loc2_.visible = false;
            _loc1_++;
         }
      }
      
      private function RequestMatterlist() : void
      {
         this.ClearList();
         var _loc1_:MSG_REQUEST_CONSORTIAEVENT = new MSG_REQUEST_CONSORTIAEVENT();
         _loc1_.PageId = this.PageIndex;
         _loc1_.Type = this.ListType;
         _loc1_.SeqId = GamePlayer.getInstance().seqID++;
         _loc1_.Guid = GamePlayer.getInstance().Guid;
         NetManager.Instance().sendObject(_loc1_);
      }
      
      public function RespMatterlist(param1:MSG_RESP_CONSORTIAEVENT) : void
      {
         var _loc2_:TextField = null;
         var _loc4_:MovieClip = null;
         var _loc5_:MSG_RESP_CONSORTIAEVENT_TEMP = null;
         var _loc6_:String = null;
         var _loc7_:int = 0;
         this.UserIdList.splice(0);
         this.RowIdList.splice(0);
         this.UserNameList.splice(0);
         this.MatterlistMsg = param1;
         this.PageCount = param1.EventCount / this._PageRows;
         if(this.PageCount * this._PageRows < param1.EventCount)
         {
            ++this.PageCount;
         }
         if(this.PageIndex + 1 > this.PageCount)
         {
            this.PageIndex = this.PageCount - 1;
         }
         MyCorpsUI.getInstance().ShowPageButton();
         var _loc3_:int = 0;
         while(_loc3_ < this._PageRows)
         {
            _loc4_ = this.McList[_loc3_] as MovieClip;
            if(_loc3_ < param1.DataLen)
            {
               _loc5_ = param1.Data[_loc3_];
               TextField(_loc4_.tf_matter).htmlText = this.GetEventString(_loc3_,_loc5_);
               _loc6_ = StringManager.getInstance().getMessageString("CorpsText119");
               TextField(_loc4_.tf_time).text = _loc6_.replace("@@1",DataWidget.localToDataZone(_loc5_.PassTime));
               _loc4_.visible = true;
               if(this.TextFieldColor == 1)
               {
                  _loc7_ = 8821431;
               }
               else if(this.TextFieldColor == 2)
               {
                  _loc7_ = 13923095;
               }
               else if(this.TextFieldColor == 3)
               {
                  _loc7_ = 1821183;
               }
               TextField(_loc4_.tf_matter).textColor = _loc7_;
               TextField(_loc4_.tf_time).textColor = _loc7_;
            }
            else
            {
               _loc4_.visible = false;
            }
            _loc3_++;
         }
      }
      
      private function GetUserLink(param1:String, param2:Number) : String
      {
         return "<a href=\'event:1," + param2 + "\'>" + param1 + "</a>";
      }
      
      private function GetStarLink(param1:String, param2:int) : String
      {
         return "<a href=\'event:2," + param2 + "\'>" + param1 + "</a>";
      }
      
      private function GetEventString(param1:int, param2:MSG_RESP_CONSORTIAEVENT_TEMP) : String
      {
         var _loc3_:String = null;
         var _loc4_:Point = null;
         var _loc5_:Point = null;
         if(param2.BigType == 0)
         {
            this.TextFieldColor = 1;
            _loc3_ = StringManager.getInstance().getMessageString("CorpsText" + int(93 + param2.SmallType));
            _loc3_ = _loc3_ + int(param2.Extend + 1) + StringManager.getInstance().getMessageString("CorpsText104");
         }
         else if(param2.BigType == 1)
         {
            if(param2.SmallType == 0 || param2.SmallType == 1)
            {
               if(param2.SmallType == 0)
               {
                  this.TextFieldColor = 1;
               }
               else
               {
                  this.TextFieldColor = 2;
               }
               _loc3_ = StringManager.getInstance().getMessageString("CorpsText105");
               _loc3_ = _loc3_.replace("@@1",this.GetUserLink(param2.SrcName,param2.SrcUserId));
               _loc3_ = _loc3_.replace("@@2",MyCorpsUI.getInstance()._ConsortiaJobName[param2.Extend]);
            }
            else if(param2.SmallType == 2)
            {
               this.TextFieldColor = 3;
               _loc3_ = StringManager.getInstance().getMessageString("CorpsText106");
               _loc3_ = _loc3_.replace("@@1",this.GetUserLink(param2.SrcName,param2.SrcUserId));
            }
            else if(param2.SmallType == 3)
            {
               this.TextFieldColor = 2;
               _loc3_ = StringManager.getInstance().getMessageString("CorpsText107");
               _loc3_ = _loc3_.replace("@@1",this.GetUserLink(param2.SrcName,param2.SrcUserId));
            }
            else if(param2.SmallType == 4)
            {
               this.TextFieldColor = 2;
               _loc3_ = StringManager.getInstance().getMessageString("CorpsText108");
               _loc3_ = _loc3_.replace("@@1",this.GetUserLink(param2.SrcName,param2.SrcUserId));
            }
            else if(param2.SmallType == 5)
            {
               this.TextFieldColor = 2;
               this.UserIdList.push(param2.ObjUserId);
               this.RowIdList.push(param1);
               this.UserNameList.push(param2.ObjName);
               _loc3_ = StringManager.getInstance().getMessageString("CorpsText109");
               _loc3_ = _loc3_.replace("@@1",this.GetUserLink(param2.SrcName,param2.SrcUserId));
               _loc3_ = _loc3_.replace("@@2",this.GetUserLink(param2.ObjName,param2.ObjUserId));
            }
            this.UserIdList.push(param2.SrcUserId);
            this.RowIdList.push(param1);
            this.UserNameList.push(param2.SrcName);
         }
         else if(param2.BigType == 2)
         {
            _loc4_ = GalaxyManager.getStarCoordinate(param2.Extend);
            if(param2.JumpType == 0)
            {
               _loc3_ = StringManager.getInstance().getMessageString("CorpsText110");
               _loc3_ = _loc3_.replace("@@1",this.GetUserLink(param2.SrcName,param2.SrcUserId));
               _loc3_ = _loc3_.replace("@@2",this.GetStarLink(_loc4_.x + "," + _loc4_.y,param2.Extend));
               if(param2.SmallType == 1)
               {
                  this.TextFieldColor = 2;
                  _loc3_ += StringManager.getInstance().getMessageString("CorpsText111");
               }
               else
               {
                  this.TextFieldColor = 1;
                  _loc3_ += StringManager.getInstance().getMessageString("CorpsText112");
               }
            }
            else
            {
               _loc3_ = StringManager.getInstance().getMessageString("CorpsText110");
               _loc3_ = _loc3_.replace("@@1",this.GetUserLink(param2.SrcName,param2.SrcUserId));
               _loc3_ = _loc3_.replace("@@2",this.GetStarLink(_loc4_.x + "," + _loc4_.y,param2.Extend));
               if(param2.SmallType == 0)
               {
                  this.TextFieldColor = 2;
                  _loc3_ += StringManager.getInstance().getMessageString("CorpsText113");
               }
               else
               {
                  this.TextFieldColor = 1;
                  _loc3_ += StringManager.getInstance().getMessageString("CorpsText114");
               }
            }
            this.UserIdList.push(param2.SrcUserId);
            this.RowIdList.push(param1);
            this.UserNameList.push(param2.SrcName);
         }
         else if(param2.BigType == 3)
         {
            this.TextFieldColor = 3;
            if(param2.SmallType == 0)
            {
               _loc3_ = StringManager.getInstance().getMessageString("CorpsText115") + param2.Extend;
            }
            else
            {
               _loc3_ = StringManager.getInstance().getMessageString("CorpsText116") + param2.Guid;
            }
         }
         else if(param2.BigType == 4)
         {
            _loc5_ = GalaxyManager.getStarCoordinate(param2.Extend);
            if(param2.SmallType == 0)
            {
               this.TextFieldColor = 1;
               _loc3_ = StringManager.getInstance().getMessageString("CorpsText117");
               _loc3_ = _loc3_.replace("@@1",this.GetStarLink(_loc5_.x + "," + _loc5_.y,param2.Extend));
            }
            else
            {
               this.TextFieldColor = 2;
               _loc3_ = StringManager.getInstance().getMessageString("CorpsText118");
               _loc3_ = _loc3_.replace("@@1",this.GetStarLink(_loc5_.x + "," + _loc5_.y,param2.Extend));
            }
         }
         return _loc3_;
      }
      
      private function getPlayerFacebookInfoArrayCallback(param1:Array) : void
      {
         var _loc2_:FacebookUserInfo = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:MovieClip = null;
         var _loc6_:TextField = null;
         var _loc7_:String = null;
         for each(_loc2_ in param1)
         {
            _loc3_ = 0;
            while(_loc3_ < this.UserIdList.length)
            {
               if(_loc2_.uid == this.UserIdList[_loc3_])
               {
                  _loc4_ = int(this.RowIdList[_loc3_]);
                  _loc5_ = this.McList[_loc4_] as MovieClip;
                  _loc6_ = _loc5_.getChildByName("tf_matter") as TextField;
                  _loc7_ = _loc6_.htmlText;
                  _loc7_ = _loc7_.replace(this.UserIdList[_loc3_] + "_",_loc2_.first_name);
                  _loc7_ = _loc7_.replace("\r","");
                  _loc7_ = _loc7_.replace("\n","");
                  _loc6_.htmlText = _loc7_;
                  _loc6_.textColor = TextField(_loc5_.tf_time).textColor;
               }
               _loc3_++;
            }
         }
      }
      
      private function tf_matterClick(param1:TextEvent) : void
      {
         var _loc3_:Point = null;
         var _loc2_:Array = param1.text.split(",");
         if(_loc2_[0] == "1")
         {
            ChatAction.getInstance().sendChatUserInfoMessage(-1,-1,3,_loc2_[1]);
         }
         else
         {
            _loc3_ = GalaxyManager.getStarCoordinate(_loc2_[1]);
            GameMouseZoneManager.NagivateToolBarByName("btn_universe",true);
            GotoGalaxyUI.instance.GotoGalaxy(_loc3_.x,_loc3_.y);
         }
      }
   }
}

