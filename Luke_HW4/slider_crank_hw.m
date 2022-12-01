%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  PROGRAM NAME: SLIDER CRANK
%
%  PURPOSE: Determine the forces on joints of the slider mechanism
%
%  AUTHOR: Luke MacKinnon
%  DATE: 11/28/22
%
%  FUNCTIONS CALLED:
%       calc_accel: calculates accleration vectors
%       printVectors: prints to terminal the results
%
%  START OF EXECUTABLE CODE
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


clear
clc
close all

%% Define System Properties
m2 = 1.5;       % [kg]
m3 = 0.11;      % [kg]
m4 = 0.13;      % [kg]
g = 9.81;       % [m/s^2]

IG2 = 4e-3;     % [kgm]
IG3 = 0.134e-3; % [kgm]

% Link Lengths
OA = 0.02;      % [m]
AB = 0.08;      % [m]

% Center of Gravity Lengths
OG2 = 0;        % [m]
AG3 = 0.033;    % [m]
BG4 = 0.016;    % [m]

% Angles
theta2 = deg2rad(92);    % [degrees]
thetaS = deg2rad(90);    % [degrees]


% Crank Speed
omega2 = 4000;  % [RPM]
omega2 = omega2*2*pi/60;    % [rad/s]

% Crank Acceleration
alpha2 = 0;

% Piston Force
F_P = 1604.5;   % [N]

%% Position Analysis
% Link 2 Position Vector
D = OA*exp(1i*theta2);

% Rotation angle of Link 3
theta3 = asin(real(D)/AB) + (pi/2);

% Link 3 Position Vector
C = AB*exp(1i*theta3);

% Slider Position Vector
S = D + C;

% Center of Gravity Positions
r_OG2 = OG2*exp(1i*theta2);
r_AG3 = -AG3*exp(1i*theta3);
r_BG3 = (AB - AG3)*exp(1i*theta3);

%% Velocity Analysis
% Velocity of Joint A
VA = 1i*OA*omega2*exp(1i*theta2);

% Rotational Velocity of Link 3
omega3 = -omega2*OA*cos(theta2 - thetaS)/(AB*cos(theta3 - thetaS));

% Velocity of Slider
VB = VA + (1i*AB*omega3*exp(1i*theta3));

%% Acceleration Analysis
% Determine the acceleration of all Centers of Gravity

% Link 2
a_G2 = calc_accel(OG2, omega2, theta2, alpha2);
a_A = calc_accel(OA, omega2, theta2, alpha2);

% Link 3
alpha3 = (OA*(((omega2^2)*sin(theta2 - thetaS)) - (alpha2*cos(theta2 - thetaS))) + (AB*(omega3^2)*sin(theta3 - thetaS)))/(AB*cos(theta3 - thetaS)); 

a_G3A = calc_accel(AG3, omega3, theta3, alpha3);
a_BA = calc_accel(AB, omega3, theta3, alpha3);

a_G3 = a_A + a_G3A;
a_B = a_A + a_BA;

% Slider
a_S = -(OA*(((omega2^2)*cos(theta2 - theta3)) + (alpha2*sin(theta2 - theta3))) + (AB*(omega3^2)))/(cos(theta3 - thetaS)); 


%% Force Analysis
A = [1 0 1 0 0 0 0;
     0 1 0 1 0 0 0;
     0 0 -1 0 1 0 0;
     0 0 0 -1 0 1 0;
     0 0 0 0 0 -1 0;
     0 0 -imag(D) real(D) 0 0 1;
     0 0 imag(r_AG3) -real(r_AG3) -imag(r_BG3) real(r_BG3) 0];

% Reference for X definitions
% X = [F_21x;
%      F_21y;
%      F_32x;
%      F_32y;
%      F_43x;
%      F_43y;
%      T];
 
B = [m2*real(a_G2);
     m2*imag(a_G2) + m2*g;
     m3*real(a_G3)
     m3*imag(a_G3) + m3*g;
     m4*imag(a_B) + m4*g + F_P;
     IG2*alpha2;
     IG3*alpha3];
 
X = A\B;

%% Output Values
printVectors(X(1) + (X(2)*1i), 'Pin Force OA');
printVectors(X(3) + (X(4)*1i), 'Pin Force A');
printVectors(X(5) + (X(6)*1i), 'Pin Force B');
torquePrint = ['Crank Torque: ', num2str(X(7)), ' [Nm]'];
disp(torquePrint)

%% Functions

function [a]  = calc_accel(r, omega, theta, alpha)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  FUNCTION NAME: calc_accel
%
%  PURPOSE: calculate the relative acceleration of a point on a link
%
%  INPUT:
%       r: distance to point on rotating link
%       omega: rotational velocity
%       theta: angle of rotation
%       alpha: rotational acceleration
%
%  OUTPUT:
%       a: acceleration vector
%
%  AUTHOR: Luke MacKinnon
%  DATE: 11/28/22
%
%  DESCRIPTION OF LOCAL VARIABLES:
%       a_normal = normal acceleration component
%       a_tangential = tangential acceleration component
%
%  FUNCTIONS CALLED: NONE
%
%  START OF EXECUTABLE CODE
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

a_normal = (-r*(omega^2))*exp(1i*theta);
a_tangential = 1i*(r*alpha)*exp(1i*theta);
a = a_normal + a_tangential;

end

function []  = printVectors(v, prompt)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  FUNCTION NAME: printVectors
%
%  PURPOSE: print the magnitude and direction of vector quanities
%
%  INPUT:
%       v: vector in complex number form
%       prompt: vector name
%
%  OUTPUT: NONE
%       
%  AUTHOR: Luke MacKinnon
%  DATE: 11/29/22
%
%  DESCRIPTION OF LOCAL VARIABLES:
%       X: array of string outputs
%
%
%  FUNCTIONS CALLED: NONE
%
%  START OF EXECUTABLE CODE
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

X = [prompt, newline, 'Magnitude: ', num2str(abs(v)), ' [N]', newline, 'Direction: ', num2str(rad2deg(angle(v))), ' [degrees]', newline];
disp(X)

end
