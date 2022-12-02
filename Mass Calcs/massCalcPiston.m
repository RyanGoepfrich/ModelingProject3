function [slidermech] = massCalcPiston(slidermech)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  FUNCTION NAME: massCalc
%
%  PURPOSE: Calc the mass of working fluid for both the displacer and
%  Power Piston. (Not for the regeneratorm solved in the setup process)
%
%  INPUT
%
%  OUTPUT
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  AUTHOR: Ryan Goepfrich
%  DATE: 11/30/22
%
%  DESCRIPTION OF LOCAL VARIABLES
%
%  FUNCTIONS CALLED
%
%  START OF EXECUTABLE CODE
%

R = 287; % [J/kgK]
y = length(slidermech.crank.angle);

for n = 1:y 
    if (slidermech.crank.angle(n) >= 4.70) && (slidermech.crank.angle(n) <= 4.72)
    slidermech.mass = (slidermech.pressureBDC*slidermech.volume(n))/(R*slidermech.temp);
    slidermech.volumeBDC = slidermech.volume(n);
    end 

end


