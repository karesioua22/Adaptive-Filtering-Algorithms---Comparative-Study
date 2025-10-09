clear;
close all;
N = 2000;
% Define the impulse response vector
h = [51.0, -41.6, -30.73, 200.15];
% Define the rank of the filter
num_signals = 100; % Number of signals to generate
for i = 1:num_signals
    x_all(i, :) = randn(N, 1);
    d_all(i, :) = conv(x_all(i, :), h);
end




p=4;
ws=5;


R_x=eye(p);
[~,l]=eig(R_x);
l_max=trace(l);
m_max=2/l_max;
m=0.01*m_max;
inst_e_wlms_all=zeros(num_signals,1,N-ws+1);
weights_all=zeros(num_signals,p,N-ws+1);

for k=1:num_signals

inst_e_wlms=zeros(1,N-ws+1);
weights=zeros(p,N-ws+1);
e=zeros(p,ws);
x2=zeros(p,ws);
w=zeros(p,1);

x=x_all(k,:);
d=d_all(k,:);
   for i=p:N-ws+1

	for j=1:p
		x2(j,:)=x(i-j+1:i+ws-j);
	end
   y=x2.'*w(:,1);
   e(i:i+ws-1,1)=d(1,i:i+ws-1).'-y;
   w(:,1)=w(:,1)+m*x2*e(i:i+ws-1,1);
   inst_e_wlms(1,i)=e(i,1)^2;
   weights(:,i)=w(:,1)';

   end
inst_e_wlms_all(k,:,:)=inst_e_wlms(:,:);
weights_all(k,:,:)=weights(:,:);


end
 a=  reshape(weights_all(1,:,:), [4,1996]);