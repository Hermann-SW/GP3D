
verify:
	gp -q < demo.gp
	diff gp.jscad gp.jscad.good

clean:
	rm gp.jscad
