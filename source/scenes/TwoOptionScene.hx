package scenes;

class TwoOptionScene extends Scene
{
	public function new()
	{
		super();

		options = 2;
	}

	override public function positionOptions()
	{
		var option1:SceneOption = PlayState.instance.options[0];
		var option2:SceneOption = PlayState.instance.options[1];

		option1.x -= option1.width;
		option2.x += option2.width;
	}
}
