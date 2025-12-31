package logic.ui.info
{
   import com.star.frameworks.display.Container;
   import com.star.frameworks.geom.RectangleKit;
   import com.star.frameworks.utils.HashSet;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   import gs.TweenLite;
   import gs.easing.Strong;
   import logic.entry.GamePlayer;
   import logic.game.GameKernel;
   import logic.game.GameSetting;
   import logic.game.GameStatisticsManager;
   import logic.ui.ConstructionUI;
   import logic.widget.ConstructionUtil;
   import logic.widget.com.ComFormat;
   import logic.widget.tips.CToolTip;
   import logic.widget.tips.CToolTipFactory;
   
   public class AbstractInfoDecorate implements IInfoDecorate
   {
      
      protected var _toolTip:CToolTip;
      
      public function AbstractInfoDecorate()
      {
         super();
      }
      
      public function get ToolTip() : CToolTip
      {
         return this._toolTip;
      }
      
      public function Show(param1:int, param2:int, param3:Boolean = false) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         if(GameKernel.isFullStage)
         {
            _loc4_ = GameSetting.GAME_STAGE_WIDTH + (GameKernel.renderManager.getScene().getStage().stageWidth - GameSetting.GAME_STAGE_WIDTH) / 2;
            _loc5_ = GameKernel.fullRect.width;
         }
         else
         {
            _loc4_ = GameSetting.GAME_STAGE_WIDTH + (GameKernel.renderManager.getScene().getStage().stageWidth - GameSetting.GAME_STAGE_WIDTH) / 2;
            if(GameKernel.ForFB == 1)
            {
               _loc5_ = GameKernel.renderManager.getScene().getStage().stageHeight - 170;
            }
            else
            {
               _loc5_ = GameKernel.renderManager.getScene().getStage().stageHeight;
            }
         }
         if(this._toolTip == null)
         {
            throw new Error("未加载UI配置表");
         }
         var _loc6_:Container = this._toolTip.getDecorateBg().Decorate;
         if(param1 + _loc6_.width > _loc4_ && param2 + _loc6_.height > _loc5_)
         {
            this._toolTip.getDecorate().x = Math.max(0,param1 - this._toolTip.getDecorate().width);
            this._toolTip.getDecorate().y = Math.max(0,param2 - this._toolTip.getDecorate().height);
         }
         else if(param1 + _loc6_.width > _loc4_ && param2 + _loc6_.height < _loc5_)
         {
            this._toolTip.getDecorate().x = Math.max(0,param1 - this._toolTip.getDecorate().width);
            this._toolTip.getDecorate().y = param2;
         }
         else if(param1 + _loc6_.width < _loc4_ && param2 + _loc6_.height > _loc5_)
         {
            this._toolTip.getDecorate().x = param1;
            this._toolTip.getDecorate().y = Math.max(0,param2 - this._toolTip.getDecorate().height);
         }
         else
         {
            this._toolTip.getDecorate().x = param1;
            this._toolTip.getDecorate().y = param2;
         }
         GameKernel.renderManager.getUI().addComponent(this._toolTip.getDecorate());
         if(param3)
         {
            this._toolTip.getDecorate().scaleX = this._toolTip.getDecorate().scaleY = 0;
            TweenLite.to(this._toolTip.getDecorate(),0.5,{
               "autoAlpha":1,
               "scaleX":1,
               "scaleY":1,
               "ease":Strong.easeOut
            });
         }
      }
      
      public function ShowTip(param1:int, param2:int, param3:Boolean = false) : void
      {
         if(this._toolTip == null)
         {
            throw new Error("未加载UI配置表");
         }
         var _loc4_:Container = this._toolTip.getDecorateBg().Decorate;
         this._toolTip.getDecorate().x = param1;
         this._toolTip.getDecorate().y = param2;
         GameKernel.renderManager.getUI().addComponent(this._toolTip.getDecorate());
         if(param3)
         {
            TweenLite.to(this._toolTip.getDecorate(),0.5,{
               "autoAlpha":1,
               "scaleX":1,
               "scaleY":1,
               "ease":Strong.easeOut
            });
         }
      }
      
      public function setSpecialColor(param1:String, param2:uint) : void
      {
         var _loc3_:TextField = null;
         if(this.ToolTip.getObject(param1))
         {
            _loc3_ = this.ToolTip.getObject(param1).Display as TextField;
            _loc3_.textColor = param2;
         }
      }
      
      public function Update(param1:String, param2:String, param3:int = -1, param4:Boolean = true) : void
      {
         var _loc5_:Object = null;
         var _loc6_:TextField = null;
         var _loc7_:TextFormat = null;
         if(Boolean(this._toolTip) && Boolean(this._toolTip.Data))
         {
            _loc5_ = this._toolTip.getObject(param1);
            if(_loc5_ == null)
            {
               return;
            }
            if(_loc5_.Display is TextField)
            {
               _loc6_ = _loc5_.Display as TextField;
            }
            else if(_loc5_.Display is Bitmap)
            {
               this._toolTip.getDecorate().addChild(_loc5_.Display);
               ComFormat(_loc5_.Format).isShow = true;
               return;
            }
            if(!ComFormat(_loc5_.Format).isShow)
            {
               this._toolTip.getDecorate().addChild(_loc6_);
               ComFormat(_loc5_.Format).isShow = true;
            }
            if(param2 == "" || param2 == null)
            {
               _loc6_.htmlText = ComFormat(_loc5_.Format).textDefault;
            }
            else
            {
               _loc6_.htmlText = param2;
               if(param4)
               {
                  BleakingLineForThai.GetInstance().BleakThaiLanguage(_loc6_,ComFormat(_loc5_.Format).fontColor);
               }
               else if(GamePlayer.getInstance().language == 10)
               {
                  BleakingLineForThai.GetInstance().SetDefaultColor(_loc6_,ComFormat(_loc5_.Format).fontColor);
                  _loc6_.autoSize = TextFieldAutoSize.RIGHT;
                  _loc7_ = _loc6_.getTextFormat();
                  _loc7_.align = TextFormatAlign.RIGHT;
                  _loc6_.setTextFormat(_loc7_);
                  _loc6_.defaultTextFormat = _loc7_;
               }
               if(param3 != -1)
               {
                  _loc6_.textColor = param3;
               }
            }
         }
      }
      
      private function ResetTextField(param1:TextField) : void
      {
      }
      
      public function replaceTexture(param1:String, param2:DisplayObject) : void
      {
         var _loc3_:Object = null;
         var _loc4_:DisplayObject = null;
         if(param2 == null)
         {
            _loc3_ = this._toolTip.getObject(param1);
            if(_loc3_ != null)
            {
               DisplayObject(_loc3_.Display).visible = false;
            }
            return;
         }
         _loc3_ = this._toolTip.getObject(param1);
         if(_loc3_ == null)
         {
            return;
         }
         var _loc5_:ComFormat = _loc3_.Format as ComFormat;
         if(_loc3_.Display == null)
         {
            _loc4_ = new Bitmap();
         }
         else
         {
            _loc4_ = _loc3_.Display as DisplayObject;
         }
         _loc4_.x = _loc5_.rectangle.x;
         _loc4_.y = _loc5_.rectangle.y;
         if(!ComFormat(_loc3_.Format).isShow)
         {
            this._toolTip.getDecorate().addChild(_loc4_);
            ComFormat(_loc3_.Format).isShow = true;
         }
         if(_loc4_.parent)
         {
            _loc4_.parent.removeChild(_loc4_);
         }
         _loc3_.Display = param2;
         param2.x = _loc4_.x;
         param2.y = _loc4_.y;
         _loc4_.visible = true;
         this._toolTip.getDecorate().addChild(param2);
      }
      
      public function ReSetShowState(param1:String) : void
      {
         var _loc2_:Object = null;
         if(Boolean(this._toolTip) && Boolean(this._toolTip.Data))
         {
            _loc2_ = this._toolTip.getObject(param1);
            ComFormat(_loc2_.Format).isShow = false;
            if(this._toolTip.getDecorate().contains(_loc2_.Display))
            {
               this._toolTip.getDecorate().removeChild(_loc2_.Display);
            }
         }
      }
      
      public function Hide() : void
      {
         if(Boolean(this._toolTip) && Boolean(this._toolTip.getDecorate().parent))
         {
            this._toolTip.getDecorate().parent.removeChild(this._toolTip.getDecorate());
         }
      }
      
      public function Load(param1:String) : void
      {
         this._toolTip = CToolTipFactory.InitToolTip(param1);
      }
      
      public function setInfoValue(param1:int, param2:int = -1, param3:int = 0, param4:int = 0) : void
      {
         var _loc5_:CTipInfo = null;
         _loc5_ = new CTipInfo(param1,param2,param3,param4,this);
         _loc5_.Init();
         this.putDecorate();
         this.changeState();
      }
      
      public function setDisableState(param1:String, param2:Boolean = true) : void
      {
         if(param2)
         {
            this.setSpecialColor(param1,16711680);
         }
         else
         {
            this.setSpecialColor(param1,65280);
         }
      }
      
      public function changeState() : void
      {
         var _loc1_:HashSet = null;
         var _loc2_:String = null;
         if(ConstructionUI.getInstance().CurrentConstructionCell != null)
         {
            _loc1_ = ConstructionUI.getInstance().CurrentConstructionCell.DependCondition;
         }
         else
         {
            _loc1_ = GameStatisticsManager.getInstance().Record;
         }
         this.setDisableState("UpgradeMetalDependTxt",false);
         this.setDisableState("UpgradeHe3DependTTxt",false);
         this.setDisableState("UpgradeMoneyDependTTxt",false);
         this.setDisableState("UpgradeMoneyDependTTxt",false);
         this.setDisableState("UpgradeCashDependTTxt",false);
         if(_loc1_ == null)
         {
            return;
         }
         if(_loc1_.Get("Metal"))
         {
            this.setDisableState("UpgradeMetalDependTxt");
         }
         else
         {
            this.setDisableState("UpgradeMetalDependTxt",false);
         }
         if(_loc1_.Get("Helium_3"))
         {
            this.setDisableState("UpgradeHe3DependTTxt");
         }
         else
         {
            this.setDisableState("UpgradeHe3DependTTxt",false);
         }
         if(_loc1_.Get("Funds"))
         {
            this.setDisableState("UpgradeMoneyDependTTxt");
         }
         else
         {
            this.setDisableState("UpgradeMoneyDependTTxt",false);
         }
         if(_loc1_.Get("Cash"))
         {
            this.setDisableState("UpgradeCashDependTTxt");
         }
         else
         {
            this.setDisableState("UpgradeCashDependTTxt",false);
         }
         if(_loc1_.Get("Dependbuilding"))
         {
            _loc2_ = ConstructionUtil.setDependStrFontFormat(_loc1_.Get("Dependbuilding"),CToolTipFactory.dependStr);
            this.Update("UpgradeDependTxt",_loc2_,-1,false);
         }
         else
         {
            this.setDisableState("UpgradeDependTxt",false);
         }
      }
      
      public function Render() : void
      {
         var _loc2_:Object = null;
         var _loc1_:int = 0;
         for each(_loc2_ in this.ToolTip.Data)
         {
            if(!ComFormat(_loc2_.Format).isShow)
            {
               this.Count(_loc1_,this.ToolTip.Data);
            }
            _loc1_++;
         }
      }
      
      public function putDecorate() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:RectangleKit = null;
         var _loc8_:DisplayObject = null;
         var _loc9_:DisplayObject = null;
         var _loc11_:Object = null;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         var _loc10_:Array = this.ToolTip.Data;
         for each(_loc11_ in _loc10_)
         {
            if(_loc11_.Format.isShow)
            {
               _loc9_ = _loc11_.Display;
               _loc12_ = _loc9_.width;
               _loc13_ = _loc9_.height;
               if(_loc9_ is TextField)
               {
                  if(TextField(_loc9_).autoSize != "none")
                  {
                     _loc12_ = TextField(_loc9_).textWidth;
                     _loc13_ = TextField(_loc9_).textHeight;
                  }
                  if(_loc11_.Format.anchor)
                  {
                     if(_loc8_ != null && _loc8_ != _loc9_)
                     {
                        _loc9_.x = _loc8_.x + TextField(_loc8_).width;
                     }
                  }
               }
               if(this._toolTip.LayOutType == 0)
               {
                  if(_loc3_ != 0 && _loc3_ != ComFormat(_loc11_.Format).rectangle.y)
                  {
                     _loc9_.y = _loc2_;
                  }
                  else if(_loc4_ != 0)
                  {
                     _loc9_.y = _loc4_;
                  }
                  _loc3_ = ComFormat(_loc11_.Format).rectangle.y;
                  _loc4_ = _loc9_.y;
               }
               _loc1_ = Math.max(_loc1_,_loc9_.x + _loc12_);
               _loc2_ = Math.max(_loc2_,_loc9_.y + _loc13_ + this._toolTip.Spacing);
               if(_loc9_)
               {
                  _loc8_ = _loc9_;
               }
            }
         }
         _loc7_ = this._toolTip.getDecorateBg().Rect;
         if(GamePlayer.getInstance().language == 10)
         {
            this._toolTip.getDecorateBg().Render(new RectangleKit(_loc7_.x,_loc7_.y,_loc1_ + 30,_loc2_ + 10));
         }
         else
         {
            this._toolTip.getDecorateBg().Render(new RectangleKit(_loc7_.x,_loc7_.y,_loc1_ + 10,_loc2_ + 10));
         }
      }
      
      private function Count(param1:int, param2:Array) : void
      {
         var _loc3_:DisplayObject = null;
         var _loc4_:int = 0;
         _loc3_ = param2[param1].Display as DisplayObject;
         if(param1 != -1 || param1 < param2.length)
         {
            _loc4_ = param1 + 1;
            while(_loc4_ < param2.length)
            {
               if(ComFormat(param2[_loc4_].Format).isShow)
               {
                  DisplayObject(param2[_loc4_].Display).y = DisplayObject(param2[_loc4_].Display).y - _loc3_.height * 0.5;
               }
               _loc4_++;
            }
         }
      }
   }
}

