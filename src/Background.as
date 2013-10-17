package
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;


	public class Background extends Entity
	{
		[Embed(source="../res/placeholder frame.png")] private const BG:Class;

		public function Background()
		{
			graphic = new Image(BG);
		}
	}
}
