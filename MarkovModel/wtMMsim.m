%[t, P] = ode45(@(t,p) MM(t, p, TM_wt(V_inf)), t_span, P_0);

%ptop = P(end, :);

%[t, P1] = ode45(@(t,p) MM(t, p, TM_wt(-80.0)), t_span, ptop);

wt_timecourse = readtable('voltage_WT-2.csv');
times = 1000*table2array(wt_timecourse(1:176, 1));

voltages = table2array(wt_timecourse(1:176, 2));

data = readtable('INa_WT.csv');
times = 1000*table2array(data(1:176, 1));
current = table2array(data(1:176, 2))./1000;
voltages = table2array(data(1:176, 3));

V0 = voltages(1);
TM_V0 = TM_wt(V0);
% initial conditions: derived from patch-clamp assumption. 
[EVTM, D] = eig(TM_V0);
iEVTM = inv(EVTM);
D_vec = diag(D);
index_zero = find(D_vec==min(abs(D_vec)));
A = eye(9);
P_0 = A(index_zero, :);
P_all = [];
tim = [];
rat = [];
P_0s = [];

for i = (2:length(voltages))
    t_span = [times(i-1), times(i)];
    [TM, rates] = TM_wt(voltages(i-1));
    [t, P] = ode45(@(t,p) MM(t, p, TM), t_span, P_0);
    P_0 = P(end, :);
    P_all = [P_all;...
        P];
    tim = [tim, t.'];
    rat = [rat;...
        rates];
    P_0s = [P_0s; P_0];
end


%figure(1)

%r = plot(times(1:end-1), rat(:,15), times(1:end-1), rat(:,16));
%legend({'a4', 'b4'});
%xlabel('Time / ms');
%ylabel('transition probability');
%r(1).LineWidth = 3;
%r(2).LineWidth = 3;

%p = plot(tim, P_all(:, :));
%legend({'IC3', 'IC2', 'IF', 'IM1', 'IM2', 'C3', 'C2', 'C1', 'O'});
%xlabel('Time / ms');
%ylabel('Proportion of channels');
%p(9).LineWidth = 2;


%% simulating wild-type sodium current.
% P_0 obtained through TM_wt
E_Na = 40;
%G_Na = 16;
G_Na = 267;
G_Na = 267/2.4;

%P_Open = P_all(:, 9);
I_Na = Na_Current(G_Na, P_0s(:, 9), voltages(1:end-1), E_Na);



%% optimization of mutants. First test the wild-type.

% create the optimization problem.



r = optimvar('r', 2, 'LowerBound', [1e-8, 0.01], 'UpperBound', [1e-5, 10]);

%myfcn = fcn2optimexpr(@RtoODE, r,times, voltages, 'OutputSize',[175 1])
myfcn = fcn2optimexpr(@RtoODE, r,times, voltages)


%yvalstrue = P_0s(:,9);
%%%%% Optimise against experimental data
%obj = sum(sum((myfcn - current(1:end-1)).^2)); 
%%%%% Optimise against model parameter data
obj = sum(sum((myfcn - I_Na).^2)); 
prob = optimproblem("Objective",obj);

r0.r = [2e-7, 8];
[rsol,sumsq] = solve(prob,r0)
r1 = rsol.r(1)
r2 = rsol.r(2)

sol = RtoODE([r1, r2], times, voltages);

%sol = RtoODE([3.7933e-7, 6.1839], times, voltages);


figure(1)
subplot(4,1,1)
plot(times(1:end-1), I_Na,times(1:end-1), sol,times(1:end-1), current(1:end-1), 'linewidth',2);
xlim([0 150])
legend('model','simulation','experimental');
xlabel('Time / ms');
ylabel('Current');
%i.LineWidth = 1.5;
subplot(4,1,2)
plot(times(1:end-1), current(1:end-1),times(1:end-1),voltages(1:end-1), 'linewidth',1.5);
xlim([0 150])
legend('current','voltage');
xlabel('Time / ms');
ylabel('Value');
subplot(4,1,3)
plot(times(1:end-1), current(1:end-1)-sol,'linewidth',1.5);
yline(0,'color','red','linewidth',1.5);
xlim([0 150])
legend('model error','reference');
xlabel('Time / ms');
ylabel('Experimental-Simulation Error');
subplot(4,1,4)
plot(times(1:end-1), I_Na-current(1:end-1),'linewidth',1.5);
yline(0,'color','red','linewidth',1.5);
xlim([0 150])
legend('error','reference');
xlabel('Time / ms');
ylabel('Experimental-Model Error');














