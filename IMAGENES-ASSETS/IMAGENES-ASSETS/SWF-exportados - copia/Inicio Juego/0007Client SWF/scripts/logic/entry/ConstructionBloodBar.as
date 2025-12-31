package logic.entry
{
   import com.star.frameworks.display.Container;
   import flash.display.Bitmap;
   import flash.events.Event;
   import logic.action.ConstructionAction;
   import logic.game.GameKernel;
   
   public class ConstructionBloodBar
   {
      
      public static const BARWIDTH:int = 66;
      
      private var _container:Container;
      
      private var _bloodBg:Bitmap;
      
      private var _bloodBar:Bitmap;
      
      private var _equ:Equiment;
      
      private var _reduce:int = 0;
      
      private var _reducePercent:Number = 0;
      
      private var _percent:Number;
      
      private var _endureCount:int = 0;
      
      public function ConstructionBloodBar(param1:Equiment)
      {
         super();
         this._container = new Container();
         this._equ = param1;
         this._bloodBg = new Bitmap(GameKernel.getTextureInstance("planbarbg"));
         this._bloodBar = new Bitmap(GameKernel.getTextureInstance("planbar"));
         this._bloodBar.width = BARWIDTH;
         this._bloodBar.x = 2;
         this._bloodBar.y = 2;
         if(this._equ.EquimentInfoData.BuildID != EquimentTypeEnum.EQUIMENT_TYPE_SPACESTATION)
         {
            this._container.x -= this._bloodBg.width >> 1;
            this._container.y -= this._bloodBg.height >> 1;
         }
         this._container.addChild(this._bloodBg);
         this._container.addChild(this._bloodBar);
      }
      
      public function get BloorBar() : Container
      {
         return this._container;
      }
      
      public function Destory() : void
      {
         if(this._container.contains(this._bloodBg))
         {
            this._container.removeChild(this._bloodBg);
            this._bloodBg = null;
         }
         if(this._container.contains(this._bloodBar))
         {
            this._container.removeChild(this._bloodBar);
            this._bloodBar = null;
         }
         this._equ = null;
      }
      
      public function rePaint(param1:int = 0) : void
      {
         if(this._equ.EquimentInfoData.Endure == 0)
         {
            ConstructionAction.getInstance().setConstructionDestoryState(this._equ);
            return;
         }
         if(param1 == 0)
         {
            this._percent = this._equ.EquimentInfoData.Endure / this._equ.EquimentInfoData.MaxEndure;
            this._bloodBar.width = ConstructionBloodBar.BARWIDTH * this._percent;
            return;
         }
         this._reduce = param1;
         this._reducePercent = param1 / this._equ.EquimentInfoData.MaxEndure;
         this._percent = this._equ.EquimentInfoData.Endure / this._equ.EquimentInfoData.MaxEndure;
         this._bloodBar.width = ConstructionBloodBar.BARWIDTH * this._percent;
         this._equ.addEventListener(Event.ENTER_FRAME,this.onRepaintEndure);
      }
      
      private function onRepaintEndure(param1:Event) : void
      {
         this._bloodBar.width -= ConstructionBloodBar.BARWIDTH * this._reducePercent * 0.1;
         if(this._endureCount == 9)
         {
            this._equ.EquimentInfoData.Endure -= this._reduce;
            this._percent = this._equ.EquimentInfoData.Endure / this._equ.EquimentInfoData.MaxEndure;
            this._bloodBar.width = ConstructionBloodBar.BARWIDTH * this._percent;
            this._equ.removeEventListener(Event.ENTER_FRAME,this.onRepaintEndure);
            this._endureCount = 0;
            this._reduce = 0;
            this._reducePercent = 0;
            this._percent = 0;
            if(this._equ.EquimentInfoData.Endure <= 0)
            {
               ConstructionAction.getInstance().setConstructionDestoryState(this._equ);
            }
            return;
         }
         ++this._endureCount;
      }
   }
}

