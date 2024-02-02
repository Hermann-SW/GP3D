readvec("jscad.gp");
jscad.open();
jscad.wlog("module.exports=function main(){");
jscad.wlog(" return require('@jscad/modeling').primitives.sphere({radius:10})");
jscad.wlog("}");
jscad.close();
