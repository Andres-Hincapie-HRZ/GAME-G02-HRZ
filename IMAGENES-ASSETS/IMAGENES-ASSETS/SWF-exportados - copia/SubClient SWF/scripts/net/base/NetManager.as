package net.base
{
   import flash.events.*;
   import flash.net.Socket;
   import flash.system.Security;
   import flash.utils.ByteArray;
   import flash.utils.Timer;
   import logic.entry.GamePlayer;
   import logic.game.GameKernel;
   import net.msg.MSG_GAME_CLIENTACTIVE;
   
   public class NetManager extends EventDispatcher
   {
      
      private static var socket:Socket;
      
      private static var netManager:NetManager = null;
      
      private var ReceiveBuf:ByteArray;
      
      private var msgsocket:MsgSocket = null;
      
      private var netrouter:NetRouter = null;
      
      private var _keycode:int = 0;
      
      private var m_userId:Number;
      
      private var m_host:String;
      
      private var m_port:int = 5050;
      
      private var m_retime:int = 15;
      
      private var m_LoginHost:String;
      
      private var m_LoginPort:int = 5050;
      
      private var m_GameHost:String;
      
      private var m_GamePort:int;
      
      private var ActiveTimer:Timer;
      
      private var ActiveMsg:MSG_GAME_CLIENTACTIVE;
      
      protected var _timer:Timer;
      
      private var IpList:Array;
      
      private var LoginServerPortList:Array;
      
      private var LoginServerIpList:Array;
      
      private var LoginServerIpId:int;
      
      public function NetManager()
      {
         super();
         this.ReceiveBuf = new ByteArray();
         this.CreateSocket();
         this.msgsocket = MsgSocket.Instance();
         this.netrouter = NetRouter.Instance();
         this.ActiveMsg = new MSG_GAME_CLIENTACTIVE();
         this.ActiveTimer = new Timer(60000);
         this.ActiveTimer.addEventListener(TimerEvent.TIMER,this.OnActiveTimer);
      }
      
      public static function Instance() : NetManager
      {
         if(netManager == null)
         {
            netManager = new NetManager();
         }
         return netManager;
      }
      
      public static function get socketConnected() : Boolean
      {
         return socket.connected;
      }
      
      private function CreateSocket() : void
      {
         socket = new Socket();
         socket.timeout = 5000;
         socket.addEventListener(Event.CONNECT,this.NetConnectEvent);
         socket.addEventListener(ProgressEvent.SOCKET_DATA,this.NetReceiveEvent);
         socket.addEventListener(IOErrorEvent.IO_ERROR,this.NetioErrorEvent);
         socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.NetsecurityErrorEvent);
         socket.addEventListener(Event.CLOSE,this.NetCloseEvent);
      }
      
      public function SendMsg(param1:ByteArray, param2:int) : void
      {
         socket.writeBytes(param1,0,param2);
         socket.flush();
      }
      
      public function NetsecurityErrorEvent(param1:SecurityErrorEvent) : void
      {
         GameKernel.getInstance().ConnectErrorCode = 2048;
         this.stopCount();
         this.starCount(1);
      }
      
      public function NetioErrorEvent(param1:IOErrorEvent) : void
      {
         GameKernel.getInstance().ConnectErrorCode = 2044;
         this.netrouter.netErrorEvent(param1);
      }
      
      public function NetCloseEvent(param1:Event) : void
      {
         GameKernel.getInstance().ConnectErrorCode = 1003;
         this.netrouter.netDisconnectEvent(param1);
      }
      
      public function NetConnectEvent(param1:Event) : void
      {
         this.ReceiveBuf.clear();
         this.netrouter.netConnectEvent(param1);
      }
      
      public function OnCrossdomain(param1:String, param2:int = 843) : void
      {
         if(param2 != 843)
         {
            Security.loadPolicyFile("xmlsocket://" + param1 + ":" + param2);
         }
      }
      
      public function OnLogin(param1:Number, param2:String = "1", param3:int = 0, param4:int = 1) : void
      {
         if(socket.connected)
         {
            socket.close();
         }
         var _loc5_:Object = this.GetLoginServerIp();
         this.m_LoginHost = _loc5_.Ip;
         this.m_LoginPort = _loc5_.Port;
         if(Boolean(this.m_LoginHost) && Boolean(this.m_LoginPort))
         {
            NetRouter.ConnLoginServer = false;
            this.m_userId = param1;
            this.m_host = this.m_LoginHost;
            this.m_port = this.m_LoginPort;
            GameKernel.getInstance().isLogin = true;
            ++GameKernel.getInstance().ConnectLoginServerNum;
            GameKernel.getInstance().isGameServer = false;
            GameKernel.getInstance().isInit = false;
            this.netrouter.userId = param1;
            this.netrouter.sessionKey = param2;
            this.netrouter.version = param3;
            this.netrouter.gameserverid = param4;
            socket.connect(this.m_host,this.m_port);
            this.starCount(this.m_retime);
         }
      }
      
      public function starCount(param1:int) : void
      {
         if(this._timer == null)
         {
            this._timer = new Timer(1000,param1);
            this._timer.addEventListener(TimerEvent.TIMER,this.onCount);
            this._timer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onCountComplete);
         }
         if(!this._timer.running)
         {
            this._timer.start();
         }
      }
      
      public function stopCount() : void
      {
         if(this._timer == null)
         {
            return;
         }
         this._timer.stop();
         this._timer.removeEventListener(TimerEvent.TIMER,this.onCount);
         this._timer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onCountComplete);
         this._timer.reset();
         this._timer = null;
      }
      
      protected function onCount(param1:TimerEvent) : void
      {
      }
      
      protected function onCountComplete(param1:TimerEvent) : void
      {
         this.netrouter.StopReconnectTimer();
         this.stopCount();
         this.OnLogin(this.m_userId,GamePlayer.getInstance().sessionKey);
      }
      
      public function ConnectLoginServer() : void
      {
         var _loc1_:Object = this.GetLoginServerIp();
         this.m_host = _loc1_.Ip;
         this.m_port = _loc1_.Port;
         if(Boolean(this.m_host) && Boolean(this.m_port))
         {
            socket.connect(this.m_host,this.m_port);
         }
      }
      
      public function ConnectGameServer() : void
      {
         this.m_host = this.m_GameHost;
         this.m_port = this.m_GamePort;
         this.reConnect();
         this.starCount(this.m_retime);
      }
      
      public function DisConnect() : void
      {
         if(socket.connected)
         {
            socket.close();
         }
      }
      
      public function reConnect() : void
      {
         if(socket.connected)
         {
            socket.close();
         }
         if(Boolean(this.m_host) && Boolean(this.m_port))
         {
            socket.connect(this.m_host,this.m_port);
         }
      }
      
      private function NetReceiveEvent(param1:ProgressEvent) : void
      {
         var _loc5_:int = 0;
         var _loc2_:NetEvent = new NetEvent(NetEvent.SOCKET_DATA);
         if(socket.bytesAvailable <= 0)
         {
            return;
         }
         var _loc3_:ByteArray = new ByteArray();
         socket.readBytes(_loc3_,0,socket.bytesAvailable);
         this.ReceiveBuf.position = this.ReceiveBuf.length;
         this.ReceiveBuf.writeBytes(_loc3_,0,_loc3_.length);
         this.ReceiveBuf.position = 0;
         var _loc4_:int = this.msgsocket.readMsgSize(this.ReceiveBuf);
         if(_loc4_ > 4096)
         {
            if(this.ReceiveBuf.length <= 91)
            {
               this.ReceiveBuf.clear();
               return;
            }
            _loc3_.clear();
            _loc3_.readBytes(this.ReceiveBuf,91,this.ReceiveBuf.length - 91);
            this.ReceiveBuf.clear();
            this.ReceiveBuf.readBytes(_loc3_,0,_loc3_.length);
            _loc4_ = this.msgsocket.readMsgSize(this.ReceiveBuf);
         }
         while(_loc4_ > 0 && this.ReceiveBuf.length >= _loc4_)
         {
            if(_loc4_ > 1024 * 64)
            {
               this.ReceiveBuf.length = 0;
               break;
            }
            _loc3_.length = 0;
            this.ReceiveBuf.position = 0;
            this.ReceiveBuf.readBytes(_loc3_,0,_loc4_);
            if(this.KeyCode > 0)
            {
               _loc3_.position = 0;
               this.msgsocket.readMsgSize(_loc3_);
               _loc5_ = this.msgsocket.readMsgType(_loc3_);
               this.msgsocket.DecodeMsgBuf(_loc3_,this.KeyCode + _loc5_,_loc4_);
               _loc3_.position = 0;
            }
            this.netrouter.msgRouter(_loc3_);
            _loc3_.length = 0;
            if(this.ReceiveBuf.length > _loc4_)
            {
               this.ReceiveBuf.readBytes(_loc3_,0,this.ReceiveBuf.length - _loc4_);
               this.ReceiveBuf.length = 0;
               this.ReceiveBuf.writeBytes(_loc3_,0,_loc3_.bytesAvailable);
               _loc3_.length = 0;
            }
            else
            {
               this.ReceiveBuf.length = 0;
            }
            this.ReceiveBuf.position = 0;
            _loc4_ = this.msgsocket.readMsgSize(this.ReceiveBuf);
         }
         _loc3_ = null;
         dispatchEvent(_loc2_);
      }
      
      public function readData(param1:Object, param2:ByteArray) : int
      {
         if(!param1 || !param2)
         {
            return 0;
         }
         return this.msgsocket.readData(param1,param2);
      }
      
      public function set KeyCode(param1:int) : void
      {
         this._keycode = param1;
      }
      
      public function get KeyCode() : int
      {
         return this._keycode;
      }
      
      public function sendData(param1:Object) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(!socket.connected)
         {
            return;
         }
         if(!param1)
         {
            return;
         }
         var _loc2_:ByteArray = new ByteArray();
         this.msgsocket.sendData(param1,_loc2_);
         if(this.KeyCode > 0)
         {
            _loc2_.position = 0;
            _loc3_ = this.msgsocket.readMsgSize(_loc2_);
            _loc4_ = this.msgsocket.readMsgType(_loc2_);
            this.msgsocket.EncodeMsgBuf(_loc2_,this.KeyCode + _loc4_,_loc3_);
         }
         this.SendMsg(_loc2_,_loc2_.length);
         _loc2_ = null;
      }
      
      public function set host(param1:String) : void
      {
         this.m_host = param1;
      }
      
      public function set port(param1:int) : void
      {
         this.m_port = param1;
      }
      
      public function get host() : String
      {
         return this.m_host;
      }
      
      public function get port() : int
      {
         return this.m_port;
      }
      
      private function RestLoginServerIpList() : void
      {
         var _loc1_:int = 0;
         var _loc2_:String = null;
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         var _loc5_:Object = null;
         if(this.IpList != null && this.LoginServerPortList != null)
         {
            this.LoginServerIpList = new Array();
            _loc1_ = 0;
            while(_loc1_ < this.IpList.length)
            {
               _loc2_ = this.LoginServerPortList[_loc1_];
               _loc3_ = _loc2_.split(",");
               _loc4_ = 0;
               while(_loc4_ < _loc3_.length)
               {
                  _loc5_ = new Object();
                  _loc5_.Ip = this.IpList[_loc1_];
                  _loc5_.Port = _loc3_[_loc4_];
                  this.LoginServerIpList.push(_loc5_);
                  _loc4_++;
               }
               _loc1_++;
            }
            this.LoginServerIpId = int(Math.random() * 100);
            this.LoginServerIpId %= this.LoginServerIpList.length;
         }
      }
      
      public function set loginServerHost(param1:String) : void
      {
         if(param1 == null)
         {
            return;
         }
         this.IpList = param1.split(";");
         this.RestLoginServerIpList();
      }
      
      public function set loginServerPort(param1:String) : void
      {
         if(param1 == null)
         {
            return;
         }
         this.LoginServerPortList = param1.split(";");
         this.RestLoginServerIpList();
      }
      
      public function GetLoginServerIp() : Object
      {
         if(this.LoginServerIpList == null)
         {
            return null;
         }
         if(this.LoginServerIpId >= this.LoginServerIpList.length)
         {
            this.LoginServerIpId = 0;
         }
         var _loc1_:Object = this.LoginServerIpList[this.LoginServerIpId];
         ++this.LoginServerIpId;
         return _loc1_;
      }
      
      public function set gameServerHost(param1:String) : void
      {
         this.m_GameHost = param1;
      }
      
      public function set gameServerPort(param1:int) : void
      {
         this.m_GamePort = param1;
      }
      
      public function get gameServerHost() : String
      {
         return this.m_GameHost;
      }
      
      public function get gameServerPort() : int
      {
         return this.m_GamePort;
      }
      
      public function sendObject(param1:Object) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(!socket.connected)
         {
            return;
         }
         if(!param1)
         {
            return;
         }
         var _loc2_:ByteArray = new ByteArray();
         param1.writeBuf(_loc2_);
         if(this.KeyCode > 0)
         {
            _loc2_.position = 0;
            _loc3_ = this.msgsocket.readMsgSize(_loc2_);
            _loc4_ = this.msgsocket.readMsgType(_loc2_);
            this.msgsocket.EncodeMsgBuf(_loc2_,this.KeyCode + _loc4_,_loc3_);
         }
         this.SendMsg(_loc2_,_loc2_.length);
         _loc2_ = null;
      }
      
      public function readObject(param1:Object, param2:ByteArray) : Boolean
      {
         if(!param1 || !param2)
         {
            return false;
         }
         param1.readBuf(param2);
         return true;
      }
      
      public function StartSendActiveMsg() : void
      {
         if(this.ActiveTimer.running)
         {
            this.ActiveTimer.stop();
         }
         this.ActiveTimer.start();
      }
      
      private function StopSendActiveMsg() : void
      {
         if(this.ActiveTimer.running)
         {
            this.ActiveTimer.stop();
         }
      }
      
      private function OnActiveTimer(param1:TimerEvent) : void
      {
         if(GameKernel.getInstance().isInit)
         {
            this.ActiveMsg.SeqId = GamePlayer.getInstance().seqID++;
            this.ActiveMsg.Guid = GamePlayer.getInstance().Guid;
            this.sendObject(this.ActiveMsg);
         }
      }
   }
}

