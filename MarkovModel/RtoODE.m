function solpts = RtoODE(r, times, voltages)
    V0 = voltages(1);
    TM_V0 = TM_opt(V0, r);
    [EVTM, D] = eig(TM_V0);
    iEVTM = inv(EVTM);
    D_vec = diag(D);
    abs_D_vec = abs(D_vec);
    index_zero = find(abs_D_vec==min(abs_D_vec));
    A = eye(9);
    P_0 = A(index_zero, :);
    rat = [];
    P_0s = [];
    for i = (2:length(voltages))
        t_span = [times(i-1), times(i)];
        [TM, rates] = TM_opt(voltages(i-1), r);
        [t, P] = ode45(@(t,p) MM(t, p, TM), t_span, P_0);
        P_0 = P(end, :);
        rat = [rat;...
            rates];
        P_0s = [P_0s; P_0];
    end
    solpts = P_0s(:, 9);
end
        
        