
demo:
	gp -q < demo.gp
	diff gp.jscad gp.jscad.good

demo2:
	gp -q < demo2.gp

clean:
	rm gp.jscad
