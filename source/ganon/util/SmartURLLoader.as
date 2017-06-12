package ganon.util
{
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	public class SmartURLLoader extends URLLoader
	{
		public var loaded:Boolean=false;
		public var complete:Function;
		
		public function SmartURLLoader(request:URLRequest=null)
		{
			super(request);
		}
	}
}