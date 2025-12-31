package logic.entry
{
   import logic.action.GalaxyMapAction;
   import logic.reader.CConstructionReader;
   import logic.reader.FortificationStarReader;
   import logic.reader.StarLevelReader;
   
   public class EquimentFactory
   {
      
      public static const EQUIMENT_UI_DIY:int = 2;
      
      public function EquimentFactory()
      {
         super();
      }
      
      public static function createEquiment(param1:int, param2:int = 0) : Equiment
      {
         var _loc4_:Equiment = null;
         var _loc3_:int = GalaxyMapAction.instance.curStar.Type;
         if(_loc3_ == GalaxyType.GT_3)
         {
            _loc4_ = new Equiment(null);
            if(param1 == EquimentTypeEnum.EQUIMENT_TYPE_SPACESTATION)
            {
               _loc4_.StarLvEntry = StarLevelReader.getInstance().Read(param2);
            }
            else
            {
               _loc4_.FortificationStarEntry = FortificationStarReader.getInstance().Read(param1,param2);
            }
            return _loc4_;
         }
         return new Equiment(CConstructionReader.getInstance().Read(param1,param2));
      }
   }
}

