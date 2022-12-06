function [D]  = calcD(flywheel)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  FUNCTION NAME: calcD
%
%  PURPOSE: to calculate the diameter of the flywheel given I
%     
%  INPUT:
%       flywheel: structure containing the flywheel dimensions and
%       properties
%
%  OUTPUT:
%       D: the diameter of the flywheel
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  AUTHOR: Luke MacKinnon, Ryan Goepfrich, Mitchel Medvec, Charlie Morain
%  DATE: 12/1/22
%
%  DESCRIPTION OF LOCAL VARIABLES:
%       fun: the function used to determine diameter
%
%  FUNCTIONS CALLED:
%       fzero: used to find the zero of the diameter function
%
%  START OF EXECUTABLE CODE

fun = @(D) ((D/2)^4 - ((D/2)-flywheel.thickness)^4) - ((2*flywheel.I)/(pi*flywheel.density*flywheel.width));
D = fzero(fun, 0.4);

end
