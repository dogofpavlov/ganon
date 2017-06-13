package ganon.fonts
{
	import flash.utils.Dictionary;

	public class GanonFont
	{
		private var _strName:String;
		private var _vecSizes:Vector.<Number>;
		private var _vecStyles:Vector.<String>;
		private var _dictColors:Dictionary;
		
		public function GanonFont($name:String)
		{
			this._strName = $name;
			this._vecSizes = new Vector.<Number>();
			this._vecStyles = new Vector.<String>();
			this._dictColors = new Dictionary();
			
		}
		
		
		public function addSize($number:Number):void{
			this._vecSizes.push($number);
		}
		public function addStyle($style:String):void{
			this._vecStyles.push($style);
		}
		public function addColor($name:String, $color:uint):void{
			this._dictColors[$name] = $color;
		}
		
		public function getColor($name:String):uint{
			return this._dictColors[$name];
		}
		
		/** Returns the closest size added to the item**/
		public function getSize($number,$forced:Boolean=false):Number{
			
			var numClosestID:int = 0;
			
			var numClosest:Number;
			
			var numDiff:Number;
			var numClosestDiffDuringLoop:Number = Math.abs(this._vecSizes[0]-$number);
			var numLen:int = this._vecSizes.length;
			
			for(var i:int=1; i<numLen; i++){ //start index 1
				numDiff = Math.abs(this._vecSizes[i]-$number);
				if(numDiff<numClosestDiffDuringLoop){
					numClosestID = i;
					numClosestDiffDuringLoop = numDiff;
				}
			}
			
		
			
			
			return this._vecSizes[numClosestID];
		}
		
		
		public function get name():String{
			return this._strName;
		}
		public function get sizes():Vector.<Number>{
			return this._vecSizes;
		}
		public function get styles():Vector.<String>{
			return this._vecStyles;
		}
	}
}