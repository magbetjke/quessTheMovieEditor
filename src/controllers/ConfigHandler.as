package controllers {
import data.Locales;

import events.GlobalEvent;

import flash.errors.IOError;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.filesystem.File;
import flash.filesystem.FileMode;
import flash.filesystem.FileStream;

import models.Block;

import models.Model;

import utils.FileUtil;
import utils.XMLUtil;

//Singleton Class

public class ConfigHandler {

    //-------------Singleton Start--------------//

    private static var _instance:ConfigHandler;

    public static function get instance():ConfigHandler {
        if (!_instance) _instance = new ConfigHandler(new SingletonData());
        return _instance;
    }

    public function ConfigHandler(singletonData:SingletonData):void {
    }

    //--------------Singleton End---------------//
    
    private var _model:Model = Model.instance;
    
    public function init():void {
        readConfigs();
    }

    private var _globalConfigPath:File = File.applicationStorageDirectory;
    
    private var _blocksConfigPath:File = File.applicationStorageDirectory;
    
    private function readConfigs():void {
        
        readGlobalConfig();
        readBlocksConfig();
        
        addListeners();

    }
    
    private function readGlobalConfig():void { 
        _globalConfigPath = _globalConfigPath.resolvePath(_model.globalConfigUrl);
        if (_globalConfigPath.exists){
            var xml:XML = FileUtil.loadXML(_globalConfigPath);
            parseGlobalConfig(xml);
        } else {
            saveGlobalConfig();
        }
    }
    
    private function readBlocksConfig():void {
        _blocksConfigPath = _blocksConfigPath.resolvePath(_model.blocksConfigUrl);
        if (_blocksConfigPath.exists){
            var xml:XML = FileUtil.loadXML(_blocksConfigPath);
            parseBlocksConfig(xml);
        } else {
            saveBlocksConfig();
        }
    }
    
    

    private function addListeners():void {
        _model.globalSettings.addEventListener(GlobalEvent.DATA_CHANGE, saveGlobalConfig);
    }

    private function parseGlobalConfig(xml:XML):void {
        if (!xml){
            saveGlobalConfig();
            return;
        }

        _model.globalSettings.k = xml.k.@value;
        _model.globalSettings.l = xml.l.@value;
        _model.globalSettings.defaultLocale = xml.defaultLocale.@value;
        _model.globalSettings.credits[Locales.EN] = xml.credits[Locales.EN].@value;
        _model.globalSettings.credits[Locales.RU] = xml.credits[Locales.RU].@value;
        _model.globalSettings.howToPlay[Locales.EN] = xml.howToPlay[Locales.EN].@value;
        _model.globalSettings.howToPlay[Locales.RU] = xml.howToPlay[Locales.RU].@value;
        _model.globalSettings.filmQuantityPerStar = xml.filmQuantityPerStar.@value;

    }
    
    private function parseBlocksConfig(xml:XML):void {
        if (!xml){
            saveBlocksConfig();
            return;
        }

        for each (var block:XML in xml.blocks.block) {
            var newBlock:Block = new Block(block.id.@value);
            newBlock.price =  block.price.@value;
            newBlock.resolvePrice =  block.resolvePrice.@value;
                    
            //Проверка на целостность XML с фильмами   block.count
            
            _model.blocks.push(newBlock);
        }
        
        
        
    }
    
    private function saveBlocksConfig():void {
        var xml:XML = <blocks/>;
        for each (var block:Block in _model.blocks) {
            xml.appendChild(XMLUtil.createXML('block', 
                                              {
                                                  id: block.id, 
                                                  price: block.price,
                                                  resolvePrice: block.resolvePrice,
                                                  count: block.count
                                              }))
            
        }
                
        FileUtil.saveXML(xml, _blocksConfigPath);
    }
    
    private function saveGlobalConfig(event:GlobalEvent = null):void {
        var xml:XML = XMLUtil.createXML('config',
                                        {
                                            k: _model.globalSettings.k,
                                            l: _model.globalSettings.l,
                                            filmQuantityPerStar: _model.globalSettings.filmQuantityPerStar,
                                            defaultLocale: _model.globalSettings.defaultLocale,
                                            credits:  _model.globalSettings.credits,
                                            howToPlay:  _model.globalSettings.howToPlay
                                        });

                
        FileUtil.saveXML(xml, _globalConfigPath);
    }
}
}

//Private Singleton class

class SingletonData {
    public function SingletonData():void {
        //private class constructor
    }
}