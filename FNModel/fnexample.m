tspan=[0:0.01:20];
v0 = -1; 
w0 = 1;
y0=[v0;w0]; % Initials conditions
a = 0.0682859;
%a = -2
b = 0.5;
c = 3;
    
[t,y]=ode45(@fn,tspan,y0);

% Plot u and v vs. t
V = y(:,1);
W = y(:,2);
figure(1)
plot(t,V)
title('Solution of FitzHugh-Nagumo Equations for a Single Cell');
xlabel('Time t');
ylabel('Solution V');
legend('V');
    
vspan = [-2.5:0.01:2.5]
w = (a - vspan)/b;
v = -vspan + vspan.^3./3;
figure(2)
plot(vspan,v,vspan,w,V,W)
%hold on;
%plot(u,v)
legend('V nullcline','W nullcline','V-W curve');

