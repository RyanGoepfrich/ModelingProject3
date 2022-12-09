%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  FUNCTION NAME: Project3MainCode
%
%  PURPOSE: The purpose of this main function is to complete all 
%  delivarables for project 3 in which a Stirling Engine is studied
%
%  INPUT: none
%
%  OUTPUT: none
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
%   varying: structure containing the varying parameters and their results
%   total.omegaAvg2: average rotational velocity frequency
%   omega_guess: initial guss of where the average rotational velocity is
%   cf_check: coefficient of friction of the stirling engine
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
%   VaryingParameters
%   specificvolumevsPressureGraph
%   torquePlots
%   PlotVaryingParam
%   omegaPlots
%   fprintf
%   disp
%   torqueTheta
%   ode45
%   trapz
%   min
%   max
%
%  START OF EXECUTABLE CODE


close all
clear
clc

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

%% Determine KE and I
total.KE = calcKE(theta, total);
total.cf = 0.002;
flywheel.I = total.KE/(total.cf*((total.omegaAvg*2*pi/60)^2));
flywheel.diameter = calcD(flywheel);

%% Rotational Velocity Analysis
% Initial Guess to start convergance
total.omegaAvg2 = total.omegaAvg*2*pi/60;
omega_guess = 1.2*total.omegaAvg2;

% Iterate rotational velocity analysis until average velocity meets
% parameters
while abs(omega_guess - total.omegaAvg2) > 0.1
    % Initial guess
    omega_guess = (total.omegaAvg2 + omega_guess)/2;
    
    % Solve ODE
    ode = @(theta, omega2) torqueTheta(theta, total.torqueAvg, total.heightmax, total.mass) / (flywheel.I*omega2);
    [theta3, omega2] = ode45(ode, [0, theta(end)], omega_guess);
    
    % Check results 
    omega_guess = (1/(2*pi))*trapz(theta3, omega2);
    cf_check = (max(omega2) - min(omega2))/total.omegaAvg2;
end

%% Varying Parameters anaylsis
varying = VaryingProperties();

%% Graphing Functions for Final Deliverables
specificvolumevsPressureGraph(total)
torquePlots(theta2, total)
PlotVaryingParam(varying);
omegaPlots(theta3, omega2)

%% Outputting Final Values to Command Window
fprintf('\n\nProject 3 Stirling Engine Analysis Results:\n')
disp('===============================================')
fprintf('\nPower Output Using Method 1:       %.2f [W]', total.power1);
fprintf('\nPower Output Using Method 2:       %.2f [W]', total.power2);
fprintf('\nDiameter of the Flywheel:          %.2f [m]', flywheel.diameter);
fprintf('\nCoefficient of Fluctuation:        %.4f \n\n', cf_check)






function [D]  = calcD(flywheel)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  FUNCTION NAME: calcD
%
%  PURPOSE: to calculate the diameter of the flywheel given I
%     
%  INPUT:
%       flywheel: structure containing the flywheel dimensions and
%       properties
%
%  OUTPUT:
%       D: the diameter of the flywheel
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  AUTHOR: Luke MacKinnon, Ryan Goepfrich, Mitchel Medvec, Charlie Morain
%  DATE: 12/1/22
%
%  DESCRIPTION OF LOCAL VARIABLES:
%       fun: the function used to determine diameter
%
%  FUNCTIONS CALLED:
%       fzero: used to find the zero of the diameter function
%
%  START OF EXECUTABLE CODE

fun = @(D) ((D/2)^4 - ((D/2)-flywheel.thickness)^4) - ((2*flywheel.I)/(pi*flywheel.density*flywheel.width));
D = fzero(fun, 0.4);

end






function [  ]  = omegaPlots(theta, omega)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  FUNCTION NAME: omegaPlots
%
%  PURPOSE: generate the rotaional velocity plot
%
%  INPUT:
%       theta: crank angle
%       omega: the rotational velocity
%
%  OUTPUT: NONE
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  AUTHOR: Luke MacKinnon, Ryan Goepfrich, Mitchel Medvec, Charlie Morain
%  DATE: 12/1/22
%
%  DESCRIPTION OF LOCAL VARIABLES:
%   a1: Plot of the rotational velocity vs crank angle
%   a2: Average velocity line at average rotational velocity
%   omega: adjusted omega to frequency
%
%  FUNCTIONS CALLED: 
%   figure
%   plot
%   xlabel
%   xlim
%   ylabel
%   yline
%   legend
%
%  START OF EXECUTABLE CODE

% Adjusting omega to frequency
omega = omega.*60./(2*pi);

