package logic.ui
{
   import com.star.frameworks.events.ActionEvent;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import logic.action.ConstructionAction;
   import logic.entry.EquimentData;
   import logic.entry.MObject;
   import logic.game.GameKernel;
   import logic.manager.GameInterActiveManager;
   
   public class ConstructionDetailCellItem extends MObject
   {
      
      private var _index:int;
      
      private var _data:EquimentData;
      
      private var _nameTF:TextField;
      
      private var _numTF:TextField;
      
      private var _mcBase:MovieClip;
      
      private var _equimentImage:MovieClip;
      
      public function ConstructionDetailCellItem(param1:int, param2:EquimentData)
      {
         super("BuildlistPlan");
         this._index = param1;
         buttonMode = true;
         this._data = param2;
         this.Init();
      }
      
      public function get ConstuctionData() : EquimentData
      {
         return this._data;
      }
      
      private function Init() : void
      {
         this._nameTF = getMC().tf_name as TextField;
         this._numTF = getMC().tf_num as TextField;
         this._mcBase = getMC().mc_base as MovieClip;
         GameInterActiveManager.InstallInterActiveEvent(this._mcBase,ActionEvent.ACTION_CLICK,this.showDetail);
      }
      
      public function setConstructionNum() : void
      {
         var _loc1_:int = ConstructionAction.getInstance().getConstructionCurrentNum(this._data.BuildID);
         var _loc2_:int = ConstructionAction.getInstance().getConstructionMaxNum(this._data.BuildID);
         this._numTF.text = _loc1_.toString() + "/" + _loc2_.toString();
      }
      
      public function setConstructionName() : void
      {
         this._nameTF.text = this._data.BuildName;
      }
      
      public function setConstructionImage() : void
      {
         var _loc1_:String = ConstructionAction.getInstance().getConstructionImage(this._data.BuildID,this._data.LevelId);
         this._equimentImage = GameKernel.getMovieClipInstance(_loc1_);
         this._equimentImage.stop();
         this._equimentImage.scaleX = this._equimentImage.scaleY = 0.4;
         this._equimentImage.x = -10;
         this._equimentImage.y = 25;
         this._mcBase.addChild(this._equimentImage);
      }
      
      private function showDetail(param1:MouseEvent) : void
      {
         ConstructionInfoManagerUI.getInstance().showConstructionDetailList(this._data.BuildID);
      }
      
      public function Clear() : void
      {
         this._equimentImage.stop();
         this._mcBase.removeChild(this._equimentImage);
         this._equimentImage = null;
         GameInterActiveManager.unInstallnterActiveEvent(this._mcBase,ActionEvent.ACTION_CLICK,this.showDetail);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}

