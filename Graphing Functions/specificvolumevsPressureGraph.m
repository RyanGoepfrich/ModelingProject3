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


Tv1 = linspace(900, 900, length(total.specificvolume));
Tv2 = linspace(300, 300, length(total.specificvolume));
Vv1 = linspace(min(total.specificvolume), max(total.specificvolume), length(total.specificvolume));

R = 287;


p = @(T,V) R*T./V;

figure('Name','Output Plots','NumberTitle','off');
subplot(2,2,1)
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










