package  
{
	import flash.geom.Point;
	/**
	 * ...
	 * @author 
	 */
	public class Constants
	{
		public static var WAVE_STARTTIME:int = 700;
		public static var MAIN_STARTLIVES:int = 2;
		public static var MAIN_STARTENERGY:int = 80;
		public static var COST_SHOOTER:int = 45;
		public static var COST_BURNER:int = 60;		
		public static var COOLDOWN_SHOOTER:int = 12;
		public static var COOLDOWN_BURNER:int = 70;	
		public static var NAME_SHOOTER:String = "Shooter";
		public static var NAME_BURNER:String = "Burner";
		public static var GRID_WIDTH:int = 25;
		public static var GRID_HEIGHT:int = 25;
		public static var MAIN_BSIZE:int = 24;
		public static var MAIN_HALFBSIZE:int = MAIN_BSIZE / 2;
		public static var PATH1:Vector.<Point>= Vector.<Point>([new Point(2,-1),
																new Point(2, 8),
																new Point(22, 8),
																new Point(22, 16),										
																new Point(2, 16),
																new Point(2, 20),										
																new Point(22, 20),
																new Point(22, 25)]);
		public static var PATH2:Vector.<Point>= Vector.<Point>([new Point(4,-1),
																new Point(4, 10),
																new Point(10, 10),
																new Point(10, 3),
																new Point(20, 3),																
																new Point(20, 16),										
																new Point(2, 16),
																new Point(2, 20),										
																new Point(22, 20),
																new Point(22, 25)]);																
	}

}