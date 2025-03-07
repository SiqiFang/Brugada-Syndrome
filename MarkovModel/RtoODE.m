function I_Na = RtoODE(r, timess, voltages)
    V0 = voltages(1);
    E_Na = 40;
    %G_Na = 16;
    G_Na = 267;
    G_Na = 267/2.4;
    TM_V0 = TM_opt(V0, r);
    [EVTM, D] = eig(TM_V0);
    D_vec = diag(D);
    abs_D_vec = abs(D_vec);
    index_zero = find(abs_D_vec==min(abs_D_vec));  % index of the row with the smallest value
    A = eye(9);
    P_0 = A(index_zero, :); % initial value
    rat = [];
    P_0s = [];
    t_span = [0,0.1];
    for i = (2:length(voltages))
        t_span = [timess(i-1), timess(i)]; % not enough input arguments?
        [TM, rates] = TM_opt(voltages(i-1), r);
        [t, P] = ode45(@(t,p) MM(t, p, TM), t_span, P_0);
        P_0 = P(end, :);
        rat = [rat;...
            rates];
        P_0s = [P_0s; P_0];
    end
    solpts = P_0s(:, 9);
    I_Na = Na_Current(G_Na, solpts, voltages(1:end-1), E_Na);
end
        
        

% ith row of matrix EVTM * iEVTM?