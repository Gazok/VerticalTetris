package {
    import flash.geom.Rectangle;
    import net.flashpunk.Entity;
    import net.flashpunk.FP;
    import net.flashpunk.graphics.Canvas;

    public class TetrisGrid extends Entity
    {
        private const gridWidth_:int = 10;
        private const gridHeight_:int = 22;
        private var grid_:Array = new Array(gridWidth_);

        private var bucket_:Array = new Array(0);

        public function TetrisGrid()
        {
            for (var i:int = 0; i < gridWidth_; ++i)
            {
                grid_[i] = new Array(gridHeight_);

                for (var j:int = 0; j < gridHeight_; ++j)
                {
                    grid_[i][j] = new GridSlot(i, j);
                    grid_[i][j].setColor(0);
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

            addTetrimino();
        }

        // Featuring Fisher-Yates Random Shuffle
        public function addTetrimino():void
        {
            //if(bucket_.length == 0)
            {
                var bucket_:Array = new Array(1,2,3,4,5,6,7);

                for (var i:int = bucket_.length - 1; i >= 0; --i)
                {
                    // Random number
                    var j:int = Math.floor(Math.random() * i);

                    // store the ith value
                    var temp:int = bucket_[i];
                    // put whatever is in index j in the ith position
                    bucket_[i] = bucket_[j];
                    // restore whatever was in the ith position to index j
                    bucket_[j] = temp;
                }
            }

            var tetriminoIndex:int = bucket_.pop();

            world.add(new Tetrimino(tetriminoIndex, this));
        }

        public function isTaken(x:int, y:int):Boolean
        {
            if (x < 0 || y < 0 || x >= gridWidth_ || y >= gridHeight_)
            {
                return true;
            }

            return grid_[x][y].getColor();
        }

        public function setColor(x:int, y:int, colorIndex:uint):void
        {
            if (x < 0 || y < 0 || x >= gridWidth_ || y >= gridHeight_) return;

            grid_[x][y].setColor(colorIndex);
        }

        public function refresh():void
        {
            var filledLine:Boolean;
            for (var x:int = 0; x < gridWidth_; ++x)
            {
                filledLine = true;
                for (var y:int = 6; y < gridHeight_; ++y)
                {
                    filledLine &&= grid_[x][y].isActive();
                }

                if (filledLine)
                {
                    clearLine(x);
                }
            }
        }

        private function clearLine(clearX:int):void
        {
            if(clearX < 0 || clearX >= gridWidth_) return;

            for(var x:int = clearX; x < gridWidth_ - 1; ++x)
            {
                for(var y:int = 0; y < gridHeight_; ++y)
                {
                    grid_[x][y].setColor(grid_[x+1][y].getColor());
                }
            }

            for (var y2:int = 0; y2 < gridHeight_; ++y2)
            {
                grid_[gridWidth_ - 1][y2].setColor(0);
            }
        }
    }
}
