rad2deg(r)=r/Pi*180;

atan2(y,x)={
  if(x==0,if(y>0,return(Pi/2),return(3*Pi/2)));
  if(x>0&&y>=0,return(atan(y/x)));
  if(x<0,return(Pi+atan(y/x)));
  if(x>0&&y<0,return(2*Pi+atan(y/x)));
}

conv(v)={
    t = acos(v[3]);
    r = atan2(v[2],v[1]);
    [rad2deg(r),rad2deg(t)];
}
