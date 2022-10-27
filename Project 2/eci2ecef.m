function rvValuesECEF = eci2ecef(tValues,rvValuesECI,OmegaE)
% --------------------------------------------------------------%
% ------------------------- ECI2ECEF.M -------------------------%
% --------------------------------------------------------------%
% Transform the values of the position along a spacecraft orbit %
% from Earth-centered inertial Cartesian coordinates to %
% Earth-centered Earth-fixed Cartesian coordinates. %
% represents the transformation matrix at the time t %
% Inputs: %
% tValues: column matrix of values of time at which the %
% transformation is to be performed %
% rvValuesECI: matrix of values of the position expressed %
% in Earth-centered inertial Cartesian %
% coordinates and stored ROW-WISE %
% OmegaE: the rotation rate of the Earth %
% Outputs: %
% rvValuesECEF: matrix of values of the position expressed %
% in Earth-centered Earth-fixed Cartesian %
% and stored ROW-WISE %
% --------------------------------------------------------------%

rvValuesECEF=zeros(length(tValues),3);

for i=1:length(tValues)
    t = tValues(i);
    TI2E = dcmI2E(t,OmegaE);
    rECI = rvValuesECI(i,:);
    rvValuesECEF(i,:) = rECI*TI2E;
end

end