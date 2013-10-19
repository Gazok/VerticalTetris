package {
    import flash.geom.Rectangle;
    import net.flashpunk.Entity;
    import net.flashpunk.graphics.Image;
    import net.flashpunk.graphics.Canvas;

    public class GridSlot extends Entity
    {
        public static const colors:Array
            = new Array(0xFFFFFF, //Inactive/Grey
                        0x5392fc, //Cyan l
                        0xcfd344, //Yellow O
                        0x6242cf, //Purple T
                        0x23923c, //Green S
                        0xd6124b, //Red Z
                        0x3231ca, //Blue J
                        0xc1727c);//Orange L

        private var color_:uint = 0;
        private var visible_:Boolean = true;
        private const block:Image = new Image(A.block);

        public function GridSlot(gridX:int, gridY:int, colorIndex:int = 0)
        {
            super(43 + gridX * (block.width), 8 + gridY * (block.height));
            graphic = block;
            if (gridY < 2)
            {
                visible_ = false;
                block.alpha = 0;
            }

            setColor(colorIndex);

        }

        public function getColor():uint
        {
            return color_;
        }
        public function setColor(index:uint):void
        {
            if (!visible_ || index > colors.size) return;

            color_ = index;
            block.color = colors[index];

            // If index = 0, show transparent outline
            block.alpha = index + 0.05;
        }

        public function isActive():Boolean
        {
            return Boolean(color_);
        }
    }
}
