function [totalPressure] = pressurecalc(total,powerpiston,displacer,regenerator)
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
%  DATE: 12/2/22
%
%  DESCRIPTION OF LOCAL VARIABLES:
%
%  FUNCTIONS CALLED:
%
%
%  START OF EXECUTABLE CODE

R = 287; % [J/kgK]
y = length(powerpiston.crank.angle);
for n = 1:y
totalPressure(n) = ((total.mass)*R)/((powerpiston.volume(n)/powerpiston.temp)+(displacer.volume(n)/displacer.temp)+(regenerator.volume/regenerator.temp));
end



