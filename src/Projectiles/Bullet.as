package Projectiles 
{
	import flash.geom.Point;

	public class Bullet extends Projectile
	{
		public var target:Point;
		public var hasReachedRange:Boolean = false;		
		private var dir:Point;
		private var traveled:int = 0;
		private var speed:Number;
		//public var type:String = "flame";
		public function Bullet(src:Point,trg:Point,rng:int,dmg:Number,spd:Number) 
		{			
			super(src, rng, dmg);
			type = "bullet";
			target = trg;
			speed = spd;
			range /= speed;
			dir = target.subtract(new Point(this.x, this.y));
			dir.normalize(speed);			
			
		}
		override public function draw():void
		{
			this.graphics.lineStyle(1, 0);
			this.graphics.beginFill(0xffffff);
			this.graphics.drawCircle(0, 0, 2);
			this.graphics.endFill();	
			//trace("drawing bullet",x,y,source);
		}	
		override public function step():void
		{
			this.x += dir.x;
			this.y += dir.y;
			traveled++;	
			if (traveled >= range)
				shouldBeRemoved = true;
		}		
	}

}