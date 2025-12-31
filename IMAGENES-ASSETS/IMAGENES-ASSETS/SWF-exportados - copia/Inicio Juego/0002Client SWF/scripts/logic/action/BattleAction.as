package logic.action
{
   import com.star.frameworks.display.Container;
   import com.star.frameworks.facebook.FacebookUserInfo;
   import com.star.frameworks.utils.MusicResHandler;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import logic.entry.AbstraceAction;
   import logic.entry.EffectShake2;
   import logic.entry.GShip;
   import logic.entry.GShipTeam;
   import logic.entry.shipmodel.ShippartInfo;
   import logic.game.GameFont;
   import logic.game.GameKernel;
   import logic.game.GameSetting;
   import logic.reader.CShipmodelReader;
   import logic.ui.AlignManager;
   import logic.ui.CommanderSceneUI;
   import net.common.MsgTypes;
   import net.msg.fightMsg.MSG_RESP_FIGHTSECTION;
   import net.msg.ship.MSG_RESP_SHIPFIGHT;
   
   public class BattleAction extends AbstraceAction
   {
      
      public static const E_CONSTRUCT:int = 1;
      
      public static const E_SHIELD:int = 2;
      
      public static const E_ELECTRONIC:int = 3;
      
      public static const E_AIR_DEFENCE:int = 4;
      
      public static const E_JUMP:int = 5;
      
      public static const E_STONE:int = 6;
      
      public static const E_STAR:int = 11;
      
      public static const E_CONNON:int = 12;
      
      public static const E_LASER:int = 13;
      
      public static const E_MISSILE:int = 14;
      
      public static const E_SHIPBASED:int = 15;
      
      public static const E_BleedNum:int = 100;
      
      public static const E_BOMB:int = 101;
      
      public static const E_BOMB2:int = 102;
      
      public static const E_BOMB3:int = 103;
      
      public static const E_LOCK:int = 104;
      
      public static const E_COMMANDERA:int = 105;
      
      public static const E_COMMANDERB:int = 106;
      
      public static const E_THOR:int = 107;
      
      public static const E_FLACK:int = 108;
      
      public static const E_PARTICLE:int = 109;
      
      public static const E_SHIPBLAST:int = 110;
      
      public static const E_MISS:int = 111;
      
      public static const E_LOCK2:int = 112;
      
      public static const E_LOCK3:int = 113;
      
      public static const E_THOR2:int = 114;
      
      public static const E_CONNON2:int = 120;
      
      public static const E_LASER2:int = 130;
      
      public static const E_MISSILE2:int = 140;
      
      public static const E_SHIPBASED2:int = 150;
      
      public static const E_SPACE:int = 151;
      
      public static const GRID_WIDTH:int = 150;
      
      public static const GRID_HEIGHT:int = 60;
      
      public static const GRID_COUNT:int = 9;
      
      public static var srcShipTeamID:TextField = new TextField();
      
      public static var objShipTeamID:TextField = new TextField();
      
      private static var _instance:BattleAction = null;
      
      private var _srcPosArr:Array;
      
      private var _objPosArr:Array;
      
      private var _bg:Bitmap;
      
      private var _scene:Container;
      
      private var _lineSprite:Sprite;
      
      private var _target:Sprite;
      
      private var _gamePartInfo:MovieClip;
      
      private var _srcPartInfo:MovieClip;
      
      private var _objPartInfo:MovieClip;
      
      private var _srcRubbish:Array;
      
      private var _objRubbish:Array;
      
      private var _srcEffRubbish:Array;
      
      private var _objEffRubbish:Array;
      
      private var _srcCommandImg:Bitmap;
      
      private var _objCommandImg:Bitmap;
      
      private var _SrcPartId:Array;
      
      private var _SrcPartNum:Array;
      
      private var _SrcPartRate:Array;
      
      private var _ObjPartId:Array;
      
      private var _ObjPartNum:Array;
      
      private var srcPercent:Number;
      
      private var srcCount:int = 0;
      
      private var srcShipTeam:GShipTeam;
      
      private var srcReduceSupply:int;
      
      private var srcReduceStorage:int;
      
      private var src_01_RSup:int;
      
      private var src_01_RSto:int;
      
      private var objPercent:Number;
      
      private var objCount:int = 0;
      
      private var objShipTeam:GShipTeam;
      
      private var objReduceSupply:int;
      
      private var objReduceStorage:int;
      
      private var obj_01_RSup:int;
      
      private var obj_01_RSto:int;
      
      private var shakeEffect:EffectShake2;
      
      public function BattleAction(param1:HHH)
      {
         var _loc7_:MovieClip = null;
         var _loc8_:Bitmap = null;
         var _loc9_:Bitmap = null;
         var _loc10_:Bitmap = null;
         var _loc11_:Bitmap = null;
         this._srcPosArr = new Array([2,5],[2,4],[2,3],[1,5],[1,4],[1,3],[0,5],[0,4],[0,3]);
         this._objPosArr = new Array([6,5],[6,4],[6,3],[7,5],[7,4],[7,3],[8,5],[8,4],[8,3]);
         this._lineSprite = new Sprite();
         this._target = new Sprite();
         this._srcRubbish = new Array();
         this._objRubbish = new Array();
         this._srcEffRubbish = new Array();
         this._objEffRubbish = new Array();
         this.shakeEffect = new EffectShake2(60);
         super();
         super.ActionName = "Map_Battle_Action";
         this._bg = new Bitmap();
         this._bg.bitmapData = GameKernel.getTextureInstance("Map2");
         AlignManager.GetInstance().SetAlign(this._bg,"none");
         this._scene = new Container("Battle");
         this._scene.addChild(this._bg);
         this._gamePartInfo = GameKernel.getMovieClipInstance("BattleScene");
         this._gamePartInfo.x = (GameSetting.GAME_STAGE_WIDTH - this._gamePartInfo.width) / 2;
         this._scene.addChild(this._gamePartInfo);
         var _loc2_:MovieClip = GameKernel.getMovieClipInstance("BattlebgMc2");
         _loc2_.x = 30 + this._gamePartInfo.x;
         _loc2_.y = 190;
         _loc2_.mouseEnabled = false;
         this._scene.addChild(_loc2_);
         var _loc3_:MovieClip = GameKernel.getMovieClipInstance("BattlebgMc3");
         _loc3_.x = 360 + this._gamePartInfo.x;
         _loc3_.y = 340;
         _loc3_.mouseEnabled = false;
         this._scene.addChild(_loc3_);
         this._scene.addChild(this._lineSprite);
         var _loc4_:int = -1;
         var _loc5_:int = -1;
         var _loc6_:int = 0;
         while(_loc6_ < this._srcPosArr.length)
         {
            _loc4_ = int(this._srcPosArr[_loc6_][0]);
            _loc5_ = int(this._srcPosArr[_loc6_][1]);
            _loc8_ = new Bitmap();
            _loc8_.name = "SRC_NUM_" + _loc6_;
            _loc8_.x = this._gamePartInfo.x + GRID_WIDTH * 0.5 * (GRID_COUNT - _loc5_ + _loc4_) - 0.5 * GRID_WIDTH - 180;
            _loc8_.y = GRID_HEIGHT * 0.5 * (_loc4_ + _loc5_ + 1) + 90;
            this._lineSprite.addChild(_loc8_);
            _loc4_ = int(this._objPosArr[_loc6_][0]);
            _loc5_ = int(this._objPosArr[_loc6_][1]);
            _loc9_ = new Bitmap();
            _loc9_.name = "OBJ_NUM_" + _loc6_;
            _loc9_.x = this._gamePartInfo.x + GRID_WIDTH * 0.5 * (GRID_COUNT - _loc5_ - 2 + _loc4_ - 2) - 0.5 * GRID_WIDTH;
            _loc9_.y = GRID_HEIGHT * 0.5 * (_loc4_ + _loc5_ + 1 - 1) + 90;
            this._lineSprite.addChild(_loc9_);
            _loc6_++;
         }
         srcShipTeamID.x = 50;
         srcShipTeamID.y = 300;
         srcShipTeamID.width = 200;
         srcShipTeamID.height = 20;
         srcShipTeamID.textColor = 16777215;
         this._scene.addChild(srcShipTeamID);
         objShipTeamID.x = 50;
         objShipTeamID.y = 330;
         objShipTeamID.width = 200;
         objShipTeamID.height = 20;
         objShipTeamID.textColor = 16777215;
         this._scene.addChild(objShipTeamID);
         _loc6_ = 0;
         while(_loc6_ < MsgTypes.MAX_MSG_PART)
         {
            _loc7_ = this._gamePartInfo.getChildByName("mc_srclist" + _loc6_) as MovieClip;
            _loc7_.gotoAndStop(1);
            (_loc7_.tf_num as TextField).text = "";
            _loc10_ = new Bitmap();
            _loc10_.name = "srcBmp";
            _loc10_.scaleX = _loc10_.scaleY = 0.75;
            _loc7_.addChild(_loc10_);
            _loc7_ = this._gamePartInfo.getChildByName("mc_objlist" + _loc6_) as MovieClip;
            _loc7_.gotoAndStop(1);
            (_loc7_.tf_num as TextField).text = "";
            _loc11_ = new Bitmap();
            _loc11_.name = "objBmp";
            _loc11_.scaleX = _loc11_.scaleY = 0.75;
            _loc7_.addChild(_loc11_);
            _loc6_++;
         }
         this._srcCommandImg = new Bitmap();
         this._srcCommandImg.name = "SrcBMP";
         this._gamePartInfo.mc_srcbase.addChild(this._srcCommandImg);
         this._objCommandImg = new Bitmap();
         this._objCommandImg.name = "ObjBMP";
         this._gamePartInfo.mc_objbase.addChild(this._objCommandImg);
      }
      
      public static function get instance() : BattleAction
      {
         if(_instance == null)
         {
            _instance = new BattleAction(new HHH());
         }
         return _instance;
      }
      
      public function setBattleBG(param1:BitmapData) : void
      {
         this._bg.bitmapData = param1;
      }
      
      public function initPart(param1:MSG_RESP_SHIPFIGHT, param2:GShipTeam, param3:GShipTeam) : void
      {
         var _loc6_:MovieClip = null;
         var _loc7_:MovieClip = null;
         var _loc8_:int = 0;
         var _loc4_:ShippartInfo = null;
         var _loc5_:Bitmap = null;
         this._SrcPartId = param1.SrcPartId;
         this._SrcPartNum = param1.SrcPartNum;
         this._SrcPartRate = param1.SrcPartRate;
         this._ObjPartId = param1.ObjPartId;
         this._ObjPartNum = param1.ObjPartNum;
         this.releasePart();
         _loc8_ = 0;
         while(_loc8_ < MsgTypes.MAX_MSG_PART)
         {
            _loc6_ = this._gamePartInfo.getChildByName("mc_srclist" + _loc8_) as MovieClip;
            (_loc6_.tf_num as TextField).text = "";
            _loc6_.mc_bg.visible = false;
            _loc7_ = this._gamePartInfo.getChildByName("mc_objlist" + _loc8_) as MovieClip;
            (_loc7_.tf_num as TextField).text = "";
            _loc7_.mc_bg.visible = false;
            _loc8_++;
         }
         _loc8_ = 0;
         while(_loc8_ < param1.SrcPartId.length)
         {
            if(param1.SrcPartId[_loc8_] != -1)
            {
               _loc6_ = this._gamePartInfo.getChildByName("mc_srclist" + _loc8_) as MovieClip;
               _loc6_.addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
               _loc6_.addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
               (_loc6_.tf_num as TextField).text = param1.SrcPartNum[_loc8_] + "";
               _loc6_.mc_bg.visible = true;
               _loc4_ = CShipmodelReader.getInstance().getShipPartInfo(param1.SrcPartId[_loc8_]);
               (_loc6_.getChildByName("srcBmp") as Bitmap).bitmapData = GameKernel.getTextureInstance(_loc4_.ImageFileName);
            }
            if(param1.ObjPartId[_loc8_] != -1)
            {
               _loc7_ = this._gamePartInfo.getChildByName("mc_objlist" + _loc8_) as MovieClip;
               _loc7_.addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
               _loc7_.addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
               (_loc7_.tf_num as TextField).text = param1.ObjPartNum[_loc8_] + "";
               _loc7_.mc_bg.visible = true;
               _loc4_ = CShipmodelReader.getInstance().getShipPartInfo(param1.ObjPartId[_loc8_]);
               (_loc7_.getChildByName("objBmp") as Bitmap).bitmapData = GameKernel.getTextureInstance(_loc4_.ImageFileName);
            }
            _loc8_++;
         }
      }
      
      private function onMouseOver(param1:MouseEvent) : void
      {
         var _loc3_:ShippartInfo = null;
         if(String(param1.currentTarget.name).slice(6,10) != "list")
         {
            return;
         }
         PartTip.instance.x = param1.currentTarget.x;
         PartTip.instance.y = 100;
         this._gamePartInfo.addChild(PartTip.instance);
         var _loc2_:int = parseInt(String(param1.currentTarget.name).slice(String(param1.currentTarget.name).length - 1,String(param1.currentTarget.name).length));
         if(String(param1.currentTarget.name).slice(3,6) == "src")
         {
            _loc3_ = CShipmodelReader.getInstance().getShipPartInfo(this._SrcPartId[_loc2_]);
            if(_loc3_)
            {
               PartTip.instance.updateTip(_loc3_,this._SrcPartNum[_loc2_],this._SrcPartRate[_loc2_]);
            }
         }
         else if(String(param1.currentTarget.name).slice(3,6) == "obj")
         {
            _loc3_ = CShipmodelReader.getInstance().getShipPartInfo(this._ObjPartId[_loc2_]);
            if(_loc3_)
            {
               PartTip.instance.updateTip(_loc3_,this._ObjPartNum[_loc2_]);
            }
         }
      }
      
      public function onMouseOut(param1:MouseEvent = null) : void
      {
         if(this._gamePartInfo.getChildByName("PartTip"))
         {
            this._gamePartInfo.removeChild(PartTip.instance);
         }
         PartTip.instance.x = PartTip.instance.y = 0;
      }
      
      public function releasePart() : void
      {
         var _loc1_:MovieClip = null;
         var _loc2_:int = 0;
         while(_loc2_ < 7)
         {
            _loc1_ = this._gamePartInfo.getChildByName("mc_srclist" + _loc2_) as MovieClip;
            if(_loc1_.hasEventListener(MouseEvent.MOUSE_OVER))
            {
               _loc1_.removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
            }
            if(_loc1_.hasEventListener(MouseEvent.MOUSE_OUT))
            {
               _loc1_.removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
            }
            (_loc1_.getChildByName("srcBmp") as Bitmap).bitmapData = null;
            _loc1_ = this._gamePartInfo.getChildByName("mc_objlist" + _loc2_) as MovieClip;
            if(_loc1_.hasEventListener(MouseEvent.MOUSE_OVER))
            {
               _loc1_.removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
            }
            if(_loc1_.hasEventListener(MouseEvent.MOUSE_OUT))
            {
               _loc1_.removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
            }
            (_loc1_.getChildByName("objBmp") as Bitmap).bitmapData = null;
            _loc2_++;
         }
      }
      
      public function initSrcShip(param1:GShipTeam) : void
      {
         (this._gamePartInfo.tf_srccorpsname as TextField).text = param1.Consortia;
         (this._gamePartInfo.tf_srccommandername as TextField).text = param1.Commander;
         (this._gamePartInfo.tf_srcplayername as TextField).text = param1.TeamOwner + "";
         (this._gamePartInfo.tf_srclv as TextField).text = "" + (param1.LevelId + 1);
         this._gamePartInfo.mc_srcgrade.gotoAndStop(param1.CardLevel + 2);
         this._srcCommandImg.bitmapData = null;
         this._srcCommandImg.bitmapData = CommanderSceneUI.getInstance().CommanderHeadImg(param1.CommanderHeadId);
         var _loc2_:Number = param1.Gas / param1.Storage;
         this._gamePartInfo.mc_srcplanbar.width = 259 * _loc2_;
         (this._gamePartInfo.tf_srcrecruit as TextField).text = param1.Gas + "/" + param1.Storage;
      }
      
      private function facebookUserInfoCallBack(param1:FacebookUserInfo) : void
      {
         if(param1 != null && param1.first_name != null)
         {
            (this._gamePartInfo.tf_srcplayername as TextField).text = param1.first_name + "";
         }
      }
      
      public function initObjShip(param1:GShipTeam) : void
      {
         (this._gamePartInfo.tf_objcorpsname as TextField).text = param1.Consortia;
         (this._gamePartInfo.tf_objcommandername as TextField).text = param1.Commander;
         (this._gamePartInfo.tf_objplayername as TextField).text = param1.TeamOwner + "";
         (this._gamePartInfo.tf_objlv as TextField).text = "" + (param1.LevelId + 1);
         this._gamePartInfo.mc_objgrade.gotoAndStop(param1.CardLevel + 2);
         this._objCommandImg.bitmapData = null;
         this._objCommandImg.bitmapData = CommanderSceneUI.getInstance().CommanderHeadImg(param1.CommanderHeadId);
         var _loc2_:Number = param1.Gas / param1.Storage;
         this._gamePartInfo.mc_objplanbar.width = 259 * _loc2_;
         (this._gamePartInfo.tf_objrecruit as TextField).text = param1.Gas + "/" + param1.Storage;
      }
      
      private function facebookUserInfoCallBackObj(param1:FacebookUserInfo) : void
      {
         if(param1 != null && param1.first_name != null)
         {
            (this._gamePartInfo.tf_objplayername as TextField).text = param1.first_name;
         }
      }
      
      public function updateSrcSupply(param1:GShipTeam, param2:int, param3:int) : void
      {
         this.srcShipTeam = param1;
         this._gamePartInfo.mc_srcplanbar.width = 259 * (this.srcShipTeam.Gas / this.srcShipTeam.Storage);
         this.srcReduceSupply = param2;
         this.srcReduceStorage = param3;
         this.srcPercent = param2 / this.srcShipTeam.Storage;
         this.src_01_RSup = Math.floor(param2 * 0.05);
         this.src_01_RSto = Math.floor(param3 * 0.05);
         this._gamePartInfo.mc_srcplanbar.addEventListener(Event.ENTER_FRAME,this.onSrcSupply);
      }
      
      private function onSrcSupply(param1:Event) : void
      {
         var _loc2_:int = this.srcShipTeam.Gas - this.src_01_RSup * 0.05;
         (this._gamePartInfo.tf_srcrecruit as TextField).text = _loc2_ + "/" + this.srcShipTeam.Storage;
         this._gamePartInfo.mc_srcplanbar.width -= 259 * this.srcPercent * 0.05;
         if(this.srcCount == 19)
         {
            this._gamePartInfo.mc_srcplanbar.removeEventListener(Event.ENTER_FRAME,this.onSrcSupply);
            this.srcShipTeam.Gas -= this.srcReduceSupply;
            (this._gamePartInfo.tf_srcrecruit as TextField).text = this.srcShipTeam.Gas + "/" + this.srcShipTeam.Storage;
            if(this.srcShipTeam.Storage == 0)
            {
               this._gamePartInfo.mc_srcplanbar.width = 0;
            }
            else
            {
               this._gamePartInfo.mc_srcplanbar.width = 259 * (this.srcShipTeam.Gas / this.srcShipTeam.Storage);
            }
            this.srcCount = 0;
            return;
         }
         ++this.srcCount;
      }
      
      public function updateObjSupply(param1:GShipTeam, param2:int, param3:int) : void
      {
         this.objShipTeam = param1;
         this._gamePartInfo.mc_objplanbar.width = 259 * (this.objShipTeam.Gas / this.objShipTeam.Storage);
         this.objReduceSupply = param2;
         this.objReduceStorage = param3;
         this.objPercent = param2 / this.objShipTeam.Storage;
         this.obj_01_RSup = Math.floor(param2 * 0.05);
         this.obj_01_RSto = Math.floor(param3 * 0.05);
         this._gamePartInfo.mc_objplanbar.addEventListener(Event.ENTER_FRAME,this.onObjSupply);
      }
      
      private function onObjSupply(param1:Event) : void
      {
         var _loc2_:int = this.objShipTeam.Gas - this.obj_01_RSup * 0.05 * this.objCount;
         var _loc3_:int = this.objShipTeam.Storage - this.obj_01_RSto * 0.05 * this.objCount;
         (this._gamePartInfo.tf_objrecruit as TextField).text = _loc2_ + "/" + _loc3_;
         this._gamePartInfo.mc_objplanbar.width -= 259 * this.objPercent * 0.05;
         if(this.objCount == 19)
         {
            this._gamePartInfo.mc_objplanbar.removeEventListener(Event.ENTER_FRAME,this.onObjSupply);
            this.objShipTeam.Gas -= this.objReduceSupply;
            (this._gamePartInfo.tf_objrecruit as TextField).text = this.objShipTeam.Gas + "/" + this.objShipTeam.Storage;
            if(this.objShipTeam.Storage == 0)
            {
               this._gamePartInfo.mc_objplanbar.width = 0;
            }
            else
            {
               this._gamePartInfo.mc_objplanbar.width = 259 * (this.objShipTeam.Gas / this.objShipTeam.Storage);
            }
            this.objCount = 0;
            return;
         }
         ++this.objCount;
      }
      
      public function addSrcSkillEffect() : void
      {
         var _loc1_:MovieClip = null;
         MusicResHandler.PlayEffectMusic(MusicResHandler.CMDERBLAST_EFFECT);
         _loc1_ = GameKernel.getMovieClipInstance("CommanderBlast");
         _loc1_.addEventListener(Event.ENTER_FRAME,this.srcSkillEffectFrame);
         _loc1_.x = 25;
         _loc1_.y = 25;
         this._srcEffRubbish.push(_loc1_);
         this._gamePartInfo.mc_srcbase.addChild(_loc1_);
      }
      
      public function addObjSkillEffect() : void
      {
         var _loc1_:MovieClip = null;
         MusicResHandler.PlayEffectMusic(MusicResHandler.CMDERBLAST_EFFECT);
         _loc1_ = GameKernel.getMovieClipInstance("CommanderBlast");
         _loc1_.addEventListener(Event.ENTER_FRAME,this.objSkillEffectFrame);
         _loc1_.x = 25;
         _loc1_.y = 25;
         _loc1_.scaleX = -1;
         this._objEffRubbish.push(_loc1_);
         this._gamePartInfo.mc_objbase.addChild(_loc1_);
      }
      
      public function addSrcEffect(param1:int, param2:int) : void
      {
         var _loc3_:MovieClip = null;
         var _loc4_:String = null;
         switch(param1)
         {
            case E_STAR:
               _loc3_ = GameKernel.getMovieClipInstance("Duixing");
               break;
            case E_CONNON:
               _loc3_ = GameKernel.getMovieClipInstance("Connon");
               _loc4_ = MusicResHandler.CONNON_EFFECT;
               break;
            case E_LASER:
               _loc3_ = GameKernel.getMovieClipInstance("Laserlight");
               _loc4_ = MusicResHandler.LASER_EFFECT;
               break;
            case E_MISSILE:
               _loc3_ = GameKernel.getMovieClipInstance("Missile");
               _loc4_ = MusicResHandler.MISSILE_EFFECT;
               break;
            case E_SHIPBASED:
               _loc3_ = GameKernel.getMovieClipInstance("ShipBase");
               _loc4_ = MusicResHandler.SHIPBASE_EFFECT;
               break;
            case E_CONNON2:
               _loc3_ = GameKernel.getMovieClipInstance("Connon2");
               _loc4_ = MusicResHandler.SHIPBASE_EFFECT;
               break;
            case E_LASER2:
               _loc3_ = GameKernel.getMovieClipInstance("Laserlight2");
               _loc4_ = MusicResHandler.CONNON_EFFECT;
               break;
            case E_MISSILE2:
               _loc3_ = GameKernel.getMovieClipInstance("Missile2");
               _loc4_ = MusicResHandler.MISSILE_EFFECT;
               break;
            case E_SHIPBASED2:
               _loc3_ = GameKernel.getMovieClipInstance("ShipBase2");
               _loc4_ = MusicResHandler.SHIPBASE_EFFECT;
               break;
            case E_BOMB:
               _loc3_ = GameKernel.getMovieClipInstance("Bomb");
               _loc4_ = MusicResHandler.BOMB_EFFECT;
               break;
            case E_THOR:
               _loc3_ = GameKernel.getMovieClipInstance("Bomb");
               _loc4_ = MusicResHandler.THOR_EFFECT;
               break;
            case E_SHIPBLAST:
               _loc3_ = GameKernel.getMovieClipInstance("ShipBlast");
               _loc4_ = MusicResHandler.SHIPBLAST_EFFECT;
         }
         MusicResHandler.PlayEffectMusic(_loc4_);
         var _loc5_:int = int(this._srcPosArr[param2][0]);
         var _loc6_:int = int(this._srcPosArr[param2][1]);
         _loc3_.x = this._gamePartInfo.x + GRID_WIDTH * 0.5 * (GRID_COUNT - _loc6_ + _loc5_) - 0.5 * GRID_WIDTH - 155;
         _loc3_.y = GRID_HEIGHT * 0.5 * (_loc5_ + _loc6_ + 1) + 65;
         _loc3_.addEventListener(Event.ENTER_FRAME,this.onSrcEffectFrame);
         if(param1 == E_COMMANDERA || param1 == E_MISSILE)
         {
            this._lineSprite.addChildAt(_loc3_,0);
         }
         else
         {
            this._lineSprite.addChild(_loc3_);
         }
         this._srcEffRubbish.push(_loc3_);
      }
      
      private function onSrcEffectFrame(param1:Event) : void
      {
         var _loc2_:int = 0;
         if(param1.target.currentFrame == param1.target.totalFrames)
         {
            param1.target.stop();
            param1.target.removeEventListener(Event.ENTER_FRAME,this.onSrcEffectFrame);
            this._lineSprite.removeChild(param1.target as DisplayObject);
            _loc2_ = 0;
            while(_loc2_ < this._srcEffRubbish.length)
            {
               if(this._srcEffRubbish[_loc2_] == param1.target)
               {
                  this._srcEffRubbish.splice(_loc2_,1);
               }
               _loc2_++;
            }
         }
      }
      
      private function srcSkillEffectFrame(param1:Event) : void
      {
         var _loc2_:int = 0;
         if(param1.target.currentFrame == param1.target.totalFrames)
         {
            param1.target.stop();
            param1.target.removeEventListener(Event.ENTER_FRAME,this.srcSkillEffectFrame);
            _loc2_ = 0;
            while(_loc2_ < this._srcEffRubbish.length)
            {
               if(this._srcEffRubbish[_loc2_] == param1.target)
               {
                  this._gamePartInfo.mc_srcbase.removeChild(this._srcEffRubbish[_loc2_] as DisplayObject);
                  this._srcEffRubbish.splice(_loc2_,1);
               }
               _loc2_++;
            }
         }
      }
      
      private function objSkillEffectFrame(param1:Event) : void
      {
         var _loc2_:int = 0;
         if(param1.target.currentFrame == param1.target.totalFrames)
         {
            param1.target.stop();
            param1.target.removeEventListener(Event.ENTER_FRAME,this.objSkillEffectFrame);
            _loc2_ = 0;
            while(_loc2_ < this._objEffRubbish.length)
            {
               if(this._objEffRubbish[_loc2_] == param1.target)
               {
                  this._gamePartInfo.mc_objbase.removeChild(this._objEffRubbish[_loc2_] as DisplayObject);
                  this._objEffRubbish.splice(_loc2_,1);
               }
               _loc2_++;
            }
         }
      }
      
      public function addObjEffect(param1:int, param2:int) : void
      {
         var _loc3_:MovieClip = null;
         var _loc4_:String = null;
         switch(param1)
         {
            case E_BOMB:
               _loc3_ = GameKernel.getMovieClipInstance("Bomb");
               _loc4_ = MusicResHandler.BOMB_EFFECT;
               break;
            case E_SHIELD:
               _loc3_ = GameKernel.getMovieClipInstance("hudunqidong");
               _loc4_ = MusicResHandler.SHIELD_EFFECT;
               break;
            case E_MISS:
               _loc3_ = GameKernel.getMovieClipInstance("ShipBlast");
               _loc4_ = MusicResHandler.SHIPBLAST_EFFECT;
         }
         MusicResHandler.PlayEffectMusic(_loc4_);
         var _loc5_:int = int(this._objPosArr[param2][0]);
         var _loc6_:int = int(this._objPosArr[param2][1]);
         _loc3_.x = this._gamePartInfo.x + GRID_WIDTH * 0.5 * (GRID_COUNT - _loc6_ + _loc5_ - 4) - 0.5 * GRID_WIDTH + 20;
         _loc3_.y = GRID_HEIGHT * 0.5 * (_loc5_ + _loc6_) + 70;
         _loc3_.addEventListener(Event.ENTER_FRAME,this.onObjEffectFrame);
         this._lineSprite.addChild(_loc3_);
         this._objEffRubbish.push(_loc3_);
      }
      
      public function addSrcNum(param1:int, param2:int, param3:Boolean = false) : void
      {
         var _loc4_:MovieClip = null;
         _loc4_ = GameKernel.getMovieClipInstance("TxtAnim");
         (_loc4_.mc_base.tf_num as TextField).textColor = 16711680;
         (_loc4_.mc_base.tf_num as TextField).text = "-" + param1;
         var _loc5_:int = int(this._srcPosArr[param2][0]);
         var _loc6_:int = int(this._srcPosArr[param2][1]);
         _loc4_.x = this._gamePartInfo.x + GRID_WIDTH * 0.5 * (GRID_COUNT - _loc6_ + _loc5_) - 0.5 * GRID_WIDTH - 190;
         _loc4_.y = GRID_HEIGHT * 0.5 * (_loc5_ + _loc6_ + 1) + 65;
         if(param3)
         {
            _loc4_.y -= 15;
            (_loc4_.mc_base.tf_num as TextField).textColor = 39167;
         }
         _loc4_.addEventListener(Event.ENTER_FRAME,this.onSrcEffectFrame);
         this._lineSprite.addChild(_loc4_);
         this._srcEffRubbish.push(_loc4_);
      }
      
      public function addObjNum(param1:int, param2:int, param3:Boolean = false) : void
      {
         var _loc4_:MovieClip = null;
         if(param1 == 0)
         {
            return;
         }
         _loc4_ = GameKernel.getMovieClipInstance("TxtAnim");
         (_loc4_.mc_base.tf_num as TextField).text = "-" + param1;
         (_loc4_.mc_base.tf_num as TextField).textColor = 16711680;
         var _loc5_:int = int(this._objPosArr[param2][0]);
         var _loc6_:int = int(this._objPosArr[param2][1]);
         _loc4_.x = this._gamePartInfo.x + GRID_WIDTH * 0.5 * (GRID_COUNT - _loc6_ + _loc5_ - 4) - 0.5 * GRID_WIDTH;
         _loc4_.y = GRID_HEIGHT * 0.5 * (_loc5_ + _loc6_) + 70;
         if(param3)
         {
            _loc4_.y -= 15;
            (_loc4_.mc_base.tf_num as TextField).textColor = 39167;
         }
         _loc4_.addEventListener(Event.ENTER_FRAME,this.onObjEffectFrame);
         this._lineSprite.addChild(_loc4_);
         this._objEffRubbish.push(_loc4_);
      }
      
      public function shakeObjShip(param1:int) : void
      {
         if(this._objRubbish[param1] == null)
         {
            return;
         }
         if(!this._objRubbish[param1])
         {
            return;
         }
         this.shakeEffect.addList(this._objRubbish[param1].name,this._objRubbish[param1]);
         this.shakeEffect.wave((this._objRubbish[param1] as MovieClip).name);
      }
      
      private function onObjEffectFrame(param1:Event) : void
      {
         var _loc2_:int = 0;
         if(param1.target.currentFrame == param1.target.totalFrames)
         {
            param1.target.stop();
            param1.target.removeEventListener(Event.ENTER_FRAME,this.onObjEffectFrame);
            _loc2_ = 0;
            while(_loc2_ < this._objEffRubbish.length)
            {
               if(this._objEffRubbish[_loc2_] == param1.target)
               {
                  this._lineSprite.removeChild(this._objEffRubbish[_loc2_] as DisplayObject);
                  this._srcEffRubbish.splice(_loc2_,1);
               }
               _loc2_++;
            }
         }
      }
      
      public function repairShipTeam(param1:GShipTeam, param2:GShipTeam, param3:MSG_RESP_FIGHTSECTION) : void
      {
         var _loc4_:GShip = null;
         var _loc5_:GShip = null;
         var _loc6_:int = 0;
         while(_loc6_ < MsgTypes.MAX_SHIPTEAMBODY)
         {
            if(param1)
            {
               _loc4_ = param1.TeamBody[_loc6_];
               if((_loc4_) && _loc4_.ShipModelId == -1 && _loc4_.Num <= 0)
               {
                  _loc4_ = null;
               }
               if(_loc4_)
               {
                  _loc4_.Shield += param3.SrcRepairShield[_loc6_];
                  _loc4_.Endure += param3.SrcRepairEndure[_loc6_];
               }
            }
            if(param2)
            {
               _loc5_ = param2.TeamBody[_loc6_];
               if((_loc5_) && _loc5_.ShipModelId == -1 && _loc5_.Num <= 0)
               {
                  _loc5_ = null;
               }
               if(_loc5_)
               {
                  _loc5_.Shield += param3.ObjRepairShield[_loc6_];
                  _loc5_.Endure += param3.ObjRepairEndure[_loc6_];
               }
            }
            _loc6_++;
         }
      }
      
      public function initBattle(param1:GShipTeam, param2:GShipTeam, param3:Array, param4:MSG_RESP_FIGHTSECTION) : void
      {
         var _loc8_:Bitmap = null;
         var _loc9_:Bitmap = null;
         var _loc10_:GShip = null;
         var _loc11_:GShip = null;
         var _loc12_:int = 0;
         var _loc13_:MovieClip = null;
         var _loc14_:MovieClip = null;
         this.shakeEffect.Init();
         this.clearRubbish();
         (this._gamePartInfo.tf_bout as TextField).text = param4.BoutId + 1 + "";
         var _loc5_:int = -1;
         var _loc6_:int = -1;
         var _loc7_:int = 0;
         while(_loc7_ < MsgTypes.MAX_SHIPTEAMBODY)
         {
            _loc8_ = this._lineSprite.getChildByName("SRC_NUM_" + _loc7_) as Bitmap;
            _loc8_.bitmapData = null;
            _loc9_ = this._lineSprite.getChildByName("OBJ_NUM_" + _loc7_) as Bitmap;
            _loc9_.bitmapData = null;
            _loc10_ = param1.TeamBody[_loc7_];
            if((_loc10_) && _loc10_.ShipModelId != -1 && _loc10_.Num > 0)
            {
               _loc8_.bitmapData = GameFont.getInt(_loc10_.Num);
               _loc13_ = _loc10_.getModel();
               _loc5_ = int(this._srcPosArr[_loc7_][0]);
               _loc6_ = int(this._srcPosArr[_loc7_][1]);
               _loc13_.name = "SRC_SHIP_" + _loc7_;
               _loc13_.x = this._gamePartInfo.x + GRID_WIDTH * 0.5 * (GRID_COUNT - _loc6_ + _loc5_) - 0.5 * GRID_WIDTH - 160;
               _loc13_.y = GRID_HEIGHT * 0.5 * (_loc5_ + _loc6_ + 1) + 70;
               _loc13_.gotoAndStop(1);
               this._lineSprite.addChild(_loc13_);
               this._srcRubbish[_loc7_] = _loc13_;
               if(_loc13_.getChildByName("BleedMC"))
               {
                  _loc13_.getChildByName("BleedMC").visible = false;
               }
            }
            _loc11_ = param2.TeamBody[param3[_loc7_]];
            _loc12_ = (4 - param1.Direction + param2.Direction) % 4 + 1;
            if(_loc11_ && _loc11_.ShipModelId != -1 && _loc11_.Num > 0)
            {
               _loc9_.bitmapData = GameFont.getInt(_loc11_.Num);
               _loc14_ = _loc11_.getModel();
               _loc5_ = int(this._objPosArr[_loc7_][0]);
               _loc6_ = int(this._objPosArr[_loc7_][1]);
               _loc14_.name = "OBJ_SHIP_" + _loc7_;
               _loc14_.x = this._gamePartInfo.x + GRID_WIDTH * 0.5 * (GRID_COUNT - _loc6_ + _loc5_ - 4) - 0.5 * GRID_WIDTH + 20;
               _loc14_.y = GRID_HEIGHT * 0.5 * (_loc5_ + _loc6_) + 70;
               _loc14_.gotoAndStop(_loc12_);
               this._lineSprite.addChild(_loc14_);
               this._objRubbish[_loc7_] = _loc14_;
            }
            _loc7_++;
         }
      }
      
      public function clearRubbish() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this._srcRubbish.length)
         {
            if(this._srcRubbish[_loc1_] != null)
            {
               if(this._lineSprite.contains(this._srcRubbish[_loc1_]))
               {
                  this._lineSprite.removeChild(this._srcRubbish[_loc1_] as DisplayObject);
                  this._srcRubbish[_loc1_] = null;
               }
            }
            _loc1_++;
         }
         this._srcRubbish.splice(0);
         _loc1_ = 0;
         while(_loc1_ < this._objRubbish.length)
         {
            if(this._objRubbish[_loc1_] != null)
            {
               if(this._lineSprite.contains(this._objRubbish[_loc1_]))
               {
                  this._lineSprite.removeChild(this._objRubbish[_loc1_] as DisplayObject);
                  this._objRubbish[_loc1_] = null;
               }
            }
            _loc1_++;
         }
         this._objRubbish.splice(0);
         this.shakeEffect.Init();
      }
      
      public function deleteSrcShip(param1:int) : void
      {
         if(this._srcRubbish[param1] == null)
         {
            return;
         }
         if(!this._lineSprite.contains(this._srcRubbish[param1]))
         {
            return;
         }
         this._lineSprite.removeChild(this._srcRubbish[param1] as MovieClip);
         this._srcRubbish[param1] = null;
      }
      
      public function deleteObjShip(param1:int) : void
      {
         if(this._objRubbish[param1] == null)
         {
            return;
         }
         if(!this._lineSprite.contains(this._objRubbish[param1]))
         {
            return;
         }
         this._lineSprite.removeChild(this._objRubbish[param1] as MovieClip);
         this._objRubbish[param1] = null;
      }
      
      private function getBase(param1:uint) : Shape
      {
         var _loc2_:Shape = new Shape();
         _loc2_.graphics.lineStyle(1,param1,0.5);
         _loc2_.graphics.moveTo(0,-28);
         _loc2_.graphics.lineTo(47.5,0);
         _loc2_.graphics.lineTo(0,28);
         _loc2_.graphics.lineTo(-47.5,0);
         _loc2_.graphics.lineTo(0,-28);
         return _loc2_;
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         var _loc2_:Point = this.getGird(param1.localX,param1.localY);
         var _loc3_:int = _loc2_.x;
         var _loc4_:int = _loc2_.y;
      }
      
      private function getGird(param1:Number, param2:Number) : Point
      {
         param1 += 0.5 * GRID_WIDTH;
         param2 -= 70;
         var _loc3_:Number = -GRID_HEIGHT / GRID_WIDTH;
         var _loc4_:Number = GRID_HEIGHT * GRID_COUNT * 0.5;
         var _loc5_:Number = param2 - _loc3_ * param1;
         var _loc6_:Number = Math.sqrt(GRID_WIDTH * 0.5 * (GRID_WIDTH * 0.5) + GRID_HEIGHT * 0.5 * (GRID_HEIGHT * 0.5));
         var _loc7_:int = Math.floor((_loc5_ - _loc4_) / _loc6_);
         _loc3_ = GRID_HEIGHT / GRID_WIDTH;
         _loc5_ = param2 - _loc3_ * param1;
         var _loc8_:int = Math.floor((_loc5_ + _loc4_) / _loc6_);
         return new Point(_loc7_,_loc8_);
      }
      
      public function Alpha(param1:Number) : void
      {
         this._scene.alpha = param1;
      }
      
      override public function Init() : void
      {
         GameKernel.renderManager.getMap().addComponent(this._scene);
      }
      
      public function Release() : void
      {
         GameKernel.renderManager.getMap().removeComponent(this._scene,true);
      }
      
      override public function getUI() : Container
      {
         return this._scene;
      }
      
      public function get lineSprite() : Sprite
      {
         return this._lineSprite;
      }
      
      public function getSrcPosPiexl(param1:int) : Point
      {
         var _loc2_:Point = new Point();
         var _loc3_:int = int(this._srcPosArr[param1][0]);
         var _loc4_:int = int(this._srcPosArr[param1][1]);
         _loc2_.x = this._gamePartInfo.x + GRID_WIDTH * 0.5 * (GRID_COUNT - _loc4_ + _loc3_) - 0.5 * GRID_WIDTH;
         _loc2_.y = GRID_HEIGHT * 0.5 * (_loc3_ + _loc4_ + 1) + 70;
         return _loc2_;
      }
      
      public function getObjPosPiexl(param1:int) : Array
      {
         return this._objPosArr[param1];
      }
   }
}

