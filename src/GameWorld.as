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
            var t:TetrisGrid = new TetrisGrid();
            add(t)
            add(new Tetrimino(6, t));
            add(new Highscore());
            TetrisMusic.loop();
        }
    }

}
