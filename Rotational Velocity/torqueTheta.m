function [T_0]  = torqueTheta(theta, avg_torque, heightmax, mass_total)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  FUNCTION NAME: torqueTheta
%
%  PURPOSE: generate a function to be used as an anonoumous function in
%  terms of theta to input to ODE45
%
%  INPUT:
%       theta: the crank angle
%       avg_torque: average torque of cycle
%       heighmax: height of piston casing
%       mass_total: total air mass
%
%  OUTPUT:
%       T_0: function for normalized torque
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  AUTHOR: Luke MacKinnon, Ryan Goepfrich, Mitchel Medvec, Charlie Morain
%  DATE: 12/1/22
%
%  DESCRIPTION OF LOCAL VARIABLES:
%
%  FUNCTIONS CALLED:
%       powerpistonsetup: creates power piston vectors and positions
%       displacersetup: creates displacer vectors and positions
%       regeneratorsetup: defines regenerator
%       PosVelAccelAnalysis: determines the position and agnles of the given link
%       VolumePowerPiston: determines the air volume of the power piston
%       section
%       VolmeDisplacer: determines the air volume of the displacer section
%       totalVolumeCalc: determines the total volume and sepcific volume of the system
%       pressureCalc: calculates the pressure at the given crank angle
%       forcecalc: calculates the force at the given crank angle
%       calcTorque: calculates the torque at the given crank angle
%
%  START OF EXECUTABLE CODE

powerpiston = powerpistonsetup(theta);
displacer = displacersetup(powerpiston);
regenerator = regeneratorsetup();

powerpiston = PosVelAccelAnalysis(powerpiston);
displacer = PosVelAccelAnalysis(displacer);
total.heightmax = heightmax;

powerpiston = VolumePowerPiston(powerpiston,displacer);
displacer = VolumeDisplacer(displacer,total);

total.mass = mass_total;

[total.volume,total.specificvolume] = totalVolumeCalc(displacer,powerpiston,regenerator,total);
total.pressure = pressurecalc(total,powerpiston,displacer,regenerator);

total.force = forcecalc(total,powerpiston);
total.torque = calcTorque(total.force, powerpiston);

T_0 = total.torque - avg_torque;

end
