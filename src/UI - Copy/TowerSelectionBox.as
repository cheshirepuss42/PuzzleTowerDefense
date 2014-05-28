package UI 
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import Towers.*;

	public class TowerSelectionBox extends Sprite
	{
		private var towers:Vector.<Button> = new Vector.<Button>();		
		public var selection:int = 0;
		private var selectionIndicator:Sprite = new Sprite();
		public function TowerSelectionBox() 
		{
			var b1:Button = new Button(60, 40, Constants.NAME_SHOOTER,2,Constants.COST_SHOOTER);
			var b2:Button = new Button(60, 40, Constants.NAME_BURNER,2,Constants.COST_BURNER);
			var b3:Button = new Button(60, 40, "Upgrade",2,0);
			var b4:Button = new Button(60, 40, "Sell", 2, 0);
			b1.addEventListener(MouseEvent.CLICK, buttonClick);
			b2.x = b1.w;
			b3.y = b1.h;
			b4.y = b1.h;
			b4.x = b3.w;
			//b3.x = b1.w + b2.w;
			//b4.x = b1.w + b2.w + b3.w;
			towers.push(b1, b2 , b3, b4);
			addChild(b1);
			addChild(b2);
			addChild(b3);
			addChild(b4);
			addChild(selectionIndicator);
			selectionIndicator.graphics.clear();
			selectionIndicator.graphics.lineStyle(2, 0xff2200, 0.7);
			selectionIndicator.graphics.drawRect(0, 0, towers[0].w, towers[0].h);			
		}
		private function buttonClick(e:MouseEvent):void
		{
			switch(e.currentTarget.name)
			{
				case Constants.NAME_SHOOTER:setSelection(0); break;
				case Constants.NAME_BURNER:setSelection(1); break;
			}
			
		}
		public function setSelection(sel:int):void
		{
			selection = (sel<0)?towers.length-1:(sel>towers.length-1)?0:sel;
			selectionIndicator.x = towers[selection].x;
			selectionIndicator.y = towers[selection].y;
		}
		public function getSelection():Class
		{
			switch(selection)
			{
				case 1: return Burner;
				default:return Shooter;
			}
		}
		
	}

}