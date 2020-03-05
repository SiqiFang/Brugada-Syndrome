function dVdt = fhn(t,V)
   dVdt = zeros(2,1)
   I = 0.33;
   dVdt=[I+V(1)-V(1)^3/3-V(2); 
        0.08*(V(1)+0.7-0.8*V(2))];
    
end