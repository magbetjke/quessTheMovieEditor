package utils {
import flash.utils.Dictionary;

public class XMLUtil {

    public static function createXML(name:String,  params:Object):XML {
        var xml:XML = <{name}/>;
        for (var param:String in params) {
            if (params[param] is Dictionary){
                xml.appendChild(createXML(param,  params[param])); 
            } else {
                var xmlChild:XML = <{param}/>;
                xmlChild.@value = params[param];
                xml.appendChild(xmlChild);
            }
        }
        return xml;
    }
}
}