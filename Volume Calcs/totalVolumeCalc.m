function [VolumeTotal,SpecificVolume] = totalVolumeCalc(displacer,powerpiston,regenerator,total)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  FUNCTION NAME: totalVolumeCalc
%
%  PURPOSE: Calculates the total volume of air within the cylinder
%
%  INPUT:
%   displacer: structure containing information for the displacer
%   powerpiston: structure containing information for the powerpiston
%   regenerator: structure contating information for the regnerator
%   total: structure containing the final calulations for important values
%
%  OUTPUT:
%   VolumeTotal: total volume of air within the cylinder
%   SpecificVolume: the specific volume of the air within the cylinder
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
%  START OF EXECUTABLE CODE
%

VolumeTotal = displacer.volume+powerpiston.volume+regenerator.volume;
SpecificVolume = VolumeTotal/total.mass;
end

