function [  ]  = calcOmega(theta2, avg_torque)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  FUNCTION NAME: calcOmega
%
%  PURPOSE: determine the rotational velocity of the flywheel for all crank
%  angles
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

powerpiston = @(theta) powerpistonsetup(theta);
displacer = displacersetup(powerpiston);
regenerator = regeneratorsetup();

powerpiston = PosVelAccelAnalysis(powerpiston);
displacer = PosVelAccelAnalysis(displacer);
total.heightmax = hcalc(powerpiston,regenerator,C_R);

powerpiston = VolumePowerPiston(powerpiston,displacer);
displacer = VolumeDisplacer(displacer,total);

[total.volume,total.specificvolume] = totalVolumeCalc(displacer,powerpiston,regenerator,total);
total.pressure = pressurecalc(total,powerpiston,displacer,regenerator);

total.force = forcecalc(total,powerpiston);
total.torque = calcTorque(total.force, powerpiston);


T_0 = @(theta) ;
ode = @(theta, omega2) T_0/omega2;

[theta, omega2] = ode45(ode);


end
