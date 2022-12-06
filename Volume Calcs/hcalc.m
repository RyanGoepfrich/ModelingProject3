function [h] = hcalc(powerpiston,regenerator,C_R)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  FUNCTION NAME: hcalc
%
%  PURPOSE: Calculates the max height of the powerpiston
%
%  INPUT:
%   powerpiston: structure containing information for the powerpiston
%   regenerator: structure containing information for the regenerator
%   C_R: compression ratio
%
%  OUTPUT:
%   h: height of the powerpiston
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  AUTHOR: Luke MacKinnon, Ryan Goepfrich, Mitchel Medvec, Charlie Morain
%  DATE: 12/1/22
%
%  DESCRIPTION OF LOCAL VARIABLES:
%   Area: surface area of the powerpiston
%  FUNCTIONS CALLED:
%   none
%  START OF EXECUTABLE CODE

 % Compression Ratio
Area = pi*(powerpiston.diameter/2)^2;

h = (C_R*max(powerpiston.S)-C_R*(regenerator.volume/Area)-min(powerpiston.S)+(regenerator.volume/Area))/(C_R-1);

end