% Plotting Rotational Velocity vs. Crank Angle
figure('Name','Rotational Velocity vs. Crank Angle','NumberTitle','off');
a1 = plot(theta, omega);
xlabel('Crank Angle [Radians]')
xlim([0 2*pi])
ylabel('Rotational Veloctiy [RPM]')
a2 = yline(2000, 'color', 'r');
legend([a1, a2], {'Rot. Velocity', 'Average Rot. Velocity'}, 'location', 'southeast')

end






function []  = PlotVaryingParam(varying)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  FUNCTION NAME: PlotVaryingParam
%
%  PURPOSE: PLots graphs of the varying CR and High temperature in the
%  stirling engine and their impacts on the flywheel diameter and the power output 
%
%  INPUT:
%   varying: sturcture containing varying paraemters and their impacts
%
%  OUTPUT: plots
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  AUTHOR: Luke MacKinnon, Ryan Goepfrich, Mitchel Medvec, Charlie Morain
%  DATE: 12/1/22
%
%  DESCRIPTION OF LOCAL VARIABLES:
%   none
%  FUNCTIONS CALLED:
%   figure  
%   subplot
%   plot
%   xlabel
%   ylabel
%   title
%
%  START OF EXECUTABLE CODE

% Creating Compression Ratio vs. Flywheel Diameter Plot
figure('Name', 'Changing Compression Ratio Plots','NumberTitle','off');
subplot(2,1,1)
plot(varying.CR, varying.varyingFlywheelDiamCR);
xlabel('Compression Ratio');
ylabel('Flywheel Diameter [m]');
title('Compression ratio vs. Flywheel Diameter')

% Creating Compression Ratio vs. Power Plot
subplot(2,1,2)
plot(varying.CR, varying.varyingPower1CR);
xlabel('Compression Ratio');
ylabel('Power [W]')
title('Compression Ratio vs. Power')

% Creating High Temperature vs. Flywheel Diameter Plot
figure('Name', 'Changing High Temperature of Air','NumberTitle','off');
subplot(2,1,1)
plot(varying.varyingTemp, varying.varyingFlywheelDiamTemp);
xlabel('High Temperature [K]');
ylabel('Flywheel Diameter [m]');
title('High Temperature vs. Flywheel Diameter')

% Creating High Temperature vs. Power Plot
subplot(2,1,2)
plot(varying.varyingTemp, varying.varyingPower1Temp);
xlabel('High Temperature [K]');
ylabel('Power [W]')
title('High Temperature vs. Power')

end






function []  = specificvolumevsPressureGraph(total)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  FUNCTION NAME: specificvolumevsPressureGraph
%
%  PURPOSE: to generate the pv diagrams for the striling cycle and engine
%
%  INPUT: 
%       total: structure containing arrays for pressure and specific volume
%
%  OUTPUT: NONE
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  AUTHOR: Luke MacKinnon, Ryan Goepfrich, Mitchel Medvec, Charlie Morain
%  DATE: 12/1/22
%
%  DESCRIPTION OF LOCAL VARIABLES:
%   Tv1: creates an array of a constant high temperature over all specific
%   volumes
%   Tv2: creates an array of the low temperature over all specific volumes
%   Vv1: creates an array between the lowest specific volume and the
%   highest specific volume
%   R: Universal gas constant [K/kg-K]
%   p: Anonymous function that links to the Temp and volume, assuming the
%   ideal gas law
%
%  FUNCTIONS CALLED:
%   figure
%   plot
%   hold
%   legend
%   grid
%   xlabel
%   ylabel
%   xlim
%   title
%
%  START OF EXECUTABLE CODE

% Creating arrays to be used later in graphing specific volume vs. pressure
Tv1 = linspace(900, 900, length(total.specificvolume));
Tv2 = linspace(300, 300, length(total.specificvolume));
Vv1 = linspace(min(total.specificvolume), max(total.specificvolume), length(total.specificvolume));

% Initializing a value for the universal gas constant
R = 287;

% Creating an anonymous function that links to the temp and volume,
% assuming the idal gas law
p = @(T,V) R*T./V;

% Creating a pressure vs. specific volume for Stirling cycle & Stirling
% engine
figure('Name','Pressure vs. Specific Volume for Stirling Cycle & Stirling Engine','NumberTitle','off');
plot(Vv1, (p(Tv1,Vv1))/1000,'b') 
hold on
plot(Vv1, (p(Tv2,Vv1))/1000,'b')
plot(Vv1(1)*[1 1], (p([Tv1(1) Tv2(end)],[1 1]*Vv1(1)))/1000, 'b')
plot(Vv1(end)*[1 1], (p([Tv2(1) Tv1(end)],[1 1]*Vv1(end)))/1000, 'b')
plot(total.specificvolume,(total.pressure)/1000);
legend('Stirling Cycle','','','','Stirling Engine')
hold off
grid
xlabel('Specific Volume [m^3]')
ylabel('Pressure [kPa]')
xlim([0.16,0.27])
title({'Pressure vs. Specific Volume for';'Stirling Cycle & Stirling Engine'})

