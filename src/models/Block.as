package models {
import flash.events.Event;
import flash.events.EventDispatcher;

public class Block extends EventDispatcher implements IIdEntity{
    
    private var _id:String; 
    
    public var price:Number = 0;
    
    public var resolvePrice:Number = 0;

    private var _count:int = 0;

    public var movies:Array = new Array();

    public function Block(id:String):void {
        _id = id;
    }

    public function get id():String {
        return _id;
    }

    [Bindable]
    public function get count():int {
        return _count;
    }

    public function set count(value:int):void {
        if (_count == value)return;

        _count = value;
    }

    public function updateCount():void {
        count = movies.length;
    }

    public function updateMovies():void {
        for each (var movie:Movie in movies) {
            movie.loadBD();
        }
    }
}
}