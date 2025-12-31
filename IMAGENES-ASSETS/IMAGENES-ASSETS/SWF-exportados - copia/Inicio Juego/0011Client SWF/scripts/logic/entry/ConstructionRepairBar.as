package logic.entry
{
   import com.star.frameworks.display.Container;
   import flash.display.Bitmap;
   
   public class ConstructionRepairBar
   {
      
      public static const BARWIDTH:int = 66;
      
      private var _container:Container;
      
      private var _bloodBg:Bitmap;
      
      private var _bloodBar:Bitmap;
      
      private var _equ:Equiment;
      
      private var _costTime:int;
      
      private var _isCompleted:Boolean;
      
      public function ConstructionRepairBar(param1:Equiment, param2:int = 0)
      {
         super();
         this._container = new Container();
         this._equ = param1;
         this._isCompleted = false;
      }
      
      public function get RepairBar() : Container
      {
         return this._container;
      }
      
      public function get Construction() : Equiment
      {
         return this._equ;
      }
      
      public function set Construction(param1:Equiment) : void
      {
         this._equ = param1;
      }
      
      public function get IsCompleted() : Boolean
      {
         return this._isCompleted;
      }
      
      public function reSet() : void
      {
         this._bloodBar.width = 0;
      }
      
      public function Destory() : void
      {
      }
      
      public function setProgressState() : void
      {
      }
      
      public function setProcess() : void
      {
         if(++this._equ.EquimentInfoData.needTime >= 0)
         {
            this._isCompleted = true;
         }
      }
   }
}

