package logic.ui.tip
{
   import com.star.frameworks.managers.StringManager;
   import flash.display.Sprite;
   import flash.geom.Point;
   import logic.entry.props.propsInfo;
   import logic.reader.CPropsReader;
   import net.msg.ChipLottery.CmosInfo;
   
   public class CommanderChipTip
   {
      
      public function CommanderChipTip()
      {
         super();
      }
      
      public static function Show(param1:Sprite, param2:CmosInfo, param3:Boolean = true) : void
      {
         var _loc4_:propsInfo = CPropsReader.getInstance().GetPropsInfo(param2.PropsId);
         var _loc5_:* = "<font color=\'#ccba7a\'>" + StringManager.getInstance().getMessageString("MailText17") + "</font><font color=\'#00ff00\'>" + _loc4_.Name + "</font><br/>";
         _loc5_ = _loc5_ + ("<font color=\'#ccba7a\'>" + StringManager.getInstance().getMessageString("Boss60") + "</font><font color=\'#00ff00\'>" + _loc4_.Comment + "</font><br/>");
         if(param3)
         {
            _loc5_ += "<font color=\'#ccba7a\'>" + StringManager.getInstance().getMessageString("Boss61") + "</font><font color=\'#00ff00\'>" + param2.Exp.toString() + "/" + _loc4_.Exp.toString() + "</font><br/>";
         }
         _loc5_ += "<font color=\'#ccba7a\'>" + StringManager.getInstance().getMessageString("Boss73") + "</font><font color=\'#00ff00\'>" + _loc4_.CostPirateCoin.toString() + StringManager.getInstance().getMessageString("Boss63") + "</font>";
         var _loc6_:Point = param1.localToGlobal(new Point(0,param1.height));
         CustomTip.GetInstance().Show(_loc5_,_loc6_);
      }
      
      public static function Hide() : void
      {
         CustomTip.GetInstance().Hide();
      }
   }
}

