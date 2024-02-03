readvec("jscad.gp");

assert(b,s)=if(!(b), error(Str(s)));

{
  assert(getenv("n")!=0);
  n=eval(getenv("n"));

  jscad.open();

  jscad.header();
   
  jscad.wlog("module.exports=function main(){");

  jscad.wlog("  initfastvertex(colorize([1,0,0],sphere({'radius':0.25})))");

  jscad.wlog("  return [");
  for(x=1,n,
    for(y=1,n,
      for(z=1,n,
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

  jscad.close();
}
