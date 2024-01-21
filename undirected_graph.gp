vertices=(A)->{ return([0..#A-1]); }

edges=(A)->{
    return([[v,w]|v<-vertices(A);w<-A[1+v],v<w]);
}

ugraph=(name)->{
    A=readvec(name)[1];
    return([vertices(A),edges(A)]);
}
