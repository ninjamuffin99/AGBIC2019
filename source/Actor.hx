import flixel.FlxSprite;

class Actor extends FlxSprite
{
    public var name:String = "";

    public function new (?X:Float = 0, ?Y:Float = 0)
    {
        super(X, Y);
    }
}