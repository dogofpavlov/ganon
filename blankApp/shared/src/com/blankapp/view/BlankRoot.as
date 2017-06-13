package com.blankapp.view
{

	import com.blankapp.assets.BlankAssets;
	import com.blankapp.data.AppData;
	import com.blankapp.env.ISizewiseEnv;
	
	import flash.utils.setTimeout;
	
	import ganon.assets.GanonAssets;
	import ganon.core.Ganon;
	import ganon.display.GanonNavigator;
	import ganon.display.GanonRoot;
	
	public class BlankRoot extends GanonRoot
	{
		
		private var _swEnv:ISizewiseEnv;
		//class visuals
		
		public function BlankRoot()
		{
			super();
			this._swEnv = this._env as ISizewiseEnv;
		}
		
		override protected function _setup1Core():void{
			super._setup1Core();
			
			Ganon.ganon.statsShow();
			//Finish with setup2
			this._setup2AssetsNSplashScreen(new BlankAssets());
		}
		
		override protected function _setup2AssetsNSplashScreen($assets:GanonAssets):void{
			super._setup2AssetsNSplashScreen($assets);
			
			//Setup Initial Splash Screen
			var splash:SplashScreen = new SplashScreen();
			this.screenAddSplash(splash,GanonNavigator.TRANS_NONE);
			
			//Finish with setup3
			this._setup3Load();
		}
		
		
		override public function resize():void{
			super.resize();
			
		}
		
		//AFTER ASSETS ARE LOADED
		override protected function _assetsLoaded():void{
			super._assetsLoaded();
			trace("WE ARE READY TO GO");
			
		
		}
		
	}
}