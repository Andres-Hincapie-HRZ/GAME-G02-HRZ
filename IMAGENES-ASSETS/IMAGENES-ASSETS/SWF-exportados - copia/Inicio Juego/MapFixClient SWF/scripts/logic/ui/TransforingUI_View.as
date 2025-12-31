package logic.ui
{
   import com.star.frameworks.display.Container;
   import com.star.frameworks.facebook.FacebookUserInfo;
   import com.star.frameworks.managers.StringManager;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import logic.action.ConstructionAction;
   import logic.entry.HButton;
   import logic.game.GameKernel;
   import logic.reader.CCommanderReader;
   import logic.reader.CShipmodelReader;
   import logic.ui.tip.CaptionTip;
   import net.common.MsgTypes;
   import net.msg.fleetMsg.MSG_SHIPTEAM_BODY;
   import net.msg.ship.*;
   
   public class TransforingUI_View
   {
      
      private static var instance:TransforingUI_View;
      
      private var ParentLock:Container;
      
      private var ViewMc:MovieClip;
      
      private var ViewMsg:MSG_RESP_VIEWJUMPSHIPTEAM;
      
      public function TransforingUI_View()
      {
         var _loc1_:MovieClip = null;
         var _loc2_:HButton = null;
         super();
         Event.ENTER_FRAME;
         this.ViewMc = GameKernel.getMovieClipInstance("ExaminePop",GameKernel.fullRect.width / 2 + GameKernel.fullRect.x,300,false);
         _loc1_ = this.ViewMc.getChildByName("btn_close") as MovieClip;
         _loc2_ = new HButton(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.btn_closeClick);
         this.ParentLock = new Container("TransforingUI_ViewSceneLock");
         this.ParentLock.mouseEnabled = true;
         this.ParentLock.mouseChildren = true;
         this.ParentLock.fillRectangleWithoutBorder(GameKernel.fullRect.x,GameKernel.fullRect.y,GameKernel.fullRect.width,GameKernel.fullRect.height,0,0);
         this.InitCaption();
      }
      
      public static function getInstance() : TransforingUI_View
      {
         if(instance == null)
         {
            instance = new TransforingUI_View();
         }
         return instance;
      }
      
      private function InitCaption() : void
      {
         var _loc1_:CaptionTip = null;
         _loc1_ = new CaptionTip(this.ViewMc.mc_jingzhun,StringManager.getInstance().getMessageString("IconText35"));
         _loc1_ = new CaptionTip(this.ViewMc.mc_sudu,StringManager.getInstance().getMessageString("IconText36"));
         _loc1_ = new CaptionTip(this.ViewMc.mc_guibi,StringManager.getInstance().getMessageString("IconText37"));
         _loc1_ = new CaptionTip(this.ViewMc.mc_dianzi,StringManager.getInstance().getMessageString("IconText38"));
      }
      
      public function Show() : void
      {
         GameKernel.renderManager.getUI().addComponent(this.ParentLock);
         this.ParentLock.addChild(this.ViewMc);
      }
      
      private function btn_closeClick(param1:Event) : void
      {
         this.ParentLock.removeChild(this.ViewMc);
         GameKernel.renderManager.getUI().removeComponent(this.ParentLock);
      }
      
      private function Clear() : void
      {
         var _loc3_:MovieClip = null;
         var _loc1_:MovieClip = MovieClip(this.ViewMc.mc_grid);
         var _loc2_:int = 0;
         while(_loc2_ < 9)
         {
            _loc3_ = MovieClip(_loc1_.getChildByName("mc_base" + _loc2_));
            _loc3_.visible = false;
            _loc2_++;
         }
         TextField(this.ViewMc.tf_jingzhun).text = "?";
         TextField(this.ViewMc.tf_sudu).text = "?";
         TextField(this.ViewMc.tf_guibi).text = "?";
         TextField(this.ViewMc.tf_dianzi).text = "?";
         TextField(this.ViewMc.tf_time).text = "?";
         TextField(this.ViewMc.tf_location).text = "?";
         TextField(this.ViewMc.tf_num).text = "?";
         TextField(this.ViewMc.tf_skill).text = "?";
         MovieClip(this.ViewMc.mc_grade).visible = false;
      }
      
      public function ShowShipTeamInfo(param1:MSG_RESP_VIEWJUMPSHIPTEAM, param2:int, param3:String, param4:int) : void
      {
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:MSG_SHIPTEAM_BODY = null;
         var _loc9_:MovieClip = null;
         var _loc10_:int = 0;
         var _loc11_:MovieClip = null;
         var _loc12_:MSG_SHIPTEAM_BODY = null;
         var _loc13_:MovieClip = null;
         var _loc14_:Bitmap = null;
         var _loc15_:MovieClip = null;
         var _loc16_:Bitmap = null;
         var _loc17_:String = null;
         this.ViewMsg = param1;
         this.Clear();
         var _loc5_:int = ConstructionAction.getInstance().getRadarLevel();
         if(param4 == 0 || param4 == 3)
         {
            _loc5_ = 999;
         }
         if(_loc5_ >= 0)
         {
            if(param4 < 3)
            {
               TextField(this.ViewMc.tf_time).text = param3;
            }
            else
            {
               TextField(this.ViewMc.tf_time).text = "";
            }
         }
         if(_loc5_ >= 2)
         {
            if(param4 < 3)
            {
               TextField(this.ViewMc.tf_location).text = this.GetLocation(param2);
            }
            else
            {
               TextField(this.ViewMc.tf_location).text = "";
            }
         }
         if(_loc5_ >= 4)
         {
            _loc6_ = 0;
            _loc7_ = 0;
            while(_loc7_ < 9)
            {
               _loc8_ = param1.TeamBody[_loc7_];
               _loc6_ += _loc8_.Num;
               _loc7_++;
            }
            TextField(this.ViewMc.tf_num).text = _loc6_.toString();
         }
         if(_loc5_ >= 6)
         {
            _loc9_ = MovieClip(this.ViewMc.mc_grid);
            _loc10_ = 0;
            while(_loc10_ < 9)
            {
               _loc11_ = MovieClip(_loc9_.getChildByName("mc_base" + _loc10_));
               _loc12_ = param1.TeamBody[_loc10_];
               if(_loc12_.Num > 0)
               {
                  _loc11_.visible = true;
                  _loc13_ = MovieClip(_loc11_.mc_base);
                  if(_loc13_.numChildren > 0)
                  {
                     _loc13_.removeChildAt(0);
                  }
                  _loc14_ = new Bitmap(GameKernel.getTextureInstance(CShipmodelReader.getInstance().getShipBodyInfo(_loc12_.BodyId).SmallIcon));
                  _loc14_.x = -3;
                  _loc14_.y = 13;
                  _loc13_.addChild(_loc14_);
                  TextField(_loc11_.tf_num).text = _loc12_.Num.toString();
               }
               else
               {
                  _loc11_.visible = false;
               }
               _loc10_++;
            }
         }
         if(_loc5_ >= 8)
         {
            _loc15_ = MovieClip(this.ViewMc.mc_player);
            if(_loc15_.numChildren > 0)
            {
               _loc15_.removeChildAt(0);
            }
            _loc16_ = CommanderSceneUI.getInstance().CommanderAvararImg(param1.SkillId);
            _loc16_.width = 50;
            _loc16_.height = 50;
            _loc15_.addChild(_loc16_);
            TextField(this.ViewMc.tf_jingzhun).text = param1.Aim.toString();
            TextField(this.ViewMc.tf_sudu).text = param1.Priority.toString();
            TextField(this.ViewMc.tf_guibi).text = param1.Blench.toString();
            TextField(this.ViewMc.tf_dianzi).text = param1.Electron.toString();
            MovieClip(this.ViewMc.mc_grade).visible = true;
            if(param1.SkillId >= 0)
            {
               MovieClip(this.ViewMc.mc_grade).gotoAndStop(param1.CardLevel + 2);
            }
            else
            {
               MovieClip(this.ViewMc.mc_grade).gotoAndStop(1);
            }
            _loc17_ = CCommanderReader.getInstance().getCommanderSkillName(param1.SkillId);
            if(_loc17_ != "")
            {
               TextField(this.ViewMc.tf_skill).text = _loc17_;
            }
            else
            {
               TextField(this.ViewMc.tf_skill).text = "";
            }
         }
         TextField(this.ViewMc.tf_name).text = param1.TeamOwner;
         GameKernel.getPlayerFacebookInfo(param1.UserId,this.getPlayerFacebookInfoCallback,param1.TeamOwner);
         TextField(this.ViewMc.tf_commandername).text = param1.TeamName;
         this.Show();
      }
      
      private function getPlayerFacebookInfoCallback(param1:FacebookUserInfo) : void
      {
         if(param1 == null)
         {
            return;
         }
         TextField(this.ViewMc.tf_name).text = param1.first_name;
      }
      
      private function GetLocation(param1:int) : String
      {
         var _loc2_:int = param1 / MsgTypes.MAP_RANGE;
         var _loc3_:int = param1 % MsgTypes.MAP_RANGE;
         return "(" + _loc2_ + "," + _loc3_ + ")";
      }
   }
}

