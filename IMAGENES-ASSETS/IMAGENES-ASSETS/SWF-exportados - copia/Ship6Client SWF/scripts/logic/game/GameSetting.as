package logic.game
{
   public class GameSetting
   {
      
      public static const DEBUG:Boolean = true;
      
      public static var DEBUG_NATIVE:Boolean = true;
      
      public static const DEBUG_MULTIPLE:Boolean = false;
      
      public static const GAME_STAGE_WIDTH:int = 760;
      
      public static const GAME_STAGE_HEIGHT:int = 650;
      
      public static const GAME_FRIEND_MAX_NUMBER:int = 6;
      
      public static const GAME_FULLSCREEN_WIDTH:int = 1920;
      
      public static const GAME_FULLSCREEN_HEIGHT:int = 1080;
      
      public static const GAME_FILE_PRIX:String = ".swf";
      
      public static const GAME_MAP_PATH:String = "map/";
      
      public static const GAME_TEXTURE_PRIX:String = ".jpg";
      
      public static const MAP_GRID_WIDTH:int = 36;
      
      public static const MAP_GRID_HEIGHT:int = 36;
      
      public static const MAP_SURFACE_OFFSET:Number = 1;
      
      public static const MAP_OUTSIDE_GRID_WIDTH:Number = 95;
      
      public static const MAP_OUTSIDE_GRID_HEIGHT:Number = 56;
      
      public static const MAP_OUTSIDE_GRID_NUMBER:int = 25;
      
      public static const MAP_OUTSIDE_GRID_NUMBER2:Number = MAP_OUTSIDE_GRID_NUMBER / 2;
      
      public static const MAP_OUTSIDE_OFFSETX:Number = 849.5;
      
      public static const MAP_OUTSIDE_OFFSETY:Number = 356;
      
      public static const CONSTRUCTION_TYPE_CIVICISM:int = 0;
      
      public static const CONSTRUCTION_TYPE_RES:int = 1;
      
      public static const CONSTRUCTION_TYPE_DIY:int = 2;
      
      public static const CONSTRUCTION_TYPE_MILITARY:int = 3;
      
      public static const CONSTRUCTION_TYPE_DEFENSE:int = 4;
      
      public static const CONSTRUCTION_TYPE:int = 5;
      
      public static const CONSTRUCTION_PROGRESS_NUMBER:int = 5;
      
      public static const CONSTRUCTION_CELL_NUMBER:int = 6;
      
      public static const CONSTRUCTION_OWER_CELL_NUMBER:int = 6;
      
      public static const CONSTRUCTION_BASE_WIDTH:int = 12;
      
      public static const CONSTRUCTION_BASE_HEIGHT:int = 6;
      
      public static const CHAT_INTERVAL_TIME:int = 10000;
      
      public static const CHAT_MAX_RECORD:int = 30;
      
      public static const CHAT_PER_TIME:int = 1;
      
      public static const CHAT_MAX_HEIGHT:int = 300;
      
      public static const CHAT_MAX_WIDTH:int = 300;
      
      public static const CHAT_CHANNEL_WORLD:int = 0;
      
      public static const CHAT_CHANNEL_LIST:Array = ["世界","军团","星球","小队"," 私聊","系统"];
      
      public static const CHAT_MAXCHARNUMBER_BIG:int = 64;
      
      public static const CHAT_MAXCHARNUMBER_EN:int = 128;
      
      public static const SERVER_INTERVAL:int = 400;
      
      public static const SERVER_MAX_STATUE:int = 7;
      
      public static const SERVER_STATE_0:int = 1;
      
      public static const SERVER_STATE_1:int = 600;
      
      public static const SERVER_STATE_2:int = 1200;
      
      public static const SERVER_STATE_3:int = 1800;
      
      public static const SERVER_STATE_4:int = 2400;
      
      public static const SERVER_STATE_5:int = 3000;
      
      public static const SERVER_STATE_6:int = 3500;
      
      public function GameSetting()
      {
         super();
      }
   }
}

