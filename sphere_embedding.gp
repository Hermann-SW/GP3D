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

    jscad.wlog_("vtype = [");
    for(v=0,#A-1,
        jscad.wlog_(if(v>0,","," "));
        jscad.wlog("[", v, ", coords[", v, "][1].toFixed(1), coords[", v, "][0].toFixed(1)]");
    );
    jscad.wlog("]");

    scad.wlog("tvtxt = (params.vtxt === 'theta') ? 1 : (params.vtxt === 'phi') ? 2 : 0");

    jscad.wlog("vtxts = (params.vtxt === 'None') ? [] : [");
    for(v=0,#A-1,
        jscad.wlog_(if(v>0,","," "));
        jscad.wlog("vtxt(", v, ", vtype[", v, "][tvtxt])");
    );
    jscad.wlog("]");

    jscad.wlog("    return[");

    Ms=vecsort(M[1..4]);
    for(v=0,#A-1,
        jscad.wlog_(",");
        if(vecsearch(Ms,v),
            jscad.wlog_("colorize([0.7, 0, 0], "));
        jscad.wlog_("vertex(", v, ", params.half)");
        if(vecsearch(Ms,v),jscad.wlog_(")"));
        jscad.wlog("");
    );

    MS=vecsort(M);
    for(v=0,#A-1,
        foreach(A[1+v],w,
            if(v<w,
                scad.wlog_(",");
                onM=vecsearch(MS,v)&&vecsearch(MS,w);
                if(onM,jscad.wlog_("colorize([1,0.66666,0],"));
                scad.wlog_("edge2(", v, ",", w, ",", 0, ")");
                if(onM,jscad.wlog_(")"));
                jscad.wlog("");
            );
        );
    );

    jscad.wlog(",pentagons");
    jscad.wlog(",sixcol");
    jscad.wlog(",white");
    jscad.wlog(",vtxts");

    jscad.wlog("] }");
    jscad.wlog("module.exports = { main, getParameterDefinitions }");

    jscad.close();
}
