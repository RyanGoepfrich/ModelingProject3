function [slidermech] = massCalcPiston(slidermech)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  FUNCTION NAME: massCalcPiston
%
%  PURPOSE: Calculates the mass of air that is above the piston
%
%  INPUT: 
%   slidermech: structure containing the information for the piston
%
%  OUTPUT:
%   slidermech: structure containing updated information for the piston
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  AUTHOR: Luke MacKinnon, Ryan Goepfrich, Mitchel Medvec, Charlie Morain
%  DATE: 12/1/22
%
%  DESCRIPTION OF LOCAL VARIABLES:
%   R: universal gas constant for air [J/kgK]
%   y: the total number of the array containing the crank angle
%
%  FUNCTIONS CALLED:
%   none
%
%  START OF EXECUTABLE CODE

R = 287; % [J/kgK]
y = length(slidermech.crank.angle);

for n = 1:y 
    if (slidermech.crank.angle(n) >= 4.70) && (slidermech.crank.angle(n) <= 4.72) %Determines if the crank angle of the piston crank is at 3pi/2
    slidermech.mass = (slidermech.pressureBDC*slidermech.volume(n))/(R*slidermech.temp); %Caluclates the mass using the ideal gas law
    slidermech.volumeBDC = slidermech.volume(n); %Set the calculated mass to the mass at BDC
    end 

end


