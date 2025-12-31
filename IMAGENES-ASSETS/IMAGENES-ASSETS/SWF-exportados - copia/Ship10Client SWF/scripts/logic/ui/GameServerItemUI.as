package logic.ui
{
   import com.star.frameworks.events.ActionEvent;
   import com.star.frameworks.module.IModule;
   import com.star.frameworks.utils.ObjectUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import logic.entry.GameServerItem;
   import logic.entry.HButton;
   import logic.entry.MObject;
   import logic.game.GameKernel;
   import logic.manager.GameInterActiveManager;
   
   public class GameServerItemUI implements IModule
   {
      
      private static var m_Instance:GameServerItemUI;
      
      public static var isInit:Boolean = false;
      
      private static const ITEM_COUNT:int = 10;
      
      public static const FLAG_EMPTY:int = 1;
      
      public static const FLAG_NEW:int = 2;
      
      public static const FLAG_HOT:int = 3;
      
      public static const FLAG_FULL:int = 4;
      
      private var m_CurrentIndex:int;
      
      private var m_MaxIndex:int;
      
      private var m_Page:TextField;
      
      private var m_leftBtn:HButton;
      
      private var m_rightBtn:HButton;
      
      private var m_ItemSet:Array;
      
      private var m_parentMc:MObject;
      
      private var m_ItemUI:MovieClip;
      
      public function GameServerItemUI()
      {
         super();
         this.m_CurrentIndex = 0;
      }
      
      public static function GetInstance() : GameServerItemUI
      {
         m_Instance = new GameServerItemUI();
         return m_Instance;
      }
      
      public function Init() : void
      {
         this.m_parentMc = GameServerListUI.GetInstance().getUI();
         this.m_ItemUI = this.m_parentMc.getMC().SelectedServerPlan as MovieClip;
         this.m_ItemUI.visible = true;
         this.m_ItemSet = new Array();
         this.InitElement();
      }
      
      public function SetDefaultState() : void
      {
         if(this.m_ItemUI == null)
         {
            this.m_parentMc = GameServerListUI.GetInstance().getUI();
            this.m_ItemUI = this.m_parentMc.getMC().SelectedServerPlan as MovieClip;
            this.m_ItemUI.stop();
         }
         this.m_ItemUI.visible = false;
      }
      
      private function InitElement() : void
      {
         this.m_leftBtn = new HButton(this.m_ItemUI.btn_left);
         this.m_rightBtn = new HButton(this.m_ItemUI.btn_right);
         this.m_Page = this.m_ItemUI.tf_page as TextField;
         this.LoadItem();
         GameInterActiveManager.InstallInterActiveEvent(this.m_leftBtn.m_movie,ActionEvent.ACTION_CLICK,this.onGoLeft);
         GameInterActiveManager.InstallInterActiveEvent(this.m_rightBtn.m_movie,ActionEvent.ACTION_CLICK,this.onGoRight);
      }
      
      private function SetMaxIndex() : void
      {
         var _loc1_:Array = GameServerListUI.GetInstance().GetServerData();
         if(_loc1_.length < GameServerItemUI.ITEM_COUNT)
         {
            this.m_MaxIndex = 1;
         }
         else if(_loc1_.length % GameServerItemUI.ITEM_COUNT == 0)
         {
            this.m_MaxIndex = Math.floor(_loc1_.length / GameServerItemUI.ITEM_COUNT);
         }
         else
         {
            this.m_MaxIndex = Math.floor(_loc1_.length / GameServerItemUI.ITEM_COUNT) + 1;
         }
      }
      
      public function Validate() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         if(this.m_ItemSet == null)
         {
            return;
         }
         if(this.m_ItemSet.length < GameServerItemUI.ITEM_COUNT)
         {
            _loc1_ = int(this.m_ItemSet.length);
            while(_loc1_ < GameServerItemUI.ITEM_COUNT)
            {
               _loc2_ = this.m_ItemUI.getChildByName("mc_list" + _loc1_) as MovieClip;
               _loc2_.stop();
               _loc2_.visible = false;
               _loc1_++;
            }
         }
      }
      
      private function Reset() : void
      {
         var _loc2_:MovieClip = null;
         var _loc1_:int = 0;
         while(_loc1_ < GameServerItemUI.ITEM_COUNT)
         {
            _loc2_ = this.m_ItemUI.getChildByName("mc_list" + _loc1_) as MovieClip;
            _loc2_.stop();
            if(!_loc2_.visible)
            {
               _loc2_.visible = true;
            }
            _loc1_++;
         }
      }
      
      public function SetPage() : void
      {
         this.m_Page.text = String(this.m_CurrentIndex + 1) + "/" + String(this.m_MaxIndex);
      }
      
      private function LoadItem() : void
      {
         var _loc5_:MovieClip = null;
         var _loc6_:HButton = null;
         var _loc7_:GameServerItem = null;
         this.m_ItemSet.splice(0);
         var _loc1_:Array = GameServerListUI.GetInstance().GetServerData();
         var _loc2_:int = _loc1_.length - this.m_CurrentIndex * GameServerItemUI.ITEM_COUNT;
         _loc2_ = Math.min(_loc2_,GameServerItemUI.ITEM_COUNT);
         var _loc3_:int = this.m_CurrentIndex * GameServerItemUI.ITEM_COUNT;
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_)
         {
            _loc5_ = this.m_ItemUI.getChildByName("mc_list" + _loc4_) as MovieClip;
            _loc5_.visible = true;
            _loc6_ = new HButton(_loc5_);
            _loc7_ = new GameServerItem(_loc5_,_loc1_[_loc3_]);
            GameInterActiveManager.InstallInterActiveEvent(_loc6_.m_movie,ActionEvent.ACTION_CLICK,this.onSelectServer);
            this.m_ItemSet.push(_loc7_);
            _loc3_++;
            _loc4_++;
         }
         this.Validate();
         this.SetMaxIndex();
         this.SetLRBtnStatue();
         this.SetPage();
      }
      
      private function Remove() : void
      {
         var _loc1_:GameServerItem = null;
         this.Reset();
         for each(_loc1_ in this.m_ItemSet)
         {
            GameInterActiveManager.unInstallnterActiveEvent(_loc1_.m_Mc,ActionEvent.ACTION_CLICK,this.onSelectServer);
         }
         ObjectUtil.ClearArray(this.m_ItemSet);
         this.m_ItemSet = null;
      }
      
      private function onGoLeft(param1:MouseEvent) : void
      {
         this.m_CurrentIndex = Math.max(0,--this.m_CurrentIndex);
         this.SetLRBtnStatue();
         this.LoadItem();
      }
      
      private function onGoRight(param1:MouseEvent) : void
      {
         ++this.m_CurrentIndex;
         this.SetLRBtnStatue();
         this.LoadItem();
      }
      
      public function SetLRBtnStatue() : void
      {
         this.m_leftBtn.setBtnDisabled(this.m_CurrentIndex == 0);
         this.m_rightBtn.setBtnDisabled(this.m_CurrentIndex + 1 >= this.m_MaxIndex);
      }
      
      private function onSelectServer(param1:MouseEvent) : void
      {
         var _loc3_:int = 0;
         var _loc2_:String = param1.currentTarget.name;
         _loc2_ = _loc2_.replace("mc_list","");
         _loc3_ = parseInt(_loc2_);
         var _loc4_:GameServerItem = this.m_ItemSet[_loc3_];
         if(_loc4_ == null)
         {
            throw new Error("Out of Bound");
         }
         GameServerListUI.GetInstance().ServerID = _loc4_.m_Data.ServerId;
         this.SetServerName();
         this.m_ItemUI.visible = false;
         GameServerListUI.GetInstance().SetCurrentSelectServerStatue();
      }
      
      public function SetServerName() : void
      {
         GameServerListUI.GetInstance().SetSelectServerName(GameServerListUI.GetInstance().ServerID);
      }
      
      public function Release() : void
      {
      }
      
      public function getUI() : MObject
      {
         if(this.m_parentMc != null)
         {
            this.Init();
         }
         return this.m_parentMc;
      }
      
      public function SetVisible(param1:Boolean) : void
      {
         GameKernel.renderManager.Show(this,param1);
      }
   }
}

