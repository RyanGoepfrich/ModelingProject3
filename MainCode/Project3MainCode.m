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
theta = deg2rad(0): deg2rad(1):deg2rad(1440); 
theta2 = 0: 1: 1440;
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

%% Graphing Functions
specificvolumevsPressureGraph(total)

%% DONT KNOW WHAT ELSE IS NEEDED (Will work on stuff)



