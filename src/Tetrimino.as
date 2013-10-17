package {

    import net.flashpunk.Entity;
    import net.flashpunk.tweens.misc.Alarm;
    import net.flashpunk.utils.Input;
    import net.flashpunk.utils.Key;

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

        private static const iTetriminos_:Array
            = new Array(
                new Array(
                    new Array(0,1,0,0),
                    new Array(0,1,0,0),
                    new Array(0,1,0,0),
                    new Array(0,1,0,0)),
                new Array(
                    new Array(0,0,0,0),
                    new Array(1,1,1,1),
                    new Array(0,0,0,0),
                    new Array(0,0,0,0)),
                new Array(
                    new Array(0,0,1,0),
                    new Array(0,0,1,0),
                    new Array(0,0,1,0),
                    new Array(0,0,1,0)),
                new Array(
                    new Array(0,0,0,0),
                    new Array(0,0,0,0),
                    new Array(1,1,1,1),
                    new Array(0,0,0,0)));

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

            updateGrid();
            gridMove(0, 2);
        }

        public override function update():void
        {
            if (Input.pressed(Key.A))
            {
                rotateCCW();
            }
            if (Input.pressed(Key.D))
            {
                rotateCW();
            }
            if (Input.pressed(Key.DOWN))
            {
                gridMove(0, 1);
            }
            if (Input.pressed(Key.RIGHT))
            {
                gridMove(1, 0);
            }
            if (Input.pressed(Key.LEFT))
            {
                gridMove(-1, 0);
            }
        }

        public function hardDrop():void
        {
        }

        public function gridMove(moveX:int, moveY:int):Boolean
        {
            if (checkOffset(moveX, moveY))
            {
                clearCurrentPosition();
                x += moveX;
                y += moveY;
                updateGrid();

                return true;
            }

            return false;
        }

        public function rotateCW():void
        {
            gridRotate(-1);
        }

        public function rotateCCW():void
        {
            gridRotate(1);
        }

        private function gridRotate(dir:int):void
        {
            if (tetrimino_.length == 2) return; // Don't rotate O block

            clearCurrentPosition();

            var tempTetrimino:Array = tetrimino_;

            if (tetrimino_.length == 4) //Give the I block special treatment
            {
                var index:int;
                if (tetrimino_[0][1]) index = 0 + dir
                else if (tetrimino_[1][0]) index = 1 + dir;
                else if (tetrimino_[0][2]) index = 2 + dir;
                else if (tetrimino_[2][0]) index = 3 + dir;

                if (index < 0) index = 3;
                else if (index > 3) index = 0;

                tetrimino_ = iTetriminos_[index];
            }
            else
            {
                // Create a new grid
                var newTetrimino:Array = new Array(tetrimino_[0].length);

                for (var i:int = 0; i < tetrimino_[0].length; ++i)
                {
                    newTetrimino[i] = new Array(tetrimino_.length);
                }

                // Rotate the old grid into the new one
                var rotX:int;
                var rotY:int;
                for (var x:int = 0; x < tetrimino_.length; ++x)
                {
                    const transX:int = x - (tetrimino_.length - 1) / 2;
                    for (var y:int = 0; y < tetrimino_[x].length; ++y)
                    {
                        const transY:int = y - (tetrimino_.length - 1) / 2;

                        rotX = dir * transY;
                        rotY = - dir * transX;

                        newTetrimino[rotX + (tetrimino_.length - 1) / 2]
                                    [rotY + (tetrimino_.length - 1) / 2]
                                    = tetrimino_[x][y];
                    }
                }

                tetrimino_ = newTetrimino;
            }

            // Check that the new position is valid, attempt a "kick", and move
            // back if still not valid
            if (!checkOffset())
            {
                if (!gridMove(1,0) && !gridMove(-1,0))
                {
                    clearCurrentPosition();

                    tetrimino_ = tempTetrimino;
                }
            }

            updateGrid();
        }

        private function checkOffset(offX:int = 0, offY:int = 0):Boolean
        {
            clearCurrentPosition(); // Don't collide with myself
            for (var x:int = 0; x < tetrimino_.length; ++x)
            {
                for (var y:int = 0; y < tetrimino_[x].length; ++y)
                {
                    if (tetrimino_[x][y])
                    {
                        if (grid_.isTaken(x + this.x + offX, y + this.y + offY))
                        {
                            updateGrid(); // Redraw myself
                            return false;
                        }
                    }
                }
            }

            updateGrid(); // Redraw myself
            return true;
        }

        private function clearCurrentPosition():void
        {
            for (var x:int = 0; x < tetrimino_.length; ++x)
            {
                for (var y:int = 0; y < tetrimino_[x].length; ++y)
                {
                    if (tetrimino_[x][y])
                    {
                        grid_.setColor(x + this.x, y + this.y, 0);
                    }
                }
            }
        }

        private function updateGrid():void
        {
            for (var x:int = 0; x < tetrimino_.length; ++x)
            {
                for (var y:int = 0; y < tetrimino_[x].length; ++y)
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
