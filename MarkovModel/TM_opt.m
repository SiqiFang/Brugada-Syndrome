function [TM, probs] = TM_opt(V, r)
% parameters: wild-type; Med Biol Eng Comput (2006) 44: 35?44
    alpha = 0.0378;
    beta = 0.0925;
    epsilon = 0.2492;
    zeta = 0.3326;
    eta = 0.4681;
    theta = 0.1093;
    omega = 0.1949;
    phi = 0.1917;
    kappa = 0.2559;
    lambda = r(1);
    mu = r(2);
    nu = 1.000;
    xi = 0.0159;
    upsilon = 0.0722;
    pi = 0.0022;
    rho = 0.100;
    sigma = 0.0924e-4;
    tau = 0.0854e-7;
    % transition rates: wild-type; Med Biol Eng Comput (2006) 44: 35?4
    a11 = (alpha*exp(-V/17) + beta*exp(-V/150))^-1;
    a12 = (alpha*exp(-V/15) + beta*exp(-V/150))^-1;
    a13 = (alpha*exp(-V/12) + beta*exp(-V/150))^-1;

    b11 = epsilon*exp(-V/20.3);
    b12 = zeta*exp(-V/20.3);
    b13 = eta*exp(-V/20.3);

    a111 = (theta*exp(-V/17) + omega*exp(-V/150))^-1;
    a112 = (theta*exp(-V/15) + omega*exp(-V/150))^-1;

    b111 = phi*exp(-V/23); % note paper typo.
    b112 = kappa*exp(-V/20.3);

    a3 = lambda*exp(-V/mu);
    b3 = nu*(8.4e-3 + V*2.0e-5);

    a2 = (xi*exp(-V/16.5) + upsilon*exp(-V/200))^-1;
    b2 = a13*a2*a3/(b13*b3);

    a4 = pi*a2;
    b4 = rho*a3;

    a5 = sigma*a2;
    b5 = tau*exp(-V/7.7);
    
    % define transition matrix

    dIC3 = [-(a111 + a3), b111, 0, 0, 0, b3, 0, 0, 0];
    dIC2 = [a111, -(b111 + a112 + a3), b112, 0, 0, 0, b3, 0, 0];
    dIF = [0, a112, -(b112 + a4 + b2 + a3), b4, 0, 0, 0, b3, a2];
    dIM1 = [0, 0, a4, -(b4 + a5), b5, 0, 0, 0, 0];
    dIM2 = [0, 0, 0, a5, -b5, 0, 0, 0, 0];
    dC3 = [a3, 0, 0, 0, 0, -(b3 + a11), b11, 0, 0];
    dC2 = [0, a3, 0, 0, 0, a11, -(b11 + a12 + b3), b12, 0];
    dC1 = [0, 0, a3, 0, 0, 0, a12, -(b12 + b3 + a13), b13];
    dO = [0, 0, b2, 0, 0, 0, 0, a13, -(b13 + a2)];

    TM = [dIC3;...
        dIC2;...
        dIF;...
        dIM1;...
        dIM2;...
        dC3;...
        dC2;...
        dC1;...
        dO];
    
    probs = [a11, a12, a13, b11, b12, b13, a111, a112, b111, b112, a3, b3, a2, b2, a4, b4, a5, b5];
end