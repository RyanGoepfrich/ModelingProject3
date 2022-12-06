function []  = PlotVaryingParam(varying)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  FUNCTION NAME:
%
%  PURPOSE:
%
%  INPUT:
%
%  OUTPUT:
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  AUTHOR: Luke MacKinnon, Ryan Goepfrich, Mitchel Medvec, Charlie Morain
%  DATE: 12/1/22
%
%  DESCRIPTION OF LOCAL VARIABLES:
%
%  FUNCTIONS CALLED:
%
%
%  START OF EXECUTABLE CODE

figure('name', 'Changing Compression Ratio Plots')
subplot(2,1,1)
plot(varying.CR, varying.varyingFlywheelDiamCR);
xlabel('Compression Ratio');
ylabel('Flywheel Diameter');
title('Compression ratio vs Flywheel Diameter')

subplot(2,1,2)
plot(varying.CR, varying.varyingPower1CR);
xlabel('Compression Ratio');
ylabel('Power [W]')
title('Compression Ratio vs Power (method 1)')

%subplot(2,1,1)
%plot(varying.CR, varying.varyingPower2);
%xlabel('Compression Ratio');
%ylabel('Power [W]');

figure('name', 'Changing High Temperature of air')
subplot(2,1,1)
plot(varying.varyingTemp, varying.varyingFlywheelDiamTemp);
xlabel('High Temperature');
ylabel('Flywheel Diameter');
title('High Temperature vs Flywheel Diameter')

subplot(2,1,2)
plot(varying.varyingTemp, varying.varyingPower1Temp);
xlabel('High Temperature');
ylabel('Power [W]')
title('High Temperature vs Power (method 1)')

%subplot(2,1,1)
%plot(varying.varyingTemp, varying.varyingPower2Temp);
%xlabel('High Temperature');
%ylabel('Power [W]');
end

