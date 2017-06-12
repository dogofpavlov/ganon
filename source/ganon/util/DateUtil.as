package ganon.util
{
	public class DateUtil
	{
		
		public static const MONTHS:Array = [
			{abbr:"Jan", full:"January", days:31},
			{abbr:"Feb", full:"February", days:28},
			{abbr:"Mar", full:"March", days:31},
			{abbr:"Apr", full:"April", days:30},
			{abbr:"May", full:"May", days:31},
			{abbr:"Jun", full:"June", days:30},
			{abbr:"Jul", full:"July", days:31},
			{abbr:"Aug", full:"August", days:31},
			{abbr:"Sep", full:"September", days:30},
			{abbr:"Oct", full:"October", days:31},
			{abbr:"Nov", full:"November", days:30},
			{abbr:"Dec", full:"December", days:31}
		];
		
		public static const DOTW:Array = [
			{abbr:"Mon", full:"Monday"},
			{abbr:"Tue", full:"Tuesday"},
			{abbr:"Wed", full:"Wednesday"},
			{abbr:"Thu", full:"Thursday"},
			{abbr:"Fri", full:"Friday"},
			{abbr:"Sat", full:"Saturday"},
			{abbr:"Sun", full:"Sunday"},
			
		];
		
		public function DateUtil()
		{
		}
		
		public static function formatTimerHMS($seconds:Number, $hours:Boolean=true, $smartSmall:Boolean=true):String{
			var strTimer:String = "";
			
			var numTime:Number = $seconds;
			
			var s:Number = numTime % 60;
			var m:Number = Math.floor((numTime % 3600 ) / 60);
			var h:Number = Math.floor(numTime / (60 * 60));
			
			var strHour:String;
			var strMin:String;
			var strSecond:String;
			if($smartSmall){
				strHour= h+":";
				strMin= ((m<10)?("0"+m):m)+":";
				strSecond= (s<10)?("0"+s):s+"";
				
			}else{
				strHour= ((h<10)?("0"+h):h)+":";
				strMin= ((m<10)?("0"+m):m)+":";
				strSecond= (s<10)?("0"+s):s+"";
				
			}
			
			if($hours){
				if($smartSmall && h==0){
					
					strTimer = strMin+strSecond;					
				}else{					
					strTimer = strHour+strMin+strSecond;
				}
			}else{
				strTimer = strMin+strSecond;
			}
			
			return strTimer;
		}
		public static function formatDateHM($date:Date, $ampm:Boolean=true, $military:Boolean=false):String{
			
			
			var strAMPM:String = "";
			var numHour:Number = $date.hours;
			if($ampm){
				if(numHour>=12){
					strAMPM="PM";
				}else{
					strAMPM="AM";
				}
			}
			
			var numMin:Number = $date.minutes;
			
			if(!$military){
				if(numHour>=12){
					numHour-=12;
				}
				if(numHour==0){
					numHour=12;
				}
			}
			
			var strHour:String;
			if($military){
				strHour= (numHour<10)?"0"+numHour:numHour+"";
			}else{
				strHour= (numHour<10)?""+numHour:numHour+"";
			}
			
			var strMin:String = (numMin<10)?"0"+numMin:numMin+"";
			
			
			var strRet:String = strHour+":"+strMin+strAMPM;
			
			
			return strRet;
		}
		public static function formatDateHMS($date:Date, $ampm:Boolean=true, $military:Boolean=false):String{
			
			
			var strAMPM:String = "";
			var numHour:Number = $date.hours;
			if($ampm){
				if(numHour>=12){
					strAMPM="PM";
				}else{
					strAMPM="AM";
				}
			}
			
			var numMin:Number = $date.minutes;
			var numSec:Number = $date.seconds;
			
			if(!$military){
				if(numHour>=12){
					numHour-=12;
				}
				if(numHour==0){
					numHour=12;
				}
			}
			
			var strHour:String = (numHour<10)?"0"+numHour:numHour+"";
			var strMin:String = (numMin<10)?"0"+numMin:numMin+"";
			var strSec:String = (numSec<10)?"0"+numSec:numSec+"";
			
			
			var strRet:String = strHour+":"+strMin+":"+strSec+strAMPM;
			
			
			return strRet;
		}
		
		public static function formatDateMDY($date:Date, $abbrMonth:Boolean=true, $dotw:Boolean=true, $abbrdotw:Boolean=true, $includeYear:Boolean=true):String{
			
			var numMonth:Number = $date.month+1;
			var numDay:Number = $date.date;
			var numYear:Number = $date.fullYear;
			
			var strMonth:String = $abbrMonth?MONTHS[$date.month].abbr:MONTHS[$date.month].full;
			
			var strRet:String;
			if($dotw){
				var strDOTW:String = $abbrdotw?DOTW[$date.day].abbr:DOTW[$date.day].full;
				strRet = strDOTW+" "+strMonth+" "+numDay;
			}else{
				strRet = strMonth+" "+numDay;
			}
			
			if($includeYear){
				strRet+=", "+numYear;
			}
			
			
			return strRet;
		}
		
	}
}