package logic.ui
{
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import logic.entry.HButton;
   import logic.entry.MObject;
   import logic.entry.props.propsInfo;
   import logic.game.GameKernel;
   import logic.reader.CPropsReader;
   import logic.utils.UpdateResource;
   
   public class RaidProps_SelectProps extends AbstractPopUp
   {
      
      private static var instance:RaidProps_SelectProps;
      
      private var _OnSelected:Function;
      
      private var _TypeId:int;
      
      private var RaidPropsList:Array;
      
      private var _PropsTip:MovieClip;
      
      public function RaidProps_SelectProps()
      {
         super();
         setPopUpName("RaidProps_SelectProps");
      }
      
      public static function getInstance() : RaidProps_SelectProps
      {
         if(instance == null)
         {
            instance = new RaidProps_SelectProps();
         }
         return instance;
      }
      
      override public function Init() : void
      {
         if(GameKernel.popUpDisplayManager.PopDisplayList.ContainsKey(getPopUpName()))
         {
            this.Clear();
            return;
         }
         this._mc = new MObject("StorehousePop1",385,300);
         this.initMcElement();
         this.Clear();
         GameKernel.popUpDisplayManager.Regisger(instance);
      }
      
      override public function initMcElement() : void
      {
         var _loc1_:HButton = null;
         var _loc2_:MovieClip = null;
         var _loc4_:MovieClip = null;
         var _loc5_:XMovieClip = null;
         _loc2_ = this._mc.getMC().getChildByName("btn_close") as MovieClip;
         _loc1_ = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.CloseClick);
         var _loc3_:int = 0;
         while(_loc3_ < 4)
         {
            _loc4_ = this._mc.getMC().getChildByName("mc_list" + _loc3_) as MovieClip;
            _loc4_.stop();
            _loc5_ = new XMovieClip(_loc4_);
            _loc5_.Data = _loc3_;
            _loc5_.OnClick = this.ItemClick;
            _loc5_.OnMouseOver = this.ItemOver;
            _loc4_.addEventListener(MouseEvent.MOUSE_OUT,this.ItemOut);
            _loc3_++;
         }
      }
      
      private function ItemOut(param1:MouseEvent) : void
      {
         if(this._PropsTip != null && this._PropsTip.parent != null && this._PropsTip.parent.contains(this._PropsTip))
         {
            this._PropsTip.parent.removeChild(this._PropsTip);
         }
      }
      
      private function ItemOver(param1:MouseEvent, param2:XMovieClip) : void
      {
         var _loc3_:propsInfo = this.RaidPropsList[param2.Data];
         this.ShowPropsTip(param2.m_movie,_loc3_.Id);
      }
      
      private function ShowPropsTip(param1:MovieClip, param2:int) : void
      {
         var _loc3_:Point = null;
         _loc3_ = param1.localToGlobal(new Point(0,param1.height));
         _loc3_ = this._mc.getMC().globalToLocal(_loc3_);
         this._PropsTip = PackUi.getInstance().TipHd(_loc3_.x,_loc3_.y,param2,true);
         this._PropsTip.x = _loc3_.x;
         this._PropsTip.y = _loc3_.y;
         this._mc.getMC().addChild(this._PropsTip);
      }
      
      private function ItemClick(param1:MouseEvent, param2:XMovieClip) : void
      {
         if(param2.m_movie.currentFrame == 3)
         {
            return;
         }
         var _loc3_:propsInfo = this.RaidPropsList[param2.Data];
         this.CloseClick(null);
         if(this._OnSelected != null)
         {
            this._OnSelected(_loc3_.Id);
         }
      }
      
      private function CloseClick(param1:Event) : void
      {
         GameKernel.popUpDisplayManager.Hide(this);
      }
      
      private function Clear() : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:propsInfo = null;
         var _loc4_:int = 0;
         var _loc5_:Sprite = null;
         var _loc6_:Bitmap = null;
         if(this._TypeId == 42)
         {
            this.RaidPropsList = CPropsReader.getInstance().RaidPropsList42;
         }
         else
         {
            this.RaidPropsList = CPropsReader.getInstance().RaidPropsList43;
         }
         var _loc1_:int = 0;
         while(_loc1_ < 4)
         {
            _loc2_ = this._mc.getMC().getChildByName("mc_list" + _loc1_) as MovieClip;
            _loc3_ = propsInfo(this.RaidPropsList[_loc1_]);
            _loc4_ = UpdateResource.getInstance().GetPropsNum(_loc3_.Id);
            if(_loc4_ == 0)
            {
               _loc2_.gotoAndStop(3);
            }
            else
            {
               _loc2_.gotoAndStop(1);
            }
            TextField(_loc2_.tf_num).text = _loc4_.toString();
            _loc5_ = Sprite(_loc2_.mc_base);
            _loc6_ = new Bitmap(GameKernel.getTextureInstance(_loc3_.ImageFileName));
            if(_loc5_.numChildren > 0)
            {
               _loc5_.removeChildAt(0);
            }
            _loc5_.addChildAt(_loc6_,0);
            _loc1_++;
         }
      }
      
      public function Show(param1:int, param2:Function) : void
      {
         this._TypeId = param1;
         this._OnSelected = param2;
         this.Init();
         GameKernel.popUpDisplayManager.Show(this);
      }
   }
}

