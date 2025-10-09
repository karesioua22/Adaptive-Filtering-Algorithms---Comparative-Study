function [ w, SNR ] = wiener_hopf( x,d,N)
x=x(:);
[lengthRecord,~]=size(x);
maxlag=N-1;
Rxx=xcorr(detrend(x),maxlag);    % from -maxlag to maxlag
Rxd=xcorr(detrend(x),detrend(d),maxlag);
R=zeros(N);
for i=1:N
    shift=i-1;
    R(:,i)=Rxx(maxlag+1-shift:maxlag+N-shift);
end
Rxd=flipud(Rxd(1:maxlag+1));
w=R\Rxd;
yEstimate=conv(w,x);
yEstimate=yEstimate(1:lengthRecord);
modelError=d-yEstimate; 
SNR=10*log10(var(d(N+1:end))/var(modelError(N+1:end)));    % dB
end
