package {
    import net.flashpunk.World;

    public class GameWorld extends World
    {
        public function GameWorld()
        {
        }

        override public function begin():void
        {
            add(new TetrisGrid());
        }
    }

}
