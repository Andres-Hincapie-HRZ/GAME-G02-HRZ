package logic.entry
{
   import flash.display.MovieClip;
   import logic.entry.shipmodel.ShipbodyInfo;
   import logic.game.GameKernel;
   import logic.reader.CShipmodelReader;
   
   public class GShip
   {
      
      public var ShipModelId:int = -1;
      
      public var BodyId:int = -1;
      
      public var Num:int = -1;
      
      public var MaxShield:int = -1;
      
      public var MaxEndure:int = -1;
      
      public var Shield:int = -1;
      
      public var Endure:int = -1;
      
      private var model:MovieClip = null;
      
      public function GShip()
      {
         super();
      }
      
      public function getModel() : MovieClip
      {
         var _loc1_:ShipbodyInfo = null;
         if(this.model == null)
         {
            _loc1_ = CShipmodelReader.getInstance().getShipBodyInfo(this.BodyId);
            this.model = GameKernel.getMovieClipInstance(_loc1_.ImageFileName,0,0,true);
            this.model.stop();
            this.model.mouseEnabled = false;
            return this.model;
         }
         return this.model;
      }
   }
}

