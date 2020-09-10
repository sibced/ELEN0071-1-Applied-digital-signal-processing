%% Q3.a)
% Read audio file .wav
[x,Fs] = audioread('hw1_echo.wav');
sound(x,Fs);

% Compute autocorrelation sequence 
[acorrX,lagX] = xcorr(x(:,1),x(:,1));

% Plot autocorrelation function
figure(1)
plot(lagX,acorrX,'LineWidth',2.5)
xlabel('Lag');
ylabel('Sample Autocorrelation');
title('Autocorrelation function of hw1_echo.wav');

% Dela'y
D = 17640; % Delay expressed in samples
Tau = D/Fs; % Delay expressed in seconds

%% Q3.b
% Data
alpha = 0.7;

% Filter
a=1;
b=[1, zeros(1,D-1), +alpha];

% Read audio file .wav with the filter
sound(filter(a,b,x),Fs)