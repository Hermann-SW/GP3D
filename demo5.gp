readvec("jscad.gp");
jscad.open();
jscad.wlog("const jscad = require('@jscad/modeling')");
jscad.wlog("const { colorize } = jscad.colors");
jscad.wlog("const { cuboid, sphere, ellipsoid } = jscad.primitives");
jscad.wlog("const { rotateX, rotateZ, translate } = jscad.transforms");
jscad.wlog("const { length, scale, create, subtract } = jscad.maths.vec3");
jscad.wlog("const { plane } = jscad.maths");
jscad.wlog("sc = 0");
jscad.wlog("a=",a=eval(getenv("a"))/180*Pi);
jscad.wlog("c=",a=eval(getenv("c")));
jscad.wlog("function main(params) {");
jscad.wlog("  var P=[[Math.sin(a)*Math.cos(c*a),Math.sin(a)*Math.sin(c*a),Math.cos(a)]]");
jscad.wlog("  a+=Math.PI/3");
jscad.wlog("  P.push([Math.sin(a)*Math.cos(c*a),Math.sin(a)*Math.sin(c*a),Math.cos(a)])");
jscad.wlog("  a+=Math.PI/3");
jscad.wlog("  P.push([Math.sin(a)*Math.cos(c*a),Math.sin(a)*Math.sin(c*a),Math.cos(a)])");
jscad.wlog("  var out=[]");
jscad.wlog("  for(v of P)");
jscad.wlog("    out.push(colorize([0.68,0.14,0.14],translate(v,sphere({radius:0.25}))))");
jscad.wlog("  var p=plane.fromNoisyPoints([],...P)");
jscad.wlog("  var o=create()");
jscad.wlog("  scale(o,p.slice(0,3),p[3])");
jscad.wlog("  out.push(colorize([0,0,0],translate(o,sphere({radius:0.1}))))");
jscad.wlog("  for(v of P){");
jscad.wlog("    var d=create()");
jscad.wlog("    if(length(subtract(d,o,v))>sc)");
jscad.wlog("      sc=length(d)");
jscad.wlog("  }");
jscad.wlog("  out.push(");
jscad.wlog("    colorize([0.666,0.666,0.666,0.8],");
jscad.wlog("      translate(o,");
jscad.wlog("        rotateZ(Math.PI/2+Math.atan2(o[1],o[0]),");
jscad.wlog("          rotateX(Math.acos(o[2]/length(o)),");
jscad.wlog("            ellipsoid({radius:[sc+1,sc+1,0.02],segments:360})");
jscad.wlog("          )");
jscad.wlog("        )");
jscad.wlog("      )");
jscad.wlog("    )");
jscad.wlog("  )");
jscad.wlog("  return out");
jscad.wlog("}");
jscad.wlog("module.exports = { main }");
jscad.close();
