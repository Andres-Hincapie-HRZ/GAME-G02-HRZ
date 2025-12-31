package net.router
{
   import com.star.frameworks.managers.StringManager;
   import com.star.frameworks.utils.MusicResHandler;
   import flash.external.ExternalInterface;
   import flash.utils.ByteArray;
   import logic.action.ChatAction;
   import logic.action.ConstructionAction;
   import logic.action.OutSideGalaxiasAction;
   import logic.entry.ConstructionState;
   import logic.entry.Equiment;
   import logic.entry.GShip;
   import logic.entry.GShipTeam;
   import logic.entry.GStar;
   import logic.entry.GalaxyType;
   import logic.entry.GamePlayer;
   import logic.entry.ScienceSystem;
   import logic.game.GameKernel;
   import logic.game.GameMouseZoneManager;
   import logic.manager.FightSectionManager;
   import logic.manager.GalaxyManager;
   import logic.manager.GalaxyShipManager;
   import logic.manager.HoldGalaxyManager;
   import logic.manager.ProgressToolBarManager;
   import logic.ui.ChatUI;
   import logic.ui.FightResultUI;
   import logic.ui.FleetInfoUI_Router;
   import logic.ui.GemcheckPopUI;
   import logic.ui.MailUI_Detail;
   import logic.ui.MessagePopup;
   import logic.ui.MyCorpsUI_Defense;
   import logic.ui.MyCorpsUI_Garrison;
   import logic.ui.ShipInfoUI;
   import logic.ui.ShipTransferUI;
   import logic.ui.TransforingUI;
   import logic.ui.tip.StarInfoTip;
   import net.base.NetManager;
   import net.common.MsgTypes;
   import net.msg.MSG_RESP_PASS_TOLLGATE;
   import net.msg.fightMsg.MSG_FIGHTGALAXYBEGIN;
   import net.msg.fightMsg.MSG_FIGHTGALAXYOVER;
   import net.msg.fightMsg.MSG_RESP_FIGHTBOUTBEG;
   import net.msg.fightMsg.MSG_RESP_FIGHTINIT_BUILD;
   import net.msg.fightMsg.MSG_RESP_FIGHTINIT_BUILD_TEMP;
   import net.msg.fightMsg.MSG_RESP_FIGHTINIT_SHIPTEAM;
   import net.msg.fightMsg.MSG_RESP_FIGHTINIT_SHIPTEAM_TEMP;
   import net.msg.fightMsg.MSG_RESP_FIGHTRESULT;
   import net.msg.fightMsg.MSG_RESP_FIGHTSECTION;
   import net.msg.fightMsg.MSG_RESP_FORTRESSSECTION;
   import net.msg.fleetMsg.MSG_SHIPTEAM_BODY;
   import net.msg.galaxyMap.MSG_RESP_GALAXYINFO;
   import net.msg.galaxyMap.MSG_RESP_INSERTFLAGBRO;
   import net.msg.galaxyMap.MSG_RESP_MAPAREA;
   import net.msg.galaxyMap.MSG_RESP_MAPAREA_TMP;
   import net.msg.galaxyMap.MSG_RESP_MOVEHOME;
   import net.msg.galaxyMap.MSG_RESP_MOVEHOMEBRO;
   import net.msg.ship.MSG_RESP_CANCELJUMPSHIPTEAM;
   import net.msg.ship.MSG_RESP_CREATESHIPTEAM;
   import net.msg.ship.MSG_RESP_DELSHIPTEAMBROADCAST;
   import net.msg.ship.MSG_RESP_DIRECTIONSHIPTEAM;
   import net.msg.ship.MSG_RESP_GALAXYSHIP;
   import net.msg.ship.MSG_RESP_GALAXYSHIP_TEMP;
   import net.msg.ship.MSG_RESP_JUMPGALAXYSHIP;
   import net.msg.ship.MSG_RESP_JUMPGALAXYSHIP_TEMP;
   import net.msg.ship.MSG_RESP_JUMPSHIPTEAM;
   import net.msg.ship.MSG_RESP_JUMPSHIPTEAMCOMPLETE;
   import net.msg.ship.MSG_RESP_JUMPSHIPTEAMINFO;
   import net.msg.ship.MSG_RESP_JUMPSHIPTEAMINFO_TEMP;
   import net.msg.ship.MSG_RESP_MOVESHIPTEAM;
   import net.msg.ship.MSG_RESP_SHIPTEAMINFO;
   import net.msg.ship.MSG_RESP_VIEWJUMPSHIPTEAM;
   import net.msg.ship.MSG_SHIPTEAMHOLDGALAXY;
   
   public class MapRouter
   {
      
      private static var _instance:MapRouter = null;
      
      public var MSG_RESP_VIEWJUMPSHIPTEAM_SrcType:int;
      
      public function MapRouter(param1:Singleton)
      {
         super();
      }
      
      public static function get instance() : MapRouter
      {
         if(_instance == null)
         {
            _instance = new MapRouter(new Singleton());
         }
         return _instance;
      }
      
      public function resp_MSG_RESP_MAPAREA(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc6_:MSG_RESP_MAPAREA_TMP = null;
         var _loc7_:GStar = null;
         var _loc4_:MSG_RESP_MAPAREA = new MSG_RESP_MAPAREA();
         NetManager.Instance().readObject(_loc4_,param3);
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_.DataLen)
         {
            _loc6_ = _loc4_.Data[_loc5_] as MSG_RESP_MAPAREA_TMP;
            _loc7_ = new GStar();
            _loc7_.GalaxyMapId = _loc4_.GalaxyMapId;
            _loc7_.RegionId = _loc4_.RegionId;
            _loc7_.GalaxyId = _loc6_.GalaxyId;
            _loc7_.ConsortiaHeadId = _loc6_.ConsortiaHeadId;
            _loc7_.ConsortiaLevelId = _loc6_.ConsortiaLevelId;
            _loc7_.Type = _loc6_.Type;
            _loc7_.Camp = _loc6_.Camp;
            _loc7_.Level = _loc6_.SpaceLevelId;
            _loc7_.FightFlag = _loc6_.FightFlag;
            _loc7_.LoserFlag = _loc6_.InsertFlagStatus;
            _loc7_.StarFace = _loc6_.StarFace;
            _loc7_.ConsortiaName = _loc6_.ConsortiaName;
            _loc7_.UserName = _loc6_.UserName;
            _loc7_.UserId = _loc6_.UserId;
            GalaxyManager.instance.pushData(_loc7_);
            GalaxyManager.instance.RefreshStarInfo(_loc7_.GalaxyId);
            _loc5_++;
         }
      }
      
      public function resp_MSG_RESP_INSERTFLAGBRO(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc5_:GStar = null;
         var _loc4_:MSG_RESP_INSERTFLAGBRO = new MSG_RESP_INSERTFLAGBRO();
         NetManager.Instance().readObject(_loc4_,param3);
         _loc5_ = GalaxyManager.instance.getData(_loc4_.GalaxyId);
         if(_loc5_ != null)
         {
            _loc5_.LoserFlag = _loc4_.Type;
            GalaxyManager.instance.fresh();
         }
      }
      
      public function resp_MSG_RESP_HOLDGALAXYINFO() : void
      {
         var _loc5_:int = 0;
         GalaxyManager.instance.sendRequestGalaxy();
         var _loc1_:int = GalaxyManager.getStarArea(GamePlayer.getInstance().galaxyID);
         var _loc2_:int = _loc1_ - GalaxyManager.MAX_MAPAREA - 1;
         var _loc3_:Array = new Array();
         var _loc4_:int = 0;
         while(_loc4_ < 4)
         {
            _loc5_ = 0;
            while(_loc5_ < 4)
            {
               _loc1_ = _loc2_ + _loc5_ + _loc4_ * GalaxyManager.MAX_MAPAREA;
               if(_loc1_ > -1 && _loc1_ < GalaxyManager.MAX_MAPAREAS)
               {
                  _loc3_.push(_loc1_);
               }
               _loc5_++;
            }
            _loc4_++;
         }
         GalaxyManager.RequestMapsDatas(_loc3_);
      }
      
      public function resp_MSG_RESP_GALAXYSHIP(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc6_:MSG_RESP_GALAXYSHIP_TEMP = null;
         var _loc7_:GShipTeam = null;
         var _loc4_:MSG_RESP_GALAXYSHIP = new MSG_RESP_GALAXYSHIP();
         NetManager.Instance().readObject(_loc4_,param3);
         ExternalInterface.call("console.log","[#] GSHIP dataLen => " + _loc4_.DataLen);
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_.DataLen)
         {
            _loc6_ = _loc4_.Data[_loc5_];
            _loc7_ = new GShipTeam();
            _loc7_.GalaxyMapId = _loc4_.GalaxyMapId;
            _loc7_.GalaxyId = _loc4_.GalaxyId;
            _loc7_.ShipTeamId = _loc6_.ShipTeamId;
            _loc7_.ShipNum = _loc6_.ShipNum;
            _loc7_.BodyId = _loc6_.BodyId;
            _loc7_.Reserve = _loc6_.Reserve;
            _loc7_.Direction = _loc6_.Direction;
            _loc7_.PosX = _loc6_.PosX;
            _loc7_.PosY = _loc6_.PosY;
            _loc7_.Owner = _loc6_.Owner;
            GalaxyShipManager.instance.renderOneShipTeam(_loc7_);
            _loc5_++;
         }
      }
      
      public function resp_MSG_RESP_MOVESHIPTEAM(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc5_:GShipTeam = null;
         var _loc4_:MSG_RESP_MOVESHIPTEAM = new MSG_RESP_MOVESHIPTEAM();
         NetManager.Instance().readObject(_loc4_,param3);
         _loc5_ = GalaxyShipManager.instance.getShipDatas(_loc4_.ShipTeamId);
         if(_loc5_)
         {
            _loc5_._isMove = true;
            _loc5_.shipMove(_loc4_.PosX,_loc4_.PosY);
         }
      }
      
      public function resp_MSG_RESP_DIRECTIONSHIPTEAM(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc5_:GShipTeam = null;
         var _loc4_:MSG_RESP_DIRECTIONSHIPTEAM = new MSG_RESP_DIRECTIONSHIPTEAM();
         NetManager.Instance().readObject(_loc4_,param3);
         if(GalaxyShipManager.instance.getShipDatas(_loc4_.ShipTeamId))
         {
            _loc5_ = GalaxyShipManager.instance.getShipDatas(_loc4_.ShipTeamId);
            _loc5_.changeDirection(_loc4_.Direction);
         }
      }
      
      public function resp_MSG_RESP_CREATESHIPTEAM(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc6_:GShipTeam = null;
         var _loc4_:MSG_RESP_CREATESHIPTEAM = new MSG_RESP_CREATESHIPTEAM();
         NetManager.Instance().readObject(_loc4_,param3);
         var _loc5_:MSG_RESP_GALAXYSHIP_TEMP = _loc4_.Data;
         _loc6_ = new GShipTeam();
         _loc6_.GalaxyMapId = _loc4_.GalaxyMapId;
         _loc6_.GalaxyId = _loc4_.GalaxyId;
         _loc6_.ShipTeamId = _loc5_.ShipTeamId;
         _loc6_.ShipNum = _loc5_.ShipNum;
         _loc6_.BodyId = _loc5_.BodyId;
         _loc6_.Reserve = _loc5_.Reserve;
         _loc6_.Direction = _loc5_.Direction;
         _loc6_.PosX = _loc5_.PosX;
         _loc6_.PosY = _loc5_.PosY;
         _loc6_.Owner = _loc5_.Owner;
         GalaxyShipManager.instance.renderOneShipTeam(_loc6_);
      }
      
      public function resp_MSG_RESP_DELSHIPTEAMBROADCAST(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_DELSHIPTEAMBROADCAST = new MSG_RESP_DELSHIPTEAMBROADCAST();
         NetManager.Instance().readObject(_loc4_,param3);
         CommanderRouter.instance.deleteShipTeam(_loc4_.ShipTeamId);
         GalaxyShipManager.instance.deleteOneShipTeam(_loc4_.ShipTeamId);
      }
      
      public function resp_MSG_RESP_SHIPTEAMINFO(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc5_:GShipTeam = null;
         var _loc7_:MSG_SHIPTEAM_BODY = null;
         var _loc8_:GShip = null;
         var _loc4_:MSG_RESP_SHIPTEAMINFO = new MSG_RESP_SHIPTEAMINFO();
         NetManager.Instance().readObject(_loc4_,param3);
         _loc5_ = GalaxyShipManager.instance.getShipDatas(_loc4_.ShipTeamId);
         _loc5_.UserId = _loc4_.UserId > 0 ? Number(_loc4_.UserId) : Number(0);
         _loc5_.Gas = _loc4_.Gas;
         _loc5_.CommanderID = _loc4_.CommanderId;
         _loc5_.TeamName = _loc4_.TeamName;
         _loc5_.Commander = _loc4_.Commander;
         _loc5_.TeamOwner = _loc4_.TeamOwner;
         _loc5_.Consortia = _loc4_.Consortia;
         _loc5_.CardLevel = _loc4_.CardLevel;
         var _loc6_:int = 0;
         while(_loc6_ < MsgTypes.MAX_SHIPTEAMBODY)
         {
            _loc7_ = _loc4_.TeamBody[_loc6_];
            if(_loc5_.TeamBody[_loc6_] != null)
            {
               _loc8_ = _loc5_.TeamBody[_loc6_] as GShip;
               _loc8_.ShipModelId = _loc7_.ShipModelId;
               _loc8_.BodyId = _loc7_.BodyId;
               _loc8_.Num = _loc7_.Num;
               if(_loc7_.Num == 0)
               {
                  _loc4_.TeamBody[_loc6_] = null;
               }
            }
            _loc6_++;
         }
         _loc5_.CommanderHeadId = _loc4_.SkillId;
         _loc5_.AttackObjInterval = _loc4_.AttackObjInterval;
         _loc5_.AttackObjType = _loc4_.AttackObjType;
         _loc5_.LevelId = _loc4_.LevelId;
         ShipInfoUI.instance.ShowCommander(_loc5_);
         FleetInfoUI_Router.Show(_loc5_.ShipTeamId);
      }
      
      public function resp_MSG_RESP_JUMPGALAXYSHIP(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc5_:int = 0;
         var _loc6_:MSG_RESP_JUMPGALAXYSHIP_TEMP = null;
         var _loc4_:MSG_RESP_JUMPGALAXYSHIP = new MSG_RESP_JUMPGALAXYSHIP();
         NetManager.Instance().readObject(_loc4_,param3);
         if(_loc4_.Type == 0)
         {
            _loc5_ = 0;
            while(_loc5_ < _loc4_.DataLen)
            {
               _loc6_ = _loc4_.Data[_loc5_];
               _loc5_++;
            }
            ShipTransferUI.instance.InitData(_loc4_);
            ShipTransferUI.instance.OpenST();
         }
         else if(_loc4_.Type == 1)
         {
            MyCorpsUI_Garrison.getInstance().ResqFleetList(_loc4_);
         }
         else if(_loc4_.Type == 2)
         {
            ShipTransferUI.instance.InitData2(_loc4_);
            ShipTransferUI.instance.OpenFB();
         }
         else
         {
            ShipTransferUI.instance.InitData2(_loc4_);
            ShipTransferUI.instance.OpenGM();
         }
      }
      
      public function resp_MSG_RESP_JUMPSHIPTEAM(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_JUMPSHIPTEAM = new MSG_RESP_JUMPSHIPTEAM();
         NetManager.Instance().readObject(_loc4_,param3);
         var _loc5_:MSG_RESP_JUMPSHIPTEAMINFO_TEMP = _loc4_.Data as MSG_RESP_JUMPSHIPTEAMINFO_TEMP;
         TransforingUI.instance.pushData(_loc5_);
      }
      
      public function resp_MSG_RESP_JUMPSHIPTEAMINFO(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_JUMPSHIPTEAMINFO = new MSG_RESP_JUMPSHIPTEAMINFO();
         NetManager.Instance().readObject(_loc4_,param3);
         TransforingUI.instance.RespJumpInfo(_loc4_);
      }
      
      public function resp_MSG_RESP_JUMPSHIPTEAMCOMPLETE(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_JUMPSHIPTEAMCOMPLETE = new MSG_RESP_JUMPSHIPTEAMCOMPLETE();
         NetManager.Instance().readObject(_loc4_,param3);
      }
      
      public function resp_MSG_RESP_FIGHTINIT_SHIPTEAM(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc6_:MSG_RESP_FIGHTINIT_SHIPTEAM_TEMP = null;
         var _loc7_:GShipTeam = null;
         var _loc8_:int = 0;
         var _loc9_:GShip = null;
         var _loc10_:MSG_SHIPTEAM_BODY = null;
         var _loc4_:MSG_RESP_FIGHTINIT_SHIPTEAM = new MSG_RESP_FIGHTINIT_SHIPTEAM();
         NetManager.Instance().readObject(_loc4_,param3);
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_.DataLen)
         {
            _loc6_ = _loc4_.Data[_loc5_] as MSG_RESP_FIGHTINIT_SHIPTEAM_TEMP;
            if(GalaxyShipManager.instance.getShipDatas(_loc6_.ShipTeamId))
            {
               _loc7_ = GalaxyShipManager.instance.getShipDatas(_loc6_.ShipTeamId) as GShipTeam;
               _loc7_.TeamName = _loc6_.TeamName;
               _loc7_.Commander = _loc6_.Commander;
               _loc7_.TeamOwner = _loc6_.TeamOwner;
               _loc7_.Consortia = _loc6_.Consortia;
               _loc7_.UserId = _loc6_.UserId > 0 ? Number(_loc6_.UserId) : Number(0);
               _loc7_.Gas = _loc6_.Gas;
               _loc7_.Storage = _loc6_.Storage;
               _loc7_.CardLevel = _loc6_.CardLevel;
               _loc7_.CommanderHeadId = _loc6_.SkillId;
               _loc8_ = 0;
               while(_loc8_ < MsgTypes.MAX_SHIPTEAMBODY)
               {
                  if(_loc7_.TeamBody[_loc8_] && (_loc6_.TeamBody[_loc8_] as MSG_SHIPTEAM_BODY).Num > 0)
                  {
                     _loc9_ = _loc7_.TeamBody[_loc8_] as GShip;
                     _loc9_.Endure = _loc6_.Endure[_loc8_];
                     _loc9_.MaxEndure = _loc6_.MaxEndure[_loc8_];
                     _loc9_.Shield = _loc6_.Shield[_loc8_];
                     _loc9_.MaxShield = _loc6_.MaxShield[_loc8_];
                     _loc10_ = _loc6_.TeamBody[_loc8_] as MSG_SHIPTEAM_BODY;
                     _loc9_.ShipModelId = _loc10_.ShipModelId;
                     _loc9_.BodyId = _loc10_.BodyId;
                     _loc9_.Num = _loc10_.Num;
                  }
                  _loc8_++;
               }
               _loc7_.AttackObjInterval = _loc6_.AttackObjInterval;
               _loc7_.AttackObjType = _loc6_.AttackObjType;
               _loc7_.LevelId = _loc6_.LevelId;
               ChatUI.getInstance().setSpecialTipState(false);
               GameKernel.renderManager.getUI().removeComponent(GemcheckPopUI.getInstance()._mc);
            }
            _loc5_++;
         }
         MusicResHandler.PlayGameMusic(MusicResHandler.BATTLE_MUSIC);
      }
      
      public function resp_MSG_RESP_FIGHTBOUTBEG(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_FIGHTBOUTBEG = new MSG_RESP_FIGHTBOUTBEG();
         NetManager.Instance().readObject(_loc4_,param3);
         if(!OutSideGalaxiasAction.getInstance().BoutVisible)
         {
            OutSideGalaxiasAction.getInstance().BoutVisible = true;
         }
         OutSideGalaxiasAction.getInstance().setBoutText(_loc4_.BoutId);
      }
      
      public function resp_MSG_RESP_FIGHTSECTION(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_FIGHTSECTION = new MSG_RESP_FIGHTSECTION();
         NetManager.Instance().readObject(_loc4_,param3);
         if(!FightSectionManager.fightingFlag)
         {
            FightSectionManager.instance.startFight();
         }
         FightSectionManager.instance.pushMsg(_loc4_);
      }
      
      public function resp_MSG_RESP_FIGHTFORTRESSSECTION(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_FORTRESSSECTION = new MSG_RESP_FORTRESSSECTION();
         NetManager.Instance().readObject(_loc4_,param3);
         if(!FightSectionManager.fightingFlag)
         {
            FightSectionManager.instance.startFight();
         }
         FightSectionManager.instance.pushMsg(_loc4_);
      }
      
      public function resp_MSG_RESP_FIGHTRESULT(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_FIGHTRESULT = new MSG_RESP_FIGHTRESULT();
         NetManager.Instance().readObject(_loc4_,param3);
         if(_loc4_.Type == 1)
         {
            FightResultUI.instance.setFightResult(_loc4_);
            FightResultUI.instance.Init();
            MailUI_Detail.getInstance().OnShowShare(_loc4_);
            return;
         }
         if(FightSectionManager.instance.hasFight())
         {
            FightSectionManager.instance.pushMsg(_loc4_);
         }
         else
         {
            FightResultUI.instance.setFightResult(_loc4_);
            FightResultUI.instance.Init();
         }
      }
      
      public function resp_MSG_SHIPTEAMHOLDGALAXY(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_SHIPTEAMHOLDGALAXY = new MSG_SHIPTEAMHOLDGALAXY();
         NetManager.Instance().readObject(_loc4_,param3);
         HoldGalaxyManager.instance.init(_loc4_);
      }
      
      public function resp_MSG_RESP_FIGHTINIT_BUILD(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc6_:MSG_RESP_FIGHTINIT_BUILD_TEMP = null;
         var _loc7_:Equiment = null;
         if(GameKernel.isBuildModule)
         {
            ConstructionAction.getInstance().clearConstructionModule();
         }
         var _loc4_:MSG_RESP_FIGHTINIT_BUILD = new MSG_RESP_FIGHTINIT_BUILD();
         NetManager.Instance().readObject(_loc4_,param3);
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_.DataLen)
         {
            _loc6_ = _loc4_.Data[_loc5_] as MSG_RESP_FIGHTINIT_BUILD_TEMP;
            if(ConstructionAction.outSideContuctionList.Get(_loc6_.IndexId) != null)
            {
               _loc7_ = ConstructionAction.outSideContuctionList.Get(_loc6_.IndexId);
               _loc7_.EquimentInfoData.Endure = _loc6_.Endure;
               _loc7_.EquimentInfoData.MaxEndure = _loc6_.MaxEndure;
               if(_loc7_.State == ConstructionState.STATE_BUILING || _loc7_.State == ConstructionState.STATE_UPDATE)
               {
                  ProgressToolBarManager.getInstance().clearProgress(_loc7_);
               }
               _loc7_.State = ConstructionState.STATE_COMPLETE;
               ConstructionAction.getInstance().addConstruction(_loc7_);
            }
            _loc5_++;
         }
         ConstructionAction.getInstance().freshFightConstruction();
      }
      
      public function resp_MSG_RESP_GALAXYINFO(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_GALAXYINFO = new MSG_RESP_GALAXYINFO();
         NetManager.Instance().readObject(_loc4_,param3);
         StarInfoTip.GetInstance().RespStarInfo(_loc4_);
      }
      
      public function MoveHome(param1:int, param2:int, param3:Boolean = true) : void
      {
         var _loc4_:Boolean = false;
         _loc4_ = GalaxyManager.instance.isMineHome();
         if(_loc4_)
         {
            GalaxyShipManager.instance.MoveHome(param1,param2);
            ConstructionAction.MoveHome(param1,param2);
         }
         GalaxyManager.instance.MoveHome(GamePlayer.getInstance().galaxyID,param2);
         GamePlayer.getInstance().galaxyMapID = param1;
         GamePlayer.getInstance().galaxyID = param2;
         GamePlayer.getInstance().galaxyStar.GalaxyId = param2;
         if(param3)
         {
            GameMouseZoneManager.NagivateToolBarByName("mc_galaxy",true);
            GalaxyManager.instance.printCacheStar(param2 / MsgTypes.MAP_RANGE - 15,param2 % MsgTypes.MAP_RANGE - 13);
         }
         else
         {
            GalaxyManager.instance.fresh();
         }
      }
      
      public function resp_MSG_RESP_MOVEHOME(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc5_:int = 0;
         var _loc6_:String = null;
         var _loc4_:MSG_RESP_MOVEHOME = new MSG_RESP_MOVEHOME();
         NetManager.Instance().readObject(_loc4_,param3);
         if(_loc4_.ErrorCode == 0)
         {
            this.MoveHome(_loc4_.ToGalaxyMapId,_loc4_.ToGalaxyId,false);
            _loc5_ = 0;
            while(_loc5_ < ScienceSystem.getinstance().Packarr.length)
            {
               if(ScienceSystem.getinstance().Packarr[_loc5_].PropsId == _loc4_.PropsId && ScienceSystem.getinstance().Packarr[_loc5_].LockFlag == _loc4_.LockFlag)
               {
                  --ScienceSystem.getinstance().Packarr[_loc5_].PropsNum;
                  if(ScienceSystem.getinstance().Packarr[_loc5_].PropsNum <= 0)
                  {
                     ScienceSystem.getinstance().Packarr.splice(_loc5_,1);
                  }
                  break;
               }
               _loc5_++;
            }
         }
         else
         {
            _loc6_ = StringManager.getInstance().getMessageString("StarText8");
            if(_loc4_.ErrorCode == 1)
            {
               _loc6_ += StringManager.getInstance().getMessageString("StarText9");
            }
            else if(_loc4_.ErrorCode == 2)
            {
               _loc6_ += StringManager.getInstance().getMessageString("StarText10");
            }
            MessagePopup.getInstance().Show(_loc6_,1);
         }
      }
      
      public function resp_MSG_FIGHTGALAXYBEGIN(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc5_:GStar = null;
         var _loc4_:MSG_FIGHTGALAXYBEGIN = new MSG_FIGHTGALAXYBEGIN();
         NetManager.Instance().readObject(_loc4_,param3);
         ChatAction.getInstance().locationGalaxyFigthPostion(_loc4_);
         _loc5_ = GalaxyManager.instance.getData(_loc4_.GalaxyId);
         if(_loc5_)
         {
            _loc5_.FightFlag = 1;
            GalaxyManager.instance.fresh();
         }
      }
      
      public function resp_MSG_FIGHTGALAXYOVER(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc5_:GStar = null;
         var _loc4_:MSG_FIGHTGALAXYOVER = new MSG_FIGHTGALAXYOVER();
         NetManager.Instance().readObject(_loc4_,param3);
         _loc5_ = GalaxyManager.instance.getData(_loc4_.GalaxyId);
         if(_loc5_)
         {
            _loc5_.FightFlag = 0;
            if(_loc5_.Type == GalaxyType.GT_3)
            {
               _loc5_.Camp = _loc4_.ConsortiaId;
               _loc5_.ConsortiaName = _loc4_.ConsortiaName;
            }
            GalaxyManager.instance.fresh();
         }
      }
      
      public function resp_MSG_RESP_CANCELJUMPSHIPTEAM(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_CANCELJUMPSHIPTEAM = new MSG_RESP_CANCELJUMPSHIPTEAM();
         NetManager.Instance().readObject(_loc4_,param3);
         TransforingUI.instance.RespBackInfo(_loc4_);
      }
      
      public function resp_MSG_RESP_VIEWJUMPSHIPTEAM(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_VIEWJUMPSHIPTEAM = new MSG_RESP_VIEWJUMPSHIPTEAM();
         NetManager.Instance().readObject(_loc4_,param3);
         if(this.MSG_RESP_VIEWJUMPSHIPTEAM_SrcType == 0)
         {
            TransforingUI.instance.RespViewJumpShipTeam(_loc4_);
         }
         else
         {
            MyCorpsUI_Defense.getInstance().RespViewJumpShipTeam(_loc4_);
         }
      }
      
      public function resp_MSG_RESP_PASS_TOLLGATE(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_PASS_TOLLGATE = new MSG_RESP_PASS_TOLLGATE();
         NetManager.Instance().readObject(_loc4_,param3);
         GamePlayer.getInstance().TollGate = _loc4_.TollGate;
      }
      
      public function resp_MSG_RESP_MOVEHOMEBRO(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc6_:GStar = null;
         var _loc4_:MSG_RESP_MOVEHOMEBRO = new MSG_RESP_MOVEHOMEBRO();
         NetManager.Instance().readObject(_loc4_,param3);
         var _loc5_:MSG_RESP_MAPAREA_TMP = _loc4_.Data;
         if(_loc4_.DelGalaxy >= 0)
         {
            GalaxyManager.instance.miniMapDatas[_loc4_.DelGalaxy] = null;
            GalaxyManager.instance.RefreshStarInfo(_loc4_.DelGalaxy,_loc5_.UserId,_loc5_.UserName);
         }
         if(_loc5_.GalaxyId >= 0)
         {
            _loc6_ = new GStar();
            _loc6_.GalaxyMapId = MsgTypes.MAP_WORLD;
            _loc6_.RegionId = 0;
            _loc6_.GalaxyId = _loc5_.GalaxyId;
            _loc6_.ConsortiaHeadId = _loc5_.ConsortiaHeadId;
            _loc6_.ConsortiaLevelId = _loc5_.ConsortiaLevelId;
            _loc6_.Type = _loc5_.Type;
            _loc6_.Camp = _loc5_.Camp;
            _loc6_.Level = _loc5_.SpaceLevelId;
            _loc6_.FightFlag = _loc5_.FightFlag;
            _loc6_.ConsortiaName = _loc5_.ConsortiaName;
            _loc6_.UserName = _loc5_.UserName;
            _loc6_.UserId = _loc5_.UserId;
            GalaxyManager.instance.pushData(_loc6_);
            GalaxyManager.instance.RefreshStarInfo(_loc6_.GalaxyId,_loc6_.UserId,_loc6_.UserName);
         }
      }
   }
}

class Singleton
{
   
   public function Singleton()
   {
      super();
   }
}
