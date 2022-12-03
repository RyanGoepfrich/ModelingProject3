function [D]  = calcD(flywheel)
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
%  AUTHOR: Luke MacKinnon, Ryan Goepfrich, Mitchel Medvec, Charlie Morain
%  DATE: 12/1/22
%
%  DESCRIPTION OF LOCAL VARIABLES:
%
%  FUNCTIONS CALLED:
%
%
%  START OF EXECUTABLE CODE

fun = @(D) D^4 - ((D-flywheel.thickness)^4) - ((32*flywheel.I)/(pi*flywheel.density*flywheel.width));
D = fzero(fun, 1);

end
