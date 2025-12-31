package logic.widget
{
   import com.star.frameworks.events.LoaderEvent;
   import com.star.frameworks.utils.HashSet;
   import logic.action.ConstructionAction;
   import logic.action.StarSurfaceAction;
   import logic.entry.Equiment;
   
   public class ConstructionLoadQueue
   {
      
      private static var m_Instance:ConstructionLoadQueue;
      
      public static var IsNeedLoad:Boolean = false;
      
      private static var constructionResCache:HashSet = new HashSet();
      
      private var m_CallBack:Function;
      
      private var m_BatchLoader:LoadQueue;
      
      public function ConstructionLoadQueue()
      {
         super();
      }
      
      public static function GetInstance() : ConstructionLoadQueue
      {
         if(m_Instance == null)
         {
            m_Instance = new ConstructionLoadQueue();
         }
         return m_Instance;
      }
      
      public function Init(param1:int = 1) : void
      {
         if(this.m_BatchLoader)
         {
            this.m_BatchLoader.LoadList.removeAll();
            return;
         }
         this.m_BatchLoader = new LoadQueue(param1);
         this.m_BatchLoader.addEventListener(LoaderEvent.COMPLETE_ALL,StarSurfaceAction.getInstance().onAllCompleted);
         this.m_BatchLoader.CallBack = this.RenderConstruction;
      }
      
      public function SetConnectionNum(param1:int) : void
      {
         this.m_BatchLoader.MaxConnectionNum = param1;
      }
      
      public function GetLoadList() : HashSet
      {
         return this.m_BatchLoader.LoadList;
      }
      
      public function AddFile(param1:Object) : void
      {
         this.m_BatchLoader.AddItem(param1);
      }
      
      public function IsExists(param1:Object) : Boolean
      {
         if(this.m_BatchLoader)
         {
            return this.m_BatchLoader.LoadList.ContainsKey(param1);
         }
         return false;
      }
      
      public function RenderConstruction(param1:LoadItem) : void
      {
         var _loc3_:Equiment = null;
         ConstructionAction.ConstructionResCache.Put(param1.Id,param1.Content);
         var _loc2_:Array = ConstructionAction.constuctionList.Values();
         for each(_loc3_ in _loc2_)
         {
            if(_loc3_.EquimentInfoData.BuildID == param1.Id)
            {
               _loc3_.reLoadMc(_loc3_.UrlItem.Image);
            }
         }
         _loc2_ = ConstructionAction.outSideContuctionList.Values();
         for each(_loc3_ in _loc2_)
         {
            if(_loc3_.EquimentInfoData.BuildID == param1.Id)
            {
               _loc3_.reLoadMc(_loc3_.UrlItem.Image);
            }
         }
      }
      
      public function DoCallBack() : void
      {
         if(this.m_CallBack != null)
         {
            this.m_CallBack();
         }
      }
      
      public function Load() : void
      {
         this.m_BatchLoader.Start();
      }
   }
}

