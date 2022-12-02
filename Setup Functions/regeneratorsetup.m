function [regenerator] = regeneratorsetup()
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  FUNCTION NAME: Regeneratorsetup
%
%  PURPOSE - Setup to define things for the regenerator
%
%
%  INPUT - none
%
%  OUTPUT - regenerator stucture
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  AUTHOR: Ryan Goepfrich   
%  DATE: 11/30/22
%
%  DESCRIPTION OF LOCAL VARIABLES
% 
%  
%   FUNCTIONS CALLED
%
%  START OF EXECUTABLE CODE
%


R = 287; % [J/kgK]

regenerator.volume = 0.00001; %[m^3] 

regenerator.temp = (900+300/2); % [K]
regenerator.pressureBDC = 500*1000; % [K]
regenerator.mass = (regenerator.pressureBDC*regenerator.volume)/(R*regenerator.temp);