import com.star.frameworks.managers.StringManager;
import flash.display.Sprite;
import flash.text.TextField;
import logic.entry.shipmodel.ShippartInfo;

class HHH
{
   
   public function HHH()
   {
      super();
   }
}

class PartTip extends Sprite
{
   
   private static var _instance:PartTip = null;
   
   private var _partName:TextField = new TextField();
   
   private var _partType:TextField = new TextField();
   
   private var _partNum:TextField = new TextField();
   
   private var _partRect:TextField = new TextField();
   
   public function PartTip(param1:HHH)
   {
      super();
      this.name = "PartTip";
      this.init();
   }
   
   public static function get instance() : PartTip
   {
      if(_instance == null)
      {
         _instance = new PartTip(new HHH());
      }
      return _instance;
   }
   
   private function init() : void
   {
      graphics.lineStyle(1,10066329,1);
      graphics.beginFill(3355443,0.5);
      graphics.drawRoundRect(0,0,120,80,8,8);
      graphics.endFill();
      this._partName.y = 0;
      this._partName.textColor = 16777010;
      this._partName.width = 120;
      this._partName.height = 20;
      addChild(this._partName);
      this._partType.textColor = 16777010;
      this._partType.x = 0;
      this._partType.y = 20;
      this._partType.width = 120;
      this._partType.height = 20;
      addChild(this._partType);
      this._partNum.textColor = 16777010;
      this._partNum.x = 0;
      this._partNum.y = 40;
      this._partNum.width = 100;
      this._partNum.height = 16;
      addChild(this._partNum);
      this._partRect.textColor = 16777010;
      this._partRect.x = 0;
      this._partRect.y = 60;
      this._partRect.width = 150;
      this._partRect.height = 16;
      addChild(this._partRect);
   }
   
