package logic.widget.com
{
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import logic.game.GameKernel;
   
   public class ComTexture extends Component
   {
      
      private var _texture:Bitmap;
      
      public function ComTexture(param1:ComFormat)
      {
         super();
         setType("ComText");
         setFormat(param1);
         setName(getFormat().name);
         setRect(getFormat().rectangle);
      }
      
      override public function Init() : void
      {
         if(getFormat().texture == "")
         {
            this._texture = new Bitmap();
         }
         else
         {
            this._texture = new Bitmap(GameKernel.getTextureInstance(getFormat().texture));
            this._texture.x = getRect().x;
            this._texture.y = getRect().y;
            this._texture.width = getRect().width;
            this._texture.height = getRect().height;
         }
      }
      
      override public function getComponent() : DisplayObject
      {
         return this._texture;
      }
   }
}

