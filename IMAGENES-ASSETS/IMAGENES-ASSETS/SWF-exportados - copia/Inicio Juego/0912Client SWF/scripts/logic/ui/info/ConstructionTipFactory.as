package logic.ui.info
{
   import com.star.frameworks.utils.HashSet;
   
   public class ConstructionTipFactory
   {
      
      private static var _tipList:HashSet = new HashSet();
      
      public function ConstructionTipFactory()
      {
         super();
      }
      
      public static function setInfoDecorate(param1:String) : IInfoDecorate
      {
         if(_tipList.Get(param1))
         {
            return _tipList.Get(param1);
         }
         var _loc2_:IInfoDecorate = new AbstractInfoDecorate();
         _loc2_.Load(param1);
         _tipList.Put(param1,_loc2_);
         return _loc2_;
      }
   }
}

