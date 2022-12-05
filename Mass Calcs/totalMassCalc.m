function [totalmass] = totalMassCalc(powerpiston,displacer,regenerator)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  FUNCTION NAME: totalMassCalc
%
%  PURPOSE: Calculate the total mass of the air within the closed system
%
%  INPUT:
%   powerpiston: stucture containing the information for the powerpiston
%   displacer: structure containing the information for the displacer
%   regnerator: structure containing the informaiton for the regenerator
%
%  OUTPUT:
%   totalmass: value representing the total mass of air within the system
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  AUTHOR: Luke MacKinnon, Ryan Goepfrich, Mitchel Medvec, Charlie Morain
%  DATE: 12/1/22
%
%  DESCRIPTION OF LOCAL VARIABLES:
%   totalmass: total mass of the air within the system
%
%  FUNCTIONS CALLED:
%   none
%
%  START OF EXECUTABLE CODE
totalmass = powerpiston.mass+displacer.mass+regenerator.mass;
end

