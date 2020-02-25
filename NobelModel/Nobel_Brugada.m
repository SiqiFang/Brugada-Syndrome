function dydt = Nobel_Brugada(t,y) 
% This function returns the four differential equations to solve for the
% Nobel Brugada model

% Define the constants used
Cm = 2.0; %Membrane Capacitance
ENa = 40; % Nernst potential for Na
EK = -100; % Nernst potential for K
Eanionic = -60; % Nernst potential for anionic
Eleak = -49.42; % Nernst potential for leak current
gleak_tot = 0.003; % Maximum conductance for leak current

% Set the initial values equal to input
V = y(1); % Initial voltage value
n = y(2); % Constant for activation gate of Potassium Channel
m = y(3); % Constant for activation gate of Sodium Channel
h = y(4); % Constant for inactivation gate of Sodium Channel

% Set the conductance values
gleak = gleak_tot; % Relevant conductance for leak current
INa=(400000*m^3*h + 140)*(V-ENa); % Ionic Current due to Sodium 
INa = INa/1.1;
IK1 = fastK(V);
IK2 = 1200*n^4*(V-EK);
IK=IK1 + IK2; % Ionic Current due to Potassium
Il=gleak*(V-Eleak); % Ionic current due to leak
I_anionic = 75*(V-Eanionic);

% Final Nobel Brugada Differential equations
dydt = [((1/Cm)*(-(INa+IK+Il+I_anionic))); an(V)*(1-n)-bn(V)*n; am(V)*(1-m)-bm(V)*m; ah(V)*(1-h)-bh(V)*h];

end

