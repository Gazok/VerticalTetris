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
            add(new TetrisGrid());
			add(new Highscore());
			TetrisMusic.loop();
        }
    }

}
