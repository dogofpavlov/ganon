package ganon.env
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageDisplayState;
	import flash.system.Capabilities;
	import flash.utils.getTimer;
	
	import starling.utils.AssetManager;
	
	

	public class GanonEnv implements IGanonEnv
	{
		
		public static const OS_Windows:String = "Windows";
		public static const OS_Mac:String = "Mac";
		public static const OS_Android:String = "Android";
		public static const OS_iOS:String = "iOS";
		
		public static const OS_iOS_6_and_below:String = "6"; //ios top black bar
		public static const OS_iOS_7_and_above:String = "7"; //ios top floating bar
		
		//Core
		protected var _config:GanonEnvConfig;		
		private var _root:Sprite;
		private var _stage:Stage;
		
		//Dates
		private var _now:Date;
		private var _now_creation:uint;
		
		//Strings
		private var _strOS:String;
		private var _strOSVer:String;
		
		//Booleans
		private var _bolMobile:Boolean;
		private var _bolDesktop:Boolean;
		private var _bolWeb:Boolean;
		private var _bolIOS:Boolean;
		private var _bolAndroid:Boolean;
		private var _bolWindows:Boolean;
		private var _bolMac:Boolean;
		private var _bolSmallDevice:Boolean;
		private var _bolPortrait:Boolean;
		
		
		//Numbers		
		private var _numWidth:Number;
		private var _numHeight:Number;
		private var _numWidth2:Number;
		private var _numHeight2:Number;
		private var _numExtraDesignSpace:Number;
		
		protected var _numIOSStatusBarHeight:Number;
		
		public function GanonEnv($root:Sprite, $config:GanonEnvConfig):void{
			this._root = $root;
			this._stage = $root.stage;
			this._config = $config;
			
			//Setup Stage
			if($config.initFullscreen){
				this.stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
			}
			this.stage.frameRate = this._config.initFrameRate;
			this.stage.color = this._config.initBGColor;
			
			//Disable Root Clicks because this is Starling
			this._root.mouseEnabled = this._root.mouseChildren = false;
			
			//Determine Small Device
			var resolutionX:Number = Capabilities.screenResolutionX;
			var resolutionY:Number = Capabilities.screenResolutionY;	
			var numDiagonalInches:Number = Math.round(Math.sqrt((resolutionX*resolutionX)+(resolutionY*resolutionY)))/Capabilities.screenDPI;
			this._bolSmallDevice = (numDiagonalInches<6);
			
			//Discover Operating System / Version / Environment
			var strOS:String = Capabilities.os;
			var strManu:String = Capabilities.manufacturer.toLowerCase();			
			if(strManu.indexOf("ios")!=-1 || strManu.indexOf("android")!=-1){	
				//Mobile
				this._bolMobile=true;
				
				if(strManu.indexOf("ios")!=-1){//IOS
					this._bolIOS=true;
					this._strOS = OS_iOS;
					
					var iOSVer:String = strOS.substr(10,1);
					switch(iOSVer){
						case "7":
							this._strOSVer = OS_iOS_7_and_above;
							break;
						default:
							this._strOSVer = OS_iOS_6_and_below;
					}
					if(this._bolSmallDevice){
						this._numIOSStatusBarHeight = 35;
					}else{
						this._numIOSStatusBarHeight = 70;
					}
					
				}else{//ANDROID
					this._bolAndroid = true;
					this._strOS = OS_Android;
				}	
			}else{
				//Desktop
				this._bolDesktop=true;
				
				if(strManu.indexOf("windows")!=-1){//Windows
					this._bolWindows = true;
					this._strOS = OS_Windows;
				}else{//Mac... or maybe linux? nah assume mac
					this._bolMac = true;
					this._strOS = OS_Mac;
				}
			}	
			
			if(this.stage.displayState==StageDisplayState.FULL_SCREEN_INTERACTIVE){
				this._numIOSStatusBarHeight=0;
			}
			
			this.newNow();
			
		}
		/**
		 * Override this to initialize ANEs
		 */
		public function initializeANEs():void{
			
		}
		/**
		 * Override this to add Assets
		 */
		public function addAssets($manager:AssetManager):void{
			
		}
		
		
		/**
		 * orientation determined by ganon
		 */
		public function set portrait($value:Boolean):void{
			this._bolPortrait = $value;
		}
		public function get portrait():Boolean{
			return this._bolPortrait;
		}
		
		/**
		 * creates/resets the main now date.
		 */
		public function newNow():void{			
			this._now = new Date();
			this._now_creation = getTimer();			
		}
		/**
		 * The current date/time without creating a new date
		 */
		public function get now():Date{
			this._now.time += Number(getTimer()-this._now_creation);
			this._now_creation = getTimer();
			return this._now;
		}
		
		
		/**
		 * flash.display.Stage of your starting Sprite class
		 */
		public function get stage():Stage{
			return this._stage;
		}
		
		/**
		 * Starting flash.display.Sprite class
		 */
		public function get root():Sprite{
			return this._root;
		}
		
		
		/**
		 * Operating System
		 */
		public function get os():String{
			return this._strOS;
		}
		/**
		 * Operating System Versopm
		 */
		public function get osVer():String{
			return this._strOSVer;
		}
		/**
		 * Is a mobile device
		 */
		public function get mobile():Boolean{
			return this._bolMobile;
		}
		/**
		 * Is a desktop computer
		 */
		public function get desktop():Boolean{
			return this._bolDesktop;
		}
		/**
		 * Is a website
		 */
		public function get web():Boolean{
			return this._bolWeb;
		}
		
		
		
		/**
		 * Is an iOS Device
		 */
		public function get ios():Boolean{
			return this._bolIOS;
		}
		/**
		 * Is an Android Device
		 */
		public function get android():Boolean{
			return this._bolAndroid;
		}
		/**
		 * Is a Windows Desktop
		 */
		public function get windows():Boolean{
			return this._bolWindows;
		}
		/**
		 * Is a Mac Desktop
		 */
		public function get mac():Boolean{
			return this._bolMac;
		}
		/**
		 * Is a Mobile Device smaller than 6 inches (a phone)
		 */
		public function get smallDevice():Boolean{
			return this._bolSmallDevice;
		}
		
		/**
		 * initial config
		 */
		public function get config():GanonEnvConfig{			
			return this._config;			
		}
		
		/**
		 * scaled width determined by ganon
		 */
		public function set width($value:Number):void{
			this._numWidth = $value;
			this._numWidth2 = $value/2;
		}
		/**
		 * scaled width determined by ganon
		 */
		public function get width():Number{
			return this._numWidth;
		}
		
		
		/**
		 * scaled height determined by ganon
		 */
		public function set height($value:Number):void{
			this._numHeight = $value;
			this._numHeight2 = $value/2;
		}
		
		/**
		 * scaled height determined by ganon
		 */
		public function get height():Number{
			return this._numHeight;
		}
		
		/**
		 * scaled half width determined by ganon
		 */
		public function set width2($value:Number):void{
			this._numWidth2 = $value;
		}
		/**
		 * scaled half width determined by ganon
		 */
		public function get width2():Number{
			return this._numWidth2;
		}
		
		
		/**
		 * scaled half height determined by ganon
		 */
		public function set height2($value:Number):void{
			this._numHeight2 = $value;
		}
		
		/**
		 * scaled half height determined by ganon
		 */
		public function get height2():Number{
			return this._numHeight2;
		}
		
		/**
		 * extra design space
		 */
		public function set extraDesignSpace($value:Number):void{
			this._numExtraDesignSpace = $value;
		}
		
		/**
		 * extra design space
		 */
		public function get extraDesignSpace():Number{
			return this._numExtraDesignSpace;
		}
		
	}
}