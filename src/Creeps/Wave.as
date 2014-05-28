package Creeps
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import Creeps.*;
	import UI.*;

	public class Wave extends Sprite
	{
		public var creeps:Vector.<Creep> = new Vector.<Creep>();
		private var delay:int ;
		private var amount:int ;
		private var generated:int = 0;
		//public var waveIsGone:Boolean = false;
		private var waveLevel:Number;
		private var rewardSparks:Vector.<RewardSpark> = new Vector.<RewardSpark>();
		public function Wave(dl:int, am:int,wLevel:Number ) 
		{
			
			delay = dl;
			amount = am;
			waveLevel = wLevel;
		}
		public function step(stepCount:int):void		
		{
			if (stepCount % delay == 0 && generated < amount)
			{
				newCreep();
			}
			for (var i:int = 0; i < creeps.length; i++) 
			{
				handleCreep(i);
				
			}
			for (var j:int = 0; j < rewardSparks.length; j++) 
			{
				handleRewardSpark(j);				
			}			
			
		}
		public function clear():void
		{
			while (creeps.length > 0)
			{
				removeChild(creeps[0]);
				creeps.splice(0, 1);				
			}
			while (rewardSparks.length > 0)
			{
				removeChild(rewardSparks[0]);
				rewardSparks.splice(0, 1);				
			}
			generated = 0;
		}
		private function newCreep():void
		{
			var ncr:Creep = new Creep(waveLevel);			
			creeps.push(ncr);
			addChild(ncr);
			generated++;
		}

		private function removeCreep(i:int):void
		{			
			removeChild(creeps[i]);
			creeps.splice(i, 1);
		}
		public function waveIsGone():Boolean
		{
			return (generated == amount && creeps.length == 0 && rewardSparks.length == 0);
		}
		
		public function handleCreep(i:int):void
		{			
			if (creeps[i].reachedEnd )
			{
				removeCreep(i);
				dispatchEvent(new Event("CreepReachedEnd"));			
			}
			else if (creeps[i].isDead())
			{
				Assets.soundDeath();
				var spark:RewardSpark = new RewardSpark(new Point(creeps[i].x + Constants.MAIN_HALFBSIZE, creeps[i].y + Constants.MAIN_HALFBSIZE), creeps[i].reward);			
				rewardSparks.push(spark);
				addChild(spark);
				removeCreep(i);
			}
			else
			{
				creeps[i].step();
			}
		}
		private function handleRewardSpark(i:int):void
		{
			rewardSparks[i].step();
			if (rewardSparks[i].shouldBeRemoved)
			{
				removeChild(rewardSparks[i]);
				rewardSparks.splice(i, 1);
			}
		}
	}
}