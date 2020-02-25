function dydt = HH(t,y) 
% This function returns the four differential equations to solve for the HH
% model

% Define the constants used
Cm = 0.01; %Membrane Capacitance
I = 0.1; % External Current
ENa = 55.17; % Nernst potential for Na
gNa_tot = 1.2; % Maximum conductance for Na
EK = -72.14; % Nernst potential for K
gK_tot = 0.36; % Maximum conductance for K
Eleak = -49.42; % Nernst potential for leak current
gleak_tot = 0.003; % Maximum conductance for leak current

% Set the initial values equal to input
V = y(1); % Initial voltage value
n = y(2); % Constant for activation gate of Potassium Channel
m = y(3); % Constant for activation gate of Sodium Channel
h = y(4); % Constant for inactivation gate of Sodium Channel

% Set the conductance values
gNa = gNa_tot*m^3*h; % Relevant conductance for Sodium Channel
gK = gK_tot*n^4; % Relevant conductance for Potassium Channel
gleak = gleak_tot; % Relevant conductance for leak current
INa=gNa*(V-ENa); % Ionic Current due to Sodium 
IK=gK*(V-EK); % Ionic Current due to Potassium
Il=gleak*(V-Eleak); % Ionic current due to leak

% Final Hodgkin-Huxley Differential equations
dydt = [((1/Cm)*(I-(INa+IK+Il))); an(V)*(1-n)-bn(V)*n; am(V)*(1-m)-bm(V)*m; ah(V)*(1-h)-bh(V)*h];

end

