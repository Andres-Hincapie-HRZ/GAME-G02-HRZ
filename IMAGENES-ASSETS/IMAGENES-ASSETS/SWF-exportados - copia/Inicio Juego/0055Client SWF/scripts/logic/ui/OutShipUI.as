package logic.ui
{
   import com.star.frameworks.events.ActionEvent;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import logic.entry.HButton;
   import logic.entry.MObject;
   import logic.entry.shipmodel.ShipbodyInfo;
   import logic.game.GameKernel;
   import logic.manager.GameInterActiveManager;
   import logic.reader.CShipmodelReader;
   import net.common.MsgTypes;
   import net.msg.gymkhanaMSg.MSG_RESP_RACINGINFOSHIPTEAM_TEMP;
   import net.router.GymkhanaRouter;
   
   public class OutShipUI extends AbstractPopUp
   {
      
      public static var instance:OutShipUI;
      
      public var shipMCAry:Array = new Array();
      
      public var shipStata:Array = new Array();
      
      public var m_page:int = 0;
      
      public function OutShipUI()
      {
         super();
         setPopUpName("OutShipUI");
      }
      
      public static function getInstance() : OutShipUI
      {
         if(instance == null)
         {
            instance = new OutShipUI();
         }
         return instance;
      }
      
      override public function Init() : void
      {
         if(GameKernel.popUpDisplayManager.PopDisplayList.ContainsKey(getPopUpName()))
         {
            return;
         }
         this._mc = new MObject("FleetdepartScene",385,326);
         GameKernel.popUpDisplayManager.Regisger(instance);
         this.initMcElement();
      }
      
      override public function initMcElement() : void
      {
         var _loc1_:HButton = null;
         var _loc2_:HButton = null;
         var _loc3_:HButton = null;
         var _loc4_:HButton = null;
         _mc.getMC().btn_unload.visible = false;
         _mc.getMC().btn_alldepart.visible = false;
         _mc.getMC().btn_attack.visible = false;
         _mc.getMC().btn_defense.visible = false;
         _mc.getMC().btn_league.visible = false;
         _loc1_ = new HButton(_mc.getMC().btn_close);
         _loc2_ = new HButton(_mc.getMC().btn_ensure);
         _loc3_ = new HButton(_mc.getMC().btn_left);
         _loc4_ = new HButton(_mc.getMC().btn_right);
         GameInterActiveManager.InstallInterActiveEvent(_loc1_.m_movie,ActionEvent.ACTION_CLICK,this.chickButton);
         GameInterActiveManager.InstallInterActiveEvent(_loc2_.m_movie,ActionEvent.ACTION_CLICK,this.chickButton);
         GameInterActiveManager.InstallInterActiveEvent(_loc4_.m_movie,ActionEvent.ACTION_CLICK,this.chickButton);
         GameInterActiveManager.InstallInterActiveEvent(_loc3_.m_movie,ActionEvent.ACTION_CLICK,this.chickButton);
         var _loc5_:int = 0;
         while(_loc5_ < 9)
         {
            this.shipMCAry[_loc5_] = _mc.getMC().getChildByName("mc_list" + _loc5_) as MovieClip;
            (this.shipMCAry[_loc5_] as MovieClip).gotoAndStop(1);
            (this.shipMCAry[_loc5_] as MovieClip).mouseChildren = false;
            (this.shipMCAry[_loc5_] as MovieClip).mouseEnabled = true;
            (this.shipMCAry[_loc5_] as MovieClip).buttonMode = true;
            (this.shipMCAry[_loc5_] as MovieClip).mc_bar.visible = false;
            (this.shipMCAry[_loc5_] as MovieClip).mc_color.gotoAndStop(3);
            (this.shipMCAry[_loc5_] as MovieClip).addEventListener(MouseEvent.CLICK,this.choose);
            _loc5_++;
         }
      }
      
      public function clearShipStata() : void
      {
         this.shipStata.splice(0);
      }
      
      private function choose(param1:Event) : void
      {
         var _loc2_:int = int(String(param1.currentTarget.name).slice(7));
         var _loc3_:int = _loc2_ + this.m_page * 9;
         var _loc4_:int = 0;
         while(_loc4_ < this.shipStata.length)
         {
            if(_loc3_ == this.shipStata[_loc4_])
            {
               this.shipStata.splice(_loc4_,1);
               (this.shipMCAry[_loc2_] as MovieClip).gotoAndStop(1);
               _mc.getMC().tf_fleetpage.text = this.shipStata.length + "/" + String(int(MsgTypes.MAX_RACINGSHIPTEAMNUM - GymkhanaRouter.getinstance().InShipAry.length));
               return;
            }
            _loc4_++;
         }
         if(MsgTypes.MAX_RACINGSHIPTEAMNUM - GymkhanaRouter.getinstance().InShipAry.length - this.shipStata.length > 0)
         {
            this.shipStata.push(_loc3_);
            (this.shipMCAry[_loc2_] as MovieClip).gotoAndStop(2);
            _mc.getMC().tf_fleetpage.text = this.shipStata.length + "/" + String(int(MsgTypes.MAX_RACINGSHIPTEAMNUM - GymkhanaRouter.getinstance().InShipAry.length));
         }
      }
      
      private function chickButton(param1:Event) : void
      {
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:MSG_RESP_RACINGINFOSHIPTEAM_TEMP = null;
         var _loc6_:MSG_RESP_RACINGINFOSHIPTEAM_TEMP = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         if(param1.currentTarget.name == "btn_close")
         {
            GameKernel.popUpDisplayManager.Hide(instance);
         }
         else if(param1.currentTarget.name == "btn_ensure")
         {
            _loc2_ = new Array();
            _loc3_ = 0;
            while(_loc3_ < GymkhanaRouter.getinstance().InShipAry.length)
            {
               _loc5_ = GymkhanaRouter.getinstance().InShipAry[_loc3_] as MSG_RESP_RACINGINFOSHIPTEAM_TEMP;
               _loc6_ = new MSG_RESP_RACINGINFOSHIPTEAM_TEMP();
               _loc6_.TeamName = _loc5_.TeamName;
               _loc6_.ShipTeamId = _loc5_.ShipTeamId;
               _loc6_.CommanderId = _loc5_.CommanderId;
               _loc6_.BodyId = _loc5_.BodyId;
               _loc6_.ShipNum = _loc5_.ShipNum;
               _loc2_.push(_loc6_.ShipTeamId);
               _loc3_++;
            }
            _loc4_ = 0;
            while(_loc4_ < this.shipStata.length)
            {
               _loc7_ = int(this.shipStata[_loc4_]);
               _loc5_ = GymkhanaRouter.getinstance().OutShipAry[_loc7_] as MSG_RESP_RACINGINFOSHIPTEAM_TEMP;
               _loc6_ = new MSG_RESP_RACINGINFOSHIPTEAM_TEMP();
               _loc6_.TeamName = _loc5_.TeamName;
               _loc6_.ShipTeamId = _loc5_.ShipTeamId;
               _loc6_.CommanderId = _loc5_.CommanderId;
               _loc6_.BodyId = _loc5_.BodyId;
               _loc6_.ShipNum = _loc5_.ShipNum;
               _loc2_.push(_loc6_.ShipTeamId);
               _loc4_++;
            }
            GymkhanaRouter.getinstance().REQUEST_SETRACINGSHIPTEAM(_loc2_.length,_loc2_);
            GameKernel.popUpDisplayManager.Hide(instance);
         }
         else if(param1.currentTarget.name == "btn_left")
         {
            if(this.m_page == 0)
            {
               return;
            }
            --this.m_page;
            this.showList();
         }
         else if(param1.currentTarget.name == "btn_right")
         {
            _loc8_ = GymkhanaRouter.getinstance().OutShipAry.length / 9;
            if(GymkhanaRouter.getinstance().OutShipAry.length % 9 == 0 && GymkhanaRouter.getinstance().OutShipAry.length > 0)
            {
               _loc8_--;
            }
            if(this.m_page == _loc8_)
            {
               return;
            }
            ++this.m_page;
            this.showList();
         }
      }
      
      private function clearList() : void
      {
         var _loc2_:MovieClip = null;
         var _loc1_:int = 0;
         while(_loc1_ < 9)
         {
            _loc2_ = this.shipMCAry[_loc1_] as MovieClip;
            _loc2_.gotoAndStop(1);
            while(_loc2_.mc_commanderbase.numChildren > 1)
            {
               _loc2_.mc_commanderbase.removeChildAt(1);
            }
            while(_loc2_.mc_fleetbase.numChildren > 1)
            {
               _loc2_.mc_fleetbase.removeChildAt(1);
            }
            _loc2_.visible = false;
            _loc1_++;
         }
      }
      
      public function showList() : void
      {
         var _loc3_:MSG_RESP_RACINGINFOSHIPTEAM_TEMP = null;
         var _loc4_:MovieClip = null;
         var _loc5_:Bitmap = null;
         var _loc6_:ShipbodyInfo = null;
         var _loc7_:BitmapData = null;
         var _loc8_:Bitmap = null;
         this.clearList();
         var _loc1_:int = 0 + this.m_page * 9;
         var _loc2_:int = 0;
         while(_loc2_ < 9 && _loc1_ < GymkhanaRouter.getinstance().OutShipAry.length)
         {
            _loc3_ = GymkhanaRouter.getinstance().OutShipAry[_loc1_] as MSG_RESP_RACINGINFOSHIPTEAM_TEMP;
            _loc4_ = this.shipMCAry[_loc2_] as MovieClip;
            _loc4_.visible = true;
            _loc5_ = CommanderSceneUI.getInstance().CommanderImg(_loc3_.CommanderId);
            _loc4_.mc_commanderbase.addChild(_loc5_);
            _loc6_ = CShipmodelReader.getInstance().getShipBodyInfo(_loc3_.BodyId);
            _loc7_ = GameKernel.getTextureInstance(_loc6_.SmallIcon);
            _loc8_ = new Bitmap(_loc7_);
            _loc4_.mc_fleetbase.addChild(_loc8_);
            _loc4_.tf_fleetnum.text = _loc3_.ShipNum;
            _loc4_.tf_fleetname.text = _loc3_.TeamName;
            _loc1_++;
            _loc2_++;
         }
         _mc.getMC().tf_fleetpage.text = this.shipStata.length + "/" + String(int(MsgTypes.MAX_RACINGSHIPTEAMNUM - GymkhanaRouter.getinstance().InShipAry.length));
         _mc.getMC().tf_page.text = int(this.m_page + 1);
      }
   }
}

