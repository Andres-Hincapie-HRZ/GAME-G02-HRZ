package logic.ui
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import logic.entry.GamePlayer;
   import logic.entry.HButton;
   import logic.entry.MObject;
   import logic.game.GameKernel;
   import net.base.NetManager;
   import net.msg.corpsMsg.MSG_REQUEST_CONSORTIAUPDATAVALUE;
   import net.msg.corpsMsg.MSG_RESP_CONSORTIAUPDATAVALUE;
   
   public class MyCorpsUI_EquipmentManage extends AbstractPopUp
   {
      
      private static var instance:MyCorpsUI_EquipmentManage;
      
      private var btn_ensure:HButton;
      
      public function MyCorpsUI_EquipmentManage()
      {
         super();
         setPopUpName("MyCorpsUI_EquipmentManage");
      }
      
      public static function getInstance() : MyCorpsUI_EquipmentManage
      {
         if(instance == null)
         {
            instance = new MyCorpsUI_EquipmentManage();
         }
         return instance;
      }
      
      override public function Init() : void
      {
         if(GameKernel.popUpDisplayManager.PopDisplayList.ContainsKey(getPopUpName()))
         {
            return;
         }
         this._mc = new MObject("EquipmentmanageMcPop",385,300);
         this.initMcElement();
         GameKernel.popUpDisplayManager.Regisger(instance);
      }
      
      override public function initMcElement() : void
      {
         var _loc1_:HButton = null;
         var _loc2_:MovieClip = null;
         _loc2_ = this._mc.getMC().getChildByName("btn_close") as MovieClip;
         _loc1_ = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.CloseClick);
         _loc2_ = this._mc.getMC().getChildByName("btn_ensure") as MovieClip;
         this.btn_ensure = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.btn_ensureClick);
         TextField(this._mc.getMC().tf_composenum).restrict = "0-9";
         TextField(this._mc.getMC().tf_mallnum).restrict = "0-9";
      }
      
      private function CloseClick(param1:MouseEvent) : void
      {
         GameKernel.popUpDisplayManager.Hide(this);
      }
      
      public function Show() : void
      {
         this.Init();
         this.ShowValue();
         this.btn_ensure.setBtnDisabled(GamePlayer.getInstance().ConsortiaJob != 1);
         GameKernel.popUpDisplayManager.Show(this);
      }
      
      private function ShowValue() : void
      {
         TextField(this._mc.getMC().tf_composenum).text = GamePlayer.getInstance().ConsortiaUnionValue.toString();
         TextField(this._mc.getMC().tf_mallnum).text = GamePlayer.getInstance().ConsortiaShopValue.toString();
      }
      
      private function btn_ensureClick(param1:MouseEvent) : void
      {
         var _loc2_:TextField = TextField(this._mc.getMC().tf_composenum);
         _loc2_.text = _loc2_.text.replace(/^\s*/g,"");
         _loc2_.text = _loc2_.text.replace(/\s*$/g,"");
         if(_loc2_.text == "")
         {
            this.ShowValue();
            return;
         }
         var _loc3_:TextField = TextField(this._mc.getMC().tf_mallnum);
         _loc3_.text = _loc3_.text.replace(/^\s*/g,"");
         _loc3_.text = _loc3_.text.replace(/\s*$/g,"");
         if(_loc3_.text == "")
         {
            this.ShowValue();
            return;
         }
         var _loc4_:MSG_REQUEST_CONSORTIAUPDATAVALUE = new MSG_REQUEST_CONSORTIAUPDATAVALUE();
         _loc4_.NeedUnionValue = int(TextField(this._mc.getMC().tf_composenum).text);
         _loc4_.NeedShopValue = int(TextField(this._mc.getMC().tf_mallnum).text);
         _loc4_.SeqId = GamePlayer.getInstance().seqID++;
         _loc4_.Guid = GamePlayer.getInstance().Guid;
         NetManager.Instance().sendObject(_loc4_);
         this.CloseClick(null);
      }
      
      public function RespUpdateValue(param1:MSG_RESP_CONSORTIAUPDATAVALUE) : void
      {
         GamePlayer.getInstance().ConsortiaUnionValue = param1.NeedUnionValue;
         GamePlayer.getInstance().ConsortiaShopValue = param1.NeedShopValue;
      }
   }
}

