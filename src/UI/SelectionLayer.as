package UI 
{
	import flash.display.Sprite;
	import flash.geom.Point;
	import Towers.Shooter;
	import Towers.Tower;

	
	public class SelectionLayer extends Sprite
	{
		public var currentTower:Tower;
		public var selection:Sprite = new Sprite();
		private var location:Point = new Point();
		public function SelectionLayer() 
		{
			this.mouseChildren = this.mouseEnabled = false;
			this.alpha = 0.5;
		}
		public function setSelection(type:Class):void
		{
			currentTower = new type();
			while (numChildren > 0) removeChildAt(0);
			selection = currentTower.selectionView();
			setLocation(location);
			addChild(selection);			
		}
		public function setLocation(pos:Point):void
		{
			location = pos.clone();
			selection.x = pos.x;
			selection.y = pos.y;
		}		
	}

}