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
e_square = zeros(100,  N - p + 1);
weights_all = zeros(100, N - p + 2, p);
MSE_all = zeros(100,1);
output_signal_all = zeros(100, N);

for j = 1:num_signals
    autocorr_vector = xcorr(x_all(j, :), 'biased');
    Rxx = toeplitz(autocorr_vector(N:end));
    eigens = eigs(Rxx);
    eigen = max(eigens);
    % Learning rate
    mu = 0.05; 
    %* (2 / eigen);
    input_signal = x_all(j, :);
    desired_output_signal = d_all(j, 1:2000);
    weights = zeros(N - p + 2, p);
    MSE = zeros(1, N - p + 1);
    output_signal = zeros(N,1);

    for i = 1:N - p + 1
        input_samples = input_signal(p + i - 1:-1:i);
        output_signal(i) = input_samples * weights(i, :)';

        % Desired output for this sample
        
        e=desired_output_signal(i + p - 1)-output_signal(i);
        % Update weights
        weights(i + 1, :) = weights(i, :) + mu * (e) * input_samples;

        % Calculate MSE for this sample
        e_square(j,i)=e^2;
    end

    weights_all(j, :, :) = weights;
    MSE_all(j) = mean(e_square(j,:));
    output_signal_all(j, :) = output_signal;
end

% Calculate overall MSE across all iterations
total_mse = mean(MSE_all, 1);

% Plot weights changes with respect to iterations
figure;
for k = 1:p
    subplot(p, 1, k);
    plot(1:N - p + 2, weights(:, k));
    xlabel('Iteration');
    ylabel(['Weight ' num2str(k)]);
    title(['Weight ' num2str(k) ' changes over iterations']);
end
epochs = 1:N - p + 1; % Replace this with your actual epoch values
% Replace this with your actual e_squared values

% Plotting the learning curve
figure;
plot(epochs,mean( e_square), 'o-', 'LineWidth', 2, 'MarkerSize', 8);
xlabel('Epochs or Iterations');
ylabel('Squared Error');
title('Learning Curve for Squared Error');
grid on;
