function [powerpiston] = VolumePowerPiston(powerpiston,displacer)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  FUNCTION NAME: VolumePowerPiston
%
%  PURPOSE: Calculate thevolume of air contained within the power piston
%
%  INPUT: 
%   powerpiston: structure containing all the information for the
%   powerpiston
%   displacer: structure containing all the information for the displacer
%
%  OUTPUT:
%   powerpiston: updated structure containing the volume of the power
%   piston
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  AUTHOR: Ryan Goepfrich   
%  DATE: 11/30/22
%
%  DESCRIPTION OF LOCAL VARIABLES
%   distancebetween: The distance between powerpiston and the displacer   
%  
%  FUNCTIONS CALLED
%   none
%
%  START OF EXECUTABLE CODE
%

distancebetween = abs(displacer.S-powerpiston.S); %calculates space between the power piston and the displacer

powerpiston.volume = powerpiston.area*distancebetween; %calculates the volume above piston using surface area and height



end

