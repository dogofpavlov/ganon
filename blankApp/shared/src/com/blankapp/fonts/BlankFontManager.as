package com.blankapp.fonts
{
	import flash.text.TextFormatAlign;
	
	import ganon.fonts.GanonFont;
	import ganon.fonts.GanonFontManager;
	
	public class BlankFontManager extends GanonFontManager
	{
		private var _strRoboto:String = "opensans";
		
		public function BlankFontManager()
		{
			super();
			
			var opensans:GanonFont = new GanonFont(this._strRoboto);
			opensans.addSize(36);
			opensans.addSize(72);
			opensans.addStyle("semibold");			
			opensans.addColor("black",0x000000);
			opensans.addColor("white",0xFFFFFF);
			this.addFontItem(opensans);
		}
		
		public function black($size:Number, $align:String=TextFormatAlign.LEFT, $forced:Boolean=false):Function{
			return this.getFont(this._strRoboto,"black",$size,"",$align,true,$forced);
		}
		public function white($size:Number, $align:String=TextFormatAlign.LEFT, $forced:Boolean=false):Function{
			return this.getFont(this._strRoboto,"white",$size,"",$align,true,$forced);
		}
	}
}