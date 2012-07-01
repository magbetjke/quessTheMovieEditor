package events {
import flash.events.Event;

public class GlobalEvent extends Event {

    public static const DATA_CHANGE:String = 'dataChange';

    public function GlobalEvent(type:String,  bubbles:Boolean = false, cancelable:Boolean = false):void {
        super(type, bubbles,  cancelable)
    }
}
}