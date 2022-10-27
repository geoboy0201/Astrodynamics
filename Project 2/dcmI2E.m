function TI2E = dcmI2E(t,OmegaE)
% --------------------------------------------------------------%
% -------------------------- DCMI2E.M --------------------------%
% --------------------------------------------------------------%
% Compute the transformation matrix from Earth-centered inertial%
% Cartesian coordinates to Earth-centered Earth-fixed Cartesian %
% coordinates. The transformation matrix is of size 3 by 3 and %
% represents the transformation matrix at the time t %
% Inputs: %
% t: the time at which the transformation is desired %
% OmegaE: the rotation rate of the Earth %
% Outputs: %
% TI2E: 3 by 3 matrix that transforms components of a %
% vector expressed in Earth-centered inertial %
% Cartesian coordinates to Earth-centered %
% Earth-fixed Cartesian coordinates %
% --------------------------------------------------------------%
% NOTE: the units of the inputs T and OMEGAE must be consistent %
% and the angular rate must be in RADIANS PER TIME UNIT %
% --------------------------------------------------------------%

theta = OmegaE * t;

TI2E = [cos(theta),-sin(theta),0;sin(theta),cos(theta),0;0,0,1];

end