package ganon.event
{
	import flash.events.Event;
	
	public class GanonEvent extends Event
	{
		
		public static const SECTION_CHANGE:String = "MainEvent.onSectionChange";
		public static const SECTION_BACK:String = "MainEvent.onSectionBack";
		public static const TOGGLE_DRAWER:String = "MainEvent.onToggleDrawer";
		
		public var origin:Object;
		public var details:Object;
		
		public function GanonEvent($type:String, $origin:Object, $details:Object=null, $bubbles:Boolean=false, $cancelable:Boolean=false)
		{
			super($type, $bubbles, $cancelable);
			this.origin = $origin;
			this.details = $details;
		}
	}
}