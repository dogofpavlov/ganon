package ganon.util
{
	public class FormatUtil
	{
		public function FormatUtil()
		{
		}
		public static function formatPhoneNumber($value:String):String{
			var strPN:String;
			var strP1:String;
			var strP2:String;
			var strP3:String;
			
			if($value.length==11){
				012345679,10,11
				195429881,4 ,6
				
				var strPOne:String = $value.substring(0,1);
				
				strP1 = $value.substring(1,4);
				strP2 = $value.substring(4,7);
				strP3 = $value.substring(7,11);
				
				strPN = strPOne+"-("+strP1+")-"+strP2+"-"+strP3;
				
			}else if($value.length==10){
				trace("yo");
				strP1 = $value.substring(0,3);
				strP2 = $value.substring(3,6);
				strP3 = $value.substring(6,10);
				
				strPN = "("+strP1+")-"+strP2+"-"+strP3;
			}else{
				strPN = $value;
			}
			
			return strPN;
		}
	}
}