function [force] = forcecalc(total,powerpiston)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  FUNCTION NAME: forcecalc
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

force = total.pressure/(powerpiston.area);

end

