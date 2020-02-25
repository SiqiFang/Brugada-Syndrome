%% Hodgkin Huxley Differential Equation Solver
%% Constants set for all Methods

Cm=0.01; % Membrane Capacitance
dt=0.04; % Time Step 
t=0:dt:25; %Time Duration of the entire Simulation
I=0.1; %External Current Applied

ENa = 55.17; % Nernst potential for Na
gNa_tot = 1.2; % Maximum conductance for Na
EK = -72.14; % Nernst potential for K
gK_tot = 0.36; % Maximum conductance for K
Eleak = -49.42; % Nernst potential for leak current
gleak_tot = 0.003; % Maximum conductance for leak current
 
%% Setting up initial voltage
V=-60; % Initial Membrane voltage
m=am(V)/(am(V)+bm(V)); % Initial m-value
n=an(V)/(an(V)+bn(V)); % Initial n-value
h=ah(V)/(ah(V)+bh(V)); % Initial h-value
y0=[V;n;m;h];
tspan = [0,max(t)];

[time,V] = ode45(@HH,tspan,y0);

[time,V_Brugada] = ode45(@HH_Brugada,tspan,y0);

V_timecourse=V(:,1);
V_timecourse2=V_Brugada(:,1);
plot(time, V_timecourse)
hold on
plot(time, V_timecourse2)