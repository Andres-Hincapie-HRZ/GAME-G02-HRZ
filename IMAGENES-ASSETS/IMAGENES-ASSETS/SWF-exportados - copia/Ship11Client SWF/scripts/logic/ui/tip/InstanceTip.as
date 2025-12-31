package logic.ui.tip
{
   import com.star.frameworks.managers.StringManager;
   import flash.display.Bitmap;
   import flash.geom.Point;
   import logic.entry.FBModel;
   import logic.game.GameKernel;
   import logic.manager.InstanceManager;
   import logic.reader.CPropsReader;
   import logic.ui.info.AbstractInfoDecorate;
   
   public class InstanceTip
   {
      
      private static var _instance:InstanceTip = null;
      
      private var _infoDecorate:AbstractInfoDecorate = new AbstractInfoDecorate();
      
      public function InstanceTip(param1:HHH)
      {
         super();
         this._infoDecorate.Load("InstanceTip");
      }
      
      public static function get instance() : InstanceTip
      {
         if(!_instance)
         {
            _instance = new InstanceTip(new HHH());
         }
         return _instance;
      }
      
      public function Show(param1:Point, param2:FBModel, param3:Boolean) : void
      {
         var _loc4_:FBModel = null;
         var _loc5_:* = null;
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc8_:Bitmap = null;
         var _loc9_:Bitmap = null;
         var _loc10_:Array = null;
         var _loc11_:* = null;
         var _loc12_:int = 0;
         this._infoDecorate.Update("FBName",param2.Name);
         this._infoDecorate.Update("Assiqnment","             " + param2.Comment);
         this._infoDecorate.Update("FBDisc","" + param2.Comment2);
         this._infoDecorate.Update("FBMaxGate",param2.MaxGate + "");
         this._infoDecorate.Update("FBMaxUser",param2.MaxUser + "");
         this._infoDecorate.Update("FBMaxTeam",param2.UserTeam + "");
         this._infoDecorate.Update("FBMaxShip",param2.UserShip + "");
         this._infoDecorate.Update("FBExp",param2.Exp + "");
         if(param2.Treasure_str == null)
         {
            _loc4_ = InstanceManager.instance.getFBModelByEctype(param2.Needed);
            _loc5_ = "";
            if(_loc4_ == null)
            {
               _loc5_ = "--";
            }
            else
            {
               _loc5_ = _loc4_.ID + "";
            }
            if(!param3)
            {
               this._infoDecorate.Update("NeedTxt","",16711680);
               this._infoDecorate.Update("NeedName",_loc5_,16711680);
            }
            else
            {
               this._infoDecorate.Update("NeedName",_loc5_,6684620);
            }
            _loc6_ = CPropsReader.getInstance().GetPropsInfo(param2.Treasure).Name;
            _loc7_ = param2.TreNumber == "" ? "" : "×" + param2.TreNumber;
            this._infoDecorate.Update("FBRewardName",_loc6_ + _loc7_);
            _loc6_ = CPropsReader.getInstance().GetPropsInfo(param2.Treasure).ImageFileName;
            _loc8_ = new Bitmap(GameKernel.getTextureInstance(_loc6_));
            this._infoDecorate.replaceTexture("FBReward",_loc8_);
            if(param2.Treasure2 > 0)
            {
               _loc6_ = CPropsReader.getInstance().GetPropsInfo(param2.Treasure2).Name;
               this._infoDecorate.Update("FBRewardName2",_loc6_ + StringManager.getInstance().getMessageString("BattleTXT13"));
               _loc6_ = CPropsReader.getInstance().GetPropsInfo(param2.Treasure2).ImageFileName;
               _loc9_ = new Bitmap(GameKernel.getTextureInstance(_loc6_));
               this._infoDecorate.replaceTexture("FBReward2",_loc9_);
            }
            else
            {
               this._infoDecorate.Update("FBRewardName2","");
               this._infoDecorate.replaceTexture("FBReward2",new Bitmap());
            }
         }
         else
         {
            _loc10_ = param2.Treasure_str.split(",");
            _loc11_ = "";
            _loc12_ = 0;
            while(_loc12_ < _loc10_.length)
            {
               if(_loc12_ > 0)
               {
                  _loc11_ += "<br/>";
               }
               _loc11_ += CPropsReader.getInstance().GetPropsInfo(_loc10_[_loc12_]).Name;
               _loc12_++;
            }
            this._infoDecorate.Update("FBRewardName","<font color=\'#FFFF00\'>" + _loc11_ + "</font>");
            this._infoDecorate.Update("NeedName","--",6684620);
            this._infoDecorate.Update("FBRewardName2","");
            this._infoDecorate.replaceTexture("FBReward",null);
            this._infoDecorate.replaceTexture("FBReward2",null);
         }
         this._infoDecorate.putDecorate();
         this._infoDecorate.Show(param1.x,param1.y);
      }
      
      public function Hide() : void
      {
         this._infoDecorate.Hide();
         CustomTip.GetInstance().Hide();
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
