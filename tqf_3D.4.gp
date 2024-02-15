readvec("jscad.gp");

assert(b,s)=if(!(b), error(Str(s)));

{
    jscad.open();

    jscad.header(10);
   
    jscad.wlog("function main(params) {");

    jscad.wlog("m = Math.floor(Math.sqrt(params.n))");
    jscad.wlog("out = []");
    jscad.wlog("for(x=-m;x<=m;++x)");
    jscad.wlog("  for(y=-m;y<=m;++y)");
    jscad.wlog("    for(z=-m;z<=m;++z)");
    jscad.wlog("      if (x*x+y*y+z*z<=params.n)");
    jscad.wlog("        out.push(colorize(palette[2],fastvertex([x,y,z])))");

    jscad.wlog("return hull(out) }");

    jscad.wlog("function getParameterDefinitions() {");
    jscad.wlog("  return [");
    jscad.wlog("    { name: 'n', type: 'slider', initial: 42, min: 3, max: 100, step: 1, caption: 'n:' },");
    jscad.wlog("  ]");
    jscad.wlog("}");

    jscad.wlog("module.exports = { main, getParameterDefinitions }");

    jscad.close();
}
