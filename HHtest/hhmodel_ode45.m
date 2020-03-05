%% Hodgkin Huxley Differential Equation Solver
%% Constants set for all Methods
% Define the constants used
Cm = 0.01; %Membrane Capacitance
I = 0; % External Current
gK_tot = 0.36; % Maximum conductance for K
gNa_tot = 1.20; % Maximum conductance for Na
gleak_tot = 0.003; % Maximum conductance for leak current

Eleak = -49.42; % Nernst potential for leak current
ENa = 55.17; % Nernst potential for Na
EK = -72.14; % Nernst potential for K

%Cm=0.01; % Membrane Capacitance
%dt=0.04; % Time Step 
%t=0:dt:25; %Time Duration of the entire Simulation
%I=0.1; %External Current Applied

Eleak = -49.42; % Nernst potential for leak current
ENa = 55.17; % Nernst potential for Na
EK = -72.14; % Nernst potential for K
%gNa_tot = 1.2; % Maximum conductance for Na

%gK_tot = 0.36; % Maximum conductance for K

%gleak_tot = 0.003; % Maximum conductance for leak current
 
%% Setting up initial voltage
V=-60; % Initial Membrane voltage
m=am(V)/(am(V)+bmm(V)); % Initial m-value
n=an(V)/(an(V)+bn(V)); % Initial n-value
h=ah(V)/(ah(V)+bh(V)); % Initial h-value
y0=[V;n;m;h];
tspan = [0,max(t)];

[time1, V] = ode45(@HH,t,y0);

[time2,V_Brugada] = ode45(@HH_Brugada,t,y0);

V_timecourse=V(:,1);
V_timecourse2=V_Brugada(:,1);
plot(time1, V_timecourse)
hold on
%plot(time2, V_timecourse2)