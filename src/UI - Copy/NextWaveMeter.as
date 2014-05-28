package UI 
{
	import flash.display.Sprite;

	public class NextWaveMeter extends Sprite
	{
		private var bg:Sprite = new Sprite();
		private var gauge:Sprite = new Sprite();
		private var stepSize:Number;
		private var amSteps:int;
		public var currentStep:int=0;
		private var gaugeWidth:int = 150;
		private var gaugeHeight:int = 30;
		private var padding:int = 5;
		public var hurry:Number = 1;
		public function NextWaveMeter(steps:int) 
		{
			amSteps = steps;
			stepSize = gaugeWidth / amSteps;
			bg.graphics.lineStyle(1);
			bg.graphics.beginFill(0xdddddd);
			bg.graphics.drawRect(0, 0, gaugeWidth+(padding*2), gaugeHeight+(padding*2));
			bg.graphics.endFill();
			//bg.graphics.beginFill(0, 0);
			bg.graphics.drawRect(padding, padding, gaugeWidth, gaugeHeight);
			drawGauge(0);
			addChild(bg);
			addChild(gauge);
			//gauge
		}
		public function step():void
		{
			currentStep+=hurry;
			if (currentStep < amSteps)			
			{
				drawGauge(currentStep*stepSize)
			}
			else
			{
				hurry = 1;
				currentStep = 0;				
			}
		}
		private function drawGauge(w:Number):void
		{
			gauge.graphics.clear();
			gauge.graphics.lineStyle(1);
			gauge.graphics.beginFill(0xdd0000);
			gauge.graphics.drawRect(padding, padding, w, gaugeHeight);
			gauge.graphics.endFill();			
		}
	}
}