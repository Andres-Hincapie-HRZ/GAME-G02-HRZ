package logic.ui
{
   import com.star.frameworks.display.Container;
   import com.star.frameworks.facebook.FacebookUserInfo;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.StyleSheet;
   import flash.text.TextField;
   import logic.action.ChatAction;
   import logic.entry.HButton;
   import logic.entry.MObject;
   import logic.game.GameKernel;
   import net.msg.field.MSG_RESP_FIELDRESOURCELOG;
   import net.msg.field.MSG_RESP_FIELDRESOURCELOG_TEMP;
   
   public class FieldUI_DomainPop extends AbstractPopUp
   {
      
      private static var instance:FieldUI_DomainPop;
      
      private var LogMsg:MSG_RESP_FIELDRESOURCELOG;
      
      private var UserIdList:Array;
      
      private var UserNameList:Array;
      
      private var ParentLock:Container;
      
      private var SelectedRow:MovieClip;
      
      public function FieldUI_DomainPop()
      {
         super();
         setPopUpName("DomainPop");
      }
      
      public static function getInstance() : FieldUI_DomainPop
      {
         if(instance == null)
         {
            instance = new FieldUI_DomainPop();
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
         this._mc = new MObject("DomainPop",GameKernel.fullRect.width >> 1,300);
         this.initMcElement();
         this.Clear();
         GameKernel.popUpDisplayManager.Regisger(instance);
      }
      
      override public function initMcElement() : void
      {
         var _loc1_:HButton = null;
         var _loc2_:MovieClip = null;
         _loc2_ = this._mc.getMC().getChildByName("btn_close") as MovieClip;
         _loc1_ = new HButton(_loc2_);
         _loc2_.addEventListener(MouseEvent.CLICK,this.CloseClick);
         var _loc3_:int = 0;
         while(_loc3_ < 15)
         {
            _loc2_ = this._mc.getMC().getChildByName("mc_list" + _loc3_) as MovieClip;
            _loc3_++;
         }
         this.UserIdList = new Array();
         this.UserNameList = new Array();
         this.ParentLock = new Container("FieldUI_DomainPopLock");
         this.ParentLock.mouseEnabled = true;
         this.ParentLock.mouseChildren = true;
         this.ParentLock.fillRectangleWithoutBorder(GameKernel.fullRect.x,GameKernel.fullRect.y,GameKernel.fullRect.width,GameKernel.fullRect.height,0,0);
      }
      
      private function Clear() : void
      {
         var _loc1_:MovieClip = null;
         var _loc3_:XTextField = null;
         var _loc4_:String = null;
         var _loc5_:StyleSheet = null;
         var _loc2_:int = 0;
         while(_loc2_ < 15)
         {
            _loc1_ = this._mc.getMC().getChildByName("mc_list" + _loc2_) as MovieClip;
            _loc1_.visible = false;
            _loc3_ = new XTextField(_loc1_.tf_title);
            _loc3_.Data = _loc2_;
            _loc3_.OnClick = this.tf_nameClick;
            _loc4_ = "a:link{text-decoration: underline;} a:hover{color:#ff0000;text-decoration: underline;} a:active{text-decoration: underline;}";
            _loc5_ = new StyleSheet();
            _loc5_.parseCSS(_loc4_);
            _loc1_.tf_title.styleSheet = _loc5_;
            _loc2_++;
         }
      }
      
      private function tf_nameClick(param1:MouseEvent, param2:XTextField) : void
      {
         if(this.LogMsg == null)
         {
            return;
         }
         var _loc3_:MSG_RESP_FIELDRESOURCELOG_TEMP = this.LogMsg.Data[param2.Data];
         ChatAction.getInstance().sendChatUserInfoMessage(-1,_loc3_.Guid,3);
      }
      
      private function CloseClick(param1:Event) : void
      {
         this.Hide();
      }
      
      public function Show() : void
      {
         this.Init();
         this.ParentLock.addChild(this._mc.getMC());
         GameKernel.renderManager.getUI().addComponent(this.ParentLock);
      }
      
      private function Hide() : void
      {
         this.ParentLock.removeChild(this._mc.getMC());
         GameKernel.renderManager.getUI().removeComponent(this.ParentLock);
      }
      
      public function ShowFieldLog(param1:MSG_RESP_FIELDRESOURCELOG) : void
      {
         var _loc2_:MovieClip = null;
         var _loc4_:MSG_RESP_FIELDRESOURCELOG_TEMP = null;
         this.LogMsg = param1;
         this.UserIdList.splice(0);
         this.UserNameList.splice(0);
         var _loc3_:int = 0;
         while(_loc3_ < 15)
         {
            _loc2_ = this._mc.getMC().getChildByName("mc_list" + _loc3_) as MovieClip;
            _loc4_ = param1.Data[_loc3_];
            if(_loc3_ < param1.DataLen)
            {
               _loc2_.visible = true;
               TextField(_loc2_.tf_title).text = "<a href=\'event:\'>" + _loc4_.Name + "(Id:" + _loc4_.Guid + ")" + "</a>";
               TextField(_loc2_.tf_metal).text = _loc4_.Metal.toString();
               TextField(_loc2_.tf_He3).text = _loc4_.Gas.toString();
               TextField(_loc2_.tf_gold).text = _loc4_.Money.toString();
               this.UserIdList.push(_loc4_.UserId);
               this.UserNameList.push(_loc4_.Name);
            }
            else
            {
               _loc2_.visible = false;
            }
            _loc3_++;
         }
         GameKernel.getPlayerFacebookInfoArray(this.UserIdList,this.getPlayerFacebookInfoArrayCallback,this.UserNameList);
      }
      
      private function getPlayerFacebookInfoArrayCallback(param1:Array) : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:FacebookUserInfo = null;
         var _loc4_:int = 0;
         var _loc5_:MSG_RESP_FIELDRESOURCELOG_TEMP = null;
         for each(_loc3_ in param1)
         {
            _loc4_ = 0;
            while(_loc4_ < this.LogMsg.DataLen)
            {
               _loc5_ = this.LogMsg.Data[_loc4_];
               if(_loc5_.UserId == _loc3_.uid)
               {
                  _loc2_ = this._mc.getMC().getChildByName("mc_list" + _loc4_) as MovieClip;
                  TextField(_loc2_.tf_title).text = "<a href=\'event:\'>" + _loc3_.first_name + "(Id:" + _loc5_.Guid + ")" + "</a>";
               }
               _loc4_++;
            }
         }
      }
      
      private function RowMouseOver(param1:MouseEvent) : void
      {
      }
   }
}