end






function []  = torquePlots(theta2, total)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  FUNCTION NAME: torquePlots
%
%  PURPOSE: to generate force and torque plots
%
%  INPUT:
%    theta2: array of crank angles in degrees
%    total: structure containing torque and force arrays
%
%  OUTPUT: NONE
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  AUTHOR: Luke MacKinnon, Ryan Goepfrich, Mitchel Medvec, Charlie Morain
%  DATE: 12/1/22
%
%  DESCRIPTION OF LOCAL VARIABLES:
%   a1: used to generate legend
%   a2: used to generate legend
%
%  FUNCTIONS CALLED:
%   plot: used to plot arrays
%   figure
%   subplot
%   xlabel
%   ylabel
%   xlim
%   title
%   yline
%   ylim
%   legend
%
%  START OF EXECUTABLE CODE

% Creating a force vs. crank angle plot
figure('Name', 'Force and Torque Plots','NumberTitle','off');
subplot(2,1,1)
plot(theta2,total.force)
xlabel('Crank Angle [deg]')
ylabel('Force [N]')
xlim([0,360])
title('Force vs. Crank Angle')

% Creating a torque vs. crank angle plot
subplot(2,1,2)
a1 = plot(theta2, total.torque);
yline(0, 'color', 'k')
a2 = yline(total.torqueAvg, 'color', 'r');
xlabel('Crank Angle [deg]')
ylabel('Torque [Nm]')
xlim([0,360])
ylim([-32, 55])
%title('Torque vs. Crank Angle')
legend([a2, a1], {'Average Torque', 'Engine Torque'})

end






function [KE]  = calcKE(theta, total)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  FUNCTION NAME: calcKE
%
%  PURPOSE: determine the kinetic energy of the power stroke
%
%  INPUT:
%       theta: the crank angles in radians
%       total: structure containing torque values
%
%  OUTPUT:
%       KE: the total kinetic energy of the power stroke
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  AUTHOR: Luke MacKinnon, Ryan Goepfrich, Mitchel Medvec, Charlie Morain
%  DATE: 12/1/22
%
%  DESCRIPTION OF LOCAL VARIABLES:
%       T_0: adjusted torque curve that is offset by the average torque
%       thetas: vector containing the the indices of where the power stroke
%       begins (theta_0 and theta_f)
%       cross: counter for how many times the torque zero function crosses the x-axis 
%
%  FUNCTIONS CALLED:
%       trapz: integration function to find kinetic energy
%
%  START OF EXECUTABLE CODE

T_0 = total.torque - total.torqueAvg;
cross = 0;
thetas = [0 0];

for m = 2:length(theta) % Determines theta o and f, by determining when normalized torque crosses zero
    if T_0(m - 1)*T_0(m) < 0
       cross = cross + 1;
       thetas(cross) = m;
    end
end

KE = trapz(theta(thetas(1):thetas(2)), total.torque(thetas(1):thetas(2)));

end






function [slidermech] = massCalcDisplacer(slidermech)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  FUNCTION NAME: massCalcDisplacer
%
%  PURPOSE: Calculates the mass of air that is above the diplacer
%
%  INPUT: 
%   slidermech: structure containing all of the information for the
%   displacer
%
%  OUTPUT:
%   slidermech: stucture with updated values
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  AUTHOR: Luke MacKinnon, Ryan Goepfrich, Mitchel Medvec, Charlie Morain
%  DATE: 12/1/22
%
%  DESCRIPTION OF LOCAL VARIABLES:
%   R: Universal gas constant [J/kgK]
%   y: the total number of angles within the displacer crank
%
%  FUNCTIONS CALLED:
%
%
%  START OF EXECUTABLE CODE

R = 287; % [J/kgK]
y = length(slidermech.crank.angle);

% Updating the values in the slidermech structure
for n = 1:y 
    if (slidermech.crank.angle(n) == 0) || (slidermech.crank.angle(n) == deg2rad(360)) %Determines if the displacer is at BDC
    slidermech.mass = (slidermech.pressureBDC*slidermech.volume(n))/(R*slidermech.temp); %Calculates the mass of the air inside using ideal gas law
    slidermech.volumeBDC = slidermech.volume(n); %sets the volume at BDC to the calculated volume
    end 

end
end






