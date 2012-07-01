package utils {
import models.IIdEntity;

public class IdUtil {

    public static var idSize:int = 4;
    
    public static function resolveNextId(ids:Object):String {
        var resultId:String = '0000';
        for each (var itemId:IIdEntity in ids) {
            if (itemId.id > resultId)resultId = itemId.id;
        }
        resultId = (Number(resultId) + 1).toString();
        var length:Number = idSize - resultId.length;
        for (var i:int = 0; i < length; i++) {
             resultId = '0' + resultId;
        }
        
        return resultId;
    }

    public function IdUtil():void {
    }
}
}