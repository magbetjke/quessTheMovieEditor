package events {
import flash.events.Event;

public class BlockEvent extends Event {
    
    public static const COUNT_CHANGE:String = 'countChange';
    public static const MOVIE_COUNT_CHANGE:String = 'movieCountChange';

    public function BlockEvent(type:String):void {
        super(type);
    }
}
}