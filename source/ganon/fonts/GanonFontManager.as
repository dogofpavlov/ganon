package ganon.fonts
{
	
	import flash.text.TextFormatAlign;
	import flash.utils.Dictionary;
	
	import feathers.controls.ButtonState;
	import feathers.controls.text.BitmapFontTextRenderer;
	import feathers.core.ITextRenderer;
	import feathers.text.BitmapFontTextFormat;

	public class GanonFontManager
	{
		
		
		private var _dictTextFormats:Dictionary;
		private var _dictItems:Dictionary;
		
		private var _vecItems:Vector.<GanonFont>;
		
		private var _dictFontFunctions:Dictionary = new Dictionary();
		
		public function GanonFontManager()
		{
			this._dictTextFormats = new Dictionary();
			this._dictItems = new Dictionary();
			this._vecItems = new Vector.<GanonFont>();
			
			
		}
		
		public function addFontItem($font:GanonFont):void{
			this._vecItems.push($font);
			this._dictItems[$font.name] = $font;
		}
		
		public function getFontItem($name:String):GanonFont{
			return this._dictItems[$name];
		}
		
		public function getBMFontFormat($font:String, $color:String, $size:int, $style:String, $align:String = TextFormatAlign.LEFT, $forced:Boolean=false):BitmapFontTextFormat{
			
			var format:BitmapFontTextFormat;
			
			var alias:String = String($font+""+$color+""+$size+""+$style+""+$align);
			
			if(this._dictTextFormats[alias]){
				format = this._dictTextFormats[alias];
			}else{
				
				var item:GanonFont = this.getFontItem($font);
				var numSize:Number = item.getSize($size,$forced);
				var color:uint = item.getColor($color);
				var strFontName:String = $font+numSize+""+$style;
				
				format = new BitmapFontTextFormat(strFontName,$size,color,$align);
				this._dictTextFormats[alias] = format;
				
			}
			
			return format;
		}
		
		public function createTextRenderer($font:String, $color:String, $size:int, $style:String="", $align:String = TextFormatAlign.LEFT, $batch:Boolean=true,$forced:Boolean=false):ITextRenderer{
			var renderer:BitmapFontTextRenderer = new BitmapFontTextRenderer();
			
			var bmFormat:BitmapFontTextFormat = this.getBMFontFormat($font,$color,$size,$style,$align,$forced);
			renderer.textFormat = bmFormat;
			renderer.useSeparateBatch=!$batch;
			
			return renderer;
		}
		
		
		public function getFont($font:String, $color:String, $size:int, $style:String="", $align:String = TextFormatAlign.LEFT, $batch:Boolean=true, $forced:Boolean=false):Function{
			var func:Function;
			
			var alias:String = String($font+""+$color+""+$size+""+$style+""+$align);
			
			if(this._dictFontFunctions[alias]){
				func = this._dictFontFunctions[alias];
				
			}else{
				func = function():ITextRenderer{
					return createTextRenderer($font,$color,$size,$style,$align,$batch,$forced);					
				}
				this._dictFontFunctions[alias] = func;
			}
			
			return func;
		}
		
		public function getFontWithSelectedState($font:String, $color:String, $selectedColor:String,  $size:int, $style:String="", $align:String = TextFormatAlign.LEFT, $batch:Boolean=true, $forced:Boolean=false):Function{
			var func:Function;
			
			var alias:String = String($font+""+$color+""+$selectedColor+""+$size+""+$style+""+$align);
			
			if(this._dictFontFunctions[alias]){
				func = this._dictFontFunctions[alias];
			}else{
				func = function():ITextRenderer{
					var renderer:BitmapFontTextRenderer = createTextRenderer($font,$color,$size,$style,$align,$batch,$forced) as BitmapFontTextRenderer;
					var selectedFormat:BitmapFontTextFormat = getBMFontFormat($font,$selectedColor,$size,$style,$align,$forced);
					renderer.setTextFormatForState(ButtonState.UP_AND_SELECTED,selectedFormat);
					renderer.setTextFormatForState(ButtonState.DOWN_AND_SELECTED,selectedFormat);
					renderer.setTextFormatForState(ButtonState.HOVER_AND_SELECTED,selectedFormat);
					return renderer;		
				}
				this._dictFontFunctions[alias] = func;
			}
			
			return func;
		}
		
		
		
		
		
		
		
		
	}
}