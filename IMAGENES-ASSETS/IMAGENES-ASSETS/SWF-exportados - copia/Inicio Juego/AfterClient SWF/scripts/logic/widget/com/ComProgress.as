package logic.widget.com
{
   import com.star.frameworks.display.Container;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import logic.game.GameKernel;
   
   public class ComProgress extends Component
   {
      
      private var _progress:Container;
      
      private var _borderBase:Bitmap;
      
      private var _dynProgress:Bitmap;
      
      public function ComProgress(param1:ComFormat)
      {
         super();
         setType(ComFormat.PROGRESS);
         setFormat(param1);
         setName(getFormat().name);
         setRect(getFormat().rectangle);
      }
      
      override public function Init() : void
      {
         this._borderBase = new Bitmap(GameKernel.getTextureInstance("planbarbg"));
         this._dynProgress = new Bitmap(GameKernel.getTextureInstance("planbar"));
         this._dynProgress.name = getName() + ComFormat.PROGRESS;
         this._dynProgress.x = getRect().x + 10;
         this._dynProgress.y = getRect().x + 10;
         this._progress = new Container();
         this._progress.name = getName();
         this._progress.x = getRect().x;
         this._progress.y = getRect().y;
         this._progress.visible = getFormat().visible;
         this._progress.addChild(this._borderBase);
         this._progress.addChild(this._dynProgress);
      }
      
      override public function getComponent() : DisplayObject
      {
         return this._progress;
      }
   }
}

