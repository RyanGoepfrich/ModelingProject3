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
flywheel.I = total.KE/(total.cf*(total.omegaAvg^2));
flywheel.diameter = calcD(flywheel);

%% Rotational Velocity Analysis

ode = @(theta, omega2) torqueTheta(theta, total.torqueAvg, total.heightmax, total.mass) / (flywheel.I*omega2);
[theta3, omega2] = ode45(ode, [0, theta(end)], total.omegaAvg);

omega_check = (1/(2*pi))*trapz(theta3, omega2);
cf_check = (max(omega2) - min(omega2))/total.omegaAvg;

omegaPlots(theta3, omega2)

%% Varying Parameters anaylsis

total.lowCR = 1.1;
total.highCR = 2;
total.CR = linspace(total.lowCR, total.highCR, 10);


for i=1:numel(total.CR)
     [total.varyingFlywheelDiamCR(i), total.varyingPower1CR(i), total.varyingPower2CR(i)] = VaryingParameter(total.CR(i));
end

lowTHigh = 700;
HighTHigh = 1100;
total.varyingTemp = linspace(lowTHigh, HighTHigh, 200);

for i=1:numel(total.varyingTemp)
     [total.varyingFlywheelDiamTemp(i), total.varyingPower1Temp(i), total.varyingPower2Temp(i)] = VaryingTemp(total.varyingTemp(i));
end

PlotVaryingCR(total);



