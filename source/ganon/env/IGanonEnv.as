package ganon.env
{
	
	import flash.display.Sprite;
	import flash.display.Stage;
	
	import starling.utils.AssetManager;
	
	
	public interface IGanonEnv
	{
		
		function initializeANEs():void;
		function addAssets($manager:AssetManager):void;
		function newNow():void;
		
		function get now():Date;
		function get stage():Stage;
		function get root():Sprite;
		function get os():String;
		function get iosVer():String;
		function get iosVer7AndAbove():Boolean;
		function get mobile():Boolean;
		function get desktop():Boolean;
		function get web():Boolean;
		function get ios():Boolean;
		function get android():Boolean;
		function get windows():Boolean;
		function get mac():Boolean;
		function get smallDevice():Boolean;
		function get config():GanonEnvConfig;
		
		function set portrait($value:Boolean):void;
		function get portrait():Boolean;
		
		function set extraDesignSpace($value:Number):void;
		function get extraDesignSpace():Number;
		
		
		function set width($value:Number):void;
		function get width():Number;
		function set height($value:Number):void;
		function get height():Number;
		
		
		function set scale($value:Number):void;
		function get scale():Number;
		function set unscale($value:Number):void;
		function get unscale():Number;
		
		function get width2():Number;
		function get height2():Number;
		
		
		function set deactivated($value:Boolean):void;
		function get deactivated():Boolean;
		
	}
}