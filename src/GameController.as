package  
{
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import Puzzle.Puzzle;
	import flash.events.Event;

	public class GameController extends Sprite		//this is the main controller
	{
		private var timer:Timer;
		private var field:GameField;
		private var fps:int;
		private var puzzle:Puzzle = new Puzzle();
		public function GameController() 
		{
			fps = 30;
			timer = new Timer(1000 / fps);
			timer.addEventListener(TimerEvent.TIMER, timeStep);
			Assets.loadAssets();
			field = new GameField();
			field.x += 10;
			field.y += 10;
			addChild(field);
			puzzle.y += 300;
			field.sideBar.addChild(puzzle);
			startGame();
			puzzle.bl.addEventListener("LastShapeRemoved", lsr);
			puzzle.bl.addEventListener("ShapeRemoved", sr);
			puzzle.bl.addEventListener("WrongClick", wc);			
		}
		public function startGame():void
		{
			timer.start();
			puzzle.bl.init();
		}
		public function gameLose():void
		{
			timer.stop();
		}
		public function levelWin():void
		{
			timer.stop()
		}		
		private function timeStep(e:TimerEvent):void
		{
			field.step(timer.currentCount);
			if (field.gameOver)
			{
				gameLose();
			}
			
		}
		private function lsr(e:Event):void
		{
			//SfxrGenerator.generatePowerup(synth);
			//synth.play();
			field.sideBar.alterResources(puzzle.bl.getScore());
			//total += 5;
			
		}
		private function wc(e:Event):void
		{
			//SfxrGenerator.generateHitHurt(synth);
			//synth.play();
			field.sideBar.alterResources(puzzle.bl.getScore());
			//total -= 5;
			//trace("score",total);
		}		
		private function sr(e:Event):void
		{
			//SfxrGenerator.generatePickupCoin(synth);
			//synth.play();
			field.sideBar.alterResources(puzzle.bl.getScore());
			//total += bl.reward - 3;
			//trace("score",total);
		}		
		
	}

}