package logic.ui.tip
{
   import flash.geom.Point;
   import logic.entry.props.propsInfo;
   import logic.reader.CPropsReader;
   import logic.ui.info.AbstractInfoDecorate;
   
   public class PropsTip
   {
      
      private static var instance:PropsTip;
      
      private var infoDecorate:AbstractInfoDecorate;
      
      public function PropsTip()
      {
         super();
         this.infoDecorate = new AbstractInfoDecorate();
         this.infoDecorate.Load("PropsInfoTip");
      }
      
      public static function GetInstance() : PropsTip
      {
         if(instance == null)
         {
            instance = new PropsTip();
         }
         return instance;
      }
      
      public function Hide() : void
      {
         this.infoDecorate.Hide();
      }
      
      public function Show(param1:int, param2:Point) : void
      {
         var _loc3_:propsInfo = CPropsReader.getInstance().GetPropsInfo(param1);
         this.infoDecorate.Update("PropsName",_loc3_.Name);
         this.infoDecorate.Update("Comment",_loc3_.Comment);
         this.infoDecorate.putDecorate();
         this.infoDecorate.Show(param2.x,param2.y);
      }
   }
}

