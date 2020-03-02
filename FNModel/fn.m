function dVdt = fn(t,V)
    a = 0.0682859; % example with oscillation
    % a = -2; % example with no oscillation
    b = 0.5;
    c = 3;
    dVdt = zeros(2,1)
    dVdt=[c*(V(1)-V(1)^3/3+V(2)); 
        -(V(1)-a+b*V(2))/c];
    
end