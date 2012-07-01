package renderers {
import mx.controls.Label;

public class BlockIdRenderer extends Label {

    public function BlockIdRenderer():void {
    }

    override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void {
        super.updateDisplayList(unscaledWidth, unscaledHeight);

        trace(data);
    }
}
}
