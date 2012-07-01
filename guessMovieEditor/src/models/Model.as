package models {
import controllers.BlocksController;

import events.BlockEvent;

import flash.events.Event;

import flash.events.Event;

import flash.events.EventDispatcher;

//Singleton Class

public class Model extends EventDispatcher {

    //-------------Singleton Start--------------//

    private static var _instance:Model;

    public static function get instance():Model {
        if (!_instance) _instance = new Model(new SingletonData());
        return _instance;
    }

    public function Model(singletonData:SingletonData):void {

    }

    //--------------Singleton End---------------//

    public var globalSettings:GlobalSettings = new GlobalSettings();

    public const globalConfigUrl:String = 'configs/global.xml';

    public const blocksConfigUrl:String = 'configs/blocks.xml';

    public const originalImagesUrl:String = 'originalImages/';

    public const movieFramesUrl:String = 'frames/';

    public static const FRAME_WIDTH:Number = 768;
    public static const FRAME_HEIGHT:Number = 576;

    private var _blocks:Array = new Array();
    
    public function get blocks():Array {
        return _blocks;
    }

    public function set blocks(value:Array):void {
        _blocks = value;
    }
}
}

//Private Singleton class

class SingletonData {
    public function SingletonData():void {
        //private class constructor
    }
}