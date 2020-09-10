close all
% Data 
r = 0.9;
K = 8;
b_0 = 5.3936*10^-7;
b_k = b_0^(1/K);
w_0 = pi/3;
w_0_ = 2*pi/3;

% Zeros
b = b_k;

% Pole
a = [1,-2*r*cos(w_0),r*r];
a_ = [1,-2*r*cos(w_0_),r*r];


% Omega
om=linspace(-pi,pi,500);

% Freq. response
X=freqz(b,a,om);
X_=freqz(b,a_,om);

% Plot
hold on
plot(om/pi + pi/3,10*log10((abs(X).^2))*K,'LineWidth',2.5)
plot(om/pi,10*log10((abs(X_).^2))*K,'LineWidth',2.5)
ylim([-200 50])
xlabel('Normalized frequency (\pi x rad/sample) ')
ylabel('Magnitude |H(exp(jw))| (dB)')
