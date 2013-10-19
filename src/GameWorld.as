package {
    import net.flashpunk.World;
	import net.flashpunk.Sfx;


    public class GameWorld extends World
    {
        private var TetrisMusic:Sfx = new Sfx(A.korobeiniki);

		public function GameWorld()
        {
        }

        override public function begin():void
        {
            add(new Background());
            var hs:Highscore = new Highscore();
            add(new TetrisGrid(hs));
            add(hs);
            TetrisMusic.loop();
        }

        override public function end():void
        {
            TetrisMusic.stop();
        }
    }
}
