package ganon.util
{
	import flash.display.Loader;
	
	public class SmartLoader extends Loader
	{
		public var data:Object;
		public var loaded:Boolean=false;
		public var complete:Function;
		
		public function SmartLoader()
		{
			super();
		}
	}
}