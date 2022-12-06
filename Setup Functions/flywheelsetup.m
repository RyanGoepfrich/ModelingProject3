function [flywheel] = flywheelsetup()
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  FUNCTION NAME: flywheelsetup
%
%  PURPOSE - setup the basic diamensions of the flywheel
%
%  INPUT - N/A 
%
%  OUTPUT - flywheel structure
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  AUTHOR: Ryan Goepfrich   
%  DATE: 11/29/22
%
%  DESCRIPTION OF LOCAL VARIABLES
%   
%   flywheel.thickness = thickness of the fly wheel (given)
%   flywheel.diameter = diameter of the fly wheel (not given get to choose)
%   flywheel.width = width of the fly wheel (given)
%   flywheel.density: density of steel [kg/m^3]
%   flywheel.modulus: modulus of elasticity of steel [GPa]
%   flywheel.sut: ultimate tensile strength of steel [MPa]
%   flywheel.sy: yield strength of steel [MPa]
%
%  
% FUNCTIONS CALLED
%
%  START OF EXECUTABLE CODE
%

flywheel.thickness = 0.07; % [m]
flywheel.diameter = 0.8; % [m] (choose random number for right now - updated in later function)
flywheel.width = 0.05; % [m]

flywheel.density =  7660; % [Kg/m^3]
flywheel.modulus = 207; % [GPa]
flywheel.sut = 420; % [MPa] 
flywheel.sy = 350; % [MPa] 


end

