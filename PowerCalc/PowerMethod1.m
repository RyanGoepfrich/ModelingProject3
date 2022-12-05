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

work = trapz(total.specificvolume,total.pressure); %calculates the area under the P-v curve

power1 = work*omega/60; %calculates the power using the frequency of cycles
end

