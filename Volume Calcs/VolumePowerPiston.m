function [powerpiston] = VolumePowerPiston(powerpiston,displacer)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  FUNCTION NAME: VolumePowerPiston
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
%   
%  
%  FUNCTIONS CALLED
%
%  START OF EXECUTABLE CODE
%

distancebetween = abs(displacer.S-powerpiston.S);

powerpiston.volume = powerpiston.area*distancebetween;



end

