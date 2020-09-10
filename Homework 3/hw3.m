%% Loading noisy and original signals
% Load x and x_ns signals from .mat file
load('hw3_noisy_signal.mat')
% Sampling period (Hz)
Fs = 1000;
% Sampling interval
Ts=1/Fs;
% Length of the signal
N=length(x);
% Maximum time
Tmax=(N-1)*Ts;
% Time vector
t=0:Ts:Tmax;


% Plot range
plot_range =(N/2-200:N/2+200);
% Plot signal in the range
figure(1)
plot(t(plot_range),x(plot_range),'LineWidth',2.5);
axis tight
hold on
plot(t(plot_range),x_ns(plot_range),'LineWidth',2.5);
xlabel('Time')
ylabel('Signal')
title('Original signal x[n] vs noisy signal x_{ns}[n]')
legend('x[n]','x_{ns}[n]')


%% single-sided frequency spectrum of the signal plus noise
% Compute fft
X=fft(x_ns);
% Take abs and scale it
X2=abs(X/N);
% Pick the first half
X1=X2(1:N/2+1);
% Multiply by 2 (except the DC part), to compenseate
% the removed side from the spectrum.
X1(2:end-1) = 2*X1(2:end-1);

% Frequency range
F = Fs*(0:(N/2))/N;
% Plot single-sided spectrum
figure(2)
plot(F,X1,'LineWidth',2.5)
title('Single-Sided Amplitude Spectrum')
xlabel('f (Hz)');

%% Remove noise usin band-stop FIR filter
% Design and load FIR band stop filter
load FIR_filter
fvtool(FIR_filter)
% Filter the noise out
x_clean_IIR=filter(FIR_filter,x_ns);

% Single sided spectrum of cleaned signal
% Compute fft
X=fft(x_clean_IIR);
% Take abs and scale it
X2=abs(X/N);
% Pick the first half
X1=X2(1:N/2+1);
% Multiply by 2 (except the DC part), to compenseate
% the removed side from the spectrum.
X1(2:end-1) = 2*X1(2:end-1);

% Plot single-sided spectrum
figure(4)
plot(F,X1,'LineWidth',2.5)
title('Single-Sided Amplitude Spectrum')
xlabel('f (Hz)');
figure(5)
plot(t(plot_range),x(plot_range),'LineWidth',2.5);
hold on
plot(t(plot_range),x_clean_IIR(plot_range),'LineWidth',2.5);
axis tight
title('Filtered signal x_{filt}[n] vs original signal x[n]')
xlabel('Time')
ylabel('Signal')
legend('x[n]','x_{filt}[n]')
