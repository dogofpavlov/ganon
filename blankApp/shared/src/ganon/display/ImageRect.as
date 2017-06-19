package ganon.display
{
	import feathers.controls.LayoutGroup;
	
	import starling.display.Image;
	import starling.textures.Texture;
	
	public class ImageRect extends LayoutGroup
	{
		
		private var _img:Image;
		private var _origW:Number;
		private var _origH:Number;
		
		public function ImageRect($texture:Texture, $autosize:Boolean=true)
		{
			super();
			this.changeTexture($texture,$autosize);
		}
		
		public function changeTexture($texture:Texture, $autoSize:Boolean=true):void{
			this._img = new Image($texture);
			this.backgroundSkin = this._img;
			
			this._origW = this._img.width;
			this._origH = this._img.height;
			if($autoSize){
				this.width = this._origW;
				this.height = this._origH;				
			}
		}
		
		
		
		public function relativeScale($scale:Number):void{
			this.width = Math.round(this._origW*$scale);
			this.height = Math.round(this._origH*$scale);
		}
	}
}