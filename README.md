# GP3D

This repo provides 3D graphics for PARI/GP, by generating JSCAD output for view+navigate in browser.  


The functions for displaying graph vertices, edges (direct as well as great circle for sqhere embedding), faces, labels, ... are ported from [https://github.com/Hermann-SW/planar_graph_playground](https://github.com/Hermann-SW/planar_graph_playground) repo nodejs implementation.  

This link opens openjscad.xyz with C36 fullerene planar embedding onto the sphere, with user defined menu bottom left for allowing dynamic change of display in addition to zoom/translate/rotate:  
[https://openjscad.xyz/?uri=https://stamm-wilbrandt.de/en/forum/C36_10.correct.jscad](https://openjscad.xyz/?uri=https://stamm-wilbrandt.de/en/forum/C36_10.correct.jscad)  

More details on implementation:  
[https://forums.raspberrypi.com/viewtopic.php?t=333342&start=75#p2033996](https://forums.raspberrypi.com/viewtopic.php?t=333342&start=75#p2033996)  

![res/C36.10.fixed.jscad.png](res/C36.10.fixed.jscad.png)  

### workinprogress

```
pi@raspberrypi5:~/GP3D $ make
gp -q < demo.gp
diff gp.jscad gp.jscad.good
pi@raspberrypi5:~/GP3D $ make clean
rm gp.jscad
pi@raspberrypi5:~/GP3D $ cat demo.gp 
readvec("jscad.gp");
jscad.open();
jscad.wlog();
jscad.wlog_(5!,2^7);
jscad.wlog(5!,2^7);
jscad.close();
pi@raspberrypi5:~/GP3D $ 
```
