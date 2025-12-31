package logic.manager
{
   import com.star.frameworks.managers.ResManager;
   import com.star.frameworks.managers.StringManager;
   import com.star.frameworks.utils.HashSet;
   import com.star.frameworks.utils.MusicResHandler;
   import flash.display.DisplayObjectContainer;
   import flash.utils.ByteArray;
   import logic.action.ConstructionAction;
   import logic.entry.FBModel;
   import logic.entry.GShipTeam;
   import logic.entry.GamePlayer;
   import logic.entry.test.FBModelView;
   import logic.ui.FightResultUI;
   import logic.ui.GalaxyMatchUI;
   import logic.ui.InstanceMenuUI;
   import logic.ui.InstanceUI;
   import logic.ui.WrestleUI;
   import net.base.NetManager;
   import net.common.MsgTypes;
   import net.msg.fightMsg.MSG_REQUEST_ECTYPE;
   import net.msg.fightMsg.MSG_REQUEST_ECTYPEINFO;
   import net.msg.fightMsg.MSG_RESP_ARENA_PAGE;
   import net.msg.fightMsg.MSG_RESP_ARENA_STATUS;
   import net.msg.fightMsg.MSG_RESP_ECTYPESTATE;
   import net.msg.instance.MSG_RESP_ECTYPEPASS;
   import net.msg.ship.MSG_RESP_JUMPGALAXYSHIP_TEMP;
   
   public class InstanceManager
   {
      
      public static const FB_NONE:int = 0;
      
      public static const FB_FIGHT:int = 1;
      
      public static const FB_OUT:int = 2;
      
      public static const FB_NEXT:int = 3;
      
      public static const FB_WAITING:int = 4;
      
      private static var _instance:InstanceManager = null;
      
      private var _dataList:HashSet = new HashSet();
      
      private var _dataViewList:HashSet = new HashSet();
      
      private var _passedFB:Array = new Array();
      
      private var _challengeDataList:HashSet = new HashSet();
      
      private var _challengeDataViewList:HashSet = new HashSet();
      
      private var _passedChallengeFB:int = 30;
      
      private var _curEctype:int = -1;
      
      private var _curGateId:int = 0;
      
      private var _curSelectFB:FBModel = null;
      
      private var _curStatus:int = 0;
      
      private var _instanceStatus:int = 2;
      
      public var bRequestGalaxy:Boolean = false;
      
      public function InstanceManager(param1:HHH)
      {
         super();
         this.InitData();
      }
      
      public static function get instance() : InstanceManager
      {
         if(_instance == null)
         {
            _instance = new InstanceManager(new HHH());
         }
         return _instance;
      }
      
      private function InitData() : void
      {
         var _loc2_:String = null;
         var _loc4_:FBModel = null;
         var _loc6_:XML = null;
         var _loc1_:XML = ResManager.getInstance().getXml(ResManager.GAMERES,"Instance");
         var _loc3_:RegExp = /[0-9]$/;
         var _loc5_:String = "";
         for each(_loc6_ in _loc1_.*)
         {
            _loc4_ = new FBModel();
            _loc4_.McName = _loc1_.@MC;
            _loc4_.LineColor = _loc1_.@LineColor;
            _loc4_.ID = _loc6_.@ID;
            _loc4_.PosX = _loc6_.@X;
            _loc4_.PosY = _loc6_.@Y;
            _loc4_.Name = _loc6_.@Name;
            _loc4_.Repeat = _loc6_.@Repeat;
            _loc4_.Type = _loc6_.@Type;
            _loc4_.EctypeID = _loc6_.@EctypeID;
            _loc4_.MaxGate = _loc6_.@MaxGate;
            _loc4_.MaxUser = _loc6_.@MaxUser;
            _loc4_.UserTeam = _loc6_.@UserTeam;
            _loc4_.UserShip = _loc6_.@UserShip;
            _loc4_.Count = _loc6_.@Count;
            _loc4_.Exp = _loc6_.@Exp;
            _loc4_.Treasure = _loc6_.@Treasure;
            _loc4_.TreNumber = _loc6_.@Number;
            _loc4_.Comment = _loc6_.@Comment;
            _loc4_.Comment2 = _loc6_.@Comment2;
            _loc4_.Needed = _loc6_.@NeedID;
            this._dataList.Put(_loc4_.ID,_loc4_);
         }
         _loc1_ = ResManager.getInstance().getXml(ResManager.GAMERES,"InstanceChallenge");
         for each(_loc6_ in _loc1_.*)
         {
            _loc4_ = new FBModel();
            _loc4_.McName = _loc1_.@MC;
            _loc4_.LineColor = _loc1_.@LineColor;
            _loc4_.ID = _loc6_.@ID;
            _loc4_.PosX = _loc6_.@X;
            _loc4_.PosY = _loc6_.@Y;
            _loc4_.Name = _loc6_.@Name;
            _loc4_.Repeat = _loc6_.@Repeat;
            _loc4_.Type = _loc6_.@Type;
            _loc4_.EctypeID = _loc6_.@EctypeID;
            _loc4_.MaxGate = _loc6_.@MaxGate;
            _loc4_.MaxUser = _loc6_.@MaxUser;
            _loc4_.UserTeam = _loc6_.@UserTeam;
            _loc4_.UserShip = _loc6_.@UserShip;
            _loc4_.Count = _loc6_.@Count;
            _loc4_.Exp = _loc6_.@Exp;
            _loc4_.Treasure = _loc6_.@Treasure;
            _loc4_.TreNumber = _loc6_.@Number;
            if(parseInt(_loc6_.@Treasure2) > 0)
            {
               _loc4_.Treasure2 = _loc6_.@Treasure2;
            }
            _loc4_.Comment = _loc6_.@Comment;
            _loc4_.Comment2 = _loc6_.@Comment2;
            _loc4_.Needed = _loc6_.@NeedID;
            _loc4_.ModelType = 1;
            this._challengeDataList.Put(_loc4_.ID,_loc4_);
         }
         _loc1_ = null;
      }
      
      public function requestStartFB(param1:Array) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:GShipTeam = null;
         var _loc2_:MSG_REQUEST_ECTYPE = new MSG_REQUEST_ECTYPE();
         _loc2_.EctypeId = this.curSelectFB.EctypeID;
         _loc2_.GateId = this.curGateId;
         _loc2_.Guid = GamePlayer.getInstance().Guid;
         _loc2_.SeqId = GamePlayer.getInstance().seqID++;
         if(param1)
         {
            _loc3_ = int(param1.length);
         }
         else
         {
            _loc3_ = 0;
         }
         _loc3_ = _loc3_ > MsgTypes.MAX_USERSHIPTEAMNUM ? MsgTypes.MAX_USERSHIPTEAMNUM : _loc3_;
         var _loc6_:int = 0;
         while(_loc6_ < _loc3_)
         {
            _loc4_ = int(param1[_loc6_][0]);
            _loc5_ = GalaxyShipManager.instance.getShipDatas(_loc4_);
            _loc2_.ShipTeamId[_loc6_] = _loc4_;
            _loc6_++;
         }
         _loc2_.DataLen = _loc3_;
         NetManager.Instance().sendObject(_loc2_);
         if(this.curSelectFB.EctypeID != 1000)
         {
            InstanceManager.instance.instanceStatus = InstanceManager.FB_FIGHT;
         }
      }
      
      public function checkShipGas() : Boolean
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MSG_RESP_JUMPGALAXYSHIP_TEMP = null;
         var _loc5_:String = null;
         var _loc6_:DisplayObjectContainer = null;
         _loc1_ = int(InstanceUI.instance.selfFBTeamsArr.length);
         _loc1_ = _loc1_ > MsgTypes.MAX_USERSHIPTEAMNUM ? MsgTypes.MAX_USERSHIPTEAMNUM : _loc1_;
         var _loc4_:int = 0;
         while(_loc4_ < _loc1_)
         {
            _loc2_ = int(InstanceUI.instance.selfFBTeamsArr[_loc4_][0]);
            _loc3_ = InstanceUI.instance.selfFBTeamsArr[_loc4_][1];
            if(_loc3_.Gas <= 0)
            {
               return false;
            }
            _loc4_++;
         }
         return true;
      }
      
      public function InitResultButtons() : void
      {
         FightResultUI.instance.InitFBButtons();
      }
      
      public function getFBModelByEctype(param1:int) : FBModel
      {
         var _loc2_:int = 0;
         while(_loc2_ < this.dataList.Values().length)
         {
            if((this.dataList.Values()[_loc2_] as FBModel).EctypeID == param1)
            {
               return this.dataList.Values()[_loc2_] as FBModel;
            }
            _loc2_++;
         }
         return null;
      }
      
      public function requestNextFB() : void
      {
         var _loc1_:MSG_REQUEST_ECTYPE = new MSG_REQUEST_ECTYPE();
         _loc1_.EctypeId = this._curEctype;
         if(this.getFBModelByEctype(this._curEctype).MaxGate > InstanceManager.instance.curGateId + 1)
         {
            this._curGateId += 1;
         }
         else
         {
            this._curGateId = this.getFBModelByEctype(this._curEctype).MaxGate;
         }
         _loc1_.GateId = this._curGateId;
         _loc1_.Guid = GamePlayer.getInstance().Guid;
         _loc1_.SeqId = GamePlayer.getInstance().seqID++;
         NetManager.Instance().sendObject(_loc1_);
      }
      
      public function request_MSG_REQUEST_ECTYPEINFO(param1:int) : void
      {
         if(param1 == 1 || param1 == 3)
         {
            InstanceManager.instance.instanceStatus = InstanceManager.FB_FIGHT;
         }
         else
         {
            InstanceManager.instance.instanceStatus = InstanceManager.FB_OUT;
         }
         var _loc2_:MSG_REQUEST_ECTYPEINFO = new MSG_REQUEST_ECTYPEINFO();
         _loc2_.EctypeId = this._curEctype;
         _loc2_.Request = param1;
         _loc2_.SeqId = GamePlayer.getInstance().seqID++;
         _loc2_.Guid = GamePlayer.getInstance().Guid;
         NetManager.Instance().sendObject(_loc2_);
      }
      
      public function respone_MSG_RESP_ECTYPESTATE(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc6_:Boolean = false;
         var _loc7_:Boolean = false;
         var _loc4_:MSG_RESP_ECTYPESTATE = new MSG_RESP_ECTYPESTATE();
         NetManager.Instance().readObject(_loc4_,param3);
         this._curStatus = _loc4_.state;
         this._curEctype = _loc4_.EctypeId;
         this._curGateId = _loc4_.GateId;
         if(this._curEctype == 1000 || this._curEctype == 1001)
         {
            this.curSelectFB = new FBModel();
            this.curSelectFB.EctypeID = this._curEctype;
            if(this._curEctype == 1001 && this._curStatus == 1)
            {
               InstanceMenuUI.instance.show();
            }
            else
            {
               InstanceMenuUI.instance.hiden();
            }
         }
         else
         {
            InstanceMenuUI.instance.show();
         }
         WrestleUI.getInstance().RestStatus();
         var _loc5_:String = "";
         switch(this._curStatus)
         {
            case 0:
               GalaxyMatchUI.instance.addShipBtnEnable(false);
               _loc5_ = StringManager.getInstance().getMessageString("BattleTXT19");
               GalaxyMatchUI.instance.updateStartBtn(_loc5_,false);
               this._curGateId = 0;
               if(!GalaxyManager.instance.isMineHome())
               {
                  break;
               }
               if(WrestleUI.getInstance().WatchStatus == 1)
               {
                  InstanceMenuUI.instance.hiden();
                  break;
               }
               ConstructionAction.getInstance().forceOnConstructionModuel();
               FightManager.instance.CleanFight();
               InstanceMenuUI.instance.hiden();
               GalaxyManager.instance.sendRequestGalaxy();
               this.instanceStatus = 0;
               break;
            case 1:
               GalaxyMatchUI.instance.addShipBtnEnable(true);
               _loc5_ = StringManager.getInstance().getMessageString("BattleTXT21");
               _loc6_ = this._curEctype == 1000 ? false : true;
               GalaxyMatchUI.instance.updateStartBtn(_loc5_,_loc6_);
               InstanceManager.instance.instanceStatus = InstanceManager.FB_FIGHT;
               GalaxyMatchUI.instance.Release();
               FightManager.instance.CleanFight();
               break;
            case 2:
               if(WrestleUI.getInstance().WatchStatus == 1)
               {
                  InstanceMenuUI.instance.hiden();
                  break;
               }
               GalaxyMatchUI.instance.addShipBtnEnable(true);
               _loc5_ = StringManager.getInstance().getMessageString("BattleTXT21");
               _loc7_ = this._curEctype == 1000 ? false : true;
               GalaxyMatchUI.instance.updateStartBtn(_loc5_,_loc7_);
               FightResultUI.instance.InitFBButtons();
               InstanceMenuUI.instance.hiden();
               FightManager.instance.CleanFight();
               this.RequestGalaxy();
               break;
            case 3:
               GalaxyMatchUI.instance.addShipBtnEnable(true);
               _loc5_ = StringManager.getInstance().getMessageString("BattleTXT26");
               GalaxyMatchUI.instance.updateStartBtn(_loc5_,true);
               break;
            case 4:
               GalaxyMatchUI.instance.addShipBtnEnable(true);
               _loc5_ = StringManager.getInstance().getMessageString("BattleTXT20");
               GalaxyMatchUI.instance.updateStartBtn(_loc5_,false);
         }
      }
      
      private function RequestGalaxy() : void
      {
         if(this.bRequestGalaxy)
         {
            this.bRequestGalaxy = false;
            InstanceMenuUI.instance.hiden();
            InstanceManager.instance.curStatus = InstanceManager.FB_OUT;
            GalaxyManager.instance.sendRequestGalaxy();
         }
      }
      
      public function response_MSG_RESP_ECTYPEPASS(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc6_:int = 0;
         this._passedFB.splice(0);
         var _loc4_:MSG_RESP_ECTYPEPASS = new MSG_RESP_ECTYPEPASS();
         NetManager.Instance().readObject(_loc4_,param3);
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_.DataLen)
         {
            _loc6_ = int(_loc4_.Data[_loc5_]);
            this._passedFB.push(_loc6_);
            _loc5_++;
         }
      }
      
      public function drawPassLine() : void
      {
         var _loc1_:int = 0;
         var _loc3_:FBModelView = null;
         var _loc2_:int = -1;
         var _loc4_:int = 0;
         while(_loc4_ < this._passedFB.length)
         {
            _loc1_ = int(this._passedFB[_loc4_]);
            _loc3_ = this._dataViewList.Get(_loc1_) as FBModelView;
            _loc3_.pass = true;
            _loc2_ = _loc1_ > _loc2_ ? _loc1_ : _loc2_;
            _loc3_ = this._dataViewList.Get(_loc2_ + 1) as FBModelView;
            if(_loc3_)
            {
               _loc3_.isNew = true;
            }
            _loc4_++;
         }
      }
      
      public function quitInstance() : void
      {
         InstanceMenuUI.instance.hiden();
         MusicResHandler.PlayGameMusic(MusicResHandler.GALAXY_MUSIC);
         if(InstanceManager.instance.instanceStatus == InstanceManager.FB_FIGHT)
         {
            InstanceManager.instance.request_MSG_REQUEST_ECTYPEINFO(2);
            InstanceManager.instance.instanceStatus = InstanceManager.FB_OUT;
            this.bRequestGalaxy = true;
         }
         else if(WrestleUI.getInstance().WatchStatus == 1)
         {
            WrestleUI.getInstance().RequestLeave();
         }
      }
      
      public function quitToFaceBookFriend() : void
      {
         if(InstanceManager.instance.instanceStatus == InstanceManager.FB_FIGHT)
         {
            InstanceManager.instance.request_MSG_REQUEST_ECTYPEINFO(2);
            InstanceManager.instance.instanceStatus = InstanceManager.FB_OUT;
            InstanceManager.instance.curStatus = InstanceManager.FB_OUT;
            InstanceMenuUI.instance.hiden();
            this.bRequestGalaxy = false;
         }
         else if(WrestleUI.getInstance().WatchStatus == 1)
         {
            WrestleUI.getInstance().RequestLeave();
         }
      }
      
      public function exitInstance() : void
      {
         if(!GalaxyManager.instance.isMineHome())
         {
            return;
         }
         InstanceMenuUI.instance.hiden();
         InstanceManager.instance.curGateId = 0;
         InstanceManager.instance.curStatus = 0;
         InstanceUI.instance.releaseModel();
         InstanceManager.instance.request_MSG_REQUEST_ECTYPEINFO(0);
         InstanceManager.instance.instanceStatus = InstanceManager.FB_OUT;
         MusicResHandler.PlayGameMusic();
      }
      
      public function setFBSelectedFalse() : void
      {
         var _loc1_:FBModelView = null;
         var _loc2_:int = 0;
         while(_loc2_ < this._dataViewList.Length())
         {
            if(this._dataViewList.Values()[_loc2_] is FBModelView)
            {
               _loc1_ = this._dataViewList.Values()[_loc2_] as FBModelView;
               _loc1_.selected = false;
            }
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < this._challengeDataViewList.Length())
         {
            if(this._challengeDataViewList.Values()[_loc2_] is FBModelView)
            {
               _loc1_ = this._challengeDataViewList.Values()[_loc2_] as FBModelView;
               _loc1_.selected = false;
            }
            _loc2_++;
         }
      }
      
      public function clearFBNew() : void
      {
         var _loc1_:FBModelView = null;
         var _loc2_:int = 0;
         while(_loc2_ < this._dataViewList.Length())
         {
            if(this._dataViewList.Values()[_loc2_] is FBModelView)
            {
               _loc1_ = this._dataViewList.Values()[_loc2_] as FBModelView;
               _loc1_.isNew = false;
            }
            _loc2_++;
         }
      }
      
      public function AddViewToPanel() : void
      {
         var _loc2_:FBModelView = null;
         var _loc1_:int = 0;
         while(_loc1_ < this._dataViewList.Length())
         {
            _loc2_ = this._dataViewList.Values()[_loc1_] as FBModelView;
            _loc2_.Init();
            _loc1_++;
         }
      }
      
      private function RemoveViewFromPanel() : void
      {
         var _loc2_:FBModelView = null;
         var _loc1_:int = 0;
         while(_loc1_ < this._dataViewList.Length())
         {
            _loc2_ = this._dataViewList.Values()[_loc1_] as FBModelView;
            _loc2_.Release();
            _loc1_++;
         }
      }
      
      public function AddCallengeViewToPanel() : void
      {
         var _loc2_:FBModelView = null;
         var _loc1_:int = 0;
         while(_loc1_ < this._challengeDataViewList.Length())
         {
            _loc2_ = this._challengeDataViewList.Values()[_loc1_] as FBModelView;
            _loc2_.Init();
            _loc1_++;
         }
      }
      
      public function RemoveCallengeViewFromPanel() : void
      {
         var _loc2_:FBModelView = null;
         var _loc1_:int = 0;
         while(_loc1_ < this._challengeDataViewList.Length())
         {
            _loc2_ = this._challengeDataViewList.Values()[_loc1_] as FBModelView;
            _loc2_.Release();
            _loc1_++;
         }
      }
      
      public function UpdateViewPanel(param1:String, param2:String) : void
      {
         switch(param2)
         {
            case "btn_ordinary":
               this.RemoveViewFromPanel();
               break;
            case "btn_copy2":
               this.RemoveCallengeViewFromPanel();
               break;
            case "btn_copy3":
            case "btn_copy4":
         }
         switch(param1)
         {
            case "btn_ordinary":
               this.AddViewToPanel();
               break;
            case "btn_copy2":
               this.AddCallengeViewToPanel();
               break;
            case "btn_copy3":
            case "btn_copy4":
         }
      }
      
      public function get dataList() : HashSet
      {
         return this._dataList;
      }
      
      public function getDataView(param1:String) : HashSet
      {
         return this._dataViewList.Get(param1);
      }
      
      public function pushViewData(param1:*, param2:*) : void
      {
         this._dataViewList.Put(param1,param2);
      }
      
      public function get challengeDataList() : HashSet
      {
         return this._challengeDataList;
      }
      
      public function getCallengeDataView(param1:String) : HashSet
      {
         return this._challengeDataViewList.Get(param1);
      }
      
      public function pushCallengeDataView(param1:*, param2:*) : void
      {
         this._challengeDataViewList.Put(param1,param2);
      }
      
      public function get curEctype() : int
      {
         return this._curEctype;
      }
      
      public function set curEctype(param1:int) : void
      {
         this._curEctype = param1;
      }
      
      public function get curGateId() : int
      {
         return this._curGateId;
      }
      
      public function set curGateId(param1:int) : void
      {
         this._curGateId = param1;
      }
      
      public function get curStatus() : int
      {
         return this._curStatus;
      }
      
      public function set curStatus(param1:int) : void
      {
         this._curStatus = param1;
      }
      
      public function get passedFB() : Array
      {
         return this._passedFB;
      }
      
      public function getLastInstanceID() : int
      {
         var _loc2_:FBModel = null;
         var _loc1_:int = 1;
         for each(_loc2_ in this._passedFB)
         {
            if(_loc2_.ID > _loc1_)
            {
               _loc1_ = _loc2_.ID;
            }
         }
         return _loc1_;
      }
      
      public function checkNeeded(param1:FBModel) : Boolean
      {
         var _loc4_:int = 0;
         if(param1.Needed == -1)
         {
            return true;
         }
         var _loc2_:Array = new Array();
         var _loc3_:int = 0;
         while(_loc3_ < this.passedFB.length)
         {
            _loc4_ = int(this.passedFB[_loc3_]);
            if(_loc4_ == param1.Needed)
            {
               return true;
            }
            _loc3_++;
         }
         return false;
      }
      
      public function get instanceStatus() : int
      {
         return this._instanceStatus;
      }
      
      public function set instanceStatus(param1:int) : void
      {
         this._instanceStatus = param1;
      }
      
      public function get curSelectFB() : FBModel
      {
         return this._curSelectFB;
      }
      
      public function set curSelectFB(param1:FBModel) : void
      {
         this._curSelectFB = param1;
      }
      
      public function Resp_MSG_RESP_ARENA_STATUS(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_ARENA_STATUS = new MSG_RESP_ARENA_STATUS();
         NetManager.Instance().readObject(_loc4_,param3);
         WrestleUI.getInstance().Resp_MSG_RESP_ARENA_STATUS(_loc4_);
      }
      
      public function Resp_MSG_RESP_ARENA_PAGE(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_ARENA_PAGE = new MSG_RESP_ARENA_PAGE();
         NetManager.Instance().readObject(_loc4_,param3);
         WrestleUI.getInstance().RespRoomList(_loc4_);
      }
   }
}

class HHH
{
   
   public function HHH()
   {
      super();
   }
}
