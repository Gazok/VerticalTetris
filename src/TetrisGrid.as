package {
    import net.flashpunk.Entity;
    import flash.geom.Rectangle;
    import net.flashpunk.graphics.Canvas;

    public class TetrisGrid extends Entity
    {
        private var grid:Array;
        private var c:Canvas = new Canvas(10,10);

        public function TetrisGrid()
        {
            c.fill(new Rectangle(0,0,10,10), 0xFF0000)
            graphic = c;
        }
    }
}
