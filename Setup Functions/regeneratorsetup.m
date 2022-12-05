function [regenerator] = regeneratorsetup()
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  FUNCTION NAME: Regeneratorsetup
%
%  PURPOSE - Setup to define things for the regenerator
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
%   regenerator.volume = dead colume inside of the regnerator
%   regenerator.temp = temperature of the air inside the regenerator
%   regenerator.mass = mass of the air inside regenerator (Calculated using
%   ideal gas las
%   R = univeral gas constant of air [J/kgK]
%  
%   FUNCTIONS CALLED
%   none
%  START OF EXECUTABLE CODE
%


R = 287; % [J/kgK]

regenerator.volume = 0.00001; %[m^3] 

regenerator.temp = (900+300/2); % [K]
regenerator.pressureBDC = 500*1000; % [K]
regenerator.mass = (regenerator.pressureBDC*regenerator.volume)/(R*regenerator.temp);



