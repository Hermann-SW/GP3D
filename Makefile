
sphere_embedding:
	name=graphs/C36.10.a gp -q < sphere_embedding.gp

demo:
	gp -q < demo.gp
	diff gp.jscad gp.jscad.good

demo2:
	gp -q < demo2.gp

demo3:
	gp -q < demo3.gp

tqf_3D.1:
	gp -q < tqf_3D.1.gp

tqf_3D.3:
	gp -q < tqf_3D.3.gp

tqf_3D.2:
	gp -q < tqf_3D.2.gp

clean:
	rm gp.jscad
