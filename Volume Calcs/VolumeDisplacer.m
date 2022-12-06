function [displacer] = VolumeDisplacer(displacer,total)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  FUNCTION NAME: VolumeDisplacer
%
%  PURPOSE: calculate the volume above the displacer
%
%  INPUT:
%   displacer: structure containing all information for the displacer
%   total: sturcture contating the important values that have been
%   calculated
%
%  OUTPUT:
%   displacer: updated structure with the volume above the displacer
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  AUTHOR: Ryan Goepfrich   
%  DATE: 11/30/22
%
%  DESCRIPTION OF LOCAL VARIABLES
%   none
%  
%   FUNCTIONS CALLED
%   none
%
%  START OF EXECUTABLE CODE
%

displacer.volume = (total.heightmax-displacer.S)*displacer.area; %finds the distance between top of cylinnder and the displacer and calculates volume using surface area times height
end



