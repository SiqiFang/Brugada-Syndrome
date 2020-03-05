tspan=[0:0.01:100];
v0 = 0.2; 
w0 = 0.1;
y0=[v0;w0]; % Initials conditions
a = 0.15;
e = 0.002;
c = 2.5;
I = 1;
    
[t,y]=ode45(@fhn,tspan,y0);

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
w = (vspan+0.7)/0.8;
v = I-vspan.^3./3+vspan
figure(2)
plot(vspan,v,vspan,w,V,W)
%hold on;
%plot(u,v)
legend('V nullcline','W nullcline','V-W curve');

