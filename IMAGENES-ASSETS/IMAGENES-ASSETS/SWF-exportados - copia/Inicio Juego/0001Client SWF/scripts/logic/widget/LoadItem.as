package logic.widget
{
   import flash.net.URLRequest;
   import flash.system.LoaderContext;
   
   public class LoadItem
   {
      
      public static const ITEM_SWF:int = 0;
      
      public static const ITEM_IMG:int = 1;
      
      public static const ITEM_TEXT:int = 2;
      
      public var Id:*;
      
      public var Image:String;
      
      public var Type:int;
      
      public var Url:URLRequest;
      
      public var Content:*;
      
      public var Index:int;
      
      public var IsLoading:Boolean;
      
      public var Context:LoaderContext;
      
      public var IsCompleted:Boolean;
      
      public function LoadItem()
      {
         super();
         this.Id = null;
         this.Type = -1;
         this.Image = null;
         this.Url = null;
         this.Content = null;
         this.Index = 0;
         this.Context = null;
         this.IsLoading = false;
         this.IsCompleted = false;
      }
   }
}

