%% Nobel Model Differential Equation Solver
%% Constants set for model set up
format long
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
m=am(V)/(am(V)+bmm(V)); % Initial m-value
n=an(V)/(an(V)+bn(V)); % Initial n-value
h=ah(V)/(ah(V)+bh(V)); % Initial h-value
y0=[V;n;m;h]; % Initial vector passed to the function for the ODE

%% Solving the ODE and plotting the results

tspan = [0,max(t)]; % vector of the time span duration

% Solving the ODE for Nobel model WT
%[time1,V] = ode15s(@Nobel,tspan,y0); 
% Extract the values of V as solved from the ODE for the WT case
%V_timecourse_WT=V(:,1);
%voltage_WT = [time1, V_timecourse_WT]
%dlmwrite('voltage_WT.csv',voltage_WT,'delimiter', ',', 'precision', 15) 
% Plot the Voltage over time
%plot(time1, V_timecourse_WT, 'LineWidth', 2)



%% plot the gradient
h=0.01;
[t,V] = ode15s(@Nobel,tspan,y0); 
V_timecourse_WT=V(:,1);
dV = gradient(V_timecourse_WT, mean(diff(t)));
dV1_i = dV(1:180);
max(dV1_i)

[t2,V_Brugada] = ode15s(@Nobel_Brugada,tspan,y0); 
V_timecourse_Brugada=V_Brugada(:,1);
dV2 = gradient(V_timecourse_Brugada, mean(diff(t2)));
dV2_i = dV2(1:180);
max(dV2_i)



figure(1)
subplot(2,1,1)
plot(t, V_timecourse_WT,t2,V_timecourse_Brugada)
title('Solution')
grid
subplot(2,1,2)
plot(t, dV,t2,dV2)
title('Derivatives')
grid

