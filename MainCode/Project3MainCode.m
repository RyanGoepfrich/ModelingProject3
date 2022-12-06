%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  FUNCTION NAME: Project3MainCode
%
%  PURPOSE - 
%
%  INPUT - 
%
%  OUTPUT - 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  AUTHOR: Ryan Goepfrich   
%  DATE: 11/29/22
%
%  DESCRIPTION OF LOCAL VARIABLES
% 
%  
% FUNCTIONS CALLED
%
%  START OF EXECUTABLE CODE
%

close all
clear
clc
close all
%%
theta = deg2rad(0): deg2rad(1) :deg2rad(360); 
theta2 = 0: 1: 360;
C_R = 1.58;

%% Set-Up functions
powerpiston = powerpistonsetup(theta);
displacer = displacersetup(powerpiston);
regenerator = regeneratorsetup();
flywheel = flywheelsetup();

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
disp('Power1')
disp(total.power1)
disp('Power2')
disp(total.power2)

%% Graphing Functions
close all

specificvolumevsPressureGraph(total)
torquePlots(theta2, total)

%% Determine KE and I
total.KE = calcKE(theta, total);
total.cf = 0.002;
flywheel.I = total.KE/(total.cf*((total.omegaAvg*2*pi/60)^2));
flywheel.diameter = calcD(flywheel);
disp("The diameter of the flywheel is "+ flywheel.diameter + " m");

%% Rotational Velocity Analysis
% Initial Guess to start convergance
total.omegaAvg2 = total.omegaAvg*2*pi/60;
omega_guess = 1.2*total.omegaAvg2;

while abs(omega_guess - total.omegaAvg2) > 0.1
    omega_guess = (total.omegaAvg2 + omega_guess)/2;
    ode = @(theta, omega2) torqueTheta(theta, total.torqueAvg, total.heightmax, total.mass) / (flywheel.I*omega2);
    [theta3, omega2] = ode45(ode, [0, theta(end)], omega_guess);

    omega_guess = (1/(2*pi))*trapz(theta3, omega2);
    cf_check = (max(omega2) - min(omega2))/total.omegaAvg2;
end
    
omegaPlots(theta3, omega2)

%% Varying Parameters anaylsis
varying = VaryingProperties();
PlotVaryingParam(varying);



