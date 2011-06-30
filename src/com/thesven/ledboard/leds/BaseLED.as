package com.thesven.ledboard.leds {
	import flash.display.Graphics;
	import flash.display.Sprite;

	/**
	 * @author michaelsvendsen
	 */
	public class BaseLED extends Sprite {
		
		private var _radius:Number;
		private var activeColor:uint;
		private var inactiveColor:uint;
		private var graph:Graphics;
		
		public function BaseLED(ledRadius:Number, ledInactiveColor:uint, ledActiveColor:uint) {
		
			super();
			
			_radius = ledRadius;
			activeColor = ledActiveColor;
			inactiveColor = ledInactiveColor;
			graph = this.graphics;
			
		}
		
		public function get radius():Number{
			return _radius;
		}
		
		public function setInactive():void{
			drawCircle(inactiveColor);
		}
		
		public function setActive():void{
			drawCircle(activeColor);
		}
		
		protected function drawCircle(color:uint):void{
			
			graph.clear();
			graph.beginFill(color, 1);
			graph.drawCircle(_radius, _radius, _radius);
			graph.endFill();
			
		}
		
	}
}
