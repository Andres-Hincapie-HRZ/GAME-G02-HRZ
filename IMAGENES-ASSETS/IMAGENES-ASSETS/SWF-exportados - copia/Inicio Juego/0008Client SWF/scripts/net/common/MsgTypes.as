package net.common
{
   public class MsgTypes
   {
      
      private static var _instance:MsgTypes;
      
      public static const MAP_RANGE:int = 420;
      
      public static const MAX_NAME:int = 32;
      
      public static const MAX_MEMO:int = 256;
      
      public static const CHAT_MESSAGE:int = 128;
      
      public static const VALIDATECODE_LENTH:int = 25;
      
      public static const SESSIONKEY_LENGTH:int = 128;
      
      public static const MAX_GAMESERVERLIST:int = 60;
      
      public static const FIGHTSTARMATRIX:int = 4;
      
      public static const MAX_CREATECONSORTIALEVEL:int = 8;
      
      public static const TECHSTART_CONSORTIA:int = 201;
      
      public static const TECHSTART_CAMP:int = 101;
      
      public static const MAX_MAP_ROW:int = 25;
      
      public static const MAX_MAP_COL:int = 25;
      
      public static const MAX_BUILDING:int = 200;
      
      public static const MAX_SHIPPART:int = 50;
      
      public static const MAX_SHIPTEAMBODY:int = 9;
      
      public static const SHIPMODEL_TECH:int = 5;
      
      public static const MAX_SHIPMODEL:int = 30;
      
      public static const MAX_SHIPCREATING:int = 5;
      
      public static const MAX_SHIPDISTYPE:int = 200;
      
      public static const MIN_HOLDSTAR:int = 0;
      
      public static const MAX_ADJUTANTNUM:int = 30;
      
      public static const MAX_COMMANDNUM:int = 30;
      
      public static const MAX_USERSHIPTEAMNUM:int = 60;
      
      public static const MAX_GALAXYSTARNUM:int = 50;
      
      public static const MAX_874_COUNT:int = 5;
      
      public static const MAX_874_ALLCOUNT:int = 20;
      
      public static const MAX_874_Additional:int = 5;
      
      public static const MAX_FIGHTRESULTEXP:int = 10;
      
      public static const MAX_FIGHTRESULTKILL:int = 10;
      
      public static const MAX_FIGHTRESULTPRIZE:int = 10;
      
      public static const MAX_GALAXYCAMP:int = 80;
      
      public static const MAX_FIGHTMOVEPATH:int = 16;
      
      public static const MAX_CAMP:int = 7;
      
      public static const MAX_MSG_PART:int = 7;
      
      public static const MAX_SENDTEAMINFO:int = 189;
      
      public static const MAX_CHATFRIEDN:int = 50;
      
      public static const MAX_DATETIME:int = 20;
      
      public static const MAX_MATRIXSHIP:int = 3000;
      
      public static const MAX_VALIDSHIP:int = 1000;
      
      public static const MAX_CAMPLOCKNUM:int = 30;
      
      public static const MAX_DOWNLOADURL:int = 60;
      
      public static const MAX_TRADECOUNT:int = 20;
      
      public static const MAX_VOTEPERSON:int = 50;
      
      public static const MAX_CONSORTIAFIELD:int = 10;
      
      public static const MAX_OFFICIALCOUNT:int = 4;
      
      public static const MaxDeadShipData:int = 90;
      
      public static const CLIENTMAXLOADAREA:int = 9;
      
      public static const MAX_CREATESHIPLIST:int = 10;
      
      public static const AREAGRIDX:int = 10;
      
      public static const AREAGRIDY:int = 10;
      
      public static const GRIDPIXELX:int = 80;
      
      public static const GRIDPIXELY:int = 80;
      
      public static const AREAGRID:int = AREAGRIDX * AREAGRIDY;
      
      public static const MAX_MAPAREA:int = 10;
      
      public static const MAX_MAPAREAGRID:int = AREAGRIDY * MAX_MAPAREA;
      
      public static const CITYMAPWIDTH:int = 1600;
      
      public static const CITYMAPHEIGHT:int = 1200;
      
      public static const COMMANDERZJCOUNT:int = 8;
      
      public static const MAX_SHIPBODYUPGRADELIST:int = 1;
      
      public static const MAX_COMMANDERNUM:int = 60;
      
      public static const MAX_TEAMMODEL:int = 3;
      
      public static const MAX_RANKPAGELEN:int = 6;
      
      public static const MAX_MSGFRIENDLEN:int = 100;
      
      public static const MAX_EMAILCONTENT:int = 512;
      
      public static const MAX_EMAILGOODS:int = 100;
      
      public static const MAX_FIELDRESOURCE:int = 12;
      
      public static const CT_WORLD:int = 0;
      
      public static const CT_CAMP:int = 1;
      
      public static const CT_GALAXY:int = 2;
      
      public static const CT_CONSORTIA:int = 3;
      
      public static const CT_PRIVATE:int = 4;
      
      public static const CT_SCRIPT:int = 5;
      
      public static const CT_SYSTEM:int = 6;
      
      public static const CT_CAMPNOTICE:int = 7;
      
      public static const CT_OTHER:int = 8;
      
      public static const CT_GMNOTICE:int = 9;
      
      public static const MAP_WORLD:int = 0;
      
      public static const SST_STARTRUSTEE:int = 0;
      
      public static const SST_MINERAL:int = 1;
      
      public static const SST_GAS:int = 2;
      
      public static const SST_POPULATION:int = 3;
      
      public static const SST_TECH:int = 4;
      
      public static const SST_BUILDINGSPEED:int = 5;
      
      public static const SST_JUMPSPEED:int = 6;
      
      public static const SST_BUILDSHIPSPEED:int = 7;
      
      public static const SST_EMPOLDERBASW:int = 8;
      
      public static const SST_COMMANDERUPPERLIMIT:int = 9;
      
      public static const SST_STARUPPERLIMIT:int = 10;
      
      public static const SST_LOOKONBATTLE:int = 11;
      
      public static const SST_ACTIVESHIPNUM:int = 12;
      
      public static const CT_NONE:int = -1;
      
      public static const CT_NPC:int = 0;
      
      public static const CT_COUNTRY1:int = 1;
      
      public static const CT_COUNTRY2:int = 2;
      
      public static const CT_COUNTRY3:int = 3;
      
      public static const CT_COUNTRY4:int = 4;
      
      public static const CT_COUNTRY5:int = 5;
      
      public static const CT_COUNTRY6:int = 6;
      
      public static const CT_COUNT:int = 7;
      
      public static const JOB_Civilian:int = 0;
      
      public static const JOB_State:int = 1;
      
      public static const JOB_Defense:int = 2;
      
      public static const JOB_Interior:int = 3;
      
      public static const JOB_Member:int = 4;
      
      public static const JOB_Staff:int = 5;
      
      public static const JOB_Scholar:int = 6;
      
      public static const JOB_Leader:int = 7;
      
      public static const SERVICESITEM_NUM:int = 12;
      
      public static const CT_STARTYPE1:int = 1;
      
      public static const CT_STARTYPE2:int = 2;
      
      public static const CT_STARTYPE3:int = 3;
      
      public static const CT_STARTYPE4:int = 4;
      
      public static const CT_STARTYPE5:int = 5;
      
      public static const TEAMBADY_NUM:int = 9;
      
      public static const DIRECTION_RIGHT:int = 0;
      
      public static const DIRECTION_DOWN:int = 1;
      
      public static const DIRECTION_LEFT:int = 2;
      
      public static const DIRECTION_UP:int = 3;
      
      public static const SHIP_ASSAULT:int = 1;
      
      public static const SHIP_CRUISER:int = 2;
      
      public static const SHIP_WARSHIP:int = 3;
      
      public static const BUILD_NEWBUILD:int = -1;
      
      public static const BUILD_QUICKBUILD:int = 0;
      
      public static const MAX_HELPCOUNT:int = 8;
      
      public static const MAX_FRIENDFIELDSTATUS:int = 6;
      
      public static const MAX_NAME_LEN:int = 8;
      
      public static const MSGBUFFERPOS_HEAD:int = 0;
      
      public static const MSGBUFFERPOS_TYPE:int = 2;
      
      public static const MAX_COMMANDERSTORE:int = 12;
      
      public static const HONOR_PROPOS_ID:int = 931;
      
      public static const _MSG_CLIENT_LOGINTOL:int = 502;
      
      public static const _MSG_CLIENT_LOGINTOG:int = 503;
      
      public static const _MSG_LOGINSERVER_VALIDATE:int = 504;
      
      public static const _MSG_GAMESERVER_LOGINRESP:int = 505;
      
      public static const _MSG_DBSERVER_ROLEINFO:int = 507;
      
      public static const _MSG_GAMESERVER_SENDGIFT:int = 514;
      
      public static const _MSG_GAMESERVER_USERLEVELRESP:int = 516;
      
      public static const _MSG_LOGIN:int = 1000;
      
      public static const _MSG_LOGIN_RETURN_INFO:int = 1001;
      
      public static const _MSG_REQUEST_GAMESERVER:int = 1002;
      
      public static const _MSG_VALIDATE_GAMESERVER:int = 1003;
      
      public static const _MSG_LOGIN_GAMESERVER:int = 1004;
      
      public static const _MSG_LOGIN_GAMESERVER2:int = 1005;
      
      public static const _MSG_RESPONSE_GAMESERVER:int = 1006;
      
      public static const _MSG_ROLE_INFO:int = 1007;
      
      public static const _MSG_REQUEST_CREATEROLE:int = 1008;
      
      public static const _MSG_CREATE_ROLE:int = 1009;
      
      public static const _MSG_GAMESERVER_READY:int = 1010;
      
      public static const _MSG_ENTER_GAME:int = 1011;
      
      public static const _MSG_CLIENT_READY:int = 1012;
      
      public static const _MSG_GAMESERVER_INFO:int = 1013;
      
      public static const _MSG_REQUEST_PUSHTEST:int = 1014;
      
      public static const _MSG_RESP_CREATEROLE:int = 1015;
      
      public static const _MSG_RESP_DBREADOVER:int = 1016;
      
      public static const _MSG_REQUEST_PLAYERINFO:int = 1017;
      
      public static const _MSG_RESP_ACCOUNTAUTH:int = 1018;
      
      public static const _MSG_GAME_CLOSECLIENT:int = 1019;
      
      public static const _MSG_GAME_CLIENTACTIVE:int = 1020;
      
      public static const _MSG_LOGINSERVER_GAMESERVERLISTRESP:int = 1021;
      
      public static const _MSG_LOGINSERVER_CHECKREGISTERNAME:int = 1022;
      
      public static const _MSG_LOGINSERVER_CHECKREGISTERNAMERESP:int = 1023;
      
      public static const _MSG_REQUEST_UPDATEPLAYERNAME:int = 1024;
      
      public static const _MSG_RESP_UPDATEPLAYERNAME:int = 1025;
      
      public static const _MSG_REQUEST_CHANGESERVER:int = 1050;
      
      public static const _MSG_RESP_CHANGESERVER:int = 1051;
      
      public static const _MSG_REQUEST_PROPSMOVE:int = 1052;
      
      public static const _MSG_RESP_PROPSMOVE:int = 1053;
      
      public static const _MSG_RESP_PROPSINFO:int = 1054;
      
      public static const _MSG_REQUEST_USEPROPS:int = 1055;
      
      public static const _MSG_RESP_USEPROPS:int = 1056;
      
      public static const _MSG_REQUEST_ADDPACK:int = 1057;
      
      public static const _MSG_RESP_ADDPACK:int = 1058;
      
      public static const _MSG_REQUEST_DELETEPROPS:int = 1059;
      
      public static const _MSG_RESP_DELETEPROPS:int = 1060;
      
      public static const _MSG_RESP_MAPBLOCK:int = 1061;
      
      public static const _MSG_REQUEST_BUYGOODS:int = 1062;
      
      public static const _MSG_RESP_BUYGOODS:int = 1063;
      
      public static const _MSG_REQUEST_TASKINFO:int = 1064;
      
      public static const _MSG_RESP_TASKINFO:int = 1065;
      
      public static const _MSG_REQUEST_TASKGAIN:int = 1066;
      
      public static const _MSG_RESP_TASKGAIN:int = 1067;
      
      public static const _MSG_REQUEST_GAINDAILYAWARD:int = 1068;
      
      public static const _MSG_RESP_GAINDAILYAWARD:int = 1069;
      
      public static const _MSG_REQUEST_COMPLETEGUIDE:int = 1070;
      
      public static const _MSG_REQUEST_GAMESERVERLIST:int = 1071;
      
      public static const _MSG_RESP_GAMESERVERLIST:int = 1072;
      
      public static const _MSG_TRANSMIT_ROLEINFO:int = 1073;
      
      public static const _MSG_TRANSMIT_TASK:int = 1074;
      
      public static const _MSG_TRANSMIT_SHIPBODYINFO:int = 1075;
      
      public static const _MSG_TRANSMIT_COMMANDER:int = 1076;
      
      public static const _MSG_TRANSMIT_STAR:int = 1077;
      
      public static const _MSG_TRANSMIT_SHIPMODEL:int = 1078;
      
      public static const _MSG_TRANSMIT_DBWRITECOMPLETE:int = 1079;
      
      public static const _MSG_TRANSMIT_UPDATESERVERID:int = 1080;
      
      public static const _MSG_TRANSMIT_UPDATESERVERIDRESP:int = 1081;
      
      public static const _MSG_REQUEST_GAINLOTTERY:int = 1082;
      
      public static const _MSG_RESP_GAINLOTTERY:int = 1083;
      
      public static const _MSG_RESP_LOTTERYSTATUS:int = 1084;
      
      public static const _MSG_REQUEST_DELETESERVER:int = 1085;
      
      public static const _MSG_RESP_DELETESERVER:int = 1086;
      
      public static const _MSG_REQUEST_REFRESHWALL:int = 1087;
      
      public static const _MSG_RESP_REFRESHWALL:int = 1088;
      
      public static const _MSG_REQUEST_EXCHANGERES:int = 1089;
      
      public static const _MSG_RESP_EXCHANGERES:int = 1090;
      
      public static const _MSG_REQUEST_ONLINEAWARD:int = 1091;
      
      public static const _MSG_RESP_ONLINEAWARD:int = 1092;
      
      public static const _MSG_REQUEST_GETONLINEAWARD:int = 1093;
      
      public static const _MSG_RESP_GETONLINEAWARD:int = 1094;
      
      public static const _MSG_REQUEST_GALAXY:int = 1100;
      
      public static const _MSG_RESP_GALAXY:int = 1101;
      
      public static const _MSG_REQUEST_STAR:int = 1102;
      
      public static const _MSG_RESP_STAR:int = 1103;
      
      public static const _MSG_RESP_MOVEHOMEBRO:int = 1104;
      
      public static const _MSG_REQUEST_HOLDGALAXY:int = 1105;
      
      public static const _MSG_RESP_HOLDGALAXY:int = 1106;
      
      public static const _MSG_REQUEST_SHOWEMPTYGALAXY:int = 1107;
      
      public static const _MSG_REQUEST_UPDATESTARNAME:int = 1108;
      
      public static const _MSG_RESP_UPDATESTARNAME:int = 1109;
      
      public static const _MSG_REQUEST_MOVEHOME:int = 1110;
      
      public static const _MSG_RESP_MOVEHOME:int = 1111;
      
      public static const _MSG_FIGHTGALAXYOVER:int = 1112;
      
      public static const _MSG_RESP_GALAXYBROADCAST:int = 1113;
      
      public static const _MSG_REQUEST_THROWSTAR:int = 1114;
      
      public static const _MSG_RESP_THROWSTAR:int = 1115;
      
      public static const _MSG_REQUEST_LEAVEGALAXY:int = 1116;
      
      public static const _MSG_REQUEST_BUILDDEMANDINFO:int = 1117;
      
      public static const _MSG_RESP_BUILDDEMANDINFO:int = 1118;
      
      public static const _MSG_REQUEST_HOLDGALAXYINFO:int = 1119;
      
      public static const _MSG_RESP_HOLDGALAXYINFO:int = 1120;
      
      public static const _MSG_REQUEST_LOCKGALAXY:int = 1121;
      
      public static const _MSG_RESP_LOCKGALAXY:int = 1122;
      
      public static const _MSG_REQUEST_GALAXYLOCKINFO:int = 1123;
      
      public static const _MSG_RESP_GALAXYLOCKINFO:int = 1124;
      
      public static const _MSG_REQUEST_STARAUTOUPGRADE:int = 1125;
      
      public static const _MSG_RESP_STARAUTOUPGRADE:int = 1126;
      
      public static const _MSG_REQUEST_SPACE:int = 1127;
      
      public static const _MSG_RESP_SPACE:int = 1128;
      
      public static const _MSG_REQUEST_TREASURE:int = 1129;
      
      public static const _MSG_RESP_TREASURE:int = 1130;
      
      public static const _MSG_REQUEST_RESCHANGE:int = 1131;
      
      public static const _MSG_RESP_RESCHANGE:int = 1132;
      
      public static const _MSG_FIGHTGALAXYBEGIN:int = 1133;
      
      public static const _MSG_REQUEST_ECTYPE:int = 1134;
      
      public static const _MSG_RESP_ECTYPESTATE:int = 1135;
      
      public static const _MSG_RESP_HOMETREASURE:int = 1136;
      
      public static const _MSG_REQUEST_HOMETREASURE:int = 1137;
      
      public static const _MSG_RESP_HOMECOPYFLAG:int = 1138;
      
      public static const _MSG_REQUEST_LOCKGALAXYCAMP:int = 1139;
      
      public static const _MSG_RESP_LOCKGALAXYCAMP:int = 1140;
      
      public static const _MSG_RESP_GALAXYGOODS:int = 1141;
      
      public static const _MSG_REQUEST_LIFESHIP:int = 1142;
      
      public static const _MSG_RESP_LIFESHIP:int = 1143;
      
      public static const _MSG_REQUEST_REBUILDSTAR:int = 1144;
      
      public static const _MSG_RESP_REBUILDSTAR:int = 1145;
      
      public static const _MSG_RESP_REBUILDSTARINFO:int = 1146;
      
      public static const _MSG_REQUEST_HOMETASK:int = 1147;
      
      public static const _MSG_RESP_HOMETASKFLAG:int = 1148;
      
      public static const _MSG_RESP_HOMETASKSTATUS:int = 1149;
      
      public static const _MSG_REQUEST_GALAXYAUTOUPGRADE:int = 1150;
      
      public static const _MSG_RESP_GALAXYAUTOUPGRADE:int = 1151;
      
      public static const _MSG_REQUEST_HOMEADDSTAR:int = 1152;
      
      public static const _MSG_RESP_HOMEADDSTAR:int = 1153;
      
      public static const _MSG_REQUEST_GALAXYSHIPBUILD:int = 1154;
      
      public static const _MSG_RESP_GALAXYSHIPBUILD:int = 1155;
      
      public static const _MSG_REQUEST_GALAXYINFO:int = 1156;
      
      public static const _MSG_RESP_GALAXYINFO:int = 1157;
      
      public static const _MSG_RESP_INSERTFLAGBRO:int = 1158;
      
      public static const _MSG_REQUEST_CREATEBUILD:int = 1200;
      
      public static const _MSG_RESP_CREATEBUILD:int = 1201;
      
      public static const _MSG_REQUEST_BUILDINFO:int = 1202;
      
      public static const _MSG_RESP_BUILDINFO:int = 1203;
      
      public static const _MSG_RESP_BUILDCOMPLETE:int = 1204;
      
      public static const _MSG_REQUEST_CANCELBUILD:int = 1205;
      
      public static const _MSG_RESP_CANCELBUILD:int = 1206;
      
      public static const _MSG_REQUEST_DELETEBUILD:int = 1207;
      
      public static const _MSG_RESP_DELETEBUILD:int = 1208;
      
      public static const _MSG_REQUEST_CREATETECH:int = 1209;
      
      public static const _MSG_RESP_CREATETECH:int = 1210;
      
      public static const _MSG_REQUEST_TECHINFO:int = 1211;
      
      public static const _MSG_RESP_TECHINFO:int = 1212;
      
      public static const _MSG_REQUEST_PLAYERRESOURCE:int = 1213;
      
      public static const _MSG_RESP_PLAYERRESOURCE:int = 1214;
      
      public static const _MSG_REQUEST_TECHUPGRADEINFO:int = 1215;
      
      public static const _MSG_RESP_TECHUPGRADEINFO:int = 1216;
      
      public static const _MSG_REQUEST_CANCELTECH:int = 1217;
      
      public static const _MSG_RESP_CANCELTECH:int = 1218;
      
      public static const _MSG_RESP_CREATETECHCOMPLETE:int = 1219;
      
      public static const _MSG_REQUEST_BUILDCREATING:int = 1220;
      
      public static const _MSG_RESP_BUILDCREATING:int = 1221;
      
      public static const _MSG_REQUEST_SPEEDBUILDING:int = 1222;
      
      public static const _MSG_RESP_SPEEDBUILDING:int = 1223;
      
      public static const _MSG_REQUEST_TIMEQUEUE:int = 1224;
      
      public static const _MSG_RESP_TIMEQUEUE:int = 1225;
      
      public static const _MSG_REQUEST_CONSORTIABUILDING:int = 1226;
      
      public static const _MSG_RESP_CONSORTIABUILDING:int = 1227;
      
      public static const _MSG_REQUEST_SPEEDTECH:int = 1228;
      
      public static const _MSG_RESP_SPEEDTECH:int = 1229;
      
      public static const _MSG_REQUEST_SPEEDFRIENDBUILDING:int = 1230;
      
      public static const _MSG_RESP_SPEEDFRIENDBUILDING:int = 1231;
      
      public static const _MSG_REQUEST_GETSTORAGERESOURCE:int = 1232;
      
      public static const _MSG_RESP_GETSTORAGERESOURCE:int = 1233;
      
      public static const _MSG_REQUEST_MOVEBUILD:int = 1234;
      
      public static const _MSG_RESP_MOVEBUILD:int = 1235;
      
      public static const _MSG_REQUEST_STORAGERESOURCE:int = 1236;
      
      public static const _MSG_RESP_STORAGERESOURCE:int = 1237;
      
      public static const _MSG_RESP_BUILDINGDEATHCOMPLETE:int = 1238;
      
      public static const _MSG_RESP_CREATEBUILDINFO:int = 1239;
      
      public static const _MSG_RESP_BUILDINFOFRIEND:int = 1240;
      
      public static const _MSG_REQUEST_MAPAREA:int = 1250;
      
      public static const _MSG_RESP_MAPAREA:int = 1251;
      
      public static const _MSG_REQUEST_SMALLMAP:int = 1252;
      
      public static const _MSG_RESP_SMALLMAP:int = 1253;
      
      public static const _MSG_REQUEST_GALAXYMAPAREA:int = 1254;
      
      public static const _MSG_REQUEST_MAPBLOCK:int = 1255;
      
      public static const _MSG_RESP_MAPBLOCKFIGHT:int = 1256;
      
      public static const _MSG_REQUEST_MAPBLOCKUSERINFO:int = 1257;
      
      public static const _MSG_RESP_MAPBLOCKUSERINFO:int = 1258;
      
      public static const _MSG_REQUEST_CREATESHIPMODEL:int = 1300;
      
      public static const _MSG_RESP_CREATESHIPMODEL:int = 1301;
      
      public static const _MSG_REQUEST_SHIPMODELINFO:int = 1302;
      
      public static const _MSG_RESP_SHIPMODELINFO:int = 1303;
      
      public static const _MSG_RESP_SHIPMODELINFODEL:int = 1304;
      
      public static const _MSG_REQUEST_DELETESHIPMODEL:int = 1305;
      
      public static const _MSG_RESP_DELETESHIPMODEL:int = 1306;
      
      public static const _MSG_REQUEST_SHIPBODYINFO:int = 1307;
      
      public static const _MSG_RESP_SHIPBODYINFO:int = 1308;
      
      public static const _MSG_REQUEST_CREATESHIP:int = 1309;
      
      public static const _MSG_RESP_CREATESHIP:int = 1310;
      
      public static const _MSG_REQUEST_CANCELSHIP:int = 1311;
      
      public static const _MSG_RESP_CANCELSHIP:int = 1312;
      
      public static const _MSG_REQUEST_CREATESHIPINFO:int = 1313;
      
      public static const _MSG_RESP_CREATESHIPINFO:int = 1314;
      
      public static const _MSG_RESP_SHIPCREATINGCOMPLETE:int = 1315;
      
      public static const _MSG_REQUEST_CREATESHIPTEAM:int = 1316;
      
      public static const _MSG_RESP_CREATESHIPTEAM:int = 1317;
      
      public static const _MSG_REQUEST_ARRANGESHIPTEAM:int = 1318;
      
      public static const _MSG_RESP_ARRANGESHIPTEAM:int = 1319;
      
      public static const _MSG_REQUEST_EDITSHIPTEAM:int = 1320;
      
      public static const _MSG_RESP_EDITSHIPTEAM:int = 1321;
      
      public static const _MSG_REQUEST_MOVESHIPTEAM:int = 1322;
      
      public static const _MSG_RESP_MOVESHIPTEAM:int = 1323;
      
      public static const _MSG_REQUEST_DELETESHIPTEAM:int = 1324;
      
      public static const _MSG_RESP_DELETESHIPTEAM:int = 1325;
      
      public static const _MSG_REQUEST_DISBANDSHIPTEAM:int = 1326;
      
      public static const _MSG_RESP_DISBANDSHIPTEAM:int = 1327;
      
      public static const _MSG_REQUEST_LOADSHIPTEAM:int = 1328;
      
      public static const _MSG_RESP_LOADSHIPTEAM:int = 1329;
      
      public static const _MSG_REQUEST_LOADINFOSHIPTEAM:int = 1330;
      
      public static const _MSG_RESP_LOADINFOSHIPTEAM:int = 1331;
      
      public static const _MSG_REQUEST_UNLOADSHIPTEAM:int = 1332;
      
      public static const _MSG_RESP_UNLOADSHIPTEAM:int = 1333;
      
      public static const _MSG_REQUEST_UNITESHIPTEAM:int = 1334;
      
      public static const _MSG_RESP_UNITESHIPTEAM:int = 1335;
      
      public static const _MSG_RESP_GALAXYSHIP:int = 1336;
      
      public static const _MSG_RESP_CREATESHIPBROADCAST:int = 1337;
      
      public static const _MSG_REQUEST_DIRECTIONSHIPTEAM:int = 1338;
      
      public static const _MSG_RESP_DIRECTIONSHIPTEAM:int = 1339;
      
      public static const _MSG_SHIPTEAMHOLDGALAXY:int = 1340;
      
      public static const _MSG_RESP_DELSHIPTEAMBROADCAST:int = 1341;
      
      public static const _MSG_REQUEST_TARGETSHIPTEAM:int = 1342;
      
      public static const _MSG_RESP_TARGETSHIPTEAM:int = 1343;
      
      public static const _MSG_REQUEST_SPEEDSHIPBODYUPGRADE:int = 1344;
      
      public static const _MSG_RESP_SPEEDSHIPBODYUPGRADE:int = 1345;
      
      public static const _MSG_REQUEST_FROMRESOURCESTARTOHOME:int = 1346;
      
      public static const _MSG_RESP_FROMRESOURCESTARTOHOME:int = 1347;
      
      public static const _MSG_RESP_SHIPTEAMTRADE:int = 1348;
      
      public static const _MSG_REQUEST_SHIPTEAMTRADEGOODS:int = 1349;
      
      public static const _MSG_RESP_SHIPTEAMTRADEGOODS:int = 1350;
      
      public static const _MSG_REQUEST_LOADSHIPTEAMALL:int = 1351;
      
      public static const _MSG_RESP_LOADSHIPTEAMALL:int = 1352;
      
      public static const _MSG_RESP_SHIPTEAMTRADECOMPLETE:int = 1353;
      
      public static const _MSG_REQUEST_UNITESHIPTEAM_RES:int = 1354;
      
      public static const _MSG_REQUEST_SHIPBODYUPGRADE:int = 1355;
      
      public static const _MSG_RESP_SHIPBODYUPGRADE:int = 1356;
      
      public static const _MSG_REQUEST_JUMPGALAXYSHIP:int = 1357;
      
      public static const _MSG_RESP_JUMPGALAXYSHIP:int = 1358;
      
      public static const _MSG_REQUEST_GOTORESOURCESTAR:int = 1359;
      
      public static const _MSG_RESP_GOTORESOURCESTAR:int = 1360;
      
      public static const _MSG_REQUEST_SHIPTEAMGOHOME:int = 1361;
      
      public static const _MSG_REQUEST_BUYSHIPINFO:int = 1362;
      
      public static const _MSG_RESP_BUYSHIPINFO:int = 1363;
      
      public static const _MSG_REQUEST_DESTROYSHIP:int = 1364;
      
      public static const _MSG_RESP_DESTROYSHIP:int = 1365;
      
      public static const _MSG_REQUEST_SPEEDSHIP:int = 1366;
      
      public static const _MSG_RESP_SPEEDSHIP:int = 1367;
      
      public static const _MSG_REQUEST_SHIPBODYUPGRADEINFO:int = 1368;
      
      public static const _MSG_RESP_SHIPBODYUPGRADEINFO:int = 1369;
      
      public static const _MSG_RESP_SHIPBODYUPGRADECOMPLETE:int = 1370;
      
      public static const _MSG_REQUEST_SHIPTEAMINFO:int = 1371;
      
      public static const _MSG_RESP_SHIPTEAMINFO:int = 1372;
      
      public static const _MSG_REQUEST_CREATETEAMMODEL:int = 1373;
      
      public static const _MSG_RESP_TEAMMODELINFO:int = 1374;
      
      public static const _MSG_REQUEST_ADDSHIPMODELDEL:int = 1375;
      
      public static const _MSG_REQUEST_UNIONFLAGSHIP:int = 1376;
      
      public static const _MSG_RESP_UNIONFLAGSHIP:int = 1377;
      
      public static const _MSG_REQUEST_UPGRADEFLAGSHIP:int = 1378;
      
      public static const _MSG_RESP_UPGRADEFLAGSHIP:int = 1379;
      
      public static const _MSG_REQUEST_UNIONSHIPPROPS:int = 1380;
      
      public static const _MSG_RESP_UNIONSHIPPROPS:int = 1381;
      
      public static const _MSG_REQUEST_UPGRADESHIPPROPS:int = 1382;
      
      public static const _MSG_RESP_UPGRADESHIPPROPS:int = 1383;
      
      public static const _MSG_REQUEST_JUMPSHIPTEAM:int = 1400;
      
      public static const _MSG_RESP_JUMPSHIPTEAM:int = 1401;
      
      public static const _MSG_REQUEST_JUMPSHIPTEAMINFO:int = 1402;
      
      public static const _MSG_RESP_JUMPSHIPTEAMINFO:int = 1403;
      
      public static const _MSG_RESP_JUMPSHIPTEAMCOMPLETE:int = 1404;
      
      public static const _MSG_REQUEST_JUMPSHIPTEAMCHANGE:int = 1405;
      
      public static const _MSG_RESP_JUMPSHIPTEAMCHANGE:int = 1406;
      
      public static const _MSG_REQUEST_VIEWJUMPSHIPTEAM:int = 1407;
      
      public static const _MSG_RESP_VIEWJUMPSHIPTEAM:int = 1408;
      
      public static const _MSG_REQUEST_CREATEFIGHT:int = 1409;
      
      public static const _MSG_RESP_FIGHTSECTION:int = 1410;
      
      public static const _MSG_RESP_GALAXYFIGHTBEG:int = 1411;
      
      public static const _MSG_RESP_GALAXYFIGHTEND:int = 1412;
      
      public static const _MSG_RESP_FIGHTBOUTBEG:int = 1413;
      
      public static const _MSG_RESP_FIGHTBOUTEND:int = 1414;
      
      public static const _MSG_RESP_FIGHTRESULT:int = 1415;
      
      public static const _MSG_RESP_FIGHTINIT_SHIPTEAM:int = 1416;
      
      public static const _MSG_RESP_FIGHTINIT_BUILD:int = 1417;
      
      public static const _MSG_REQUEST_BRUISESHIPINFO:int = 1418;
      
      public static const _MSG_RESP_BRUISESHIPINFO:int = 1419;
      
      public static const _MSG_REQUEST_SPEEDBRUISESHIP:int = 1420;
      
      public static const _MSG_RESP_SPEEDBRUISESHIP:int = 1421;
      
      public static const _MSG_REQUEST_BRUISESHIPRELIVE:int = 1422;
      
      public static const _MSG_RESP_BRUISESHIPRELIVE:int = 1423;
      
      public static const _MSG_REQUEST_BRUISESHIPDELETE:int = 1424;
      
      public static const _MSG_RESP_BRUISESHIPDELETE:int = 1425;
      
      public static const _MSG_REQUEST_WARINVITE:int = 1426;
      
      public static const _MSG_RESP_WARINVITE:int = 1427;
      
      public static const _MSG_RESP_PKINVITE:int = 1428;
      
      public static const _MSG_REQUEST_WARSTATE:int = 1429;
      
      public static const _MSG_RESP_WARSTATE:int = 1430;
      
      public static const _MSG_REQUEST_WARACCEPT:int = 1431;
      
      public static const _MSG_RESP_WARACCEPT:int = 1432;
      
      public static const _MSG_RESP_WARRESULT:int = 1433;
      
      public static const _MSG_REQUEST_WARMSGSTOP:int = 1434;
      
      public static const _MSG_RESP_WARMSGSTOP:int = 1435;
      
      public static const _MSG_RESP_ECTYPEPASS:int = 1436;
      
      public static const _MSG_REQUEST_ECTYPEINFO:int = 1437;
      
      public static const _MSG_REQUEST_CANCELJUMPSHIPTEAM:int = 1438;
      
      public static const _MSG_RESP_CANCELJUMPSHIPTEAM:int = 1439;
      
      public static const _MSG_REQUEST_FLIGHTSHIPTEAM:int = 1440;
      
      public static const _MSG_RESP_FLIGHTSHIPTEAM:int = 1441;
      
      public static const _MSG_REQUEST_FLIGHTSHIPTEAMOVER:int = 1442;
      
      public static const _MSG_RESP_FLIGHTSHIPTEAMOVER:int = 1443;
      
      public static const _MSG_RESP_FIGHTFORTRESSSECTION:int = 1444;
      
      public static const _MSG_RESP_JUMPSHIPTEAMNOTICE:int = 1445;
      
      public static const _MSG_REQUEST_MATCHINFO:int = 1446;
      
      public static const _MSG_RESP_MATCHINFO:int = 1447;
      
      public static const _MSG_REQUEST_MATCHPAGE:int = 1448;
      
      public static const _MSG_RESP_MATCHPAGE:int = 1449;
      
      public static const CMS_YOUR:int = 0;
      
      public static const CMS_NORMALCOMMANDER:int = 1;
      
      public static const CMS_SPELLCOMMANDER:int = 2;
      
      public static const CMS_SEPCIALCOMMADNER:int = 3;
      
      public static const CMS_SUPERCOMMANDER:int = 4;
      
      public static const CMS_NORMALCREATE:int = 0;
      
      public static const CMS_SPECIALCREATE:int = 1;
      
      public static const CMS_SUPERCREATE:int = 2;
      
      public static const CMS_NORMAL:int = 0;
      
      public static const CMS_ILL:int = 1;
      
      public static const CMS_DEATH:int = 2;
      
      public static const CMS_FIGHT_ILLDEATH:int = 3;
      
      public static const _COMMANDER_TYPE_FREE:int = 1;
      
      public static const _COMMANDER_TYPE_ALL:int = 0;
      
      public static const _MSG_REQUEST_CREATECOMMANDER:int = 1500;
      
      public static const _MSG_RESP_CREATECOMMANDER:int = 1501;
      
      public static const _MSG_REQUEST_UPDATENAMECOMMANDER:int = 1502;
      
      public static const _MSG_RESP_UPDATENAMECOMMANDER:int = 1503;
      
      public static const _MSG_REQUEST_DELETECOMMANDER:int = 1504;
      
      public static const _MSG_RESP_DELETECOMMANDER:int = 1505;
      
      public static const _MSG_REQUEST_COMMANDERINFO:int = 1506;
      
      public static const _MSG_RESP_COMMANDERINFO:int = 1507;
      
      public static const _MSG_REQUEST_RELIVECOMMANDER:int = 1508;
      
      public static const _MSG_RESP_RELIVECOMMANDER:int = 1509;
      
      public static const _MSG_REQUEST_RESUMECOMMANDER:int = 1510;
      
      public static const _MSG_RESP_RESUMECOMMANDER:int = 1511;
      
      public static const _MSG_REQUEST_CLEARCOMMANDERPERCENT:int = 1512;
      
      public static const _MSG_RESP_CLEARCOMMANDERPERCENT:int = 1513;
      
      public static const _MSG_RESP_COMMANDERBASEINFO:int = 1514;
      
      public static const _MSG_REQUEST_COMMANDERINFOARRANGE:int = 1515;
      
      public static const _MSG_RESP_COMMANDERINFOARRANGE:int = 1516;
      
      public static const _MSG_REQUEST_COMMANDEREDITSHIPTEAM:int = 1517;
      
      public static const _MSG_RESP_COMMANDEREDITSHIPTEAM:int = 1518;
      
      public static const _MSG_RESP_COMMANDERCARD:int = 1519;
      
      public static const _MSG_REQUEST_GETSECONDCOMMANDERCARD:int = 1520;
      
      public static const _MSG_RESP_GETSECONDCOMMANDERCARD:int = 1521;
      
      public static const _MSG_REQUEST_UNIONCOMMANDERCARD:int = 1522;
      
      public static const _MSG_RESP_UNIONCOMMANDERCARD:int = 1523;
      
      public static const _MSG_REQUEST_COMMANDERCHANGECARD:int = 1524;
      
      public static const _MSG_RESP_COMMANDERCHANGECARD:int = 1525;
      
      public static const _MSG_RESP_UNIONCOMMANDERCARDBRO:int = 1526;
      
      public static const _MSG_RESP_REFRESHCOMMANDERBASEINFO:int = 1527;
      
      public static const _MSG_REQUEST_COMMANDERINSERTSTONE:int = 1528;
      
      public static const _MSG_RESP_COMMANDERINSERTSTONE:int = 1529;
      
      public static const _MSG_REQUEST_COMMANDERUNIONSTONE:int = 1530;
      
      public static const _MSG_RESP_COMMANDERUNIONSTONE:int = 1531;
      
      public static const _MSG_REQUEST_COMMANDERSTONEINFO:int = 1532;
      
      public static const _MSG_RESP_COMMANDERSTONEINFO:int = 1533;
      
      public static const _MSG_RESP_COMMANDERCARDBRO:int = 1534;
      
      public static const _MSG_REQUEST_UNIONDOUBLESKILLCARD:int = 1535;
      
      public static const _MSG_RESP_UNIONDOUBLESKILLCARD:int = 1536;
      
      public static const _MSG_REQUEST_UNBINDCOMMANDERCARD:int = 1537;
      
      public static const _MSG_RESP_UNBINDCOMMANDERCARD:int = 1538;
      
      public static const _MSG_REQUEST_COMMANDERINSERTCMOS:int = 1539;
      
      public static const _MSG_RESP_COMMANDERINSERTCMOS:int = 1540;
      
      public static const _MSG_REQUEST_COMMANDERPROPERTYSTONE:int = 1541;
      
      public static const _MSG_RESP_COMMANDERPROPERTYSTONE:int = 1542;
      
      public static const _MSG_REQUEST_CONSORTIAINFO:int = 1550;
      
      public static const _MSG_RESP_CONSORTIAINFO:int = 1551;
      
      public static const _MSG_REQUEST_CONSORTIAPROCLAIM:int = 1552;
      
      public static const _MSG_RESP_CONSORTIAPROCLAIM:int = 1553;
      
      public static const _MSG_REQUEST_CREATECONSORTIA:int = 1554;
      
      public static const _MSG_RESP_CREATECONSORTIA:int = 1555;
      
      public static const _MSG_REQUEST_CONSORTIAMYSELF:int = 1556;
      
      public static const _MSG_RESP_CONSORTIAMYSELF:int = 1557;
      
      public static const _MSG_REQUEST_CONSORTIAMEMBER:int = 1558;
      
      public static const _MSG_RESP_CONSORTIAMEMBER:int = 1559;
      
      public static const _MSG_REQUEST_EDITCONSORTIA:int = 1560;
      
      public static const _MSG_RESP_EDITCONSORTIA:int = 1561;
      
      public static const _MSG_REQUEST_CONSORTIATHROWVALUE:int = 1562;
      
      public static const _MSG_RESP_CONSORTIATHROWVALUE:int = 1563;
      
      public static const _MSG_REQUEST_CONSORTIADELMEMBER:int = 1564;
      
      public static const _MSG_RESP_CONSORTIADELMEMBER:int = 1565;
      
      public static const _MSG_REQUEST_JOINCONSORTIA:int = 1566;
      
      public static const _MSG_RESP_JOINCONSORTIA:int = 1567;
      
      public static const _MSG_RESP_OPERATECONSORTIABRO:int = 1568;
      
      public static const _MSG_RESP_CONSORTIADELMEMBERBRO:int = 1569;
      
      public static const _MSG_REQUEST_CONSORTIASETOFFICIAL:int = 1570;
      
      public static const _MSG_RESP_CONSORTIASETOFFICIAL:int = 1571;
      
      public static const _MSG_REQUEST_CONSORTIAGIVEN:int = 1572;
      
      public static const _MSG_RESP_CONSORTIAGIVEN:int = 1573;
      
      public static const _MSG_REQUEST_CONSORTIAAUTHUSER:int = 1574;
      
      public static const _MSG_RESP_CONSORTIAAUTHUSER:int = 1575;
      
      public static const _MSG_REQUEST_DEALCONSORTIAAUTHUSER:int = 1576;
      
      public static const _MSG_RESP_CONSORTIASTAR:int = 1577;
      
      public static const _MSG_REQUEST_CONSORTIATHROWRANK:int = 1578;
      
      public static const _MSG_RESP_CONSORTIATHROWRANK:int = 1579;
      
      public static const _MSG_REQUEST_CONSORTIAFIELD:int = 1580;
      
      public static const _MSG_RESP_CONSORTIAFIELD:int = 1581;
      
      public static const _MSG_RESP_CONSORTIAWEALTH:int = 1582;
      
      public static const _MSG_REQUEST_CONSORTIAUPGRADE:int = 1583;
      
      public static const _MSG_RESP_CONSORTIAUPGRADE:int = 1584;
      
      public static const _MSG_REQUEST_CONSORTIARANK:int = 1585;
      
      public static const _MSG_RESP_CONSORTIARANK:int = 1586;
      
      public static const _MSG_RESP_DEALCONSORTIAAUTHUSER:int = 1587;
      
      public static const _MSG_REQUEST_CONSORTIAATTACKINFO:int = 1588;
      
      public static const _MSG_RESP_CONSORTIAATTACKINFO:int = 1589;
      
      public static const _MSG_REQUEST_CONSORTIAUPDATEJOBNAME:int = 1590;
      
      public static const _MSG_REQUEST_CONSORTIAUPDATAVALUE:int = 1591;
      
      public static const _MSG_RESP_CONSORTIAUPDATAVALUE:int = 1592;
      
      public static const _MSG_REQUEST_CONSORTIABUYGOODS:int = 1593;
      
      public static const _MSG_RESP_CONSORTIABUYGOODS:int = 1594;
      
      public static const _MSG_RESP_CONSORTIAUPGRADECOMPLETE:int = 1595;
      
      public static const _MSG_REQUEST_CONSORTIAUPGRADECANCEL:int = 1596;
      
      public static const _MSG_RESP_CONSORTIAUPGRADECANCEL:int = 1597;
      
      public static const _MSG_REQUEST_CONSORTIAEVENT:int = 1598;
      
      public static const _MSG_RESP_CONSORTIAEVENT:int = 1599;
      
      public static const _MSG_CHAT_MESSAGE:int = 1600;
      
      public static const _MSG_REQUEST_ADDFRIEND:int = 1601;
      
      public static const _MSG_RESP_ADDFRIEND:int = 1602;
      
      public static const _MSG_REQUEST_DELFRIEND:int = 1603;
      
      public static const _MSG_RESP_DELFRIEND:int = 1604;
      
      public static const _MSG_REQUEST_FRIENDLIST:int = 1605;
      
      public static const _MSG_RESP_FRIENDLIST:int = 1606;
      
      public static const _MSG_REQUEST_SENDEMAIL:int = 1607;
      
      public static const _MSG_REQUEST_EMAILINFO:int = 1608;
      
      public static const _MSG_RESP_EMAILINFO:int = 1609;
      
      public static const _MSG_REQUEST_DELETEEMAIL:int = 1610;
      
      public static const _MSG_REQUEST_READEMAIL:int = 1611;
      
      public static const _MSG_RESP_READEMAIL:int = 1612;
      
      public static const _MSG_REQUEST_EMAILGOODS:int = 1613;
      
      public static const _MSG_RESP_EMAILGOODS:int = 1614;
      
      public static const _MSG_REQUEST_FRIENDINFO:int = 1615;
      
      public static const _MSG_RESP_FRIENDINFO:int = 1616;
      
      public static const _MSG_REQUEST_FRIENDLEVEL:int = 1617;
      
      public static const _MSG_RESP_FRIENDLEVEL:int = 1618;
      
      public static const _MSG_RESP_ADDFRIENDAUTH:int = 1619;
      
      public static const _MSG_REQUEST_FRIENDPASSAUTH:int = 1620;
      
      public static const _MSG_RESP_FRIENDPASSAUTH:int = 1621;
      
      public static const _MSG_RESP_NEWEMAILNOTICE:int = 1622;
      
      public static const _MSG_REQUEST_USERINFO:int = 1623;
      
      public static const _MSG_RESP_USERINFO:int = 1624;
      
      public static const _MSG_REQUEST_LOOKUPUSERINFO:int = 1625;
      
      public static const _MSG_RESP_LOOKUPUSERINFO:int = 1626;
      
      public static const _MSG_REQUEST_INSERTFLAGCONSORTIAIMEMBER:int = 1650;
      
      public static const _MSG_RESP_INSERTFLAGCONSORTIAIMEMBER:int = 1651;
      
      public static const _MSG_REQUEST_CONSORTIAPIRATE:int = 1652;
      
      public static const _MSG_RESP_CONSORTIAPIRATE:int = 1653;
      
      public static const _MSG_REQUEST_CONSORTIAPIRATECHOOSE:int = 1654;
      
      public static const _MSG_RESP_CONSORTIAPIRATECHOOSE:int = 1655;
      
      public static const _MSG_RESP_CONSORTIAPIRATEBRO:int = 1656;
      
      public static const _MSG_REQUEST_CONSORTIAINFO2:int = 1657;
      
      public static const _MSG_REQUEST_RANKCENT:int = 1700;
      
      public static const _MSG_RESP_RANKCENT:int = 1701;
      
      public static const _MSG_REQUEST_RANKKILLTOTAL:int = 1702;
      
      public static const _MSG_RESP_RANKKILLTOTAL:int = 1703;
      
      public static const _MSG_REQUEST_RANKFIGHT:int = 1704;
      
      public static const _MSG_RESP_RANKFIGHT:int = 1705;
      
      public static const _MSG_REQUEST_RANKMATCH:int = 1706;
      
      public static const _MSG_RESP_RANKMATCH:int = 1707;
      
      public static const _MSG_REQUEST_TRADEGOODS:int = 1750;
      
      public static const _MSG_RESP_TRADEGOODS:int = 1751;
      
      public static const _MSG_REQUEST_MYTRADEINFO:int = 1752;
      
      public static const _MSG_RESP_MYTRADEINFO:int = 1753;
      
      public static const _MSG_REQUEST_DELETETRADEGOODS:int = 1754;
      
      public static const _MSG_RESP_DELETETRADEGOODS:int = 1755;
      
      public static const _MSG_REQUEST_TRADEINFO:int = 1756;
      
      public static const _MSG_RESP_TRADEINFO:int = 1757;
      
      public static const _MSG_REQUEST_BUYTRADEGOODS:int = 1758;
      
      public static const _MSG_RESP_BUYTRADEGOODS:int = 1759;
      
      public static const _MSG_REQUEST_FIELDRESOURCE:int = 1800;
      
      public static const _MSG_RESP_FIELDRESOURCE:int = 1801;
      
      public static const _MSG_REQUEST_GROWFIELDRESOURCE:int = 1802;
      
      public static const _MSG_RESP_GROWFIELDRESOURCE:int = 1803;
      
      public static const _MSG_REQUEST_GETFIELDRESOURCE:int = 1804;
      
      public static const _MSG_RESP_GETFIELDRESOURCE:int = 1805;
      
      public static const _MSG_REQUEST_THIEVEFIELDRESOURCE:int = 1806;
      
      public static const _MSG_RESP_THIEVEFIELDRESOURCE:int = 1807;
      
      public static const _MSG_REQUEST_DELETEFIELDRESOURCE:int = 1808;
      
      public static const _MSG_RESP_DELETEFIELDRESOURCE:int = 1809;
      
      public static const _MSG_REQUEST_FIELDRESOURCELOG:int = 1810;
      
      public static const _MSG_RESP_FIELDRESOURCELOG:int = 1811;
      
      public static const _MSG_REQUEST_HELPFIELDCENTERRESOURCE:int = 1812;
      
      public static const _MSG_RESP_HELPFIELDCENTERRESOURCE:int = 1813;
      
      public static const _MSG_REQUEST_FRIENDFIELDSTATUS:int = 1814;
      
      public static const _MSG_RESP_FRIENDFIELDSTATUS:int = 1815;
      
      public static const _MSG_REQUEST_GAINCMOSLOTTERY:int = 1900;
      
      public static const _MSG_RESP_GAINCMOSLOTTERY:int = 1901;
      
      public static const _MSG_REQUEST_CMOSLOTTERYINFO:int = 1902;
      
      public static const _MSG_RESP_CMOSLOTTERYINFO:int = 1903;
      
      public static const _MSG_REQUEST_UNIONCMOS:int = 1904;
      
      public static const _MSG_RESP_UNIONCMOS:int = 1905;
      
      public static const _MSG_REQUEST_OPENCMOSPACK:int = 1906;
      
      public static const _MSG_RESP_OPENCMOSPACK:int = 1907;
      
      public static const _MSG_REQUEST_SELLPROPS:int = 1908;
      
      public static const _MSG_RESP_SELLPROPS:int = 1909;
      
      public static const _MSG_RESP_PAYMENTSUCCEED:int = 1910;
      
      public static const _MSG_RESP_PASS_TOLLGATE:int = 1136;
      
      public static const MAX_CMOSCOUNT:int = 30;
      
      public static const MAX_COMMANDERCMOS:int = 5;
      
      public static const _MSG_REQUEST_ARENA_STATUS:int = 1450;
      
      public static const _MSG_RESP_ARENA_STATUS:int = 1451;
      
      public static const _MSG_REQUEST_ARENA_PAGE:int = 1452;
      
      public static const _MSG_RESP_ARENA_PAGE:int = 1453;
      
      public static const _MSG_RESP_CAPTURE_ARK_INFO:int = 1454;
      
      public static const _MSG_RESP_CAPTURE_ARK_LIST:int = 1455;
      
      public static const _MSG_RESP_CAPTURE_ARK_ROOM:int = 1456;
      
      public static const _MSG_REQUEST_CAPTURE_STATE:int = 1457;
      
      public static const _MSG_RESP_DUPLICATE_BATTLE:int = 1458;
      
      public static const _MSG_RESP_CAPTURE_BULLETIN:int = 1459;
      
      public static const _MSG_REQUEST_WARFIELD_STATUS:int = 1460;
      
      public static const _MSG_RESP_WARFIELD_STATUS:int = 1461;
      
      public static const _MSG_RESP_DUPLICATE_BULLETIN:int = 1462;
      
      public static const _MSG_RESP_WARFIELD_PAGE:int = 1463;
      
      public static const _MSG_RESP_WARFIELD_PLAYERLIST:int = 1464;
      
      public static const _MSG_DUPLICATE_STATUS:int = 1465;
      
      public static const _MSG_REQUEST_RACINGINFO:int = 1850;
      
      public static const _MSG_RESP_RACINGINFO:int = 1851;
      
      public static const _MSG_REQUEST_RACINGBATTLE:int = 1852;
      
      public static const _MSG_RESP_RACINGBATTLE:int = 1853;
      
      public static const _MSG_REQUEST_RACINGAWARD:int = 1854;
      
      public static const _MSG_RESP_RACINGAWARD:int = 1855;
      
      public static const _MSG_REQUEST_JOINRACING:int = 1856;
      
      public static const _MSG_REQUEST_RACINGCREATEROLE:int = 1857;
      
      public static const _MSG_REQUEST_RACINGBATTLEEND:int = 1858;
      
      public static const _MSG_REQUEST_RACINGBATTLEDATA:int = 1859;
      
      public static const _MSG_REQUEST_SETRACINGSHIPTEAM:int = 1860;
      
      public static const _MSG_RESP_SETRACINGSHIPTEAM:int = 1861;
      
      public static const _MSG_RESP_RACINGSHIPMODEL:int = 1862;
      
      public static const _MSG_RESP_RACINGCOMMANDER:int = 1863;
      
      public static const _MSG_RESP_RACINGSHIPTEAM:int = 1864;
      
      public static const _MSG_RESP_RACINGINFOSHIPTEAM:int = 1865;
      
      public static const _MSG_RESP_RACINGTECH:int = 1866;
      
      public static const _MSG_REQUEST_RACINGRANK:int = 1867;
      
      public static const _MSG_RESP_RACINGRANK:int = 1868;
      
      public static const MAX_RACINGENEMYNUM:int = 9;
      
      public static const MAX_RACINGREPORTNUM:int = 5;
      
      public static const MAX_RACINGSHIPTEAMNUM:int = 12;
      
      public function MsgTypes()
      {
         super();
      }
      
      public static function Instance() : MsgTypes
      {
         if(_instance == null)
         {
            _instance = new MsgTypes();
         }
         return _instance;
      }
   }
}

