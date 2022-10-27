function [lonE,lat] = ecef2LonLat(rvValuesECEF)
% --------------------------------------------------------------%
% ----------------------- ECEF2LONLAT.M ------------------------%
% --------------------------------------------------------------%
% Compute the Earth-relative longitude and geocentric latitude %
% from the Earth-centered Earth-fixed position. %
% Input: %
% rvValuesECEF: matrix of values of the position expressed %
% in Earth-centered Earth-fixed Cartesian %
% and stored ROW-WISE %
% Outputs: %
% lonE: a column matrix containing the values of the %
% Earth-relative longitude (radians) %
% lat: a column matrix containing the values of the %
% geocentric latitude (radians) %
% --------------------------------------------------------------%

lonE = zeros(length(rvValuesECEF),1);
lat = zeros(length(rvValuesECEF),1);

for i=1:length(rvValuesECEF)
     lonE(i)=atan2(rvValuesECEF(i,2),rvValuesECEF(i,1));
     lat(i)=atan2(rvValuesECEF(i,3),sqrt(rvValuesECEF(i,1)^2+rvValuesECEF(i,2)^2));
end

end