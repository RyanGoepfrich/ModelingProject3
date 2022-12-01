%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  FUNCTION NAME: Project3MainCode
%
%  PURPOSE - test2
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
theta = 0: deg2rad(1):deg2rad(1440);
theta2 = 0: 1: 1440;

%% Set-Up functions
displacer = displacersetup(theta);
powerpiston = powerpistonsetup(displacer);
regenerator = regeneratorsetup();
flywheel = flywheelsetup();

%% Position, Velc, Accel Calcs
powerpiston = PosVelAccelAnalysis(powerpiston);
displacer = PosVelAccelAnalysis(displacer);

%% Volume Calcs (Note: Regenerator calc is done in setup) 
powerpiston = VolumePowerPiston(powerpiston,displacer);
displacer = VolumeDisplacer(displacer);


%% Mass Calcs (Note: Regenerator calc is done in setup) 
powerpiston = massCalc(powerpiston);

%% Torque Calcs

%% DONT KNOW WHAT ELSE IS NEEDED (Will work on stuff)



