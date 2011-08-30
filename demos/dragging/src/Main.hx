//
// Flambe - Rapid game development
// https://github.com/aduros/flambe/blob/master/LICENSE.txt

import flambe.display.FillSprite;
import flambe.display.ImageSprite;
import flambe.display.Transform;
import flambe.Entity;
import flambe.System;

class Main
{
    private static function main ()
    {
        System.init();

        _loader = System.loadAssetPack("bootstrap");
        // Add listeners
        _loader.success.connect(onSuccess);
        _loader.error.connect(function (message) {
            trace("Load error: " + message);
        });
        _loader.progress.connect(function () {
            trace("Loading progress... " + _loader.bytesLoaded + " of " + _loader.bytesTotal);
        });
        // Go!
        _loader.start();
    }

    private static function onSuccess ()
    {
        trace("Loading complete!");

        // Add a filled background color
        System.root.addChild(new Entity()
            .add(new FillSprite(0x303030, System.stageWidth, System.stageHeight)));

        for (ii in 0...10) {
            var tentacle = new Entity()
                .add(new ImageSprite(_loader.pack.loadTexture("tentacle.png")))
                .add(new Draggable());
            var sprite = tentacle.get(ImageSprite);
            var xform = tentacle.get(Transform);
            xform.x._ = Math.random() * (System.stageWidth-sprite.getNaturalWidth());
            xform.y._ = Math.random() * (System.stageHeight-sprite.getNaturalHeight());
            xform.scaleX._ = xform.scaleY._ = 0.5 + Math.random()*4;
            xform.rotation._ = Math.random()*90;
            System.root.addChild(tentacle);
        }
    }

    private static var _loader;
}
