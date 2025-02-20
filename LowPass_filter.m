function Bout=LowPass_filter(Bin,fg,fs)

%%%% Law-pass filter function
% Bin - input signal 
% Bout - output signal 
% fg - cut-off frequency
% fs- sampling frequency
Bin = [flip(Bin(1:fs, :), 1); Bin; flip(Bin(end-fs+1:end, :), 1)];

fg_norm=fg*2/fs;
[blp,alp]=butter(11, fg_norm);% butterworth low-pass filter 11 order
%  blp=fir1(order,fg_norm); %% fir low-pass filter %ovaj deo se moze odcekirati ako se koristi FIR filter
%  alp=1;
Bout(:,1)=Bin(:,1);       
   for j=2:size(Bin,2)
       y= Bin(:,j);
       yf=filtfilt(blp,alp,y); % double filtering function (direct and inverse signal filtering) !!!!
       Bout(:,j)=yf;
   end
   
Bout=Bout(fs+1:end-fs, :);

end