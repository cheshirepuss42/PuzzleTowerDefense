package  
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import Projectiles.*;
	import Towers.*;
	import Creeps.*;
	import UI.*;
	
	public class GameField extends Sprite
	{
		private var grid:Vector.<Vector.<int>> = new Vector.<Vector.<int>>();
		private var waves:Vector.<Wave> = new Vector.<Wave>();
		private var currentTarget:Point = new Point();		
		private var towerLayer:TowerLayer;
		private var projectileLayer:ProjectileLayer;
		private var selectionLayer:SelectionLayer;
		public var sideBar:SideBar = new SideBar();
		private var creepLevel:Number = 0;
		private var fieldLayer:Sprite = new Sprite();
		public var gameOver:Boolean = false;
		
		public function GameField() 
		{			
			Assets.scaleImages();			
			setupGrid();
			
			towerLayer = new TowerLayer();
			projectileLayer = new ProjectileLayer();
			selectionLayer = new SelectionLayer();
			
			addChild(towerLayer);
			addChild(projectileLayer);
			addChild(selectionLayer);
			setupUI();
	
			selectionLayer.setSelection(sideBar.getCurrentSelection());
			fieldLayer.addEventListener(MouseEvent.MOUSE_MOVE, selectTarget);
			fieldLayer.addEventListener(MouseEvent.CLICK, placeTower);
			addEventListener(MouseEvent.MOUSE_WHEEL, changeTowerSelection);
			startGame();
		}
		public function handleStartButton(e:Event):void
		{
			
			startGame();
			GameController(this.parent).startGame();
		}
		private function startGame():void
		{
			
			sideBar.reset();
			towerLayer.clear();
			for (var i:int = 0; i < waves.length; i++) 
			{
				waves[i].clear();
			}
			waves.splice(0, waves.length);
			creepLevel = 0;
			gameOver = false;
			//trace("startGame");			
		}
		private function setupUI():void
		{
			sideBar.x += Constants.MAIN_BSIZE * Constants.GRID_WIDTH;
			sideBar.addEventListener("NextWave", nextTimedWave);
			sideBar.startButton.addEventListener(MouseEvent.CLICK, handleStartButton);
			addChild(sideBar);
		}
		private function nextTimedWave(e:Event):void
		{
			//trace("new timed wave");
			startNewWave(25, 4 + int(creepLevel));
			Assets.soundRattle();
		}
		private function changeTowerSelection(e:MouseEvent):void
		{
			if (e.delta > 0)
			{				
				sideBar.changeTowerSelection("next");
			}
			else
			{				
				sideBar.changeTowerSelection("prev");
			}
			selectionLayer.setSelection(sideBar.getCurrentSelection());
		}
		
		private function setupGrid(holes:int=100):void
		{
			for (var i:int = 0; i < Constants.GRID_WIDTH; i++) 
			{
				grid[i] = new Vector.<int>();
				for (var j:int = 0; j < Constants.GRID_HEIGHT; j++) 
				{
					grid[i][j] = 0;
				}
			}
			for (var k:int = 0; k < holes; k++) 
			{
				grid[int(Math.random() * Constants.GRID_WIDTH-1)][int(Math.random() * Constants.GRID_HEIGHT-1)]=9;
			}
			Path.generateWayPoints();
			Path.applyPathOnGrid(grid);
			drawField();
			addChild(fieldLayer);
		}
		private function startNewWave(delay:int,amount:int):void
		{			
			creepLevel += 0.25;
			var wave:Wave = new Wave(delay, amount,creepLevel);
			addChild(wave);
			waves.push(wave);
			wave.addEventListener("CreepReachedEnd", reachedEnd);
		}
		private function reachedEnd(e:Event):void
		{
			sideBar.removeLife();
			Assets.soundReachedEnd();
		}
		
		private function placeTower(e:MouseEvent):void
		{
			if (grid[currentTarget.x][currentTarget.y] == 0 && selectionLayer.currentTower.cost <= sideBar.getResources())			
			{				
				grid[currentTarget.x][currentTarget.y] = 2;
				towerLayer.placeTower(currentTarget,sideBar.getCurrentSelection());
				Assets.soundPlaceTower();
				selectionLayer.visible = false;
				sideBar.alterResources(-selectionLayer.currentTower.cost);
			}
		}
		
		private function selectTarget(e:MouseEvent):void
		{			
			var target:Point = new Point(int((e.localX + Constants.MAIN_HALFBSIZE) / Constants.MAIN_BSIZE), int((e.localY + Constants.MAIN_HALFBSIZE) / Constants.MAIN_BSIZE));
			if (target.x<Constants.GRID_WIDTH && target.x>=0 && target.y<Constants.GRID_HEIGHT && target.y>=0)			
			{
				currentTarget = target.clone();				
			}
			selectionLayer.visible = false;
			if (grid[currentTarget.x][currentTarget.y] == 0)
			{
				selectionLayer.setLocation(new Point(currentTarget.x * Constants.MAIN_BSIZE, currentTarget.y * Constants.MAIN_BSIZE));
				selectionLayer.visible = true;
			}
		}
		
		public function step(count:int):void
		{			
			for (var i:int = 0; i < waves.length; i++) 
			{
				var wv:Wave = waves[i];
				if (!wv.waveIsGone())
				{	
					wv.step(count);
					for (var j:int = 0; j < wv.creeps.length; j++)					
					{
						var cr:Creep = wv.creeps[j];
						for (var k:int = 0; k < towerLayer.towers.length; k++)
						{
							var tw:Tower = towerLayer.towers[k];
							var newPr:Projectile = tw.reactToCreep(cr);
							if (newPr != null)
							{
								projectileLayer.addProjectile(newPr);
							}
						}
						for (var l:int = 0; l < projectileLayer.projectiles.length; l++)						
						{
							var pr:Projectile = projectileLayer.projectiles[l];
							cr.handleHit(pr);

							if (pr.shouldBeRemoved)
							{
								projectileLayer.removeProjectile(l);
							}
						}
						if (cr.isDead())
						{
							
							//sideBar.alterResources(cr.reward);						
						}
					}
				}
				else
				{
					removeChild(waves[i]);	
					waves[i].removeEventListener("CreepReachedEnd", reachedEnd);
					waves.splice(i, 1);
					if (waves.length == 0)
						sideBar.hurry(4);
					//startNewWave(25, 4+int(creepLevel));					
				}	
			}			
			towerLayer.step();
			projectileLayer.step();
			sideBar.step();
			if (sideBar.getLives() <= 0)
				gameOver = true;
		}
		
		private function drawField():void
		{
			var col:uint;
			fieldLayer.graphics.clear();
			for (var i:int = 0; i < Constants.GRID_WIDTH; i++) 
			{
				for (var j:int = 0; j < Constants.GRID_HEIGHT; j++) 
				{		
					
					switch(grid[i][j])
					{
						case 0:col = (Math.random()<0.5)?0x004000:0x004e00; break;
						case 1:col = 0x964b00; break;
						case 9:col = 0x222222; break;
					}					
					//fieldLayer.graphics.lineStyle(1, 0, ((grid[i][j] == 0)?1:0));
					fieldLayer.graphics.beginFill(col);
					fieldLayer.graphics.drawRect((i * Constants.MAIN_BSIZE) - Constants.MAIN_HALFBSIZE, (j * Constants.MAIN_BSIZE) - Constants.MAIN_HALFBSIZE, Constants.MAIN_BSIZE, Constants.MAIN_BSIZE);
					fieldLayer.graphics.endFill();
				}
			}			
		}		
	}
}