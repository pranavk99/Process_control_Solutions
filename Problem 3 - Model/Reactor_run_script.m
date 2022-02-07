% Solve ODE for bio reactor

% Time def
range = [0:300];
IC = [1000, 0.9, 12.5, 30, 3.1, 25, 27];
% Solving the eqns
[tsol, varsol] = ode45(@Bioreactor_modelnew, range, IC);

figure
plot(tsol, varsol(:,6))
title('Temperature of Reactor')
xlabel('Time') 
ylabel('Tr')

figure
plot(tsol, varsol(:,5))
title('Conc of Co2')
xlabel('Time') 
ylabel('Cco2')


figure
plot(tsol, varsol(:,4))
title('Conc. of Substrate')
xlabel('Time') 
ylabel('Cs')

