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
			{
				if (FlxG.mouse.overlaps(option1))
				{
					option1.alpha = FlxMath.lerp(option1.alpha, 1, .4);

					if (FlxG.mouse.justPressed)
					{
						performOption(1);
					}
				}
				else
					option1.alpha = FlxMath.lerp(option1.alpha, .8, .4);
			}
			
			if (option2 != null)
			{
				if (FlxG.mouse.overlaps(option2))
				{
					option2.alpha = FlxMath.lerp(option2.alpha, 1, .4);

					if (FlxG.mouse.justPressed)
					{
						performOption(2);
					}
				}
				else
					option2.alpha = FlxMath.lerp(option2.alpha, .8, .4);
			}
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
	public var option2:FlxSprite;

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
		
		option2 = new FlxSprite().makeGraphic(128, 128, FlxColor.WHITE);
		add(option2);
		option2.screenCenter();

		option2.camera = optionsCamera;

		option2.alpha = 0;
		option2.y += option2.height * .1;

		option1.x -= option1.width;
		option2.x += option2.width;

		FlxTween.tween(option2, {alpha: .8, y: option2.y - option2.height * .1}, .5, {
			startDelay: .1,
			ease: FlxEase.backInOut
		});

		FlxTimer.wait(.6, () ->
		{
			selectableOptions = true;
		});
	}

	public function performOption(option:Int)
	{
		FlxTween.tween(option1, {alpha: 0, y: option1.y + option1.height * .1}, .5, {
			startDelay: .1,
			ease: FlxEase.backInOut,
			onComplete: t ->
			{
				option1.destroy();
				option1 = null;
			}
		});

		FlxTween.tween(option2, {alpha: 0, y: option2.y + option2.height * .1}, .5, {
			startDelay: .1,
			ease: FlxEase.backInOut,
			onComplete: t ->
			{
				option2.destroy();
				option2 = null;
			}
		});

		selectableOptions = false;

		switch (option)
		{
			case 1:
				FlxTween.tween(object, {x: FlxG.width}, .5, {ease: FlxEase.backInOut});
			case 2:
				FlxTween.tween(object, {x: -FlxG.width}, .5, {ease: FlxEase.backInOut});
		}
	}
}
