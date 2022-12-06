function [varying]  = VaryingProperties( )
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
