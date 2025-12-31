package logic.entry
{
   import com.star.frameworks.managers.StringManager;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import logic.game.GameSetting;
   import logic.ui.GameServerItemUI;
   import net.msg.MSG_LOGINSERVER_GAMESERVERLISTRESP_TEMP;
   
   public class GameServerItem
   {
      
      public var m_Name:TextField;
      
      public var m_Statue:MovieClip;
      
      public var m_Mc:MovieClip;
      
      public var m_Flag:MovieClip;
      
      public var m_Data:MSG_LOGINSERVER_GAMESERVERLISTRESP_TEMP;
      
      public function GameServerItem(param1:MovieClip, param2:MSG_LOGINSERVER_GAMESERVERLISTRESP_TEMP = null)
      {
         super();
         if(param1 != null)
         {
            this.m_Mc = param1;
            this.m_Name = this.m_Mc.tf_name as TextField;
            this.m_Statue = this.m_Mc.mc_state as MovieClip;
            this.m_Flag = this.m_Mc.mc_txt as MovieClip;
         }
         this.m_Data = param2;
         this.SetServerStatue();
         this.SetServerName();
         this.SetServerNewFlag();
      }
      
      public function SetServerNewFlag(param1:int = 0) : void
      {
         if(this.m_Data)
         {
            if(this.m_Data.ServerId == GamePlayer.getInstance().NewServerID)
            {
               this.m_Flag.gotoAndStop(GameServerItemUI.FLAG_NEW);
            }
            else
            {
               this.m_Flag.gotoAndStop(GameServerItemUI.FLAG_EMPTY);
            }
         }
      }
      
      public function SetServerStatue() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(this.m_Statue)
         {
            if(this.m_Data)
            {
               _loc1_ = this.m_Data.OnlineCount;
               if(this.m_Data.OnlineCount == 0)
               {
                  _loc2_ = 1;
               }
               else
               {
                  _loc2_ = int(this.m_Data.OnlineCount / GameSetting.SERVER_INTERVAL) + 2;
               }
               _loc2_ = Math.min(_loc2_,GameSetting.SERVER_MAX_STATUE);
               this.m_Statue.gotoAndStop(_loc2_);
            }
         }
      }
      
      public function SetServerName() : void
      {
         var _loc1_:String = null;
         if(this.m_Name)
         {
            _loc1_ = "ServerName";
            if(this.m_Data)
            {
               _loc1_ = _loc1_.concat(this.m_Data.ServerId + 1);
               this.m_Name.text = StringManager.getInstance().getMessageString(_loc1_);
            }
         }
      }
   }
}

