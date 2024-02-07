readvec("jscad.gp");

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
    print("n=",n);
    assert(n%4!=0&&n%8!=7);

    Q=qflllgram(get_tqf(n))^-1;
    M=Q~*Q;
    S=[x|x<-Vec(qfminim(M,n)[3]),qfeval(M,x)<=n];

    jscad.open();

    jscad.header(sqrt(n));
   
    jscad.wlog("function main(params) {");

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
    jscad.wlog(", colorize([1,1,1],");
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
    jscad.wlog("  out.push(colorize(palette[mod(s[1],params.ncolors)],fastvertex(s[2])))}");

    jscad.wlog("return out }");

    jscad.wlog("function getParameterDefinitions() {");
    jscad.wlog("  return [");
    jscad.wlog("    ,{ name: 'ms', type: 'checkbox', initial: false, caption: 'S=concat(S,-S):' },");
    jscad.wlog("    ,{ name: 'mod', type: 'checkbox', initial: false, caption: 'mod:' },");
    jscad.wlog("    ,{ name: 'ncolors', type: 'int', initial: 12, min: 1, max: 12, caption: '#colors:' },");
    jscad.wlog("    ,{ name: 'whiten', type: 'int', initial: 1, min: 1, max: ",n,", caption: 'sphere radius^2:' },");
    jscad.wlog("    ,{ name: 'white', type: 'checkbox', initial: false, caption: 'surface of sphere:' },");
    jscad.wlog("    ,{ name: 'look_inside', type: 'choice', values: ['no', 'yes'], initial: 'yes', caption: 'look_inside:' }");
    jscad.wlog("  ];");
    jscad.wlog("}");

    jscad.wlog("module.exports = { main, getParameterDefinitions }");

    jscad.close();
}
