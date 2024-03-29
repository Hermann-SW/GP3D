⇓ feature|https://openjscad.xyz|https://jscad.app|⇐ APP
:---|:--------------------|:----------------|-
just open link|shows empty model|shows JSCAD logo model
APP/?uri=URL |[demo](https://openjscad.xyz/?uri=https://stamm-wilbrandt.de/en/forum/JSCAD.minimal.js)|−
APP/#URL|[demo](https://openjscad.xyz/#https://stamm-wilbrandt.de/en/forum/JSCAD.minimal.js)|[demo](https://jscad.app/#https://stamm-wilbrandt.de/en/forum/JSCAD.minimal.js)
APP/#data,application/javascript;base64,URL|−|[demo](https://jscad.app/#data:application/javascript;base64,bW9kdWxlLmV4cG9ydHM9ZnVuY3Rpb24gbWFpbigpe3JldHVybiByZXF1aXJlKCdAanNjYWQvbW9kZWxpbmcnKS5wcmltaXRpdmVzLnNwaGVyZSh7cmFkaXVzOiA1MH0pfQ==)|[view_b64](tools/view_b64)
APP/#data,application/gzip;base64,URL|−|[demo](https://jscad.app/#data:application/gzip;base64,H4sICAAAAAAAAzYzAA3KwQ5AMAwA0Luv2I1dxsVFIvErixUV66ZdRSL+nXd+MQU9wMGdExcZF6W5YCITPVJjH4aiTIbhVGRo6mmX2Yc2pgAH0lpblxkjFrxAnOQN/vSwD6gymL577Vt90vGbrWIAAAA=)|[view_gzb64](tools/view_gzb64)
 | | | | ⇑ tool
rendering|✅|✅
smooth rendering|−|✅
 | | | |
drag&drop |✅ |✅ | |
drag&drop render¹|−|✅ | |

¹ automatic render in case drag&drop file gets changed (does not work with firefox)  
![res/Peek_2024-01-31_15-50.gif](res/Peek_2024-01-31_15-50.gif)  

   
Tool usage example of JSCAD file with base64 URL larger than jscad.app 32000 bytes limit:  
```
~/GP3D $ name=graphs/C36.10.a gp -q < sphere_embedding.gp 
~/GP3D $ tools/view_b64 gp.jscad
base64 string too long, use view_gzb64 instead
~/GP3D $ tools/view_gzb64 gp.jscad
Opening in existing browser session.
~/GP3D $ 
```

hit 32KB demo with smooth render|JSCAD logo without smooth render
-|-
![res/hit32KB_demo.smooth.jpg](res/hit32KB_demo.smooth.jpg)| ![res/JSCAD_logo.non-smooth.jpg](res/JSCAD_logo.non-smooth.jpg)
