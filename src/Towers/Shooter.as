package Towers 
{
	import flash.geom.Point;
	import Projectiles.*;
	import Creeps.*;
	
	public class Shooter extends Tower
	{
		
		public function Shooter() 
		{
			super();
			cost = Constants.COST_SHOOTER;
			fireDelay = Constants.COOLDOWN_SHOOTER;
		}
		override public function reactToCreep(cr:Creep):Projectile
		{					
			if(!hasFired && inRange(cr))
			{
				hasFired = true;
				Assets.soundFire();
				return new Bullet(new Point(x+Constants.MAIN_HALFBSIZE,y+Constants.MAIN_HALFBSIZE),new Point(cr.x+Constants.MAIN_HALFBSIZE,cr.y+Constants.MAIN_HALFBSIZE),range,damage,5.5);
			}
			return null;
		}		
	}

}