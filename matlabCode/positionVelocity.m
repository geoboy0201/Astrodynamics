function [hVec e hDote p a nu0] = positionVelocity[rVec vVec mu]
    %This function takes postion and velocity vectors as inputs and calculates orbital quantities
    %Function call: [hVec e hDote p a nu0] = positionVelocity[rVec vVec mu]
    
    hVec = cross(rVec,vVec);
end