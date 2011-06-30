package com.thesven.ledboard {
	import com.thesven.ledboard.characters.CharacterMatrix;
	import com.thesven.ledboard.characters.ICharacterList;
	import com.thesven.ledboard.leds.BaseLED;

	import flash.display.Sprite;

	/**
	 * @author michaelsvendsen
	 */
	public class LEDBoard extends Sprite {
		
		private var _width:int;
		private var _height:int;
		private var _charWidth:int;
		private var _charHeight:int;
		private var _charClass:Class;
		private var _singleLEDRadius:Number;
		private var _singleLEDSpacing:Number;
		private var _inactiveLEDColor:uint;
		private var _activeLEDColor:uint;
		
		private var characterList:ICharacterList;
		private var displayString:String;
		
		private var ledContainer:Sprite;
		private var leds : Vector.<Vector.<BaseLED>>;
		private var rowSize : int;
		private var columnSize : Number;
		private var charsToUse:Vector.<CharacterMatrix>;
		private var currentStartRow:int;
		private var wordLength:int;
		
		public function LEDBoard(boardWidth:int, boardHeight:int, letterWidth:int, letterHeight:int, letterClass:Class, ledRadius:Number, ledSpacing:Number, ledInactiveColor:uint = 0xFFFFFF, ledActiveColor:uint = 0xFF0000) {
			
			super();
			
			_width = boardWidth;
			_height = boardHeight;
			_charWidth = letterWidth;
			_charHeight = letterHeight;
			_charClass = letterClass;
			_singleLEDRadius = ledRadius;
			_singleLEDSpacing = ledSpacing;
			_inactiveLEDColor = ledInactiveColor;
			_activeLEDColor = ledActiveColor;
			
			init();
			
		}

		public function setDisplayString(value:String):void{
			
			displayString = value;
			wordLength =displayString.length;
			currentStartRow = columnSize;
			charsToUse = new Vector.<CharacterMatrix>(displayString.length, true);
			var i:int = 0;
			for(i; i < wordLength; i++){
				charsToUse[i] = setCharacter(String(displayString.charAt(i)).toUpperCase());
			}
			
		}
		
		public function advance():void{
			
			makeGridInactive();
			var count:int = 0;
			var isFirst:Boolean = true;
			for each(var charMat:CharacterMatrix in charsToUse){
				var toAdd:int = (isFirst) ? 0 : 1;
				toAdd *= count;
				applyCharacterMatrixAtPosition(charMat, (count * _charWidth) + currentStartRow + toAdd);
				count += 1;
				if(isFirst == true) isFirst = false;
			}
			currentStartRow -= 1;
			if(currentStartRow > columnSize) currentStartRow = columnSize;
			if(currentStartRow < -((wordLength * _charWidth) + wordLength) ) currentStartRow = columnSize;
				
		}

		protected function init():void{
		
			characterList = new _charClass();
			
			ledContainer = new Sprite();
			addChild(ledContainer);
			
			setupDisplayGrid();
			
		}
		
		//lays out in rows
		protected function setupDisplayGrid():void{
			
			var singlePixelWidth:Number = (_singleLEDRadius * 2) + (_singleLEDSpacing - (_singleLEDRadius * 2));
			columnSize = Math.floor(_width / singlePixelWidth);
			rowSize = _charHeight;
			var ledCount:int = columnSize * rowSize;
			
			leds = new Vector.<Vector.<BaseLED>>(ledCount, true);
			//build the vectors to store the pixels in by column
			var buildCount:int = 0;
			for(buildCount; buildCount < columnSize; buildCount ++){
				leds[buildCount] = new Vector.<BaseLED>(rowSize, true);
			}
			
			var i:int = 0;
			for(i; i < ledCount; i++){
				
				var led:BaseLED = new BaseLED(_singleLEDRadius, _inactiveLEDColor, _activeLEDColor);
				var ledYMath:int = Math.floor(i / columnSize);
				var ledXMath:int = i - ledYMath * columnSize;
				led.y = ledYMath * _singleLEDSpacing;
				led.x = ledXMath * _singleLEDSpacing;
				led.setInactive();
				ledContainer.addChild(led);
				
				leds[ledXMath][ledYMath] = led;
				
			}
			
		}
		
		protected function setCharacter(character:String):CharacterMatrix{
			var charArr:Vector.<int> = characterList.getCharacter(character);
			var charMat:CharacterMatrix = createCharacterMatrix(charArr);
			return charMat;
		}

		protected function applyCharacterMatrixAtPosition(charMat:CharacterMatrix, startCol:int) : void {
			
			for(var i:int = 0; i < charMat.data.length; i++){
				for(var k:int = 0; k < _charHeight; k++){
					if(i+startCol >=0 && i+startCol < columnSize){
						if(charMat.data[i][k] == 1){
						 	leds[i + startCol][k].setActive();
						}
					}
				}
			}
		
		}
		
		protected function createCharacterMatrix(charData:Vector.<int>):CharacterMatrix{
			
			var charMat:CharacterMatrix = new CharacterMatrix(_charWidth, _charHeight);
			
			var i:int = 0;
			var count:int = 0;
			for(i; i < charData.length; i++){
				
				var row:int = Math.floor(i / _charWidth);
				var col:int = i - row * _charWidth;
				charMat.data[col][row] = charData[count];
				count += 1;
			}
			
			return charMat;
		}
		
		protected function makeGridInactive():void{
			
			for each(var v:Vector.<BaseLED> in leds){
				for each(var b:BaseLED in v){
					b.setInactive();
				}
			}
			
		}
		
		
	}
}
