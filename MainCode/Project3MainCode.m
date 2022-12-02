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
theta = deg2rad(-90): deg2rad(1):deg2rad(270); 
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

%% Volume Calcs (Note: Regenerator calc is done in setup)
total.heightmax = hcalc(powerpiston,regenerator,C_R);
powerpiston = VolumePowerPiston(powerpiston,displacer);
displacer = VolumeDisplacer(displacer,total);
total.Volume = totalVolumeCalc(displacer,powerpiston,regenerator);


%% Mass Calcs (Note: Regenerator calc is done in setup) 
powerpiston = massCalcPiston(powerpiston);
displacer = massCalcDisplacer(displacer);
total.mass = totalMassCalc(powerpiston,displacer,regenerator);

%% Torque Calcs

%% DONT KNOW WHAT ELSE IS NEEDED (Will work on stuff)
hold on
plot(theta2,displacer.volume,'g',theta2,powerpiston.volume,'c',theta2,total.Volume,'m')
yline(regenerator.volume,'r')
