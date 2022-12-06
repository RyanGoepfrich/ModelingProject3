function [flywheelDiam, power1, power2]  = VaryingTemp(HighTemperature)
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
theta = deg2rad(0): deg2rad(1) :deg2rad(360); 
theta2 = 0: 1: 360;
C_R = 1.58;

%% Set-Up functions
powerpiston = powerpistonsetup(theta);
displacer = displacersetup(powerpiston);
regenerator = regeneratorsetup();
flywheel = flywheelsetup();
displacer.temp = HighTemperature;

%% Position, Velc, Accel Calcs
powerpiston = PosVelAccelAnalysis(powerpiston);
displacer = PosVelAccelAnalysis(displacer);
total.heightmax = hcalc(powerpiston,regenerator,C_R);

%% Volume Calcs (Note: Regenerator calc is done in setup)
powerpiston = VolumePowerPiston(powerpiston,displacer);
displacer = VolumeDisplacer(displacer,total);

%% Mass Calcs (Note: Regenerator calc is done in setup) 
powerpiston = massCalcPiston(powerpiston);
displacer = massCalcDisplacer(displacer);
total.mass = totalMassCalc(powerpiston,displacer,regenerator);

%% Total Volume Calc.
[total.volume,total.specificvolume] = totalVolumeCalc(displacer,powerpiston,regenerator,total);

%% Pressure Calc.
total.pressure = pressurecalc(total,powerpiston,displacer,regenerator);

%% Torque Calcs
total.force = forcecalc(total,powerpiston);
total.torque = calcTorque(total.force, powerpiston);
total.torqueAvg = calcTorqueAvg(total, theta);

%% Power Calcs
[total.power1,total.omegaAvg] = PowerMethod1(total);
total.power2 = PowerMethod2(total);



%% Determine KE and I
total.KE = calcKE(theta, total);
total.cf = 0.002;
flywheel.I = total.KE/(total.cf*(total.omegaAvg^2));
flywheel.diameter = calcD(flywheel);

flywheelDiam = flywheel.diameter;
power1 = total.power1;
power2 = total.power2;

end
