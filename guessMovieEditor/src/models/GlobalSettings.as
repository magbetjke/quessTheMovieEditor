package models {
import data.Locales;

import events.GlobalEvent;

import flash.events.EventDispatcher;

import flash.utils.Dictionary;

public class GlobalSettings extends EventDispatcher {
    
    private var _k:int = 0;
    private var _l:int = 0;
    private var _filmQuantityPerStar:int = 0;
    private var _defaultLocale:String = Locales.EN;
    private var _howToPlay:Dictionary;
    private var _credits:Dictionary;

    public function GlobalSettings():void {
        init();
    }

    private function init():void {
        _howToPlay = new Dictionary();
        _howToPlay[Locales.EN] = '';
        _howToPlay[Locales.RU] = '';

        _credits = new Dictionary();
        _credits[Locales.EN] = '';
        _credits[Locales.RU] = '';
    }

    public function get defaultLocale():String {
        return _defaultLocale;
    }

    public function set defaultLocale(value:String):void {
        if (_defaultLocale == value) return;
        
        _defaultLocale = value;
        dispatchEvent(new GlobalEvent(GlobalEvent.DATA_CHANGE));
    }

    public function get filmQuantityPerStar():int {
        return _filmQuantityPerStar;
    }

    public function set filmQuantityPerStar(value:int):void {
        if (_filmQuantityPerStar == value) return;
        
        _filmQuantityPerStar = value;
        dispatchEvent(new GlobalEvent(GlobalEvent.DATA_CHANGE));
    }

    public function get l():int {
        return _l;
    }

    public function set l(value:int):void {
        if (_l == value) return;
        
        _l = value;
        dispatchEvent(new GlobalEvent(GlobalEvent.DATA_CHANGE));
    }

    public function get k():int {
        return _k;
    }

    public function set k(value:int):void {
        if (_k == value) return;
        
        _k = value;
        dispatchEvent(new GlobalEvent(GlobalEvent.DATA_CHANGE));
    }

    public function get credits():Dictionary {
        return _credits;
    }

    public function updateCredits(key:String, value:Object):void {
        if (_credits[key] && _credits[key] == value)return;

        _credits[key] = value;
        dispatchEvent(new GlobalEvent(GlobalEvent.DATA_CHANGE));
    }

    public function get howToPlay():Dictionary {
        return _howToPlay;
    }

    public function updateHowTo(key:String, value:Object):void {
        if (_howToPlay[key] && _howToPlay[key] == value)return;

        _howToPlay[key] = value;
        dispatchEvent(new GlobalEvent(GlobalEvent.DATA_CHANGE));
    }
}
}