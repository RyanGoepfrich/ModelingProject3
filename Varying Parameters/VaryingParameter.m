function [  ]  = VaryingParameter(C_R, theta, theta2, flywheel, regenerator, powerpiston, displacer, total )
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

Varying.heightmax = hcalc(powerpiston,regenerator,C_R);
powerpiston = VolumePowerPiston(powerpiston,displacer);
displacer = VolumeDisplacer(displacer,total);

powerpiston = massCalcPiston(powerpiston);
displacer = massCalcDisplacer(displacer);
Varying.mass = totalMassCalc(powerpiston,displacer,regenerator);

%% Total Volume Calc.
[total.volume,total.specificvolume] = totalVolumeCalc(displacer,powerpiston,regenerator,total);

%% Pressure Calc.
varying.pressure = pressurecalc(total,powerpiston,displacer,regenerator);

%% Torque Calcs
varying.force = forcecalc(total,powerpiston);
varying.torque = calcTorque(varying.force, powerpiston);
total.torqueAvg = calcTorqueAvg(varying, theta);

varying.KE = calcKE(theta, varying);
total.cf = 0.002;
flywheel.I = varying.KE/(total.cf*(total.omegaAvg^2));
flywheel.diameter = calcD(flywheel);

end


