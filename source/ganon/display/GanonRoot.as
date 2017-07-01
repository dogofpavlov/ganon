package ganon.display
{
	import ganon.assets.GanonAssets;
	import ganon.core.Ganon;
	import ganon.dispatcher.MainDispatcher;
	import ganon.env.IGanonEnv;
	import ganon.event.GanonEvent;
	
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class GanonRoot extends Sprite
	{
		protected var _assets:GanonAssets;
		
		//Main Ganon Navigator
		protected var _navigator:GanonNavigator;
		
		protected var _env:IGanonEnv;
		
		//Data Containers
		
		public function GanonRoot()
		{
			super();
			this._env = Ganon.ganon.env;
			this.addEventListener(Event.ADDED_TO_STAGE, this._initialize);
			
			
			MainDispatcher.addEventListener(GanonEvent.DEACTIVATE, this._onDeactivate);
			MainDispatcher.addEventListener(GanonEvent.ACTIVATE, this._onActivate);
			
		}
		private function _initialize($event:Event):void{
			this.removeEventListener(Event.ADDED_TO_STAGE, this._initialize);			
			trace("[Ganon] Ready");
			this._setup1Core();
		}
		/**
		 * You must finish overriding this function with calling setup 2 (_setup2AssetsNSplashScreen)
		 */
		protected function _setup1Core():void{
			
			//Navigator
			this._navigator = new GanonNavigator();
			this.addChild(this._navigator);
		}
		
		/**
		 * You must finish overriding this function with calling setup 3 (_setup3Load)
		 */
		protected function _setup2AssetsNSplashScreen($assets:GanonAssets):void{
			//Assets
			this._assets = $assets;
			
		}

		protected function _setup3Load():void{
			this._assets.loadAssets(this._assetsLoaded);
		}
		
		protected function _setupListeners():void{
			
		}
		protected function _assetsLoaded():void{
			
		}
		/*
		SECTION CHANGE
		*/
		public function screenAddSplash($screen:GanonScreen, $trans:String = GanonNavigator.TRANS_NONE, $data:Object=null):void{
			this.screenAdd("GanonSplash",$screen,$data,false);
			this._navigator.sectionChange("GanonSplash",$trans);
		}
		
		public function screenAdd($sectionID:String, $screen:GanonScreen, $data:Object=null, $history:Boolean=true, $root:Boolean=false):void{
			this._navigator.screenAdd($sectionID,$screen,$data,$history,$root);
		}
		public function screenRemove($sectionID:String):GanonScreen{
			return this._navigator.screenRemove($sectionID);
		}
		
		
		public function resize():void{
			this._navigator.resize();
		}
		
		/*
		MAIN EVENT HANDLERS
		*/
		public function androidBack():void{
			this._navigator.androidBack();
		}
		
		/*
		EVENT HANLDERS
		*/
		protected function _onDrawerOpen($event:Event):void{
		
		}
		protected function _onDrawerClose($event:Event):void{
			
		}
		
		protected function _onActivate($event:GanonEvent):void{
			
		}
		protected function _onDeactivate($event:GanonEvent):void{
			
		}
		
		/*
		GETTERS & SETTERS
		*/
		public function get assets():GanonAssets{
			return this._assets;
		}
		
	}
}