%% Nobel Model Differential Equation Solver
%% Constants set for model set up
format long
%Cm=12.0; % Membrane Capacitance
dt=0.0025; % Time Step 
t=0:dt:2.5; %Time Duration of the entire Simulation

% These constants aren't used directly in the following script but are used
% instead in the function establishment of the ODE (put here for reference)

ENa = 40; % Nernst potential for Na
%EK = -100; % Nernst potential for K
%Eanionic = -60; % Nernst potential for anionic
%Eleak = -49.42; % Nernst potential for leak current
%gleak_tot = 0.003; % Maximum conductance for leak current
 
%% Setting up initial values for differential equations

V=-75; % Initial Membrane voltage
m=am(V)/(am(V)+bmm(V)); % Initial m-value
n=an(V)/(an(V)+bn(V)); % Initial n-value
h=ah(V)/(ah(V)+bh(V)); % Initial h-value
y0=[V;n;m;h]; % Initial vector passed to the function for the ODE

%% Solving the ODE and plotting the results

tspan = [0,max(t)]; % vector of the time span duration

% Solving the ODE for Nobel model WT
[time1,V] = ode15s(@Nobel,tspan,y0); 
% Extract the values of V as solved from the ODE for the WT case
V_WT = V(:,1);
m_WT = V(:,3);
h_WT = V(:,4);
INa = (400000.*m_WT.^3.*h_WT + 132).*(V_WT-ENa)./1000;
GM = INa./V_WT
%voltage_WT = [time1, V_timecourse_WT];
%dlmwrite('voltage_WT.csv',voltage_WT,'delimiter', ',', 'precision', 15) 
% Plot the Voltage over time
%plot(time1, V_timecourse_WT, 'LineWidth', 2)

% Solving the ODE for Brugada mutant
[time,V_Brugada] = ode15s(@Nobel_Brugada,tspan,y0); 
% Extract the values of V as solved from the ODE for the Brugada case
V_B = V_Brugada(:,1);
m_B = V_Brugada(:,3);
h_B = V_Brugada(:,4);
%INa_B = (362500.*m_B.^3.*h_B + 132).*(V_B-ENa);
INa_B = (350000.*m_B.^3.*h_B + 132).*(V_B-ENa)./1000;
%INa_B = (400000.*(0.995*m_B).^3.*h_B + 132).*(V_B-ENa);
% Plot the Voltage over time
%line(time, V_timecourse_Brugada, 'Color','r','LineWidth', 2)
INa_WT = [time1, INa./1000, V_WT];
INa_E_B = [time, INa_B, V_B];
INa_T_B = [time, INa_B, V_B];
INa_W_B = [time, INa_B, V_B];
%dlmwrite('INa_WT.csv',INa_WT,'delimiter', ',', 'precision', 15)
dlmwrite('INa_E_B.csv',INa_E_B,'delimiter', ',', 'precision', 15)
%dlmwrite('INa_T_B.csv',INa_T_B,'delimiter', ',', 'precision', 15)
%dlmwrite('INa_W_B.csv',INa_W_B,'delimiter', ',', 'precision', 15)


%ration_E = INa_B./INa;
figure(1)
subplot(2,1,1)
plot(time1, V_WT, time, V_B,'LineWidth', 2)
xlim([0 0.5])
legend('Wildtype','Mutant')
xlabel('time')
ylabel(['Voltage'])
title('Voltage')
grid
subplot(2,1,2)
plot(time1, INa, time, INa_B,'LineWidth', 2)
xlim([0 0.5])
legend('Wildtype','Mutant')
xlabel('time')
ylabel('Current')
title('Sodium Current')
grid