function [slidermech] = massCalcPiston(slidermech)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  FUNCTION NAME: massCalcPiston
%
%  PURPOSE: Calculates the mass of air that is above the piston
%
%  INPUT: 
%   slidermech: structure containing the information for the piston
%
%  OUTPUT:
%   slidermech: structure containing updated information for the piston
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  AUTHOR: Luke MacKinnon, Ryan Goepfrich, Mitchel Medvec, Charlie Morain
%  DATE: 12/1/22
%
%  DESCRIPTION OF LOCAL VARIABLES:
%   R: universal gas constant for air [J/kgK]
%   y: the total number of the array containing the crank angle
%
%  FUNCTIONS CALLED:
%   none
%
%  START OF EXECUTABLE CODE

R = 287; % [J/kgK]
y = length(slidermech.crank.angle);

    for n = 1:y 
        if (slidermech.crank.angle(n) >= 4.70) && (slidermech.crank.angle(n) <= 4.72) %Determines if the crank angle of the piston crank is at 3pi/2
            slidermech.mass = (slidermech.pressureBDC*slidermech.volume(n))/(R*slidermech.temp); %Caluclates the mass using the ideal gas law
            slidermech.volumeBDC = slidermech.volume(n); %Set the calculated mass to the mass at BDC
        end 

    end
end






function [totalmass] = totalMassCalc(powerpiston,displacer,regenerator)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  FUNCTION NAME: totalMassCalc
%
%  PURPOSE: Calculate the total mass of the air within the closed system
%
%  INPUT:
%   powerpiston: stucture containing the information for the powerpiston
%   displacer: structure containing the information for the displacer
%   regnerator: structure containing the informaiton for the regenerator
%
%  OUTPUT:
%   totalmass: value representing the total mass of air within the system
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  AUTHOR: Luke MacKinnon, Ryan Goepfrich, Mitchel Medvec, Charlie Morain
%  DATE: 12/1/22
%
%  DESCRIPTION OF LOCAL VARIABLES:
%   totalmass: total mass of the air within the system
%
%  FUNCTIONS CALLED:
%   none
%
%  START OF EXECUTABLE CODE
totalmass = powerpiston.mass+displacer.mass+regenerator.mass;
end






function [slidermech] = PosVelAccelAnalysis(slidermech)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  FUNCTION NAME: PosVelAccelAnalysis
%
%  PURPOSE : determine the posistion of the given link
%
%  INPUT: 
%   slidermech: structure containing the information for the slider
%   mechanism that is being analyzed
%
%  OUTPUT:
%   slidermech: structure containing updated information for the position
%   of the slidermech
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  AUTHOR: Ryan Goepfrich, Mitchel Medvec, Charlie Morain, Luke MacKinnon
%  DATE: 11/27/22
%
%  DESCRIPTION OF LOCAL VARIABLES
%   S = posistion of the element being analyzed
%   theta_S: the lead time of  the displacer in radians
%  FUNCTIONS CALLED
%   deg2rad
%  START OF EXECUTABLE CODE
%

theta_S = deg2rad(90);

slidermech.crod.angle = theta_S + asin((-slidermech.crank.length/slidermech.crod.length)*sin(slidermech.crank.angle-theta_S)); 
S = slidermech.crank.length*sin(slidermech.crank.angle)+slidermech.crod.length*cos(slidermech.crod.angle-theta_S);
slidermech.crod.vector = slidermech.crod.length*(cos(slidermech.crod.angle)+ 1i*sin(slidermech.crod.angle));
slidermech.S = S;
slidermech.Scheck = imag(slidermech.crank.vector)+imag(slidermech.crod.vector);

end






function [power1,omega] = PowerMethod1(total)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  FUNCTION NAME: PowerMethod1
%
%  PURPOSE: calculates the power produced by the stirling engine using
%  method 1 - area under the P-V curve
%
%  INPUT:
%   total: structure containing the important calculated values
%
%  OUTPUT:
%   power1: the calculated power using this method
%   omega: the average rotational velocity for the system
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  AUTHOR: Luke MacKinnon, Ryan Goepfrich, Mitchel Medvec, Charlie Morain
%  DATE: 12/1/22
%
%  DESCRIPTION OF LOCAL VARIABLES:
%   work: total area under the PV curve
%
%  FUNCTIONS CALLED:
%   trapz
%
%  START OF EXECUTABLE CODE

omega = 2000;                   % Average rotational velocity [rpm]

% Calculating work using trapz function. This will be used to calculate the
% power output of the engine
work = trapz(total.volume,total.pressure);

% Calculating the power out put of the stirling engine using method 1
% (integral of the P-V curve)
power1 = work*omega/60;

end






function power2 = PowerMethod2(total)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  FUNCTION NAME: PowerMethod2
%
%  PURPOSE: Calculates the power using the average rotational velocity and 
%  the average torque
%
%  INPUT:
%   total: structure containing all of the important calculations
%
%  OUTPUT:
%   power2: the power calculated using this method
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  AUTHOR: Luke MacKinnon, Ryan Goepfrich, Mitchel Medvec, Charlie Morain
%  DATE: 12/1/22
%
%  DESCRIPTION OF LOCAL VARIABLES:
%   none
%  FUNCTIONS CALLED:
%   none
%
%  START OF EXECUTABLE CODE

