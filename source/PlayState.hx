package;

import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.FlxSprite;
import flixel.FlxState;

class PlayState extends FlxState
{
	public var object:FlxSprite;

	override public function create()
	{
		super.create();

		object = new FlxSprite().makeGraphic(64, 64, FlxColor.RED);
		add(object);
		object.screenCenter();

		play();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
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
					onComplete: t -> displayOptions
				});
			}
		});
	}

	public function displayOptions() {}
}
