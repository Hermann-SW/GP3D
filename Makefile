
demo:
	gp -q < demo.gp
	diff gp.jscad gp.jscad.good

demo2:
	gp -q < demo2.gp

demo3:
	gp -q < demo3.gp

clean:
	rm gp.jscad
