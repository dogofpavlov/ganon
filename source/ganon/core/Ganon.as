package ganon.core
{
	
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	import ganon.display.GanonRoot;
	import ganon.env.IGanonEnv;
	
	import starling.core.Starling;
	import starling.events.Event;

	public class Ganon
	{
		/*
		STATIC
		*/
		public static var __instance:Ganon;
		
		/**
		 * The Main Ganon instance
		 */		
		public static function get ganon():Ganon{
			if(__instance==null) __instance = new Ganon(new GanonEnforcer());
			return __instance;
		}
		
		/*
		INSTANCE
		*/
		
		//Core
		private var _env:IGanonEnv;
		private var _rootClass:Class;
		
		//Starling
		private var _starling:Starling;
		
		
		public function Ganon($param:GanonEnforcer)
		{
		}
		
		
		/**
		 * Setup Ganon by declaring your own enviroment and Starling Root Class
		 * The Environment must extend a GanonEnv and implement your own Interface in order to call ANEs	
		 * The Starling Root Class must extend GanonRoot
		 */
		public function setup($env:IGanonEnv, $root:Class):void{
			this._env =$env;
			this._rootClass = $root;
			trace("[Ganon] Starting");
			
			//Initialize ANES
			this._env.initializeANEs();
			
			//Load init
			this.load();
		}
		
		public function load():void{
			//Listen to the loading swf root.
			this._env.root.loaderInfo.addEventListener(flash.events.Event.COMPLETE, this._onRootLoaded);
		}
		private function _onRootLoaded($event:flash.events.Event):void{
			this._env.root.loaderInfo.removeEventListener(flash.events.Event.COMPLETE, this._onRootLoaded);
			this._setupStarling();
			this._setupListeners();
		}
		
		
		private function _setupStarling():void{
			
			//Begin Starling
			Starling.multitouchEnabled = this._env.config.initStarlingMultiTouchEnable;
			this._starling = new Starling(this._rootClass, this._env.stage);
			this._starling.supportHighResolutions = this._env.desktop; //desktop only
			this._starling.skipUnchangedFrames = true;
			this._starling.start();
			this._starling.addEventListener("rootCreated", this._onStarlingReady);
			
			//Run resize once to start
			this.resize();
		}
		private function _setupListeners():void{
			
			this._env.stage.addEventListener(flash.events.Event.RESIZE, this._onResize);
			this._env.stage.addEventListener(flash.events.Event.DEACTIVATE, this._onDeactivate);
			
		}
		private function _starlingReady():void{		
			
		}
		public function statsShow($hor:String="right", $ver:String="bottom"):void{
			if(this._starling){
				this._starling.showStatsAt($hor,$ver,this._env.scale);
			}
		}
		
		public function resize():void{
			
			//Determine w/h and apply to viewport
			var screenWidth:int = (this._env.ios)?this._env.stage.fullScreenWidth:this._env.stage.stageWidth;
			var screenHeight:int = (this._env.ios)?this._env.stage.fullScreenHeight:this._env.stage.stageHeight;
			
			//FOR PORTRAIT ... divide by DESIGN_WIDTH
			//FOR LANDSCAPE ..... divide by DESIGN_HEIGHT
			var numDivider:Number = this._env.config.designBasedOnPortrait?this._env.config.designWidth:this._env.config.designHeight
			
			if ( screenWidth > screenHeight ){ //check real orientation
				this._env.portrait=false;
				this._env.unscale = (screenHeight / numDivider);
			}else{
				this._env.portrait=true;
				this._env.unscale = (screenWidth / numDivider);
			}
			
			this._env.scale = 1/this._env.unscale;
			
			var viewport:Rectangle = this._starling.viewPort;
			
			viewport.width = screenWidth;
			viewport.height = screenHeight;
			this._starling.viewPort = viewport;
			
			
			//Update MainData Details
			this._env.width = screenWidth * this._env.scale;
			this._env.height = screenHeight * this._env.scale;
			
			
			//Calc extra design space if any
			if(this._env.portrait){
				this._env.extraDesignSpace = this._env.height-this._env.config.designHeight; //based on height				
			}else{
				this._env.extraDesignSpace = this._env.width-this._env.config.designWidth; //based on width
			}
			
			//Update Starling Stage to the MainData.WiDTH & HEIGHT
			this._starling.stage.stageWidth = this._env.width;
			this._starling.stage.stageHeight = this._env.height;
			
			//Tell the Root as well
			if(this._starling.root) (this._starling.root as GanonRoot).resize();
			
			
		}
		
		/*
		BASIC EVENT HANDLERS
		*/
		private function _onResize($event:flash.events.Event):void{
			this.resize();
		}
		private function _onDeactivate($event:flash.events.Event):void{		
			this._env.deactivated = true;
			this._starling.stop();
			this._env.stage.addEventListener(flash.events.Event.ACTIVATE, this._onActivate);
		}		
		private function _onActivate($event:flash.events.Event):void{	
			this._env.deactivated = false;
			this._env.stage.removeEventListener(flash.events.Event.ACTIVATE, this._onActivate);
			this._starling.start();
			
		}
		
		/*
		STARLING EVENT HANDLERS
		*/
		private function _onStarlingReady($event:starling.events.Event):void{
			this._starling.removeEventListener("rootCreated", this._onStarlingReady);
			this._starlingReady();
			
		}
		
		/*
		GETTERS & SETTERS
		*/
		
		public function get env():IGanonEnv{
			return this._env;
		}
		public function get root():GanonRoot{
			return this._starling.root as GanonRoot;
		}
	}
}


//Singleton Enforcer
internal class GanonEnforcer{}