function []  = PlotVaryingCR(total)
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
plot(total.CR, total.varyingFlywheelDiamCR);
xlabel('Compression Ratio');
ylabel('Flywheel Diameter');
title('Compression ratio vs Flywheel Diameter')

subplot(2,1,2)
plot(total.CR, total.varyingPower1CR);
xlabel('Compression Ratio');
ylabel('Power [W]')
title('Compression Ratio vs Power (method 1)')

%subplot(2,1,1)
%plot(total.CR, total.varyingPower2);
%xlabel('Compression Ratio');
%ylabel('Power [W]');
end

