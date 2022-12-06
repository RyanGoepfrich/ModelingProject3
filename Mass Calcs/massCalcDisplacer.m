function [slidermech] = massCalcDisplacer(slidermech)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  FUNCTION NAME: massCalcDisplacer
%
%  PURPOSE: Calculates the mass of air that is above the diplacer
%
%  INPUT: 
%   slidermech: structure containing all of the information for the
%   displacer
%
%  OUTPUT:
%   slidermech: stucture with updated values
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  AUTHOR: Luke MacKinnon, Ryan Goepfrich, Mitchel Medvec, Charlie Morain
%  DATE: 12/1/22
%
%  DESCRIPTION OF LOCAL VARIABLES:
%   R: Universal gas constant [J/kgK]
%   y: the total number of angles within the displacer crank
%
%  FUNCTIONS CALLED:
%
%
%  START OF EXECUTABLE CODE

R = 287; % [J/kgK]
y = length(slidermech.crank.angle);

for n = 1:y 
    if (slidermech.crank.angle(n) == 0) || (slidermech.crank.angle(n) == deg2rad(360)) %Determines if the displacer is at BDC
    slidermech.mass = (slidermech.pressureBDC*slidermech.volume(n))/(R*slidermech.temp); %Calculates the mass of the air inside using ideal gas law
    slidermech.volumeBDC = slidermech.volume(n); %sets the volume at BDC to the calculated volume
    end 

end
end

