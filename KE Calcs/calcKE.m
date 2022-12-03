function [KE]  = calcKE(theta, total)
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
