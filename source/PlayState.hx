package;

import scenes.OGScene;
import scenes.Scene;
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
	public static var scene:Scene;

	public var sceneCamera:FlxCamera;
	public var optionsCamera:FlxCamera;

	public static var instance:PlayState;

	override public function create()
	{
		super.create();

		if (instance != null)
			instance = null;
		instance = this;

		sceneCamera = new FlxCamera();
		FlxG.cameras.add(sceneCamera, true);

		optionsCamera = new FlxCamera();
		FlxG.cameras.add(optionsCamera, false);
		optionsCamera.bgColor.alpha = 0;

		play();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (scene != null)
			scene.update(elapsed);
	}

	public function play()
	{
		if (scene != null)
			scene.intro();
	}

	public var options:Array<SceneOption> = [];

	public var selectableOptions:Bool = false;

	public function displayOptions()
	{
		if (scene == null)
			return;

		var startDelay:Float = 0.1;

		for (i in 0...scene.options)
		{
			var option = new SceneOption(i + 1);
			options.push(option);
			add(option);
			option.screenCenter();

			option.callback = () -> performOption(option.option);
			option.selectable = false;

			option.camera = optionsCamera;

			option.alpha = 0;
			option.y += option.height * .1;

			FlxTween.tween(option, {alpha: .8, y: option.y - option.height * .1}, .5, {
				startDelay: startDelay,
				ease: FlxEase.backInOut,
				onComplete: t ->
				{
					option.selectable = true;
				}
			});

			startDelay += .1;
		}

		scene.positionOptions();
	}

	public function performOption(option:Int)
	{
		for (option in options)
		{
			FlxTween.tween(option, {alpha: 0, y: option.y + option.height * .1}, .5, {
				startDelay: .1 * option.option,
				ease: FlxEase.backInOut,
				onComplete: t ->
				{
					remove(option);
					option.destroy();
					option = null;
				}
			});
		}

		if (scene == null)
			return;

		scene.onOption(option);
	}
}
