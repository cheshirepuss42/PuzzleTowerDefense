package Projectiles 
{
	import flash.filters.BlurFilter;
	import flash.geom.Point;

	public class Flame extends Projectile
	{
		public var burnTime:int =20;
	
		public function Flame(src:Point,rng:int,dmg:Number) 
		{
			super(src, rng, dmg);
			type = "flame";
			Assets.soundLash();
		}
		override public function draw():void 
		{
			this.graphics.beginFill(0xff0000, 1);
			this.graphics.drawCircle(0, 0, Constants.MAIN_BSIZE/4);
			this.graphics.endFill();			
			this.graphics.beginFill(0xffff00, 0.1);
			this.graphics.drawCircle(0, 0, range-Constants.MAIN_BSIZE/4);
			this.graphics.endFill();
			this.graphics.beginFill(0xff0000, 0.2);
			this.graphics.drawCircle(0, 0, range);
			this.graphics.endFill();	
		}
		override public function step():void 
		{			
			burnTime--;
			if (burnTime <= 0)
				shouldBeRemoved = true;
		}		
	}
}