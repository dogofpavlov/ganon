package ganon.assets
{
	import flash.utils.Dictionary;
	
	import ganon.core.Ganon;
	import ganon.env.IGanonEnv;
	import ganon.fonts.GanonFontManager;
	
	import starling.textures.Texture;
	import starling.utils.AssetManager;

	public class GanonAssets
	{
		//Managers
		protected var _assetManager:AssetManager;
		protected var _fontManager:GanonFontManager;	
		
		//Environment
		protected var _env:IGanonEnv;
		
		//Dictionaries
		protected var _dictRectangles:Dictionary;
		
		//Function Callbacks
		protected var _funcAssetsLoaded:Function;
		
		
		public function GanonAssets()
		{
			this._env = Ganon.ganon.env;
			this._assetManager = new AssetManager();
		}
		
		public function loadAssets($complete:Function):void{
			this._funcAssetsLoaded = $complete;
			
			this._env.addAssets(this._assetManager);
			this._assetManager.loadQueue(this._loadProgress);
			
		}
		private function _loadProgress($percent:Number):void{
			if($percent==1){
				this._assetsReady();
			}
		}
		public function getTexture($textureID:String):Texture{
			return this._assetManager.getTexture($textureID);
		}
		/**
		 * This override must call "_setupFontManager" at the end.
		 */
		protected function _assetsReady():void{
			
			
		}
		protected function _setupFontManager($manager:GanonFontManager):void{
			this._fontManager = $manager;
			
			this._funcAssetsLoaded();
		}
		
		public function get fonts():GanonFontManager{
			return this._fontManager;
		}
		public function get manager():AssetManager{
			return this._assetManager;
		}
		
	}
}