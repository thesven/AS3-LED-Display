package com.thesven.ledboard.characters {
	/**
	 * @author michaelsvendsen
	 */
	public class CharacterMatrix {
		
		private var cols:int;
		private var rows:int;
		public  var data:Vector.<Vector.<int>>;
		
		public function CharacterMatrix(totalColumns:int, totalRows:int){
			
			cols = totalColumns;
			rows = totalRows;
			init();
			
		}
		

		private function init() : void {
			
			data = new  Vector.<Vector.<int>>(cols, true);
			
			for(var i:int = 0; i < cols; i++){
				data[i] = new Vector.<int>(rows, true);
				for(var k:int =0; k < rows; k++){
					data[i][k] = 0;
				}
			}
			
			
		}

	}		
}
