package
{
	import com.blankapp.env.BlankAppMobileEnv;
	import com.blankapp.view.BlankAppRoot;
	
	import flash.display.Sprite;
	
	import ganon.core.Ganon;
	import ganon.env.GanonEnvConfig;
	
	public class GanonBlankApp extends Sprite
	{
		public function GanonBlankApp()
		{
			super();
			
			Ganon.ganon.setup(new BlankAppMobileEnv(this, new GanonEnvConfig(1080,1920,true,false,0x35b2f6)), BlankAppRoot);
		}
	}
}