% Calculating the power output of the Stirling engine using method 2
% (product of the average rotational velocity and the average torque)
power2 = total.omegaAvg*total.torqueAvg/9.5488;

end






function [force] = forcecalc(total,powerpiston)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  FUNCTION NAME: forcecalc
%
%  PURPOSE: Calculates the force acting on the piston at each CAD
%
%  INPUT: 
%   total: structure containing the calculated values
%   powerpiston: structure containing information for the powerpiston
%
%  OUTPUT:
%   force: array of all the forces acting on the piston at each CAD
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  AUTHOR: Luke MacKinnon, Ryan Goepfrich, Mitchel Medvec, Charlie Morain
%  DATE: 12/1/22
%
%  DESCRIPTION OF LOCAL VARIABLES:
%   none
%  FUNCTIONS CALLED:
%   none
%
%  START OF EXECUTABLE CODE

force = (total.pressure-101300)*(powerpiston.area);

end






function [totalPressure] = pressurecalc(total,powerpiston,displacer,regenerator)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  FUNCTION NAME: pressurecalc
%
%  PURPOSE: Calculate the total pressure in the cylinder using partial
%  pressures
%
%  INPUT:
%   total: structure containing all of the important calculated values
%   powerpiston: structure contating information for the powerpiston
%   displacer: structure containing information for the displacer
%   regenerator: structure containing information for the regenerator
%
%  OUTPUT:
%   totalpressure: returns an array of the totalpressure at the different
%   crank angles
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  AUTHOR: Luke MacKinnon, Ryan Goepfrich, Mitchel Medvec, Charlie Morain
%  DATE: 12/2/22
%
%  DESCRIPTION OF LOCAL VARIABLES:
%   R: universal gas constant of air [J/kgK]
%   y: total number of different crank angles
%
%  FUNCTIONS CALLED:
%   length
%
%  START OF EXECUTABLE CODE

R = 287; % [J/kgK]
y = length(powerpiston.crank.angle);

% At each CAD calcuates the total pressure using partial pressures from the
% ideal gas law
    for n = 1:y
        totalPressure(n) = ((total.mass)*R)/((powerpiston.volume(n)/powerpiston.temp)+(displacer.volume(n)/displacer.temp)+(regenerator.volume/regenerator.temp));
    end

end






function [T_0]  = torqueTheta(theta, avg_torque, heightmax, mass_total)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  FUNCTION NAME: torqueTheta
%
%  PURPOSE: generate a function to be used as an anonoumous function in
%  terms of theta to input to ODE45
%
%  INPUT:
%       theta: the crank angle
%       avg_torque: average torque of cycle
%       heighmax: height of piston casing
%       mass_total: total air mass
%
%  OUTPUT:
%       T_0: function for normalized torque
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  AUTHOR: Luke MacKinnon, Ryan Goepfrich, Mitchel Medvec, Charlie Morain
%  DATE: 12/1/22
%
%  DESCRIPTION OF LOCAL VARIABLES:
%
%  FUNCTIONS CALLED:
%       powerpistonsetup: creates power piston vectors and positions
%       displacersetup: creates displacer vectors and positions
%       regeneratorsetup: defines regenerator
%       PosVelAccelAnalysis: determines the position and agnles of the given link
%       VolumePowerPiston: determines the air volume of the power piston
%       section
%       VolmeDisplacer: determines the air volume of the displacer section
%       totalVolumeCalc: determines the total volume and sepcific volume of the system
%       pressureCalc: calculates the pressure at the given crank angle
%       forcecalc: calculates the force at the given crank angle
%       calcTorque: calculates the torque at the given crank angle
%
%  START OF EXECUTABLE CODE

powerpiston = powerpistonsetup(theta);
displacer = displacersetup(powerpiston);
regenerator = regeneratorsetup();

powerpiston = PosVelAccelAnalysis(powerpiston);
displacer = PosVelAccelAnalysis(displacer);
total.heightmax = heightmax;

powerpiston = VolumePowerPiston(powerpiston,displacer);
displacer = VolumeDisplacer(displacer,total);

total.mass = mass_total;

[total.volume,total.specificvolume] = totalVolumeCalc(displacer,powerpiston,regenerator,total);
total.pressure = pressurecalc(total,powerpiston,displacer,regenerator);

total.force = forcecalc(total,powerpiston);
total.torque = calcTorque(total.force, powerpiston);

T_0 = total.torque - avg_torque;

end






