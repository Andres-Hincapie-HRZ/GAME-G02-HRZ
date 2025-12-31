package logic.entry
{
   import com.star.frameworks.display.Container;
   
   public class ConstructionSenseZone extends Container
   {
      
      private var _buildId:int;
      
      private var _levelId:int;
      
      private var _equiment:Equiment;
      
      private var _isInit:Boolean = false;
      
      private var _isHit:Boolean;
      
      public function ConstructionSenseZone(param1:Equiment, param2:Boolean = true)
      {
         this._equiment = param1;
         this._buildId = this._equiment.EquimentInfoData.BuildID;
         this._levelId = this._equiment.EquimentInfoData.LevelId;
         mouseChildren = false;
         super("ConstructionSenseZone");
      }
      
      public function get Construction() : Equiment
      {
         return this._equiment;
      }
      
      public function get IsHit() : Boolean
      {
         return this._isHit;
      }
      
      public function set IsHit(param1:Boolean) : void
      {
         this._isHit = param1;
      }
      
      public function get EquimentId() : int
      {
         if(this._equiment)
         {
            return this._equiment.EquimentInfoData.IndexId;
         }
         return -1;
      }
      
      public function get buildId() : int
      {
         return this._buildId;
      }
      
      public function set buildId(param1:int) : void
      {
         this._buildId = param1;
      }
      
      public function get LevelId() : int
      {
         return this._levelId;
      }
      
      public function set LevelId(param1:int) : void
      {
         this._levelId = param1;
      }
      
      public function Draw() : void
      {
         if(this._isInit)
         {
            return;
         }
         this._isInit = true;
         this.Paint();
      }
      
      private function Paint(param1:uint = 4373760) : void
      {
         graphics.clear();
         graphics.beginFill(param1,0.2);
         graphics.lineStyle(0,13421772,1);
         graphics.moveTo(this._equiment.BlurPrint.react1.x,this._equiment.BlurPrint.react1.y);
         graphics.lineTo(this._equiment.BlurPrint.react2.x,this._equiment.BlurPrint.react2.y);
         graphics.lineTo(this._equiment.BlurPrint.react3.x,this._equiment.BlurPrint.react3.y);
         graphics.lineTo(this._equiment.BlurPrint.react4.x,this._equiment.BlurPrint.react4.y);
         graphics.lineTo(this._equiment.BlurPrint.react1.x,this._equiment.BlurPrint.react1.y);
         graphics.endFill();
      }
      
      public function setDefaultState() : void
      {
         if(this._isHit)
         {
            this.Paint();
            this._isHit = false;
         }
      }
      
      public function setHitState() : void
      {
         if(!this._isHit)
         {
            this.Paint(16711680);
            this._isHit = true;
         }
      }
      
      public function addZoneListeners(param1:Boolean = true) : void
      {
      }
      
      public function removeZoneListeners() : void
      {
      }
      
      public function Release() : void
      {
         this._equiment.removeChild(this);
      }
   }
}

