package com.blankapp.env
{
	import flash.display.Sprite;
	
	import ganon.env.GanonEnvConfig;
	import ganon.env.GanonMobileEnv;
	
	public class BlankAppMobileEnv extends GanonMobileEnv implements IBlankAppEnv
	{
		public function BlankAppMobileEnv($root:Sprite, $config:GanonEnvConfig=null)
		{
			super($root, $config);			
		}
		public function someANEMethod():void{
			
		}
	}
}