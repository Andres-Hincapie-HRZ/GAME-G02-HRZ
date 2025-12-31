package logic.ui.tip
{
   import flash.geom.Point;
   import flash.text.TextField;
   import logic.entry.GamePlayer;
   import logic.ui.info.AbstractInfoDecorate;
   import logic.widget.com.ComFormat;
   
   public class CustomTip
   {
      
      private static var instance:CustomTip;
      
      public static var isShow:Boolean = false;
      
      private var infoDecorate:AbstractInfoDecorate;
      
      public function CustomTip()
      {
         super();
         this.infoDecorate = new AbstractInfoDecorate();
         this.infoDecorate.Load("CustomTip");
      }
      
      public static function GetInstance() : CustomTip
      {
         if(instance == null)
         {
            instance = new CustomTip();
         }
         return instance;
      }
      
      public function get InfoDecorat() : AbstractInfoDecorate
      {
         return this.infoDecorate;
      }
      
      public function Hide() : void
      {
         this.infoDecorate.Hide();
         isShow = false;
      }
      
      public function Show(param1:String, param2:Point, param3:Boolean = false, param4:int = 0) : void
      {
         var _loc5_:Object = this.infoDecorate.ToolTip.getObject("Content");
         var _loc6_:TextField = _loc5_.Display as TextField;
         if(param4 > 0)
         {
            _loc6_.width = param4;
         }
         else
         {
            _loc6_.width = ComFormat(_loc5_.Format).rectangle.width;
         }
         this.infoDecorate.Update("Content",param1);
         this.infoDecorate.putDecorate();
         this.infoDecorate.Show(param2.x,param2.y);
         isShow = true;
      }
      
      public function ShowTip(param1:String, param2:Point, param3:Boolean = false) : void
      {
         var _loc4_:Object = this.infoDecorate.ToolTip.getObject("Content");
         var _loc5_:TextField = _loc4_.Display as TextField;
         _loc5_.width = 150;
         this.infoDecorate.Update("Content",param1);
         this.infoDecorate.putDecorate();
         this.infoDecorate.ShowTip(param2.x,param2.y);
         isShow = true;
      }
      
      public function Update(param1:String) : void
      {
         if(isShow)
         {
            this.infoDecorate.Update("Content",param1);
         }
         this.infoDecorate.putDecorate();
      }
      
      public function GetStringText(param1:String, param2:String, param3:Boolean = true) : String
      {
         var _loc4_:* = null;
         if(GamePlayer.getInstance().language == 10)
         {
            return param2 + param1;
         }
         if(param3)
         {
            _loc4_ = "<font color=\'#ccba7a\'>" + param1 + "</font>" + "<font  color=\'#FFFFFF\'>" + param2 + "</font>";
         }
         else
         {
            _loc4_ = "<font color=\'#FF0000\'>" + param1 + param2 + "</font>";
         }
         return _loc4_;
      }
      
      public function GetNumberText(param1:String, param2:String, param3:Boolean = true) : String
      {
         var _loc4_:* = null;
         if(GamePlayer.getInstance().language == 10)
         {
            return param2 + param1;
         }
         if(param3)
         {
            _loc4_ = "<font color=\'#ccba7a\'>" + param1 + "</font>" + "<font color=\'#00ff00\'>" + param2 + "</font>";
         }
         else
         {
            _loc4_ = "<font color=\'#FF0000\'>" + param1 + param2 + "</font>";
         }
         return _loc4_;
      }
   }
}

