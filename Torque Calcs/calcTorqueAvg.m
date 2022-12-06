function [torqueAvg]  = calcTorqueAvg(total,theta)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  FUNCTION NAME: calcTorqueAvg
%
%  PURPOSE: determine the average torque for 1 cycle
%
%  INPUT:
%       total: structure containing torque array
%       theta: array of crank angles in radians
%
%  OUTPUT:
%   torqueAvg: average torque of the mechanism
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  AUTHOR: Luke MacKinnon, Ryan Goepfrich, Mitchel Medvec, Charlie Morain
%  DATE: 12/1/22
%
%  DESCRIPTION OF LOCAL VARIABLES: NONE
%
%  FUNCTIONS CALLED:
%       trapz(): trapezoidal integreation function
%
%  START OF EXECUTABLE CODE

torqueAvg = (1/(2*pi))*trapz(theta,total.torque);

end


