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
%  FUNCTIONS CALLED: NONE
%
%
%  START OF EXECUTABLE CODE

omega = omega.*60./(2*pi);

figure('Name','Rotational Velocity vs. Crank Angle','NumberTitle','off');
a1 = plot(theta, omega);
xlabel('Crank Angle [Radians]')
xlim([0 2*pi])
ylabel('Rotational Veloctiy [RPM]')
a2 = yline(2000, 'color', 'r');
legend([a1, a2], {'Rot. Velocity', 'Average Rot. Velocity'}, 'location', 'southeast')

end
