package
{
	import com.blankapp.env.BlankMobileEnv;
	import com.blankapp.view.BlankRoot;
	
	import flash.display.Sprite;
	
	import ganon.core.Ganon;
	import ganon.env.GanonEnvConfig;
	
	public class GanonBlankApp extends Sprite
	{
		public function GanonBlankApp()
		{
			super();
			
			Ganon.ganon.setup(new BlankMobileEnv(this, new GanonEnvConfig(1080,1920,true,false,0x35b2f6)), BlankRoot);
		}
	}
}