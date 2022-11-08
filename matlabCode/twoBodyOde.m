function pdot = twoBodyOde(t,p,mu)
    pos = p(1:3);
    vel = p(4:6);
    rad = norm(pos,2);
    posdot = vel;
    veldot = -mu/(rad^3)*pos;
    pdot = [posdot; veldot];
end