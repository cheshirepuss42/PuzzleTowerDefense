package Projectiles 
{
	import flash.display.Sprite;
	import flash.geom.Point;

	public class Projectile extends Sprite
	{	
		public var shouldBeRemoved:Boolean = false;
		public var damage:Number;
		public var range:int;
		public var source:Point;
		public var type:String;
		
		public function Projectile(src:Point,rng:int,dmg:Number) 
		{
			source = src;
			this.x = src.x;
			this.y = src.y;
			range = rng;
			damage = dmg;
			draw();
		}
		public function draw():void
		{
			trace("override draw on projectile");
		}
		public function step():void
		{
			trace("override step on projectile");
		}		
	}
}