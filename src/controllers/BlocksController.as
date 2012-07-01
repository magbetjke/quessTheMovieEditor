package controllers {
import events.BlockEvent;

import flash.events.EventDispatcher;

import models.Block;
import models.IIdEntity;
import models.Model;
import models.Movie;

import utils.IdUtil;

//Singleton Class

public class BlocksController extends EventDispatcher {

    //-------------Singleton Start--------------//

    private static var _instance:BlocksController;

    public static function get instance():BlocksController {
        if (!_instance) _instance = new BlocksController(new SingletonData());
        return _instance;
    }

    public function BlocksController(singletonData:SingletonData):void {
    }

    //--------------Singleton End---------------//
    
    private var _model:Model = Model.instance;
    
    public function createBlock():void {
        var block:Block = new Block(IdUtil.resolveNextId(_model.blocks));
        _model.blocks.push(block);
        dispatchEvent(new BlockEvent(BlockEvent.COUNT_CHANGE));
    }
    
    public function removeBlock(blockId:String):void {
        var index:int = getItemIndexById(blockId, _model.blocks);
        if (index != -1){
            _model.blocks.splice(index, 1);
            dispatchEvent(new BlockEvent(BlockEvent.COUNT_CHANGE));
        }
    }

    public function addMovieToBlock(blockId:String):void {
        var index:int = getItemIndexById(blockId, _model.blocks);
        if (index != -1){
            var block:Block = _model.blocks[index];
            var movie:Movie = new Movie(IdUtil.resolveNextId(block.movies));
            block.movies.push(movie);
            dispatchEvent(new BlockEvent(BlockEvent.MOVIE_COUNT_CHANGE));
            block.updateCount();
        }
    }
    
    public function removeMovieFromBlock(movieId:String, blockId:String):void {
        var blockIndex:int = getItemIndexById(blockId, _model.blocks);
        if (blockIndex != -1){
            var block:Block = Block(_model.blocks[blockIndex]);
            var movieIndex:int = getItemIndexById(movieId, block.movies);
            if (movieIndex == -1)return;
            block.movies.splice(movieIndex, 1);
            dispatchEvent(new BlockEvent(BlockEvent.MOVIE_COUNT_CHANGE));
            block.updateCount();
        }
    }



    private function getItemIndexById(id:String,  arr:Array):int {
        for each (var item:IIdEntity in arr) {
            if (item.id == id){
                return arr.indexOf(item);
            }
        }
        return -1;
    }
        
}
}

//Private Singleton class

class SingletonData {
    public function SingletonData():void {
        //private class constructor
    }
}