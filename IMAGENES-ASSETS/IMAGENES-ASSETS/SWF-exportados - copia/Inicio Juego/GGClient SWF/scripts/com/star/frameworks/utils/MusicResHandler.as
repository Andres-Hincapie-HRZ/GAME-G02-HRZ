package com.star.frameworks.utils
{
   import flash.events.Event;
   import flash.media.Sound;
   import flash.media.SoundChannel;
   import flash.media.SoundTransform;
   
   public class MusicResHandler
   {
      
      private static var gameMusic:Sound;
      
      private static var gameSoundTransform:SoundTransform;
      
      public static var MusicCount:int = 0;
      
      private static var loadFinish:Boolean = false;
      
      private static var musicLoaderInfo:HashSet = new HashSet();
      
      private static var gameMusicChannel:SoundChannel = new SoundChannel();
      
      public static var playStageMusic:Boolean = false;
      
      public static var playEffectMusic:Boolean = false;
      
      public static const GALAXY_MUSIC:String = "galaxy_music";
      
      public static const BATTLE_MUSIC:String = "battle_music";
      
      public static const BOMB_EFFECT:String = "bomb_effect";
      
      public static const CMDERBLAST_EFFECT:String = "cmderBlast_effect";
      
      public static const SHIPBLAST_EFFECT:String = "shipBlast_effect";
      
      public static const SHIELD_EFFECT:String = "shield_effect";
      
      public static const CONNON_EFFECT:String = "connon_effect";
      
      public static const MISSILE_EFFECT:String = "missile_effect";
      
      public static const SHIPBASE_EFFECT:String = "shipBase_effect";
      
      public static const LASER_EFFECT:String = "laser_effect";
      
      public static const PARTICLE_EFFECT:String = "particle_effect";
      
      public static const FLACK_EFFECT:String = "flack_effect";
      
      public static const THOR_EFFECT:String = "thor_effect";
      
      public static const MOVE_EFFECT:String = "move_effect";
      
      private static var curMusic:String = "";
      
      private static var curVolume:Number = 1;
      
      private static var _instance:MusicResHandler = null;
      
      public function MusicResHandler(param1:HHH)
      {
         super();
      }
      
      public static function PlayGameMusic(param1:String = "galaxy_music") : void
      {
         if(curMusic == param1)
         {
            return;
         }
         if(loadFinish && playStageMusic)
         {
            if(Boolean(gameMusicChannel) && playStageMusic)
            {
               gameMusicChannel.stop();
            }
            curMusic = param1;
            gameMusic = musicLoaderInfo.Get(param1) as Sound;
            gameMusicChannel = gameMusic.play(0,9999);
            gameSoundTransform = gameMusicChannel.soundTransform;
            gameSoundTransform.volume = curVolume;
            gameMusicChannel.soundTransform = gameSoundTransform;
         }
      }
      
      public static function StopGameMusic() : void
      {
         if(!playStageMusic)
         {
            gameMusicChannel.stop();
         }
      }
      
      public static function GameMusicVolume(param1:Number) : void
      {
         param1 = param1 > 100 ? 100 : param1;
         param1 = param1 < 0 ? 0 : param1;
         param1 *= 0.01;
         curVolume = param1;
         gameSoundTransform = gameMusicChannel.soundTransform;
         gameSoundTransform.volume = param1;
         gameMusicChannel.soundTransform = gameSoundTransform;
      }
      
      public static function PlayEffectMusic(param1:String) : void
      {
         var _loc2_:Sound = null;
         var _loc3_:SoundChannel = null;
         if(!param1 || param1 == "")
         {
            return;
         }
         if(loadFinish && playEffectMusic)
         {
            _loc2_ = musicLoaderInfo.Get(param1) as Sound;
            _loc3_ = _loc2_.play(0,1);
            gameSoundTransform = _loc3_.soundTransform;
            gameSoundTransform.volume = curVolume;
            _loc3_.soundTransform = gameSoundTransform;
            _loc3_.addEventListener(Event.SOUND_COMPLETE,releaseMusic,false,0,true);
         }
      }
      
      private static function onPlayEffet(param1:Event) : void
      {
      }
      
      private static function releaseMusic(param1:Event) : void
      {
         param1.target.stop();
         param1.target.removeEventListener(Event.SOUND_COMPLETE,releaseMusic);
      }
      
      public static function get LoadFinish() : Boolean
      {
         return loadFinish;
      }
      
      public static function set LoadFinish(param1:Boolean) : void
      {
         loadFinish = param1;
         PlayGameMusic();
      }
      
      public static function PlayStage() : void
      {
         playStageMusic = !playStageMusic;
         if(!playStageMusic)
         {
            curMusic = "";
         }
      }
      
      public static function PlayEffect() : void
      {
         playEffectMusic = !playEffectMusic;
      }
      
      public static function PushMusic(param1:String, param2:*) : void
      {
         musicLoaderInfo.Put(param1,param2);
      }
      
      public static function get instance() : MusicResHandler
      {
         if(!_instance)
         {
            _instance = new MusicResHandler(new HHH());
         }
         return _instance;
      }
      
      public static function getPlayStageMusic() : Boolean
      {
         return playStageMusic;
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
