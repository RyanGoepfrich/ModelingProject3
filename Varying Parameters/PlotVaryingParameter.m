function []  = PlotVaryingParameter(total)
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

subplot(2,2,1)
plot(total.CR, total.varyingFlywheelDiam);
xlabel('Compression Ratio');
ylabel('Flywheel Diameter');

subplot(2,2,2)
plot(total.CR, total.varyingPower1);
xlabel('Compression Ratio');
ylabel('Power [W]')

subplot(2,1,1)
plot(total.CR, total.varyingPower2);
xlabel('Compression Ratio');
ylabel('Power [W]');


end


