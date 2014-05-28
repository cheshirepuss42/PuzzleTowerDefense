package UI 
{

	import flash.display.Sprite;
	import flash.events.*;
	import flash.filters.GlowFilter;
	import flash.text.*;
	
	public class SubText extends Sprite
	{
		private var text:TextField = new TextField();
		private var format:TextFormat = new TextFormat();	
		
		public function SubText(size:int=7) 
		{			
			format.font = "Arial";
			format.size = size;	
			format.color = 0xffff00;
			text.selectable = false;						
			text.mouseEnabled = false;		
			text.antiAliasType = "advanced";
			addChild(text);	
			filters = [new GlowFilter(0, 1, 2, 2)];
			//setText(txt);			
		}
		public function setText(sc:String):void
		{		
			text.text = sc;
			text.setTextFormat(format);
			text.autoSize = TextFieldAutoSize.LEFT;
			
		}	
	}

}