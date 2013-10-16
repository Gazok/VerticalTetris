package {

    import net.flashpunk.Entity;

    public class Tetrimino extends Entity
    {
        private static const tetriminos_:Array
            = new Array(
                new Array(),
                new Array(
                    new Array(0,1,0,0),
                    new Array(0,1,0,0),
                    new Array(0,1,0,0),
                    new Array(0,1,0,0)),
                new Array(
                    new Array(1,1),
                    new Array(1,1)),
                new Array(
                    new Array(0,1,0),
                    new Array(1,1,0),
                    new Array(0,1,0)),
                new Array(
                    new Array(1,0,0),
                    new Array(1,1,0),
                    new Array(0,1,0)),
                new Array(
                    new Array(0,1,0),
                    new Array(1,1,0),
                    new Array(1,0,0)),
                new Array(
                    new Array(0,1,0),
                    new Array(0,1,0),
                    new Array(1,1,0)),
                new Array(
                    new Array(1,1,0),
                    new Array(0,1,0),
                    new Array(0,1,0)));

        private var tetriminoType_:uint = 0;
        private var tetrimino_:Array;
        private var grid_:TetrisGrid;

        public function Tetrimino(type:uint, grid:TetrisGrid)
        {
            tetriminoType_ = type;
            grid_ = grid;
            x = 3;
            y = 0;

            tetrimino_ = tetriminos_[tetriminoType_];
        }

        public override function update():void
        {
            updateGrid();
        }

        public function hardDrop():void
        {
        }

        public function rotateCW():void
        {
            var newTetrimino:Array = new Array;
            for (var x:int = 0; x < tetrimino_.length; ++x)
            {
                newTetrimino.push_back(new Array);

                for (var y:int = 0; y < tetrimino_[x].length; ++y)
                {
                    newTetrimino.push_back(tetrimino_[tetrimino_[x].length - y]
                                                     [tetrimino_.length - x]);
                }
            }

            tetrimino_ = newTetrimino;
        }

        public function rotateCCW():void
        {
            var newTetrimino:Array = new Array;
            for (var x:int = 0; x < tetrimino_.length; ++x)
            {
                newTetrimino.push_back(new Array);

                for (var y:int = 0; y < tetrimino_[x].length; ++y)
                {
                    newTetrimino.push_back(tetrimino_[y][x]);
                }
            }

            tetrimino_ = newTetrimino;
        }

        private function updateGrid():void
        {
            for (var x:int = 0; x < tetrimino_.length; ++x)
            {
                for (var y:int = 0; y < tetrimino_.length; ++y)
                {
                    if (tetrimino_[x][y])
                    {
                        grid_.setColor(x + this.x, y + this.y, tetriminoType_);
                    }
                }
            }
        }
    }
}
