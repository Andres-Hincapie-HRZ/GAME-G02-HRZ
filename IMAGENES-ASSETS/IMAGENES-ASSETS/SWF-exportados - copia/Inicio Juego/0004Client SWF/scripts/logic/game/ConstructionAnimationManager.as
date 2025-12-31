package logic.game
{
   import flash.display.MovieClip;
   import logic.action.ConstructionAction;
   import logic.entry.Equiment;
   import logic.entry.EquimentTypeEnum;
   import logic.entry.GamePlayer;
   import logic.entry.ScienceSystem;
   import logic.widget.ConstructionMeomery;
   import net.router.UpgradeRouter;
   
   public class ConstructionAnimationManager
   {
      
      public function ConstructionAnimationManager()
      {
         super();
      }
      
      public static function PlayConstruction(param1:Equiment) : void
      {
         switch(param1.EquimentInfoData.BuildID)
         {
            case EquimentTypeEnum.EQUIMENT_TYPE_METAL:
               PlayConstuctionByBuildingID(EquimentTypeEnum.EQUIMENT_TYPE_METAL);
               break;
            case EquimentTypeEnum.EQUIMENT_TYPE_HELIUM_3:
               PlayConstuctionByBuildingID(EquimentTypeEnum.EQUIMENT_TYPE_HELIUM_3);
               break;
            case EquimentTypeEnum.EQUIMENT_TYPE_TRADEPORT:
               PlayConstuctionByBuildingID(EquimentTypeEnum.EQUIMENT_TYPE_TRADEPORT);
         }
      }
      
      public static function PlayConstuctionByBuildingID(param1:int) : void
      {
         var _loc2_:Array = null;
         var _loc3_:Equiment = null;
         var _loc4_:MovieClip = null;
         var _loc5_:MovieClip = null;
         switch(param1)
         {
            case EquimentTypeEnum.EQUIMENT_TYPE_HELIUM_3:
               _loc2_ = ConstructionMeomery.he3List;
               break;
            case EquimentTypeEnum.EQUIMENT_TYPE_METAL:
               _loc2_ = ConstructionMeomery.metalList;
               break;
            case EquimentTypeEnum.EQUIMENT_TYPE_HOMEREGION:
               _loc2_ = ConstructionMeomery.homeRegionList;
               break;
            case EquimentTypeEnum.EQUIMENT_TYPE_RESSTORECENTER:
               _loc3_ = ConstructionMeomery.resStorecenterList[0];
               if(_loc3_)
               {
                  _loc4_ = _loc3_.getMC().mc_anim as MovieClip;
                  _loc5_ = _loc3_.getMC().mc_fetch as MovieClip;
                  if(_loc4_)
                  {
                     _loc4_.gotoAndPlay(2);
                  }
                  if(_loc5_)
                  {
                     _loc5_.gotoAndStop(1);
                  }
               }
               return;
            case EquimentTypeEnum.EQUIMENT_TYPE_TECHRESEARCHCENTER:
               _loc3_ = ConstructionMeomery.techResearchList[0];
               if(_loc3_)
               {
                  _loc3_.PlayAnimation(true);
               }
               return;
            default:
               _loc2_ = ConstructionAction.constuctionList.Values();
               for each(_loc3_ in _loc2_)
               {
                  if(_loc3_.EquimentInfoData.BuildID == param1)
                  {
                     _loc3_.PlayAnimation(true);
                     return;
                  }
               }
               return;
         }
         for each(_loc3_ in _loc2_)
         {
            _loc3_.PlayAnimation(true);
         }
      }
      
      public static function StopConstructionDestined(param1:Equiment) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(!param1.IsOkay)
         {
            return;
         }
         var _loc2_:MovieClip = param1.getMC().mc_anim as MovieClip;
         if(_loc2_)
         {
            _loc2_.gotoAndStop(1);
            _loc2_.stop();
         }
      }
      
      public static function StopConstructionByBuildingID(param1:int) : void
      {
         var _loc2_:Array = null;
         var _loc3_:Equiment = null;
         switch(param1)
         {
            case EquimentTypeEnum.EQUIMENT_TYPE_HELIUM_3:
               _loc2_ = ConstructionMeomery.he3List;
               break;
            case EquimentTypeEnum.EQUIMENT_TYPE_METAL:
               _loc2_ = ConstructionMeomery.metalList;
               break;
            case EquimentTypeEnum.EQUIMENT_TYPE_HOMEREGION:
               _loc2_ = ConstructionMeomery.homeRegionList;
               break;
            case EquimentTypeEnum.EQUIMENT_TYPE_TECHRESEARCHCENTER:
               _loc2_ = ConstructionMeomery.techResearchList;
               break;
            default:
               _loc2_ = ConstructionAction.constuctionList.Values();
         }
         for each(_loc3_ in _loc2_)
         {
            if(_loc3_.EquimentInfoData.BuildID == param1)
            {
               _loc3_.PlayAnimation(false);
               _loc3_.getMC().stop();
               _loc3_.stop();
            }
         }
      }
      
      public static function StopConstruction(param1:Equiment) : void
      {
         var _loc2_:MovieClip = param1.getMC().mc_anim as MovieClip;
         if(param1.IsEffect)
         {
            if(_loc2_)
            {
               _loc2_.gotoAndPlay(1);
               _loc2_.stop();
            }
         }
      }
      
      public static function StopAllConstructionEffect() : void
      {
         var _loc2_:Equiment = null;
         var _loc3_:MovieClip = null;
         var _loc1_:Array = ConstructionAction.constuctionList.Values();
         for each(_loc2_ in _loc1_)
         {
            if(_loc2_.IsEffect)
            {
               _loc3_ = _loc2_.getMC().mc_anim as MovieClip;
               if(_loc3_)
               {
                  _loc3_.gotoAndPlay(1);
                  _loc3_.stop();
               }
            }
         }
      }
      
      public static function playResourceStorageFullAnimation(param1:Equiment) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc2_:MovieClip = param1.getMC().mc_anim as MovieClip;
         var _loc3_:MovieClip = param1.getMC().mc_fetch as MovieClip;
         _loc2_.gotoAndPlay(2);
         _loc3_.gotoAndStop(1);
      }
      
      public static function fetchResourceStorageAnimation(param1:Equiment) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc2_:MovieClip = param1.getMC().mc_anim as MovieClip;
         var _loc3_:MovieClip = param1.getMC().mc_fetch as MovieClip;
         if(_loc2_)
         {
            _loc2_.gotoAndStop(1);
         }
         if(_loc3_)
         {
            _loc3_.gotoAndPlay(2);
         }
      }
      
      public static function StopResourceStorageAnimation(param1:Equiment) : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:MovieClip = null;
         if(Boolean(param1) && param1.IsEffect)
         {
            _loc2_ = param1.getMC().mc_anim as MovieClip;
            _loc3_ = param1.getMC().fetctMc as MovieClip;
            if(_loc2_)
            {
               _loc2_.gotoAndStop(1);
            }
            if(_loc3_)
            {
               _loc3_.gotoAndStop(1);
            }
            return;
         }
      }
      
      public static function rePlayConstruction(param1:Equiment) : void
      {
         if(param1 == null)
         {
            return;
         }
         switch(param1.EquimentInfoData.BuildID)
         {
            case EquimentTypeEnum.EQUIMENT_TYPE_METAL:
               if(GamePlayer.getInstance().ResMetal >= GamePlayer.getInstance().ResStorageMetal)
               {
                  param1.PlayAnimation(false);
                  break;
               }
               param1.PlayAnimation(true);
               break;
            case EquimentTypeEnum.EQUIMENT_TYPE_HELIUM_3:
               if(GamePlayer.getInstance().ResGas >= GamePlayer.getInstance().ResStorageGas)
               {
                  param1.PlayAnimation(false);
                  break;
               }
               param1.PlayAnimation(true);
               break;
            case EquimentTypeEnum.EQUIMENT_TYPE_TRADEPORT:
               param1.PlayAnimation(true);
               break;
            case EquimentTypeEnum.EQUIMENT_TYPE_RADAR:
               param1.PlayAnimation(true);
               break;
            case EquimentTypeEnum.EQUIMENT_TYPE_SHIPBUILDING:
               if(GamePlayer.getInstance().m_IfbeingCreatShip)
               {
                  param1.PlayAnimation(true);
                  break;
               }
               param1.PlayAnimation(false);
               break;
            case EquimentTypeEnum.EQUIMENT_TYPE_TECHRESEARCHCENTER:
               if(ScienceSystem.getinstance().Online)
               {
                  param1.PlayAnimation(true);
                  break;
               }
               param1.PlayAnimation(false);
               break;
            case EquimentTypeEnum.EQUIMENT_TYPE_WEAPONRESEARCHCENTER:
               if(UpgradeRouter.instance.IsUpgrading())
               {
                  param1.PlayAnimation(true);
                  break;
               }
               param1.PlayAnimation(false);
         }
         ConstructionAction.getInstance().setStorageActiveState();
      }
      
      public static function rePlayConstructionAll() : void
      {
         if(GamePlayer.getInstance().ResGas >= GamePlayer.getInstance().ResStorageGas)
         {
            ConstructionAnimationManager.StopConstructionByBuildingID(EquimentTypeEnum.EQUIMENT_TYPE_HELIUM_3);
         }
         else
         {
            ConstructionAnimationManager.PlayConstuctionByBuildingID(EquimentTypeEnum.EQUIMENT_TYPE_HELIUM_3);
         }
         if(GamePlayer.getInstance().ResMetal >= GamePlayer.getInstance().ResStorageMetal)
         {
            ConstructionAnimationManager.StopConstructionByBuildingID(EquimentTypeEnum.EQUIMENT_TYPE_METAL);
         }
         else
         {
            ConstructionAnimationManager.PlayConstuctionByBuildingID(EquimentTypeEnum.EQUIMENT_TYPE_METAL);
         }
         ConstructionAnimationManager.PlayConstuctionByBuildingID(EquimentTypeEnum.EQUIMENT_TYPE_TRADEPORT);
         ConstructionAnimationManager.PlayConstuctionByBuildingID(EquimentTypeEnum.EQUIMENT_TYPE_RADAR);
         if(GamePlayer.getInstance().m_IfbeingCreatShip)
         {
            ConstructionAnimationManager.PlayConstuctionByBuildingID(EquimentTypeEnum.EQUIMENT_TYPE_SHIPBUILDING);
         }
         else
         {
            ConstructionAnimationManager.StopConstructionByBuildingID(EquimentTypeEnum.EQUIMENT_TYPE_SHIPBUILDING);
         }
         if(ScienceSystem.getinstance().Online)
         {
            ConstructionAnimationManager.PlayConstuctionByBuildingID(EquimentTypeEnum.EQUIMENT_TYPE_TECHRESEARCHCENTER);
         }
         else
         {
            ConstructionAnimationManager.StopConstructionByBuildingID(EquimentTypeEnum.EQUIMENT_TYPE_TECHRESEARCHCENTER);
         }
         if(UpgradeRouter.instance.IsUpgrading())
         {
            ConstructionAnimationManager.PlayConstuctionByBuildingID(EquimentTypeEnum.EQUIMENT_TYPE_WEAPONRESEARCHCENTER);
         }
         else
         {
            ConstructionAnimationManager.StopConstructionByBuildingID(EquimentTypeEnum.EQUIMENT_TYPE_WEAPONRESEARCHCENTER);
         }
         ConstructionAction.getInstance().setStorageActiveState();
      }
      
      private static function onCompleted() : void
      {
      }
   }
}

