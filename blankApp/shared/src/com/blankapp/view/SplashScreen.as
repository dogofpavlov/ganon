package com.blankapp.view
{
	import com.blankapp.assets.BlankAppAssets;
	
	import ganon.display.GanonScreen;
	import ganon.display.ImageRect;
	import ganon.layout.ALD;
	
	public class SplashScreen extends GanonScreen
	{
		public function SplashScreen()
		{
			super();
			
			var logo:ImageRect = new ImageRect(BlankAppAssets.getTexture("logo"));
			logo.relativeScale(1);
			this.addChild(logo);
			logo.layoutData = new ALD(NaN,NaN,NaN,NaN,0,0);
			
		}
	}
}