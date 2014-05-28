package Towers 
{
	import flash.geom.Point;	
	import Projectiles.*;
	import Creeps.*;	
	public class Burner extends Tower
	{
		
		public function Burner() 
		{
			super(0.15, 3.5);
			cost = Constants.COST_BURNER;
			fireDelay = Constants.COOLDOWN_BURNER;
		}
		override public function draw():void
		{
			graphics.beginFill(0xffff00, 0.00);
			graphics.drawCircle(x + Constants.MAIN_HALFBSIZE, y +  Constants.MAIN_HALFBSIZE, range);
			graphics.endFill();	
			graphics.beginBitmapFill(Assets.towers[2].bitmapData, null, false);
			graphics.drawRect( 0, 0, Constants.MAIN_BSIZE, Constants.MAIN_BSIZE);
			graphics.endFill();	
		}
		override public function reactToCreep(cr:Creep):Projectile
		{					
			if(!hasFired && inRange(cr))
			{
				hasFired = true;
				//Assets.soundFire();
				return new Flame(new Point(x + Constants.MAIN_HALFBSIZE, y + Constants.MAIN_HALFBSIZE), range, damage);
				
			}
			return null;
		}		
	}

}