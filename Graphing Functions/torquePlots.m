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

figure('Name', 'Force and Torque Plots','NumberTitle','off');
subplot(2,1,1)
plot(theta2,total.force)
xlabel('Crank Angle [deg]')
ylabel('Force [N]')
xlim([0,360])
title('Force vs. Crank Angle')

subplot(2,1,2)
figure
a1 = plot(theta2, total.torque);
yline(0, 'color', 'k')
a2 = yline(total.torqueAvg, 'color', 'r');
xlabel('Crank Angle [deg]')
ylabel('Torque [Nm]')
xlim([0,360])
ylim([-32, 55])
title('Torque vs. Crank Angle')
legend([a2, a1], {'Average Torque', 'Engine Torque'})

end
