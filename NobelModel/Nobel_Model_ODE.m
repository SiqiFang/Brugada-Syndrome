%% Nobel Model Differential Equation Solver
%% Constants set for model set up

Cm=2.0; % Membrane Capacitance
dt=0.0025; % Time Step 
t=0:dt:2.5; %Time Duration of the entire Simulation

% These constants aren't used directly in the following script but are used
% instead in the function establishment of the ODE (put here for reference)

ENa = 40; % Nernst potential for Na
EK = -100; % Nernst potential for K
Eanionic = -60; % Nernst potential for anionic
Eleak = -49.42; % Nernst potential for leak current
gleak_tot = 0.003; % Maximum conductance for leak current
 
%% Setting up initial values for differential equations

V=-75; % Initial Membrane voltage
m=am(V)/(am(V)+bm(V)); % Initial m-value
n=an(V)/(an(V)+bn(V)); % Initial n-value
h=ah(V)/(ah(V)+bh(V)); % Initial h-value
y0=[V;n;m;h]; % Initial vector passed to the function for the ODE

%% Solving the ODE and plotting the results

tspan = [0,max(t)]; % vector of the time span duration

% Solving the ODE for Nobel model WT
[time,V] = ode15s(@Nobel,tspan,y0); 
% Extract the values of V as solved from the ODE for the WT case
V_timecourse_WT=V(:,1);
% Plot the Voltage over time
plot(time, V_timecourse, 'LineWidth', 2)

% Solving the ODE for Brugada mutant
[time,V_Brugada] = ode15s(@Nobel_Brugada,tspan,y0); 
% Extract the values of V as solved from the ODE for the Brugada case
V_timecourse_Brugada=V_Brugada(:,1);
% Plot the Voltage over time
line(time, V_timecourse2, 'Color','r','LineWidth', 2)