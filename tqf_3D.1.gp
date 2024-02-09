readvec("jscad.gp");
readvec("utils.gp");

assert(b,s)=if(!(b), error(Str(s)));

get_tqf(n)={
    assert(n%4!=0);
    assert(n%8!=7);
    my(Q,v,b,p,a12);
    if(n%4==2,
        for(vv=0,oo,
            if(ispseudoprime((4*vv+1)*n-1),
                v=vv; break()));
        b=4*v+1;
        p=b*n-1;
        assert(kronecker(-b,p)==1);
        a12=lift(sqrt(Mod(-b,p)));
        ,
        my(c=4-(n%4));
        assert(((c*n-1)/2)%2==1);
        for(vv=0,oo,
            if(ispseudoprime(((8*vv+c)*n-1)/2),
                v=vv; break()));
        b=8*v+c;
        p=(b*n-1)/2;
        assert(kronecker(-b,p)==1);
        my(r0=lift(sqrt(Mod(-b,p))));
        a12=abs(r0-(1-(r0%2))*p));
    [(b+a12^2)/(b*n-1),a12,1;a12,b*n-1,0;1,0,n];
}

{
    assert(getenv("n")!=0);
    n=eval(getenv("n"));
    assert(n%4!=0&&n%8!=7);

    Q=qflllgram(get_tqf(n))^-1;
    M=Q~*Q;
    S=[x|x<-Vec(qfminim(M,n)[3]),qfeval(M,x)==n];
    S=concat(S,-S);

    sc=sqrt(n);
    coords=[conv((Q*s)~/sc)|s<-S];
    V=[0..#coords-1];


    jscad.open();

    jscad.header(sc);
    jscad.header1(coords);
    jscad.header2();
   
    jscad.wlog("function main(params) {");

    jscad.wlog("sub = [cube({size: (params.look_inside === 'yes')?sc+0.1:0.01, center: [sc/2,sc/2,sc/2]})]");

    jscad.wlog("white = (!params.white) ? [] : [[]");
    jscad.wlog(", colorize([1,1,1,params.alpha],");
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
        jscad.wlog(",vtxt(", v, ", vtype[", v, "][tvtxt])");
    );
    jscad.wlog("]");

    jscad.wlog("    return[");

    foreach(V,v,
        jscad.wlog(",vertex(", v, ",params.half)");
    );

    jscad.wlog(",white");
    jscad.wlog(",vtxts");

    jscad.wlog("] }");

    jscad.wlog("function getParameterDefinitions() {");
    jscad.wlog("  return [");
    jscad.wlog("    { name: 'white', type: 'checkbox', initial: true, caption: 'surface of sphere:' },");
    jscad.wlog("    { name: 'alpha', type: 'slider', initial: 0.8, min: 0, max: 1, step: 0.1, caption: 'alpha:' },");
    jscad.wlog("    { name: 'half', type: 'checkbox', initial: true, caption: 'half vertex:' },");
    jscad.wlog("    { name: 'vtxt', type: 'choice', values: ['Id', 'theta', 'phi', 'None'], initial: 'Id', caption: 'vtxt:' },");
    jscad.wlog("    { name: 'look_inside', type: 'choice', values: ['no', 'yes'], initial: 'yes', caption: 'look_inside:' }");
    jscad.wlog("  ];");
    jscad.wlog("}");

    jscad.wlog("module.exports = { main, getParameterDefinitions }");

    jscad.close();
}
