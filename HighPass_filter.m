function Bout = HighPass_filter(Bin,fg,fs)

%%%% High-pass filter function
% Bin - input signal 
% Bout - output signal 
% fg - cut-off frequency
% fs- sampling frequency
Bin = [flip(Bin(1:fs, :), 1); Bin; flip(Bin(end-fs+1:end, :), 1)];
[N,M]=size(Bin);% N - number of samples , (M-1) - number of  ECG leads
t=Bin(1:N,1);

DataProc=Bin(:,2:M);


Theta = 2*pi*fg/fs;
P=(1-sin(Theta))/cos(Theta);

G = (1+P)/2;

BHP = [G -G];
AHP = [1 -P];


% fg_norm=fg*2/fs;
% BHP=fir1(681,fg_norm,'high');
% AHP=1;

DataProc = filtfilt(BHP, AHP, DataProc);% double filtering function (direct and inverse signal filtering) !!!!

Bout=[t DataProc];
Bout = Bout(fs+1:end-fs, :);
end