package logic.ui
{
   import com.star.frameworks.events.ActionEvent;
   import com.star.frameworks.geom.RectangleKit;
   import com.star.frameworks.managers.RenderManager;
   import com.star.frameworks.module.IModule;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import logic.entry.GamePlayer;
   import logic.entry.HButton;
   import logic.entry.MObject;
   import logic.game.GameKernel;
   import logic.manager.GameInterActiveManager;
   import net.base.NetManager;
   import net.msg.MSG_REQUEST_CREATEROLEINFO;
   
   public class CreateRoleUI implements IModule
   {
      
      private static var instance:CreateRoleUI;
      
      private var roleHeadID:int = 50;
      
      private var mWnd:MObject;
      
      private var createBtn:HButton;
      
      public function CreateRoleUI()
      {
         super();
      }
      
      public static function getInstance() : CreateRoleUI
      {
         if(instance == null)
         {
            instance = new CreateRoleUI();
         }
         return instance;
      }
      
      public function Init() : void
      {
         RenderManager.getInstance().showLoadingMc(false);
         GameKernel.gameLayout.InstallUI("CharacterScene",new RectangleKit(260,200));
         this.mWnd = GameKernel.gameLayout.getInstallUI("CharacterScene") as MObject;
         this.createBtn = new HButton(this.mWnd.getMC().mc_ensure);
         GameInterActiveManager.InstallInterActiveEvent(this.createBtn.m_movie,ActionEvent.ACTION_CLICK,this.__createRole);
         GameKernel.renderManager.getUI().addComponent(this.mWnd);
      }
      
      public function Release() : void
      {
         this.mWnd.removeMc();
         GameKernel.renderManager.getUI().removeComponent(this.mWnd);
         this.mWnd = null;
         GameKernel.resManager.unRegisterRes("login_assset");
      }
      
      public function getUI() : MObject
      {
         if(this.mWnd != null)
         {
            this.Init();
         }
         return this.mWnd;
      }
      
      public function SetVisible(param1:Boolean) : void
      {
         GameKernel.renderManager.Show(this,param1);
      }
      
      private function __createRole(param1:MouseEvent) : void
      {
         if(TextField(this.mWnd.getMC().tf_name).text == "")
         {
            return;
         }
         RenderManager.getInstance().showLoadingMc(true);
         var _loc2_:MSG_REQUEST_CREATEROLEINFO = new MSG_REQUEST_CREATEROLEINFO();
         _loc2_.Guid = GamePlayer.getInstance().Guid;
         _loc2_.Name = TextField(this.mWnd.getMC().tf_name).text;
         _loc2_.roleHeadID = this.roleHeadID;
         NetManager.Instance().sendData(_loc2_);
         this.Release();
      }
   }
}

