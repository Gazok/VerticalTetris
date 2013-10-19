package
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Text; //we want to use text
    import net.flashpunk.graphics.Image;//use images
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;

	public class Highscore extends Entity
	{
		private var highscore:Text;
        private var score:int;

		public function Highscore( x:int = 0, y:int = 0)
		{
            score = 0;
            highscore = new Text(""+score, 240, 130);
            highscore.size = 30;
			graphic = highscore;
		}

        public function addToScore(scoreAdd:int):void
        {
            score += scoreAdd;
            highscore.text = ""+score;
        }
	}
}
