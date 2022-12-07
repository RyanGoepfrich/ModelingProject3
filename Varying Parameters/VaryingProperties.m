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
