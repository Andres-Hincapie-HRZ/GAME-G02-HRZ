package logic.manager
{
   import com.star.frameworks.utils.HashSet;
   import com.star.frameworks.utils.MusicResHandler;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.filters.GlowFilter;
   import flash.geom.Point;
   import gs.TweenLite;
   import logic.action.BattleAction;
   import logic.action.ConstructionAction;
   import logic.action.OutSideGalaxiasAction;
   import logic.entry.EffectBlood;
   import logic.entry.Equiment;
   import logic.entry.EquimentTypeEnum;
   import logic.entry.GShip;
   import logic.entry.GShipTeam;
   import logic.entry.GameStageEnum;
   import logic.entry.shipmodel.ShippartInfo;
   import logic.game.GameFont;
   import logic.game.GameKernel;
   import logic.game.GameSetting;
   import logic.reader.CShipmodelReader;
   import logic.ui.FightResultUI;
   import logic.ui.MainUI;
   import logic.ui.tip.ShipTeamInfoTip;
   import logic.widget.BufferQueueManager;
   import logic.widget.NotifyWidget;
   import net.common.MsgTypes;
   import net.msg.fightMsg.*;
   import net.msg.ship.MSG_RESP_SHIPFIGHT;
   
   public class FightSectionManager
   {
      
      private static var _fightingFlag:Boolean = false;
      
      private static var _fightStatus:int = 1;
      
      private static var _attackStatus:int = 1;
      
      private static var frame:int = 0;
      
      private static var _moveStep:int = 0;
      
      private static var _fightStep:int = 0;
      
      public static const FIGHT_SHIP_MOVE:int = 1;
      
      public static const FIGHT_LOCK_TARGET:int = 2;
      
      public static const FIGHT_BATTLT_OPEN:int = 3;
      
      public static const FIGHT_TEAM_ATTACK:int = 4;
      
      public static const FIGHT_END:int = 5;
      
      public static const FIGHT_SHIP_BIT_BASE:int = 6;
      
      public static const FIGHT_BASE_BIT_SHIP:int = 7;
      
      public static const ATTACK_STARTUP:int = 1;
      
      public static const ATTACK_FIER:int = 2;
      
      public static const ATTACK_BEFIERED:int = 3;
      
      public static const ATTACK_STEP_4:int = 4;
      
      public static const ATTACK_STEP_5:int = 5;
      
      private static var tempArr:Array = new Array();
      
      private static const _matrix:Array = [[6,7,8,3,4,5,0,1,2],[0,3,6,1,4,7,2,5,8],[0,1,2,3,4,5,6,7,8],[8,5,2,7,4,1,6,3,0]];
      
      private static var _instance:FightSectionManager = null;
      
      private var _MsgDatas:Array = new Array();
      
      private var _srcShipTeam:GShipTeam;
      
      private var _objShipTeam:GShipTeam;
      
      private var _srcEquiment:Equiment;
      
      private var _objEquimnet:Equiment;
      
      private var _moveTempX:Number = 0;
      
      private var _moveTempY:Number = 0;
      
      private var objMatrix:Array = new Array();
      
      private var _moveEffectTarget:Boolean = false;
      
      private var len:int = 5;
      
      private var count:int = 0;
      
      private var _filter:Array = [new GlowFilter(255,1,6,6,4)];
      
      private var _filterCount:int = 0;
      
      public function FightSectionManager(param1:HHH)
      {
         super();
      }
      
      public static function get instance() : FightSectionManager
      {
         if(_instance == null)
         {
            _instance = new FightSectionManager(new HHH());
         }
         return _instance;
      }
      
      public static function get fightingFlag() : Boolean
      {
         return _fightingFlag;
      }
      
      public function debugMsgLength() : void
      {
      }
      
      private function onFight(param1:Event) : void
      {
         var msg:* = undefined;
         var Blast:Array = null;
         var lockPos:Point = null;
         var starPos:Point = null;
         var temp:MSG_RESP_SHIPFIGHT = null;
         var srcPos:Point = null;
         var bitPos:Point = null;
         var objPos:int = 0;
         var objShip:GShip = null;
         var part:ShippartInfo = null;
         var countEndure:int = 0;
         var b:int = 0;
         var basePos:Point = null;
         var temp1:MSG_RESP_SHIPFIGHT = null;
         var f:int = 0;
         var fight:MSG_RESP_FORTRESSFIGHT = null;
         var posArr:HashSet = null;
         var s:int = 0;
         var gship:GShip = null;
         var objTeamRHP:int = 0;
         var ss:int = 0;
         var shipPoint:Point = null;
         var item:Point = null;
         var sss:int = 0;
         var fight2:MSG_RESP_FORTRESSFIGHT = null;
         var bomPos:Point = null;
         var e1:Event = param1;
         if(GameKernel.currentGameStage == GameStageEnum.GAME_STAGE_GALAXY || GameKernel.currentGameStage == GameStageEnum.GAME_STAGE_STARSURFACE)
         {
            this.releaseFightSection();
            this.endFight();
            return;
         }
         if(GameLoadingManager.getInstance().LoadState == GameLoadingManager.STATE_PROGRESS)
         {
            GameLoadingManager.getInstance().ShowLoadingUI();
            return;
         }
         if(this._MsgDatas.length == 0)
         {
            return;
         }
         msg = this._MsgDatas[0];
         if(msg is MSG_RESP_FIGHTSECTION)
         {
            msg as MSG_RESP_FIGHTSECTION;
            msg = msg as MSG_RESP_FIGHTSECTION;
            this._srcShipTeam = GalaxyShipManager.instance.getShipDatas(msg.SrcShipTeamId);
            if(this._srcShipTeam == null)
            {
               return;
            }
            this._objEquimnet = null;
            this._objShipTeam = null;
            if(msg.ObjShipTeamId != -1 && msg.BothStatus == 0)
            {
               this._objShipTeam = GalaxyShipManager.instance.getShipDatas(msg.ObjShipTeamId);
            }
            if(msg.ObjShipTeamId != -1 && msg.BothStatus == 1)
            {
               this._objEquimnet = ConstructionAction.outSideContuctionList.Get(msg.ObjShipTeamId);
            }
         }
         else if(msg is MSG_RESP_FORTRESSSECTION)
         {
            msg = msg as MSG_RESP_FORTRESSSECTION;
         }
         else
         {
            if(msg is MSG_RESP_FIGHTRESULT)
            {
               msg = msg as MSG_RESP_FIGHTRESULT;
               FightResultUI.instance.setFightResult(msg);
               FightResultUI.instance.Init();
               this.releaseFightSection();
               _fightStatus = FIGHT_END;
               MusicResHandler.PlayGameMusic();
               return;
            }
            _fightStatus = FIGHT_END;
         }
         switch(_fightStatus)
         {
            case FIGHT_SHIP_MOVE:
               if(msg is MSG_RESP_FORTRESSSECTION)
               {
                  _fightStatus = FIGHT_BASE_BIT_SHIP;
                  break;
               }
               if(msg.SrcMovePath[_moveStep] == -1 || _moveStep == MsgTypes.MAX_FIGHTMOVEPATH)
               {
                  BattleAction.instance.repairShipTeam(this._srcShipTeam,this._objShipTeam,msg);
                  this._srcShipTeam.getShipMc().gotoAndStop(msg.SrcDirection + 1);
                  this._srcShipTeam.Direction = msg.SrcDirection;
                  this._srcShipTeam.setShipPos(this._srcShipTeam.PosX,this._srcShipTeam.PosY);
                  _fightStatus = FIGHT_LOCK_TARGET;
                  this._moveEffectTarget = false;
                  _moveStep = 0;
                  frame = 0;
                  break;
               }
               if(frame == 0)
               {
                  this._srcShipTeam.getShipMc().gotoAndStop(msg.SrcMovePath[_moveStep] + 1);
                  this._srcShipTeam.fightMove(msg.SrcMovePath[_moveStep]);
                  this.initMoveTemp(this._srcShipTeam,msg.SrcMovePath[_moveStep]);
                  if(!this._moveEffectTarget)
                  {
                     if(msg.SrcSkill > 0)
                     {
                        this._moveEffectTarget = true;
                        this._srcShipTeam.moveSkillEffect();
                     }
                  }
               }
               this._srcShipTeam.getShipMc().x = this._srcShipTeam.getShipMc().x + this._moveTempX;
               this._srcShipTeam.getShipMc().y = this._srcShipTeam.getShipMc().y + this._moveTempY;
               if(frame == 6)
               {
                  ++_moveStep;
                  frame = 0;
                  break;
               }
               ++frame;
               break;
            case FIGHT_LOCK_TARGET:
               if(msg.ObjShipTeamId == -1)
               {
                  _fightStatus = FIGHT_END;
                  break;
               }
               if(frame == 0)
               {
                  starPos = GalaxyShipManager.getPixel(this._srcShipTeam.PosX,this._srcShipTeam.PosY);
                  if(msg.BothStatus == 0)
                  {
                     lockPos = GalaxyShipManager.getPixel(this._objShipTeam.PosX,this._objShipTeam.PosY);
                     OutSideGalaxiasAction.getInstance().LockObjEffect(starPos,lockPos,BattleAction.E_LOCK);
                  }
                  else if(msg.BothStatus == 1)
                  {
                     lockPos = GalaxyShipManager.getPixel(this._objEquimnet.EquimentInfoData.PosX,this._objEquimnet.EquimentInfoData.PosY);
                     if(this._objEquimnet.EquimentInfoData.BuildID == EquimentTypeEnum.EQUIMENT_TYPE_SPACESTATION)
                     {
                        OutSideGalaxiasAction.getInstance().LockObjEffect(starPos,lockPos,BattleAction.E_LOCK3);
                     }
                     else
                     {
                        OutSideGalaxiasAction.getInstance().LockObjEffect(starPos,lockPos,BattleAction.E_LOCK);
                     }
                  }
               }
               if(frame == 19)
               {
                  if(msg.BothStatus == 0)
                  {
                     _fightStatus = FIGHT_BATTLT_OPEN;
                  }
                  else if(msg.BothStatus == 1)
                  {
                     _fightStatus = FIGHT_SHIP_BIT_BASE;
                  }
                  frame = 0;
                  break;
               }
               ++frame;
               break;
            case FIGHT_BATTLT_OPEN:
               if(frame == 0)
               {
                  BattleAction.instance.Alpha(0);
                  ShipTeamInfoTip.instance.Hide();
                  GameKernel.currentGameStage = GameStageEnum.GAME_STAGE_BATTLE;
                  GameScreenManager.getInstance().ShowScreen(BattleAction.instance);
                  MainUI.getInstance().SetUIVisible(false);
                  BufferQueueManager.getInstance().Hide();
                  NotifyWidget.getInstance().Hide();
                  this.objMatrix = this.getObjArray(msg.SrcDirection,this._objShipTeam.Direction);
                  this._srcShipTeam.Gas -= msg.SrcRepairSupply;
                  BattleAction.instance.initSrcShip(this._srcShipTeam);
                  BattleAction.instance.initObjShip(this._objShipTeam);
                  BattleAction.instance.initBattle(this._srcShipTeam,this._objShipTeam,this.objMatrix,msg);
                  this._objShipTeam.beMove(msg.SrcDirection,msg.RepelStep);
               }
               if(frame == 9)
               {
                  BattleAction.instance.Alpha(1);
                  _fightStatus = FIGHT_TEAM_ATTACK;
                  frame = 0;
                  break;
               }
               ++frame;
               BattleAction.instance.Alpha(frame * 0.1);
               break;
            case FIGHT_TEAM_ATTACK:
               if(msg.ShipFight.length == 0 || _fightStep == 9)
               {
                  _fightStatus = FIGHT_END;
                  _fightStep = 0;
                  frame = 0;
                  break;
               }
               temp = msg.ShipFight[_fightStep] as MSG_RESP_SHIPFIGHT;
               Blast = this.initBlastArray(temp.ObjBlast);
               if(msg.ObjMatrixId[_fightStep] == -1)
               {
                  ++_fightStep;
                  break;
               }
               switch(_attackStatus)
               {
                  case ATTACK_STARTUP:
                     if(frame == 0)
                     {
                        if(temp.SrcSkill > 0)
                        {
                           BattleAction.instance.addSrcSkillEffect();
                        }
                        if(Blast[0] == 1)
                        {
                           BattleAction.instance.addSrcEffect(BattleAction.E_SHIPBLAST,_fightStep);
                        }
                        BattleAction.instance.initPart(temp,this._srcShipTeam,this._objShipTeam);
                     }
                     if(frame == 4 && temp.SrcSkill <= 0)
                     {
                        frame = 0;
                        _attackStatus = ATTACK_FIER;
                        break;
                     }
                     if(frame == 14 && temp.SrcSkill > 0)
                     {
                        frame = 0;
                        _attackStatus = ATTACK_FIER;
                        break;
                     }
                     ++frame;
                     break;
                  case ATTACK_FIER:
                     if(frame == 0)
                     {
                        part = CShipmodelReader.getInstance().getShipPartInfo(temp.SrcPartId[0]);
                        if(Blast[2] == 1)
                        {
                           BattleAction.instance.addSrcEffect(parseInt(part.KindId + "0"),_fightStep);
                        }
                        else
                        {
                           BattleAction.instance.addSrcEffect(part.KindId,_fightStep);
                        }
                        BattleAction.instance.updateSrcSupply(this._srcShipTeam,temp.SrcReduceSupply,temp.SrcReduceStorage);
                     }
                     if(frame == 20)
                     {
                        frame = 0;
                        _attackStatus = ATTACK_BEFIERED;
                        break;
                     }
                     ++frame;
                     break;
                  case ATTACK_BEFIERED:
                     if(frame == 0)
                     {
                        objPos = this.getObjArrayPos2(this.objMatrix,msg.ObjMatrixId[_fightStep]);
                        objShip = this._objShipTeam.TeamBody[this.objMatrix[objPos]];
                        if(temp.ObjSkill > 0)
                        {
                           BattleAction.instance.addObjSkillEffect();
                        }
                        if(Blast[1] == 1)
                        {
                           BattleAction.instance.addObjEffect(BattleAction.E_MISS,objPos);
                        }
                        this.addObjShipNumEffect(temp.ObjReduceShield,temp.ObjReduceEndure,temp.ObjReduceShipNum,this.objMatrix,this._objShipTeam,objPos);
                        BattleAction.instance.updateObjSupply(this._objShipTeam,temp.ObjReduceSupply,temp.ObjReduceStorage);
                     }
                     if(frame == 10)
                     {
                        this.addObjShipBombEffect(this.objMatrix,this._objShipTeam,objPos);
                     }
                     if(frame == 20)
                     {
                        this.deleteObjShip(this.objMatrix,this._objShipTeam,objPos);
                        frame = 0;
                        if(temp.SrcReduceHp > 0 || temp.SrcReduceShipNum > 0)
                        {
                           _attackStatus = ATTACK_STEP_4;
                           break;
                        }
                        _attackStatus = ATTACK_STEP_5;
                        break;
                     }
                     ++frame;
                     break;
                  case ATTACK_STEP_4:
                     if(frame == 0)
                     {
                        this.addSrcShipNumEffect(temp.SrcReduceHp,temp.SrcReduceShipNum);
                     }
                     ++frame;
                     if(frame == 4)
                     {
                        frame = 0;
                        _attackStatus = ATTACK_STEP_5;
                     }
                     break;
                  case ATTACK_STEP_5:
                     _attackStatus = ATTACK_STARTUP;
                     ++_fightStep;
               }
               break;
            case FIGHT_SHIP_BIT_BASE:
               if(frame == 0)
               {
                  b = 0;
                  while(b < msg.ShipFight.length)
                  {
                     temp1 = msg.ShipFight[b] as MSG_RESP_SHIPFIGHT;
                     countEndure += temp1.ObjReduceEndure;
                     b++;
                  }
                  ConstructionBloodPlaneManager.showBloodPlane(this._objEquimnet);
                  ConstructionBloodPlaneManager.repaint(this._objEquimnet,countEndure);
                  basePos = GalaxyShipManager.getPixel(this._objEquimnet.EquimentInfoData.PosX,this._objEquimnet.EquimentInfoData.PosY);
                  OutSideGalaxiasAction.getInstance().OutSideAddFightEffect(BattleAction.E_BleedNum,basePos,"-" + countEndure);
                  OutSideGalaxiasAction.getInstance().OutSideAddFightEffect(BattleAction.E_BOMB2,basePos);
               }
               if(frame == 30)
               {
                  frame = 0;
                  _fightStatus = FIGHT_END;
                  break;
               }
               ++frame;
               break;
            case FIGHT_BASE_BIT_SHIP:
               if(frame == 0)
               {
                  f = 0;
                  while(f < (msg as MSG_RESP_FORTRESSSECTION).DataLen)
                  {
                     tempArr.push((msg as MSG_RESP_FORTRESSSECTION).ShipFight[f]);
                     f++;
                  }
                  if(this._MsgDatas[1] is MSG_RESP_FORTRESSSECTION && this._MsgDatas[1].SrcID == msg.SrcID)
                  {
                     this._MsgDatas.shift();
                     return;
                  }
                  this._srcEquiment = ConstructionAction.outSideContuctionList.Get((msg as MSG_RESP_FORTRESSSECTION).SrcID);
                  if(!this._srcEquiment)
                  {
                     break;
                  }
                  this.AddSrcTarget(this._srcEquiment as DisplayObject);
                  srcPos = GalaxyShipManager.getPixel(this._srcEquiment.EquimentInfoData.PosX,this._srcEquiment.EquimentInfoData.PosY);
                  this._objShipTeam = GalaxyShipManager.instance.getShipDatas((tempArr[0] as MSG_RESP_FORTRESSFIGHT).ObjShipTeamId);
                  bitPos = GalaxyShipManager.getPixel(this._objShipTeam.PosX,this._objShipTeam.PosY);
                  switch((msg as MSG_RESP_FORTRESSSECTION).BuildType)
                  {
                     case 1:
                        OutSideGalaxiasAction.getInstance().LockObjEffect(srcPos,bitPos,BattleAction.E_LOCK);
                        break;
                     case 2:
                        OutSideGalaxiasAction.getInstance().LockObjEffect(srcPos,bitPos,BattleAction.E_LOCK2);
                        break;
                     case 3:
                  }
               }
               if(frame == 10)
               {
                  srcPos = GalaxyShipManager.getPixel(this._srcEquiment.EquimentInfoData.PosX,this._srcEquiment.EquimentInfoData.PosY);
                  bitPos = GalaxyShipManager.getPixel(this._objShipTeam.PosX,this._objShipTeam.PosY);
                  switch((msg as MSG_RESP_FORTRESSSECTION).BuildType)
                  {
                     case 1:
                        OutSideGalaxiasAction.getInstance().OutSideAddFightEffect(BattleAction.E_PARTICLE,bitPos);
                        break;
                     case 2:
                        OutSideGalaxiasAction.getInstance().OutSideAddFightEffect(BattleAction.E_FLACK,bitPos);
                        break;
                     case 3:
                        if(this._srcEquiment.EquimentInfoData.BuildID == 13)
                        {
                           OutSideGalaxiasAction.getInstance().OutSideAddFightEffect(BattleAction.E_SPACE,srcPos);
                           break;
                        }
                        OutSideGalaxiasAction.getInstance().OutSideAddFightEffect(BattleAction.E_THOR,srcPos);
                  }
               }
               if(frame == 19)
               {
                  if((msg as MSG_RESP_FORTRESSSECTION).BuildType == 3)
                  {
                     bitPos = new Point(this._objShipTeam.PosX,this._objShipTeam.PosY);
                     bitPos = GalaxyShipManager.getPixel(bitPos.x,bitPos.y);
                     OutSideGalaxiasAction.getInstance().OutSideAddFightEffect(BattleAction.E_THOR2,bitPos);
                  }
                  try
                  {
                     switch((msg as MSG_RESP_FORTRESSSECTION).BuildType)
                     {
                        case 1:
                           break;
                        case 2:
                           this.shake();
                           break;
                        case 3:
                           this.shake();
                     }
                  }
                  catch(err:Error)
                  {
                  }
                  posArr = new HashSet();
                  s = 0;
                  while(s < tempArr.length)
                  {
                     fight = tempArr[s] as MSG_RESP_FORTRESSFIGHT;
                     this._objShipTeam = GalaxyShipManager.instance.getShipDatas(fight.ObjShipTeamId);
                     this._objShipTeam.Storage -= fight.ObjReduceStorage;
                     this._objShipTeam.Gas -= fight.ObjReduceSupply;
                     bitPos = GalaxyShipManager.getPixel(this._objShipTeam.PosX,this._objShipTeam.PosY);
                     posArr.Put(this._objShipTeam.PosX + "_" + this._objShipTeam.PosY,bitPos);
                     ss = 0;
                     while(ss < MsgTypes.MAX_SHIPTEAMBODY)
                     {
                        gship = this._objShipTeam.TeamBody[ss] as GShip;
                        if(gship)
                        {
                           gship.Num -= fight.ObjReduceShipNum[ss];
                           this._objShipTeam.ShipNum -= fight.ObjReduceShipNum[ss];
                           gship.Shield -= fight.ObjReduceHP[ss];
                           objTeamRHP += fight.ObjReduceHP[ss];
                           if(gship.Shield < 0)
                           {
                              gship.Endure += gship.Shield;
                              gship.Shield = 0;
                           }
                           if(gship.Endure == 0 || gship.Num == 0)
                           {
                              gship = null;
                           }
                        }
                        ss++;
                     }
                     this._objShipTeam.freshShipNum();
                     shipPoint = GalaxyShipManager.getPixel(this._objShipTeam.PosX,this._objShipTeam.PosY);
                     OutSideGalaxiasAction.getInstance().OutSideAddFightEffect(BattleAction.E_BleedNum,shipPoint,"-" + objTeamRHP);
                     objTeamRHP = 0;
                     s++;
                  }
                  s = 0;
                  while(s < posArr.Length())
                  {
                     item = posArr.Values()[s] as Point;
                     OutSideGalaxiasAction.getInstance().OutSideAddFightEffect(BattleAction.E_THOR2,item);
                     s++;
                  }
               }
               if(frame == 24)
               {
                  sss = 0;
                  while(sss < (msg as MSG_RESP_FORTRESSSECTION).DataLen)
                  {
                     fight2 = tempArr[sss] as MSG_RESP_FORTRESSFIGHT;
                     if(fight2.DelFlag == 1)
                     {
                        this._objShipTeam = GalaxyShipManager.instance.getShipDatas(fight2.ObjShipTeamId);
                        bomPos = GalaxyShipManager.getPixel(this._objShipTeam.PosX,this._objShipTeam.PosY);
                        OutSideGalaxiasAction.getInstance().OutSideAddFightEffect(BattleAction.E_BOMB,bomPos);
                        GalaxyShipManager.instance.deleteOneShipTeam(fight2.ObjShipTeamId);
                     }
                     sss++;
                  }
               }
               if(frame == 29)
               {
                  frame = 0;
                  _fightStatus = FIGHT_END;
                  break;
               }
               ++frame;
               break;
            case FIGHT_END:
               if(msg is MSG_RESP_FIGHTSECTION)
               {
                  if(this._objEquimnet)
                  {
                     ConstructionBloodPlaneManager.hideBloodPlane(this._objEquimnet);
                  }
                  else
                  {
                     switch(msg.DelFlag)
                     {
                        case 0:
                           break;
                        case 1:
                           GalaxyShipManager.instance.deleteOneShipTeam(msg.ObjShipTeamId);
                           break;
                        case 2:
                           GalaxyShipManager.instance.deleteOneShipTeam(msg.SrcShipTeamId);
                           break;
                        case 3:
                           GalaxyShipManager.instance.deleteOneShipTeam(msg.ObjShipTeamId);
                           GalaxyShipManager.instance.deleteOneShipTeam(msg.SrcShipTeamId);
                     }
                  }
               }
               else if(msg is MSG_RESP_FORTRESSSECTION)
               {
                  ConstructionBloodPlaneManager.hideBloodPlane(this._objEquimnet);
               }
               this.fightStepEnd();
         }
      }
      
      private function shake() : void
      {
         TweenLite.to(GameKernel.getScreen(),0.02,{
            "x":this.len * Math.random(),
            "y":this.len * Math.random(),
            "onComplete":this.completeHandle
         });
      }
      
      private function completeHandle(param1:Event = null) : void
      {
         if(this.count < 9)
         {
            TweenLite.to(GameKernel.getScreen(),0.02,{
               "x":this.len * Math.random(),
               "y":this.len * Math.random(),
               "onComplete":this.completeHandle
            });
            ++this.count;
            return;
         }
         TweenLite.to(GameKernel.getScreen(),0.02,{
            "x":0,
            "y":0
         });
         this.count = 0;
      }
      
      public function releaseFightSection() : void
      {
         this._MsgDatas.splice(0);
         this._MsgDatas.length = 0;
         if(this.hasFight())
         {
            this.endFight();
         }
         _fightingFlag = false;
         BattleAction.instance.clearRubbish();
         BattleAction.instance.releasePart();
         MainUI.getInstance().SetUIVisible(true);
         BufferQueueManager.getInstance().Show();
         NotifyWidget.getInstance().Show();
         _fightStatus = FIGHT_SHIP_MOVE;
         frame = 0;
         _moveStep = 0;
         _attackStatus = ATTACK_STARTUP;
         _fightStep = 0;
         if(GameKernel.currentGameStage == GameStageEnum.GAME_STAGE_BATTLE)
         {
            GameKernel.currentGameStage = GameStageEnum.GAME_STAGE_OUTSIDE;
            GameScreenManager.getInstance().ShowScreen(OutSideGalaxiasAction.getInstance());
            BattleAction.instance.onMouseOut();
         }
      }
      
      private function fightStepEnd() : void
      {
         BattleAction.instance.releasePart();
         BattleAction.instance.clearRubbish();
         GameScreenManager.getInstance().ShowScreen(OutSideGalaxiasAction.getInstance());
         BattleAction.instance.onMouseOut();
         MainUI.getInstance().SetUIVisible(true);
         BufferQueueManager.getInstance().Show();
         NotifyWidget.getInstance().Show();
         GameKernel.currentGameStage = GameStageEnum.GAME_STAGE_OUTSIDE;
         this._MsgDatas.shift();
         tempArr.splice(0);
         _fightStatus = FIGHT_SHIP_MOVE;
         _attackStatus = ATTACK_STARTUP;
         frame = 0;
         _moveStep = 0;
         _fightStep = 0;
         this.objMatrix.splice();
      }
      
      private function initBlastArray(param1:int) : Array
      {
         var _loc5_:int = 0;
         var _loc2_:String = "";
         var _loc3_:Array = new Array();
         _loc2_ = param1.toString(2);
         var _loc4_:int = _loc2_.length - 1;
         while(_loc4_ >= 0)
         {
            _loc5_ = parseInt(_loc2_.charAt(_loc4_));
            _loc3_.push(_loc5_);
            _loc4_--;
         }
         return _loc3_;
      }
      
      private function AddSrcTarget(param1:DisplayObject) : void
      {
         GameKernel.AddTimerEvent(this.onSrcTarget,param1);
      }
      
      private function onSrcTarget(param1:DisplayObject) : void
      {
         if(this._filterCount % 2 == 0)
         {
            param1.filters = this._filter;
         }
         else
         {
            param1.filters = null;
         }
         ++this._filterCount;
         if(this._filterCount == 8)
         {
            GameKernel.RemoveTimerEvent(this.onSrcTarget,param1);
            param1.filters = null;
            this._filterCount = 0;
            return;
         }
      }
      
      private function onObjEquimentEffect(param1:Event) : void
      {
         if(param1.target.currentFrame == param1.target.totalFrames)
         {
            param1.target.stop();
            GameKernel.RemoveTimerEvent(this.onObjEquimentEffect);
            this._objEquimnet.removeChild(param1.target as DisplayObject);
         }
      }
      
      private function addSrcShipNumEffect(param1:int, param2:int) : void
      {
         var _loc3_:GShip = this._srcShipTeam.TeamBody[_fightStep] as GShip;
         if(_loc3_.Shield > 0)
         {
            if(param1 <= _loc3_.Shield)
            {
               BattleAction.instance.addSrcNum(param1,_fightStep,true);
            }
            else
            {
               BattleAction.instance.addSrcNum(_loc3_.Shield,_fightStep,true);
               BattleAction.instance.addSrcNum(param1 - _loc3_.Shield,_fightStep);
            }
         }
         else
         {
            BattleAction.instance.addSrcNum(param1,_fightStep);
         }
         _loc3_.Shield -= param1;
         if(_loc3_.Shield < 0)
         {
            _loc3_.Endure += _loc3_.Shield;
            _loc3_.Shield = 0;
         }
         _loc3_.Num -= param2;
         this._srcShipTeam.ShipNum -= param2;
         this._srcShipTeam.freshShipNum();
         var _loc4_:Bitmap = BattleAction.instance.lineSprite.getChildByName("SRC_NUM_" + _fightStep) as Bitmap;
         if(Boolean(_loc3_) && _loc3_.Num > 0)
         {
            _loc4_.bitmapData = GameFont.getInt(_loc3_.Num);
         }
         else
         {
            _loc4_.bitmapData = null;
         }
         if(_loc3_ && _loc3_.ShipModelId != -1 && _loc3_.Num == 0)
         {
            BattleAction.instance.addSrcEffect(BattleAction.E_BOMB,_fightStep);
            BattleAction.instance.deleteSrcShip(_fightStep);
            _loc3_ = null;
            this._srcShipTeam.TeamBody[_fightStep] = null;
         }
      }
      
      private function addObjShipNumEffect(param1:Array, param2:int, param3:Array, param4:Array, param5:GShipTeam, param6:int) : void
      {
         var _loc8_:GShip = null;
         var _loc9_:EffectBlood = null;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:int = 0;
         var _loc13_:Bitmap = null;
         var _loc7_:int = 0;
         while(_loc7_ < MsgTypes.MAX_SHIPTEAMBODY)
         {
            if(param5.TeamBody[_loc7_] != null)
            {
               _loc8_ = param5.TeamBody[_loc7_] as GShip;
               if(_loc8_.ShipModelId == -1)
               {
                  _loc8_.Endure = 0;
                  _loc8_.Num = 0;
               }
               else
               {
                  _loc12_ = this.getObjArrayPos2(param4,_loc7_);
                  if(_loc12_ != param6 && param1[_loc7_] > 0)
                  {
                     if(_loc8_.Shield >= param1[_loc7_])
                     {
                        BattleAction.instance.addObjEffect(BattleAction.E_SHIELD,_loc12_);
                        BattleAction.instance.addObjNum(param1[_loc7_],_loc12_,true);
                     }
                     else if(_loc8_.Shield > 0 && _loc8_.Shield < param1[_loc7_])
                     {
                        BattleAction.instance.addObjEffect(BattleAction.E_SHIELD,_loc12_);
                        BattleAction.instance.addObjNum(_loc8_.Shield,_loc12_,true);
                        BattleAction.instance.addObjNum(param1[_loc7_] - _loc8_.Shield,_loc12_,false);
                     }
                     else
                     {
                        BattleAction.instance.addObjNum(param1[_loc7_],_loc12_,false);
                     }
                  }
                  else if(_loc12_ == param6)
                  {
                     if(param1[_loc7_] > 0)
                     {
                        BattleAction.instance.addObjEffect(BattleAction.E_SHIELD,_loc12_);
                        BattleAction.instance.addObjNum(param1[_loc7_],_loc12_,true);
                     }
                     if(param2 > 0)
                     {
                        BattleAction.instance.shakeObjShip(_loc12_);
                        BattleAction.instance.addObjNum(param2,_loc12_,false);
                     }
                  }
                  if(_loc12_ == param6)
                  {
                     _loc10_ = _loc8_.Shield / _loc8_.MaxShield;
                     _loc11_ = _loc8_.Endure / _loc8_.MaxEndure;
                     _loc9_ = new EffectBlood(_loc10_,_loc11_);
                     _loc9_.y -= 20;
                     _loc8_.getModel().addChild(_loc9_);
                     _loc8_.Shield -= param1[_loc7_];
                     _loc8_.Endure -= param2;
                     _loc10_ -= _loc8_.Shield / _loc8_.MaxShield;
                     _loc11_ -= _loc8_.Endure / _loc8_.MaxEndure;
                     _loc9_.update(_loc10_,_loc11_);
                  }
                  else
                  {
                     _loc8_.Shield -= param1[_loc7_];
                     if(_loc8_.Shield < 0)
                     {
                        _loc8_.Endure += _loc8_.Shield;
                        _loc8_.Shield = 0;
                     }
                  }
                  _loc8_.Num -= param3[_loc7_];
                  param5.ShipNum -= param3[_loc7_];
                  _loc13_ = BattleAction.instance.lineSprite.getChildByName("OBJ_NUM_" + _loc12_) as Bitmap;
                  if(_loc8_.Num > 0)
                  {
                     _loc13_.bitmapData = GameFont.getInt(_loc8_.Num);
                  }
                  else
                  {
                     _loc13_.bitmapData = null;
                  }
                  if(_loc8_.Num == 0 || _loc8_.Endure == 0)
                  {
                     _loc8_.Num = 0;
                     _loc8_.Endure = 0;
                  }
               }
            }
            _loc7_++;
         }
         param5.freshShipNum();
      }
      
      private function addObjShipBombEffect(param1:Array, param2:GShipTeam, param3:int) : void
      {
         var _loc4_:GShip = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         while(_loc6_ < MsgTypes.MAX_SHIPTEAMBODY)
         {
            if(Boolean(param2.TeamBody[_loc6_]) && param2.TeamBody[_loc6_].ShipModelId != -1)
            {
               _loc4_ = param2.TeamBody[_loc6_] as GShip;
               if(_loc4_.Num == 0)
               {
                  _loc5_ = this.getObjArrayPos2(param1,_loc6_);
                  BattleAction.instance.addObjEffect(BattleAction.E_BOMB,_loc5_);
               }
            }
            _loc6_++;
         }
      }
      
      private function deleteObjShip(param1:Array, param2:GShipTeam, param3:int) : void
      {
         var _loc4_:GShip = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         while(_loc6_ < MsgTypes.MAX_SHIPTEAMBODY)
         {
            if(Boolean(param2.TeamBody[_loc6_]) && param2.TeamBody[_loc6_].ShipModelId != -1)
            {
               _loc4_ = param2.TeamBody[_loc6_] as GShip;
               if(_loc4_.Num == 0)
               {
                  _loc5_ = this.getObjArrayPos2(param1,_loc6_);
                  param2.TeamBody[_loc6_] = null;
                  BattleAction.instance.deleteObjShip(_loc5_);
               }
            }
            _loc6_++;
         }
      }
      
      private function getObjArray(param1:int, param2:int) : Array
      {
         var _loc3_:int = (4 - param1 + param2) % 4;
         return _matrix[_loc3_];
      }
      
      private function getObjArrayPos(param1:int, param2:int, param3:int) : int
      {
         var _loc4_:int = (4 - param1 + param2) % 4;
         var _loc5_:int = 0;
         while(_loc5_ < 9)
         {
            if(_matrix[_loc4_][_loc5_] == param3)
            {
               return _loc5_;
            }
            _loc5_++;
         }
         return -1;
      }
      
      private function getObjArrayPos2(param1:Array, param2:int) : int
      {
         var _loc3_:int = 0;
         while(_loc3_ < param1.length)
         {
            if(param1[_loc3_] == param2)
            {
               return _loc3_;
            }
            _loc3_++;
         }
         return -1;
      }
      
      private function initMoveTemp(param1:GShipTeam, param2:int) : void
      {
         switch(param2)
         {
            case 0:
               this._moveTempX = GameSetting.MAP_OUTSIDE_GRID_WIDTH * 0.5 / 7;
               this._moveTempY = GameSetting.MAP_OUTSIDE_GRID_HEIGHT * 0.5 / 7;
               param1.PosX + 1;
               break;
            case 1:
               this._moveTempX = -GameSetting.MAP_OUTSIDE_GRID_WIDTH * 0.5 / 7;
               this._moveTempY = GameSetting.MAP_OUTSIDE_GRID_HEIGHT * 0.5 / 7;
               param1.PosY + 1;
               break;
            case 2:
               this._moveTempX = -GameSetting.MAP_OUTSIDE_GRID_WIDTH * 0.5 / 7;
               this._moveTempY = -GameSetting.MAP_OUTSIDE_GRID_HEIGHT * 0.5 / 7;
               param1.PosX - 1;
               break;
            case 3:
               this._moveTempX = GameSetting.MAP_OUTSIDE_GRID_WIDTH * 0.5 / 7;
               this._moveTempY = -GameSetting.MAP_OUTSIDE_GRID_HEIGHT * 0.5 / 7;
               param1.PosY - 1;
         }
      }
      
      public function startFight() : void
      {
         if(_fightingFlag == true)
         {
            return;
         }
         _fightingFlag = true;
         GameKernel.AddTimerEvent(this.onFight);
      }
      
      public function endFight() : void
      {
         if(_fightingFlag)
         {
            GameKernel.RemoveTimerEvent(this.onFight);
            _fightingFlag = false;
         }
      }
      
      public function hasFight() : Boolean
      {
         OutSideGalaxiasAction.getInstance().Init();
         return _fightingFlag;
      }
      
      public function pushMsg(param1:*) : void
      {
         if(this._MsgDatas.length == 0)
         {
            this.startFight();
         }
         this._MsgDatas.push(param1);
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
