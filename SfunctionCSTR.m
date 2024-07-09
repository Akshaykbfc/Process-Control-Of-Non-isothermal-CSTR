function [sys,x0] = SfunctionCSTR(t,x,u,flag)
%
%  Simulink interface to CSTRfunction.m     
%
% Input arguments :    
%-------------------------------------------------------------------------
% Input arguments : 
%  1)  t    - time variable
%  2)  x    - state variables 
%  3)  u    - input variables will be  set in Simulink and passed to model
%  4) flag  - indicator of a Simulink request which designated by an integer number
%-----------------------------------------------------------------------------
% Output argumets :   
%  1) sys  - the main vector of results requested by Simulink.
%              depending on the flag # it holds different information
%                 when flag=0, sys contains [sizes ] and  initial conditions.
%                 when flag=1, sys contains derivatives
%                 when flag=3, sys contains outputs  
%  2) x0   - initial conditions
%-------------------------------------------------------------------------
%  System outputs 
%         x(1)
%         x(2) 
%         ...
%--------------------------------------------------------------------------
% When flag is 0 
%  Initialization :
%   1) define initial conditions,  x0
%   2) define the system in terms of number of states, inputs etc.
%      e.g. sys = [2, 0, 2, 3, 0, 0];
%
%            1st array,a :  number of continuous states
%            2nd array,b :  number of discrete states
%            3rd array,c :  number of outputs
%            4th array,d :  number of inputs
%            5th array,e :  flag for direct feedthrough
%            6th array,f :  the number of sample times
%-------------------------------------------------------------------------

if abs(flag) == 1
  % Return state derivatives.
  sys =  CSTRmodel(t, x, u);

elseif abs(flag) == 3
  % Return system outputs.
  sys = x;

elseif flag == 0
  % Initialize the system
  load init_xss.mat
  x0= xss ;
  sys = [3,0,3,5,0,0];

else
  sys = [];  
end
  
   
