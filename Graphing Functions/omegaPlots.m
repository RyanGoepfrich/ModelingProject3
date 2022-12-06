function [  ]  = omegaPlots(theta, omega)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  FUNCTION NAME: omegaPlots
%
%  PURPOSE: generate the rotaional velocity plot
%
%  INPUT:
%       theta: crank angle
%       omega: the rotational velocity
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

figure('name', 'rotational velocity vs. crank angle')
a1 = plot(omega, theta);
xlabel('Crank Angle [Rad]')
ylabel('Rotational Veloctiy [RPM]')
a2 = yline(2000);
legend([a1, a2], {'Rot. Velocity', 'Average Rot. Velocity'})

end
