package logic.ui
{
   import com.star.frameworks.facebook.FacebookUserInfo;
   import com.star.frameworks.managers.StringManager;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import logic.action.GalaxyMapAction;
   import logic.entry.GamePlayer;
   import logic.entry.HButton;
   import logic.entry.HButtonType;
   import logic.entry.test.BirthTextField;
   import logic.entry.test.MovieClipDataBox;
   import logic.game.GameKernel;
   import logic.manager.GalaxyManager;
   import net.base.NetManager;
   import net.msg.galaxyMap.MSG_REQUEST_LOOKUPUSERINFO;
   import net.msg.galaxyMap.MSG_RESP_LOOKUPUSERINFO;
   
   public class GotoGalaxyUI extends Sprite
   {
      
      private static var _instance:GotoGalaxyUI = null;
      
      private var _inputX:BirthTextField = new BirthTextField();
      
      private var _inputY:BirthTextField = new BirthTextField();
      
      private var _movie:MovieClip;
      
      private var _movieData:MovieClipDataBox;
      
      private var _inputGalaxy:TextField;
      
      private var _input_X:TextField;
      
      private var _input_Y:TextField;
      
      private var _content:TextField;
      
      private var _msg:MSG_RESP_LOOKUPUSERINFO;
      
      public function GotoGalaxyUI(param1:HHH)
      {
         super();
         this.InitMcElement();
      }
      
      public static function get instance() : GotoGalaxyUI
      {
         if(_instance == null)
         {
            _instance = new GotoGalaxyUI(new HHH());
         }
         return _instance;
      }
      
      public function Init() : void
      {
         this.x = this.y = 100;
         GalaxyMapAction.instance.getUI().addChild(this);
      }
      
      private function InitMcElement() : void
      {
         this._movie = GameKernel.getMovieClipInstance("GalaxymapPopup");
         this._movie.x = 132;
         this._movie.y = 121;
         addChild(this._movie);
         this._movieData = new MovieClipDataBox(this._movie,true);
         var _loc1_:Sprite = new Sprite();
         _loc1_.graphics.beginFill(7782,0.01);
         _loc1_.graphics.drawRect(5,5,70,20);
         _loc1_.graphics.endFill();
         _loc1_.addEventListener(MouseEvent.MOUSE_DOWN,this._startDrag);
         _loc1_.addEventListener(MouseEvent.MOUSE_UP,this._stopDrag);
         addChild(_loc1_);
         this._inputGalaxy = this._movieData.getTF("tf_input");
         this._inputGalaxy.addEventListener(Event.CHANGE,this.onInput);
         this._inputGalaxy.addEventListener(MouseEvent.CLICK,this.onClick);
         this._input_X = this._movieData.getTF("tf_x");
         this._input_X.addEventListener(Event.CHANGE,this.onInput);
         this._input_X.addEventListener(MouseEvent.CLICK,this.onClick);
         this._input_Y = this._movieData.getTF("tf_y");
         this._input_Y.addEventListener(Event.CHANGE,this.onInput);
         this._input_Y.addEventListener(MouseEvent.CLICK,this.onClick);
         this._content = this._movieData.getTF("tf_content");
         this._content.autoSize = TextFieldAutoSize.CENTER;
         this._content.multiline = true;
         var _loc2_:HButton = new HButton(this._movie.btn_search,HButtonType.SIMPLE,false,StringManager.getInstance().getMessageString("IconText40"));
         this._movieData.getMC("btn_search").addEventListener(MouseEvent.CLICK,this.onClick);
         this._movieData.getMC("btn_cancel").addEventListener(MouseEvent.CLICK,this.onClick);
         var _loc3_:HButton = new HButton(this._movie.btn_collection);
         _loc3_.setBtnDisabled(true);
         this._movieData.getMC("btn_collection").addEventListener(MouseEvent.CLICK,this.onClick);
         this._movieData.getMC("btn_place").addEventListener(MouseEvent.CLICK,this.onClick);
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         var _loc2_:Point = null;
         switch(param1.target.name)
         {
            case "tf_input":
               this._inputGalaxy.text = "";
               break;
            case "tf_x":
               this._input_X.text = "";
               break;
            case "tf_y":
               this._input_Y.text = "";
               break;
            case "btn_search":
               this.onSearch();
               break;
            case "btn_cancel":
               this.Release();
               break;
            case "btn_collection":
               break;
            case "btn_place":
               if(this._msg)
               {
                  _loc2_ = GalaxyManager.getStarCoordinate(this._msg.GalaxyId);
                  this.GotoGalaxy(_loc2_.x,_loc2_.y);
               }
         }
      }
      
      private function onInput(param1:Event) : void
      {
         var _loc2_:RegExp = /[0-9]$/;
         switch(param1.target.name)
         {
            case "tf_input":
               if(!_loc2_.test(this._inputGalaxy.text))
               {
                  this._inputGalaxy.text = "";
               }
               break;
            case "tf_x":
               if(!_loc2_.test(this._input_X.text))
               {
                  this._input_X.text = "";
               }
               if(parseInt(this._input_X.text) > GalaxyManager.MAX_MAPAREAGRID_X)
               {
                  this._input_X.text = "" + GalaxyManager.MAX_MAPAREAGRID_X;
               }
               break;
            case "tf_y":
               if(!_loc2_.test(this._input_Y.text))
               {
                  this._input_Y.text = "";
               }
               if(parseInt(this._input_Y.text) > GalaxyManager.MAX_MAPAREAGRID)
               {
                  this._input_Y.text = "" + GalaxyManager.MAX_MAPAREAGRID;
               }
         }
      }
      
      private function InitUI() : void
      {
      }
      
      private function _startDrag(param1:MouseEvent) : void
      {
         startDrag();
      }
      
      private function _stopDrag(param1:MouseEvent) : void
      {
         stopDrag();
      }
      
      private function onSearch(param1:MouseEvent = null) : void
      {
         var _loc3_:int = 0;
         var _loc2_:MSG_REQUEST_LOOKUPUSERINFO = new MSG_REQUEST_LOOKUPUSERINFO();
         if(this._inputGalaxy.text.length > 0)
         {
            _loc2_.ObjGuid = parseInt(this._inputGalaxy.text);
         }
         else
         {
            _loc2_.ObjGuid = -1;
         }
         if(this._input_X.text.length > 0 && this._input_Y.text.length > 0)
         {
            _loc3_ = parseInt(this._input_X.text) * GalaxyManager.MAX_MAPAREAGRID + parseInt(this._input_Y.text);
            _loc2_.ObjGalaxyId = _loc3_;
         }
         else
         {
            _loc2_.ObjGalaxyId = -1;
         }
         if(_loc2_.ObjGuid != -1 || _loc2_.ObjGalaxyId != -1)
         {
            _loc2_.Guid = GamePlayer.getInstance().Guid;
            _loc2_.SeqId = GamePlayer.getInstance().seqID++;
            NetManager.Instance().sendObject(_loc2_);
         }
      }
      
      public function GotoGalaxy(param1:int, param2:int) : void
      {
         param1 -= 15;
         param2 -= 15;
         var _loc3_:int = param1;
         var _loc4_:int = param2;
         if(_loc3_ < -10)
         {
            _loc3_ = -10;
         }
         if(_loc4_ < -10)
         {
            _loc4_ = -10;
         }
         GalaxyMapAction.instance.requestAreas(param1,param2);
         GalaxyManager.instance.printCacheStar(_loc3_,_loc4_);
      }
      
      public function GotoGalaxyCallBack(param1:MSG_RESP_LOOKUPUSERINFO) : void
      {
         var _loc2_:Point = null;
         this._msg = param1;
         if(param1.Guid == -1)
         {
            _loc2_ = GalaxyManager.getStarCoordinate(param1.GalaxyId);
            this._content.text = "there\'s none player at X:" + _loc2_.x + " Y:" + _loc2_.y;
         }
         else
         {
            this._content.text = param1.UserName + "ID:" + param1.Guid + "(" + param1.PosX + "," + param1.PosY + ")";
            GameKernel.getPlayerFacebookInfo(param1.UserId,this.getPlayerFacebookInfoCallback,param1.UserName);
         }
      }
      
      private function getPlayerFacebookInfoCallback(param1:FacebookUserInfo) : void
      {
         if(this._msg != null && param1 != null && this._msg.UserId == param1.uid)
         {
            this._content.text = param1.first_name + "ID:" + this._msg.Guid + "(" + this._msg.PosX + "," + this._msg.PosY + ")";
         }
      }
      
      public function Release(param1:MouseEvent = null) : void
      {
         GalaxyMapAction.instance.getUI().removeChild(this);
         this._msg = null;
      }
   }
}

class HHH
{
   
   public function HHH()
   {
      super();
   }
}
