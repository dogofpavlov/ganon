package ganon.display
{
	import feathers.controls.Screen;
	import feathers.layout.AnchorLayout;
	
	import ganon.dispatcher.MainDispatcher;
	import ganon.event.GanonEvent;
	
	public class GanonScreen extends Screen
	{
		private var _funcSectionChange:Function;
		private var _funcSectionBack:Function;
		private var _funcToggleDrawer:Function;
		
		private var _bolShowing:Boolean=false;
		protected var _objData:Object;
		
		public function GanonScreen()
		{
			super();
		}
		
		public function init($sectionChange:Function, $sectionBack:Function, $toggleDrawer:Function, $data:Object=null):void{
			this._funcSectionChange = $sectionChange;
			this._funcSectionBack = $sectionBack;
			this._funcToggleDrawer = $toggleDrawer;
			this._objData = $data;
			this.layout = new AnchorLayout();
			
		}
		
		public function intro():void{
			
		}
		public function introComplete():void{
			this._bolShowing=true;
		}
		public function outro():void{
			this._bolShowing=false;
		}
		public function outroComplete():void{
			
		}
		
		public function resize():void{
			
		}
		public function androidBack():void{
			
		}
		public function mainDispatch($event:String, $details:Object=null):void{
			MainDispatcher.dispatchEvent(new GanonEvent($event, this, $details));
		}
		
		public function toggleDrawer($side:String):void{
			this._funcToggleDrawer($side);
		}
		public function toggleDrawerTop():void{
			this.toggleDrawer(GanonNavigator.DRAWER_TOP);
		}
		public function toggleDrawerBottom():void{
			this.toggleDrawer(GanonNavigator.DRAWER_BOTTOM);
		}
		public function toggleDrawerRight():void{
			this.toggleDrawer(GanonNavigator.DRAWER_RIGHT);
		}
		public function toggleDrawerLeft():void{
			this.toggleDrawer(GanonNavigator.DRAWER_LEFT);
		}
		
		public function sectionBack():void{
			this._funcSectionBack();
		}
		
		public function sectionChange($section:String, $trans:String=GanonNavigator.TRANS_FORWARD):void{
			this._funcSectionChange($section,$trans);
		}
		
		public function get isShowing():Boolean{
			return this._bolShowing;
		}
	}
}