package utils {

import flash.display.BitmapData;
import flash.filesystem.File;
    import flash.filesystem.FileMode;
    import flash.filesystem.FileStream;
import flash.geom.Rectangle;
import flash.utils.ByteArray;

    import mx.graphics.codec.JPEGEncoder;
    import mx.graphics.codec.PNGEncoder;

    public class FileUtil {
        public static function loadText(file:File):String {
            var fileStream:FileStream = new FileStream();
            fileStream.open(file, FileMode.READ);
            var text:String = fileStream.readUTFBytes(fileStream.bytesAvailable);
            fileStream.close();
            return text;
        }

        public static function loadXML(file:File):XML {
            return new XML(loadText(file));
        }

        public static function saveXML(xml:XML, file:File):void {
            saveText("<?xml version=\"1.0\"?>\n" + xml.toXMLString(), file);
        }

        public static function saveText(text:String, file:File):void {
            if (file.exists) file.deleteFile();
            var fileStream:FileStream = new FileStream();
            fileStream.open(file, FileMode.WRITE);
            fileStream.writeUTFBytes(text);
            fileStream.close();
        }

        public static function savePNG(bitmapData:BitmapData, file:File):void {
            var pngenc:PNGEncoder = new PNGEncoder();
            saveByteArray(pngenc.encode(bitmapData), file)
        }

        public static function saveJPG(bitmapData:BitmapData, file:File):void {
            var pngenc:JPEGEncoder = new JPEGEncoder();
            saveByteArray(pngenc.encode(bitmapData), file)
        }
        
        public static function saveJXR(bitmapData:BitmapData, file:File):void {
            var byteArray:ByteArray = new ByteArray();
            //bitmapData.encode(new Rectangle(0, 0, bitmapData.width, bitmapData.height), new JPEGXREncoderOptions(), byteArray);
            saveByteArray(byteArray, file);
        }

        public static function saveByteArray(ba:ByteArray, file:File):void {
            if (file.exists) file.deleteFile();
            var fileStream:FileStream = new FileStream();
            fileStream.open(file, FileMode.WRITE);
            fileStream.writeBytes(ba, 0, ba.bytesAvailable);
            fileStream.close();
        }

        public static function loadByteArray(file:File):ByteArray {
            var ba:ByteArray = new ByteArray();
            var fileStream:FileStream = new FileStream();
            fileStream.open(file, FileMode.READ);
            fileStream.readBytes(ba, 0, fileStream.bytesAvailable);
            fileStream.close();
            return ba;
        }

        public static function copyFolderConent(from:File, to:File):void {
            var list:Array = from.getDirectoryListing();
            for each(var f:File in list) {
                f.copyTo(to.resolvePath(f.name), true);
            }
        }
    }
}