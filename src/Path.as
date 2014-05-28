package  
{
	import flash.geom.Point;

	public class Path
	{
		public static var wayPoints:Vector.<Point> = new Vector.<Point>();
		private static var path:Vector.<Point> = new Vector.<Point>();
		
		public static function generateWayPoints(pathType:int=2):void
		{
			
			switch(pathType)
			{
				case 2:path = Constants.PATH2; break;
				default:path = Constants.PATH1; break;
			}
			for (var i:int = 0; i < path.length; i++) 
			{
				wayPoints[i] = new Point(path[i].x * Constants.MAIN_BSIZE-Constants.MAIN_HALFBSIZE, path[i].y * Constants.MAIN_BSIZE-Constants.MAIN_HALFBSIZE);
			}	
			//trace(wayPoints);
		}
		
		public static function applyPathOnGrid(grid:Vector.<Vector.<int>>):void
		{
			for (var i:int = 0; i < path.length-1; i++) 
			{
				var p:Point = path[i + 1].subtract(path[i]);
				var len:int = p.length;
				p.normalize(1);
				for (var j:int = 0; j < len; j++) 
				{
					if (i==0 && j==0)j++;//entrance point hack						
					grid[path[i].x + (p.x * j)][path[i].y + (p.y * j)] = 1;
				}
			}			
		}		
	}

}