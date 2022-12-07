function [flywheelDiam, power1, power2]  = VaryingTemp(HighTemperature)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  FUNCTION NAME: VaryingTemp
%
%  PURPOSE: Recalculate the flywheel diameter and the two powers based on a
%  different temperature in the high temperature region
%
%  INPUT: 
%   HighTemperature: the new temperature at which we are looking at
%
%  OUTPUT:
%   flywheelDiam: Diameter of the flywheel at the new temperature
%   power1: Power calculated using trapz at the new temperature
%   power2: Power calculated using wT at the new temperature
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  AUTHOR: Luke MacKinnon, Ryan Goepfrich, Mitchel Medvec, Charlie Morain
%  DATE: 12/1/22
%
%  DESCRIPTION OF LOCAL VARIABLES:
%   theta: array of all the CAD that the stirling engine goes through in
%   one cycle
%   C_R: Compression ratio of the striling engine
%   powerpiston: structure that contains all neccesary information for the
%   powerpiston
%   displacer: structure that contains all the neccessary information for
%   the displacer
%   regenerator: structure that contains all the neccessary information for
%   the regnerator
%   flywheel: structure that contains all the neccessary information for
%   the regenerator
%   displacer.temp: sets the high temperature gasto the assigned value
%   total.heightMax: max height of the piston inside engined
%   total.mass: total mass of the gas inside the cylinder
%   total.volume: total colume of gas inside the cylinder
%   total.specificVolume: specific volume of the air inside the cylinder
%   total.pressure: total pressure of the gas inside the cyliner - array
%   total.torque: array of all the torques at each CAD
%   total.force: array of all the forces on the piston head at each CAD
%   total.torqueAvg: average torque acting on the crank shaft
%   total.power1: power production of the stirling engine [W] - calcualted
%   using trapz
%   total.power2: power production of the stirling engine [W] - calculated
%   using Wt
%   total.KE: change in kinetic energy of the system
%   total.cf: max allowable coefficient of fluctuation
%   flywheel.I: moment of inertia of the flywheel
%   flywheel.Diam: diameter of the flywheel
%
%  FUNCTIONS CALLED:
%   deg2rad
%   powerpistonsetup
%   displacersetup
%   regneratorsetup
%   flywheelsetup
%   hcalc
%   PosVelAccelAnalysis
%   VolumePowerPiston
%   VolumeDisplacer
%   massCalcPiston
%   massCalcDisplacer
%   totalMassCalc
%   totalVolumeCalc
%   pressureCalc
%   forceCalc
%   calctorque
%   calctorqueAvg
%   PowerMethod1
%   PowerMethod2
%   calcKE
%   calcD
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
flywheel.I = total.KE/(total.cf*((total.omegaAvg*2*pi/60)^2));
flywheel.diameter = calcD(flywheel);

flywheelDiam = flywheel.diameter;
power1 = total.power1;
power2 = total.power2;

end
