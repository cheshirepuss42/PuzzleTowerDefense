package  
{
	import flash.geom.Point;

	public class IntGrid2d
	{
		private var grid:Vector.<Vector.<int> > = new Vector.<Vector.<int>>();
		private var dirs:Vector.<Point> = Vector.<Point>([new Point(0, 1), new Point(0, -1), new Point( -1, 0), new Point(1, 0), new Point(1, 1), new Point(1, -1), new Point( -1, 1), new Point( -1, -1)]);		
		private var w:int;
		private var h:int;
		public function IntGrid2d(_w:int,_h:int,initval:int=0) 
		{
			w = _w;
			h = _h;
			for (var i:int = 0; i < w; i++) 
			{
				grid[i] = new Vector.<int>();
				for (var j:int = 0; j < h; j++) 
				{
					grid[i][j] = initval;
				}				
			}			
		}
		public function setVal(val:int, p:Point):void
		{
			grid[p.x][p.y] = val;
		}
		public function getVal(p:Point):int
		{
			return grid[p.x][p.y];
		}		
		public function inGrid(p:Point):Boolean
		{
			return p.x >= 0 && p.x < w && p.y >= 0 && p.y < h;
		}
		public function clone():IntGrid2d
		{
			var newgrid:IntGrid2d = new IntGrid2d(w, h);
			for (var i:int = 0; i < w; i++) 
			{
				for (var j:int = 0; j < h; j++) 
				{
					var p:Point = new Point(i, j);
					newgrid.setVal(grid[i][j], p);					
				}				
			}	
			return newgrid;
		}
		public function randomize(max:int, min:int=0):void
		{
			for (var i:int = 0; i < w; i++) 
			{
				for (var j:int = 0; j < h; j++) 
				{
					grid[i][j] = int(Math.random() * (max-min)) + min;					
				}				
			}			
		}
		public function getNeighbours(p:Point,diagonals:Boolean=true):Vector.<Point>
		{			
			var nb:Vector.<Point> = new Vector.<Point>();
			var am:int = (diagonals)?dirs.length:dirs.length / 2;
			for (var i:int = 0; i < am; i++) 
			{
				var np:Point = new Point(p.x + dirs[i].x, p.y + dirs[i].y);
				if (inGrid(np))
				{
					nb.push(np);
				}
			}
			return nb;
		}
	}

}