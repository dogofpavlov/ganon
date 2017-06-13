package com.blankapp.assets
{
	import com.blankapp.fonts.BlankFontManager;
	import com.blankapp.view.BlankRoot;
	
	import flash.display.Bitmap;
	
	import ganon.assets.GanonAssets;
	
	import starling.core.Starling;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	public class BlankAssets extends GanonAssets
	{
		
		[Embed(source="/embededui.png")]
		public static const embededui_png:Class;		
		[Embed(source="/embededui.xml", mimeType="application/octet-stream")]
		public static const embededui_xml:Class;
		
		
		public static function getTexture($textureID:String):Texture{
			return assets.getTexture($textureID);	
		}		
		
		public static function get assets():BlankAssets{
			return (Starling.current.root as BlankRoot).assets as BlankAssets;			
		}		
		public static function get fonts():BlankFontManager{
			return (Starling.current.root as BlankRoot).assets.fonts as BlankFontManager;
		}
		
		public function BlankAssets()
		{
			super();
			this._assetManager.addTextureAtlas("embededui",new TextureAtlas(Texture.fromBitmap(new embededui_png() as Bitmap) ,XML(new embededui_xml())));
		}
		
		override protected function _assetsReady():void{
			super._assetsReady();
			
			this._setupFontManager(new BlankFontManager());
		}
		
		/*
		public function vertScrollbarBlack():IScrollBar{
			
			var scrollbar:SimpleScrollBar = new SimpleScrollBar();
			scrollbar.thumbFactory = function():Button{
				
				var skin:ImageSkin = new ImageSkin(getTexture("scrollbar"));
				skin.color= 0x000000;
				skin.scale9Grid = rectScrollBar;
				var but:Button = new Button();
				but.defaultSkin = skin;
				return but;
			};
			
			return scrollbar;
		}*/
		
		
		
		/*
		COLORS
		*/
		
		public function get colorWhite():Texture{
			return this.getTexture("color-white");
		}
		public function get colorBlack():Texture{
			return this.getTexture("color-black");
		}
		
		/*
		RECTANGLES
		*/
		/*
		public function get rectScrollBar():Rectangle{
			return this._dictRectangles["scrollbar"];
		}
		*/
	}
}