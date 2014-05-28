package Puzzle 
{
	import flash.display.Sprite;
	import flash.events.*;
	import flash.geom.Point;
	/**
	 * ...
	 * @author 
	 */
	public class Puzzle extends Sprite
	{
		public var bl:Blocks = new Blocks(10, 10,19);
		private var synth:SfxrSynth;
		private var total:int = 0;		
		public function Puzzle() 
		{
			addChild(bl.getView());
			//stage.addEventListener(KeyboardEvent.KEY_DOWN, kdown);
			addEventListener(MouseEvent.CLICK, click);
			synth = new SfxrSynth();
			synth.masterVolume = 0.2;
			//synth.minFrequency
			bl.addEventListener("LastShapeRemoved", lsr);
			bl.addEventListener("ShapeRemoved", sr);
			bl.addEventListener("WrongClick", wc);
			//SfxrGenerator.generateLaserShoot(synth);			
		}
		private function click(e:MouseEvent):void
		{
			var p:Point = new Point(int(e.localX / bl.getSize()), int(e.localY / bl..getSize()));
			bl.handlePoint(p);
			while (numChildren > 0)removeChildAt(0);
			addChild(bl.getView());
			//trace
			//trace(p);
			//trace("score", bl.getScore());
			//var mem:String = Number( System.totalMemory / 1024 / 1024 ).toFixed( 2 ) + "Mb";
			//trace( mem ); // eg traces “24.94Mb”

			
		}	
		private function lsr(e:Event):void
		{
			SfxrGenerator.generatePowerup(synth);
			synth.play();
			//total += 5;
			
		}
		private function wc(e:Event):void
		{
			SfxrGenerator.generateHitHurt(synth);
			synth.play();
			//total -= 5;
			//trace("score",total);
		}		
		private function sr(e:Event):void
		{
			SfxrGenerator.generatePickupCoin(synth);
			synth.play();
			//total += bl.reward - 3;
			//trace("score",total);
		}		
	}

}