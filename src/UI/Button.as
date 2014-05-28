package UI 
{
	public class Button extends TextLabel
	{
		private var isActive:Boolean = true;
		public function Button(w:int,h:int,txt:String,pad:int,costVal:int) 
		{
			super(w, h, txt, pad);
			if (costVal > 0)
			{
				var cost:SubText = new SubText(9);
				this.name = txt;
				cost.setText(String(costVal));
				addChild(cost);
				cost.x = x + w - cost.width;
				cost.y = y + h - cost.height;
			}
		}
		public function toggle():void
		{
			if (isActive)
			{
				this.mouseEnabled = false;
				//label.visible = false;
			}
			else
			{
				this.mouseEnabled = true;
				//label.visible = true;
			}
			isActive = !isActive;
		}		
	}

}