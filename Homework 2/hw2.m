% Load ecg signal from .mat file
load('hw2_electrocardiogram.mat','ecg')
%a)
% Sampling frequency (in Hz)
Fs = 250;
% Sampling period (in second)
Ts = 1/Fs;
% Signal length
N = length(ecg);
% Ending time
Tmax = (N-1)*Ts;
% Time vector
t=0:Ts:Tmax;

figure
plot(t,ecg)
xlabel('Time (s)')
ylabel('Amplitude')
title('ECG + noise')

%b)
figure
plot(t,ecg)
xlim([2 5])
xlabel('Time (s)')
ylabel('Amplitude')
title('ECG + noise')

%c)
% Compute fft
ECG=fft(ecg);
% Take abs and scale it
ECG2=abs(ECG/N);
% Pick the first half
ECG1=ECG2(1:N/2+1);
% Multiply by 2 (except the DC part), to compenseate
% the removed side from the spectrum.
ECG1(2:end-1) = 2*ECG1(2:end-1);
% Frequency range
F = Fs*(0:(N/2))/N;
% Plot single-sided spectrum
figure
plot(F,ECG1,'LineWidth',2.5)
title('Single-Sided Amplitude Spectrum')
xlabel('f (Hz)');

%e)
% load the first filter object
load noche60;
% removing the 60Hz-frequency noise
almost_pure_ecg = filter(noche60, ecg);

% load the second filter object
load noche120;
% removing the 120Hz-frequency noise
pure_ecg = filter(noche120, almost_pure_ecg);

figure
plot(t,pure_ecg,'LineWidth',2); title('without noise')
xlabel('time (s)')
ylabel('amplitude')
% Zoom in
figure
plot(t(500:length(t)/6),ecg(500:length(t)/6),'LineWidth',2.5); title('Noisy and without noise')
xlim([2 5])
xlabel('time')
ylabel('amplitude')
hold on
plot(t(500:length(t)/6),pure_ecg(500:length(t)/6),'LineWidth',2.5)