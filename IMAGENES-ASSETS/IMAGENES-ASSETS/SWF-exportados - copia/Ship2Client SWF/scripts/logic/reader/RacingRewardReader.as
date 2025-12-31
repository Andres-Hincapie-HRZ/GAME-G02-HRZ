package logic.reader
{
   import com.star.frameworks.managers.ResManager;
   import logic.game.GameKernel;
   
   public class RacingRewardReader
   {
      
      private static var instance:RacingRewardReader;
      
      private var m_xmlList:XMLList;
      
      private var ary:Array;
      
      public function RacingRewardReader()
      {
         var _loc1_:XML = null;
         super();
         _loc1_ = GameKernel.resManager.getXml(ResManager.GAMERES,"RacingReward");
         this.m_xmlList = _loc1_.* as XMLList;
      }
      
      public static function getInstance() : RacingRewardReader
      {
         if(instance == null)
         {
            instance = new RacingRewardReader();
         }
         return instance;
      }
      
      public function ReData(param1:int) : Object
      {
         var i:int;
         var typeXml:XML = null;
         var xml:XML = null;
         var obj:Object = null;
         var obj1:Object = null;
         var ranking:int = param1;
         if(this.ary == null)
         {
            typeXml = new XML(this.m_xmlList.(@Type == "0"));
            this.ary = new Array();
            for each(xml in typeXml.*)
            {
               obj = new Object();
               obj.Ranking = int(xml.@Ranking);
               obj.Reward = int(xml.@Reward);
               obj.PropsId = String(xml.@PropsId);
               this.ary.push(obj);
            }
         }
         i = 0;
         while(i < this.ary.length)
         {
            obj1 = this.ary[i] as Object;
            if(obj1.Ranking == ranking || obj1.Ranking >= ranking)
            {
               return obj1;
            }
            i++;
         }
         return null;
      }
   }
}

