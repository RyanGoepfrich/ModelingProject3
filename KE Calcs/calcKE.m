function [KE]  = calcKE(theta, total)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  FUNCTION NAME: calcKE
%
%  PURPOSE: determine the kinetic energy of the power stroke
%
%  INPUT:
%       theta: the crank angles in radians
%       total: structure containing torque values
%
%  OUTPUT:
%       KE: the total kinetic energy of the power stroke
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  AUTHOR: Luke MacKinnon, Ryan Goepfrich, Mitchel Medvec, Charlie Morain
%  DATE: 12/1/22
%
%  DESCRIPTION OF LOCAL VARIABLES:
%       T_0: adjusted torque curve that is offset by the average torque
%       thetas: vector containing the the indices of where the power stroke
%       begins (theta_0 and theta_f)
%       cross: counter for how many times the torque zero function crosses the x-axis 
%
%  FUNCTIONS CALLED:
%       trapz: integration function to find kinetic energy
%
%  START OF EXECUTABLE CODE

T_0 = total.torque - total.torqueAvg;
cross = 0;
thetas = [0 0];

for m = 2:length(theta)
    if T_0(m - 1)*T_0(m) < 0
       cross = cross + 1;
       thetas(cross) = m;
    end
end

KE = trapz(theta(thetas(1):thetas(2)), total.torque(thetas(1):thetas(2)));

end
