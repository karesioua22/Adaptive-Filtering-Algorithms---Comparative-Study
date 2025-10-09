clear;
close all;
N = 2000;
% Define the rank of the filter
p = 4;
num_signals = 100; 
% Load data from files
x_mat = load('x.mat'); 
d_mat = load('d.mat'); 
x_all = x_mat.x;
d_all = d_mat.d;

w=zeros(p,num_signals);

w1=zeros(p,num_signals);

w2=zeros(p,num_signals);

for k=1:num_signals

[ w(:,k), SNR ] = wiener_hopf( x_all(k,:),d_all(k,:),p);

end
for k=1:num_signals

[ w1(:,k), SNR ] = wiener_hopf( x_all(k,1:1000),d_all(k,1:1000),p);

end

for k=1:num_signals

[ w2(:,k), SNR ] = wiener_hopf( x_all(k,1001:2000),d_all(k,1001:2000),p);

end