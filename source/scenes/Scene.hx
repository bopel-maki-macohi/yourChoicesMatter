package scenes;

class Scene
{
	public var options:Int = 0;

	public function new() {}

	public function intro()
	{
		PlayState.instance.displayOptions();
	}

	public function update(elapsed:Float) {}

	public function onOption(option:Int) {}

	public function positionOptions() {}
}
