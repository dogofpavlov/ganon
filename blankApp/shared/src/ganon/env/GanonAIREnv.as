package ganon.env
{
	import flash.display.Sprite;
	import flash.filesystem.File;
	
	import starling.utils.AssetManager;

	public class GanonAIREnv extends GanonEnv
	{
		public function GanonAIREnv($root:Sprite, $config:GanonEnvConfig)
		{
			super($root,$config);
		}
		
		override public function addAssets($manager:AssetManager):void{
			super.addAssets($manager);
			$manager.enqueue(File.applicationDirectory.resolvePath("assets"));
		}
	}
}