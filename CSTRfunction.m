function xdot =CSTRfunction(~,x,p)

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Non-isothermal CSTR model equations 
% ---------------------------------
Tj0 = p.Tj0 ;
Ca0 = p.Ca0 ;
T0 = p.T0 ; 
F = p.F ;
Fj = p.Fj;
V = p.V ; 
alpha = p.alpha ; 
E = p.E ; 
R = p.R ; 
H = p.H ; 
rho = p.rho ;
rhoj = p.rhoj;
Cp = p.Cp ;
Cpj = p.Cpj;
U = p.U;
A = p.A ;
Vj = p.Vj ;

ra =alpha*exp(-E/(R*x(2)))*x(1);

xdot(1)= ((F/V)*(Ca0-x(1)))-ra;
xdot(2)= ((F/V)*(T0-x(2)))-(H*ra/(rho*Cp))-((U*A*(x(2)-x(3))/(rho*Cp*V)));
xdot(3)= ((Fj/Vj)*(Tj0-x(3)))+(U*A/(rhoj*Cpj*Vj)*(x(2)-x(3)));
xdot=xdot';
end
