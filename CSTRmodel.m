function xdot = CSTRmodel(~,x,u)
%CSTR Model
%~~~~~~~~~~


% States / Outputs : 
%~~~~~~~~~~~~~~~~~~~
% Process Concentration (Ca) = x(1)
% Process Temperature (T) = x(2) 
% Cooling medium outlet Temperature (Tj) = x(3)

% Inputs
%~~~~~~~~
F = u(1);                       % Feed flow rate of the process           
Fj = u(2);                      % Cooling medium feed flow rate

% Disturbances - Ca0, T0, Tj0
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Ca0 = u(3);                     % Feed concentration
T0 = u(4);                      % Input temperature of the process
Tj0 = u(5);                     % Cooling medium feed temperature

% Parameters
%~~~~~~~~~~~~
V  = 1.36 ;                     % Reactor volume(m^3) 
Vj = 0.085;                     % Jacket volume(m^3)
alpha  = 7.08*10^(10) ;         % Pre exponential factor from Arrhenius law(h^-1)
E  = 69815 ;                    %  Activation energy(kJ/kmol)
R   = 8.314 ;                   %  Perfect gas constant(kJ/kmolK)
H   = -69815 ;                  %  Enthalpy of reaction(kJ/kmol)
rho  = 800 ;                    %  Density of the inlet and outlet streams(kg/m^3)
rhoj = 1000 ;                   %  Density of cooling water(kg/m^3)
Cp  = 3.13 ;                    %  Heat capacity of inlet and outletstreams (kJ/kgK) 
Cpj = 4.18 ;                    % Heat capacity of cooling water(kJ/kgK)
U = 3065 ;                      %  Overall heat transfer in the jacket(kJ/(hm^2K))
A = 2.322;                      % Heat transfer area(m^2)

ra =alpha*exp(-E/(R*x(2)))*x(1);

% Model Equations 
%~~~~~~~~~~~~~~~~
xdot(1)= ((F/V)*(Ca0-x(1)))-ra;
xdot(2)= ((F/V)*(T0-x(2)))-(H*ra/(rho*Cp))-((U*A*(x(2)-x(3))/(rho*Cp*V)));
xdot(3)= ((Fj/Vj)*(Tj0-x(3)))+(U*A/(rhoj*Cpj*Vj)*(x(2)-x(3)));
xdot=xdot';

