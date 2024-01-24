readvec("jscad.gp");
readvec("undirected_graph.gp");
{
    name=getenv("name");
    [V,E]=ugraph(name);
    faces=readvec(concat(name,".faces"))[1];
    pent=[f|f<-faces,#f==5];
    M=readvec(concat(name,".M"))[1];
    coords=readvec(concat(name,".coords"))[1];
    col=readvec(concat(name,".col"))[1];

    sc=sqrt(#V);

    jscad.open();
    pal = [ [0.9, 0.0, 0], [0, 0.7, 0.7], [0, 0.9, 0], [0.7, 0, 0.7], [0, 0, 0.9], [0.7, 0.7, 0] ];

    jscad.header(coords, sc);
    jscad.header2();
   
    jscad.wlog("function main(params) {");
    jscad.wlog("    t0=new Date().getTime()");
    jscad.wlog("    sub = [cube({size: (params.look_inside === 'yes')?sc+0.1:0.01, center: [sc/2,-sc/2,sc/2]})]");

    jscad.wlog("pentagons = (params.faces !== 'Pentagons') ? [] : [[]");
    foreach(pent,face,
        jscad.wlog(",sp_tria(", face[1], ",", face[2], ",", face[3], ", sub)");
        jscad.wlog(",sp_tria(", face[1], ",", face[3], ",", face[4], ", sub)");
        jscad.wlog(",sp_tria(", face[1], ",", face[4], ",", face[5], ", sub)");
    );
    jscad.wlog("]");

    jscad.wlog("sixcol = (params.faces !== '6coloring') ? [] : [[]");
    my(i=0);
    foreach(faces,face,
        i+=1;
        forstep(j=#face-1,2,-1,
            jscad.wlog(", colorize(", pal[1+col[i]], ", sp_tria(", face[1],",", face[j], ",", face[j+1], ", sub))");
        );
    );
    jscad.wlog("]");

    jscad.wlog("white = (!params.white) ? [] : [[]");
    jscad.wlog(", colorize([1,1,1],");
    jscad.wlog("      subtract(");
    jscad.wlog("          sphere({radius: sc, segments: 30})");
    jscad.wlog("          ,sphere({radius: sc-0.1, segments: 30})");
    jscad.wlog("          ,sub ");
    jscad.wlog("      )");
    jscad.wlog("  )");
    jscad.wlog("]");

    jscad.wlog_("vtype = [");
    foreach(V,v,
        jscad.wlog_(if(v!=V[1],","," "));
        jscad.wlog("[", v, ", coords[", v, "][1].toFixed(1), coords[", v, "][0].toFixed(1)]");
    );
    jscad.wlog("]");

    scad.wlog("tvtxt = (params.vtxt === 'theta') ? 1 : (params.vtxt === 'phi') ? 2 : 0");

    jscad.wlog("vtxts = (params.vtxt === 'None') ? [] : [");
    foreach(V,v,
        jscad.wlog_(if(v!=V[1],","," "));
        jscad.wlog("vtxt(", v, ", vtype[", v, "][tvtxt])");
    );
    jscad.wlog("]");

    jscad.wlog("    ret = [");

    Ms=vecsort(M[1..4]);
    MS=vecsort(M);
    foreach(V,v,
        jscad.wlog_(",");
        if(vecsearch(Ms,v),
            jscad.wlog_("colorize([0.7, 0, 0], "));
        jscad.wlog_("vertex(", v, if(vecsearch(MS,v),", false)",", params.half)"));
        if(vecsearch(Ms,v),jscad.wlog_(")"));
        jscad.wlog("");
    );

    foreach(E,e,[v,w]=e;
        scad.wlog_(",");
        onM=vecsearch(MS,v)&&vecsearch(MS,w);
        if(onM,jscad.wlog_("colorize([1,0.66666,0],"));
        scad.wlog_("edge2(", v, ",", w, ",", 0, ")");
        if(onM,jscad.wlog_(")"));
        jscad.wlog("");
    );

    jscad.wlog(",pentagons");
    jscad.wlog(",sixcol");
    jscad.wlog(",white");
    jscad.wlog(",vtxts");

    jscad.wlog("]");
    jscad.wlog("console.log(\"dt=\"+(new Date().getTime()-t0)+\"ms\")");
    jscad.wlog("return ret }");

    jscad.wlog("function getParameterDefinitions() {");
    jscad.wlog("  return [");
    jscad.wlog("     { name: 'faces', type: 'choice', values: ['Pentagons', '6coloring', 'None'], initial: 'Pentagons', caption: 'face coloring:' },");
    jscad.wlog("    ,{ name: 'white', type: 'checkbox', checked: true, initial: '20', caption: 'surface of sphere:' },");
    jscad.wlog("    ,{ name: 'half', type: 'checkbox', checked: true, initial: '20', caption: 'half vertex:' },");
    jscad.wlog("    ,{ name: 'vtxt', type: 'choice', values: ['Id', 'theta', 'phi', 'None'], initial: 'Id', caption: 'vtxt:' },");
    jscad.wlog("    ,{ name: 'look_inside', type: 'choice', values: ['no', 'yes'], initial: 'no', caption: 'look_inside:' }");
    jscad.wlog("  ];");
    jscad.wlog("}");

    jscad.wlog("module.exports = { main, getParameterDefinitions }");

    jscad.close();
}
