clear;
close all;
N = 2000;
% Define the impulse response vector
h = [51.0, -41.6, -30.73, 200.15];
% Define the rank of the filter
p = 4;
num_signals = 100; % Number of signals to generate
x_all = zeros(num_signals, N);
d_all = zeros(num_signals, N + p - 1);
for i = 1:num_signals
    x_all(i, :) = randn(N, 1);
    d_all(i, :) = conv(x_all(i, :), h);
end
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