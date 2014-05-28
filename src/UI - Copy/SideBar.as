package UI 
{
	import flash.display.Sprite;
	import flash.events.*;
	public class SideBar extends Sprite
	{
		private var resourcesLabel:TextLabel;
		private var livesLabel:TextLabel;
		public var startButton:Button;
		private var tsb:TowerSelectionBox = new TowerSelectionBox();
		private var lives:int;
		private var resources:int;
		private var nextWave:NextWaveMeter;
		
		public function SideBar() 
		{
			nextWave = new NextWaveMeter(Constants.WAVE_STARTTIME);
			//nextWave.addEventListener("NEW_WAVE", nextWave);
			startButton = new Button(150, 50, "Reset", 3, 0);
			
			lives = Constants.MAIN_STARTLIVES;
			resources = Constants.MAIN_STARTENERGY;
			this.x -= Constants.MAIN_HALFBSIZE;
			this.y -= Constants.MAIN_HALFBSIZE;
			this.graphics.beginFill(0xeeeeee);
			this.graphics.drawRect(0, 0, 200, 600);
			this.graphics.endFill();
			livesLabel = new TextLabel(120, 30, "lives: " + String(lives), 5);
			resourcesLabel = new TextLabel(120, 30, "resources: " + String(resources), 5);
			resourcesLabel.y = livesLabel.h;
			tsb.y = livesLabel.h + resourcesLabel.h;
			nextWave.y = tsb.y + tsb.height;
			startButton.y = nextWave.y + nextWave.height;
			addChild(livesLabel);
			addChild(resourcesLabel);
			addChild(tsb);
			addChild(nextWave);
			addChild(startButton);
			
		}
		public function step():void
		{
			if (nextWave.currentStep == 0)
			{
				dispatchEvent(new Event("NextWave"));
			}
			nextWave.step();
		}
		public function reset():void
		{
			hurry(4);
			nextWave.currentStep = Constants.WAVE_STARTTIME/2;
			lives = Constants.MAIN_STARTLIVES;
			resources = Constants.MAIN_STARTENERGY;	
			alterLives(0);
			alterResources(0);
		}

		public function changeTowerSelection(dir:String):void
		{
			if (dir == "next")
			{
				tsb.setSelection(tsb.selection + 1);
			}
			else
			{
				tsb.setSelection(tsb.selection - 1);
			}
		}
		public function removeLife():void
		{
			lives--;
			livesLabel.setText("lives: " + String(lives));
		}
		public function getLives():int
		{
			return lives;
		}	
		public function alterResources(nr:int):void
		{
			resources += nr;
			resourcesLabel.setText("resources: " + String(resources));
		}
		public function alterLives(nr:int):void
		{
			lives += nr;
			livesLabel.setText("Lives: " + String(lives));
		}		
		public function getResources():int
		{
			return resources;
		}
		public function getCurrentSelection():Class
		{
			return tsb.getSelection();
		}
		public function hurry(am:Number):void
		{
			nextWave.hurry *=am;
		}

	}

}