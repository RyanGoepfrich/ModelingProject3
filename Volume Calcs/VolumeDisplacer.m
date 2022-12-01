function [displacer] = VolumeDisplacer(displacer)
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

C_R = 1.58;

delta_V = (max(displacer.S)-min(displacer.S))*pi*(displacer.diameter/2)^2;


displacer.volumeBDC = ((C_R*delta_V)/(1-C_R));
displacer.volumeTDC = (delta_V-displacer.volumeBDC);
C_R2 = displacer.volumeBDC/displacer.volumeTDC


y = length(displacer.crank.angle);

for n = 1:y 
delta_V2= (displacer.S(n)-min(displacer.S))*pi*(displacer.diameter/2)^2;
displacer.volume(n) = delta_V2+displacer.volumeTDC;
end

% I do not understand how this works....
end

