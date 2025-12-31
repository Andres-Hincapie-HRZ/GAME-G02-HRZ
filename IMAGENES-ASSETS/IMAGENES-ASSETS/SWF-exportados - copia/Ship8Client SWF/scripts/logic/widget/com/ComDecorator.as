package logic.widget.com
{
   public class ComDecorator
   {
      
      private var _IDecorate:IComponent;
      
      public function ComDecorator(param1:ComFormat)
      {
         super();
         this.Init(param1);
      }
      
      private function Init(param1:ComFormat) : void
      {
         if(param1 == null)
         {
            throw new Error("UI样式对象为空");
         }
         switch(param1.type)
         {
            case ComFormat.TEXT:
               this._IDecorate = new ComText(param1);
               break;
            case ComFormat.IMAGE:
               this._IDecorate = new ComTexture(param1);
               break;
            case ComFormat.PROGRESS:
               this._IDecorate = new ComProgress(param1);
         }
         this._IDecorate.Init();
      }
      
      public function getIDecorate() : IComponent
      {
         return this._IDecorate;
      }
   }
}

