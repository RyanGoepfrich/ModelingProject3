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

figure('Name', 'Changing Compression Ratio Plots','NumberTitle','off');
subplot(2,1,1)
plot(varying.CR, varying.varyingFlywheelDiamCR);
xlabel('Compression Ratio');
ylabel('Flywheel Diameter [m]');
title('Compression ratio vs Flywheel Diameter')

subplot(2,1,2)
plot(varying.CR, varying.varyingPower1CR);
xlabel('Compression Ratio');
ylabel('Power [W]')
title('Compression Ratio vs Power')

figure('Name', 'Changing High Temperature of Air','NumberTitle','off');
subplot(2,1,1)
plot(varying.varyingTemp, varying.varyingFlywheelDiamTemp);
xlabel('High Temperature [K]');
ylabel('Flywheel Diameter [m]');
title('High Temperature vs Flywheel Diameter')

subplot(2,1,2)
plot(varying.varyingTemp, varying.varyingPower1Temp);
xlabel('High Temperature [K]');
ylabel('Power [W]')
title('High Temperature vs Power')

end

