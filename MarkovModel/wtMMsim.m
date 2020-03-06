%[t, P] = ode45(@(t,p) MM(t, p, TM_wt(V_inf)), t_span, P_0);

%ptop = P(end, :);

%[t, P1] = ode45(@(t,p) MM(t, p, TM_wt(-80.0)), t_span, ptop);

wt_timecourse = readtable('voltage_WT-2.csv');
times = 1000*table2array(wt_timecourse(1:176, 1));
voltages = table2array(wt_timecourse(1:176, 2));

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
E_Na = 40;
G_Na = 16;

P_Open = P_all(:, 9);

I_Na = Na_Current(G_Na, P_0s(:, 9), voltages(1:end-1), E_Na);

%figure(1)

%i = plot(times(1:end-1), I_Na);
%xlim([0 70])
%legend('Na');
%xlabel('Time / ms');
%ylabel('Current');
%i.LineWidth = 1.5;

%% optimization of mutants. First test the wild-type.

% create the optimization problem.



r = optimvar('r', 2, 'LowerBound', [1e-8, 0.01], 'UpperBound', [1e-5, 10]);

myfcn = fcn2optimexpr(@RtoODE, r, times, voltages);
format long
yvalstrue = P_0s(:,9);
obj = sum(sum((myfcn-yvalstrue).^2));
prob = optimproblem('Objective',obj);

%sol = RtoODE([3.7933e-7, 6.1839], times, voltages);
%sol = RtoODE([1e-7, 6], times, voltages);

r0.r = [3e-7,6]; % initial condition 1
r0.r = [1e-7,5]; % initial condition 2, could try global min or grid search
[rsol, sumsq] = solve(prob,r0)





















