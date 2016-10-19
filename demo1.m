%% demo1: Enhanced Low-Rank Matrix Approximation (ELMA)
%
% Reference: Enhanced Low-Rank Matrix Approximation
% A. Parekh and I. W. Selesnick
% IEEE Signal Processing Letters, 2016.
%
% Last Edit: 2/21/2016
% Ankit Parekh, NYU Tandon
% ankit.parekh@nyu.edu

%% Function definitions

% Initialize        
clear

% soft-threshold function
soft = @(x,lam) max(1 - lam./abs(x), 0) .* x;                               

% firm-threshold function
firm = @(x,lam,a) min(abs(x), max((abs(x)-lam)./(1-a.*lam),0)).* sign(x);   

%% Generate random matrix
% Matrix M = A*B has rank 'r' and is of size 'm by n'.
% A is of size 'm by r' and B is of size 'r by n'.
                                 
m = 200;                        
n = 100;
r = 10;
sigma = 6;                                        % Noise level sigma
A = randn(m, r);
B = randn(r, n);
M = A * B;
Y = M + sigma * randn(m, n);                      % Add AWGN to the clean matrix M

%% Estimate the Low-Rank Matrix using ELMA and NNM

[U,S,V] = svd(Y);                                 % SVD of the input matrix Y

% Enhanced low-rank matrix approximation (ELMA) method
ELMA.lam = 22.7*sigma;                            % Parameters for ELMA method
ELMA.a = 0.6/ELMA.lam;        
ELMA.S = firm(S, ELMA.lam, ELMA.a);               % ELMA Approximated singular value matrix
ELMA.X = U * ELMA.S * V';                         % ELMA Low-Rank Approximation

% Nuclear norm minimization (NNM) method
NNM.lam = 22*sigma;                               % NNM parameters
NNM.S = soft(S, NNM.lam);                         % NNM Approximated singular value matrix
NNM.X = U * NNM.S * V';                           % NNM Low-Rank Approximation

%% Plot the singular values of the approximated matrices

figure(1), clf
plot(1:n, diag(S),'.-r',...                       % Noisy singular values
     1:n, svd(M),'.-b',...                        % Original singular values
     1:n, diag(ELMA.S),'.-k',...                  % ELMA approximated singular values
     1:n, diag(NNM.S),'.-m')                      % NNM approximated singular values
xlabel('n')
ylabel('n-th singular value')
legend('Noisy singular values','True singular values',...
       'ELMA','Nuclear norm minimization (NNM)')
   
print -dpdf demo1

