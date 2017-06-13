package ganon.util
{
	import flash.display.AVM1Movie;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.utils.getQualifiedClassName;
	
	import starling.display.MovieClip;
	import starling.textures.Texture;
	
	public class StarlingAS2SWFLoader extends Loader
	{
		
		
		private var _movieclip:MovieClip;
		
		private var _as2Movie:AVM1Movie;
		
		public var complete:Function;
		
		private var _numCurFrame:int = 0;
		private var _numMaxFrames:int;
		private var _bolDone:Boolean=false;
		
		private var _funcComplete:Function;
		
		private var _bmd:BitmapData;
		
		private var _vecTextures:Vector.<Texture>;
		
		public function StarlingAS2SWFLoader($complete:Function)
		{
			super();
			
			this._funcComplete = $complete;
			this._vecTextures = new Vector.<Texture>();
			
			this.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this._onError);
			this.contentLoaderInfo.addEventListener(Event.COMPLETE, this._onComplete);
		}
		public function setMaxFrames($numFramesToDraw:int):void{
			this._numMaxFrames = $numFramesToDraw;
		}
		private function _onComplete($event:Event):void{
			this._clean();
			
			this._numCurFrame=0;
			this._bolDone=false;
			
			
			switch(getQualifiedClassName(this.content)){
				case "flash.display::AVM1Movie": //SWF, listen for multi-frame
					
					this._as2Movie = this.content as AVM1Movie;
					this._as2Movie.addEventListener(Event.ENTER_FRAME, this._onEnterFrame);
					break;
				case "flash.display::Bitmap":
					this._drawToTexture(); //bitmap, only 1 frame.
					this._done();
					
					break;
			}
		}
		
		private function _onError($event:Event):void{
			this._funcComplete(false);
		}
		private function _onEnterFrame($event:Event):void{
			
			if(!this._bolDone){
				this._drawToTexture();
			}
			
			this._numCurFrame++;
			
			if(this._numCurFrame==this._numMaxFrames){
				this._as2Movie.removeEventListener(Event.ENTER_FRAME, this._onEnterFrame);
				this._done();
			}
		}
		
		private function _done():void{
			this._bolDone=true;	
			
			this._movieclip = new MovieClip(this._vecTextures,4);
			
			this._funcComplete(true);
			
		}
		private function _drawToTexture():void{
			var bmd:BitmapData = new BitmapData(this.width, this.height, false,0x000000);
			bmd.draw(this);
			this._vecTextures.push(Texture.fromBitmapData(bmd));
		}
		
		private function _clean():void{
			if(this._movieclip){
				this._movieclip.dispose();
				this._movieclip = null;
			}
			
			var numFrames:int = this._vecTextures.length;
			var texture:Texture;
			for(var i:int=0; i<numFrames; i++){
				texture = this._vecTextures[i];
				texture.dispose();
				texture = null;
			}
			this._vecTextures.length = 0;
		}
		
		
		
		public function get movieclip():MovieClip{
			return this._movieclip;
		}
	}
}