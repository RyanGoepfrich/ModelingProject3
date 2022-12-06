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
<<<<<<< HEAD

close all
clear
clc
=======
clear
clc
close all
>>>>>>> 63bb68fe1d1d8ea8940e127a3b1aa5a43173c4ff

theta = deg2rad(0): deg2rad(1):deg2rad(360); 
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
<<<<<<< HEAD

subplot(2,2,2)
plot(theta2,total.force)
xlabel('Crank Angle [deg]')
ylabel('Force [N]')
xlim([0,360])
title('Force vs. Crank Angle')

% Plotting Subplot of Crank Angle vs. 
subplot(2,2,3)
plot(theta2, total.torque)
yline(0)
yline(total.torqueAvg, 'color', 'r')
xlabel('Crank Angle [deg]')
ylabel('Torque [Nm]')
xlim([0,360])
ylim([-25, 42])
title('Torque vs. Crank Angle')
=======
torquePlots(theta2, total)
>>>>>>> 63bb68fe1d1d8ea8940e127a3b1aa5a43173c4ff

%% Determine KE and I
total.KE = calcKE(theta, total);
total.cf = 0.002;
flywheel.I = total.KE/(total.cf*(total.omegaAvg^2));
flywheel.diameter = calcD(flywheel);

%% DONT KNOW WHAT ELSE IS NEEDED (Will work on stuff)


