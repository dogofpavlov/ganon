package ganon.display
{
	import flash.utils.Dictionary;
	
	import feathers.controls.Drawers;
	import feathers.controls.ScreenNavigator;
	import feathers.controls.ScreenNavigatorItem;
	import feathers.events.FeathersEventType;
	import feathers.motion.Cube;
	import feathers.motion.Fade;
	import feathers.motion.Slide;
	
	import starling.animation.Transitions;
	import starling.events.Event;
	
	public class GanonNavigator extends Drawers
	{
		
		public static const DRAWER_TOP:String = 	"top";
		public static const DRAWER_LEFT:String = 	"left";
		public static const DRAWER_RIGHT:String = 	"right";
		public static const DRAWER_BOTTOM:String = 	"bottom";
		
		public static const TRANS_NONE:String = 	"none";
		public static const TRANS_OPACITY:String = 	"opacity";
		public static const TRANS_UP:String = 		"up";
		public static const TRANS_RIGHT:String = 	"right";
		public static const TRANS_DOWN:String = 	"down";
		public static const TRANS_LEFT:String = 	"left";
		public static const TRANS_CUBE_UP:String = 		"cube_up";
		public static const TRANS_CUBE_RIGHT:String = 	"cube_right";
		public static const TRANS_CUBE_DOWN:String = 	"cube_down";
		public static const TRANS_CUBE_LEFT:String = 	"cube_left";
		
		public static const TRANS_FORWARD:String = TRANS_LEFT;
		public static const TRANS_BACK:String = TRANS_RIGHT;
		
		//Core
		private var _navigator:ScreenNavigator;
		
		//Dictionaries
		private var _dictScreens:Dictionary;
		
		//Vectors
		private var _vecScreens:Vector.<GanonScreen>;
		private var _vecExemptFromHistory:Vector.<String>;
		private var _vecHistory:Vector.<SectionChange>;
		private var _vecHistoryPool:Vector.<SectionChange>;
		
		//Numbers
		private var _numTransitionSpeed:Number;
		
		//strings
		private var _strCurSection:String;
		private var _strPrevSection:String;
		private var _strRoot:String;
		
		//Booleans
		private var _bolTransitioning:Boolean=false;
		
		public function GanonNavigator($transitionSpeed:Number=0.5)
		{
			super();
			
			this._numTransitionSpeed = $transitionSpeed;
			this._vecScreens = new Vector.<GanonScreen>();
			this._vecExemptFromHistory = new Vector.<String>();
			this._vecHistory = new Vector.<SectionChange>();
			this._vecHistoryPool = new Vector.<SectionChange>();
			this._dictScreens = new Dictionary();
			this._strRoot = "";
			
			
			this._navigator = new ScreenNavigator();
			this._navigator.addEventListener( FeathersEventType.TRANSITION_START, this._onTransitionStart );
			this._navigator.addEventListener( FeathersEventType.TRANSITION_COMPLETE, this._onTransitionComplete );
			this.content = this._navigator;
		}
		/**
		 * Add a screen. There can only be 1 root, adding another will override the current if it exists
		 * @param $history if false, this section will not be included in the history.
		 * 
		 */
		public function screenAdd($sectionID:String, $screen:GanonScreen, $data:Object=null, $history:Boolean=true, $root:Boolean=false):void{
			if($data==null)$data={};
			$screen.init(this.sectionChangeWithHistory, this.sectionBack, this.toggleDrawer, $data);
			this._navigator.addScreen($sectionID, new ScreenNavigatorItem($screen));
			this._vecScreens.push($screen);
			if($history==false) this._vecExemptFromHistory.push($sectionID);
			this._dictScreens[$sectionID] = $screen;
			if($root) this._strRoot = $sectionID;
		}
		public function screenRemove($sectionID:String):GanonScreen{
			var screen:GanonScreen = this._navigator.removeScreen($sectionID).screen as GanonScreen;
			var index:int = this._vecScreens.indexOf(screen);
			if(index!=-1) this._vecScreens.removeAt(index);	
			index = this._vecExemptFromHistory.indexOf($sectionID);
			if(index!=-1) this._vecExemptFromHistory.removeAt(index);			
			delete this._dictScreens[$sectionID];			
			return screen;
		}
		public function sectionChangeWithHistory($sectionID:String, $trans:String=TRANS_FORWARD):void{
			
			var change:SectionChange = this._createSectionChange();
			change.ID = $sectionID;
			change.trans = $trans;
			
			var strRequestedSection:String = $sectionID;
			// Prevent storing duplicate sections and the root in view history
			var strLastStoredSectionOrRoot:String = this._vecHistory.length > 0 ? this._vecHistory[ this._vecHistory.length - 1 ].ID : this._strRoot;
			
			var bolHistory:Boolean=true;
			if(strRequestedSection == strLastStoredSectionOrRoot || this._vecExemptFromHistory.indexOf(strRequestedSection)!=-1){
				bolHistory=false;
			}
			
			if(bolHistory){
				this._vecHistory.push( change );
			}
			
			this.sectionChange($sectionID, $trans);
		}
		
		
		
		public function sectionBack():void{
			var strPrevSection:String;
			if(this._vecHistory.length>1){
				var strCurrentStoreSection:String = this._vecHistory[this._vecHistory.length-1].ID;
				if(this._strCurSection == strCurrentStoreSection){
					this._returnSectionChange(this._vecHistory.pop()); 
				}
				var sectionData:SectionChange = this._vecHistory[this._vecHistory.length-1];
				strPrevSection = sectionData.ID;
				
			}else{
				strPrevSection = this._strRoot;
			}
			this.sectionChange(strPrevSection,TRANS_BACK);
		}
		
		public function sectionChange($section:String, $trans:String=TRANS_FORWARD):void{
			
			this._strPrevSection = this._strCurSection;
			this._strCurSection = $section;
			
			if($section==this._strRoot){ //clear history if root
				this._vecHistory.length = 0;
			}
			trace("[SECTION CHANGE] GOING "+$trans+" FROM ("+(this._strPrevSection?this._strPrevSection:"")+") TO ("+this._strCurSection+")");
			
			this._navigator.transition = this._getTransition($trans,this.transitionSpeed);
			
			this._navigator.showScreen($section);
			
			
		}
		
		public function toggleDrawer($side:String):void{
			
			switch($side){
				case DRAWER_TOP:
					this.toggleTopDrawer();
					break;
				case DRAWER_RIGHT:
					this.toggleRightDrawer();
					break;
				case DRAWER_BOTTOM:
					this.toggleBottomDrawer();
					break;
				case DRAWER_LEFT:
					this.toggleLeftDrawer();
					break;
			}
		}
		
		private function _getTransition($trans:String, $speed:Number):Function{
			var transition:Function;
			var ease:String = Transitions.EASE_IN_OUT;
			
			switch($trans){
				case TRANS_UP:
					transition = Slide.createSlideUpTransition($speed,ease);
					break;
				case TRANS_DOWN:
					transition = Slide.createSlideDownTransition($speed,ease);
					break;
				case TRANS_RIGHT:
					transition = Slide.createSlideRightTransition($speed,ease);
					break;
				case TRANS_LEFT:
					transition = Slide.createSlideLeftTransition($speed,ease);
					break;
				case TRANS_CUBE_UP:
					
					transition = Cube.createCubeUpTransition($speed,ease);
					break;
				case TRANS_CUBE_DOWN:
					transition = Cube.createCubeDownTransition($speed,ease);
					break;
				case TRANS_CUBE_RIGHT:
					transition = Cube.createCubeRightTransition($speed,ease);
					break;
				case TRANS_CUBE_LEFT:
					transition = Cube.createCubeLeftTransition($speed,ease);
					break;
				case TRANS_NONE:
					transition = null;	
					break;
				case TRANS_OPACITY:
					transition = Fade.createFadeInTransition($speed,Transitions.EASE_OUT);
					break;
			}			
			return transition;
		}
		
		protected function _onTransitionStart($event:Event):void{
			this._bolTransitioning=true;
			if(this._strPrevSection) (this._navigator.getScreen(this._strPrevSection).screen as GanonScreen).outro();
			(this._navigator.getScreen(this._navigator.activeScreenID).screen as GanonScreen).intro();
		}
		protected function _onTransitionComplete($event:Event):void{
			this._bolTransitioning=false;
			if(this._strPrevSection) (this._navigator.getScreen(this._strPrevSection).screen as GanonScreen).outroComplete();
			(this._navigator.getScreen(this._navigator.activeScreenID).screen as GanonScreen).introComplete();			
		}
		
		public function resize():void{
			var numLen:int = this._vecScreens.length;
			for(var i:int=0; i<numLen; i++){
				this._vecScreens[i].resize();
			}
		}
		public function androidBack():void{
			(this._navigator.activeScreen as GanonScreen).androidBack();
		}
		/**
		 * get from SectionChange Pool
		 */
		private function _createSectionChange():SectionChange{
			var change:SectionChange;
			if(this._vecHistoryPool.length>0){				
				change = this._vecHistoryPool.shift();
			}else{
				change = new SectionChange();
			}
			return change;
		}
		/**
		 * return to SectionChange Pool
		 */
		private function _returnSectionChange($change:SectionChange):void{
			this._vecHistoryPool.push($change);
		}
		
		
		
		/**
		 * Transition Speed, Default 0.5
		 */
		public function set transitionSpeed($value:Number):void{
			this._numTransitionSpeed = $value;
		}
		
		/**
		 * Transition Speed, Default 0.5
		 */
		public function get transitionSpeed():Number{
			return this._numTransitionSpeed;
		}
		
		/**
		 * Is currently Transitioning
		 */
		public function get isTransitioning():Boolean{
			return this._bolTransitioning;
		}
		
		/**
		 * The Previous Section ID
		 */
		public function get previousSection():String{
			return this._strPrevSection;
		}
		
		public function get navigator():ScreenNavigator{
			return this._navigator;
		}
		
	}
}