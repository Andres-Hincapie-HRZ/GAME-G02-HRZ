package logic.ui
{
   public interface MyCorpsUI_Base
   {
      
      function GetList(param1:int = -1) : Array;
      
      function GetPageIndex() : int;
      
      function GetPageCount() : int;
      
      function NextPage() : Array;
      
      function PrePage() : Array;
      
      function GetHeadString() : String;
   }
}

