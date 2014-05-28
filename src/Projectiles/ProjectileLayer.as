package Projectiles 
{
	import flash.display.Sprite;
	public class ProjectileLayer extends Sprite
	{
		public var projectiles:Vector.<Projectile> = new Vector.<Projectile>();
		
		public function ProjectileLayer() 
		{
			this.mouseChildren = this.mouseEnabled = false;
		}
		public function step():void
		{
			for (var i:int = 0; i < projectiles.length; i++) 
			{
				projectiles[i].step();
				if (projectiles[i].shouldBeRemoved)
					removeProjectile(i);
			}
		}
		public function addProjectile(pr:Projectile):void
		{
			//trace("adding bullet",projectiles.length);
			projectiles.push(pr);
			addChild(pr);
		}
		public function removeProjectile(i:int):void
		{
			//trace("removing bullet");
			removeChild(projectiles[i]);
			projectiles.splice(i, 1);
		}
	}

}