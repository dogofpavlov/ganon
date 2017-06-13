package com.blankapp.env
{
	import flash.display.Sprite;
	
	import ganon.env.GanonEnvConfig;
	import ganon.env.GanonMobileEnv;
	
	public class BlankMobileEnv extends GanonMobileEnv implements ISizewiseEnv
	{
		public function BlankMobileEnv($root:Sprite, $config:GanonEnvConfig=null)
		{
			super($root, $config);			
		}
	}
}