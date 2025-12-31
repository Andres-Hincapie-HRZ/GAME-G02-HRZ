package logic.ui.tip
{
   import com.star.frameworks.managers.StringManager;
   import flash.geom.Point;
   import logic.entry.GamePlayer;
   import logic.entry.commander.CommanderInfo;
   import logic.entry.shipmodel.ShipbodyInfo;
   import logic.entry.shipmodel.ShipmodelInfo;
   import logic.entry.shipmodel.ShippartInfo;
   import logic.reader.CShipmodelReader;
   import logic.ui.info.AbstractInfoDecorate;
   import logic.widget.DataWidget;
   import net.base.NetManager;
   import net.msg.commanderMsg.MSG_REQUEST_COMMANDERINFO;
   import net.msg.shipmodelMsg.MSG_REQUEST_ADDSHIPMODELDEL;
   import net.router.CommanderRouter;
   import net.router.ShipmodelRouter;
   
   public class ShipModelInfoTip
   {
      
      private static var instance:ShipModelInfoTip;
      
      private var infoDecorate:AbstractInfoDecorate;
      
      private var CurCommanderId:int;
      
      private var _ShipModelId:int;
      
      private var _LocationPoint:Point;
      
      private var CurCommanderInfo:CommanderInfo;
      
      private var CurShipModleInfo:ShipmodelInfo;
      
      private var CurLocationPoint:Point;
      
      private var CurRequest:Boolean;
      
      public function ShipModelInfoTip()
      {
         super();
         this.infoDecorate = new AbstractInfoDecorate();
         this.infoDecorate.Load("ShipModleInfoTip");
      }
      
      public static function GetInstance() : ShipModelInfoTip
      {
         if(instance == null)
         {
            instance = new ShipModelInfoTip();
         }
         return instance;
      }
      
      public function Hide() : void
      {
         this.CurCommanderId = -1;
         ShipmodelRouter.instance.OnAddShipModel = null;
         this.infoDecorate.Hide();
      }
      
      public function OnAddShipModel() : void
      {
         this.Show(this._ShipModelId,this._LocationPoint);
      }
      
      public function ShowModel(param1:ShipmodelInfo, param2:Point, param3:Boolean = false, param4:int = -1) : void
      {
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc13_:int = 0;
         var _loc16_:String = null;
         var _loc17_:String = null;
         var _loc19_:int = 0;
         var _loc21_:int = 0;
         var _loc22_:ShippartInfo = null;
         this.CurCommanderId = param4;
         if(param4 >= 0)
         {
            this.CurCommanderInfo = CommanderRouter.instance.selectCommander(param4);
            if(this.CurCommanderInfo == null || this.CurCommanderInfo.HasCardLevel == false)
            {
               this.CurShipModleInfo = param1;
               this.CurLocationPoint = param2;
               this.CurRequest = param3;
               this.CurCommanderInfo = null;
               this.RequestCommanderInfo(param4);
            }
         }
         this._LocationPoint = param2;
         var _loc5_:ShipbodyInfo = CShipmodelReader.getInstance().getShipBodyInfo(param1.m_BodyId);
         var _loc6_:int = _loc5_.Locomotivity;
         var _loc7_:int = _loc5_.Endure;
         var _loc8_:int = _loc5_.Shield;
         var _loc11_:Number = _loc5_.Yare;
         var _loc12_:int = 9999;
         var _loc14_:int = _loc5_.TransitionTime;
         var _loc15_:int = _loc5_.ValidNum;
         var _loc18_:int = -1;
         var _loc20_:int = 0;
         while(_loc20_ < param1.m_PartNum)
         {
            _loc21_ = int(param1.m_PartId[_loc20_]);
            _loc22_ = CShipmodelReader.getInstance().getShipPartInfo(_loc21_);
            if(_loc20_ == 0)
            {
               _loc16_ = _loc22_.Name;
               _loc17_ = "";
            }
            else if(_loc18_ != _loc21_)
            {
               _loc17_ += " x " + _loc19_.toString() + "\n";
               _loc16_ += "\n" + _loc22_.Name;
               _loc19_ = 0;
            }
            _loc18_ = ++_loc21_;
            _loc9_ += _loc22_.MinAssault;
            _loc10_ += _loc22_.MaxAssault;
            if(_loc22_.MinRange > 0 && _loc22_.MinRange < _loc12_)
            {
               _loc12_ = _loc22_.MinRange;
            }
            if(_loc22_.MaxRange > 0 && _loc22_.MaxRange > _loc13_)
            {
               _loc13_ = _loc22_.MaxRange;
            }
            _loc6_ += _loc22_.Locomotivity;
            _loc14_ += _loc22_.TransitionTime;
            _loc7_ += _loc22_.Endure;
            _loc11_ += _loc22_.Yare;
            _loc8_ += _loc22_.Shield;
            _loc20_++;
         }
         if(_loc19_ > 0)
         {
            _loc17_ += " x " + _loc19_.toString();
         }
         if(_loc12_ == 9999)
         {
            _loc12_ = 0;
         }
         this.infoDecorate.Update("Name",StringManager.getInstance().getMessageString("MailText17"));
         this.infoDecorate.Update("NameValue",param1.m_ShipName);
         this.infoDecorate.Update("KindName",StringManager.getInstance().getMessageString("DesignText5"));
         this.infoDecorate.Update("KindNameValue",_loc5_.KindName);
         this.infoDecorate.Update("Shield",StringManager.getInstance().getMessageString("DesignText9"));
         this.infoDecorate.Update("ShieldValue",_loc8_.toString());
         this.infoDecorate.Update("Endure",StringManager.getInstance().getMessageString("DesignText8"));
         this.infoDecorate.Update("EndureValue",_loc7_.toString());
         this.infoDecorate.Update("Assault",StringManager.getInstance().getMessageString("FormationText18"));
         this.infoDecorate.Update("AssaultValue",_loc9_ + "-" + _loc10_);
         this.infoDecorate.Update("Locomotivity",StringManager.getInstance().getMessageString("DesignText6"));
         this.infoDecorate.Update("LocomotivityValue",_loc6_.toString());
         this.infoDecorate.Update("Yare",StringManager.getInstance().getMessageString("FormationText19"));
         this.infoDecorate.Update("YareValue",_loc11_.toString());
         this.infoDecorate.Update("Range",StringManager.getInstance().getMessageString("Text1"));
         this.infoDecorate.Update("RangeValue",_loc12_ + "-" + _loc13_);
         this.infoDecorate.Update("TransitionTime",StringManager.getInstance().getMessageString("FormationText20"));
         this.infoDecorate.Update("TransitionTimeValue",DataWidget.GetTimeString(_loc14_));
         this.infoDecorate.Update("ValidNum",StringManager.getInstance().getMessageString("FormationText21"));
         this.infoDecorate.Update("ValidNumValue",_loc15_.toString());
         this.infoDecorate.Update("ShipInfo",_loc16_);
         this.infoDecorate.Update("ShipInfoNum",_loc17_);
         this.infoDecorate.putDecorate();
         this.infoDecorate.Show(param2.x,param2.y);
      }
      
      public function Show(param1:int, param2:Point, param3:Boolean = false) : void
      {
         var _loc5_:MSG_REQUEST_ADDSHIPMODELDEL = null;
         this._ShipModelId = param1;
         this._LocationPoint = param2;
         ShipmodelRouter.instance.OnAddShipModel = null;
         var _loc4_:ShipmodelInfo = ShipmodelRouter.instance.ShipModeList.Get(param1);
         if(_loc4_ == null)
         {
            if(param3)
            {
               ShipmodelRouter.instance.OnAddShipModel = this.OnAddShipModel;
               _loc5_ = new MSG_REQUEST_ADDSHIPMODELDEL();
               _loc5_.ShipModelId = param1;
               _loc5_.SeqId = GamePlayer.getInstance().seqID++;
               _loc5_.Guid = GamePlayer.getInstance().Guid;
               NetManager.Instance().sendObject(_loc5_);
            }
            return;
         }
         this.ShowModel(_loc4_,param2,param3);
      }
      
      private function RequestCommanderInfo(param1:int) : void
      {
         var _loc2_:MSG_REQUEST_COMMANDERINFO = new MSG_REQUEST_COMMANDERINFO();
         _loc2_.ShowType = 4;
         _loc2_.CommanderId = param1;
         _loc2_.SeqId = GamePlayer.getInstance().seqID++;
         _loc2_.Guid = GamePlayer.getInstance().Guid;
         NetManager.Instance().sendObject(_loc2_);
      }
      
      public function RespCommanderInfo(param1:CommanderInfo) : void
      {
         if(this.CurCommanderId != param1.commander_commanderId)
         {
            return;
         }
         this.ShowModel(this.CurShipModleInfo,this.CurLocationPoint,this.CurRequest,this.CurCommanderId);
      }
   }
}

