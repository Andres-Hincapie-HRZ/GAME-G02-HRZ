package logic.impl
{
   import com.star.frameworks.display.Container;
   
   public interface IAbstractAction
   {
      
      function Init() : void;
      
      function getUI() : Container;
   }
}

