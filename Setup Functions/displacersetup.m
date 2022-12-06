function [displacer] = displacersetup(powerpiston)
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
%   displacer.volume: volume of air above displacer (Placeholder value)
%   displacer.crank.angle: CAD of the displacer in reference to the
%   powerpiston
%   displacer.diameter: diameter of the displacer
%   dispacer.crank.vector: length of the displacer crank in terms of vector
%   notation
%   displacer.temp: temperature of the air above the displacer
%   displacer.area: surface area of the displacer
%   displacer.pressureBDC: pressure of the air above the displacer at BDC
%   
%  
% FUNCTIONS CALLED
%   deg2rad
%  START OF EXECUTABLE CODE
%

displacer.crank.length = 0.0138; % [m] (r_OaC)
displacer.crod.length = 0.0705; % [m] (r_CD)
displacer.volume = 0; % [m^2] (V_disp)
displacer.crank.angle = powerpiston.crank.angle+deg2rad(90);
displacer.diameter = 0.07; % [m]
displacer.crank.vector = displacer.crank.length*(cos(displacer.crank.angle)+ 1i*sin(displacer.crank.angle));
displacer.temp = 900; % [k]
displacer.area = pi*(displacer.diameter/2)^2;
displacer.pressureBDC = 500*1000; % [Pa]

end

