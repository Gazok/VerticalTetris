package {
    import flash.geom.Rectangle;
    import net.flashpunk.Entity;
    import net.flashpunk.FP;
    import net.flashpunk.graphics.Canvas;

    /*
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
    */
    public class TetrisGrid extends Entity
    {
        private const gridWidth_:int = 10;
        private const gridHeight_:int = 22;
        private var grid_:Array = new Array(gridWidth_);

        public function TetrisGrid()
        {
            for (var i:int = 0; i < gridWidth_; ++i)
            {
                grid_[i] = new Array(gridHeight_);

                for (var j:int = 0; j < gridHeight_; ++j)
                {
                    grid_[i][j] = new GridSlot(i, j);
                }
            }
        }

        public override function added():void
        {
            for (var i:int = 0; i < gridWidth_; ++i)
            {
                for (var j:int = 0; j < gridHeight_; ++j)
                {
                    this.world.add(grid_[i][j]);
                }
            }
        }
    }
}
