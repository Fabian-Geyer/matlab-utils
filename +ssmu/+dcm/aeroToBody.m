function [T_BA] = aeroToBody(alpha, beta)
% Calculate (symbolic) DCM for transformations from the Aerodynamic to the
% body frame
arguments
    alpha 
    beta 
end

% DCM from aerodynamic frame to body frame (flight mechanics definition)
T_BA = ssmu.dcm.T2(alpha)*ssmu.dcm.T3(-beta);
end