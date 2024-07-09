% Steady State solution of Non-isothermal CSTR

clear, clc, close all 

p.Tj0 = 294.7 ;         % Inlet stream cooling water Temperature (K)
p.Ca0 = 8 ;             % Reactant concentration inlet stream(kmolA/m^3)
p.T0 = 294.7 ;          % Inlet stream temperature(K)
p.F = 1.13 ;            % Volumetric flow rate of the inlet stream(m^3/h)
p.Fj = 1.4130 ;         % Volumetric flow rate of cooling water(m^3/h)
p.V  = 1.36 ;           % Reactor volume(m^3) 
p.Vj = 0.085;           % Jacket volume(m^3)
p.alpha  = 7.08e10 ;    % Pre exponential factor from Arrhenius law(h^-1)
p.E  = 69815 ;          % Activation energy(kJ/kmol)
p.R   = 8.314 ;         % Perfect gas constant(kJ/kmolK)
p.H   = -69815 ;        % Enthalpy of reaction(kJ/kmol)
p.rho  = 800 ;          % Density of the inlet and outlet streams(kg/m^3)
p.rhoj = 1000 ;         % Density of cooling water(kg/m^3)
p.Cp  = 3.13 ;          % Heat capacity of inlet and outletstreams (kJ/kgK) 
p.Cpj = 4.18 ;          % Heat capacity of cooling water(kJ/kgK)
p.U = 3065 ;            % Overall heat transfer in the jacket(kJ/(hm^2K))
p.A = 2.322;            % Heat transfer area(m^2)

%Initial Conditions for high conversion rate
x0=[0.141155161204843  397.056076103663 350.635397814976 ]; 

% Assuming room temperature for Jacket and Reactor temperature for high conversion (yield) 
% Concentration of A Ca is 1.

tspan=[0 100];          % simulation for 100 seconds
                
options = odeset('RelTol',1e-6,'AbsTol',[1.e-6 1.e-6 1.e-6]);
[t,x]=ode45(@CSTRfunction,tspan,x0,options,p); 


% Steady state solution plot for all three output variables

figure(1)  
yyaxis left
plot(t,x(:,2),"LineWidth",1),grid on
hold on 
plot(t,x(:,3),"--",LineWidth=1),grid on
hold off
ylabel('Reactor Temperature (T), Jacket temperature (Tj) ')
yyaxis right
plot(t,x(:,1),LineWidth=1)
legend('T','Tj','Ca')
xlabel('Time(s)')
ylabel('Concentration of Reactant (Ca)')


%The solution at final time to find steady state values is saved into xss . 

xss= x(end,:) ;

%Calculate the conversion ( yield) :
yield = (p.Ca0 - xss(1,1))/p.Ca0*100;

save init_xss xss
