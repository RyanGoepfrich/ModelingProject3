function [force] = forcecalc(total,powerpiston)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  FUNCTION NAME: forcecalc
%
%  PURPOSE: Calculates the force acting on the piston at each CAD
%
%  INPUT: 
%   total: structure containing the calculated values
%   powerpiston: structure containing information for the powerpiston
%
%  OUTPUT:
%   force: array of all the forces acting on the piston at each CAD
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  AUTHOR: Luke MacKinnon, Ryan Goepfrich, Mitchel Medvec, Charlie Morain
%  DATE: 12/1/22
%
%  DESCRIPTION OF LOCAL VARIABLES:
%   none
%  FUNCTIONS CALLED:
%   none
%
%  START OF EXECUTABLE CODE

force = (total.pressure-101300)*(powerpiston.area);

end

