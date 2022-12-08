function power2 = PowerMethod2(total)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  FUNCTION NAME: PowerMethod2
%
%  PURPOSE: Calculates the power using the average rotational velocity and 
%  the average torque
%
%  INPUT:
%   total: structure containing all of the important calculations
%
%  OUTPUT:
%   power2: the power calculated using this method
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  AUTHOR: Luke MacKinnon, Ryan Goepfrich, Mitchel Medvec, Charlie Morain
%  DATE: 12/1/22
%
%  DESCRIPTION OF LOCAL VARIABLES:
%   none
%  FUNCTIONS CALLED:
%   none
%
%  START OF EXECUTABLE CODE

% Calculating the power output of the Stirling engine using method 2
% (product of the average rotational velocity and the average torque)
power2 = total.omegaAvg*total.torqueAvg/9.5488;

end

