readvec("jscad.gp");
readvec("utils.gp");

assert(b,s)=if(!(b), error(Str(s)));

get_tqf(n,vstart)={
    assert(n%4!=0);
    assert(n%8!=7);
    my(Q,v,b,p,a12);
    if(n%4==2,
        for(vv=vstart,oo,
            if(ispseudoprime((4*vv+1)*n-1),
                v=vv; break()));
        print(v+1);
        b=4*v+1;
        p=b*n-1;
        assert(kronecker(-b,p)==1);
        a12=lift(sqrt(Mod(-b,p)));
        ,
        my(c=4-(n%4));
        assert(((c*n-1)/2)%2==1);
        for(vv=vstart,oo,
            if(ispseudoprime(((8*vv+c)*n-1)/2),
                v=vv; break()));
        print(v+1);
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
    vstart=if(getenv("vstart"),eval(getenv("vstart")),0);

    Q=qflllgram(get_tqf(n,vstart))^-1;
    M=Q~*Q;
    S=[x|x<-Vec(qfminim(M,n)[3]),qfeval(M,x)<=n];
    P=[(Q*v)~|v<-S,v[3]==vecsort(matreduce([v[3]|v<-S])~,2,4)[1,1]];
    v=matker(Mat(apply(x->concat(x,1),P~)))[,1];
    PO=-v[4]/(norml2(v[1..3]))*v[1..3]~;
    P1=(Q*[0,0,1]~)~;
    ncol=min(12,2-vecmin([v[3]|v<-S]));

    jscad.open();

    jscad.header(sqrt(n));
   
    jscad.wlog("function main(params) {");

    jscad.wlog("for(i=0;i<",ncol,";++i)");
    jscad.wlog("  palette[4+i]=hexToRgb(params['p_'+i])");

    jscad.wlog("PO =",PO);
    jscad.wlog("// P1 =",P1," norml2 =",norml2(P1));
    if(PO==[0,0,0],jscad.wlog("D0 =", PO),jscad.wlog("DO =", P1-((P1*PO~)*(PO/norml2(PO))~)~, "  // norml2 =",norml2(P1-((P1*PO~)*(PO/norml2(PO))~)~)));
    jscad.wlog("N = ",conv(PO));

    jscad.wlog("S = [");
    foreach(S,s,
        if(s!=S[1],jscad.wlog_(","));
        jscad.wlog([norml2((Q*s)~),s[3],(Q*s)~]);
    );
    jscad.wlog("]");

    jscad.wlog("MS = [");
    foreach(-S,s,
        if(s!=-S[1],jscad.wlog_(","));
        jscad.wlog([norml2((Q*s)~),s[3],(Q*s)~]);
    );
    jscad.wlog("]");

    jscad.wlog("if(params.ms) S=S.concat(MS)");

    jscad.wlog("sub = [cube({size: (params.look_inside === 'yes')?sc+0.1:0.01, center: [sc/2,sc/2,sc/2]})]");

    jscad.wlog("white = (!params.white) ? [] : [[]");
    jscad.wlog(", colorize(palette[3],");
    jscad.wlog("      subtract(");
    jscad.wlog("          sphere({radius: Math.sqrt(params.whiten), segments: 30})");
    jscad.wlog("          ,sphere({radius: Math.sqrt(params.whiten)-0.3, segments: 30})");
    jscad.wlog("          ,sub ");
    jscad.wlog("      )");
    jscad.wlog("  )");
    jscad.wlog("]");

    jscad.wlog("let out=[white]");

    jscad.wlog("function mod(x,m) {");
    jscad.wlog(" if(params.mod) { x=x%m; return(x<0)?x+m:x }");
    jscad.wlog(" if(x>1) x=1; else if (x<=-params.ncolors+1) x=-params.ncolors+1;");
    jscad.wlog(" if(x<0) x+=params.ncolors;");
    jscad.wlog(" return x");
    jscad.wlog("}");

    jscad.wlog("for(s of S){if(s[0]>=params.whiten)");
    jscad.wlog("  out.push(colorize(palette[4+mod(s[1],params.ncolors)],fastvertex(s[2])))}");

    jscad.wlog("if (params.hull)");
    jscad.wlog("  out.push(colorize(palette[2].concat(params.alpha),hull(out)))");

    jscad.wlog("if (params.plane !== 'none') {");
    jscad.wlog("  out.push(colorize(palette[0],translate(PO,sphere({radius:0.1}))))");
    jscad.wlog("  out.push(colorize(palette[1],translate(DO,sphere({radius:0.1}))))");
    jscad.wlog("  out.push(colorize(palette[2].concat(params.alpha),translate(params.plane === 'max'?PO:[0,0,0],rotateZ(degToRad(90+N[0]),rotateX(degToRad(N[1]),cuboid({size: [2*sc+1,2*sc+1,0.02]}))))))");
    jscad.wlog("}");

    jscad.wlog("return out }");

    jscad.wlog("function getParameterDefinitions() {");
    jscad.wlog("  ret = [");
    jscad.wlog("    { name: 'plane', type: 'choice', values: ['none', 'max', 'origin'], initial: 'max', caption: 'plane:' },");
    jscad.wlog("    { name: 'hull', type: 'checkbox', initial: false, caption: 'hull:' },");
    jscad.wlog("    { name: 'ms', type: 'checkbox', initial: false, caption: 'S=concat(S,-S):' },");
    jscad.wlog("    { name: 'mod', type: 'checkbox', initial: false, caption: 'mod:' },");
    jscad.wlog("    { name: 'ncolors', type: 'int', initial: ",ncol,", min: 1, max: ",ncol,", caption: '#colors:' },");
    jscad.wlog("    { name: 'whiten', type: 'int', initial: 1, min: 1, max: ",n,", caption: 'sphere radius^2:' },");
    jscad.wlog("    { name: 'alpha', type: 'slider', initial: 0.8, min: 0, max: 1, step: 0.1, caption: 'alpha:' },");
    jscad.wlog("    { name: 'white', type: 'checkbox', initial: false, caption: 'surface of sphere:' },");
    jscad.wlog("    { name: 'look_inside', type: 'choice', values: ['no', 'yes'], initial: 'yes', caption: 'look_inside:' }");
    jscad.wlog("   ,{ name: 'group1', type: 'group', initial: 'closed', caption: 'lospec.com/palette-list/optimum' } ]");
    jscad.wlog("  for(i=0;i<",ncol,";++i)");
    jscad.wlog("    ret.push({ name: 'p_'+i, type: 'color', initial: rgbToHex(palette[4+i]), caption: i+' ('+palettenames[4+i]+')' })");
    jscad.wlog("  return ret");
    jscad.wlog("}");

    jscad.wlog("module.exports = { main, getParameterDefinitions }");

    jscad.close();
}
