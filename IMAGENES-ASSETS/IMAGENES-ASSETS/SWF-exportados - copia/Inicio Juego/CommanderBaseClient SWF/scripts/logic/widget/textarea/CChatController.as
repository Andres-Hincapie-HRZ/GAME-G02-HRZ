package logic.widget.textarea
{
   import com.star.frameworks.geom.RectangleKit;
   import flash.display.DisplayObject;
   import gs.TweenLite;
   import gs.easing.Elastic;
   import logic.game.GameKernel;
   import logic.ui.ChatUI;
   import logic.widget.TaskNotifyWidget;
   
   public class CChatController
   {
      
      private static var instance:CChatController;
      
      public static const DIRECTION_EXPAND:int = 0;
      
      public static const DIRECTION_UNEXPAND:int = 1;
      
      private static const WIDTH:int = 364;
      
      private static const MIN_HEIGHT:int = 100;
      
      private static const NORMAL_HEIGHT:int = 250;
      
      private static const MAX_HEIGHT:int = 400;
      
      public static const DIFF:int = 150;
      
      public static var Direction:int = 0;
      
      public static var State:int = 0;
      
      public var firstY:int;
      
      public function CChatController()
      {
         super();
         this.firstY = ChatUI.getInstance().TextArea.y;
      }
      
      public static function getInstance() : CChatController
      {
         if(instance == null)
         {
            instance = new CChatController();
         }
         return instance;
      }
      
      public function changeChatContent(param1:int, param2:int) : void
      {
         var _loc3_:CTextArea = ChatUI.getInstance().TextArea;
         CChatController.State = param1;
         CChatController.Direction = Direction;
         switch(param1)
         {
            case 0:
               ChatUI.getInstance().TextArea.rePaint(new RectangleKit(0,0,CChatController.WIDTH,CChatController.MIN_HEIGHT));
               if(!GameKernel.isFullStage)
               {
                  _loc3_.setLocationXY(0 + GameKernel.fullRect.x,this.firstY);
                  break;
               }
               ChatUI.getInstance().TextArea.setLocationXY(0 + GameKernel.fullRect.x,GameKernel.fullRect.height - ChatUI.chatUIHeight);
               break;
            case 1:
               ChatUI.getInstance().TextArea.rePaint(new RectangleKit(0,0,CChatController.WIDTH,CChatController.NORMAL_HEIGHT));
               if(!GameKernel.isFullStage)
               {
                  if(param2 == CChatController.DIRECTION_EXPAND)
                  {
                     _loc3_.setLocationXY(0 + GameKernel.fullRect.x,_loc3_.y - CChatController.DIFF);
                     break;
                  }
                  _loc3_.setLocationXY(0 + GameKernel.fullRect.x,_loc3_.y + CChatController.DIFF);
                  break;
               }
               if(param2 == CChatController.DIRECTION_EXPAND)
               {
                  _loc3_.setLocationXY(0 + GameKernel.fullRect.x,_loc3_.y - CChatController.DIFF);
                  break;
               }
               _loc3_.setLocationXY(0 + GameKernel.fullRect.x,_loc3_.y + CChatController.DIFF);
               break;
            case 2:
               ChatUI.getInstance().TextArea.rePaint(new RectangleKit(0,0,CChatController.WIDTH,CChatController.MAX_HEIGHT));
               if(!GameKernel.isFullStage)
               {
                  ChatUI.getInstance().TextArea.setLocationXY(0 + GameKernel.fullRect.x,_loc3_.y - CChatController.DIFF);
                  break;
               }
               ChatUI.getInstance().TextArea.setLocationXY(0 + GameKernel.fullRect.x,_loc3_.y - CChatController.DIFF);
         }
         if(TaskNotifyWidget.GetInstance().IsShow())
         {
            TaskNotifyWidget.GetInstance().SetLocation(TaskNotifyWidget.GetInstance().GetXY().x,ChatUI.getInstance().TextArea.y - ChatUI.getInstance().TF_Channel.height - 50);
         }
      }
      
      public function setChatContentFullScreen(param1:Boolean) : void
      {
         var _loc2_:DisplayObject = GameKernel.gameLayout.getInstallUI("ChatScene");
         if(param1)
         {
            switch(ChatUI.getInstance().getChatInputBar().ChatState)
            {
               case 0:
                  TweenLite.to(_loc2_,0.5,{
                     "x":GameKernel.fullRect.x,
                     "y":GameKernel.fullRect.height - ChatUI.chatUIHeight,
                     "ease":Elastic.easeOut
                  });
                  break;
               case 1:
                  TweenLite.to(_loc2_,0.5,{
                     "x":GameKernel.fullRect.x,
                     "y":GameKernel.fullRect.height - ChatUI.chatUIHeight - CChatController.DIFF,
                     "ease":Elastic.easeOut
                  });
                  break;
               case 2:
                  TweenLite.to(_loc2_,0.5,{
                     "x":GameKernel.fullRect.x,
                     "y":GameKernel.fullRect.height - ChatUI.chatUIHeight - 2 * CChatController.DIFF,
                     "ease":Elastic.easeOut
                  });
            }
         }
         else
         {
            switch(ChatUI.getInstance().getChatInputBar().ChatState)
            {
               case 0:
                  TweenLite.to(_loc2_,0.5,{
                     "x":0,
                     "y":this.firstY,
                     "ease":Elastic.easeOut
                  });
                  break;
               case 1:
                  TweenLite.to(_loc2_,0.5,{
                     "x":0,
                     "y":this.firstY - CChatController.DIFF,
                     "ease":Elastic.easeOut
                  });
                  break;
               case 2:
                  TweenLite.to(_loc2_,0.5,{
                     "x":0,
                     "y":this.firstY - 2 * CChatController.DIFF,
                     "ease":Elastic.easeOut
                  });
            }
         }
      }
   }
}

