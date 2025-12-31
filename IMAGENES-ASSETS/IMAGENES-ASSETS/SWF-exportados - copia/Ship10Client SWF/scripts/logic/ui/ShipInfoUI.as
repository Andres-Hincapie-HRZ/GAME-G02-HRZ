package logic.ui
{
   import com.star.frameworks.display.Container;
   import com.star.frameworks.facebook.FacebookUserInfo;
   import com.star.frameworks.managers.StringManager;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import logic.action.OutSideGalaxiasAction;
   import logic.entry.GShipTeam;
   import logic.entry.test.MovieClipDataBox;
   import logic.game.GameKernel;
   
   public class ShipInfoUI
   {
      
      private static var _instance:ShipInfoUI = null;
      
      private var _mc:MovieClip;
      
      private var _mcData:MovieClipDataBox;
      
      private var _commanderImg:Bitmap;
      
      private var _CurUserId:Number;
      
      public function ShipInfoUI(param1:HHH)
      {
         super();
         this._mc = GameKernel.getMovieClipInstance("Fleetsuspend",0,0,true);
         this._mcData = new MovieClipDataBox(this._mc);
         this._commanderImg = new Bitmap();
         this._mcData.getMC("mc_base").addChild(this._commanderImg);
      }
      
      public static function get instance() : ShipInfoUI
      {
         if(!_instance)
         {
            _instance = new ShipInfoUI(new HHH());
         }
         return _instance;
      }
      
      public function Show(param1:GShipTeam) : void
      {
         this._mc.x = param1.getShipMc().x + this._mc.width * 0.65;
         this._mc.y = param1.getShipMc().y + this._mc.height * 0.3;
         var _loc2_:Container = OutSideGalaxiasAction.getInstance().OutSideDefendContainer;
         if(!_loc2_.contains(this._mc))
         {
            _loc2_.addChild(this._mc);
         }
         this._commanderImg.bitmapData = CommanderSceneUI.getInstance().CommanderHeadImg(param1.CommanderHeadId);
         this._mcData.getMC("mc_grade").gotoAndStop(param1.CardLevel + 2);
         this._mcData.getTF("tf_Lv").text = param1.LevelId + 1 + "";
         this._mcData.getTF("tf_fleetname").text = param1.TeamName;
         this._mcData.getTF("tf_commandername").text = param1.Commander;
         this._mcData.getTF("tf_commander").text = param1.TeamOwner;
         this._mcData.getTF("tf_corps").text = param1.Consortia;
         this._mcData.getTF("tf_He3").text = param1.Gas + "";
         this._mcData.getTF("tf_commandername").text = param1.Commander;
         this._mcData.getTF("tf_Ranges").text = StringManager.getInstance().getMessageString("FormationText" + (6 + param1.AttackObjInterval));
         this._mcData.getTF("tf_Goals").text = StringManager.getInstance().getMessageString("FormationText" + (8 + param1.AttackObjType));
         this._CurUserId = param1.UserId;
         GameKernel.getPlayerFacebookInfo(param1.UserId,this.getPlayerFacebookInfoCallback,param1.TeamOwner);
      }
      
      public function ShowCommander(param1:GShipTeam) : void
      {
         if(!param1)
         {
            return;
         }
         this._mcData.getTF("tf_commandername").text = param1.Commander;
         this._mcData.getTF("tf_Ranges").text = StringManager.getInstance().getMessageString("FormationText" + (6 + param1.AttackObjInterval));
         this._mcData.getTF("tf_Goals").text = StringManager.getInstance().getMessageString("FormationText" + (8 + param1.AttackObjType));
         this._mcData.getTF("tf_Lv").text = "" + int(param1.LevelId + 1);
         this._commanderImg.bitmapData = CommanderSceneUI.getInstance().CommanderHeadImg(param1.CommanderHeadId);
      }
      
      private function getPlayerFacebookInfoCallback(param1:FacebookUserInfo) : void
      {
         if(param1 != null && this._CurUserId == param1.uid)
         {
            this._mcData.getTF("tf_commander").text = param1.first_name;
         }
      }
      
      public function Hiden() : void
      {
         var _loc1_:Container = OutSideGalaxiasAction.getInstance().OutSideDefendContainer;
         if(_loc1_.contains(this._mc))
         {
            _loc1_.removeChild(this._mc);
         }
         if(this._commanderImg.bitmapData)
         {
            this._commanderImg.bitmapData = null;
         }
         this._mcData.getMC("mc_grade");
         this._mcData.getTF("tf_fleetname").text = "";
         this._mcData.getTF("tf_commandername").text = "";
         this._mcData.getTF("tf_Lv").text = "LV:";
         this._mcData.getTF("tf_commander").text = "";
         this._mcData.getTF("tf_corps").text = "";
         this._mcData.getTF("tf_He3").text = "";
         this._mcData.getTF("tf_Ranges").text = "";
         this._mcData.getTF("tf_Goals").text = "";
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
