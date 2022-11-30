function [slidermech] = PosVelAccelAnalysis(slidermech)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  FUNCTION NAME: MainCodeHW4
%
%  PURPOSE : Used to set up varaibles
%
%  INPUT
%
%  OUTPUT
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  AUTHOR: Ryan Goepfrich
%  DATE: 11/27/22
%
%  DESCRIPTION OF LOCAL VARIABLES
%
%  FUNCTIONS CALLED
%
%  START OF EXECUTABLE CODE
%
theta_S = deg2rad(90);

% Postion Analysis
slidermech.crod.angle = theta_S + asin((-slidermech.crank.length/slidermech.crod.length)*sin(slidermech.crank.angle-theta_S)); 
S = slidermech.crank.length*sin(slidermech.crank.angle)+slidermech.crod.length*cos(slidermech.crod.angle-theta_S);
slidermech.crod.vector = slidermech.crod.length*(cos(slidermech.crod.angle)+ 1i*sin(slidermech.crod.angle));
slidermech.S = S;
slidermech.Scheck = imag(slidermech.crank.vector)+imag(slidermech.crod.vector);

% Velocity Anaylsis 
 ... (needs to be added -RG)
end

