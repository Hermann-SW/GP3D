readvec("jscad.gp");

assert(b,s)=if(!(b), error(Str(s)));

{
  assert(getenv("mult")!=0);
  mult=eval(getenv("mult"));

  jscad.open();

  jscad.header();
   
  jscad.wlog("function main(params){");

  jscad.wlog("  initfastvertex(colorize(hexToRgb(params.color),
                  params.sphere?sphere({'radius':0.25}):cube({'size':0.5})))");

  jscad.wlog("  return [");
  for(x=1,mult,
    for(y=1,mult,
      for(z=1,mult,
        c=[x,y,z];
        if((x+y+z)%2==1,
          jscad.wlog(",colorize([0,1,0],fastvertex(",c,"))"),
          jscad.wlog(",fastvertex(",c,")")
        )
      )
    )
  );
  jscad.wlog("  ]");
  jscad.wlog("}");

  jscad.wlog("function getParameterDefinitions() {");
  jscad.wlog("  return [");
  jscad.wlog("    ,{ name: 'color', type: 'color', initial: '#FF0000', caption: 'color:' }");
  jscad.wlog("    ,{ name: 'sphere', type: 'checkbox', initial: true, caption: 'sphere:' }");
  jscad.wlog("  ];");
  jscad.wlog("}");

  jscad.wlog("module.exports = { main, getParameterDefinitions }");


  jscad.close();
}
