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
		
		public function ImageRect($image:Image, $autosize:Boolean=true)
		{
			super();
			this._img = $image;
			this.backgroundSkin = $image;
			
			this._origW = $image.width;
			this._origH = $image.height;
			
			
			if($autosize){
				this.width = this._origW;
				this.height = this._origH;
			}
		}
		
		public function changeTexture($texture:Texture, $andSize:Boolean=true):void{
			this._img.texture = $texture;
			this.backgroundSkin = this._img;
			
			this._origW = this._img.width;
			this._origH = this._img.height;
			if($andSize){
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