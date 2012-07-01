package utils {
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.geom.Matrix;

public class BitmapUtil {

    public static function cropBitmapData(bitmapData:BitmapData, width:Number, height:Number):BitmapData {
        var originalW:Number = bitmapData.width;
        var originalH:Number = bitmapData.height;
        var scale:Number = width / originalW;
        var matrix:Matrix = new Matrix();
        matrix.scale(scale,  scale);
        var bd:BitmapData = new BitmapData(width, height);
        bd.draw(bitmapData, matrix, null, null, null, true);
        return bd;
    }
}
}