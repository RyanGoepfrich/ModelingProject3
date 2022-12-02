function [displacer] = VolumeDisplacer(displacer,total)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  FUNCTION NAME: 
%
%  PURPOSE - 
%
%  INPUT - 
%
%  OUTPUT - 
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

displacer.volume = (total.heightmax-displacer.S)*displacer.area;
end



