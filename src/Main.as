package {
	import net.hires.debug.Stats;

	import com.thesven.ledboard.LEDBoard;
	import com.thesven.ledboard.characters.SixBySevenCharacterList;

	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	/**
	 * @author michaelsvendsen
	 */
	 [SWF(backgroundColor="#000000", frameRate="31", width="1000", height="72")]
	public class Main extends Sprite {
		
		private var board:LEDBoard;
		private var timer:Timer;
		
		public function Main() {
		
			board = new LEDBoard(1000, 72, 7, 6, SixBySevenCharacterList, 5, 12, 0xFFFFFF, 0xF0000FF);
			board.setDisplayString("blue jays game");
			addChild(board);
			
			timer = new Timer(81.25)	;
			timer.addEventListener(TimerEvent.TIMER, onTimerTick);
			timer.start();
			
			addChild(new Stats());
				
		}
		
		private function onTimerTick(e:TimerEvent):void{
			
			board.advance();
			
		}

		
	}
}
