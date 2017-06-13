package ganon.env
{

	public class GanonEnvConfig
	{
		
		/**
		 * Starting Fullscreen, Default False/No
		 */
		public var initFullscreen:Boolean;
		
		/**
		 * Stage Background Color, Default 60 unless specified
		 */
		public var initBGColor:uint;
		
		/**
		 * Starting Framerate, Default 60 unless specified
		 */
		public var initFrameRate:Number;
		
		/**
		 * Width of the design
		 */
		public var designWidth:Number;
		
		/**
		 * Height of the design
		 */
		public var designHeight:Number;	
		
		
		/**
		 * Is the Design based upon portrait? even if it can rotate to landscape? true
		 * Is the Design based upon landscape? even if it can rotate to portrait (which is rare)? false 
		 */
		public var designBasedOnPortrait:Boolean;
		
		
		/**
		 * Enables Starling Multitouch, True by Default
		 */
		public var initStarlingMultiTouchEnable:Boolean=true;
		
		public function GanonEnvConfig($designWidth:Number, $designHeight:Number, $designBasedOnPortrait:Boolean=true, $initFullscreen:Boolean=false, $initBGColor:uint = 0x000000, $initFrameRate:Number=60)
		{
			this.designWidth = $designWidth;
			this.designHeight = $designHeight;
			this.designBasedOnPortrait = $designBasedOnPortrait;
			
			this.initFullscreen = $initFullscreen;
			this.initBGColor = $initBGColor;
			this.initFrameRate = $initFrameRate;
		}
	}
}