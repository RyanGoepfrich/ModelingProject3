function [slidermech] = PosVelAccelAnalysis(slidermech)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  FUNCTION NAME: 
%
%  PURPOSE : 
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

%% Postion Analysis
slidermech.crod.angle = theta_S + asin((-slidermech.crank.length/slidermech.crod.length)*sin(slidermech.crank.angle-theta_S)); 
S = slidermech.crank.length*sin(slidermech.crank.angle)+slidermech.crod.length*cos(slidermech.crod.angle-theta_S);
slidermech.crod.vector = slidermech.crod.length*(cos(slidermech.crod.angle)+ 1i*sin(slidermech.crod.angle));
slidermech.S = S;
slidermech.Scheck = imag(slidermech.crank.vector)+imag(slidermech.crod.vector);

% Working on the other analyses later (RG)

% %% Velocity Analysis
%
% slidermech.crod.angvelocity = -slidermech.crank.angvelocity*(slidermech.crank.length/slidermech.crod.length)*(cos(slidermech.crank.angle-theta_S)/cos(slidermech.crod.angle-theta_S));
% slidermech.S_dot = -slidermech.crank.angvelocity*slidermech.crank.length*((sin(slidermech.crank.angle-slidermech.crod.angle))/(cos(theta_S-slidermech.crod.angle)));
% 
% %% Acclecration Analysis
% 
% part1 = crank.length*(crank.angvelocity^2*sind(crank.angle-theta_S)-crank.angaccel*cosd(crank.angle-theta_S));
% part2 = crod.length*(crod.angvelocity^2)*sind(crod.angle-theta_S);
% part3 = crod.length*cosd(crod.angle-theta_S);
% crod.angaccel = (part1+part2)/part3;
% 
% slidermech.S_doubledot = -((crank.length*(crank.angvelocity^2*cosd(crank.angle-crod.angle)+crank.angaccel*sind(crank.angle-crod.angle))+crod.length*crod.angvelocity^2)/(cosd(crod.angle-theta_S)));


end

