package net.router
{
   import com.star.frameworks.managers.StringManager;
   import flash.geom.Point;
   import flash.utils.ByteArray;
   import logic.action.ChatAction;
   import logic.action.ConstructionAction;
   import logic.entry.ChannelEnum;
   import logic.entry.GamePlayer;
   import logic.entry.ScienceSystem;
   import logic.manager.GalaxyManager;
   import logic.reader.CorpsPirateReader;
   import logic.ui.CorpsListUI;
   import logic.ui.EnjoyUi;
   import logic.ui.LoserPopUI;
   import logic.ui.MessagePopup;
   import logic.ui.MyCorpsUI;
   import logic.ui.MyCorpsUI_Defense;
   import logic.ui.MyCorpsUI_Demesne;
   import logic.ui.MyCorpsUI_EquipmentManage;
   import logic.ui.MyCorpsUI_Garrison;
   import logic.ui.MyCorpsUI_Mall;
   import logic.ui.MyCorpsUI_Matterlist;
   import logic.ui.MyCorpsUI_Offer;
   import logic.ui.MyCorpsUI_Pirate;
   import logic.ui.MyCorpsUI_Recruit;
   import logic.ui.MyCorpsUI_Upgrade;
   import logic.ui.PackUi;
   import net.base.NetManager;
   import net.msg.corpsMsg.MSG_RESP_CONSORTIAATTACKINFO;
   import net.msg.corpsMsg.MSG_RESP_CONSORTIAAUTHUSER;
   import net.msg.corpsMsg.MSG_RESP_CONSORTIABUYGOODS;
   import net.msg.corpsMsg.MSG_RESP_CONSORTIAEVENT;
   import net.msg.corpsMsg.MSG_RESP_CONSORTIAFIELD;
   import net.msg.corpsMsg.MSG_RESP_CONSORTIAGIVEN;
   import net.msg.corpsMsg.MSG_RESP_CONSORTIAINFO;
   import net.msg.corpsMsg.MSG_RESP_CONSORTIAMEMBER;
   import net.msg.corpsMsg.MSG_RESP_CONSORTIAMYSELF;
   import net.msg.corpsMsg.MSG_RESP_CONSORTIAPIRATEBRO;
   import net.msg.corpsMsg.MSG_RESP_CONSORTIAPIRATECHOOSE;
   import net.msg.corpsMsg.MSG_RESP_CONSORTIAPROCLAIM;
   import net.msg.corpsMsg.MSG_RESP_CONSORTIATHROWRANK;
   import net.msg.corpsMsg.MSG_RESP_CONSORTIATHROWVALUE;
   import net.msg.corpsMsg.MSG_RESP_CONSORTIAUPDATAVALUE;
   import net.msg.corpsMsg.MSG_RESP_CONSORTIAUPGRADE;
   import net.msg.corpsMsg.MSG_RESP_CONSORTIAUPGRADECANCEL;
   import net.msg.corpsMsg.MSG_RESP_CONSORTIAUPGRADECOMPLETE;
   import net.msg.corpsMsg.MSG_RESP_CREATECONSORTIA;
   import net.msg.corpsMsg.MSG_RESP_DEALCONSORTIAAUTHUSER;
   import net.msg.corpsMsg.MSG_RESP_GOTORESOURCESTAR;
   import net.msg.corpsMsg.MSG_RESP_INSERTFLAGCONSORTIAIMEMBER;
   import net.msg.corpsMsg.MSG_RESP_JOINCONSORTIA;
   import net.msg.corpsMsg.MSG_RESP_OPERATECONSORTIABRO;
   
   public class CorpsRouter
   {
      
      private static var _instance:CorpsRouter;
      
      public function CorpsRouter()
      {
         super();
      }
      
      public static function get instance() : CorpsRouter
      {
         if(_instance == null)
         {
            _instance = new CorpsRouter();
         }
         return _instance;
      }
      
      public function resp_MSG_RESP_CONSORTIAINFO(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_CONSORTIAINFO = new MSG_RESP_CONSORTIAINFO();
         NetManager.Instance().readObject(_loc4_,param3);
         CorpsListUI.getInstance().RespCorpsList(_loc4_);
      }
      
      public function resp_MSG_RESP_CONSORTIAPROCLAIM(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_CONSORTIAPROCLAIM = new MSG_RESP_CONSORTIAPROCLAIM();
         NetManager.Instance().readObject(_loc4_,param3);
         CorpsListUI.getInstance().RespCorpsInfo(_loc4_);
      }
      
      public function resp_MSG_RESP_CREATECONSORTIA(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc5_:int = 0;
         var _loc6_:String = null;
         var _loc4_:MSG_RESP_CREATECONSORTIA = new MSG_RESP_CREATECONSORTIA();
         NetManager.Instance().readObject(_loc4_,param3);
         if(_loc4_.ErrorCode == 0)
         {
            GamePlayer.getInstance().consortiaId = _loc4_.ConsortiaId;
            GamePlayer.getInstance().ConsortiaJob = 1;
            GamePlayer.getInstance().PropsCorpsPack = _loc4_.PropsCorpsPack;
            CorpsListUI.getInstance().ResetShow();
            _loc5_ = 0;
            while(_loc5_ < ScienceSystem.getinstance().Packarr.length)
            {
               if(ScienceSystem.getinstance().Packarr[_loc5_].PropsId == 922 && ScienceSystem.getinstance().Packarr[_loc5_].LockFlag == _loc4_.LockFlag)
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
            EnjoyUi.getInstance().PublishMessage(StringManager.getInstance().getMessageString("EmailText33"),StringManager.getInstance().getMessageString("EmailText19"),StringManager.getInstance().getMessageString("EmailText20"),"KingCard",StringManager.getInstance().getMessageString("Boss11"));
         }
         else
         {
            if(_loc4_.ErrorCode == 1)
            {
               _loc6_ = StringManager.getInstance().getMessageString("CorpsText29");
            }
            else if(_loc4_.ErrorCode == 2)
            {
               _loc6_ = StringManager.getInstance().getMessageString("CorpsText30");
            }
            else
            {
               _loc6_ = StringManager.getInstance().getMessageString("CorpsText31");
            }
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("CorpsText32") + _loc6_,0);
         }
      }
      
      public function resp_MSG_RESP_JOINCONSORTIA(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_JOINCONSORTIA = new MSG_RESP_JOINCONSORTIA();
         NetManager.Instance().readObject(_loc4_,param3);
         if(_loc4_.ErrorCode == 0)
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("CorpsText33"),0);
         }
         else if(_loc4_.ErrorCode == 1)
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("CorpsText34"),0);
         }
         else
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("CorpsText35"),0);
         }
      }
      
      public function resp_MSG_RESP_CONSORTIAMYSELF(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_CONSORTIAMYSELF = new MSG_RESP_CONSORTIAMYSELF();
         NetManager.Instance().readObject(_loc4_,param3);
         MyCorpsUI.getInstance().ShowCorpsInfo(_loc4_);
      }
      
      public function resp_MSG_RESP_CONSORTIAMEMBER(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_CONSORTIAMEMBER = new MSG_RESP_CONSORTIAMEMBER();
         NetManager.Instance().readObject(_loc4_,param3);
         MyCorpsUI.getInstance().ShowMyCorpsMemberList(_loc4_);
      }
      
      public function resp_MSG_RESP_CONSORTIAAUTHUSER(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_CONSORTIAAUTHUSER = new MSG_RESP_CONSORTIAAUTHUSER();
         NetManager.Instance().readObject(_loc4_,param3);
         MyCorpsUI_Recruit.getInstance().RespRecruitList(_loc4_);
      }
      
      public function resp_MSG_RESP_OPERATECONSORTIABRO(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_OPERATECONSORTIABRO = new MSG_RESP_OPERATECONSORTIABRO();
         NetManager.Instance().readObject(_loc4_,param3);
         if(_loc4_.Type == 1)
         {
            GamePlayer.getInstance().consortiaId = -1;
            GamePlayer.getInstance().ConsortiaJob = 0;
            GamePlayer.getInstance().PropsCorpsPack = 0;
            PackUi.getInstance().closeHd(0,false);
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("CorpsText36"),1);
         }
         else if(_loc4_.Type == 0)
         {
            GamePlayer.getInstance().consortiaId = _loc4_.ConsortiaId;
            GamePlayer.getInstance().ConsortiaJob = _loc4_.Job;
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("CorpsText37"),1);
         }
         else if(_loc4_.Type == 2)
         {
            GamePlayer.getInstance().consortiaId = _loc4_.ConsortiaId;
            GamePlayer.getInstance().ConsortiaJob = _loc4_.Job;
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("CorpsText38"),1);
         }
         GamePlayer.getInstance().PropsCorpsPack = _loc4_.PropsCorpsPack;
         GamePlayer.getInstance().ConsortiaUnionLevel = _loc4_.UnionLevel;
         GamePlayer.getInstance().ConsortiaUnionValue = _loc4_.NeedUnionValue;
         GamePlayer.getInstance().ConsortiaShopValue = _loc4_.NeedShopValue;
         GamePlayer.getInstance().ConsortiaShopLevel = _loc4_.ShopLevel;
      }
      
      public function resp_MSG_RESP_CONSORTIAFIELD(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_CONSORTIAFIELD = new MSG_RESP_CONSORTIAFIELD();
         NetManager.Instance().readObject(_loc4_,param3);
         MyCorpsUI_Demesne.getInstance().RespDemesneList(_loc4_);
      }
      
      public function resp_MSG_RESP_CONSORTIATHROWVALUE(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_CONSORTIATHROWVALUE = new MSG_RESP_CONSORTIATHROWVALUE();
         NetManager.Instance().readObject(_loc4_,param3);
         switch(_loc4_.Type)
         {
            case 0:
               ConstructionAction.getInstance().costResource(0,0,0,_loc4_.Value);
               break;
            case 1:
               ConstructionAction.getInstance().costResource(0,0,_loc4_.Value,0);
               break;
            case 2:
               ConstructionAction.getInstance().costResource(0,_loc4_.Value,0,0);
               break;
            case 3:
               ConstructionAction.getInstance().costResource(_loc4_.Value,0,0,0);
         }
         MyCorpsUI_Offer.getInstance().RespOffer();
      }
      
      public function resp_MSG_RESP_CONSORTIATHROWRANK(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_CONSORTIATHROWRANK = new MSG_RESP_CONSORTIATHROWRANK();
         NetManager.Instance().readObject(_loc4_,param3);
         MyCorpsUI_Offer.getInstance().RespOfferList(_loc4_);
      }
      
      public function resp_MSG_RESP_CONSORTIAGIVEN(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_CONSORTIAGIVEN = new MSG_RESP_CONSORTIAGIVEN();
         NetManager.Instance().readObject(_loc4_,param3);
         if(_loc4_.ErrorCode == 0)
         {
            GamePlayer.getInstance().ConsortiaJob = 0;
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("CorpsText39"),0);
         }
         else if(_loc4_.ErrorCode == 1)
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("CorpsText40"),0);
         }
      }
      
      public function resp_MSG_RESP_CONSORTIAUPGRADE(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_CONSORTIAUPGRADE = new MSG_RESP_CONSORTIAUPGRADE();
         NetManager.Instance().readObject(_loc4_,param3);
         MyCorpsUI_Upgrade.getInstance().RespUpgrade(_loc4_);
         MyCorpsUI.getInstance().RespUpgrade(_loc4_);
      }
      
      public function resp_MSG_RESP_CONSORTIAUPGRADECANCEL(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_CONSORTIAUPGRADECANCEL = new MSG_RESP_CONSORTIAUPGRADECANCEL();
         NetManager.Instance().readObject(_loc4_,param3);
         MyCorpsUI_Upgrade.getInstance().RespUpgradeCancel(_loc4_);
         MyCorpsUI.getInstance().RespUpgradeCancel(_loc4_);
      }
      
      public function resp_MSG_RESP_CONSORTIAUPGRADECOMPLETE(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_CONSORTIAUPGRADECOMPLETE = new MSG_RESP_CONSORTIAUPGRADECOMPLETE();
         NetManager.Instance().readObject(_loc4_,param3);
         if(_loc4_.Type == 0)
         {
            MyCorpsUI_Upgrade.getInstance().RespCorpsUpgrade();
            MyCorpsUI.getInstance().Refresh();
         }
         else if(_loc4_.Type == 1)
         {
            MyCorpsUI_Upgrade.getInstance().RespCorpsStorageUpgrade();
            MyCorpsUI.getInstance().Refresh();
         }
         else if(_loc4_.Type == 2)
         {
            MyCorpsUI_Upgrade.getInstance().RespComposeUpgrade();
            MyCorpsUI.getInstance().Refresh();
         }
         else if(_loc4_.Type == 3)
         {
            MyCorpsUI_Upgrade.getInstance().RespShopUpgrade();
            MyCorpsUI.getInstance().Refresh();
         }
         GamePlayer.getInstance().PropsCorpsPack = _loc4_.PropsCorpsPack;
         GamePlayer.getInstance().ConsortiaUnionLevel = _loc4_.UnionLevel;
         GamePlayer.getInstance().ConsortiaShopLevel = _loc4_.ShopLevel;
      }
      
      public function Resp_MSG_RESP_GOTORESOURCESTAR(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_GOTORESOURCESTAR = new MSG_RESP_GOTORESOURCESTAR();
         NetManager.Instance().readObject(_loc4_,param3);
         MyCorpsUI_Garrison.getInstance().Resp_MSG_RESP_GOTORESOURCESTAR(_loc4_);
      }
      
      public function resp_MSG_RESP_DEALCONSORTIAAUTHUSER(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_DEALCONSORTIAAUTHUSER = new MSG_RESP_DEALCONSORTIAAUTHUSER();
         NetManager.Instance().readObject(_loc4_,param3);
         if(_loc4_.Agree == 1)
         {
            if(_loc4_.ErrorCode == 0)
            {
               MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("CorpsText41"),0);
               MyCorpsUI.getInstance().AddMember();
            }
            else if(_loc4_.ErrorCode == 1)
            {
               MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("CorpsText42"),0);
            }
            else
            {
               MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("Boss121"),0);
            }
         }
         else if(_loc4_.ErrorCode == 0)
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("CorpsText122"),0);
            MyCorpsUI.getInstance().AddMember();
         }
         else
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("CorpsText123"),0);
         }
      }
      
      public function resp_MSG_RESP_CONSORTIAATTACKINFO(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_CONSORTIAATTACKINFO = new MSG_RESP_CONSORTIAATTACKINFO();
         NetManager.Instance().readObject(_loc4_,param3);
         MyCorpsUI_Defense.getInstance().RespDefenseList(_loc4_);
      }
      
      public function resp_MSG_RESP_CONSORTIAUPDATAVALUE(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_CONSORTIAUPDATAVALUE = new MSG_RESP_CONSORTIAUPDATAVALUE();
         NetManager.Instance().readObject(_loc4_,param3);
         MyCorpsUI_EquipmentManage.getInstance().RespUpdateValue(_loc4_);
      }
      
      public function resp_MSG_RESP_CONSORTIABUYGOODS(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_CONSORTIABUYGOODS = new MSG_RESP_CONSORTIABUYGOODS();
         NetManager.Instance().readObject(_loc4_,param3);
         MyCorpsUI_Mall.getInstance().RespBuyGoods(_loc4_);
      }
      
      public function resp_MSG_RESP_CONSORTIAEVENT(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_CONSORTIAEVENT = new MSG_RESP_CONSORTIAEVENT();
         NetManager.Instance().readObject(_loc4_,param3);
         MyCorpsUI_Matterlist.getInstance().RespMatterlist(_loc4_);
      }
      
      public function resp_MSG_RESP_INSERTFLAGCONSORTIAIMEMBER(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_INSERTFLAGCONSORTIAIMEMBER = new MSG_RESP_INSERTFLAGCONSORTIAIMEMBER();
         NetManager.Instance().readObject(_loc4_,param3);
         LoserPopUI.getInstance().RespList(_loc4_);
      }
      
      public function resp_MSG_RESP_CONSORTIAPIRATECHOOSE(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_CONSORTIAPIRATECHOOSE = new MSG_RESP_CONSORTIAPIRATECHOOSE();
         NetManager.Instance().readObject(_loc4_,param3);
         MyCorpsUI_Pirate.getInstance().Resp_MSG_RESP_CONSORTIAPIRATECHOOSE(_loc4_);
      }
      
      public function resp_MSG_RESP_CONSORTIAPIRATEBRO(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc5_:Point = null;
         var _loc6_:* = null;
         var _loc7_:String = null;
         var _loc8_:String = null;
         var _loc4_:MSG_RESP_CONSORTIAPIRATEBRO = new MSG_RESP_CONSORTIAPIRATEBRO();
         NetManager.Instance().readObject(_loc4_,param3);
         if(_loc4_.Flag == 0)
         {
            _loc5_ = GalaxyManager.getStarCoordinate(_loc4_.GalaxyId);
            _loc6_ = "<font color=\'#FF9999\'><a href=\'event:CorpsName," + _loc4_.ConsortiaId + "\'>[" + _loc4_.ConsortiaName + "]</a></font><font color=\'#00FF00\'><a href=\'event:GalaxyFigth#" + _loc4_.GalaxyId + "\'>[" + _loc5_.x + "," + _loc5_.y + "]</a></font>";
            _loc7_ = StringManager.getInstance().getMessageString("Pirate07");
            _loc8_ = " Lv." + int(_loc4_.PirateLevelId + 1) + " " + CorpsPirateReader.GetPirateInfo(_loc4_.PirateLevelId).@Name;
            if(_loc4_.PirateLevelId < 2)
            {
               _loc7_ = _loc7_.replace("@@1",StringManager.getInstance().getMessageString("Pirate08") + _loc8_);
            }
            else if(_loc4_.PirateLevelId < 5)
            {
               _loc7_ = _loc7_.replace("@@1",StringManager.getInstance().getMessageString("Pirate09") + _loc8_);
            }
            else
            {
               _loc7_ = _loc7_.replace("@@1",StringManager.getInstance().getMessageString("Pirate10") + _loc8_);
            }
            _loc6_ += _loc7_;
            ChatAction.getInstance().appendMsgContent(_loc6_,ChannelEnum.CHANNEL_SYSTEM,_loc4_.ConsortiaName);
         }
      }
   }
}

