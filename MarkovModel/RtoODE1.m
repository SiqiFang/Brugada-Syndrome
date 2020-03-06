function solpts = RtoODE1(r, tspan, voltages)
    format long
    V0 = voltages(1);
    TM_V0 = TM_opt(V0, r);
    [EVTM, D] = eig(TM_V0);
    D_vec = diag(D);
    index_zero = find(D_vec==min(abs(D_vec)));  % index of the row with the smallest value
    A = eye(9);
    P_0 = A(index_zero, :); % initial value
    P_0 = [ 0     0     0     0     0     0     0     1     0];
    [TM, rates] = TM_opt(V0, r);
    [t, P] = ode45(@(t,p) MM(t, p, TM), tspan, P_0);
    solpts = P(:, 9);
end
        
        

% ith row of matrix EVTM * iEVTM?