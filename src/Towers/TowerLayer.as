package Towers 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.geom.Point;
	import Towers.*;

	//make seperate rangeLayer to not paint over towers
	//make towers selectable (for upgrade, selling)
	
	public class TowerLayer extends Sprite
	{
		public var towers:Vector.<Tower> = new Vector.<Tower>();
		private var towerLayer:Sprite = new Sprite();
	
		public function TowerLayer() 
		{
			this.mouseChildren = this.mouseEnabled = false;			
			addChild(towerLayer);
		}
		public function clear():void
		{
			while (towers.length > 0)
			{
				towerLayer.removeChild(towers[0]);
				towers.splice(0, 1);				
			}
		}
		public function placeTower(pos:Point,type:Class):void
		{			
			var t:Tower = new type();
			t.x = (pos.x-0.5) * Constants.MAIN_BSIZE;
			t.y = (pos.y-0.5) * Constants.MAIN_BSIZE;
			towerLayer.addChild(t);
			towers.push(t);
			//trace("tower placed...");
		}
		public function step():void
		{
			for (var i:int = 0; i < towers.length; i++) 
			{
				towers[i].step();
			}
		}
		
	}

}