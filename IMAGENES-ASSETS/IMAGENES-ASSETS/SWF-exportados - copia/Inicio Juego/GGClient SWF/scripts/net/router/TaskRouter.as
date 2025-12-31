package net.router
{
   import flash.utils.ByteArray;
   import logic.ui.TaskSceneUI;
   import net.base.NetManager;
   import net.msg.task.MSG_RESP_GAINDAILYAWARD;
   import net.msg.task.MSG_RESP_TASKGAIN;
   import net.msg.task.MSG_RESP_TASKINFO;
   
   public class TaskRouter
   {
      
      private static var _instance:TaskRouter;
      
      public function TaskRouter()
      {
         super();
      }
      
      public static function get instance() : TaskRouter
      {
         if(_instance == null)
         {
            _instance = new TaskRouter();
         }
         return _instance;
      }
      
      public function resp_MSG_RESP_TASKINFO(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_TASKINFO = new MSG_RESP_TASKINFO();
         NetManager.Instance().readObject(_loc4_,param3);
         TaskSceneUI.getInstance().RespTaskList(_loc4_);
      }
      
      public function resp_MSG_RESP_TASKGAIN(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_TASKGAIN = new MSG_RESP_TASKGAIN();
         NetManager.Instance().readObject(_loc4_,param3);
         TaskSceneUI.getInstance().RespTaskGain(_loc4_);
      }
      
      public function resp_MSG_RESP_GAINDAILYAWARD(param1:int, param2:int, param3:ByteArray) : void
      {
         var _loc4_:MSG_RESP_GAINDAILYAWARD = new MSG_RESP_GAINDAILYAWARD();
         NetManager.Instance().readObject(_loc4_,param3);
         TaskSceneUI.getInstance().RespAward(_loc4_);
      }
   }
}

