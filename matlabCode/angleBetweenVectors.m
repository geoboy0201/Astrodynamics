function theta = angleBetweenVectors(a,b)

% % ---------------------------------------------------- %
% % This function computes the angle between two vectors %
% % Inputs                                               %
% %   a: 3 x 1 column vector                             %
% %   b: 3 x 1 column vector                             %
% % Output                                               %
% %   theta: angle on [0,2*pi] (radians)                 %
% % ---------------------------------------------------- %
d     = dot(a,b);
c     = cross(a,b);
theta = acos(d/(norm(a,2)*norm(b,2)));
if c(3)<0
    theta = 2*pi-theta;
end