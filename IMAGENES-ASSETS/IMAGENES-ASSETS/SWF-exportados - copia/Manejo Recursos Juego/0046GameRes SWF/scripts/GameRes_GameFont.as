package
{
   import mx.core.FontAsset;
   
   [Embed(source="/_assets/2_GameRes_GameFont.cff",
   fontName="DefaultFont",
   mimeType="application/x-font",
   fontWeight="bold",
   fontStyle="normal",
   embedAsCFF="true"
   )]
   public class GameRes_GameFont extends FontAsset
   {
      
      public function GameRes_GameFont()
      {
         super();
      }
   }
}

