package  
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.media.SoundMixer;	
	//everything is static so i can reach it anywhere
	
	public class Assets
	{
		[Embed(source = "assets/creeps/creep4.png")]private static var Creep1:Class;		
		[Embed(source = "assets/towers/tower1.png")]private static var Tower1:Class;
		[Embed(source = "assets/towers/tower2.png")]private static var Tower2:Class;
		[Embed(source = "assets/towers/tower3.png")]private static var Tower3:Class;
		[Embed(source = "assets/towers/tower4.png")]private static var Tower4:Class;
		
		[Embed(source = 'assets/sounds/gunshot1.mp3')]private static var sound1:Class;
		[Embed(source = 'assets/sounds/bullethit.mp3')]private static var sound2:Class;
		[Embed(source = 'assets/sounds/creepappear.mp3')]private static var sound3:Class;
		[Embed(source = 'assets/sounds/creepdeath.mp3')]private static var sound4:Class;
		[Embed(source = 'assets/sounds/towerplace.mp3')]private static var sound5:Class;
		[Embed(source = 'assets/sounds/lash.mp3')]private static var sound6:Class;
		[Embed(source = 'assets/sounds/waveentrance.mp3')]private static var sound7:Class;
		[Embed(source = 'assets/sounds/zip.mp3')]private static var sound8:Class;
		
	
		public static var creeps:Vector.<Bitmap> = new Vector.<Bitmap>();		
		public static var towers:Vector.<Bitmap> = new Vector.<Bitmap>();
	
		public static var sounds:Vector.<Sound>;
		private static var channel:SoundChannel;
		private static var soundOn:Boolean = true;
		private static var transform:SoundTransform = new SoundTransform();

		public static function loadAssets():void
		{
			creeps[0] = new Creep1();	
			towers.push(new Tower1(),new Tower2(),new Tower3(),new Tower4());

			//setup sounds
			channel = new SoundChannel();
			sounds = new Vector.<Sound>();
			channel.soundTransform = transform;
			sounds.push(new sound1());
			sounds.push(new sound2());
			sounds.push(new sound3());
			sounds.push(new sound4());	
			sounds.push(new sound5());	
			sounds.push(new sound6());	
			sounds.push(new sound7());
			sounds.push(new sound8());
			setVolume(0.4);	
		}
		public static function scaleImages():void
		{	
			var originalBitmapData:BitmapData;
			var scaleFactor:Number;
			var newWidth:Number;
			var newHeight:Number;
			var scaledBitmapData:BitmapData;
			var scaleMatrix:Matrix;
			for (var i:int = 0; i < towers.length; i++) 
			{
				originalBitmapData = towers[i].bitmapData;
				scaleFactor = Constants.MAIN_BSIZE / originalBitmapData.width;
				newWidth = originalBitmapData.width * scaleFactor;
				newHeight = originalBitmapData.height * scaleFactor;
				scaledBitmapData = new BitmapData(newWidth, newHeight, true, 0xffffff);
				scaleMatrix = new Matrix();
				scaleMatrix.scale(scaleFactor, scaleFactor);
				scaledBitmapData.draw(originalBitmapData, scaleMatrix);
				towers[i].bitmapData = scaledBitmapData;
			}
			for (i = 0; i < creeps.length; i++) 
			{
				originalBitmapData = creeps[i].bitmapData;
				scaleFactor = Constants.MAIN_BSIZE / originalBitmapData.width;
				newWidth = originalBitmapData.width * scaleFactor;
				newHeight = originalBitmapData.height * scaleFactor;
				scaledBitmapData = new BitmapData(newWidth, newHeight, true, 0xffffff);
				scaleMatrix = new Matrix();
				scaleMatrix.scale(scaleFactor, scaleFactor);
				scaledBitmapData.draw(originalBitmapData, scaleMatrix);
				creeps[i].bitmapData = scaledBitmapData;
			}			
		}

		public static function setVolume(v:Number=1):void
		{
			var s:SoundTransform = new SoundTransform();
			s.volume = v;
			SoundMixer.soundTransform = s;	
		}
		
		public static function soundToggle():void
		{
			var s:SoundTransform = new SoundTransform();
			s.volume = (soundOn)?0:1;
			soundOn = (s.volume == 0)?false:true;
			SoundMixer.soundTransform = s;					
		}
		
		public static function soundFire():void
		{
			channel = sounds[0].play();
		}
		public static function soundHit():void
		{
			channel = sounds[1].play();
		}
		public static function soundBirth():void
		{
			channel = sounds[2].play();
		}
		public static function soundDeath():void
		{
			channel = sounds[3].play();
		}
		public static function soundPlaceTower():void
		{
			channel = sounds[4].play();
		}	
		public static function soundLash():void
		{
			channel = sounds[5].play();
		}	
		public static function soundRattle():void
		{
			channel = sounds[6].play();
		}		
		public static function soundReachedEnd():void
		{
			channel = sounds[7].play();
		}			
	}

}