package
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Text; //we want to use text
	//import net.flashpunk.utils.Input;
	//import net.flashpunk.utils.Key;

	public class Highscore extends Entity
	{
		private var highscore:Text;
		
		public function Highscore( x:int = 0, y:int = 0)
		{
			highscore = new Text("snbslkdjfnhsd", x, y) ;
			graphic = highscore;
			//public function updateTextBuffer():void;
			//Show Highscore?
			//Does a loop whereby it outputs score from array
			//Goes to next stored score and draws it down incrementally.
		}
		/*
		override public function update():void
		{
			//Want to draw text containing current score whilst game is playing
			//add(new Text(text:String = "hello world", x:Number = 10, y:Number = 10, options:Object = null, h:Number = 0));
			public function updateTextBuffer():void;
		}
		
		override public function begin():void
        {
			//I have no idea what im doing
            public function set text(value:String):void;
        }*/
	}
}