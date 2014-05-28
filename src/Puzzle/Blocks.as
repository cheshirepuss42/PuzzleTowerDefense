package  Puzzle
{
	//import Box2D.Collision.b2ContactPoint;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	
	public class Blocks extends EventDispatcher
	{
		private var grid:Vector.<Vector.<int>>;
		private var searchGrid:Vector.<Vector.<int>>;
		private var w:int;
		private var h:int;
		private var amTypes:int = 5;
		private var neighbours:Vector.<Point> = Vector.<Point>([new Point(0, 1), new Point(1, 0), new Point(0, -1), new Point( -1, 0)]);
		private var colors:Vector.<uint> = Vector.<uint>([0,0xcccccc, 0xff0000 ,0x0000ff,0x00ff00, 0xffff00,0xeeee00, 0x00eeee]);
		private var shapeVect:Vector.<Point> = new Vector.<Point>();
		private var shapes:Vector.<Vector.<Point>> = new Vector.<Vector.<Point>>();
		private var shapePoints:Vector.<Point> = new Vector.<Point>();
		private var size:int; 
		private var score:int = 0;
		private var minShapeSize:int = 4;
		private var newScore:Boolean = false;
		
		public function Blocks(_w:int,_h:int,_s:int) 
		{
			size = _s;
			w = _w;
			h = _h;
			//setupGrid();
			//setupSearchGrid();
			//findShapes();
			init();
		}
		public function hasNewScore():Boolean
		{
			return newScore;
		}
		public function getScore():int
		{
			newScore = false;
			return score;
		}
		public function getSize():int
		{
			return size;
		}		
		private function setupGrid():void
		{
			grid = new Vector.<Vector.<int>>();
			for (var i:int = 0; i < w; i++) 
			{
				grid[i] = new Vector.<int>();
				for (var j:int = 0; j < h; j++) 
				{
					grid[i][j] = int(Math.random() * amTypes)+1;
				}				
			}			
		}
		private function setupSearchGrid():void
		{
			searchGrid = new Vector.<Vector.<int>>();
			for (var i:int = 0; i < w; i++) 
			{
				searchGrid[i] = new Vector.<int>();
				for (var j:int = 0; j < h; j++) 
				{
					searchGrid[i][j] = 0;
				}				
			}			
		}		
		public function handlePoint(p:Point):void
		{
			if (pointIsOnGrid(p))
			{
				var shapenr:int = -1;
				for (var m:int = 0; m < shapes.length; m++) 
				{
					if (searchPoints(p, shapes[m]) != -1)
					{
						shapenr = m;
						m = shapes.length;
					}
				}
				if (shapenr >= 0)
				{
					for (var i:int = 0; i < shapes[shapenr].length; i++) 
					{
						grid[shapes[shapenr][i].x][shapes[shapenr][i].y] = 0;
					}	
					score = (shapes[shapenr].length-(minShapeSize-1))*2;
					dispatchEvent(new Event("ShapeRemoved"));
					shapes.splice(shapenr, 1);
					dropAboveEmpty();
					newScore = true;
					
				}	
				else
				{
					score = -5;
					dispatchEvent(new Event("WrongClick"));
					newScore = true;
				}
			}
			findShapes();
			if (shapes.length == 0)
			{
				init();				
				dispatchEvent(new Event("LastShapeRemoved"));				
			}			
			//trace(shapes.length);
		}
		public function init():void
		{
			score = 20;			
			newScore = true;
			setupGrid();
			setupSearchGrid();
			findShapes();			
		}
		private function dropAboveEmpty():void
		{
			for (var i:int = 0; i < w; i++) 
			{
				for (var j:int = 0; j < h; j++) 
				{
					if (grid[i][j] == 0)
					{
						var p:Point = new Point(i, j);
						while (p.y >= 0)
						{							
							grid[p.x][p.y] = (p.y == 0)?int(Math.random() * amTypes)+1:grid[p.x][p.y - 1];
							p.y -= 1;
						}
					}
					
				}
			}
		}
		private function findShapes():void
		{		
			shapes.splice(0, shapes.length);
			setupSearchGrid();
			for (var i:int = 0; i < w; i++) 
			{
				for (var j:int = 0; j < h; j++) 
				{
					var isPresent:Boolean = false;
					for (var m:int = 0; m < shapes.length; m++) 
					{
						if (searchPoints(new Point(i, j), shapes[m]) != -1)
						{
							isPresent = true;
							m = shapes.length;
						}
					}	
					if (!isPresent)
					{
						findNextPointInShape(new Point(i, j));					
						if (shapeVect.length >= minShapeSize )
						{
							shapes.push(shapeVect);
						}
						shapeVect = new Vector.<Point>();
					}
				}				
			}

			for (var k:int = 0; k < shapes.length; k++) 
			{
				for (var l:int = 0; l <shapes[k].length ; l++) 
				{
					searchGrid[shapes[k][l].x][shapes[k][l].y] = grid[shapes[k][l].x][shapes[k][l].y];
				}
			}

		}
		private function findNextPointInShape(p:Point):void
		{
			shapeVect.push(p);
			var nb:Vector.<Point> = getNeighbours(p);
			for (var i:int = 0; i < nb.length; i++) 
			{
				if (searchPoints(nb[i],shapeVect)==-1)
				{
					findNextPointInShape(nb[i]);
				}
			}			
		}

		private function getNeighbours(p:Point):Vector.<Point>		
		{
			var points:Vector.<Point> = new Vector.<Point>();
			for (var i:int = 0; i < neighbours.length; i++) 
			{
				var neighbour:Point = new Point(p.x + neighbours[i].x, p.y + neighbours[i].y);
				if (pointIsOnGrid(neighbour))
				{
					if (grid[neighbour.x][neighbour.y] == grid[p.x][p.y])
					{
						points.push(neighbour);
					}
				}								
			}		
			//trace(points.length);
			return points;
		}
		private function pointIsOnGrid(p:Point):Boolean
		{
			return p.x >= 0 && p.x < w && p.y >= 0 && p.y < h;
		}	
		public function getView():Sprite
		{
			var spr:Sprite = new Sprite();
			var gr:Sprite = gridView(grid);
			var sgr:Sprite = gridView(searchGrid);
			spr.addChild(gr);
			//spr.addChild(sgr);
			sgr.x += gr.width + 10;
			return spr;
		}
		public function doFallingAnimation(shapenr:int,duration:int):void
		{
			//make seperate sprite
			//paint shape black
			
			for (var k:int = 0; k < shapes[shapenr].length; k++) 
			{
				grid[shapes[shapenr][k].x][shapes[shapenr][k].y] = 0;
			}
			//var droppingPoints:Vector.<Point> = new Vector.<Point>();
			var dropping:Sprite = new Sprite();
			for (var i:int = 0; i < w; i++) 
			{
				for (var j:int = 0; j < h; j++) 
				{
					if (grid[i][j] == 0)
					{
						var p:Point = new Point(i, j);
						while (p.y >= 0)
						{							
							//grid[p.x][p.y] = (p.y == 0)?int(Math.random() * amTypes)+1:grid[p.x][p.y - 1];
							p.y -= 1;
							//dropping.graphics
							dropping.graphics.beginFill(colors[grid[p.x][p.y]],0.35);					
							dropping.graphics.drawRect(p.x * size, p.y * size, size, size);
							dropping.graphics.endFill();	
							dropping.graphics.lineStyle(1, 0);
							dropping.graphics.beginFill(colors[grid[p.x][p.y]]);
							dropping.graphics.drawRect(p.x * size + 2, p.y * size + 2, size-3, size-3);
							//view.graphics.drawCircle((i * size)+(size/2), (j * size)+(size/2), (size/2)-2);
							dropping.graphics.endFill();	
							dropping.graphics.lineStyle(0, 0);								
							//droppingPoints.push(p.clone());
						}
					}
					
				}
			}
			//var dropping:Sprite = new Sprite();
			
			//trace(droppingPoints);
			//make new shape from blocks above black
		}
		private function gridView(gr:Vector.<Vector.<int>>):Sprite
		{
			var view:Sprite = new Sprite();
			//var size:int = 30;
			for (var i:int = 0; i < w; i++) 
			{
				for (var j:int = 0; j < h; j++) 
				{
					
					view.graphics.beginFill(colors[gr[i][j]],0.35);					
					view.graphics.drawRect(i * size, j * size, size, size);
					view.graphics.endFill();	
					view.graphics.lineStyle(1, 0);
					view.graphics.beginFill(colors[gr[i][j]]);
					view.graphics.drawRect(i * size + 2, j * size + 2, size-3, size-3);
					//view.graphics.drawCircle((i * size)+(size/2), (j * size)+(size/2), (size/2)-2);
					view.graphics.endFill();	
					view.graphics.lineStyle(0, 0);				
				}				
			}
			//trace(gr);
			return view;
			
		}
		private function searchPoints(p:Point,pts:Vector.<Point>):int
		{
			for (var i:int = 0; i < pts.length; i++) 
			{
				if (p.equals(pts[i]))
					return i;
			}
			return -1;
		}
	}

}