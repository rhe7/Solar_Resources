% This function applies the dual simplex method to the LP
%
%          minimize c^Tx
%          s.t. Ax >= b, x >=0, 
%
% or equivalently,
%
%          minimize c^Tx
%          s.t. Ax - Ix_s= b, x >=0, x_s >= 0
%
%
% given an initial basis.  The initial basis may include surplus variables.
%
% INPUTS:  A         - the constraint matrix A 
%          b         - the righthand side of general inequality constriants
%          c         - the vector of coefficients in the objective
%          basis_i   - the initial choice of indices for the basic variables
%                      may include surplus variables, and should be a row
%                      vector
%
% OUTPUTS: x_star    - the optimal solution for the LP
%          obj_value - the obj. value at the optimal solution of the LP
%          basis_f   - the indices of the basic variables at the LP optimal
%                      solution
%
function [x_star, opt_value, basis_f] = HeRaymondDSA(c,A,b,basis_i)

% Error checking
if length(c) > size(c,1)
    error('User Error: c should be a column vector.');
elseif length(c) ~= size(A,2)
    error('User Error: Dimension mismatch between c and A.');
elseif length(b) > size(b,1)
    error('User Error: b should be a column vector.\n');
elseif length(b) ~= size(A,1)
    error('User Error: Dimension mismatch between b and A.');
elseif length(basis_i) > size(basis_i,2)
    error('User Error: basis_i should be a row vector.');
end    

% Get size of A
[m,n] = size(A);

% Set up A and c for standard form minimization LP
A     = [A,-eye(m)];
c     = [c;zeros(m,1)];

% Basic and nonbasic indicies
I = basis_i;
J = setdiff(1:m+n,I);

% Basic and nonbasic matrices
B = A(:,I);
N = A(:,J);

% Order of variables at the top of the tableau
v_ord = [I,J];

% For constructing tableau
Y     = B\N;
b_bar = B\b;

% Set up the initial tableau.
T = [eye(m+1),[c(I)'*Y-c(J)',c(I)'*b_bar;Y,b_bar]];

while 1
    
   % Optimal solution reached; terminate algorithm. 
   if all(T(2:m+1,n+m+2) >= 1e-12)
       x_star    = zeros(n+m,1);
       x_star(I) = T(2:m+1,m+n+2);
       x_star    = x_star(1:n,1);
       opt_value = T(1,m+n+2);
       basis_f = I;
       break;
   end
   
   % Select pivot row.
   [rcc,k]=min(T(2:m+1,n+m+2));
   
   % Get pivot col
   indices = find(T(k+1,2:n+m+1) <-1e-12);
   [test,col]   = min( T(1,indices+1)./ T(k+1,indices+1) ); 
   if test < 1e-12
       error('LP is infeasible. Algorithm Terminating.');
   end
   
   r       = k;
   dud=indices(col)+1;
   
   % Update tableau
   T([1:r,r+2:m+1],:) = T([1:r,r+2:m+1],:)-(T([1:r,r+2:m+1],dud)/T(r+1,dud))*T(r+1,:);  
   T(r+1,:) = T(r+1,:)/T(r+1,dud)
   
   % Update basic indices
     I(k) = v_ord(indices(col))
end

end %function HeRaymondDSA

% A = [1,1.5,1.2;2,1.5,0;0,1.5,1.1];
% b = [100;50;50];
% c = [2.2;4;3.3];
% basis_i = 4:6;
% [x_star, opt_value, basis_f] = HeRaymondDSA(c,A,b,basis_i)