function [displacer] = displacersetup(powerpiston)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  FUNCTION NAME: powerpistonsetup
%
%  PURPOSE - setup the basic diamensions of the power power piston
%
%  INPUT - N/A 
%
%  OUTPUT - powerpiston
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  AUTHOR: Ryan Goepfrich   
%  DATE: 11/29/22
%
%  DESCRIPTION OF LOCAL VARIABLES
%   
%   displacer.crank.length = crank length of displacer
%   displacer.crod.length= connecting rod length of displacer
%   displacer.volume: volume of air above displacer (Placeholder value)
%   displacer.crank.angle: CAD of the displacer in reference to the
%   powerpiston
%   displacer.diameter: diameter of the displacer
%   dispacer.crank.vector: length of the displacer crank in terms of vector
%   notation
%   displacer.temp: temperature of the air above the displacer
%   displacer.area: surface area of the displacer
%   displacer.pressureBDC: pressure of the air above the displacer at BDC
%   
%  
% FUNCTIONS CALLED
%   deg2rad
%  START OF EXECUTABLE CODE
%

displacer.crank.length = 0.0138; % [m] (r_OaC)
displacer.crod.length = 0.0705; % [m] (r_CD)
displacer.volume = 0; % [m^2] (V_disp)
displacer.crank.angle = powerpiston.crank.angle+deg2rad(90);
displacer.diameter = 0.07; % [m]
displacer.crank.vector = displacer.crank.length*(cos(displacer.crank.angle)+ 1i*sin(displacer.crank.angle));
displacer.temp = 900; % [k]
displacer.area = pi*(displacer.diameter/2)^2;
displacer.pressureBDC = 500*1000; % [Pa]

end






function [flywheel] = flywheelsetup()
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  FUNCTION NAME: flywheelsetup
%
%  PURPOSE - setup the basic diamensions of the flywheel
%
%  INPUT - N/A 
%
%  OUTPUT - flywheel structure
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  AUTHOR: Ryan Goepfrich   
%  DATE: 11/29/22
%
%  DESCRIPTION OF LOCAL VARIABLES
%   
%   flywheel.thickness = thickness of the fly wheel (given)
%   flywheel.diameter = diameter of the fly wheel (not given get to choose)
%   flywheel.width = width of the fly wheel (given)
%   flywheel.density: density of steel [kg/m^3]
%   flywheel.modulus: modulus of elasticity of steel [GPa]
%   flywheel.sut: ultimate tensile strength of steel [MPa]
%   flywheel.sy: yield strength of steel [MPa]
%
%  
% FUNCTIONS CALLED
%
%  START OF EXECUTABLE CODE
%

flywheel.thickness = 0.07; % [m]
flywheel.diameter = 0.8; % [m] (choose random number for right now - updated in later function)
flywheel.width = 0.05; % [m]

flywheel.density =  7660; % [Kg/m^3]
flywheel.modulus = 207; % [GPa]
flywheel.sut = 420; % [MPa] 
flywheel.sy = 350; % [MPa] 


end






function [powerpiston] = powerpistonsetup(theta)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  FUNCTION NAME: powerpistonsetup
%
%  PURPOSE - setup the basic diamensions of the power power piston
%
%  INPUT - N/A 
%
%  OUTPUT - powerpiston
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  AUTHOR: Ryan Goepfrich   
%  DATE: 11/29/22
%
%  DESCRIPTION OF LOCAL VARIABLES
%   
%   powerpiston.crank.length = crank length of power piston
%   powerpiston.crod.length= connecting rod length
%   powerpiston.crank.angle = angle of the crank for the power piston
%   powerpiston.diameter = diameter of the power piston
%   powerpiston.crank.vector = length of the crank attached to the power piston in vector coordinates 
%   powerpiston.temp = temperature of the air above the powerpiston [K]
%   powerpiston.pressureBDC = pressure of the air above powerpiston at BDC
%   [Pa]
%   powerpiston.area = surface area of the powerpiston 
%  
% FUNCTIONS CALLED
%
%  START OF EXECUTABLE CODE
%

powerpiston.crank.length = 0.0138; % [m] (r_OaA)
powerpiston.crod.length = 0.046; % [m] (r_AB)
powerpiston.crank.angle = theta; % (accounting for phaseshift)
powerpiston.diameter = 0.07; % [m]
powerpiston.crank.vector = powerpiston.crank.length*(cos(powerpiston.crank.angle)+ 1i*sin(powerpiston.crank.angle));
powerpiston.temp = 300; % [K]
powerpiston.pressureBDC = 500*1000; % [Pa]
powerpiston.area = pi*(powerpiston.diameter/2)^2;

end






