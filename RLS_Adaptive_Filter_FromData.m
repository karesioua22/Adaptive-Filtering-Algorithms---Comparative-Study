clear;
close all;

% Load data from files
x_mat = load('x.mat'); 
d_mat = load('d.mat'); 
x_all = x_mat.x;
d_all = d_mat.d;

p = 4;
N = 2000;
num_signals = 100; 
weights_all = zeros(100, N +1, p);
MSE_all = zeros(100, N +1);
output_signal_all = zeros(100, N, p);
lambda = 0.9;  % Forgetting factor
inverse_lambda = 1 / lambda;
M =p; 

for j = 1:num_signals
% Initialize variables
weights = zeros(N+1, p);% Filter coefficients
mse=zeros(1,N+1);
P = eye(M) / lambda; % Initial inverse correlation matrix
input_signal = x_all(j, :);
    desired_output_signal = d_all(j, 1:2000);

for n = M:N-1
    % Kalman gain
    u = input_signal(n:-1:n-M+1);
    k = (P * u.') / (lambda + u * P * u.');
    a=weights(n, :);
    % Prediction
    y = a * u.';


    % Error
    e = desired_output_signal(n) - y;

    % Update filter coefficients
    weights(n+1,:) = weights(n,:) + k.' * e;

    % Update inverse correlation matrix
    P = inverse_lambda * P - inverse_lambda * k * u * P;

    % Calculate MSE
    mse(1,n) = e^2;
end
weights_all(j, :, :) = weights;
MSE_all(j,:) = mse;

end

% Plot weights changes with respect to iterations
figure;
for k = 1:p
    subplot(p, 1, k);
    plot(1:N+1, weights(:, k));
    xlabel('Iteration');
    ylabel(['Weight ' num2str(k)]);
    title(['Weight ' num2str(k) ' changes over iterations']);
end
epochs = 1:N + 1; % Replace this with your actual epoch values
% Replace this with your actual e_squared values

% Plotting the learning curve
figure;
plot(epochs,mean(MSE_all), 'o-', 'LineWidth', 2, 'MarkerSize', 8);
xlabel('Epochs or Iterations');
ylabel('Squared Error');
title('Learning Curve for Squared Error');
grid on;