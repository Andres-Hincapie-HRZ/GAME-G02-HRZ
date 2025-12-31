package logic.ui
{
   import com.star.frameworks.events.ActionEvent;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.text.TextField;
   import logic.entry.GamePlayer;
   import logic.entry.HButton;
   import logic.entry.MObject;
   import logic.entry.ScienceSystem;
   import logic.game.GameKernel;
   import logic.manager.GameInterActiveManager;
   import logic.reader.CPropsReader;
   import logic.utils.UpdateResource;
   import net.base.NetManager;
   import net.msg.sciencesystem.MSG_REQUEST_USEPROPS;
   import net.router.CommanderRouter;
   
   public class StateHandlingUI extends AbstractPopUp
   {
      
      private static var instance:StateHandlingUI;
      
      private var _close:HButton;
      
      private var _list:MovieClip;
      
      private var _PropsTip:MovieClip;
      
      public var _state:int;
      
      public var _stateAry:Array = new Array();
      
      public var _parent:String;
      
      public var _PicNumAry:Array = new Array();
      
      private var _NameAry:Array = new Array();
      
      public function StateHandlingUI()
      {
         super();
         setPopUpName("StateHandlingUI");
      }
      
      public static function getInstance() : StateHandlingUI
      {
         if(instance == null)
         {
            instance = new StateHandlingUI();
         }
         return instance;
      }
      
      override public function Init() : void
      {
         if(GameKernel.popUpDisplayManager.PopDisplayList.ContainsKey(getPopUpName()))
         {
            return;
         }
         this._mc = new MObject("StorehousePop",400,250);
         this.initMcElement();
         GameKernel.popUpDisplayManager.Regisger(instance);
      }
      
      override public function initMcElement() : void
      {
         var _loc1_:int = 0;
         this._close = new HButton(this._mc.getMC().btn_close);
         GameInterActiveManager.InstallInterActiveEvent(this._close.m_movie,ActionEvent.ACTION_CLICK,this.chickButton);
         while(_loc1_ < 3)
         {
            this._list = this._mc.getMC().getChildByName("mc_list" + _loc1_) as MovieClip;
            this._list.addEventListener(ActionEvent.ACTION_CLICK,this.chicklist);
            this._list.addEventListener(ActionEvent.ACTION_MOUSE_OVER,this.overlist);
            this._list.addEventListener(ActionEvent.ACTION_MOUSE_OUT,this.outlist);
            _loc1_++;
         }
      }
      
      public function setParent(param1:String) : void
      {
         this._parent = param1;
      }
      
      public function getstate(param1:int = -1, param2:int = -1, param3:int = -1) : void
      {
         this._stateAry[0] = param1;
         this._stateAry[1] = param2;
         this._stateAry[2] = param3;
      }
      
      private function chickButton(param1:Event) : void
      {
         if(param1.currentTarget.name == "btn_close")
         {
            if(this._parent == "CommanderSceneUI")
            {
               CommanderSceneUI.getInstance().removeBackMC();
               GameKernel.popUpDisplayManager.Hide(instance);
            }
            else if(this._parent == "ResPlaneUI" || this._parent == "_ResPlaneUI")
            {
               GameKernel.popUpDisplayManager.Hide(instance);
            }
            else if(this._parent == "CreateCorpsUI")
            {
               GameKernel.popUpDisplayManager.Hide(instance);
            }
            else if(this._parent == "ComposeUI")
            {
               GameKernel.popUpDisplayManager.Hide(instance);
            }
            else if(this._parent == InstanceUI.instance.getPopUpName())
            {
               GameKernel.popUpDisplayManager.Hide(instance);
            }
         }
      }
      
      private function overlist(param1:Event) : void
      {
         var _loc4_:MovieClip = null;
         var _loc5_:MovieClip = null;
         var _loc6_:Point = null;
         var _loc2_:String = param1.currentTarget.name;
         _loc2_ = _loc2_.substring(7);
         var _loc3_:int = int(_loc2_);
         if(this._PicNumAry[_loc3_] == 1)
         {
            _loc4_ = this._mc.getMC().getChildByName("mc_list" + _loc3_) as MovieClip;
            _loc4_.gotoAndStop("over");
            _loc5_ = param1.currentTarget as MovieClip;
            _loc6_ = _loc5_.localToGlobal(new Point(0,0));
            _loc6_ = this._mc.getMC().globalToLocal(_loc6_);
            this._PropsTip = PackUi.getInstance().TipHd(_loc6_.x,_loc6_.y,this._stateAry[_loc3_],true);
            this._PropsTip.x += 20;
            this._PropsTip.y -= 20;
            this._mc.getMC().addChild(this._PropsTip);
         }
      }
      
      private function outlist(param1:Event) : void
      {
         var _loc4_:MovieClip = null;
         var _loc2_:String = param1.currentTarget.name;
         _loc2_ = _loc2_.substring(7);
         var _loc3_:int = int(_loc2_);
         if(this._PicNumAry[_loc3_] == 1)
         {
            _loc4_ = this._mc.getMC().getChildByName("mc_list" + _loc3_) as MovieClip;
            _loc4_.gotoAndStop("up");
            if(this._PropsTip != null)
            {
               this._mc.getMC().removeChild(this._PropsTip);
            }
         }
      }
      
      private function chicklist(param1:Event) : void
      {
         var _loc5_:MSG_REQUEST_USEPROPS = null;
         var _loc6_:Boolean = false;
         var _loc7_:MSG_REQUEST_USEPROPS = null;
         var _loc8_:Boolean = false;
         var _loc2_:String = param1.currentTarget.name;
         _loc2_ = _loc2_.substring(7);
         var _loc3_:int = int(_loc2_);
         this._state = this._stateAry[_loc3_];
         if(this._state == -1)
         {
            return;
         }
         var _loc4_:MovieClip = this._mc.getMC().getChildByName("mc_list" + _loc3_) as MovieClip;
         if(uint(TextField(_loc4_.tf_num).text) > 0)
         {
            if(this._parent == "CommanderSceneUI")
            {
               CommanderSceneUI.getInstance().removeBackMC();
               GameKernel.popUpDisplayManager.Hide(instance);
               if(this._state == 903)
               {
                  CommanderRouter.instance.onSendMsgRELIVECOMMANDER(CommanderRouter.instance.m_commandInfoAry[CommanderSceneUI.getInstance().m_choosenum].commander_commanderId);
               }
               else if(this._state == 904)
               {
                  CommanderRouter.instance.onSendMsgRESUMECOMMANDER(CommanderRouter.instance.m_commandInfoAry[CommanderSceneUI.getInstance().m_choosenum].commander_commanderId);
               }
               else if(this._state == 924)
               {
                  CommanderRouter.instance.onSendMsgCLEARCOMMANDERPERCENT(CommanderSceneUI.getInstance().m_commanderInfo.commander_commanderId);
               }
               else if(this._state == 926)
               {
                  CommanderRouter.instance.sendmsgCOMMANDERCHANGECARD(CommanderSceneUI.getInstance().m_commanderInfo.commander_commanderId);
               }
            }
            else if(this._parent == "ResPlaneUI")
            {
               _loc5_ = new MSG_REQUEST_USEPROPS();
               _loc6_ = UpdateResource.getInstance().XiaoLaBaHd(this._state,false);
               ScienceSystem.getinstance().yutiaojian = true;
               if(_loc6_)
               {
                  GameKernel.popUpDisplayManager.Hide(instance);
                  _loc5_.SeqId = GamePlayer.getInstance().seqID++;
                  _loc5_.Guid = GamePlayer.getInstance().Guid;
                  _loc5_.PropsId = this._state;
                  _loc5_.Num = 1;
                  _loc5_.LockFlag = UpdateResource.getInstance().lockflg;
                  NetManager.Instance().sendObject(_loc5_);
               }
            }
            else if(this._parent == "_ResPlaneUI")
            {
               _loc7_ = new MSG_REQUEST_USEPROPS();
               _loc8_ = UpdateResource.getInstance().XiaoLaBaHd(this._state,false);
               ScienceSystem.getinstance().yutiaojian = true;
               if(_loc8_)
               {
                  GameKernel.popUpDisplayManager.Hide(instance);
                  _loc7_.SeqId = GamePlayer.getInstance().seqID++;
                  _loc7_.Guid = GamePlayer.getInstance().Guid;
                  _loc7_.PropsId = this._state;
                  _loc7_.Num = 1;
                  _loc7_.LockFlag = UpdateResource.getInstance().lockflg;
                  NetManager.Instance().sendObject(_loc7_);
               }
               GameKernel.popUpDisplayManager.Hide(instance);
            }
            else if(this._parent == "InstanceUI")
            {
               GameKernel.popUpDisplayManager.Hide(instance);
            }
         }
         else
         {
            GameKernel.popUpDisplayManager.Hide(instance);
            PropsBuyUI.getInstance().Init();
            PropsBuyUI.getInstance().SetState(this._state);
            PropsBuyUI.getInstance().InitPopUp();
            GameKernel.popUpDisplayManager.Show(PropsBuyUI.getInstance());
         }
      }
      
      public function InitPopUp() : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:String = null;
         var _loc4_:Bitmap = null;
         var _loc5_:int = 0;
         var _loc1_:int = 0;
         while(_loc1_ < 3)
         {
            _loc2_ = this._mc.getMC().getChildByName("mc_list" + _loc1_) as MovieClip;
            _loc2_.gotoAndStop("disabled");
            this._PicNumAry[_loc1_] = 0;
            if(_loc2_.mc_base.numChildren > 0)
            {
               _loc2_.mc_base.removeChildAt(0);
               TextField(_loc2_.tf_num).text = "";
            }
            if(this._stateAry[_loc1_] != -1)
            {
               _loc3_ = CPropsReader.getInstance().GetPropsInfo(this._stateAry[_loc1_]).ImageFileName;
               _loc4_ = new Bitmap(GameKernel.getTextureInstance(_loc3_));
               _loc2_.mc_base.addChild(_loc4_);
               this._PicNumAry[_loc1_] = 1;
               _loc2_.gotoAndStop("up");
               if(!UpdateResource.getInstance().pdHd(this._stateAry[_loc1_]))
               {
                  _loc5_ = 0;
               }
               else
               {
                  _loc5_ = UpdateResource.getInstance().fuhuoNum;
               }
               TextField(_loc2_.tf_num).text = String(_loc5_);
            }
            _loc1_++;
         }
      }
   }
}