function [regenerator] = regeneratorsetup()
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  FUNCTION NAME: Regeneratorsetup
%
%  PURPOSE - Setup to define things for the regenerator
%
%  INPUT - none
%
%  OUTPUT - regenerator stucture
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  AUTHOR: Ryan Goepfrich   
%  DATE: 11/30/22
%
%  DESCRIPTION OF LOCAL VARIABLES
%   regenerator.volume = dead colume inside of the regnerator
%   regenerator.temp = temperature of the air inside the regenerator
%   regenerator.mass = mass of the air inside regenerator (Calculated using
%   ideal gas las
%   R = univeral gas constant of air [J/kgK]
%  
%   FUNCTIONS CALLED
%   none
%  START OF EXECUTABLE CODE
%


R = 287; % [J/kgK]

regenerator.volume = 0.00001; %[m^3] 

regenerator.temp = (900+300/2); % [K]
regenerator.pressureBDC = 500*1000; % [K]
regenerator.mass = (regenerator.pressureBDC*regenerator.volume)/(R*regenerator.temp);

end






function [T]  = calcTorque(F_P, powerpiston)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  FUNCTION NAME: calcTorque
%
%  PURPOSE: Determine the torque for each theta and piston force
%
%  INPUT: 
%       F_P: The array of piston forces for each theta
%       powerpiston: powerpiston structure
%
%  OUTPUT:
%       T: array of torque values for each theta
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  AUTHOR: Luke MacKinnon, Ryan Goepfrich, Mitchel Medvec, Charlie Morain
%  DATE: 12/1/22
%
%  DESCRIPTION OF LOCAL VARIABLES:
%       F_43x: the force acting on link 3 by link 4 in the x direction
%       F_32: the force acting on link 2 by link 3 in complex form
%
%  FUNCTIONS CALLED:
%       real(): real portion of complex number
%       imag(): imaginary portion of complex number
%
%  START OF EXECUTABLE CODE

% Determine force vector acting on the crank
F_P = -1.*F_P;
F_43x = F_P.*real(powerpiston.crod.vector)./imag(powerpiston.crod.vector);
F_32 = -F_43x + F_P.*1i;

% Using force vectors to create an array of torque values for each value of
% theta
T = real(F_32).*imag(powerpiston.crank.vector) + imag(F_32).*real(powerpiston.crank.vector);
end






function [torqueAvg]  = calcTorqueAvg(total,theta)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  FUNCTION NAME: calcTorqueAvg
%
%  PURPOSE: determine the average torque for 1 cycle
%
%  INPUT:
%       total: structure containing torque array
%       theta: array of crank angles in radians
%
%  OUTPUT:
%   torqueAvg: average torque of the mechanism
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  AUTHOR: Luke MacKinnon, Ryan Goepfrich, Mitchel Medvec, Charlie Morain
%  DATE: 12/1/22
%
%  DESCRIPTION OF LOCAL VARIABLES: NONE
%
%  FUNCTIONS CALLED:
%       trapz(): trapezoidal integreation function
%
%  START OF EXECUTABLE CODE

% Calculating the average torque for 1 cycle to be used in needed
% deliverables for this project
torqueAvg = (1/(2*pi))*trapz(theta,total.torque);

end






function [flywheelDiam, power1, power2]  = VaryingParameter(C_R)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  FUNCTION NAME: VaryingParameter
%
%  PURPOSE: Calcualte the flywheel diameter and the power through two
%  methods based on a specific Compression ratio
%
%  INPUT: 
%   C_R: compression ratio
%
%  OUTPUT:
%   flywheelDiam: diameter of the flywheel
%   power1: power calculated using method 1 - trapz [W]
%   power2: power calculated using method 2 - rot.vel*torque [W]
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  AUTHOR: Luke MacKinnon, Ryan Goepfrich, Mitchel Medvec, Charlie Morain
%  DATE: 12/1/22
%
%  DESCRIPTION OF LOCAL VARIABLES:
%   theta: array of all the CAD that the stirling engine goes through in
%   one cycle
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



%% Determine KE and I
total.KE = calcKE(theta, total);
total.cf = 0.002;
flywheel.I = total.KE/(total.cf*((total.omegaAvg*2*pi/60)^2));
flywheel.diameter = calcD(flywheel);

flywheelDiam = flywheel.diameter;
power1 = total.power1;
power2 = total.power2;

end






function [varying]  = VaryingProperties( )
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  FUNCTION NAME: VaryingProperties
%
%  PURPOSE: Varies two properties of the stirling engine to determine their
%  effect on the power and flywheel diameter
%
%  INPUT:
%
%  OUTPUT:
%   varying: structure containing the values for the varying compression
%   ratio and High temperature region in the stirling engine
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  AUTHOR: Luke MacKinnon, Ryan Goepfrich, Mitchel Medvec, Charlie Morain
%  DATE: 12/1/22
%
%  DESCRIPTION OF LOCAL VARIABLES:
%   varying.lowCR: low compression ratio that is being looked at
%   varying.highCR: high compression ratio that is being looked at
%   varying.CR: array of compression ratios that are being studied
%   varying.varyingFlywheelDiamCR: an array of varying flywheel diameter
%   caused by varying the Compression ratio
%   varying.varyingPower1CR: varying power outputs caused by varying
%   Compression ratios
%   varying.varyingPower2CR: array of varraying power outputs from method 2
%   caused by varying Compression ratio
%   varying.lowTHigh: low temp range of the high temperature region
%   varying.highTHigh: high temp bound of the high temperature region
%   varying.varyingTemp: array containing temperature in which the
%   parameters are varied for
%   varying.varyingFlywheelDiamTemp: array of flywheel diameters from
%   varying the temperatures
%   varying.varyingPower1Temp: array of the powers from method 1 based on
%   different temperatures
%   varying.varyingPower2Temp: array of the powers from method 2 based on
%   different temperatures
%
%  FUNCTIONS CALLED:
%   linspace
%   VaryingParameter
%   
%  START OF EXECUTABLE CODE

varying.lowCR = 1.1;
varying.highCR = 2;
varying.CR = linspace(varying.lowCR, varying.highCR, 10);


for i=1:numel(varying.CR)
     [varying.varyingFlywheelDiamCR(i), varying.varyingPower1CR(i), varying.varyingPower2CR(i)] = VaryingParameter(varying.CR(i));
end

varying.lowTHigh = 700;
varying.HighTHigh = 1100;
varying.varyingTemp = linspace(varying.lowTHigh, varying.HighTHigh, 200);

for i=1:numel(varying.varyingTemp)
     [varying.varyingFlywheelDiamTemp(i), varying.varyingPower1Temp(i), varying.varyingPower2Temp(i)] = VaryingTemp(varying.varyingTemp(i));
end

end






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






function [h] = hcalc(powerpiston,regenerator,C_R)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  FUNCTION NAME: hcalc
%
%  PURPOSE: Calculates the max height of the powerpiston
%
%  INPUT:
%   powerpiston: structure containing information for the powerpiston
%   regenerator: structure containing information for the regenerator
%   C_R: compression ratio
%
%  OUTPUT:
%   h: height of the powerpiston
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  AUTHOR: Luke MacKinnon, Ryan Goepfrich, Mitchel Medvec, Charlie Morain
%  DATE: 12/1/22
%
%  DESCRIPTION OF LOCAL VARIABLES:
%   Area: surface area of the powerpiston
%  FUNCTIONS CALLED:
%   none
%  START OF EXECUTABLE CODE

 % Compression Ratio
Area = pi*(powerpiston.diameter/2)^2;

h = (C_R*max(powerpiston.S)-C_R*(regenerator.volume/Area)-min(powerpiston.S)+(regenerator.volume/Area))/(C_R-1);

end






function [VolumeTotal,SpecificVolume] = totalVolumeCalc(displacer,powerpiston,regenerator,total)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  FUNCTION NAME: totalVolumeCalc
%
%  PURPOSE: Calculates the total volume of air within the cylinder
%
%  INPUT:
%   displacer: structure containing information for the displacer
%   powerpiston: structure containing information for the powerpiston
%   regenerator: structure contating information for the regnerator
%   total: structure containing the final calulations for important values
%
%  OUTPUT:
%   VolumeTotal: total volume of air within the cylinder
%   SpecificVolume: the specific volume of the air within the cylinder
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  AUTHOR: Ryan Goepfrich   
%  DATE: 11/30/22
%
%  DESCRIPTION OF LOCAL VARIABLES
%   none
%  
%   FUNCTIONS CALLED
%   none
%  START OF EXECUTABLE CODE
%

VolumeTotal = displacer.volume+powerpiston.volume+regenerator.volume;
SpecificVolume = VolumeTotal/total.mass;
end






function [displacer] = VolumeDisplacer(displacer,total)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  FUNCTION NAME: VolumeDisplacer
%
%  PURPOSE: calculate the volume above the displacer
%
%  INPUT:
%   displacer: structure containing all information for the displacer
%   total: sturcture contating the important values that have been
%   calculated
%
%  OUTPUT:
%   displacer: updated structure with the volume above the displacer
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  AUTHOR: Ryan Goepfrich   
%  DATE: 11/30/22
%
%  DESCRIPTION OF LOCAL VARIABLES
%   none
%  
%   FUNCTIONS CALLED
%   none
%
%  START OF EXECUTABLE CODE
%

displacer.volume = (total.heightmax-displacer.S)*displacer.area; %finds the distance between top of cylinnder and the displacer and calculates volume using surface area times height
end

%% End of Program