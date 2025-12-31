package logic.ui
{
   import com.star.frameworks.utils.MusicResHandler;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import logic.entry.HButton;
   import logic.entry.HButtonType;
   import logic.entry.MObject;
   import logic.entry.test.MovieClipDataBox;
   import logic.game.GameKernel;
   import logic.manager.GalaxyManager;
   import logic.manager.InstanceManager;
   
   public class MusicControlUI extends AbstractPopUp
   {
      
      private static var _instance:MusicControlUI = null;
      
      private var mcData:MovieClipDataBox;
      
      private var _win:Sprite = new Sprite();
      
      private var _closeBtn:Sprite = new Sprite();
      
      private var _show:Boolean = false;
      
      private var _loadingMc:MovieClip;
      
      public function MusicControlUI(param1:HHH)
      {
         super();
         setPopUpName("MusicControlUI");
         this._mc = new MObject("MusicScene",100,160);
         this._loadingMc = GameKernel.getMovieClipInstance("Nowloading");
         this.mcData = new MovieClipDataBox(_mc.getMC());
         this.initMcElement();
      }
      
      public static function get instance() : MusicControlUI
      {
         if(!_instance)
         {
            _instance = new MusicControlUI(new HHH());
         }
         return _instance;
      }
      
      override public function Init() : void
      {
         if(GameKernel.popUpDisplayManager.PopDisplayList.ContainsKey(getPopUpName()))
         {
            if(this._show)
            {
               GameKernel.popUpDisplayManager.Hide(_instance);
               this._show = false;
            }
            else
            {
               GameKernel.popUpDisplayManager.Show(_instance,false);
               this._show = true;
            }
            return;
         }
         GameKernel.popUpDisplayManager.Regisger(_instance);
         GameKernel.popUpDisplayManager.Show(_instance,false);
      }
      
      override public function initMcElement() : void
      {
         var _loc1_:MovieClip = null;
         var _loc2_:HButton = null;
         _loc1_ = this.mcData.getMC("btn_stagemusic");
         _loc1_.addEventListener(MouseEvent.CLICK,this.onSelect);
         _loc2_ = new HButton(_loc1_,HButtonType.SELECT);
         _loc1_ = this.mcData.getMC("btn_battlemusic");
         _loc1_.addEventListener(MouseEvent.CLICK,this.onSelect);
         _loc2_ = new HButton(_loc1_,HButtonType.SELECT);
         _loc1_ = this.mcData.getMC("mc_shadebg");
         _loc1_.addEventListener(MouseEvent.CLICK,this.onSelect);
         _loc1_ = this.mcData.getMC("mc_shade");
         _loc1_.addEventListener(MouseEvent.CLICK,this.onSelect);
         _loc1_ = this.mcData.getMC("btn_close");
         _loc1_.addEventListener(MouseEvent.CLICK,this.onSelect);
         _loc2_ = new HButton(_loc1_);
      }
      
      private function onSelect(param1:MouseEvent) : void
      {
         switch(param1.target.name)
         {
            case "btn_stagemusic":
               MusicResHandler.PlayStage();
               if(GalaxyManager.instance.enterStar.FightFlag == 1)
               {
                  MusicResHandler.PlayGameMusic(MusicResHandler.BATTLE_MUSIC);
               }
               else if(GalaxyManager.instance.isMineHome() && (InstanceManager.instance.instanceStatus == InstanceManager.FB_FIGHT || InstanceManager.instance.curStatus == InstanceManager.FB_FIGHT))
               {
                  MusicResHandler.PlayGameMusic(MusicResHandler.BATTLE_MUSIC);
               }
               else
               {
                  MusicResHandler.PlayGameMusic(MusicResHandler.GALAXY_MUSIC);
               }
               MusicResHandler.StopGameMusic();
               break;
            case "btn_battlemusic":
               MusicResHandler.PlayEffect();
               break;
            case "mc_shade":
               this.mcData.getMC("mc_mask").width = this.mcData.getMC("mc_shade").mouseX;
               MusicResHandler.GameMusicVolume(this.mcData.getMC("mc_mask").width);
               break;
            case "mc_shadebg":
               this.mcData.getMC("mc_mask").width = this.mcData.getMC("mc_shadebg").mouseX - 6;
               MusicResHandler.GameMusicVolume(this.mcData.getMC("mc_mask").width);
               break;
            case "btn_close":
               GameKernel.popUpDisplayManager.Hide(_instance);
               this._show = false;
         }
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
