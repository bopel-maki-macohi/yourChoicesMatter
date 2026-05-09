package;

import flixel.util.FlxTimer;
import flixel.math.FlxMath;
import flixel.FlxG;
import flixel.FlxCamera;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.FlxSprite;
import flixel.FlxState;

class PlayState extends FlxState
{
	public var object:FlxSprite;

	public var sceneCamera:FlxCamera;
	public var optionsCamera:FlxCamera;

	override public function create()
	{
		super.create();

		sceneCamera = new FlxCamera();
		FlxG.cameras.add(sceneCamera, true);

		optionsCamera = new FlxCamera();
		FlxG.cameras.add(optionsCamera, false);
		optionsCamera.bgColor.alpha = 0;

		object = new FlxSprite().makeGraphic(64, 64, FlxColor.RED);
		add(object);
		object.screenCenter();

		play();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (selectableOptions)
		{
			if (option1 != null)
				option1.alpha = FlxMath.lerp(option1.alpha, (FlxG.mouse.overlaps(option1)) ? 1 : .8, .4);
		}
	}

	public var step:Int = 0;

	public function play()
	{
		step = 0;

		introStep();
	}

	public function introStep()
	{
		final objectCenterX:Float = object.x;
		object.x = -object.width;

		FlxTween.tween(object, {x: objectCenterX}, 1, {
			ease: FlxEase.backInOut,
			onComplete: t ->
			{
				FlxTween.tween(object, {x: object.x - object.width}, .25, {
					startDelay: 1,
					ease: FlxEase.sineIn,
					onComplete: t ->
					{
						displayOptions();
					}
				});
			}
		});
	}

	public var option1:FlxSprite;

	public var selectableOptions:Bool = false;

	public function displayOptions()
	{
		option1 = new FlxSprite().makeGraphic(128, 128, FlxColor.WHITE);
		add(option1);
		option1.screenCenter();

		option1.camera = optionsCamera;

		option1.alpha = 0;
		option1.y += option1.height * .1;

		FlxTween.tween(option1, {alpha: .8, y: option1.y - option1.height * .1}, .5, {
			startDelay: .1,
			ease: FlxEase.backInOut
		});

		FlxTimer.wait(.6, () ->
		{
			selectableOptions = true;
		});
	}
}
