package  Creeps
{
	import flash.display.Sprite;
	import flash.geom.Point;
	import Projectiles.Projectile;
	import UI.*;

	public class Creep extends Sprite
	{
		public var speed:Number;	

		public var health:Number;
		public var reachedEnd:Boolean = false;	
		public var reward:int;
		
		private var dir:Point = new Point();
		private var currWp:int = 0;		
		private var healthText:SubText = new SubText();
		private var burnTime:int = 40;
		private var currentBurnTime:int = 0;
		private var burnDamage:Number;
		public var position:Point = new Point();
		
		public function Creep(level:Number,hlth:int=40,rwrd:int=20,spd:Number=2) 
		{
			speed = spd;
			health = hlth;
			reward = rwrd;
			health *= level;
			reward = (health * 0.3) * 0.6;
			draw();
			this.x = Path.wayPoints[0].x;
			this.y = Path.wayPoints[0].y;
			turnToNextWp();	
			addChild(healthText);
			
			alterHealth(0);
		}
		public function isDead():Boolean
		{
			return int(health) <= 0;
		}
		public function alterHealth(mod:Number):void
		{
			health += mod;
			healthText.setText(String(int(health)));
			healthText.x = (Constants.MAIN_BSIZE ) - (healthText.width );			
			healthText.y = (Constants.MAIN_BSIZE ) - (healthText.height);
		}
		private function draw():void
		{	
			this.graphics.beginBitmapFill(Assets.creeps[0].bitmapData);
			this.graphics.drawRect( 0, 0, Constants.MAIN_BSIZE, Constants.MAIN_BSIZE);
			this.graphics.endFill();
			this.mouseEnabled = false;		
		}
		public function setOnFire(dmg:Number):void
		{
			burnDamage = dmg;
			currentBurnTime = burnTime;
		}
		public function step():void
		{
			this.x += speed * dir.x;
			this.y += speed * dir.y;
			position= new Point(x, y);
			if (currentBurnTime > 0)
			{
				currentBurnTime--;
				alterHealth( -burnDamage);
			}
			
			if (distToNextWp() < speed)
			{
				if (currWp == Path.wayPoints.length-1)
					reachedEnd = true;
				else
				{
					turnToNextWp();	
				}
			}
		}
		
		private function distToNextWp():Number
		{
			return Math.abs(Path.wayPoints[currWp].x - this.x) + Math.abs(Path.wayPoints[currWp].y - this.y);
		}
		
		private function turnToNextWp():void
		{	
			currWp++;
			dir.x = Path.wayPoints[currWp].x - this.x;
			dir.y = Path.wayPoints[currWp].y - this.y;
			dir.normalize(1);
			//this.rotation = (Math.atan2(dir.x, dir.y) / Math.PI * 180) * -1;			
		
		}
		public function handleHit(pr:Projectile):void
		{
			if (hitTestObject(pr))
			{				
				switch(pr.type)
				{
					case "bullet":alterHealth( -pr.damage);pr.shouldBeRemoved = true; break;
					case "flame": setOnFire(pr.damage); break;
				}
			}
		}
		
		
	}

}