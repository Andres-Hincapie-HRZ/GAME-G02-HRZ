package logic.ui.tip
{
   import com.star.frameworks.facebook.FacebookUserInfo;
   import flash.display.Bitmap;
   import flash.geom.Point;
   import logic.entry.GShipTeam;
   import logic.game.GameKernel;
   import logic.manager.GalaxyShipManager;
   import logic.ui.CommanderSceneUI;
   import logic.ui.info.AbstractInfoDecorate;
   
   public class ShipTeamInfoTip
   {
      
      private static var _instance:ShipTeamInfoTip = null;
      
      private var infoDecorate:AbstractInfoDecorate = new AbstractInfoDecorate();
      
      private var _commanderImg:Bitmap;
      
      private var _CurUserId:Number;
      
      public function ShipTeamInfoTip(param1:HHH)
      {
         super();
         this.infoDecorate.Load("ShipTeamInfoTip");
         this.infoDecorate.ToolTip.SetMoveEvent();
      }
      
      public static function get instance() : ShipTeamInfoTip
      {
         if(_instance == null)
         {
            _instance = new ShipTeamInfoTip(new HHH());
         }
         return _instance;
      }
      
      public function Hide() : void
      {
         this.infoDecorate.Hide();
         CustomTip.GetInstance().Hide();
      }
      
      public function Show(param1:int, param2:int, param3:GShipTeam) : void
      {
         var _loc4_:Point = GalaxyShipManager.getGird(param1,param2);
         this.infoDecorate.Update("ShipName",param3.TeamName);
         this.infoDecorate.Update("CommanderName",param3.Commander);
         this.infoDecorate.Update("CommandLevel",param3.LevelId + 1 + "");
         this.infoDecorate.Update("UserName",param3.TeamOwner);
         this.infoDecorate.Update("Crops",param3.Consortia);
         this.infoDecorate.Update("He3",param3.Gas + "");
         this._CurUserId = param3.UserId;
         this.infoDecorate.putDecorate();
         this.infoDecorate.Show(param1,param2);
         this.ShowCommander(param3);
      }
      
      public function ShowCommander(param1:GShipTeam) : void
      {
         if(!param1)
         {
            return;
         }
         this.infoDecorate.Update("UserName",param1.TeamOwner);
         GameKernel.getPlayerFacebookInfo(param1.UserId,this.getPlayerFacebookInfoCallback,param1.TeamOwner);
         this._commanderImg = CommanderSceneUI.getInstance().CommanderAvararImg(param1.CommanderHeadId);
         this.infoDecorate.replaceTexture("CommanderIcon",this._commanderImg);
         this.infoDecorate.putDecorate();
      }
      
      private function getPlayerFacebookInfoCallback(param1:FacebookUserInfo) : void
      {
         if(!param1)
         {
            return;
         }
         if(param1.first_name == "")
         {
            return;
         }
         if(param1 != null && this._CurUserId == param1.uid)
         {
            this.infoDecorate.Update("UserName",param1.first_name);
         }
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
