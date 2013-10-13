package {
    import flash.geom.Rectangle;
    import net.flashpunk.Entity;
    import net.flashpunk.graphics.Image;
    import net.flashpunk.graphics.Canvas;

    public class GridSlot extends Entity
    {
        public static const colors:Array
            = new Array(0xFFFFFF, //Inactive/Grey
                        0x5392fc, //Cyan
                        0xcfd344, //Yellow
                        0x6242cf, //Purple
                        0x23923c, //Green
                        0xd6124b, //Red
                        0x3231ca, //Blue
                        0xc1727c);//Orange

        private var color_:uint = 0;
        private const block:Image = new Image(A.block);

        public function GridSlot(gridX:int, gridY:int, colorIndex:int = 0)
        {
            super(gridX * (1 + block.width), gridY * (1 + block.height));
            graphic = block;
            setColor(colorIndex);
        }

        public function getColor():uint
        {
            return color_;
        }
        public function setColor(index:uint):void
        {
            color_ = index;
            block.alpha = index;
            block.color = colors[index];
        }

        public function isActive():Boolean
        {
            return Boolean(color_);
        }
    }
}
