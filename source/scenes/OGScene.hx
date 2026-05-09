package scenes;

import flixel.FlxG;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.FlxSprite;

class OGScene extends Scene
{
	public var object:FlxSprite;

	public var objectXCenter:Float = 0;

	public function new()
	{
		super();

		options = 2;

		object = new FlxSprite().makeGraphic(64, 64, FlxColor.RED);
		object.screenCenter();

		objectXCenter = object.x;

		PlayState.instance.add(object);
	}

	override public function intro()
	{
		object.x = -object.width;

		FlxTween.tween(object, {x: objectXCenter}, 1, {
			ease: FlxEase.backInOut,
			onComplete: t ->
			{
				FlxTween.tween(object, {x: object.x - object.width}, .25, {
					startDelay: 1,
					ease: FlxEase.sineIn,
					onComplete: t ->
					{
						PlayState.instance.displayOptions();
					}
				});
			}
		});
	}

	override public function onOption(option:Int)
	{
		switch (option)
		{
			case 1:
				FlxTween.tween(object, {x: FlxG.width}, .5, {ease: FlxEase.backInOut});
			case 2:
				FlxTween.tween(object, {x: -FlxG.width}, .5, {ease: FlxEase.backInOut});
		}
	}

	override public function positionOptions()
	{
		var option1:FlxSprite = PlayState.instance.options[0];
		var option2:FlxSprite = PlayState.instance.options[1];

		option1.x -= option1.width;
		option2.x += option2.width;
	}
}
