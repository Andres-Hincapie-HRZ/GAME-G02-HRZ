package logic.entry
{
   import com.star.frameworks.facebook.FacebookUserInfo;
   import com.star.frameworks.managers.StringManager;
   import com.star.frameworks.utils.CEffectText;
   import com.star.frameworks.utils.StringUitl;
   import flash.utils.ByteArray;
   import logic.action.ChatAction;
   import logic.action.ConstructionAction;
   import logic.entry.props.propsInfo;
   import logic.game.ConstructionAnimationManager;
   import logic.game.GameKernel;
   import logic.reader.CPropsReader;
   import logic.reader.CScienceReader;
   import logic.ui.AirshipUi;
   import logic.ui.BuildChargeUI;
   import logic.ui.FlattopUi;
   import logic.ui.GameDateTaskUI;
   import logic.ui.LotteryUi;
   import logic.ui.MallgoodsPopup;
   import logic.ui.MessagePopup;
   import logic.ui.MissileUi;
   import logic.ui.OpticsUi;
   import logic.ui.PackUi;
   import logic.ui.PlayerInfoUI;
   import logic.ui.ResPlaneUI;
   import logic.ui.ResgatherUi;
   import logic.ui.ScienceSpeedPopUp;
   import logic.ui.ScienceSystemUi;
   import logic.ui.TrajectoryUi;
   import logic.utils.*;
   import net.base.NetManager;
   import net.msg.sciencesystem.*;
   import net.router.MapRouter;
   import net.router.ShipmodelRouter;
   
   public class ScienceSystem
   {
      
      private static var _instance:ScienceSystem = null;
      
      public var scobj:Object;
      
      public var levearr:Array = new Array();
      
      public var Ttimarr:Array = new Array();
      
      public var Otimarr:Array = new Array();
      
      public var Mtimarr:Array = new Array();
      
      public var Ftimarr:Array = new Array();
      
      public var Atimarr:Array = new Array();
      
      public var zzsjarr:Array = new Array(0);
      
      private var pd:Boolean = true;
      
      private var xmlpd:Boolean = true;
      
      public var duiarr:Array = new Array();
      
      public var Packarr:Array = new Array();
      
      public var Juntarr:Array = new Array();
      
      public var Allarr:Array = new Array();
      
      public var IncTechPercent:int = 0;
      
      private var fists:Boolean = true;
      
      public var Online:Boolean = false;
      
      public var yutiaojian:Boolean = false;
      
      private var Mallbo:Boolean = true;
      
      public var nowtechid:int = -1;
      
      private var lottID:int = 0;
      
      private var guid:int = 0;
      
      public var ScienceObj:Object = new Object();
      
      public function ScienceSystem()
      {
         super();
      }
      
      public static function getinstance() : ScienceSystem
      {
         if(_instance == null)
         {
            _instance = new ScienceSystem();
         }
         return _instance;
      }
      
      public function initXML() : void
      {
         if(!this.xmlpd)
         {
            return;
         }
         this.xmlpd = false;
         CScienceReader.getInstance().getWeaponTechXML();
         CScienceReader.getInstance().getDefenceTechXML();
         CScienceReader.getInstance().getTechXML();
         McBitmap.getInstance().begin();
         ConstructionAction.bulidTechObj = this.getBuildTechData();
         ConstructionAction.defendTechObj = this.getDefenceTechData();
         PackUi.getInstance().Init();
      }
      
      public function read_MSG_RESP_CREATETECH(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_CREATETECH = new MSG_RESP_CREATETECH();
         NetManager.Instance().readObject(_loc4_,param3);
         this.scobj = new Object();
         this.scobj.TechId = _loc4_.TechId;
         this.scobj.NeedTime = _loc4_.NeedTime;
         var _loc5_:Object = new Object();
         var _loc6_:Array = new Array();
         ConstructionAnimationManager.PlayConstuctionByBuildingID(EquimentTypeEnum.EQUIMENT_TYPE_TECHRESEARCHCENTER);
         this.nowtechid = _loc4_.TechId;
         if(_loc4_.TechId < 64)
         {
            if(_loc4_.TechId < 16)
            {
               TrajectoryUi.getInstance().timeHd(_loc4_.TechId,_loc4_.NeedTime);
               _loc6_[0] = TrajectoryUi.getInstance().levelarr[_loc4_.TechId];
            }
            if(_loc4_.TechId >= 16 && _loc4_.TechId < 32)
            {
               OpticsUi.getInstance().timeHd(_loc4_.TechId,_loc4_.NeedTime);
               _loc6_[0] = OpticsUi.getInstance().levelarr[_loc4_.TechId];
            }
            if(_loc4_.TechId >= 32 && _loc4_.TechId < 48)
            {
               MissileUi.getInstance().timeHd(_loc4_.TechId,_loc4_.NeedTime);
               _loc6_[0] = MissileUi.getInstance().levelarr[_loc4_.TechId];
            }
            if(_loc4_.TechId >= 48 && _loc4_.TechId < 64)
            {
               FlattopUi.getInstance().timeHd(_loc4_.TechId,_loc4_.NeedTime);
               _loc6_[0] = FlattopUi.getInstance().levelarr[_loc4_.TechId];
            }
            this.ScienceObj.name = CScienceReader.getInstance().WeaponTechAry[_loc4_.TechId].name;
         }
         if(_loc4_.TechId >= 70 && _loc4_.TechId < 97)
         {
            if(_loc4_.TechId < 89)
            {
               AirshipUi.getInstance().timeHd(_loc4_.TechId,_loc4_.NeedTime);
               _loc6_[0] = AirshipUi.getInstance().levelarr[_loc4_.TechId];
            }
            if(_loc4_.TechId >= 89)
            {
               BuildChargeUI.getInstance().timeHd(_loc4_.TechId,_loc4_.NeedTime);
               _loc6_[0] = BuildChargeUI.getInstance().levelarr[_loc4_.TechId];
            }
            this.ScienceObj.name = CScienceReader.getInstance().DefenceTechAry[_loc4_.TechId].name;
         }
         if(_loc4_.TechId >= 100 && _loc4_.TechId < 111)
         {
            ResgatherUi.getInstance().timeHd(_loc4_.TechId,_loc4_.NeedTime);
            _loc6_[0] = ResgatherUi.getInstance().levelarr[_loc4_.TechId];
            this.ScienceObj.name = CScienceReader.getInstance().TechArr[_loc4_.TechId].name;
         }
         this.ScienceObj.needtime = _loc4_.NeedTime;
         this.ScienceObj.leve = _loc6_[0];
         _loc5_.leve = _loc6_[0];
         _loc5_.needtime = _loc4_.NeedTime;
         _loc5_.tc = _loc4_.TechId;
         _loc5_.CreditFlag = _loc4_.CreditFlag;
         this.zzsjarr.push(_loc5_);
         this.Online = true;
         ScienceSystemUi.getInstance().sjj(_loc5_);
      }
      
      public function read_MSG_RESP_TECHINFO(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc5_:Array = null;
         var _loc6_:Object = null;
         var _loc8_:MSG_RESP_TECHINFO_TEMP = null;
         var _loc4_:MSG_RESP_TECHINFO = new MSG_RESP_TECHINFO();
         NetManager.Instance().readObject(_loc4_,param3);
         this.nowtechid = -1;
         var _loc7_:int = 0;
         while(_loc7_ < _loc4_.DataLen)
         {
            _loc8_ = _loc4_.Data[_loc7_] as MSG_RESP_TECHINFO_TEMP;
            _loc5_ = new Array();
            _loc5_.length = 0;
            _loc5_[0] = _loc8_.TechId;
            _loc5_[1] = uint(_loc8_.levelId + 1);
            if(_loc8_.TechId == 95)
            {
               GamePlayer.getInstance().AddThorNum = CScienceReader.getInstance().defencearr[95][0].AddThorNum;
            }
            if(_loc8_.TechId == 93)
            {
               GamePlayer.getInstance().AddBuiltNum = CScienceReader.getInstance().defencearr[93][_loc8_.levelId].AddBuiltNum;
            }
            if(_loc8_.TechId == 100)
            {
               GamePlayer.getInstance().IncreaseBuildQueue = CScienceReader.getInstance().techarr[_loc8_.TechId][0].IncreaseBuildQueue;
            }
            if(_loc8_.TechId == 105)
            {
               GamePlayer.getInstance().m_ParallelCreateShip = _loc8_.levelId + 1;
            }
            this.levearr.push(_loc5_);
            _loc6_ = new Object();
            _loc6_.TechId = _loc8_.TechId;
            _loc6_.levelId = _loc8_.levelId + 1;
            this.Allarr.push(_loc6_);
            _loc7_++;
         }
         ScienceSystemUi.getInstance().Init();
         ConstructionAction.bulidTechObj = this.getBuildTechData();
         ConstructionAction.defendTechObj = this.getDefenceTechData();
      }
      
      public function read_MSG_RESP_TECHUPGRADEINFO(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc5_:Array = null;
         var _loc6_:Object = null;
         var _loc10_:MSG_RESP_TECHUPGRADEINFO_TEMP = null;
         var _loc11_:uint = 0;
         var _loc4_:MSG_RESP_TECHUPGRADEINFO = new MSG_RESP_TECHUPGRADEINFO();
         NetManager.Instance().readObject(_loc4_,param3);
         if(this.fists)
         {
            if(_loc4_.DataLen > 0)
            {
               this.Online = true;
            }
            else
            {
               this.Online = false;
            }
            this.fists = false;
         }
         var _loc7_:Array = new Array();
         var _loc8_:uint = 0;
         while(_loc8_ < 64)
         {
            _loc7_.push(0);
            _loc8_++;
         }
         this.IncTechPercent = _loc4_.IncTechPercent;
         CScienceReader.getInstance().zxpd = true;
         CScienceReader.getInstance().depd = true;
         CScienceReader.getInstance().tepd = true;
         CScienceReader.getInstance().getWeaponTechXML();
         CScienceReader.getInstance().getDefenceTechXML();
         CScienceReader.getInstance().getTechXML();
         var _loc9_:uint = 0;
         while(_loc9_ < _loc4_.DataLen)
         {
            _loc10_ = _loc4_.Data[_loc9_] as MSG_RESP_TECHUPGRADEINFO_TEMP;
            _loc6_ = new Object();
            if(_loc10_.TechId < 64)
            {
               if(_loc10_.TechId < 16)
               {
                  TrajectoryUi.getInstance().timeHd(_loc10_.TechId,_loc10_.NeedTime);
                  _loc7_[_loc10_.TechId] = TrajectoryUi.getInstance().levelarr[_loc10_.TechId];
               }
               if(_loc10_.TechId >= 16 && _loc10_.TechId < 32)
               {
                  OpticsUi.getInstance().timeHd(_loc10_.TechId,_loc10_.NeedTime);
                  _loc7_[_loc10_.TechId] = OpticsUi.getInstance().levelarr[_loc10_.TechId];
               }
               if(_loc10_.TechId >= 32 && _loc10_.TechId < 48)
               {
                  MissileUi.getInstance().timeHd(_loc10_.TechId,_loc10_.NeedTime);
                  _loc7_[_loc10_.TechId] = MissileUi.getInstance().levelarr[_loc10_.TechId];
               }
               if(_loc10_.TechId >= 48 && _loc10_.TechId < 64)
               {
                  FlattopUi.getInstance().timeHd(_loc10_.TechId,_loc10_.NeedTime);
                  _loc7_[_loc10_.TechId] = FlattopUi.getInstance().levelarr[_loc10_.TechId];
               }
               RegisteredData.getInstance().money = CScienceReader.getInstance().weaponarr[_loc10_.TechId][_loc7_[_loc10_.TechId]].Money;
               this.ScienceObj.name = CScienceReader.getInstance().WeaponTechAry[_loc10_.TechId].name;
            }
            if(_loc10_.TechId >= 70 && _loc10_.TechId < 97)
            {
               if(_loc10_.TechId < 89)
               {
                  AirshipUi.getInstance().timeHd(_loc10_.TechId,_loc10_.NeedTime);
                  _loc7_[_loc10_.TechId] = AirshipUi.getInstance().levelarr[_loc10_.TechId];
               }
               if(_loc10_.TechId >= 89)
               {
                  BuildChargeUI.getInstance().timeHd(_loc10_.TechId,_loc10_.NeedTime);
                  _loc7_[_loc10_.TechId] = BuildChargeUI.getInstance().levelarr[_loc10_.TechId];
               }
               RegisteredData.getInstance().money = CScienceReader.getInstance().defencearr[_loc10_.TechId][_loc7_[_loc10_.TechId]].Money;
               this.ScienceObj.name = CScienceReader.getInstance().DefenceTechAry[_loc10_.TechId].name;
            }
            if(_loc10_.TechId >= 100 && _loc10_.TechId < 111)
            {
               ResgatherUi.getInstance().timeHd(_loc10_.TechId,_loc10_.NeedTime);
               _loc7_[_loc10_.TechId] = ResgatherUi.getInstance().levelarr[_loc10_.TechId];
               RegisteredData.getInstance().money = CScienceReader.getInstance().techarr[_loc10_.TechId][_loc7_[_loc10_.TechId]].Money;
               this.ScienceObj.name = CScienceReader.getInstance().TechArr[_loc10_.TechId].name;
            }
            this.ScienceObj.needtime = _loc10_.NeedTime;
            this.ScienceObj.leve = _loc7_[_loc10_.TechId];
            this.nowtechid = _loc10_.TechId;
            _loc6_.leve = _loc7_[_loc10_.TechId];
            _loc6_.needtime = _loc10_.NeedTime;
            _loc6_.tc = _loc10_.TechId;
            _loc6_.CreditFlag = _loc10_.CreditFlag;
            if(this.zzsjarr.length == 0)
            {
               this.zzsjarr.push(_loc6_);
            }
            else
            {
               this.zzsjarr[0].needtime = _loc10_.NeedTime;
               GameDateTaskUI.GetInstance().UpdateTechTask();
            }
            _loc9_++;
         }
         if(ScienceSystemUi.IsOpen)
         {
            _loc11_ = 0;
            while(_loc11_ < this.zzsjarr.length)
            {
               ScienceSystemUi.getInstance().sjj(this.zzsjarr[_loc11_]);
               _loc11_++;
            }
         }
      }
      
      public function read_MSG_RESP_CANCELTECH(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_CANCELTECH = new MSG_RESP_CANCELTECH();
         NetManager.Instance().readObject(_loc4_,param3);
         ScienceSystemUi.getInstance().qkong(_loc4_.TechId);
         var _loc5_:uint = 0;
         while(_loc5_ < this.zzsjarr.length)
         {
            if(this.zzsjarr[_loc5_].tc == _loc4_.TechId)
            {
               this.zzsjarr.splice(_loc5_,1);
            }
            _loc5_++;
         }
         ConstructionAnimationManager.StopConstructionByBuildingID(EquimentTypeEnum.EQUIMENT_TYPE_TECHRESEARCHCENTER);
         this.ScienceObj.name = undefined;
         this.ScienceObj.leve = undefined;
         this.ScienceObj.needtime = undefined;
         this.Online = false;
         if(_loc4_.TechId < 64)
         {
            if(_loc4_.TechId < 16)
            {
               TrajectoryUi.getInstance().closeHd(_loc4_.TechId,false);
               return;
            }
            if(_loc4_.TechId >= 16 && _loc4_.TechId < 32)
            {
               OpticsUi.getInstance().closeHd(_loc4_.TechId,false);
               return;
            }
            if(_loc4_.TechId >= 32 && _loc4_.TechId < 48)
            {
               MissileUi.getInstance().closeHd(_loc4_.TechId,false);
               return;
            }
            if(_loc4_.TechId >= 48 && _loc4_.TechId < 64)
            {
               FlattopUi.getInstance().closeHd(_loc4_.TechId,false);
               return;
            }
         }
         if(_loc4_.TechId < 97 && _loc4_.TechId >= 70)
         {
            if(_loc4_.TechId < 89)
            {
               AirshipUi.getInstance().closeHd(_loc4_.TechId,false);
               return;
            }
            if(_loc4_.TechId >= 89)
            {
               BuildChargeUI.getInstance().closeHd(_loc4_.TechId,false);
               return;
            }
         }
         if(_loc4_.TechId >= 100 && _loc4_.TechId < 111)
         {
            ResgatherUi.getInstance().closeHd(_loc4_.TechId,false);
            return;
         }
      }
      
      public function CloseScienceSystemUI(param1:int, param2:int = 0) : void
      {
         ScienceSystemUi.getInstance().qkong(param1,param2);
         var _loc3_:uint = 0;
         while(_loc3_ < this.zzsjarr.length)
         {
            if(this.zzsjarr[_loc3_].tc == param1)
            {
               this.zzsjarr.splice(_loc3_,1);
            }
            _loc3_++;
         }
         if(param1 < 64)
         {
            if(param1 < 16)
            {
               TrajectoryUi.getInstance().closeHd(param1,false,1);
               return;
            }
            if(param1 >= 16 && param1 < 32)
            {
               OpticsUi.getInstance().closeHd(param1,false,1);
               return;
            }
            if(param1 >= 32 && param1 < 48)
            {
               MissileUi.getInstance().closeHd(param1,false,1);
               return;
            }
            if(param1 >= 48 && param1 < 64)
            {
               FlattopUi.getInstance().closeHd(param1,false,1);
               return;
            }
         }
         if(param1 < 97 && param1 >= 70)
         {
            if(param1 < 89)
            {
               AirshipUi.getInstance().closeHd(param1,false,1);
               return;
            }
            if(param1 >= 89)
            {
               BuildChargeUI.getInstance().closeHd(param1,false,1);
               return;
            }
         }
         if(param1 >= 100 && param1 < 111)
         {
            ResgatherUi.getInstance().closeHd(param1,false,1);
            return;
         }
      }
      
      public function read_MSG_RESP_CREATETECHCOMPLETE(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_CREATETECHCOMPLETE = new MSG_RESP_CREATETECHCOMPLETE();
         NetManager.Instance().readObject(_loc4_,param3);
         this.Compelete(_loc4_.TechId);
         ConstructionAnimationManager.StopConstructionByBuildingID(EquimentTypeEnum.EQUIMENT_TYPE_TECHRESEARCHCENTER);
         this.ScienceObj.name = undefined;
         this.ScienceObj.leve = undefined;
         this.ScienceObj.needtime = undefined;
         this.nowtechid = -1;
         var _loc5_:String = "";
         if(_loc4_.TechId < 64)
         {
            _loc5_ = CScienceReader.getInstance().WeaponTechAry[_loc4_.TechId].name;
         }
         else if(_loc4_.TechId < 97 && _loc4_.TechId >= 70)
         {
            _loc5_ = CScienceReader.getInstance().DefenceTechAry[_loc4_.TechId].name;
         }
         else if(_loc4_.TechId >= 100 && _loc4_.TechId < 111)
         {
            _loc5_ = CScienceReader.getInstance().TechArr[_loc4_.TechId].name;
         }
         CEffectText.getInstance().showEffectText(GameKernel.renderManager.getUI().getContainer(),"[" + _loc5_ + "]" + StringManager.getInstance().getMessageString("TechnologyText4"));
         this.Online = false;
      }
      
      private function Compelete(param1:int = 0) : void
      {
         var _loc3_:Object = null;
         var _loc4_:uint = 0;
         var _loc5_:Object = null;
         var _loc6_:Object = null;
         var _loc7_:int = 0;
         var _loc2_:uint = 0;
         while(_loc2_ < this.zzsjarr.length)
         {
            if(this.zzsjarr[_loc2_].tc == param1)
            {
               this.zzsjarr.splice(_loc2_,1);
            }
            _loc2_++;
         }
         ScienceSystemUi.getInstance().qkong(param1);
         if(this.Allarr.length == 0)
         {
            _loc3_ = new Object();
            _loc3_.TechId = param1;
            _loc3_.levelId = 1;
            this.Allarr.push(_loc3_);
         }
         else
         {
            _loc4_ = 0;
            while(_loc4_ < this.Allarr.length)
            {
               if(_loc4_ == this.Allarr.length - 1)
               {
                  if(this.Allarr[_loc4_].TechId == param1)
                  {
                     ++this.Allarr[_loc4_].levelId;
                     break;
                  }
                  _loc5_ = new Object();
                  _loc5_.TechId = param1;
                  _loc5_.levelId = 1;
                  this.Allarr.push(_loc5_);
                  break;
               }
               if(this.Allarr[_loc4_].TechId == param1)
               {
                  ++this.Allarr[_loc4_].levelId;
                  break;
               }
               _loc4_++;
            }
         }
         if(param1 < 64)
         {
            if(param1 < 16)
            {
               TrajectoryUi.getInstance().closeHd(param1,true);
               return;
            }
            if(param1 >= 16 && param1 < 32)
            {
               OpticsUi.getInstance().closeHd(param1,true);
               return;
            }
            if(param1 >= 32 && param1 < 48)
            {
               MissileUi.getInstance().closeHd(param1,true);
               return;
            }
            if(param1 >= 48 && param1 < 64)
            {
               FlattopUi.getInstance().closeHd(param1,true);
               return;
            }
         }
         if(param1 < 97 && param1 >= 70)
         {
            if(param1 < 89)
            {
               AirshipUi.getInstance().closeHd(param1,true);
               return;
            }
            if(param1 >= 89)
            {
               BuildChargeUI.getInstance().closeHd(param1,true);
               if(param1 == 95)
               {
                  GamePlayer.getInstance().AddThorNum = CScienceReader.getInstance().defencearr[95][0].AddThorNum;
               }
               else if(param1 == 93)
               {
                  for each(_loc6_ in this.Allarr)
                  {
                     if(_loc6_.TechId == 93)
                     {
                        _loc7_ = int(_loc6_.levelId);
                     }
                  }
                  GamePlayer.getInstance().AddBuiltNum = CScienceReader.getInstance().defencearr[93][_loc7_ - 1].AddBuiltNum;
               }
               ConstructionAction.defendTechObj = this.getDefenceTechData();
               return;
            }
         }
         if(param1 >= 100 && param1 < 111)
         {
            if(param1 == 100)
            {
               GamePlayer.getInstance().IncreaseBuildQueue = CScienceReader.getInstance().techarr[param1][0].IncreaseBuildQueue;
            }
            if(param1 == 105)
            {
               GamePlayer.getInstance().m_ParallelCreateShip = 1;
            }
            ConstructionAction.bulidTechObj = this.getBuildTechData();
            ResgatherUi.getInstance().closeHd(param1,true);
            return;
         }
      }
      
      public function read_MSG_RESP_SPEEDTECH(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc5_:MSG_REQUEST_TECHUPGRADEINFO = null;
         var _loc4_:MSG_RESP_SPEEDTECH = new MSG_RESP_SPEEDTECH();
         NetManager.Instance().readObject(_loc4_,param3);
         if(ScienceSpeedPopUp.getInstance().mtyp == 0)
         {
            ConstructionAction.getInstance().costResource(0,0,0,_loc4_.Credit);
         }
         else
         {
            GamePlayer.getInstance().coins = GamePlayer.getInstance().coins - _loc4_.Credit;
         }
         if(_loc4_.Time <= 0)
         {
            this.CloseScienceSystemUI(_loc4_.TechId);
            ScienceSpeedPopUp.getInstance().close();
            return;
         }
         this.CloseScienceSystemUI(_loc4_.TechId,2);
         _loc5_ = new MSG_REQUEST_TECHUPGRADEINFO();
         _loc5_.SeqId = GamePlayer.getInstance().seqID++;
         _loc5_.Guid = GamePlayer.getInstance().Guid;
         NetManager.Instance().sendObject(_loc5_);
         ScienceSpeedPopUp.getInstance().close();
      }
      
      public function getDefenceTechData() : Object
      {
         var _loc1_:Object = new Object();
         _loc1_.DecreaseMetalConsume = 0;
         _loc1_.DecreaseHe3Consume = 0;
         _loc1_.DecreaseMoneyConsume = 0;
         _loc1_.IncreaseBuilding = 0;
         _loc1_.AddAssault = 0;
         _loc1_.AddRange = 0;
         var _loc2_:uint = 0;
         while(_loc2_ < this.Allarr.length)
         {
            if(this.Allarr[_loc2_].TechId == 89)
            {
               _loc1_.DecreaseMetalConsume = CScienceReader.getInstance().defencearr[89][this.Allarr[_loc2_].levelId - 1].DecreaseMetalConsume / 100;
               _loc1_.DecreaseHe3Consume = CScienceReader.getInstance().defencearr[89][this.Allarr[_loc2_].levelId - 1].DecreaseHe3Consume / 100;
               _loc1_.DecreaseMoneyConsume = CScienceReader.getInstance().defencearr[89][this.Allarr[_loc2_].levelId - 1].DecreaseMoneyConsume / 100;
            }
            else if(this.Allarr[_loc2_].TechId == 90)
            {
               _loc1_.IncreaseBuilding = CScienceReader.getInstance().defencearr[90][this.Allarr[_loc2_].levelId - 1].IncreaseBuilding / 100;
            }
            else if(this.Allarr[_loc2_].TechId == 92)
            {
               _loc1_.AddAssault = CScienceReader.getInstance().defencearr[92][this.Allarr[_loc2_].levelId - 1].AddAssault;
            }
            else if(this.Allarr[_loc2_].TechId == 94)
            {
               _loc1_.AddRange = CScienceReader.getInstance().defencearr[94][this.Allarr[_loc2_].levelId - 1].AddRange;
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function getBuildTechData() : Object
      {
         var _loc1_:Object = new Object();
         _loc1_.DecreaseMetalConsume = 0;
         _loc1_.DecreaseHe3Consume = 0;
         _loc1_.DecreaseMoneyConsume = 0;
         _loc1_.IncreaseBuilding = 0;
         _loc1_.IncreaseMetalOut = 0;
         _loc1_.IncreaseHe3Out = 0;
         _loc1_.IncreaseMoneyOut = 0;
         _loc1_.IncreaseMetalCapacity = 0;
         _loc1_.IncreaseHe3Capacity = 0;
         _loc1_.IncreaseMoneyCapacity = 0;
         var _loc2_:uint = 0;
         while(_loc2_ < this.Allarr.length)
         {
            if(this.Allarr[_loc2_].TechId == 101)
            {
               _loc1_.DecreaseMetalConsume = CScienceReader.getInstance().techarr[101][this.Allarr[_loc2_].levelId - 1].DecreaseMetalConsume * 0.01;
               _loc1_.DecreaseHe3Consume = CScienceReader.getInstance().techarr[101][this.Allarr[_loc2_].levelId - 1].DecreaseHe3Consume * 0.01;
               _loc1_.DecreaseMoneyConsume = CScienceReader.getInstance().techarr[101][this.Allarr[_loc2_].levelId - 1].DecreaseMoneyConsume * 0.01;
            }
            else if(this.Allarr[_loc2_].TechId == 102)
            {
               _loc1_.IncreaseBuilding = CScienceReader.getInstance().techarr[102][this.Allarr[_loc2_].levelId - 1].IncreaseBuilding * 0.01;
            }
            else if(this.Allarr[_loc2_].TechId == 106)
            {
               _loc1_.IncreaseMetalOut = CScienceReader.getInstance().techarr[106][this.Allarr[_loc2_].levelId - 1].IncreaseMetalOut * 0.01;
            }
            else if(this.Allarr[_loc2_].TechId == 107)
            {
               _loc1_.IncreaseHe3Out = CScienceReader.getInstance().techarr[107][this.Allarr[_loc2_].levelId - 1].IncreaseHe3Out * 0.01;
            }
            else if(this.Allarr[_loc2_].TechId == 108)
            {
               _loc1_.IncreaseMoneyOut = CScienceReader.getInstance().techarr[108][this.Allarr[_loc2_].levelId - 1].IncreaseMoneyOut * 0.01;
            }
            else if(this.Allarr[_loc2_].TechId == 109)
            {
               _loc1_.IncreaseMetalCapacity = CScienceReader.getInstance().techarr[109][this.Allarr[_loc2_].levelId - 1].IncreaseMetalCapacity;
               _loc1_.IncreaseHe3Capacity = CScienceReader.getInstance().techarr[109][this.Allarr[_loc2_].levelId - 1].IncreaseHe3Capacity;
               _loc1_.IncreaseMoneyCapacity = CScienceReader.getInstance().techarr[109][this.Allarr[_loc2_].levelId - 1].IncreaseMoneyCapacity;
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function CreateShipData() : void
      {
         var _loc1_:uint = 0;
         while(_loc1_ < this.Allarr.length)
         {
            if(this.Allarr[_loc1_].TechId == 103)
            {
               GamePlayer.getInstance().m_speedcreateShipTime = CScienceReader.getInstance().techarr[103][this.Allarr[_loc1_].levelId - 1].IncreaseShipBuild;
            }
            else if(this.Allarr[_loc1_].TechId == 104)
            {
               GamePlayer.getInstance().m_DecreaseShipMetalConsume = CScienceReader.getInstance().techarr[104][this.Allarr[_loc1_].levelId - 1].DecreaseShipMetalConsume;
               GamePlayer.getInstance().m_DecreaseShipHe3Consume = CScienceReader.getInstance().techarr[104][this.Allarr[_loc1_].levelId - 1].DecreaseShipHe3Consume;
               GamePlayer.getInstance().m_DecreaseShipMoneyConsume = CScienceReader.getInstance().techarr[104][this.Allarr[_loc1_].levelId - 1].DecreaseShipMoneyConsume;
            }
            _loc1_++;
         }
      }
      
      public function GetScienceData(param1:int) : void
      {
         GamePlayer.getInstance().ScienceOjbect.LowCubage = 0;
         GamePlayer.getInstance().ScienceOjbect.LowCubage = 0;
         GamePlayer.getInstance().ScienceOjbect.Hit = 0;
         GamePlayer.getInstance().ScienceOjbect.BoostCarry = 0;
         GamePlayer.getInstance().ScienceOjbect.DecBackfill = 0;
         GamePlayer.getInstance().ScienceOjbect.DecHes = 0;
         GamePlayer.getInstance().ScienceOjbect.Shield = 0;
         GamePlayer.getInstance().ScienceOjbect.Endure = 0;
         GamePlayer.getInstance().ScienceOjbect.Yare = 0;
         GamePlayer.getInstance().ScienceOjbect.Turn = 0;
         GamePlayer.getInstance().ScienceOjbect.DecHeadoff = 0;
         var _loc2_:uint = 0;
         while(_loc2_ < this.Allarr.length)
         {
            if(this.Allarr[_loc2_].TechId == param1)
            {
               if(param1 < 64)
               {
                  GamePlayer.getInstance().ScienceOjbect.LowCubage = CScienceReader.getInstance().weaponarr[param1][this.Allarr[_loc2_].levelId - 1].LowCubage;
                  GamePlayer.getInstance().ScienceOjbect.Hit = CScienceReader.getInstance().weaponarr[param1][this.Allarr[_loc2_].levelId - 1].Hit;
                  GamePlayer.getInstance().ScienceOjbect.BoostCarry = CScienceReader.getInstance().weaponarr[param1][this.Allarr[_loc2_].levelId - 1].BoostCarry;
                  GamePlayer.getInstance().ScienceOjbect.DecBackfill = CScienceReader.getInstance().weaponarr[param1][this.Allarr[_loc2_].levelId - 1].DecBackfill;
                  GamePlayer.getInstance().ScienceOjbect.DecHes = CScienceReader.getInstance().weaponarr[param1][this.Allarr[_loc2_].levelId - 1].DecHes;
                  GamePlayer.getInstance().ScienceOjbect.Turn = CScienceReader.getInstance().weaponarr[param1][this.Allarr[_loc2_].levelId - 1].Turn;
                  GamePlayer.getInstance().ScienceOjbect.DecHeadoff = CScienceReader.getInstance().weaponarr[param1][this.Allarr[_loc2_].levelId - 1].DecHeadoff;
                  break;
               }
               if(param1 >= 70 && param1 <= 97)
               {
                  GamePlayer.getInstance().ScienceOjbect.Shield = CScienceReader.getInstance().defencearr[param1][this.Allarr[_loc2_].levelId - 1].Shield;
                  GamePlayer.getInstance().ScienceOjbect.Endure = CScienceReader.getInstance().defencearr[param1][this.Allarr[_loc2_].levelId - 1].Endure;
                  GamePlayer.getInstance().ScienceOjbect.Yare = CScienceReader.getInstance().defencearr[param1][this.Allarr[_loc2_].levelId - 1].Yare;
               }
               break;
            }
            _loc2_++;
         }
      }
      
      public function read_MSG_RESP_PROPSINFO(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc7_:Object = null;
         var _loc9_:Props = null;
         var _loc10_:uint = 0;
         var _loc4_:MSG_RESP_PROPSINFO = new MSG_RESP_PROPSINFO();
         NetManager.Instance().readObject(_loc4_,param3);
         var _loc5_:Object = new Object();
         var _loc6_:int = 0;
         var _loc8_:uint = 0;
         while(_loc8_ < _loc4_.DataLen)
         {
            _loc9_ = _loc4_.Data[_loc8_] as Props;
            _loc5_ = new Object();
            _loc5_.StorageType = _loc9_.StorageType;
            _loc5_.PropsId = _loc9_.PropsId;
            _loc6_ = _loc9_.PropsNum + _loc9_.PropsLockNum;
            _loc5_.PropsNum = _loc6_;
            _loc5_.LockFlag = 0;
            _loc5_.Reserve = _loc9_.Reserve;
            if(_loc6_ == 1)
            {
               if(_loc9_.PropsNum > _loc9_.PropsLockNum)
               {
                  _loc5_.LockFlag = 0;
               }
               else
               {
                  _loc5_.LockFlag = 1;
               }
               _loc5_.PropsId = _loc9_.PropsId;
               this.DDDHd(_loc9_.StorageType,_loc5_);
            }
            else
            {
               _loc10_ = 0;
               while(_loc10_ < _loc6_)
               {
                  if(_loc10_ == _loc9_.PropsNum - 1)
                  {
                     _loc7_ = new Object();
                     _loc7_.LockFlag = 0;
                     _loc7_.PropsNum = _loc9_.PropsNum;
                     _loc7_.StorageType = _loc9_.StorageType;
                     _loc7_.PropsId = _loc9_.PropsId;
                     _loc7_.Reserve = _loc9_.Reserve;
                     this.DDDHd(_loc9_.StorageType,_loc7_);
                  }
                  else if(_loc10_ == _loc6_ - 1)
                  {
                     _loc7_ = new Object();
                     _loc7_.LockFlag = 1;
                     _loc7_.PropsNum = _loc9_.PropsLockNum;
                     _loc7_.StorageType = _loc9_.StorageType;
                     _loc7_.PropsId = _loc9_.PropsId;
                     _loc7_.Reserve = _loc9_.Reserve;
                     this.DDDHd(_loc9_.StorageType,_loc7_);
                  }
                  _loc10_++;
               }
            }
            _loc8_++;
         }
      }
      
      private function DDDHd(param1:int, param2:Object) : void
      {
         if(param1 == 0)
         {
            this.Packarr.push(param2);
            return;
         }
         this.Juntarr.push(param2);
      }
      
      public function read_MSG_RESP_USEPROPS(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc9_:String = null;
         var _loc10_:Object = null;
         var _loc11_:Object = null;
         var _loc12_:uint = 0;
         var _loc13_:uint = 0;
         var _loc4_:MSG_RESP_USEPROPS = new MSG_RESP_USEPROPS();
         NetManager.Instance().readObject(_loc4_,param3);
         var _loc5_:propsInfo = CPropsReader.getInstance().GetPropsInfo(_loc4_.PropsId);
         if(_loc4_.ErrorCode == 0)
         {
            if(_loc4_.MoveHomeFlag == 1)
            {
               MapRouter.instance.MoveHome(_loc4_.ToGalaxyMapId,_loc4_.ToGalaxyId);
            }
            _loc9_ = "";
            if(_loc5_.PackID == 0)
            {
               _loc9_ = StringManager.getInstance().getMessageString("ItemText10");
            }
            else
            {
               _loc9_ = StringManager.getInstance().getMessageString("ItemText7");
            }
            _loc9_ += "[" + _loc5_.Name + "]";
            CEffectText.getInstance().showEffectText(GameKernel.renderManager.getUI().getContainer(),StringUitl.Trim(_loc9_));
            var _loc6_:uint = 0;
            while(_loc6_ < this.Packarr.length)
            {
               if(this.Packarr[_loc6_].PropsId == _loc4_.PropsId && this.Packarr[_loc6_].LockFlag == _loc4_.LockFlag)
               {
                  this.Packarr[_loc6_].PropsNum -= _loc4_.Num;
                  if(this.Packarr[_loc6_].PropsNum == 0)
                  {
                     this.Packarr.splice(_loc6_,1);
                  }
               }
               _loc6_++;
            }
            if(_loc4_.PropsId == 905 || _loc4_.PropsId == 906 || _loc4_.PropsId == 907 || _loc4_.PropsId == 930)
            {
               ConstructionAction.getInstance().sendPlayerResource();
            }
            else if(_loc4_.PropsId == 900)
            {
               GamePlayer.getInstance().constructionQueueOpenNum = 3;
            }
            else if(_loc4_.PropsId == 927)
            {
               PlayerInfoUI.getInstance().resetPlayerSp(_loc4_.SpValue);
            }
            else if(_loc4_.PropsId == 931)
            {
               GamePlayer.getInstance().Badge = GamePlayer.getInstance().Badge + _loc4_.AwardBadge;
            }
            else if(_loc4_.PropsId == 934)
            {
               GamePlayer.getInstance().Honor = GamePlayer.getInstance().Honor + _loc4_.AwardHonor;
            }
            if(_loc4_.AwardFlag == 1)
            {
               if(!this.yutiaojian)
               {
                  PackUi.getInstance().Bralock(false);
               }
               if(this.Mallbo)
               {
                  MallgoodsPopup.getInstance().Init();
               }
               this.Mallbo = false;
               GameKernel.popUpDisplayManager.Show(MallgoodsPopup.getInstance());
               _loc11_ = new Object();
               _loc11_.len = _loc4_.AwardPropsLen;
               _loc11_.arr = _loc4_.AwardPropsId;
               _loc11_.gas = _loc4_.AwardGas;
               _loc11_.mony = _loc4_.AwardMoney;
               _loc11_.metal = _loc4_.AwardMetal;
               _loc11_.num = _loc4_.AwardPropsNum;
               _loc11_.AwardCoins = _loc4_.AwardCoins;
               _loc11_.AwardBadge = _loc4_.AwardBadge;
               _loc11_.AwardHonor = _loc4_.AwardHonor;
               _loc11_.AwardActiveCredit = _loc4_.AwardActiveCredit;
               _loc11_.PirateMoney = _loc4_.PirateMoney;
               ConstructionAction.getInstance().addResource(_loc4_.AwardGas,_loc4_.AwardMetal,_loc4_.AwardMoney);
               GamePlayer.getInstance().coins = GamePlayer.getInstance().coins + _loc4_.AwardCoins;
               MallgoodsPopup.getInstance().pdd(_loc11_);
               if(_loc4_.AwardPropsLen > 0)
               {
                  _loc12_ = 0;
                  while(_loc12_ < _loc4_.AwardPropsLen)
                  {
                     if(this.Packarr.length == 0)
                     {
                        _loc10_ = new Object();
                        _loc10_.StorageType = 0;
                        _loc10_.PropsId = _loc4_.AwardPropsId[_loc12_];
                        _loc10_.PropsNum = _loc4_.AwardPropsNum[_loc12_];
                        _loc10_.LockFlag = _loc4_.AwardLockFlag;
                        this.Packarr.push(_loc10_);
                     }
                     else
                     {
                        _loc13_ = 0;
                        while(_loc13_ < this.Packarr.length)
                        {
                           if(_loc4_.AwardPropsId[_loc12_] == this.Packarr[_loc13_].PropsId && this.Packarr[_loc13_].LockFlag == _loc4_.AwardLockFlag)
                           {
                              this.Packarr[_loc13_].PropsNum += _loc4_.AwardPropsNum[_loc12_];
                              break;
                           }
                           if(_loc13_ >= int(this.Packarr.length) - 1)
                           {
                              _loc10_ = new Object();
                              _loc10_.StorageType = 0;
                              _loc10_.PropsId = _loc4_.AwardPropsId[_loc12_];
                              _loc10_.PropsNum = _loc4_.AwardPropsNum[_loc12_];
                              _loc10_.LockFlag = _loc4_.AwardLockFlag;
                              this.Packarr.push(_loc10_);
                              break;
                           }
                           _loc13_++;
                        }
                     }
                     _loc12_++;
                  }
               }
            }
            var _loc7_:int = _loc5_.ShipBodyID;
            var _loc8_:int = _loc5_.ShipPartID;
            ShipmodelRouter.instance.AddBodyPart(_loc7_,_loc8_);
            PackUi.getInstance().updateuseHd();
            return;
         }
         if(_instance == null)
         {
            PackUi.getInstance();
         }
         PackUi.getInstance().Usefalse();
         if(_loc4_.MoveHomeFlag == 1)
         {
            if(_loc4_.ErrorCode == 1)
            {
               CEffectText.getInstance().showEffectText(GameKernel.renderManager.getUI().getContainer(),StringManager.getInstance().getMessageString("StarText20"));
            }
            else if(_loc4_.ErrorCode == 2)
            {
               CEffectText.getInstance().showEffectText(GameKernel.renderManager.getUI().getContainer(),StringManager.getInstance().getMessageString("StarText21"));
            }
            else if(_loc4_.ErrorCode == 3)
            {
               CEffectText.getInstance().showEffectText(GameKernel.renderManager.getUI().getContainer(),StringManager.getInstance().getMessageString("StarText22"));
            }
         }
         else if(_loc4_.PropsId == 927)
         {
            CEffectText.getInstance().showEffectText(GameKernel.renderManager.getUI().getContainer(),StringManager.getInstance().getMessageString("ItemText13"));
         }
         else
         {
            CEffectText.getInstance().showEffectText(GameKernel.renderManager.getUI().getContainer(),StringManager.getInstance().getMessageString("StarText23"));
         }
      }
      
      public function read_MSG_RESP_DELETEPROPS(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_DELETEPROPS = new MSG_RESP_DELETEPROPS();
         NetManager.Instance().readObject(_loc4_,param3);
         var _loc5_:uint = 0;
         while(_loc5_ < this.Packarr.length)
         {
            if(this.Packarr[_loc5_].PropsId == _loc4_.PropsId && this.Packarr[_loc5_].LockFlag == _loc4_.LockFlag)
            {
               --this.Packarr[_loc5_].PropsNum;
               if(this.Packarr[_loc5_].PropsNum == 0)
               {
                  this.Packarr.splice(_loc5_,1);
               }
            }
            _loc5_++;
         }
         PackUi.getInstance().updateuseHd();
      }
      
      public function read_MSG_RESP_ADDPACK(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_ADDPACK = new MSG_RESP_ADDPACK();
         NetManager.Instance().readObject(_loc4_,param3);
         ConstructionAction.getInstance().costResource(0,0,GamePlayer.getInstance().AddPackMoney,0);
         GamePlayer.getInstance().PropsPack = _loc4_.PropsPack;
         PackUi.getInstance().addHd();
      }
      
      public function read_MSG_RESP_PROPSMOVE(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc4_:MSG_RESP_PROPSMOVE = new MSG_RESP_PROPSMOVE();
         NetManager.Instance().readObject(_loc4_,param3);
         var _loc5_:Object = new Object();
         var _loc6_:int = _loc4_.Type;
         if(_loc4_.Type == 0)
         {
            _loc7_ = 0;
            while(_loc7_ < this.Packarr.length)
            {
               if(this.Packarr[_loc7_].PropsId == _loc4_.PropsId && this.Packarr[_loc7_].LockFlag == _loc4_.LockFlag)
               {
                  if(this.Juntarr.length > 0)
                  {
                     _loc8_ = 0;
                     while(_loc8_ < this.Juntarr.length)
                     {
                        if(_loc4_.PropsId == this.Juntarr[_loc8_].PropsId && _loc4_.LockFlag == this.Juntarr[_loc8_].LockFlag)
                        {
                           this.Juntarr[_loc8_].PropsNum += _loc4_.PropsNum;
                           this.Packarr[_loc7_].PropsNum -= _loc4_.PropsNum;
                           if(this.Packarr[_loc7_].PropsNum <= 0)
                           {
                              this.Packarr.splice(_loc7_,1);
                           }
                           break;
                        }
                        if(_loc8_ == this.Juntarr.length - 1)
                        {
                           _loc5_.StorageType = 1;
                           _loc5_.PropsId = this.Packarr[_loc7_].PropsId;
                           _loc5_.PropsNum = _loc4_.PropsNum;
                           _loc5_.LockFlag = this.Packarr[_loc7_].LockFlag;
                           _loc5_.Reserve = this.Packarr[_loc7_].Reserve;
                           this.Juntarr.push(_loc5_);
                           this.Packarr[_loc7_].PropsNum -= _loc4_.PropsNum;
                           if(this.Packarr[_loc7_].PropsNum <= 0)
                           {
                              this.Packarr.splice(_loc7_,1);
                           }
                           break;
                        }
                        _loc8_++;
                     }
                  }
                  else
                  {
                     _loc5_.StorageType = 1;
                     _loc5_.PropsId = this.Packarr[_loc7_].PropsId;
                     _loc5_.PropsNum = _loc4_.PropsNum;
                     _loc5_.LockFlag = this.Packarr[_loc7_].LockFlag;
                     _loc5_.Reserve = this.Packarr[_loc7_].Reserve;
                     this.Juntarr.push(_loc5_);
                     this.Packarr[_loc7_].PropsNum -= _loc4_.PropsNum;
                     if(this.Packarr[_loc7_].PropsNum <= 0)
                     {
                        this.Packarr.splice(_loc7_,1);
                     }
                  }
               }
               _loc7_++;
            }
            CEffectText.getInstance().showEffectText(GameKernel.renderManager.getUI().getContainer(),StringManager.getInstance().getMessageString("BagTXT18"));
         }
         else
         {
            _loc9_ = 0;
            while(_loc9_ < this.Juntarr.length)
            {
               if(this.Juntarr[_loc9_].PropsId == _loc4_.PropsId && this.Juntarr[_loc9_].LockFlag == _loc4_.LockFlag)
               {
                  if(this.Packarr.length > 0)
                  {
                     _loc10_ = 0;
                     while(_loc10_ < this.Packarr.length)
                     {
                        if(_loc4_.PropsId == this.Packarr[_loc10_].PropsId && _loc4_.LockFlag == this.Packarr[_loc10_].LockFlag)
                        {
                           this.Packarr[_loc10_].PropsNum += _loc4_.PropsNum;
                           this.Juntarr[_loc9_].PropsNum -= _loc4_.PropsNum;
                           if(this.Juntarr[_loc9_].PropsNum <= 0)
                           {
                              this.Juntarr.splice(_loc9_,1);
                           }
                           break;
                        }
                        if(_loc10_ == this.Packarr.length - 1)
                        {
                           _loc5_.StorageType = 0;
                           _loc5_.PropsId = this.Juntarr[_loc9_].PropsId;
                           _loc5_.PropsNum = _loc4_.PropsNum;
                           _loc5_.LockFlag = this.Juntarr[_loc9_].LockFlag;
                           _loc5_.Reserve = this.Juntarr[_loc9_].Reserve;
                           this.Packarr.push(_loc5_);
                           this.Juntarr[_loc9_].PropsNum -= _loc4_.PropsNum;
                           if(this.Juntarr[_loc9_].PropsNum <= 0)
                           {
                              this.Juntarr.splice(_loc9_,1);
                           }
                           break;
                        }
                        _loc10_++;
                     }
                  }
                  else
                  {
                     _loc5_.StorageType = 0;
                     _loc5_.PropsId = this.Juntarr[_loc9_].PropsId;
                     _loc5_.PropsNum = _loc4_.PropsNum;
                     _loc5_.LockFlag = this.Juntarr[_loc9_].LockFlag;
                     _loc5_.Reserve = this.Juntarr[_loc9_].Reserve;
                     this.Packarr.push(_loc5_);
                     this.Juntarr[_loc9_].PropsNum -= _loc4_.PropsNum;
                     if(this.Juntarr[_loc9_].PropsNum <= 0)
                     {
                        this.Juntarr.splice(_loc9_,1);
                     }
                  }
               }
               _loc9_++;
            }
            CEffectText.getInstance().showEffectText(GameKernel.renderManager.getUI().getContainer(),StringManager.getInstance().getMessageString("BagTXT17"));
         }
         PackUi.getInstance().updateuseHd();
      }
      
      public function read_MSG_RESP_GAINLOTTERY(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc8_:uint = 0;
         var _loc9_:* = null;
         var _loc4_:MSG_RESP_GAINLOTTERY = new MSG_RESP_GAINLOTTERY();
         NetManager.Instance().readObject(_loc4_,param3);
         if(_loc4_.Guid != GamePlayer.getInstance().Guid)
         {
            if(_loc4_.BroFlag == 1 && _loc4_.LotteryId != 9)
            {
               this.lottID = _loc4_.LotteryId;
               this.guid = _loc4_.Guid;
               _loc6_ = _loc4_.Name;
               _loc7_ = "";
               _loc8_ = 0;
               while(_loc8_ < CScienceReader.getInstance().Lotteryarr.length)
               {
                  if(CScienceReader.getInstance().Lotteryarr[_loc8_].OrderID == this.lottID)
                  {
                     _loc7_ = CScienceReader.getInstance().Lotteryarr[_loc8_].Name;
                  }
                  _loc8_++;
               }
               _loc9_ = StringManager.getInstance().getMessageString("MainUITXT38") + "<a href=\'event:" + this.guid + "," + _loc6_ + "\'>" + "[" + _loc6_ + "]" + "</a>" + StringManager.getInstance().getMessageString("MainUITXT39") + "<font color=\'#99FFFF\'>" + "[" + _loc7_ + "]" + "</font>";
               ChatAction.getInstance().appendMsgContent(StringUitl.Trim(_loc9_),ChannelEnum.CHANNEL_SYSTEM,_loc6_);
            }
            return;
         }
         var _loc5_:Object = new Object();
         _loc5_.UserId = _loc4_.UserId;
         _loc5_.Guid = _loc4_.Guid;
         _loc5_.Name = _loc4_.Name;
         _loc5_.Type = _loc4_.Type;
         _loc5_.LotteryId = _loc4_.LotteryId;
         _loc5_.LotteryType = _loc4_.LotteryType;
         _loc5_.PropsId = _loc4_.PropsId;
         _loc5_.Num = _loc4_.Num;
         _loc5_.Coins = _loc4_.Coins;
         _loc5_.Metal = _loc4_.Metal;
         _loc5_.Gas = _loc4_.Gas;
         _loc5_.Money = _loc4_.Money;
         _loc5_.BroFlag = _loc4_.BroFlag;
         _loc5_.LockFlag = _loc4_.LockFlag;
         if(_loc4_.Type == 1)
         {
            ConstructionAction.getInstance().costResource(0,0,0,GamePlayer.getInstance().LotteryCredit);
            GamePlayer.getInstance().LotteryStatus = GamePlayer.getInstance().VipBuffer ? GamePlayer.getInstance().LotteryStatus - 1 : 0;
         }
         else if(_loc4_.Type == 2)
         {
            GamePlayer.getInstance().coins = GamePlayer.getInstance().coins - GamePlayer.getInstance().LotteryCredit;
            GamePlayer.getInstance().LotteryStatus = GamePlayer.getInstance().VipBuffer ? GamePlayer.getInstance().LotteryStatus - 1 : 0;
         }
         LotteryUi.getInstance().readResoutdAndBegin(_loc5_);
         ++GamePlayer.getInstance().LotteryStatus;
      }
      
      private function getPlayerFacebookInfo(param1:FacebookUserInfo) : void
      {
         var _loc3_:String = null;
         var _loc4_:uint = 0;
         var _loc5_:* = null;
         var _loc2_:String = "";
         if(param1 == null)
         {
            return;
         }
         _loc2_ = param1.first_name;
         if(param1.first_name == null)
         {
            _loc2_ = param1.uid.toString();
         }
         _loc3_ = "";
         _loc4_ = 0;
         while(_loc4_ < CScienceReader.getInstance().Lotteryarr.length)
         {
            if(CScienceReader.getInstance().Lotteryarr[_loc4_].OrderID == this.lottID)
            {
               _loc3_ = CScienceReader.getInstance().Lotteryarr[_loc4_].Name;
            }
            _loc4_++;
         }
         _loc2_ = _loc2_.replace("\r","");
         _loc2_ = _loc2_.replace("\n","");
         _loc5_ = StringManager.getInstance().getMessageString("MainUITXT38") + "<a href=\'event:" + this.guid + "," + _loc2_ + "\'>" + "[" + _loc2_ + "]" + "</a>" + StringManager.getInstance().getMessageString("MainUITXT39") + "<font color=\'#99FFFF\'>" + _loc3_ + "</font>";
         ChatAction.getInstance().appendMsgContent(StringUitl.Trim(_loc5_),ChannelEnum.CHANNEL_SYSTEM,_loc2_);
      }
      
      public function read_MSG_RESP_LOTTERYSTATUS(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_LOTTERYSTATUS = new MSG_RESP_LOTTERYSTATUS();
         NetManager.Instance().readObject(_loc4_,param3);
         GamePlayer.getInstance().LotteryStatus = _loc4_.LotteryStatus;
         if(GameDateTaskUI.IsShow)
         {
            GameDateTaskUI.GetInstance().UpdateLottery();
         }
      }
      
      public function read_MSG_RESP_UNBINDCOMMANDERCARD(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_UNBINDCOMMANDERCARD = new MSG_RESP_UNBINDCOMMANDERCARD();
         NetManager.Instance().readObject(_loc4_,param3);
         GamePlayer.getInstance().cash = GamePlayer.getInstance().cash - 100;
         ResPlaneUI.getInstance().updateResPlane();
         var _loc5_:uint = 0;
         while(_loc5_ < this.Packarr.length)
         {
            if(this.Packarr[_loc5_].PropsId == _loc4_.PropsId && this.Packarr[_loc5_].LockFlag == 1)
            {
               --this.Packarr[_loc5_].PropsNum;
               if(this.Packarr[_loc5_].PropsNum == 0)
               {
                  this.Packarr.splice(_loc5_,1);
               }
            }
            _loc5_++;
         }
         UpdateResource.getInstance().AddToPack(_loc4_.PropsId,1,0);
         PackUi.getInstance().updateuseHd();
         MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("Boss44"),0);
      }
   }
}

