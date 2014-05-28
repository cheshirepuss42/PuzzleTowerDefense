package UI 
{
	import flash.display.Sprite;
	import flash.events.*;
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	import flash.text.*;
	public class RewardSpark extends Sprite
	{
		private var text:TextField = new TextField();
		private var format:TextFormat = new TextFormat();	
		private var duration:int = 40;
		private var floatHeight:int = 20;
		private var currentTime:int = 0;
		public var shouldBeRemoved:Boolean = false;
		public function RewardSpark(pos:Point,amount:int) 
		{
			x = pos.x;
			y = pos.y;
			format.font = "Arial";
			format.size = 9;	
			format.color = 0xffff00;
			text.selectable = false;						
			text.mouseEnabled = false;		
			text.antiAliasType = "advanced";
			addChild(text);	
			setText("+"+String(amount));
			filters = [new GlowFilter(0)];
			x -= width / 2;
			y -= height / 2;
		}
		public function setText(sc:String):void
		{		
			text.text = sc;
			text.setTextFormat(format);
			text.autoSize = TextFieldAutoSize.LEFT;
			
		}			
		public function step():void
		{
			currentTime++;
			if (duration < currentTime)
				shouldBeRemoved = true;
			this.y -= (floatHeight / duration);
		}
	}

}