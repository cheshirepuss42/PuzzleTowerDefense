package Towers
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import Creeps.*;
	import Projectiles.Projectile;
	
	public class Tower extends Sprite
	{
		public var damage:Number;
		public var range:Number;
		public var fireDelay:int;
		public var currentCoolDown:int = 0;
		public var hasFired:Boolean = false;
		public var cost:int = 45;
		
		public function Tower(dmg:Number=5,rng:Number=2.5) 
		{
			range = (rng * Constants.MAIN_BSIZE)-1;
			damage = dmg;
			draw();
			this.addEventListener(MouseEvent.CLICK, click);
		}
		private function click(e:Event):void
		{
			
		}
		public function draw():void
		{
			graphics.beginFill(0xffff00, 0.00);
			graphics.drawCircle(x + Constants.MAIN_HALFBSIZE, y +  Constants.MAIN_HALFBSIZE, range);
			graphics.endFill();	
			graphics.beginBitmapFill(Assets.towers[0].bitmapData, null, false);
			graphics.drawRect( 0, 0, Constants.MAIN_BSIZE, Constants.MAIN_BSIZE);
			graphics.endFill();	
		}
		public function rangeView():Sprite
		{			
			var rview:Sprite = new Sprite();
			rview.graphics.beginFill(0xffff00, 0.00);
			rview.graphics.drawCircle(x + Constants.MAIN_HALFBSIZE, y +  Constants.MAIN_HALFBSIZE, range);
			rview.graphics.endFill();
			rview.mouseEnabled = false;
			return rview;
		}	
		
		public function selectionView():Sprite
		{
			var selection:Sprite = new Sprite();
			selection.graphics.beginFill(0xffffff, 0.2);
			selection.graphics.drawCircle(0, 0, range);
			selection.graphics.lineStyle(1, 0xff0000);
			selection.graphics.drawRect( -Constants.MAIN_HALFBSIZE, -Constants.MAIN_HALFBSIZE, Constants.MAIN_BSIZE, Constants.MAIN_BSIZE);
			selection.graphics.endFill();
			return selection;
		}
		
		public function step():void
		{
			if (currentCoolDown >= fireDelay)
			{
				hasFired = false;
				currentCoolDown = 0;
			}
			else if (hasFired)
				currentCoolDown++;
			
		}
		
		public function reactToCreep(cr:Creep):Projectile
		{			
			trace("override reactToCreep");
			return null;
		}
		
		public function inRange(cr:Creep):Boolean
		{
			var start:Point = new Point(Constants.MAIN_HALFBSIZE, Constants.MAIN_HALFBSIZE);
			var end:Point = new Point((cr.position.x - this.x) + Constants.MAIN_HALFBSIZE, (cr.position.y - this.y) + Constants.MAIN_HALFBSIZE);
			var between:Point = new Point(start.x - end.x, start.y - end.y);
			return between.length <= range;
			//return Math.sqrt(Math.pow(between.x, 2) + Math.pow(between.y, 2)) <= range;
		}
		public function canFire():Boolean
		{
			return !hasFired;
		}
		
		
	}

}