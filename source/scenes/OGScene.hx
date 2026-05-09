package scenes;

import flixel.FlxG;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.FlxSprite;

class OGScene
{
	public var object:FlxSprite;

	public var objectXCenter:Float = 0;

	public function new()
	{
		object = new FlxSprite().makeGraphic(64, 64, FlxColor.RED);
		object.screenCenter();

		objectXCenter = object.x;
	}

	public function intro(end:Void->Void)
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
						if (end != null)
							end();
					}
				});
			}
		});
	}

	public function onOption(option:Int)
	{
		switch (option)
		{
			case 1:
				FlxTween.tween(object, {x: FlxG.width}, .5, {ease: FlxEase.backInOut});
			case 2:
				FlxTween.tween(object, {x: -FlxG.width}, .5, {ease: FlxEase.backInOut});
		}
	}
}
