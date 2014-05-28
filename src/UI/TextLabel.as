package UI 
{
	import flash.display.Sprite;
	import flash.events.*;
	import flash.text.*;
	
	public class TextLabel extends Sprite
	{
		private var padding:Sprite = new Sprite();
		private var label:Sprite = new Sprite();
		private var text:TextField = new TextField();
		private var format:TextFormat = new TextFormat();	
		private var padSize:int;
		public var w:int;
		public var h:int;
		public var txt:String;
		
		public function TextLabel(_w:int,_h:int,_txt:String,pad:int,bgCol:uint=0xaaaaaa) 
		{
			
			w = _w + (2 * pad);
			h = _h + (2 * pad);
			txt = _txt;
			padSize = pad;
			padding.graphics.beginFill(0,0);
			padding.graphics.drawRect(0, 0, w, h);
			padding.graphics.endFill();
			padding.mouseEnabled = false;
			addChild(padding);	
			
			label.graphics.lineStyle(1);
			label.graphics.beginFill(bgCol);
			label.graphics.drawRoundRect(pad, pad, _w, _h, 10, 10);
			label.graphics.endFill();			
			addChild(label);
			
			format.font = "Arial";
			format.size = 12;	
			format.color = 0;
			text.selectable = false;						
			text.mouseEnabled = false;		
			text.antiAliasType = "advanced";
			addChild(text);			
			setText(txt);			
		}
		public function setText(sc:String):void
		{		
			text.text = sc;
			text.setTextFormat(format);
			text.autoSize = TextFieldAutoSize.LEFT;
			text.x = padSize + (label.width / 2) - (text.width / 2);
			text.y = padSize + (label.height / 2) - (text.height / 2);
			
		}		
	}

}