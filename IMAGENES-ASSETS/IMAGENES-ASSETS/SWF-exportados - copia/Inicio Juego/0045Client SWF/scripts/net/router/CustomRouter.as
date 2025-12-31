package net.router
{
   import com.star.frameworks.utils.HashSet;
   import flash.display.DisplayObject;
   import flash.utils.ByteArray;
   import logic.ui.FleetInfoUI_Res;
   import logic.ui.MessagePopup;
   import logic.ui.PlayerInfoUI;
   import net.base.NetManager;
   import net.msg.MSG_RESP_CUSTOM_CONFIGURATION;
   import net.msg.MSG_RESP_CUSTOM_MOREINFO;
   import net.msg.MSG_RESP_CUSTOM_WARN;
   
   public class CustomRouter
   {
      
      private static var _instance:CustomRouter;
      
      public var userId:String;
      
      public var userImage:String;
      
      public var resourcesUrl:String;
      
      public var otherImages:HashSet;
      
      public function CustomRouter()
      {
         super();
         this.otherImages = new HashSet();
      }
      
      public static function get instance() : CustomRouter
      {
         if(_instance == null)
         {
            _instance = new CustomRouter();
         }
         return _instance;
      }
      
      public function Resp_MSG_RESP_CUSTOM_WARN(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_CUSTOM_WARN = new MSG_RESP_CUSTOM_WARN();
         NetManager.Instance().readObject(_loc4_,param3);
         MessagePopup.getInstance().Show(_loc4_.buffer,1);
      }
      
      public function Resp_MSG_RESP_CUSTOM_MOREINFO(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_CUSTOM_MOREINFO = new MSG_RESP_CUSTOM_MOREINFO();
         NetManager.Instance().readObject(_loc4_,param3);
         if(_loc4_.Kind == 0)
         {
            this.userImage = this.resourcesUrl + "images/profile/" + _loc4_.ProfileImage + ".png";
            this.userId = _loc4_.UserId;
            PlayerInfoUI.getInstance().bindPlayerImage();
         }
         else
         {
            this.otherImages.Put(_loc4_.UserId,this.resourcesUrl + "images/profile/" + _loc4_.ProfileImage + ".png");
         }
         FleetInfoUI_Res.GetInstance().GetFacebookUserImg(_loc4_.UserId,this.resourcesUrl + "images/profile/" + _loc4_.ProfileImage + ".png",this.GetFacebookUserImgCallback);
      }
      
      public function Resp_MSG_RESP_CUSTOM_CONFIGURATION(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_CUSTOM_CONFIGURATION = new MSG_RESP_CUSTOM_CONFIGURATION();
         NetManager.Instance().readObject(_loc4_,param3);
         this.resourcesUrl = _loc4_.ResourcesUrl;
      }
      
      private function GetFacebookUserImgCallback(param1:Number, param2:DisplayObject) : void
      {
      }
   }
}

