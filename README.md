# GP3D

This repo provides 3D graphics for PARI/GP, by generating JSCAD output for view+navigate in browser.  


The functions for displaying graph vertices, edges (direct as well as great circle for sqhere embedding), faces, labels, ... are ported from [https://github.com/Hermann-SW/planar_graph_playground](https://github.com/Hermann-SW/planar_graph_playground) repo nodejs implementation.  

This link opens openjscad.xyz with C36 fullerene planar embedding onto the sphere, with user defined menu bottom left for allowing dynamic change of display in addition to zoom/translate/rotate:  
[https://openjscad.xyz/?uri=https://stamm-wilbrandt.de/en/forum/_C36_10.correct.jscad](https://openjscad.xyz/?uri=https://stamm-wilbrandt.de/en/forum/_C36_10.correct.jscad)  

More details on implementation:  
[https://forums.raspberrypi.com/viewtopic.php?t=333342&start=75#p2033996](https://forums.raspberrypi.com/viewtopic.php?t=333342&start=75#p2033996)  

![res/C36.10.fixed.jscad.png](res/C36.10.fixed.jscad.png)  

### workinprogress

New [sphere_embedding.gp](sphere_embedding.gp) draws a graph onto sphere (as of now faces only, vertices+edges next).  
Currently only one demo graph is provided.   

[tools/view_b64](tools/view_b64) views JSCAD file via "data:" URL in browser on https://jscad.app.

Since 1/18/24 "data:" scheme allows to process gzipped base64 encoded URLs as well:  
https://github.com/hrgdavor/jscadui/pull/80  
Currently on a different server only with [tools/view_gzb64](tools/view_gzb64).

```
pi@raspberrypi5:~/GP3D $ name=graphs/C36.10.a gp -q < sphere_embedding.gp 
pi@raspberrypi5:~/GP3D $ tools/view_gzb64 gp.jscad
Opening in existing browser session.
pi@raspberrypi5:~/GP3D $ 
```

During development, just open https://jscad.app, generate gp.jscad outtput and drag+drop onto jscad.app.  
Whenever file gp.jscad gets written (by "wlog()" calls), jscad.app refreshes view automatically.  
You can try yourself online with this 28106 bytes base64 encoded [data URL](https://jscad.app/#data:text/plain;base64,Y29uc3QganNjYWQgPSByZXF1aXJlKCdAanNjYWQvbW9kZWxpbmcnKQpjb25zdCB7IGNvbG9yaXplIH0gPSBqc2NhZC5jb2xvcnMKY29uc3QgeyBjdWJvaWQsIGN1YmUsIHNwaGVyZSwgY3lsaW5kZXIsIGNpcmNsZSwgcG9seWdvbiB9ID0ganNjYWQucHJpbWl0aXZlcwpjb25zdCB7IHJvdGF0ZSwgdHJhbnNsYXRlIH0gPSBqc2NhZC50cmFuc2Zvcm1zCmNvbnN0IHsgZGVnVG9SYWQgfSA9IGpzY2FkLnV0aWxzCmNvbnN0IHsgYWRkLCBub3JtYWxpemUsIGxlbmd0aCwgc2NhbGUsIGRvdCB9ID0ganNjYWQubWF0aHMudmVjMwpjb25zdCB7IGV4dHJ1ZGVSb3RhdGUsIGV4dHJ1ZGVMaW5lYXIgfSA9IHJlcXVpcmUoJ0Bqc2NhZC9tb2RlbGluZycpLmV4dHJ1c2lvbnMKY29uc3QgeyBpbnRlcnNlY3QsIHN1YnRyYWN0LCB1bmlvbiB9ID0gcmVxdWlyZSgnQGpzY2FkL21vZGVsaW5nJykuYm9vbGVhbnMKY29uc3QgeyBodWxsLCBodWxsQ2hhaW4gfSA9IHJlcXVpcmUoJ0Bqc2NhZC9tb2RlbGluZycpLmh1bGxzCmNvbnN0IHsgdmVjdG9yVGV4dCB9ID0gcmVxdWlyZSgnQGpzY2FkL21vZGVsaW5nJykudGV4dApmdW5jdGlvbiBnZXRQYXJhbWV0ZXJEZWZpbml0aW9ucygpIHsKICByZXR1cm4gWwogICAgIHsgbmFtZTogJ2ZhY2VzJywgdHlwZTogJ2Nob2ljZScsIHZhbHVlczogWydQZW50YWdvbnMnLCAnNmNvbG9yaW5nJywgJ05vbmUnXSwgaW5pdGlhbDogJ1BlbnRhZ29ucycsIGNhcHRpb246ICdmYWNlIGNvbG9yaW5nOicgfSwKICAgICx7IG5hbWU6ICd3aGl0ZScsIHR5cGU6ICdjaGVja2JveCcsIGNoZWNrZWQ6IHRydWUsIGluaXRpYWw6ICcyMCcsIGNhcHRpb246ICdzdXJmYWNlIG9mIHNwaGVyZTonIH0sCiAgICAseyBuYW1lOiAnaGFsZicsIHR5cGU6ICdjaGVja2JveCcsIGNoZWNrZWQ6IHRydWUsIGluaXRpYWw6ICcyMCcsIGNhcHRpb246ICdoYWxmIHZlcnRleDonIH0sCiAgICAseyBuYW1lOiAnbG9va19pbnNpZGUnLCB0eXBlOiAnY2hvaWNlJywgdmFsdWVzOiBbJ25vJywgJ3llcyddLCBpbml0aWFsOiAnbm8nLCBjYXB0aW9uOiAnbG9va19pbnNpZGU6JyB9CiAgXTsKfQpmdW5jdGlvbiBtYXBfM0QoYywgc2MpIHsKICByZXR1cm4gW01hdGguY29zKGRlZ1RvUmFkKGNbMF0pKSpNYXRoLnNpbihkZWdUb1JhZChjWzFdKSkqc2MsIE1hdGguc2luKGRlZ1RvUmFkKGNbMF0pKSpNYXRoLnNpbihkZWdUb1JhZChjWzFdKSkqc2MsIE1hdGguY29zKGRlZ1RvUmFkKGNbMV0pKSpzY10KfQplcHMgPSAwLjAwMDAxMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMApzYyA9IDYuMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMApjb29yZHMgPSBbWzEwNS45NDU3ODM2NTU0OTU3NzAwMDAwMDAwMDAwMDAwMDAwMDAwMCwgODkuMDE0NzMzNzkyNDMyMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwXSwgWzEyOS4wNTUwMDE5MjgxNTg0MDAwMDAwMDAwMDAwMDAwMDAwMDAwMCwgMTA3LjczNjQwNjUxMTIxMzE5MDAwMDAwMDAwMDAwMDAwMDAwMDAwXSwgWzEyMi4zMDk3MjM5MjQyMzk5MzAwMDAwMDAwMDAwMDAwMDAwMDAwMCwgMTI3LjcxMjMyMzU1NzI0MjY3MDAwMDAwMDAwMDAwMDAwMDAwMDAwXSwgWzE4MCwgMTQ3LjE1ODYzMzgwOTY1Mjc3MDAwMDAwMDAwMDAwMDAwMDAwMDAwXSwgWzE4MCwgMTY5LjA1Mjg3NzkzNjU1MDkwMDAwMDAwMDAwMDAwMDAwMDAwMDAwXSwgWzIyNSwgOTBdLCBbMjQ1LjEwMzkwOTM2MTAxNzEwMDAwMDAwMDAwMDAwMDAwMDAwMDAwLCA3MS4wMzA5MzYyODY0MDcyNDAwMDAwMDAwMDAwMDAwMDAwMDAwMDBdLCBbMjcwLCA1NC43MzU2MTAzMTcyNDUzNDYwMDAwMDAwMDAwMDAwMDAwMDAwMDBdLCBbMjcwLCAzMi44NDEzNjYxOTAzNDcyMTAwMDAwMDAwMDAwMDAwMDAwMDAwMDBdLCBbMjcwLCAxMC45NDcxMjIwNjM0NDkwNjgwMDAwMDAwMDAwMDAwMDAwMDAwMDBdLCBbOTAsIDEwLjk0NzEyMjA2MzQ0OTA2ODAwMDAwMDAwMDAwMDAwMDAwMDAwMF0sIFs5MCwgMzIuODQxMzY2MTkwMzQ3MjEwMDAwMDAwMDAwMDAwMDAwMDAwMDAwXSwgWzkwLCA1NC43MzU2MTAzMTcyNDUzNDYwMDAwMDAwMDAwMDAwMDAwMDAwMDBdLCBbMTEzLjE4NTE1Nzg5Nzc0NDY1MDAwMDAwMDAwMDAwMDAwMDAwMDAwLCA3MC41MzQyOTY0ODAxMjY0MTAwMDAwMDAwMDAwMDAwMDAwMDAwMDBdLCBbNzUuNTk3MTkxMTQwNTg0MzAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwLCA4OC43NzM0OTgzODU5NTYzNDAwMDAwMDAwMDAwMDAwMDAwMDAwMDBdLCBbNjkuNTMzMDA0MTU2ODEyNzgwMDAwMDAwMDAwMDAwMDAwMDAwMDAwLCA2Ny40NTA5Mjc2Nzk3NDYzMzAwMDAwMDAwMDAwMDAwMDAwMDAwMDBdLCBbNTIuNzg4MDUxNTc1NzQyNDYwMDAwMDAwMDAwMDAwMDAwMDAwMDAwLCA4Mi4yODI5MTQ4Nzk5OTU1MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDBdLCBbMzcuMjExOTQ4NDI0MjU3NTQwMDAwMDAwMDAwMDAwMDAwMDAwMDAwLCA5Ny43MTcwODUxMjAwMDQ1MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDBdLCBbMzM0LjQxOTAyMzY1NTAwMzc0MDAwMDAwMDAwMDAwMDAwMDAwMDAwLCA3OS4wNjQwMjgyNzQwMDE3MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDBdLCBbMzM2LjA0NTEyMjU0MDc1MzU0MDAwMDAwMDAwMDAwMDAwMDAwMDAwLCAxMDYuNjMzNjMzNTExNjUzMzkwMDAwMDAwMDAwMDAwMDAwMDAwMDBdLCBbMzEzLjcxNjM0Mzk2NzI1NjkwMDAwMDAwMDAwMDAwMDAwMDAwMDAwLCAxMTUuNTcyNDgyNTc4MjAzODYwMDAwMDAwMDAwMDAwMDAwMDAwMDBdLCBbMCwgMTY5LjA1Mjg3NzkzNjU1MDkwMDAwMDAwMDAwMDAwMDAwMDAwMDAwXSwgWzAsIDE0Ny4xNTg2MzM4MDk2NTI3NzAwMDAwMDAwMDAwMDAwMDAwMDAwMF0sIFs1Ny44NzQxNjk4NDQ1NjE0MjAwMDAwMDAwMDAwMDAwMDAwMDAwMDAsIDEyOC4yNDE5MzAzNTA4NjIwNTAwMDAwMDAwMDAwMDAwMDAwMDAwMF0sIFs1MS4zMTI3ODU2MDk0NDQyOTAwMDAwMDAwMDAwMDAwMDAwMDAwMDAsIDEwOS44NTQ4MzM2ODU2OTA3MDAwMDAwMDAwMDAwMDAwMDAwMDAwMF0sIFsyMC40NjY5OTU4NDMxODcyMTcwMDAwMDAwMDAwMDAwMDAwMDAwMDAsIDExMi41NDkwNzIzMjAyNTM2NDAwMDAwMDAwMDAwMDAwMDAwMDAwMF0sIFswLCAxMjUuMjY0Mzg5NjgyNzU0NjUwMDAwMDAwMDAwMDAwMDAwMDAwMDBdLCBbMjI4LjkzNDI4NjEyMjA2NDY2MDAwMDAwMDAwMDAwMDAwMDAwMDAwLCA1OS41OTIzMzY2MDU4MjI0NDAwMDAwMDAwMDAwMDAwMDAwMDAwMDBdLCBbMjE2LjMwMTU2ODU1MDQ5MTU0MDAwMDAwMDAwMDAwMDAwMDAwMDAwLCAzOS4wMzkwMzU5NDExMDc5NTQwMDAwMDAwMDAwMDAwMDAwMDAwMDBdLCBbMTQ5Ljk3MDQxOTUyOTQwOTkwMDAwMDAwMDAwMDAwMDAwMDAwMDAwLCA0Ni41Nzc2NDkxNTQwNTIzNTAwMDAwMDAwMDAwMDAwMDAwMDAwMDBdLCBbMTQzLjYwOTY5MDAzNzczODE4MDAwMDAwMDAwMDAwMDAwMDAwMDAwLCA2Ny44NTI1NDUzMzA3MDE5MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDBdLCBbMTY3LjY3MzQ5MjY4NjA2MDA2MDAwMDAwMDAwMDAwMDAwMDAwMDAwLCA4Ni40NDU2OTAzNTc5MjY5NTAwMDAwMDAwMDAwMDAwMDAwMDAwMDBdLCBbMTU4LjkwOTQ5ODIwNDczOTQ2MDAwMDAwMDAwMDAwMDAwMDAwMDAwLCAxMDYuNDgyMTYyMTgzOTY0OTIwMDAwMDAwMDAwMDAwMDAwMDAwMDBdLCBbMTgwLCAxMjUuMjY0Mzg5NjgyNzU0NjUwMDAwMDAwMDAwMDAwMDAwMDAwMDBdLCBbMjA0Ljg5NjA5MDYzODk4MjkwMDAwMDAwMDAwMDAwMDAwMDAwMDAwLCAxMDguOTY5MDYzNzEzNTkyNzUwMDAwMDAwMDAwMDAwMDAwMDAwMDBdLCBbMjAwLjUwMTI4OTgxNTcwMjUzMDAwMDAwMDAwMDAwMDAwMDAwMDAwLCA4NS4wMDIzNjM1NTkxMTQwMzAwMDAwMDAwMDAwMDAwMDAwMDAwMDBdXQpmdW5jdGlvbiB2ZXJ0ZXgoX3YsIGhhbGY9ZmFsc2UpIHsKICAgIHAgPSBjb29yZHNbX3ZdIAogICAgdiA9IG1hcF8zRChwLHNjKQogICAgcyA9IHNwaGVyZSh7cmFkaXVzOiAwLjUsIGNlbnRlcjogdn0pCiAgICBpZiAoaGFsZikgewogICAgICAgIGxhMSA9IGRlZ1RvUmFkKHBbMF0pCiAgICAgICAgcGgxID0gZGVnVG9SYWQoOTAgLSBwWzFdKQogICAgICAgIHJldHVybiBjb2xvcml6ZShbMCwgMC43LCAwXSwKICAgICAgICAgICAgc3VidHJhY3QocywKICAgICAgICAgICAgICAgIHRyYW5zbGF0ZShbMCwgMCwgMF0sCiAgICAgICAgICAgICAgICAgICAgcm90YXRlKFswLCAwLCBsYTFdLAogICAgICAgICAgICAgICAgICAgICAgICByb3RhdGUoWzAsIC1waDEsIDBdLAogICAgICAgICAgICAgICAgICAgICAgICAgICAgdHJhbnNsYXRlKFtzYyswLjUsIDBdLAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJvdGF0ZShbZGVnVG9SYWQoOTApLCAwLCBkZWdUb1JhZCg5MCldLAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB0cmFuc2xhdGUoWy0wLCAtMCwgLTFdLAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGN1Ym9pZCh7c2l6ZTogWzEsIDEsIDAuOF19KQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICApCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKQogICAgICAgICAgICAgICAgICAgICAgICAgICAgKQogICAgICAgICAgICAgICAgICAgICAgICApCiAgICAgICAgICAgICAgICAgICAgKQogICAgICAgICAgICAgICAgKQogICAgICAgICAgICApCiAgICAgICAgKQogICAgfSBlbHNlIHsKICAgICAgICByZXR1cm4gY29sb3JpemUoWzAsIDAuNywgMF0sIHMpCiAgICB9Cn0KZnVuY3Rpb24gdHh0KG1lc2csIHcpIHsKICAgIGNvbnN0IGxpbmVSYWRpdXMgPSB3IC8gMgogICAgY29uc3QgbGluZUNvcm5lciA9IGNpcmNsZSh7IHJhZGl1czogbGluZVJhZGl1cyB9KQoKICAgIGNvbnN0IGxpbmVTZWdtZW50UG9pbnRBcnJheXMgPSB2ZWN0b3JUZXh0KHsgeDogMCwgeTogMCwgaGVpZ2h0OiAwLjI1LCBpbnB1dDogbWVzZyB9KQoKICAgIGNvbnN0IGxpbmVTZWdtZW50cyA9IFtdCiAgICBsaW5lU2VnbWVudFBvaW50QXJyYXlzLmZvckVhY2goZnVuY3Rpb24oc2VnbWVudFBvaW50cykgewogICAgICAgIGNvbnN0IGNvcm5lcnMgPSBzZWdtZW50UG9pbnRzLm1hcCgocG9pbnQpID0+IHRyYW5zbGF0ZShwb2ludCwgbGluZUNvcm5lcikpCiAgICAgICAgbGluZVNlZ21lbnRzLnB1c2goaHVsbENoYWluKGNvcm5lcnMpKQogICAgfSkKICAgIGNvbnN0IG1lc3NhZ2UyRCA9IHVuaW9uKGxpbmVTZWdtZW50cykKICAgIHJldHVybiBleHRydWRlTGluZWFyKHsgaGVpZ2h0OiB3IH0sIG1lc3NhZ2UyRCkKfQpmdW5jdGlvbiB2dHh0KF9wMSwgbnVtKSB7CiAgICBzdHIgPSBudW0udG9TdHJpbmcoKQogICAgcDEgPSBjb29yZHNbX3AxXQogICAgbGExID0gZGVnVG9SYWQocDFbMF0pCiAgICBwaDEgPSBkZWdUb1JhZCg5MCAtIHAxWzFdKQogICAgcmV0dXJuIHRyYW5zbGF0ZShbMCwgMCwgMF0sCiAgICAgICAgcm90YXRlKFswLCAwLCBsYTFdLAogICAgICAgICAgICByb3RhdGUoWzAsIC1waDEsIDBdLAogICAgICAgICAgICAgICAgdHJhbnNsYXRlKFtzYyswLjUsIDAuMTUtMC4yNSpzdHIubGVuZ3RoXSwKICAgICAgICAgICAgICAgICAgICByb3RhdGUoW2RlZ1RvUmFkKDkwKSwgMCwgZGVnVG9SYWQoOTApXSwKICAgICAgICAgICAgICAgICAgICAgICAgY29sb3JpemUoWzAsIDAsIDBdLAogICAgICAgICAgICAgICAgICAgICAgICAgICAgdHh0KHN0ciwgMC4wNSkKICAgICAgICAgICAgICAgICAgICAgICAgKQogICAgICAgICAgICAgICAgICAgICkKICAgICAgICAgICAgICAgICkKICAgICAgICAgICAgKQogICAgICAgICkKICAgICkKfQpmdW5jdGlvbiBlZGdlKF92LCBfdywgX2UpIHsKICAgIHYgPSBtYXBfM0QoY29vcmRzW192XSwgc2MpCiAgICB3ID0gbWFwXzNEKGNvb3Jkc1tfd10sIHNjKQogICAgZCA9IFswLCAwLCAwXQogICAgeCA9IFswLCAwLCAwXQogICAganNjYWQubWF0aHMudmVjMy5zdWJ0cmFjdChkLCB3LCB2KQogICAgYWRkKHgsIHYsIHcpCiAgICBzY2FsZSh3LCB4LCAwLjUpCiAgaWYgKGxlbmd0aChkKSA+PSBlcHMpIHsKICAgIHJldHVybiBjb2xvcml6ZShbMCwgMCwgMSwgMV0sIAogICAgICAgIHRyYW5zbGF0ZSh3LCAKICAgICAgICAgICAgcm90YXRlKFswLCBNYXRoLmFjb3MoZFsyXS9sZW5ndGgoZCkpLCBNYXRoLmF0YW4yKGRbMV0sIGRbMF0pXSwKICAgICAgICAgICAgICAgIGN5bGluZGVyKHtyYWRpdXM6IDAuMSwgaGVpZ2h0OiBsZW5ndGgoZCl9KQogICAgICAgICAgICApCiAgICAgICAgKQogICAgKQogIH0gZWxzZSB7CiAgICByZXR1cm4gY3ViZSh7c2l6ZTogMC4wMX0pCiAgfQp9CmZ1bmN0aW9uIGVkZ2UyKF9wMSwgX3AyLCBfZSkgewogICAgcDEgPSBjb29yZHNbX3AxXQogICAgcDIgPSBjb29yZHNbX3AyXQogICAgLy8gYWwvbGEvcGg6IGFscGhhL2xhbWJkYS9waGkgfCBseHkvc3h5OiBkZWx0YSBsYW1iZGFfeHkvc2lnbWFfeHkKICAgIC8vIGh0dHBzOi8vZW4ud2lraXBlZGlhLm9yZy93aWtpL0dyZWF0LWNpcmNsZV9uYXZpZ2F0aW9uI0NvdXJzZQogICAgbGExID0gZGVnVG9SYWQocDFbMF0pCiAgICBsYTIgPSBkZWdUb1JhZChwMlswXSkKICAgIGwxMiA9IGxhMiAtIGxhMQogICAgcGgxID0gZGVnVG9SYWQoOTAgLSBwMVsxXSkKICAgIHBoMiA9IGRlZ1RvUmFkKDkwIC0gcDJbMV0pCiAgICBhbDEgPSBNYXRoLmF0YW4yKE1hdGguY29zKHBoMikqTWF0aC5zaW4obDEyKSwgTWF0aC5jb3MocGgxKSpNYXRoLnNpbihwaDIpLU1hdGguc2luKHBoMSkqTWF0aC5jb3MocGgyKSpNYXRoLmNvcyhsMTIpKQogICAgLy8gZGVsdGEgc2lnbWFfMTIKICAgIC8vIGh0dHBzOi8vZW4ud2lraXBlZGlhLm9yZy93aWtpL0dyZWF0LWNpcmNsZV9kaXN0YW5jZSNGb3JtdWxhZQogICAgczEyID0gTWF0aC5hY29zKE1hdGguc2luKHBoMSkqTWF0aC5zaW4ocGgyKStNYXRoLmNvcyhwaDEpKk1hdGguY29zKHBoMikqTWF0aC5jb3MobDEyKSkKICAgIHJldHVybiByb3RhdGUoWzAsIDAsIGxhMV0sCiAgICAgICAgcm90YXRlKFswLCAtcGgxLCAwXSwKICAgICAgICAgICAgcm90YXRlKFtkZWdUb1JhZCg5MCktYWwxLCAwLCAwXSwKICAgICAgICAgICAgICAgIGNvbG9yaXplKFswLCAwLCAwLjddLAogICAgICAgICAgICAgICAgICAgIGV4dHJ1ZGVSb3RhdGUoe3NlZ21lbnRzOiAzMiwgYW5nbGU6IHMxMn0sCiAgICAgICAgICAgICAgICAgICAgICAgIGNpcmNsZSh7cmFkaXVzOiAwLjEsIGNlbnRlcjogW3NjLDBdfSkKICAgICAgICAgICAgICAgICAgICApCiAgICAgICAgICAgICAgICApCiAgICAgICAgICAgICkKICAgICAgICApCiAgICApCn0KZnVuY3Rpb24gc3BfdHJpYTIociwgdGFuZywgcGFuZywgdGhpLCBwb2ludHMsIHNlZ21lbnRzKSB7CiAgICBjb25zdCBjb29yZHMgPSBbXQogICAgcHRzMiA9IE1hdGgudHJ1bmMocG9pbnRzIC8gMikKICAgIAogICAgZm9yKGkgPSAwOyBpPHB0czI7IGk9aSsxKSB7CiAgICAgICAgdGggPSBpKih0YW5nLyhwdHMyLTEpKQogICAgICAgIGNvb3Jkcy5wdXNoKFsoci10aGkvMikqTWF0aC5zaW4odGgpLCAoci10aGkvMikqTWF0aC5jb3ModGgpXSkKICAgIH0KICAgIGZvcihpID0gcHRzMi0xOyBpPj0wOyBpPWktMSkgewogICAgICAgIHRoID0gaSoodGFuZy8ocHRzMi0xKSkKICAgICAgICBjb29yZHMucHVzaChbKHIrdGhpLzIpKk1hdGguc2luKHRoKSwgKHIrdGhpLzIpKk1hdGguY29zKHRoKV0pCiAgICB9CiAgICByZXR1cm4gZXh0cnVkZVJvdGF0ZSh7c2VnbWVudHM6IHNlZ21lbnRzLCBhbmdsZTogcGFuZ30sIAogICAgICAgIHBvbHlnb24oe3BvaW50czogY29vcmRzfSkKICAgICkKfQpmdW5jdGlvbiBzcF90cmlhKF9wMSwgX3AyLCBfcDMsIHN1YikgewogICAgcDEgPSBjb29yZHNbX3AxXQogICAgcDIgPSBjb29yZHNbX3AyXQogICAgcDMgPSBjb29yZHNbX3AzXQogICAgLy8gYWwvbGEvcGg6IGFscGhhL2xhbWJkYS9waGkgfCBseHkvc3h5OiBkZWx0YSBsYW1iZGFfeHkvc2lnbWFfeHkKICAgIC8vIGh0dHBzOi8vZW4ud2lraXBlZGlhLm9yZy93aWtpL0dyZWF0LWNpcmNsZV9uYXZpZ2F0aW9uI0NvdXJzZQogICAgbGExID0gZGVnVG9SYWQocDFbMF0pCiAgICBsYTIgPSBkZWdUb1JhZChwMlswXSkKICAgIGxhMyA9IGRlZ1RvUmFkKHAzWzBdKQogICAgbDEyID0gbGEyIC0gbGExCiAgICBsMTMgPSBsYTMgLSBsYTEKICAgIGwzMiA9IGxhMiAtIGxhMwogICAgbDIzID0gbGEzIC0gbGEyCiAgICBsMzEgPSBsYTEgLSBsYTMKICAgIHBoMSA9IGRlZ1RvUmFkKDkwIC0gcDFbMV0pCiAgICBwaDIgPSBkZWdUb1JhZCg5MCAtIHAyWzFdKQogICAgcGgzID0gZGVnVG9SYWQoOTAgLSBwM1sxXSkKICAgIGFsMTIgPSBNYXRoLmF0YW4yKE1hdGguY29zKHBoMikqTWF0aC5zaW4obDEyKSwgTWF0aC5jb3MocGgxKSpNYXRoLnNpbihwaDIpLU1hdGguc2luKHBoMSkqTWF0aC5jb3MocGgyKSpNYXRoLmNvcyhsMTIpKQogICAgYWwxMyA9IE1hdGguYXRhbjIoTWF0aC5jb3MocGgzKSpNYXRoLnNpbihsMTMpLCBNYXRoLmNvcyhwaDEpKk1hdGguc2luKHBoMyktTWF0aC5zaW4ocGgxKSpNYXRoLmNvcyhwaDMpKk1hdGguY29zKGwxMykpCiAgICBhbDMxID0gTWF0aC5hdGFuMihNYXRoLmNvcyhwaDEpKk1hdGguc2luKGwzMSksIE1hdGguY29zKHBoMykqTWF0aC5zaW4ocGgxKS1NYXRoLnNpbihwaDMpKk1hdGguY29zKHBoMSkqTWF0aC5jb3MobDMxKSkKICAgIGFsMzIgPSBNYXRoLmF0YW4yKE1hdGguY29zKHBoMikqTWF0aC5zaW4obDMyKSwgTWF0aC5jb3MocGgzKSpNYXRoLnNpbihwaDIpLU1hdGguc2luKHBoMykqTWF0aC5jb3MocGgyKSpNYXRoLmNvcyhsMzIpKQogICAgLy8gZGVsdGEgc2lnbWFfeHkKICAgIC8vIGh0dHBzOi8vZW4ud2lraXBlZGlhLm9yZy93aWtpL0dyZWF0LWNpcmNsZV9kaXN0YW5jZSNGb3JtdWxhZQogICAgczEyID0gTWF0aC5hY29zKE1hdGguc2luKHBoMSkqTWF0aC5zaW4ocGgyKStNYXRoLmNvcyhwaDEpKk1hdGguY29zKHBoMikqTWF0aC5jb3MobDEyKSkKICAgIHMyMyA9IE1hdGguYWNvcyhNYXRoLnNpbihwaDIpKk1hdGguc2luKHBoMykrTWF0aC5jb3MocGgyKSpNYXRoLmNvcyhwaDMpKk1hdGguY29zKGwyMykpCiAgICBzMTMgPSBNYXRoLmFjb3MoTWF0aC5zaW4ocGgxKSpNYXRoLnNpbihwaDMpK01hdGguY29zKHBoMSkqTWF0aC5jb3MocGgzKSpNYXRoLmNvcyhsMTMpKQoKICAgIGlmIChzMTMgPCBzMTIpIHsKICAgICAgICBpZiAoczEyID49IHMyMykgewogICAgICAgICAgICByZXR1cm4gc3BfdHJpYShfcDEsIF9wMywgX3AyLCBzdWIpCiAgICAgICAgfSBlbHNlIHsKICAgICAgICAgICAgcmV0dXJuIHNwX3RyaWEoX3AyLCBfcDEsIF9wMywgc3ViKQogICAgICAgIH0KICAgIH0gZWxzZSB7CiAgICAgICAgaWYgKHMxMyA8IHMyMykgewogICAgICAgICAgICByZXR1cm4gc3BfdHJpYShfcDIsIF9wMSwgX3AzLCBzdWIpCiAgICAgICAgfSBlbHNlIGlmIChNYXRoLmFicyhzMTMtczEyLXMyMykgPj0gZXBzKSB7CiAgICAgICAgICAgIGZ1bmN0aW9uIG1waShhbmcpIHsgcmV0dXJuIChhbmcgPCAtTWF0aC5QSSkgPyAyKk1hdGguUEkgKyBhbmcgOiAoKGFuZyA+IE1hdGguUEkpID8gYW5nIC0gMipNYXRoLlBJIDogYW5nKSB9CgogICAgICAgICAgICB2MSA9IG1hcF8zRChwMSwgMSkKICAgICAgICAgICAgdjIgPSBtYXBfM0QocDIsIDEpCiAgICAgICAgICAgIHYzID0gbWFwXzNEKHAzLCAxKQogICAgICAgICAgICBtcyA9IFswLCAwLCAwXQogICAgICAgICAgICBtczIgPSBbMCwgMCwgMF0KICAgICAgICAgICAgc3YxPVswLCAwLCAwXQogICAgICAgICAgICBzdjI9WzAsIDAsIDBdCiAgICAgICAgICAgIHN2Mz1bMCwgMCwgMF0KICAgICAgICAgICAgczE9WzAsIDAsIDBdCiAgICAgICAgICAgIHMyPVswLCAwLCAwXQogICAgICAgICAgICBzMz1bMCwgMCwgMF0KICAgICAgICAgICAgYWRkKG1zLCB2MSwgdjIpCiAgICAgICAgICAgIGFkZChtcywgbXMsIHYzKQogICAgICAgICAgICBub3JtYWxpemUobXMyLCBtcykKICAgICAgICAgICAgbWkgPSBNYXRoLm1pbihkb3QodjEsIG1zMiksIGRvdCh2MiwgbXMyKSwgZG90KHYzLCBtczIpKQoKICAgICAgICAgICAgc2NhbGUoc3YxLCB2MSwgc2MpCiAgICAgICAgICAgIHNjYWxlKHN2MiwgdjIsIHNjKQogICAgICAgICAgICBzY2FsZShzdjMsIHYzLCBzYykKICAgICAgICAgICAgc2NhbGUoczEsIHN2MSwgMS9taSkKICAgICAgICAgICAgc2NhbGUoczIsIHN2MiwgMS9taSkKICAgICAgICAgICAgc2NhbGUoczMsIHN2MywgMS9taSkKCiAgICAgICAgICAgIHJldHVybiBjb2xvcml6ZShbMC41LCAwLjUsIDAuNV0sCiAgICAgICAgICAgICAgICBzdWJ0cmFjdCgKICAgICAgICAgICAgICAgICAgICBpbnRlcnNlY3QoCiAgICAgICAgICAgICAgICAgICAgICAgIHVuaW9uKAogICAgICAgICAgICAgICAgICAgICAgICAgICAgdHJhbnNsYXRlKFswLCAwLCAwXSwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICByb3RhdGUoWzAsIDAsIGxhMS1kZWdUb1JhZCgxODApXSwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcm90YXRlKFswLCBwaDEtZGVnVG9SYWQoOTApLCAwXSwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJvdGF0ZShbMCwwLC1hbDEzXSwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzcF90cmlhMihzYywgczEyLCBtcGkoYWwxMy1hbDEyKSwgMC4xLCAyNCwgMzApCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICApCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICkKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICApCiAgICAgICAgICAgICAgICAgICAgICAgICAgICApLAogICAgICAgICAgICAgICAgICAgICAgICAgICAgdHJhbnNsYXRlKFswLCAwLCAwXSwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICByb3RhdGUoWzAsIDAsIGxhMy1kZWdUb1JhZCgxODApXSwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcm90YXRlKFswLCBwaDMtZGVnVG9SYWQoOTApLCAwXSwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJvdGF0ZShbMCwgMCwgLWFsMzFdLAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNwX3RyaWEyKHNjLCBzMjMsIG1waShhbDMxLWFsMzIpLCAwLjEsIDI0LCAzMCkKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICkKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICkKICAgICAgICAgICAgICAgICAgICAgICAgICAgICkKICAgICAgICAgICAgICAgICAgICAgICAgKSwKICAgICAgICAgICAgICAgICAgICAgICAgaHVsbCgKICAgICAgICAgICAgICAgICAgICAgICAgICAgIGN1YmUoe2NlbnRlcjogc3YxLCBzaXplOiAwLjAxfSkKICAgICAgICAgICAgICAgICAgICAgICAgICAgICxjdWJlKHtjZW50ZXI6IHN2Miwgc2l6ZTogMC4wMX0pCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAsY3ViZSh7Y2VudGVyOiBzdjMsIHNpemU6IDAuMDF9KQogICAgICAgICAgICAgICAgICAgICAgICAgICAgLGN1YmUoe2NlbnRlcjogczEsIHNpemU6IDAuMDF9KQogICAgICAgICAgICAgICAgICAgICAgICAgICAgLGN1YmUoe2NlbnRlcjogczIsIHNpemU6IDAuMDF9KQogICAgICAgICAgICAgICAgICAgICAgICAgICAgLGN1YmUoe2NlbnRlcjogczMsIHNpemU6IDAuMDF9KQogICAgICAgICAgICAgICAgICAgICAgICApCiAgICAgICAgICAgICAgICAgICApCiAgICAgICAgICAgICAgICAgICAsc3ViKQogICAgICAgICAgICAgICAgKQogICAgICAgIH0gZWxzZSB7CiAgICAgICAgICAgIHJldHVybiBjdWJlKHtzaXplOiAwLjAxfSkKICAgICAgICB9CiAgICB9Cn0KZnVuY3Rpb24gbWFpbihwYXJhbXMpIHsKICAgIHN1YiA9IFtjdWJlKHtzaXplOiAocGFyYW1zLmxvb2tfaW5zaWRlID09PSAneWVzJyk/c2MrMC4xOjAuMDEsIGNlbnRlcjogW3NjLzIsLXNjLzIsc2MvMl19KV0KcGVudGFnb25zID0gKHBhcmFtcy5mYWNlcyAhPT0gJ1BlbnRhZ29ucycpID8gW10gOiBbW10KLHNwX3RyaWEoIDEzICwgMCAsIDE0ICwgc3ViKQosc3BfdHJpYSggMTMgLCAxNCAsIDE1ICwgc3ViKQosc3BfdHJpYSggMTMgLCAxNSAsIDEyICwgc3ViKQosc3BfdHJpYSggMiAsIDEgLCAzMiAsIHN1YikKLHNwX3RyaWEoIDIgLCAzMiAsIDMzICwgc3ViKQosc3BfdHJpYSggMiAsIDMzICwgMyAsIHN1YikKLHNwX3RyaWEoIDQgLCAzICwgMzMgLCBzdWIpCixzcF90cmlhKCA0ICwgMzMgLCAzNCAsIHN1YikKLHNwX3RyaWEoIDQgLCAzNCAsIDUgLCBzdWIpCixzcF90cmlhKCAyMSAsIDQgLCA1ICwgc3ViKQosc3BfdHJpYSggMjEgLCA1ICwgNiAsIHN1YikKLHNwX3RyaWEoIDIxICwgNiAsIDIwICwgc3ViKQosc3BfdHJpYSggOCAsIDcgLCAyNyAsIHN1YikKLHNwX3RyaWEoIDggLCAyNyAsIDI4ICwgc3ViKQosc3BfdHJpYSggOCAsIDI4ICwgOSAsIHN1YikKLHNwX3RyaWEoIDEwICwgOSAsIDI4ICwgc3ViKQosc3BfdHJpYSggMTAgLCAyOCAsIDI5ICwgc3ViKQosc3BfdHJpYSggMTAgLCAyOSAsIDExICwgc3ViKQosc3BfdHJpYSggMTYgLCAxMCAsIDExICwgc3ViKQosc3BfdHJpYSggMTYgLCAxMSAsIDEyICwgc3ViKQosc3BfdHJpYSggMTYgLCAxMiAsIDE1ICwgc3ViKQosc3BfdHJpYSggMTIgLCAxMSAsIDI5ICwgc3ViKQosc3BfdHJpYSggMTIgLCAyOSAsIDMwICwgc3ViKQosc3BfdHJpYSggMTIgLCAzMCAsIDEzICwgc3ViKQosc3BfdHJpYSggMTggLCAxNyAsIDI1ICwgc3ViKQosc3BfdHJpYSggMTggLCAyNSAsIDI2ICwgc3ViKQosc3BfdHJpYSggMTggLCAyNiAsIDE5ICwgc3ViKQosc3BfdHJpYSggMjAgLCAxOSAsIDI2ICwgc3ViKQosc3BfdHJpYSggMjAgLCAyNiAsIDIyICwgc3ViKQosc3BfdHJpYSggMjAgLCAyMiAsIDIxICwgc3ViKQosc3BfdHJpYSggMjMgLCAyMiAsIDI2ICwgc3ViKQosc3BfdHJpYSggMjMgLCAyNiAsIDI1ICwgc3ViKQosc3BfdHJpYSggMjMgLCAyNSAsIDI0ICwgc3ViKQosc3BfdHJpYSggMzIgLCAzMSAsIDM1ICwgc3ViKQosc3BfdHJpYSggMzIgLCAzNSAsIDM0ICwgc3ViKQosc3BfdHJpYSggMzIgLCAzNCAsIDMzICwgc3ViKQpdCnNpeGNvbCA9IChwYXJhbXMuZmFjZXMgIT09ICc2Y29sb3JpbmcnKSA/IFtdIDogW1tdCiwgY29sb3JpemUoIFswLCAwLjcwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwLCAwLjcwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwXSAsIHNwX3RyaWEoIDAgLCAzMiAsIDEgLCBzdWIpKQosIGNvbG9yaXplKCBbMCwgMC43MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMCwgMC43MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMF0gLCBzcF90cmlhKCAwICwgMzEgLCAzMiAsIHN1YikpCiwgY29sb3JpemUoIFswLCAwLjcwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwLCAwLjcwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwXSAsIHNwX3RyaWEoIDAgLCAzMCAsIDMxICwgc3ViKSkKLCBjb2xvcml6ZSggWzAsIDAuNzAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAsIDAuNzAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDBdICwgc3BfdHJpYSggMCAsIDEzICwgMzAgLCBzdWIpKQosIGNvbG9yaXplKCBbMC45MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMCwgMC5FLTM4LCAwXSAsIHNwX3RyaWEoIDEzICwgMTUgLCAxMiAsIHN1YikpCiwgY29sb3JpemUoIFswLjkwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwLCAwLkUtMzgsIDBdICwgc3BfdHJpYSggMTMgLCAxNCAsIDE1ICwgc3ViKSkKLCBjb2xvcml6ZSggWzAuOTAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAsIDAuRS0zOCwgMF0gLCBzcF90cmlhKCAxMyAsIDAgLCAxNCAsIHN1YikpCiwgY29sb3JpemUoIFswLCAwLCAwLjkwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwXSAsIHNwX3RyaWEoIDE0ICwgMjMgLCAyNCAsIHN1YikpCiwgY29sb3JpemUoIFswLCAwLCAwLjkwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwXSAsIHNwX3RyaWEoIDE0ICwgMiAsIDIzICwgc3ViKSkKLCBjb2xvcml6ZSggWzAsIDAsIDAuOTAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDBdICwgc3BfdHJpYSggMTQgLCAxICwgMiAsIHN1YikpCiwgY29sb3JpemUoIFswLCAwLCAwLjkwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwXSAsIHNwX3RyaWEoIDE0ICwgMCAsIDEgLCBzdWIpKQosIGNvbG9yaXplKCBbMC45MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMCwgMC5FLTM4LCAwXSAsIHNwX3RyaWEoIDIgLCAzMyAsIDMgLCBzdWIpKQosIGNvbG9yaXplKCBbMC45MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMCwgMC5FLTM4LCAwXSAsIHNwX3RyaWEoIDIgLCAzMiAsIDMzICwgc3ViKSkKLCBjb2xvcml6ZSggWzAuOTAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAsIDAuRS0zOCwgMF0gLCBzcF90cmlhKCAyICwgMSAsIDMyICwgc3ViKSkKLCBjb2xvcml6ZSggWzAuNzAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAsIDAsIDAuNzAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDBdICwgc3BfdHJpYSggMjMgLCAyMSAsIDIyICwgc3ViKSkKLCBjb2xvcml6ZSggWzAuNzAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAsIDAsIDAuNzAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDBdICwgc3BfdHJpYSggMjMgLCA0ICwgMjEgLCBzdWIpKQosIGNvbG9yaXplKCBbMC43MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMCwgMCwgMC43MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMF0gLCBzcF90cmlhKCAyMyAsIDMgLCA0ICwgc3ViKSkKLCBjb2xvcml6ZSggWzAuNzAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAsIDAsIDAuNzAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDBdICwgc3BfdHJpYSggMjMgLCAyICwgMyAsIHN1YikpCiwgY29sb3JpemUoIFswLCAwLjcwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwLCAwLjcwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwXSAsIHNwX3RyaWEoIDQgLCAzNCAsIDUgLCBzdWIpKQosIGNvbG9yaXplKCBbMCwgMC43MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMCwgMC43MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMF0gLCBzcF90cmlhKCA0ICwgMzMgLCAzNCAsIHN1YikpCiwgY29sb3JpemUoIFswLCAwLjcwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwLCAwLjcwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwXSAsIHNwX3RyaWEoIDQgLCAzICwgMzMgLCBzdWIpKQosIGNvbG9yaXplKCBbMC45MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMCwgMC5FLTM4LCAwXSAsIHNwX3RyaWEoIDIxICwgNiAsIDIwICwgc3ViKSkKLCBjb2xvcml6ZSggWzAuOTAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAsIDAuRS0zOCwgMF0gLCBzcF90cmlhKCAyMSAsIDUgLCA2ICwgc3ViKSkKLCBjb2xvcml6ZSggWzAuOTAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAsIDAuRS0zOCwgMF0gLCBzcF90cmlhKCAyMSAsIDQgLCA1ICwgc3ViKSkKLCBjb2xvcml6ZSggWzAuNzAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAsIDAsIDAuNzAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDBdICwgc3BfdHJpYSggNiAsIDI3ICwgNyAsIHN1YikpCiwgY29sb3JpemUoIFswLjcwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwLCAwLCAwLjcwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwXSAsIHNwX3RyaWEoIDYgLCAzNSAsIDI3ICwgc3ViKSkKLCBjb2xvcml6ZSggWzAuNzAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAsIDAsIDAuNzAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDBdICwgc3BfdHJpYSggNiAsIDM0ICwgMzUgLCBzdWIpKQosIGNvbG9yaXplKCBbMC43MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMCwgMCwgMC43MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMF0gLCBzcF90cmlhKCA2ICwgNSAsIDM0ICwgc3ViKSkKLCBjb2xvcml6ZSggWzAsIDAuOTAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAsIDBdICwgc3BfdHJpYSggMjAgLCAxOCAsIDE5ICwgc3ViKSkKLCBjb2xvcml6ZSggWzAsIDAuOTAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAsIDBdICwgc3BfdHJpYSggMjAgLCA4ICwgMTggLCBzdWIpKQosIGNvbG9yaXplKCBbMCwgMC45MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMCwgMF0gLCBzcF90cmlhKCAyMCAsIDcgLCA4ICwgc3ViKSkKLCBjb2xvcml6ZSggWzAsIDAuOTAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAsIDBdICwgc3BfdHJpYSggMjAgLCA2ICwgNyAsIHN1YikpCiwgY29sb3JpemUoIFswLjkwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwLCAwLkUtMzgsIDBdICwgc3BfdHJpYSggOCAsIDI4ICwgOSAsIHN1YikpCiwgY29sb3JpemUoIFswLjkwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwLCAwLkUtMzgsIDBdICwgc3BfdHJpYSggOCAsIDI3ICwgMjggLCBzdWIpKQosIGNvbG9yaXplKCBbMC45MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMCwgMC5FLTM4LCAwXSAsIHNwX3RyaWEoIDggLCA3ICwgMjcgLCBzdWIpKQosIGNvbG9yaXplKCBbMC43MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMCwgMCwgMC43MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMF0gLCBzcF90cmlhKCAxOCAsIDE2ICwgMTcgLCBzdWIpKQosIGNvbG9yaXplKCBbMC43MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMCwgMCwgMC43MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMF0gLCBzcF90cmlhKCAxOCAsIDEwICwgMTYgLCBzdWIpKQosIGNvbG9yaXplKCBbMC43MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMCwgMCwgMC43MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMF0gLCBzcF90cmlhKCAxOCAsIDkgLCAxMCAsIHN1YikpCiwgY29sb3JpemUoIFswLjcwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwLCAwLCAwLjcwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwXSAsIHNwX3RyaWEoIDE4ICwgOCAsIDkgLCBzdWIpKQosIGNvbG9yaXplKCBbMCwgMC43MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMCwgMC43MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMF0gLCBzcF90cmlhKCAxMCAsIDI5ICwgMTEgLCBzdWIpKQosIGNvbG9yaXplKCBbMCwgMC43MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMCwgMC43MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMF0gLCBzcF90cmlhKCAxMCAsIDI4ICwgMjkgLCBzdWIpKQosIGNvbG9yaXplKCBbMCwgMC43MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMCwgMC43MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMF0gLCBzcF90cmlhKCAxMCAsIDkgLCAyOCAsIHN1YikpCiwgY29sb3JpemUoIFswLCAwLjkwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwLCAwXSAsIHNwX3RyaWEoIDE2ICwgMTIgLCAxNSAsIHN1YikpCiwgY29sb3JpemUoIFswLCAwLjkwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwLCAwXSAsIHNwX3RyaWEoIDE2ICwgMTEgLCAxMiAsIHN1YikpCiwgY29sb3JpemUoIFswLCAwLjkwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwLCAwXSAsIHNwX3RyaWEoIDE2ICwgMTAgLCAxMSAsIHN1YikpCiwgY29sb3JpemUoIFswLjcwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwLCAwLCAwLjcwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwXSAsIHNwX3RyaWEoIDEyICwgMzAgLCAxMyAsIHN1YikpCiwgY29sb3JpemUoIFswLjcwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwLCAwLCAwLjcwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwXSAsIHNwX3RyaWEoIDEyICwgMjkgLCAzMCAsIHN1YikpCiwgY29sb3JpemUoIFswLjcwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwLCAwLCAwLjcwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwXSAsIHNwX3RyaWEoIDEyICwgMTEgLCAyOSAsIHN1YikpCiwgY29sb3JpemUoIFswLCAwLjcwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwLCAwLjcwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwXSAsIHNwX3RyaWEoIDE1ICwgMTcgLCAxNiAsIHN1YikpCiwgY29sb3JpemUoIFswLCAwLjcwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwLCAwLjcwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwXSAsIHNwX3RyaWEoIDE1ICwgMjUgLCAxNyAsIHN1YikpCiwgY29sb3JpemUoIFswLCAwLjcwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwLCAwLjcwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwXSAsIHNwX3RyaWEoIDE1ICwgMjQgLCAyNSAsIHN1YikpCiwgY29sb3JpemUoIFswLCAwLjcwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwLCAwLjcwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwXSAsIHNwX3RyaWEoIDE1ICwgMTQgLCAyNCAsIHN1YikpCiwgY29sb3JpemUoIFswLjkwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwLCAwLkUtMzgsIDBdICwgc3BfdHJpYSggMTggLCAyNiAsIDE5ICwgc3ViKSkKLCBjb2xvcml6ZSggWzAuOTAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAsIDAuRS0zOCwgMF0gLCBzcF90cmlhKCAxOCAsIDI1ICwgMjYgLCBzdWIpKQosIGNvbG9yaXplKCBbMC45MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMCwgMC5FLTM4LCAwXSAsIHNwX3RyaWEoIDE4ICwgMTcgLCAyNSAsIHN1YikpCiwgY29sb3JpemUoIFswLCAwLjcwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwLCAwLjcwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwXSAsIHNwX3RyaWEoIDIwICwgMjIgLCAyMSAsIHN1YikpCiwgY29sb3JpemUoIFswLCAwLjcwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwLCAwLjcwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwXSAsIHNwX3RyaWEoIDIwICwgMjYgLCAyMiAsIHN1YikpCiwgY29sb3JpemUoIFswLCAwLjcwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwLCAwLjcwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwXSAsIHNwX3RyaWEoIDIwICwgMTkgLCAyNiAsIHN1YikpCiwgY29sb3JpemUoIFswLCAwLjkwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwLCAwXSAsIHNwX3RyaWEoIDIzICwgMjUgLCAyNCAsIHN1YikpCiwgY29sb3JpemUoIFswLCAwLjkwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwLCAwXSAsIHNwX3RyaWEoIDIzICwgMjYgLCAyNSAsIHN1YikpCiwgY29sb3JpemUoIFswLCAwLjkwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwLCAwXSAsIHNwX3RyaWEoIDIzICwgMjIgLCAyNiAsIHN1YikpCiwgY29sb3JpemUoIFswLCAwLjkwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwLCAwXSAsIHNwX3RyaWEoIDI4ICwgMzAgLCAyOSAsIHN1YikpCiwgY29sb3JpemUoIFswLCAwLjkwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwLCAwXSAsIHNwX3RyaWEoIDI4ICwgMzEgLCAzMCAsIHN1YikpCiwgY29sb3JpemUoIFswLCAwLjkwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwLCAwXSAsIHNwX3RyaWEoIDI4ICwgMzUgLCAzMSAsIHN1YikpCiwgY29sb3JpemUoIFswLCAwLjkwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwLCAwXSAsIHNwX3RyaWEoIDI4ICwgMjcgLCAzNSAsIHN1YikpCiwgY29sb3JpemUoIFswLCAwLCAwLjkwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwXSAsIHNwX3RyaWEoIDMyICwgMzQgLCAzMyAsIHN1YikpCiwgY29sb3JpemUoIFswLCAwLCAwLjkwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwXSAsIHNwX3RyaWEoIDMyICwgMzUgLCAzNCAsIHN1YikpCiwgY29sb3JpemUoIFswLCAwLCAwLjkwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwXSAsIHNwX3RyaWEoIDMyICwgMzEgLCAzNSAsIHN1YikpCl0Kd2hpdGUgPSAoIXBhcmFtcy53aGl0ZSkgPyBbXSA6IFtbXQosIGNvbG9yaXplKFsxLDEsMV0sCiAgICAgIHN1YnRyYWN0KAogICAgICAgICAgc3BoZXJlKHtyYWRpdXM6IHNjLCBzZWdtZW50czogMzB9KQogICAgICAgICAgLHNwaGVyZSh7cmFkaXVzOiBzYy0wLjEsIHNlZ21lbnRzOiAzMH0pCiAgICAgICAgICAsc3ViIAogICAgICApCiAgKQpdCiAgICByZXR1cm5bCnBlbnRhZ29ucwosc2l4Y29sCix3aGl0ZQpdIH0KbW9kdWxlLmV4cG9ydHMgPSB7IG1haW4sIGdldFBhcmFtZXRlckRlZmluaXRpb25zIH0K) generated with <kbd>tools/view_b64</kbd>.

![res/workinprogress.png](res/workinprogress.png)


### good enough

Doc will be updated, this is latest.

Generated as "gp.jscad" with:
```
pi@raspberrypi5:~/GP3D $ name=graphs/C36.10.a gp -q < sphere_embedding.gp
pi@raspberrypi5:~/GP3D $  
```
[https://jscad.app/#https://gist.githubusercontent.com/Hermann-SW/b3e85c8fe6827cd29238c14f9da346be/raw/C36.10.fixed.jscad.good_enough.jscad](https://jscad.app/#https://gist.githubusercontent.com/Hermann-SW/b3e85c8fe6827cd29238c14f9da346be/raw/C36.10.fixed.jscad.good_enough.jscad)

![res/C36.10.fixed.jscad.good_enough.png](res/C36.10.fixed.jscad.good_enough.png)
