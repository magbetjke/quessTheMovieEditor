package models {
import data.HintType;
import data.Locales;

import flash.utils.Dictionary;

public class Hint {
    
    public var hintType:String;
    
    private var _imgUrl:String;
    
    private var _hints:Dictionary;

    public function Hint(type:String):void {
        this.hintType = type;
        if (type == HintType.TEXT_HINT){
            _hints = new Dictionary();
            _hints[Locales.RU] = '';
            _hints[Locales.EN] = '';
        }
        
    }
    
    public function setLocText(loc:String, text:String):void {
        if (_hints) {
            _hints[loc] = text;
        }
    }

    public function getLocHint(loc:String):String {
        return _hints[loc];
    }

    public function get imgUrl():String {
        return _imgUrl;
    }

    public function set imgUrl(value:String):void {
        if (_imgUrl == value || hintType != HintType.IMG_HINT)return;

        _imgUrl = value;
    }
}
}