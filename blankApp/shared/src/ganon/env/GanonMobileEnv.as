package ganon.env
{
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	public class GanonMobileEnv extends GanonAIREnv
	{
		public function GanonMobileEnv($root:Sprite, $config:GanonEnvConfig)
		{
			super($root,$config);
			
			//Listen for Keydown for Android Back Button
			this.stage.addEventListener(KeyboardEvent.KEY_DOWN, this._onKeyDown);
		}
		/**
		 * Override to use android Back
		 */
		public function androidBack():void{
			
		}
		
		/*
		Event Handlers
		*/
		private function _onKeyDown($event:KeyboardEvent):void{
			
			switch($event.keyCode){
				case Keyboard.BACK:
					this.androidBack();
					break;
			}
		}
	}
}