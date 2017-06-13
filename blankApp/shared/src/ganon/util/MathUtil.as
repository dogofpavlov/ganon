package ganon.util
{
	import flash.geom.Point;

	public class MathUtil
	{
		public static const EARTH_RADIUS_METERS:Number = 6379100;
		public static const DEG_2_RAD:Number = 0.0174533;
		public static const RAD_2_DEG:Number = 57.2958;
			
		
		public static function MPS_2_MPH($meters):Number{
			return $meters*2.23694;
		}
		
		public static function BEARING_2_DIR($bearing:Number):String{
			var dir:String = "";
			
			if ($bearing >= 0 && $bearing <= 11.25) dir = "N";
			if ($bearing > 348.75 && $bearing <= 360) dir = "N";
			if ($bearing > 11.25 && $bearing <= 33.75) dir = "NNE";
			if ($bearing > 33.75 && $bearing <= 56.25) dir = "NE";
			if ($bearing > 56.25 && $bearing <= 78.75) dir = "ENE";
			if ($bearing > 78.75 && $bearing <= 101.25) dir = "E";
			if ($bearing > 101.25 && $bearing <= 123.75) dir = "ESE";
			if ($bearing > 123.75 && $bearing <= 146.25) dir = "SE";
			if ($bearing > 146.25 && $bearing <= 168.75) dir = "SSE";
			if ($bearing > 168.75 && $bearing <= 191.25) dir = "S";
			if ($bearing > 191.25 && $bearing <= 213.75) dir = "SSW";
			if ($bearing > 213.75 && $bearing <= 236.25) dir = "SW";
			if ($bearing > 236.25 && $bearing <= 258.75) dir = "WSW";
			if ($bearing > 258.75 && $bearing <= 281.25) dir = "W";
			if ($bearing > 281.25 && $bearing <= 303.75) dir = "WNW";
			if ($bearing > 303.75 && $bearing <= 326.25) dir = "NW";
			if ($bearing > 326.25 && $bearing <= 348.75) dir = "NNW";
			
			return dir;
		}
		
		public static function distanceBetween2LatLon($lat:Number, $lon:Number, $lat2:Number, $lon2:Number):Number{
			var numDistance:Number;
			
			var numSinLatDist:Number = Math.sin(($lat-$lat2)*DEG_2_RAD);
			var numSinLonDist:Number = Math.sin(($lon-$lon2)*DEG_2_RAD);
			var numCosLat1:Number = Math.cos($lat*DEG_2_RAD);
			var numCosLat2:Number = Math.cos($lat2*DEG_2_RAD);
			var numA:Number = (numSinLatDist/2)*(numSinLatDist/2)+numCosLat1*numCosLat2*(numSinLonDist/2)*(numSinLonDist/2)
			if(numA<0)numA = -1*numA;
			var numC:Number = 2*Math.atan2(Math.sqrt(numA),Math.sqrt(1-numA));
			
			numDistance = EARTH_RADIUS_METERS*numC;
			
			return numDistance;
		}
		public static function destinationFromLatLon($lat:Number, $lon:Number, $distance:Number, $bearing:Number):Point{

			var δ:Number = $distance/EARTH_RADIUS_METERS; // angular distance in radians
			var θ:Number = $bearing*DEG_2_RAD;
			
			var φ1:Number = $lat*DEG_2_RAD;
			var λ1:Number = $lon*DEG_2_RAD;
			
			var sinφ1:Number = Math.sin(φ1), cosφ1:Number = Math.cos(φ1);
			var sinδ:Number = Math.sin(δ), cosδ:Number = Math.cos(δ);
			var sinθ:Number = Math.sin(θ), cosθ:Number = Math.cos(θ);
			
			var sinφ2:Number = sinφ1*cosδ + cosφ1*sinδ*cosθ;
			var φ2:Number = Math.asin(sinφ2);
			var y:Number = sinθ * sinδ * cosφ1;
			var x:Number = cosδ - sinφ1 * sinφ2;
			var λ2:Number = λ1 + Math.atan2(y, x);
			
			
			return new Point(φ2*RAD_2_DEG, ((λ2*RAD_2_DEG)+540)%360-180);
			
			
			
		}
		
		
		
		public static function bearingTo($fromLat:Number, $fromLon:Number, $toLat:Number, $toLon:Number):Number{
			
			var numFromLatRad:Number = $fromLat*DEG_2_RAD;
			var numToLatRad:Number = $toLat*DEG_2_RAD;
			
			var numDiffLonRad:Number = ($toLon-$fromLon)*DEG_2_RAD;
			
			var numY:Number = Math.sin(numDiffLonRad)*Math.cos(numToLatRad);
			var numX:Number = Math.cos(numFromLatRad)*Math.sin(numToLatRad)-Math.sin(numFromLatRad)*Math.cos(numToLatRad)*Math.cos(numDiffLonRad);
			
			var numAng:Number = Math.atan2(numY,numX);
			
			return ((numAng*RAD_2_DEG)+360)%360;
			
		}
		
		public function MathUtil()
		{
		}
	}
}