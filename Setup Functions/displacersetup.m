function [displacer] = displacersetup(theta)
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
%   displacer.crank.length = crank length of displacer
%   displacer.crod.length= connecting rod length of displacer
%   
%  
% FUNCTIONS CALLED
%
%  START OF EXECUTABLE CODE
%

displacer.crank.length = 0.0138; % [m] (r_OaC)
displacer.crod.length = 0.0705; % [m] (r_CD)
displacer.volume = 0; % [m^2] (V_disp)
displacer.crank.angle = theta;
displacer.diameter = 0.07; % [m]
displacer.crank.vector = displacer.crank.length*(cos(displacer.crank.angle)+ 1i*sin(displacer.crank.angle));

end

