readvec("jscad.gp");
{
    name=getenv("name");
    A=readvec(name)[1];
    faces=readvec(concat(name,".faces"))[1];
    pent=[f|f<-faces,#f==5];
    M=readvec(concat(name,".M"))[1];
    coords=readvec(concat(name,".coords"))[1];
    col=readvec(concat(name,".col"))[1];

    sc=sqrt(#A);

    jscad.open();
    pal = [ [0.9, 0.0, 0], [0, 0.7, 0.7], [0, 0.9, 0], [0.7, 0, 0.7], [0, 0, 0.9], [0.7, 0.7, 0] ];

    jscad.header(coords, sc);
    jscad.header2();
   
    jscad.wlog("function main(params) {");
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

    jscad.wlog("    return[");

    Ms=vecsort(M[1..4]);
/*
    for(v=1,#A,
        jscad.wlog_(",");
        if(vecsearch(Ms,v),
            jscad.wlog_("colorize([0.7, 0, 0], "));
        jscad.wlog_("vertex(", v, ", params.half)");
        if(vecsearch(Ms,v,jscad.wlog(")");,jscad.wlog(""););
    );
*/
/*
    forall_edges(G, function(e) {
            scad.wlog_(",");
            if (evisited[e]) { scad.wlog_("colorize([1,0.66666,0],"); }
            scad.wlog_("edge2(", source(G, e), ",", target(G, e), ",", e, ")");
            if (evisited[e]) { scad.wlog(")"); } else { scad.wlog(""); }
    });
*/
    jscad.wlog("pentagons");
    jscad.wlog(",sixcol");
    jscad.wlog(",white");

    jscad.wlog("] }");
    jscad.wlog("module.exports = { main, getParameterDefinitions }");

    jscad.close();
}
