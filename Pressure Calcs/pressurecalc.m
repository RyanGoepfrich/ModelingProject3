function [totalPressure] = pressurecalc(total,powerpiston,displacer,regenerator)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  FUNCTION NAME: pressurecalc
%
%  PURPOSE: Calculate the total pressure in the cylinder using partial
%  pressures
%
%  INPUT:
%   total: structure containing all of the important calculated values
%   powerpiston: structure contating information for the powerpiston
%   displacer: structure containing information for the displacer
%   regenerator: structure containing information for the regenerator
%
%  OUTPUT:
%   totalpressure: returns an array of the totalpressure at the different
%   crank angles
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  AUTHOR: Luke MacKinnon, Ryan Goepfrich, Mitchel Medvec, Charlie Morain
%  DATE: 12/2/22
%
%  DESCRIPTION OF LOCAL VARIABLES:
%   R: universal gas constant of air [J/kgK]
%   y: total number of different crank angles
%
%  FUNCTIONS CALLED:
%   length
%
%  START OF EXECUTABLE CODE

R = 287; % [J/kgK]
y = length(powerpiston.crank.angle);

%At each CAD calcuates the total pressure using partial pressures from the
%ideal gas law
for n = 1:y
totalPressure(n) = ((total.mass)*R)/((powerpiston.volume(n)/powerpiston.temp)+(displacer.volume(n)/displacer.temp)+(regenerator.volume/regenerator.temp));
end



