function [h] = hcalc(powerpiston,regenerator,C_R)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  FUNCTION NAME:
%
%  PURPOSE:
%
%  INPUT:
%
%  OUTPUT:
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  AUTHOR: Luke MacKinnon, Ryan Goepfrich, Mitchel Medvec, Charlie Morain
%  DATE: 12/1/22
%
%  DESCRIPTION OF LOCAL VARIABLES:
%
%  FUNCTIONS CALLED:
%
%  START OF EXECUTABLE CODE

 % Compression Ratio
Area = pi*(powerpiston.diameter/2)^2;

h = (C_R*max(powerpiston.S)-C_R*(regenerator.volume/Area)-min(powerpiston.S)+(regenerator.volume/Area))/(C_R-1);

end