   public function updateTip(param1:ShippartInfo, param2:int, param3:int = 0) : void
   {
      var _loc4_:int = 0;
      graphics.clear();
      this._partName.text = param1.Name + "";
      _loc4_ = int(this._partName.textWidth);
      this._partNum.text = StringManager.getInstance().getMessageString("Text20") + param2;
      _loc4_ = _loc4_ < this._partNum.textWidth ? int(this._partNum.textWidth) : _loc4_;
      var _loc5_:String = StringManager.getInstance().getMessageString("Text6") + StringManager.getInstance().getMessageString("Text" + param1.HurtType);
      this._partType.text = _loc5_;
      var _loc6_:String = StringManager.getInstance().getMessageString("Text6");
      var _loc7_:String = "";
      switch(param1.HurtType)
      {
         case 11:
            _loc7_ = "Text16";
            break;
         case 12:
            _loc7_ = "Text17";
            break;
         case 13:
            _loc7_ = "Text18";
            break;
         case 14:
            _loc7_ = "Text19";
      }
      _loc7_ = StringManager.getInstance().getMessageString(_loc7_);
      if(_loc7_.length == 0)
      {
         _loc7_ = "";
      }
      else if(_loc7_ == "false")
      {
         _loc7_ = StringManager.getInstance().getMessageString("Text24") + StringManager.getInstance().getMessageString("Text25");
      }
      else
      {
         _loc7_ = StringManager.getInstance().getMessageString("Text6") + _loc7_;
      }
      this._partType.text = _loc7_;
      _loc4_ = _loc4_ < this._partType.textWidth ? int(this._partType.textWidth) : _loc4_;
      this._partRect.text = StringManager.getInstance().getMessageString("Text21") + param3 + "%";
      _loc4_ = _loc4_ < this._partRect.textWidth ? int(this._partRect.textWidth) : _loc4_;
      graphics.lineStyle(1,10066329,1);
      graphics.beginFill(3355443,0.5);
      graphics.drawRoundRect(0,0,_loc4_ + 10,80,8,8);
      graphics.endFill();
      this._partName.width = _loc4_ + 20;
      this._partType.width = _loc4_ + 20;
      this._partNum.width = _loc4_ + 20;
      this._partRect.width = _loc4_ + 20;
   }
}
