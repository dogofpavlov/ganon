package ganon.dispatcher
{
	
	import ganon.event.GanonEvent;
	
	import flash.events.EventDispatcher;

	public class MainDispatcher
	{
		
		private static var _objDispatcher:EventDispatcher = new EventDispatcher();
		
		public function MainDispatcher()
		{
		}
		
		public static function dispatchEvent($event:GanonEvent):Boolean{
			return MainDispatcher._objDispatcher.dispatchEvent($event);
		}
		
		public static function hasEventListener($type:String):Boolean{
			return MainDispatcher._objDispatcher.hasEventListener($type);
		}
		public static function willTrigger($type:String):Boolean{
			return MainDispatcher._objDispatcher.willTrigger($type);
		}
		public static function removeEventListener($type:String, $listener:Function, $useCapture:Boolean=false):void{
			MainDispatcher._objDispatcher.removeEventListener($type,$listener,$useCapture);	
		}
		public static function addEventListener($type:String, $listener:Function, $useCapture:Boolean=false, $priority:int=0, $useWeakReference:Boolean=false):void{
			MainDispatcher._objDispatcher.addEventListener($type,$listener,$useCapture,$priority,$useWeakReference);
		}
	}
}