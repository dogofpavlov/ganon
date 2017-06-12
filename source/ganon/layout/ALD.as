package ganon.layout
{
	import feathers.layout.AnchorLayoutData;
	
	import starling.display.DisplayObject;
	
	public class ALD extends AnchorLayoutData
	{
		/**
		 * Use this to instead of having to create an Anchor Layout Data variable first and then set the anchor display objects...all in one go
		 */
		public function ALD($top:Number=NaN, $right:Number=NaN, $bottom:Number=NaN, $left:Number=NaN, $horizontalCenter:Number=NaN, $verticalCenter:Number=NaN, $topD:DisplayObject=null,$rightD:DisplayObject=null,$botD:DisplayObject=null,$leftD:DisplayObject=null)
		{
			super($top, $right, $bottom, $left, $horizontalCenter, $verticalCenter);
			this.topAnchorDisplayObject = $topD;
			this.rightAnchorDisplayObject = $rightD;
			this.bottomAnchorDisplayObject = $botD;
			this.leftAnchorDisplayObject = $leftD;
		}
	}
}