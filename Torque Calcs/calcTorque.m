function [T]  = calcTorque(F_P, powerpiston)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  FUNCTION NAME: calcTorque
%
%  PURPOSE: Determine the torque for each theta and piston force
%
%  INPUT: 
%       F_P: The array of piston forces for each theta
%       powerpiston: powerpiston structure
%
%  OUTPUT:
%       T: array of torque values for each thetat
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  AUTHOR: Luke MacKinnon, Ryan Goepfrich, Mitchel Medvec, Charlie Morain
%  DATE: 12/1/22
%
%  DESCRIPTION OF LOCAL VARIABLES:
%       F_43x: the force acting on link 3 by link 4 in the x direction
%       F_32: the force acting on link 2 by link 3 in complex form
%
%  FUNCTIONS CALLED:
%       real(): real portion of complex number
%       imag(): imaginary portion of complex number
%
%  START OF EXECUTABLE CODE

% Determine force vector acting on the crank
F_P = -1.*F_P;
F_43x = F_P.*real(powerpiston.crod.vector)./imag(powerpiston.crod.vector);
F_32 = F_43x + F_P.*1i;

T = real(F_32).*imag(powerpiston.crank.vector) + imag(F_32).*real(powerpiston.crank.vector);
end

