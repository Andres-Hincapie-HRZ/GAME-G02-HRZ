package logic.widget
{
   import com.star.frameworks.display.Container;
   import flash.display.Bitmap;
   import flash.geom.Point;
   import logic.action.OutSideGalaxiasAction;
   import logic.action.StarSurfaceAction;
   import logic.entry.Equiment;
   import logic.entry.EquimentTypeEnum;
   import logic.entry.blurprint.EquimentBlueprint;
   import logic.game.GameKernel;
   import logic.manager.ConstructionRepairManager;
   import logic.manager.FightSectionManager;
   import logic.manager.GalaxyShipManager;
   import logic.reader.CConstructionReader;
   
   public class ConprogressToolBar
   {
      
      public static const BARWIDTH:int = 66;
      
      private var isCompleted:Boolean;
      
      private var _toolW:int;
      
      private var _toolH:int;
      
      private var _curW:int;
      
      private var _cuH:int;
      
      private var _mc:Container;
      
      private var _block:Bitmap;
      
      private var _precess:Bitmap;
      
      private var _costTime:int;
      
      private var _parent:Equiment;
      
      public function ConprogressToolBar(param1:Equiment, param2:int = 3)
      {
         var _loc4_:Point = null;
         super();
         this._parent = param1;
         this._precess = new Bitmap(GameKernel.getTextureInstance("planbar"));
         this._precess.width = 0;
         this._precess.x = 2;
         this._precess.y = 2;
         this._mc = new Container();
         this._block = new Bitmap(GameKernel.getTextureInstance("planbarbg"));
         this._mc.addChild(this._block);
         this._mc.addChild(this._precess);
         if(param1.BlurPrint.BuildingClass & 1)
         {
            _loc4_ = GalaxyShipManager.getPixel(param1.EquimentInfoData.PosX,param1.EquimentInfoData.PosY);
            if(param1.EquimentInfoData.BuildID == EquimentTypeEnum.EQUIMENT_TYPE_SPACESTATION)
            {
               this._mc.x = _loc4_.x + 20;
               this._mc.y = _loc4_.y;
            }
            else
            {
               this._mc.x = _loc4_.x - (this._block.width >> 1);
               this._mc.y = _loc4_.y - this._block.height;
            }
            if(OutSideGalaxiasAction.getInstance().OutSideDefendContainer == null)
            {
               OutSideGalaxiasAction.getInstance().Init();
            }
            OutSideGalaxiasAction.getInstance().OutSideDefendContainer.addChild(this._mc);
         }
         else
         {
            this._mc.x = param1.EquimentInfoData.PosX + param1.BlurPrint.Center1.x - (this._block.width >> 1);
            this._mc.y = param1.EquimentInfoData.PosY + param1.BlurPrint.Center1.y - (this._block.height >> 1);
            StarSurfaceAction.getInstance().SurFaceContainer.addChild(this._mc);
         }
         var _loc3_:EquimentBlueprint = CConstructionReader.getInstance().Read(this._parent.EquimentInfoData.BuildID,this._parent.EquimentInfoData.LevelId + 1);
         if(this._parent.BlurPrint.BuildingClass & 1)
         {
            this._costTime = _loc3_.defendLevel.needTime;
         }
         else
         {
            this._costTime = _loc3_.equimentLevel.needTime;
         }
         if(FightSectionManager.fightingFlag)
         {
            ConstructionRepairManager.setRepairState(param1);
         }
         else
         {
            ConstructionRepairManager.setRepairState(param1,false);
         }
         this.setProgressState();
      }
      
      public function get ToolWidth() : int
      {
         return this._toolW;
      }
      
      public function get ToolHeight() : int
      {
         return this._toolH;
      }
      
      public function get CurrentWidth() : int
      {
         return this._curW;
      }
      
      public function get CurrentHeight() : int
      {
         return this._cuH;
      }
      
      public function set CurrentWidth(param1:int) : void
      {
         this._curW = param1;
      }
      
      public function set CurrentHeight(param1:int) : void
      {
         this._cuH = param1;
      }
      
      public function get ToolBar() : Container
      {
         return this._mc;
      }
      
      public function get IsCompleted() : Boolean
      {
         return this.isCompleted;
      }
      
      public function get CostTime() : int
      {
         return this._costTime;
      }
      
      public function get Parent() : Equiment
      {
         return this._parent;
      }
      
      public function setProgressState() : void
      {
         this._precess.width = (this._costTime - Math.max(0,this._parent.EquimentInfoData.needTime - 1)) / this._costTime * ConprogressToolBar.BARWIDTH;
      }
      
      public function setCompleteState() : void
      {
         if(Boolean(this._precess) && Boolean(this._block))
         {
            this._precess.width = ConprogressToolBar.BARWIDTH;
         }
      }
      
      public function Release() : void
      {
         if(this._parent)
         {
            if(Boolean(this._mc) && Boolean(this._mc.parent))
            {
               this._mc.parent.removeChild(this._mc);
               this._mc = null;
               this._parent = null;
            }
         }
      }
      
      public function setProcess() : void
      {
         if(this._parent.EquimentInfoData.needTime > 0)
         {
            this._precess.width = (this._costTime - (this._parent.EquimentInfoData.needTime - 1)) / this._costTime * ConprogressToolBar.BARWIDTH;
         }
         else
         {
            this._precess.width = this._block.width;
            this.isCompleted = true;
            this.Destory();
         }
      }
      
      private function Destory() : void
      {
         this._mc.graphics.clear();
         this._precess = null;
         this._block = null;
      }
   }
}

