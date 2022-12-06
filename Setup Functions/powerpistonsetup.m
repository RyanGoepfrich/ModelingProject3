function [powerpiston] = powerpistonsetup(theta)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  FUNCTION NAME: powerpistonsetup
%
%  PURPOSE - setup the basic diamensions of the power power piston
%
%  INPUT - N/A 
%
%  OUTPUT - powerpiston
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  AUTHOR: Ryan Goepfrich   
%  DATE: 11/29/22
%
%  DESCRIPTION OF LOCAL VARIABLES
%   
%   powerpiston.crank.length = crank length of power piston
%   powerpiston.crod.length= connecting rod length
%   powerpiston.crank.angle = angle of the crank for the power piston
%   powerpiston.diameter = diameter of the power piston
%   powerpiston.crank.vector = length of the crank attached to the power piston in vector coordinates 
%   powerpiston.temp = temperature of the air above the powerpiston [K]
%   powerpiston.pressureBDC = pressure of the air above powerpiston at BDC
%   [Pa]
%   powerpiston.area = surface area of the powerpiston 
%  
% FUNCTIONS CALLED
%
%  START OF EXECUTABLE CODE
%

powerpiston.crank.length = 0.0138; % [m] (r_OaA)
powerpiston.crod.length = 0.046; % [m] (r_AB)
powerpiston.crank.angle = theta; % (accounting for phaseshift)
powerpiston.diameter = 0.07; % [m]
powerpiston.crank.vector = powerpiston.crank.length*(cos(powerpiston.crank.angle)+ 1i*sin(powerpiston.crank.angle));
powerpiston.temp = 300; % [K]
powerpiston.pressureBDC = 500*1000; % [Pa]
powerpiston.area = pi*(powerpiston.diameter/2)^2;





end

