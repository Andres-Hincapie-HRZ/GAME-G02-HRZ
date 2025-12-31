package logic.widget.tips
{
   import com.star.frameworks.managers.ResManager;
   import com.star.frameworks.utils.HashSet;
   import logic.game.GameKernel;
   import logic.widget.com.ComXmlParser;
   
   public class CToolTipFactory
   {
      
      public static var dependStr:String = "";
      
      private static var toolTipList:HashSet = new HashSet();
      
      public static var infoList:HashSet = new HashSet();
      
      public function CToolTipFactory()
      {
         super();
      }
      
      public static function InitToolTip(param1:String) : CToolTip
      {
         var _loc2_:CToolTip = null;
         var _loc3_:ComXmlParser = null;
         if(!toolTipList.ContainsKey(param1))
         {
            _loc3_ = new ComXmlParser(GameKernel.resManager.getXml(ResManager.GAMERES,param1));
            _loc2_ = _loc3_.getToolTipDecorate();
            _loc2_.Name = param1;
            toolTipList.Put(param1,_loc2_);
         }
         else
         {
            _loc2_ = CToolTip(toolTipList.Get(param1)) as CToolTip;
         }
         return _loc2_;
      }
   }
}

