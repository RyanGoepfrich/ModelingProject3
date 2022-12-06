function [slidermech] = PosVelAccelAnalysis(slidermech)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  FUNCTION NAME: PosVelAccelAnalysis
%
%  PURPOSE : determine the posistion of the given link
%
%  INPUT: 
%   slidermech: structure containing the information for the slider
%   mechanism that is being analyzed
%
%  OUTPUT:
%   slidermech: structure containing updated information for the position
%   of the slidermech
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  AUTHOR: Ryan Goepfrich, Mitchel Medvec, Charlie Morain, Luke MacKinnon
%  DATE: 11/27/22
%
%  DESCRIPTION OF LOCAL VARIABLES
%   S = posistion of the element being analyzed
%   theta_S: the lead time of  the displacer in radians
%  FUNCTIONS CALLED
%   deg2rad
%  START OF EXECUTABLE CODE
%
theta_S = deg2rad(90);

slidermech.crod.angle = theta_S + asin((-slidermech.crank.length/slidermech.crod.length)*sin(slidermech.crank.angle-theta_S)); 
S = slidermech.crank.length*sin(slidermech.crank.angle)+slidermech.crod.length*cos(slidermech.crod.angle-theta_S);
slidermech.crod.vector = slidermech.crod.length*(cos(slidermech.crod.angle)+ 1i*sin(slidermech.crod.angle));
slidermech.S = S;
slidermech.Scheck = imag(slidermech.crank.vector)+imag(slidermech.crod.vector);

end

