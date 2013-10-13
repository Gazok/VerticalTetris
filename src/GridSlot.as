package {
    import flash.geom.Rectangle;
    import net.flashpunk.Entity;
    import net.flashpunk.graphics.Image;
    import net.flashpunk.graphics.Canvas;

    public class GridSlot extends Entity
    {
        private const block:Image = new Image(A.block);

        public function GridSlot(gridX:int, gridY:int)
        {
            super(gridX * (1 + block.width), gridY * (1 + block.height));
            graphic = block;
        }

        public function setColor(color:uint):void
        {
            block.color = color;
        }
    }
}
