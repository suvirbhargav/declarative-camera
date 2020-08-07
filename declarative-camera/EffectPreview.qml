import QtQuick 2.0
import QtMultimedia 5.4


Item {
    //property alias source : captureControls.source
    property Camera camera
    signal closed

    id : captureControls

    /*ShaderEffectSource {
        id: theSource
        sourceItem: viewfinder

    }*/

    ShaderEffect {

        //property variant source: theSource
       //ShaderEffectSource { sourceItem: null ; hideSource: true}
       //property variant source: ShaderEffectSource { sourceItem: viewfinder; }

       property variant source: ShaderEffectSource { sourceItem: viewfinder; }
       property real wiggleAmount: 0.025
       property real gamma: 0.5
       property real numColors: 8.0
       property real dividerValue: 1.0
       anchors.fill: parent

       fragmentShader: "
                uniform float dividerValue;
                uniform float gamma;
                uniform float numColors;

                uniform sampler2D source;
                uniform lowp float qt_Opacity;
                varying vec2 qt_TexCoord0;

                void main()
                {
                    vec2 uv = qt_TexCoord0.xy;
                    vec4 c = vec4(0.0);
                    if (uv.x < dividerValue) {
                        vec3 x = texture2D(source, uv).rgb;
                        x = pow(x, vec3(gamma, gamma, gamma));
                        x = x * numColors;
                        x = floor(x);
                        x = x / numColors;
                        x = pow(x, vec3(1.0/gamma));
                        c = vec4(x, 1.0);
                    } else {
                        c = texture2D(source, uv);
                    }
                    gl_FragColor = qt_Opacity * c;
                }
       "
     }


}





