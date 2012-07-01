package models {
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Loader;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.events.SecurityErrorEvent;
import flash.filesystem.File;
import flash.net.URLRequest;

import mx.controls.Alert;

public class Movie implements IIdEntity {

    private var _id:String;
    
    public var title:String;
    
    public var frameUrl:String;
    
    private var _maxHints:int = 3;
    
    public var imgUrl:String;
    
    [Bindable]
    public var imgBD:BitmapData;
    
    private var _loader:Loader;
    
    public var hints:Vector.<Hint> = new <Hint>[];
    
    public function Movie(id:String):void {
        _id = id;
    }

    public function get id():String {
        return _id;
    }
    
    public function get valid():Boolean {
        return title && imgBD;
    }
    
    public function loadBD():void {
        _loader = new Loader();
        var file:File = File.applicationStorageDirectory;
        file = file.resolvePath(Model.instance.movieFramesUrl + imgUrl);
        if (!file.exists)return;
        var urlReq:URLRequest = new URLRequest(file.url);
        _loader.contentLoaderInfo.addEventListener(Event.COMPLETE, imgLoaded);
        _loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onError);
        _loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onError);
        _loader.load(urlReq);
        
    }

    private function onError(event:IOErrorEvent):void {
        Alert.show('wrong URL');
        disposeLoader();
    }


    private function imgLoaded(event:Event):void {
        imgBD = (_loader.content as Bitmap).bitmapData;
        disposeLoader();
    }

    private function disposeLoader():void {
        _loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, imgLoaded);
        _loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onError);
        _loader.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onError);
        _loader = null;
    }
}
}