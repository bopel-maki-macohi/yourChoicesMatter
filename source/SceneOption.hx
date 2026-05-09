import flixel.math.FlxMath;
import flixel.FlxG;
import flixel.FlxSprite;

class SceneOption extends FlxSprite
{
	public var option:Int;

	public function new(option:Int)
	{
		super();

		makeGraphic(128, 128);

		this.option = option;
	}

	public var selectable:Bool = true;

	public var callback:Void->Void;

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (selectable)
		{
			if (FlxG.mouse.overlaps(this))
			{
				alpha = FlxMath.lerp(alpha, 1, .4);

				if (FlxG.mouse.justPressed && callback != null)
					callback();
			}
			else
			{
				alpha = FlxMath.lerp(alpha, .8, .4);
			}
		}
	}
}
