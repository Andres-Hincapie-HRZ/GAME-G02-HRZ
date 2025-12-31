package logic.ui
{
   import com.star.frameworks.display.Container;
   import com.star.frameworks.managers.StringManager;
   import com.star.frameworks.utils.CEffectText;
   import com.star.frameworks.utils.HashSet;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import logic.entry.GShipTeam;
   import logic.entry.GamePlayer;
   import logic.entry.HButton;
   import logic.entry.HButtonType;
   import logic.entry.MObject;
   import logic.entry.commander.CommanderInfo;
   import logic.entry.shipmodel.ShipbodyInfo;
   import logic.game.GameKernel;
   import logic.manager.GalaxyShipManager;
   import logic.reader.CShipmodelReader;
   import logic.widget.BufferQueueManager;
   import logic.widget.DataWidget;
   import net.base.NetManager;
   import net.msg.ship.*;
   import net.router.CommanderRouter;
   
   public class ShipTransferUI extends AbstractPopUp
   {
      
      private static var _instance:ShipTransferUI = null;
      
      private var _UI:Container = new Container();
      
      private var _UIElements:HashSet = new HashSet();
      
      private var _pageTxt:TextField;
      
      private var _msg:MSG_RESP_JUMPGALAXYSHIP;
      
      private var _shipTeams:HashSet = new HashSet();
      
      private var _jpTeamsArr:Array = new Array();
      
      private var _allJumpTime:int = 0;
      
      private var _isShow:Boolean = false;
      
      private var MaxShip:int = 0;
      
      private var selCurPage:int = 0;
      
      private var selLastPage:int = 0;
      
      private var selPageSize:int = 9;
      
      private var _DataList:Array;
      
      private var _galaxyShips:Array;
      
      private var _SenderType:int;
      
      public function ShipTransferUI(param1:HHH)
      {
         super();
         setPopUpName("ShipTransferUI");
         this._mc = new MObject("FleetdepartScene",385,326);
         this.initMcElement();
      }
      
      public static function get instance() : ShipTransferUI
      {
         if(_instance == null)
         {
            _instance = new ShipTransferUI(new HHH());
         }
         return _instance;
      }
      
      override public function Init() : void
      {
         this._isShow = true;
         if(GameKernel.popUpDisplayManager.PopDisplayList.ContainsKey(getPopUpName()))
         {
            GameKernel.popUpDisplayManager.Show(instance);
            this.setVisible(true);
            this.InitPage();
            return;
         }
         GameKernel.popUpDisplayManager.Regisger(instance);
         GameKernel.popUpDisplayManager.Show(instance);
         this.setVisible(true);
         this.InitPage();
      }
      
      private function close(param1:MouseEvent = null) : void
      {
         this._shipTeams.removeAll();
         this._jpTeamsArr.splice(0);
         this.InitPage();
         this.Release();
      }
      
      override public function initMcElement() : void
      {
         var _loc1_:HButton = null;
         var _loc2_:MovieClip = null;
         this._pageTxt = _mc.getMC().getChildByName("tf_page") as TextField;
         _loc2_ = this._mc.getMC().getChildByName("btn_close") as MovieClip;
         _loc2_.addEventListener(MouseEvent.CLICK,this.close,false,0,true);
         _loc1_ = new HButton(_loc2_);
         this._UIElements.Put("btn_close",_loc1_);
         _loc2_ = this._mc.getMC().btn_attack as MovieClip;
         _loc2_.addEventListener(MouseEvent.CLICK,this.onClick,false,0,true);
         _loc1_ = new HButton(_loc2_);
         this._UIElements.Put("btn_attack",_loc1_);
         _loc2_ = this._mc.getMC().btn_defense as MovieClip;
         _loc2_.addEventListener(MouseEvent.CLICK,this.onClick,false,0,true);
         _loc1_ = new HButton(_loc2_);
         this._UIElements.Put("btn_defense",_loc1_);
         _loc1_.setVisible(true);
         _loc2_ = this._mc.getMC().btn_alldepart as MovieClip;
         _loc2_.addEventListener(MouseEvent.CLICK,this.onClick,false,0,true);
         _loc1_ = new HButton(_loc2_,HButtonType.SELECT,false,StringManager.getInstance().getMessageString("StarText24"));
         this._UIElements.Put("btn_alldepart",_loc1_);
         _loc1_.setVisible(true);
         if(this._mc.getMC().getChildByName("btn_league") != null)
         {
            _loc2_ = this._mc.getMC().btn_league as MovieClip;
            _loc2_.addEventListener(MouseEvent.CLICK,this.onClick,false,0,true);
            _loc1_ = new HButton(_loc2_,HButtonType.SELECT);
            this._UIElements.Put("btn_league",_loc1_);
            _loc1_.setVisible(false);
         }
         _loc2_ = this._mc.getMC().btn_ensure as MovieClip;
         _loc2_.addEventListener(MouseEvent.CLICK,this.onClick,false,0,true);
         _loc1_ = new HButton(_loc2_,HButtonType.SELECT);
         this._UIElements.Put("btn_ensure",_loc1_);
         _loc1_.setVisible(false);
         if(this._mc.getMC().getChildByName("btn_league") != null)
         {
            _loc2_ = this._mc.getMC().btn_league as MovieClip;
            _loc1_ = new HButton(_loc2_,HButtonType.SELECT);
            this._UIElements.Put("btn_league",_loc1_);
            _loc1_.setVisible(false);
         }
         _loc2_ = this._mc.getMC().btn_unload as MovieClip;
         _loc2_.addEventListener(MouseEvent.CLICK,this.onClick,false,0,true);
         _loc1_ = new HButton(_loc2_,HButtonType.SIMPLE,false,StringManager.getInstance().getMessageString("StarText25"));
         this._UIElements.Put("btn_unload",_loc1_);
         _loc2_ = this._mc.getMC().btn_left as MovieClip;
         _loc2_.addEventListener(MouseEvent.CLICK,this.onClick,false,0,true);
         _loc1_ = new HButton(_loc2_);
         this._UIElements.Put("btn_left",_loc1_);
         _loc2_ = this._mc.getMC().btn_right as MovieClip;
         _loc2_.addEventListener(MouseEvent.CLICK,this.onClick,false,0,true);
         _loc1_ = new HButton(_loc2_);
         this._UIElements.Put("btn_right",_loc1_);
         var _loc3_:int = 0;
         while(_loc3_ < 9)
         {
            _loc2_ = this._mc.getMC().getChildByName("mc_list" + _loc3_) as MovieClip;
            _loc2_.visible = false;
            (_loc2_.getChildByName("mc_color") as MovieClip).gotoAndStop(3);
            _loc2_.addEventListener(MouseEvent.CLICK,this.onDoubleClick,false,0,true);
            _loc1_ = new HButton(_loc2_,HButtonType.SELECT);
            this._UIElements.Put("mc_list" + _loc3_,_loc1_);
            _loc3_++;
         }
      }
      
      private function onDoubleClick(param1:MouseEvent) : void
      {
         var _loc4_:MSG_RESP_JUMPGALAXYSHIP_TEMP = null;
         var _loc5_:* = undefined;
         var _loc6_:MSG_RESP_JUMPGALAXYSHIP_TEMP = null;
         var _loc7_:GShipTeam = null;
         var _loc9_:String = null;
         var _loc10_:String = null;
         var _loc11_:DisplayObjectContainer = null;
         var _loc2_:int = int(String(param1.target.name).split("mc_list")[1]);
         var _loc3_:HButton = this._UIElements.GetValue(param1.target.name);
         _loc4_ = this._shipTeams.GetValue(this._DataList[_loc2_ + this.selCurPage * this.selPageSize]);
         var _loc8_:int = 0;
         while(_loc8_ < this._jpTeamsArr.length)
         {
            _loc6_ = this._jpTeamsArr[_loc8_][1];
            if(_loc6_.ShipTeamId == _loc4_.ShipTeamId)
            {
               this._jpTeamsArr.splice(_loc8_,1);
            }
            _loc8_++;
         }
         if(_loc3_.selsected)
         {
            if(_loc4_.Gas > 0)
            {
               if(this.MaxShip > 0 && this._jpTeamsArr.length >= this.MaxShip)
               {
                  _loc9_ = StringManager.getInstance().getMessageString("Boss143");
                  _loc9_ = _loc9_.replace("@@1",this.MaxShip);
                  MessagePopup.getInstance().Show(_loc9_,0);
                  _loc3_.setSelect(false);
                  return;
               }
               this._jpTeamsArr.push([_loc4_.ShipTeamId,_loc4_]);
            }
            else
            {
               _loc10_ = StringManager.getInstance().getMessageString("BattleTXT10");
               _loc11_ = GameKernel.renderManager.getUI().getContainer();
               CEffectText.getInstance().showEffectText(_loc11_,_loc10_);
               _loc3_.setSelect(false);
            }
         }
         (this._mc.getMC().tf_fleetpage as TextField).text = this._jpTeamsArr.length + "/" + this._shipTeams.Length();
         this.SetAllDepartTime();
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         var _loc4_:MSG_RESP_JUMPGALAXYSHIP_TEMP = null;
         var _loc5_:String = null;
         var _loc2_:int = -1;
         var _loc3_:int = 0;
         switch(param1.currentTarget.name)
         {
            case "btn_left":
               this.frontPage();
               break;
            case "btn_right":
               this.nextPage();
               break;
            case "btn_alldepart":
               this.SetAllDepartTime();
               break;
            case "btn_attack":
               _loc5_ = "";
               if(this._jpTeamsArr.length * 2 <= GamePlayer.getInstance().SpValue)
               {
                  _loc5_ = StringManager.getInstance().getMessageString("ItemText23") + this._jpTeamsArr.length * 2;
                  MessagePopup.getInstance().Show(_loc5_,2,this.fontAttack);
                  break;
               }
               _loc5_ = StringManager.getInstance().getMessageString("VegetableText7");
               MessagePopup.getInstance().Show(_loc5_,1);
               break;
            case "btn_defense":
               if(BufferQueueManager.getInstance().isExists(1))
               {
                  MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("CorpsText49"),2,this.DoDefense);
                  break;
               }
               this.DoDefense();
               this.close();
               TransforingUI.instance.Show();
               break;
            case "btn_ensure":
               this.SendFBData();
               break;
            case "btn_league":
               this.SendGMData();
               break;
            case "btn_unload":
               this.close();
               LoadFleetUI.getInstance().Init();
               GameKernel.popUpDisplayManager.Show(LoadFleetUI.getInstance());
         }
      }
      
      private function fontAttack() : void
      {
         if(BufferQueueManager.getInstance().isExists(1))
         {
            MessagePopup.getInstance().Show(StringManager.getInstance().getMessageString("CorpsText49"),2,this.DoAttack);
         }
         else
         {
            this.DoAttack();
            this.close();
            TransforingUI.instance.Show();
         }
      }
      
      private function DoAttack() : void
      {
         GamePlayer.getInstance().SpValue = GamePlayer.getInstance().SpValue - this._jpTeamsArr.length * 2;
         PlayerInfoUI.getInstance().resetPlayerSp(GamePlayer.getInstance().SpValue);
         this.sendMsg(1,(this._UIElements.Get("btn_alldepart") as HButton).selsected);
      }
      
      private function DoDefense() : void
      {
         this.sendMsg(0,(this._UIElements.Get("btn_alldepart") as HButton).selsected);
      }
      
      private function SetAllDepartTime() : void
      {
         var _loc1_:MSG_RESP_JUMPGALAXYSHIP_TEMP = null;
         var _loc2_:int = 0;
         this._allJumpTime = 0;
         if((this._UIElements.Get("btn_alldepart") as HButton).selsected)
         {
            _loc2_ = 0;
            while(_loc2_ < this._jpTeamsArr.length)
            {
               if(this._jpTeamsArr[_loc2_])
               {
                  _loc1_ = this._jpTeamsArr[_loc2_][1];
                  if(_loc1_.JumpNeedTime > this._allJumpTime)
                  {
                     this._allJumpTime = _loc1_.JumpNeedTime;
                  }
               }
               _loc2_++;
            }
            TextField(this._mc.getMC().getChildByName("tf_fleettime")).text = DataWidget.secondFormatToTime(this._allJumpTime);
         }
         else
         {
            TextField(this._mc.getMC().getChildByName("tf_fleettime")).text = "";
         }
      }
      
      public function InitData(param1:MSG_RESP_JUMPGALAXYSHIP) : void
      {
         var _loc3_:MSG_RESP_JUMPGALAXYSHIP_TEMP = null;
         this._msg = param1;
         switch(this._msg.JumpType)
         {
            case 0:
               (this._UIElements.Get("btn_attack") as HButton).setBtnDisabled(true);
               (this._UIElements.Get("btn_defense") as HButton).setBtnDisabled(false);
               break;
            case 1:
               (this._UIElements.Get("btn_attack") as HButton).setBtnDisabled(false);
               (this._UIElements.Get("btn_defense") as HButton).setBtnDisabled(true);
               break;
            case 2:
               (this._UIElements.Get("btn_attack") as HButton).setBtnDisabled(false);
               (this._UIElements.Get("btn_defense") as HButton).setBtnDisabled(false);
               break;
            case 3:
               (this._UIElements.Get("btn_attack") as HButton).setBtnDisabled(true);
               (this._UIElements.Get("btn_defense") as HButton).setBtnDisabled(true);
         }
         var _loc2_:int = 0;
         while(_loc2_ < param1.DataLen)
         {
            _loc3_ = param1.Data[_loc2_];
            this._shipTeams.Put(_loc3_.ShipTeamId,_loc3_);
            _loc2_++;
         }
         (this._mc.getMC().tf_fleetpage as TextField).text = "0/" + this._shipTeams.Length();
         this.selCurPage = 0;
         this.selLastPage = Math.floor((this._shipTeams.Length() - 1) / this.selPageSize);
         this._pageTxt.text = this.selCurPage + 1 + "/" + (this.selLastPage + 1);
         if(this.selLastPage == 0)
         {
            (this._UIElements.Get("btn_left") as HButton).setBtnDisabled(true);
            (this._UIElements.Get("btn_right") as HButton).setBtnDisabled(true);
         }
         else
         {
            (this._UIElements.Get("btn_right") as HButton).setBtnDisabled(false);
         }
         (this._mc.getMC().tf_sp as TextField).text = GamePlayer.getInstance().SpValue + "";
      }
      
      public function InitData2(param1:MSG_RESP_JUMPGALAXYSHIP) : void
      {
         var _loc2_:Boolean = false;
         var _loc3_:MSG_RESP_JUMPGALAXYSHIP_TEMP = null;
         var _loc5_:MSG_RESP_JUMPGALAXYSHIP_TEMP = null;
         var _loc7_:int = 0;
         this._msg = param1;
         var _loc4_:Array = InstanceUI.instance.selfFBTeamsArr;
         var _loc6_:int = 0;
         while(_loc6_ < param1.DataLen)
         {
            _loc3_ = param1.Data[_loc6_];
            if(_loc4_)
            {
               _loc7_ = 0;
               while(_loc7_ < _loc4_.length)
               {
                  _loc5_ = _loc4_[_loc7_][1];
                  if(_loc5_.ShipTeamId == _loc3_.ShipTeamId)
                  {
                     _loc2_ = true;
                     break;
                  }
                  _loc7_++;
               }
            }
            if(!_loc2_)
            {
               this._shipTeams.Put(_loc3_.ShipTeamId,_loc3_);
            }
            _loc2_ = false;
            _loc6_++;
         }
         (this._mc.getMC().tf_fleetpage as TextField).text = "0/" + this._shipTeams.Length();
         this.selCurPage = 0;
         this.selLastPage = Math.floor((this._shipTeams.Length() - 1) / this.selPageSize);
         if(this.selLastPage == 0)
         {
            (this._UIElements.Get("btn_left") as HButton).setBtnDisabled(true);
            (this._UIElements.Get("btn_right") as HButton).setBtnDisabled(true);
         }
         else
         {
            (this._UIElements.Get("btn_right") as HButton).setBtnDisabled(false);
         }
         (this._mc.getMC().tf_sp as TextField).text = GamePlayer.getInstance().SpValue + "";
      }
      
      private function InitPage() : void
      {
         var _loc1_:HButton = null;
         this.selCurPage = 0;
         this.freshItem();
         if(this.selLastPage < 0)
         {
            this.selLastPage = 0;
         }
         this._pageTxt.text = this.selCurPage + 1 + "/" + (this.selLastPage + 1);
         if(this.selCurPage == 0)
         {
            (this._UIElements.Get("btn_left") as HButton).setBtnDisabled(true);
         }
         if(this.selLastPage <= 0)
         {
            (this._UIElements.Get("btn_right") as HButton).setBtnDisabled(true);
         }
      }
      
      private function frontPage() : void
      {
         if(this.selCurPage == 0)
         {
            return;
         }
         (this._UIElements.Get("btn_left") as HButton).setBtnDisabled(false);
         --this.selCurPage;
         this._pageTxt.text = this.selCurPage + 1 + "/" + (this.selLastPage + 1);
         this.freshItem();
         if(this.selCurPage == 0)
         {
            (this._UIElements.Get("btn_left") as HButton).setBtnDisabled(true);
         }
         if(this.selCurPage != this.selLastPage)
         {
            (this._UIElements.Get("btn_right") as HButton).setBtnDisabled(false);
         }
      }
      
      private function nextPage() : void
      {
         if(this.selCurPage == this.selLastPage)
         {
            return;
         }
         (this._UIElements.Get("btn_right") as HButton).setBtnDisabled(false);
         this.selCurPage += 1;
         this._pageTxt.text = this.selCurPage + 1 + "/" + (this.selLastPage + 1);
         this.freshItem();
         if(this.selCurPage != 0)
         {
            (this._UIElements.Get("btn_left") as HButton).setBtnDisabled(false);
         }
         if(this.selCurPage == this.selLastPage)
         {
            (this._UIElements.Get("btn_right") as HButton).setBtnDisabled(true);
         }
      }
      
      private function freshItem() : void
      {
         var _loc1_:HButton = null;
         var _loc3_:MSG_RESP_JUMPGALAXYSHIP_TEMP = null;
         var _loc4_:GShipTeam = null;
         var _loc5_:int = 0;
         var _loc6_:CommanderInfo = null;
         var _loc7_:int = 0;
         var _loc8_:Bitmap = null;
         var _loc9_:ShipbodyInfo = null;
         var _loc10_:BitmapData = null;
         var _loc11_:Bitmap = null;
         var _loc12_:MovieClip = null;
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         var _loc15_:MSG_RESP_JUMPGALAXYSHIP_TEMP = null;
         this._DataList = this._shipTeams.Keys();
         this._DataList = this._DataList.sort();
         var _loc2_:int = 0;
         while(_loc2_ < this.selPageSize)
         {
            _loc1_ = this._UIElements.GetValue("mc_list" + _loc2_);
            _loc1_.m_movie.visible = false;
            _loc1_.setSelect(false);
            if(_loc1_.m_movie.mc_commanderbase.getChildByName("commanderIcon"))
            {
               _loc1_.m_movie.mc_commanderbase.removeChild(_loc1_.m_movie.mc_commanderbase.getChildByName("commanderIcon"));
            }
            if(_loc1_.m_movie.mc_fleetbase.getChildByName("shipIcon"))
            {
               _loc1_.m_movie.mc_fleetbase.removeChild(_loc1_.m_movie.mc_fleetbase.getChildByName("shipIcon"));
            }
            TextField(_loc1_.m_movie.tf_fleetname).text = "";
            TextField(_loc1_.m_movie.tf_fleetnum).text = "";
            TextField(_loc1_.m_movie.tf_time).text = "";
            TextField(_loc1_.m_movie.tf_num).text = "";
            _loc3_ = this._shipTeams.GetValue(this._DataList[this.selCurPage * this.selPageSize + _loc2_]);
            if(_loc3_)
            {
               _loc4_ = GalaxyShipManager.instance.getShipDatas(_loc3_.ShipTeamId);
               if(_loc4_)
               {
                  _loc4_.GasPercent = _loc3_.GasPercent;
               }
               _loc1_.m_movie.visible = true;
               _loc5_ = 0;
               while(_loc5_ < this._jpTeamsArr.length)
               {
                  _loc14_ = int(this._jpTeamsArr[_loc5_][0]);
                  _loc15_ = this._jpTeamsArr[_loc5_][1];
                  if(_loc3_.ShipTeamId == _loc14_)
                  {
                     _loc1_.setSelect(true);
                  }
                  _loc5_++;
               }
               TextField(_loc1_.m_movie.tf_fleetname).text = _loc3_.TeamName;
               TextField(_loc1_.m_movie.tf_fleetnum).text = _loc3_.ShipNum + "";
               _loc6_ = CommanderRouter.instance.selectCommander(_loc3_.CommanderId);
               _loc7_ = _loc6_.commander_level + 1;
               TextField(_loc1_.m_movie.tf_num).text = _loc7_ + "";
               _loc8_ = CommanderSceneUI.getInstance().CommanderImg(_loc3_.CommanderId);
               _loc8_.name = "commanderIcon";
               MovieClip(_loc1_.m_movie.mc_commanderbase).addChild(_loc8_);
               _loc9_ = CShipmodelReader.getInstance().getShipBodyInfo(_loc3_.BodyId);
               _loc10_ = GameKernel.getTextureInstance(_loc9_.SmallIcon);
               _loc11_ = new Bitmap(_loc10_);
               _loc11_.name = "shipIcon";
               MovieClip(_loc1_.m_movie.mc_fleetbase).addChild(_loc11_);
               TextField(_loc1_.m_movie.tf_time).text = DataWidget.secondFormatToTime(_loc3_.JumpNeedTime);
               _loc12_ = MovieClip(_loc1_.m_movie.mc_color);
               _loc13_ = _loc3_.GasPercent;
               if(_loc13_ > 60)
               {
                  _loc12_.gotoAndStop(3);
               }
               else if(_loc13_ > 30 && _loc13_ < 60)
               {
                  _loc12_.gotoAndStop(2);
               }
               else if(_loc13_ < 30)
               {
                  _loc12_.gotoAndStop(1);
               }
               MovieClip(_loc1_.m_movie.mc_bar).height = _loc12_.height * _loc3_.GasPercent * 0.01;
            }
            _loc2_++;
         }
      }
      
      private function sendMsg(param1:int = 0, param2:Boolean = false) : void
      {
         var _loc4_:MSG_RESP_JUMPGALAXYSHIP_TEMP = null;
         var _loc6_:int = 0;
         var _loc3_:int = 0;
         if(param2)
         {
            _loc6_ = 0;
            while(_loc6_ < this._jpTeamsArr.length)
            {
               _loc4_ = this._jpTeamsArr[_loc6_][1] as MSG_RESP_JUMPGALAXYSHIP_TEMP;
               if(_loc4_)
               {
                  if(_loc4_.JumpNeedTime > _loc3_)
                  {
                     _loc3_ = _loc4_.JumpNeedTime;
                  }
               }
               _loc6_++;
            }
         }
         var _loc5_:MSG_REQUEST_JUMPSHIPTEAM = new MSG_REQUEST_JUMPSHIPTEAM();
         _loc6_ = 0;
         while(_loc6_ < this._jpTeamsArr.length)
         {
            _loc4_ = this._jpTeamsArr[_loc6_][1] as MSG_RESP_JUMPGALAXYSHIP_TEMP;
            if(_loc4_)
            {
               _loc5_.ShipTeamId[_loc5_.DataLen] = _loc4_.ShipTeamId;
               ++_loc5_.DataLen;
               this._shipTeams.Remove(_loc4_.ShipTeamId);
            }
            _loc6_++;
         }
         if(_loc5_.DataLen == 0 || _loc5_.DataLen > _loc5_.ShipTeamId.length)
         {
            return;
         }
         _loc5_.Guid = GamePlayer.getInstance().Guid;
         _loc5_.SeqId = GamePlayer.getInstance().seqID++;
         _loc5_.ToGalaxyId = this._msg.GalaxyId;
         _loc5_.ToGalaxyMapId = this._msg.GalaxyMapId;
         _loc5_.JumpType = param1;
         _loc5_.Type = param2 ? 1 : 0;
         NetManager.Instance().sendObject(_loc5_);
         this._jpTeamsArr.splice(0);
         this.selCurPage = 0;
         this.selLastPage = Math.floor((this._shipTeams.Length() - 1) / this.selPageSize);
         this.InitPage();
      }
      
      public function RequestJumpShips(param1:int, param2:int, param3:int = 0, param4:int = -1, param5:int = 0) : void
      {
         this.close();
         var _loc6_:MSG_REQUEST_JUMPGALAXYSHIP = new MSG_REQUEST_JUMPGALAXYSHIP();
         _loc6_.SeqId = GamePlayer.getInstance().seqID++;
         _loc6_.Guid = GamePlayer.getInstance().Guid;
         _loc6_.Type = param3;
         _loc6_.GalaxyMapId = param2;
         _loc6_.GalaxyId = param1;
         NetManager.Instance().sendObject(_loc6_);
         this._SenderType = param4;
         this.MaxShip = param5;
      }
      
      public function Release(param1:MouseEvent = null) : void
      {
         this._isShow = false;
         GameKernel.popUpDisplayManager.Hide(this);
         this._shipTeams.removeAll();
         this._jpTeamsArr.splice(0);
         TextField(this._mc.getMC().getChildByName("tf_fleettime")).text = "";
         (this._UIElements.Get("btn_alldepart") as HButton).setSelect(false);
         this.freshItem();
      }
      
      public function OpenFB() : void
      {
         this.Init();
         (this._UIElements.Get("btn_defense") as HButton).setVisible(false);
         (this._UIElements.Get("btn_attack") as HButton).setVisible(false);
         (this._UIElements.Get("btn_alldepart") as HButton).setVisible(false);
         (this._UIElements.Get("btn_ensure") as HButton).setVisible(true);
         (this._UIElements.Get("btn_league") as HButton).setVisible(false);
      }
      
      public function OpenST() : void
      {
         this.Init();
         (this._UIElements.Get("btn_defense") as HButton).setVisible(true);
         (this._UIElements.Get("btn_attack") as HButton).setVisible(true);
         (this._UIElements.Get("btn_alldepart") as HButton).setVisible(true);
         (this._UIElements.Get("btn_ensure") as HButton).setVisible(false);
         (this._UIElements.Get("btn_league") as HButton).setVisible(false);
      }
      
      public function OpenGM() : void
      {
         this.Init();
         (this._UIElements.Get("btn_defense") as HButton).setVisible(false);
         (this._UIElements.Get("btn_attack") as HButton).setVisible(false);
         (this._UIElements.Get("btn_alldepart") as HButton).setVisible(false);
         (this._UIElements.Get("btn_ensure") as HButton).setVisible(false);
         (this._UIElements.Get("btn_league") as HButton).setVisible(true);
      }
      
      public function SendFBData(param1:MouseEvent = null) : void
      {
         InstanceUI.instance.receiveData(this._jpTeamsArr);
         this.InitPage();
         this.Release();
      }
      
      public function SendGMData(param1:MouseEvent = null) : void
      {
         if(this._SenderType == 0)
         {
            WrestleUI.getInstance().SetSelectedFleetList(this._jpTeamsArr);
         }
         else if(this._SenderType == 4)
         {
            RaidProps.getInstance().receiveData(this._jpTeamsArr);
         }
         else if(this._SenderType == 5)
         {
            BattlefieldUI.getInstance().receiveData(this._jpTeamsArr);
         }
         else
         {
            GalaxyMatchUI.instance.receiveData(this._jpTeamsArr);
         }
         this.InitPage();
         this.Release();
      }
      
      public function reloadSupply() : void
      {
         this._shipTeams.removeAll();
         this._jpTeamsArr.splice(0);
         this.InitPage();
      }
      
      public function get shipTeams() : HashSet
      {
         return this._shipTeams;
      }
      
      public function set shipTeams(param1:HashSet) : void
      {
         this._shipTeams = param1;
      }
      
      public function get isShow() : Boolean
      {
         return this._isShow;
      }
   }
}

import flash.display.MovieClip;
import flash.display.Sprite;
import logic.game.GameKernel;

class HHH
{
   
   public function HHH()
   {
      super();
   }
}

class JumpTeamItem extends Sprite
{
   
   public var _mc:MovieClip;
   
   public function JumpTeamItem()
   {
      super();
      this._mc = GameKernel.getMovieClipInstance("FleetdepartedMc");
      addChild(this._mc);
   }
}
