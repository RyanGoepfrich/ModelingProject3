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
%
%  FUNCTIONS CALLED:
%
%
%  START OF EXECUTABLE CODE


Tv1 = linspace(900, 900, length(total.specificvolume));
Tv2 = linspace(300, 300, length(total.specificvolume));
Vv1 = linspace(min(total.specificvolume), max(total.specificvolume), length(total.specificvolume));

R = 278;


p = @(T,V) R*T./V;

figure('name', 'Pv diagrams')
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










