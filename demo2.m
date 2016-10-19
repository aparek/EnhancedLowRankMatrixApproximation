%% demo2: Penalty function and threshold function plots
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

% firm-threshold function
firm = @(x,lam,a) min(abs(x), max((abs(x)-lam)./(1-a.*lam),0)).* sign(x);   

% partly quadratic penalty function
phi = @(x,a) zeros(size(x)) + ...                                            
             (abs(x) < (1/a)).* (abs(x) - (a/2)*x.^2) + ...
             (abs(x) >= (1/a)) .* (1/(2*a));

%% Plot the penalty function

x = linspace(-4, 4, 201);
lam = 1;
a = 0.6/lam;

figure(1), clf
subplot(2, 1, 1)
plot(x, abs(x), x, phi(x, a))
legend('Absolute value', 'Partly quadratic penalty') 
daspect([1 1 1])
xlabel('x')
ylabel('phi(x;a)')

% Plot the threshold function
subplot(2, 1, 2)
plot(x, x, '--', x, firm(x, lam, a))
legend('Identity', 'Firm threshold')
xlabel('y')
ylabel('\theta(y; \lambda, a)')
daspect([1 1 1])

orient tall
print -dpdf demo2
