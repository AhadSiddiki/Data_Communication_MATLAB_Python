%%
%AM Modulation
t = 0:0.01: 5;
y1 = cos(pi*t); %message
y2 = sin(10*pi*t); %carrier
m=0.8; % modulation index
ym=(1+m*y1).*y2; %Modulated wave

subplot(3,1,1)
plot(t,y1, 'r')
xlabel('t') 
ylabel('m(t)') 
title('Message')
grid on

subplot(3,1,2)
plot(t,y2, 'r')
xlabel('t') 
ylabel('yc(t)') 
title('Carrier')
grid on

subplot(3,1,3)
plot(t,ym, 'r')
xlabel('t') 
ylabel('ym(t)') 
title('Modulated Wave')
grid on

%%
%Demodulation
z = ym.*y2; %multiply by carrier then filter it
[b,a]=butter(8, 0.1); %Butterworth filter with cut off 0.1 
and order 8
r = filter(b, a, z);
plot(r)
title('Filtered signal');
grid on

%%
%Audio Signal
% AM modulator and demodulator
load mtlb
in=mtlb;
x=in(1:500); %500 samples of speech
Fs=18000; %sampling rate of plot
Fc=8000; %carrier frequency
in_phase = 0;%initial phase angle
y=ammod(x,Fc,Fs,in_phase); 
%AM with double sideband suppressed carrier
subplot(2,2,1)
plot(x, 'k'); %base band signal
title('Base band signal');
grid on
subplot(2,2,2)
plot(y, 'k') % AM signal
title('AM signal');
grid on
z=demod(y,Fc,Fs,'am'); %demodulated signal
subplot(2,2,3)
plot(z, 'k') % demodulated signal
grid on
title('Demodulated signal');
subplot(2,2,4)
[b,a]=butter(8, 0.1); %Butterworth filter with cut off 0.1 and order 8
r=filter(b, a, z);
plot(r)
title('Filtered signal');
grid on

periodogram(y,[],512,Fs);


%%
%FM modulation
fs = 1000; % Sample rate (Hz)
ts = 1/fs; % Sample period (s)
fd = 25; % Frequency deviation (Hz)
t = 0:ts:2;
t=t';
x = sin(2*pi*2*t);
M_s = comm.FMModulator('SampleRate',fs,'FrequencyDeviation',fd);
y = step(M_s, x);
subplot(3,1,1)
plot(t,[x real(y)]) %plot both x and y

% Demodulation
DEMOD = comm.FMDemodulator('SampleRate',fs,'FrequencyDeviation',fd);
z = step(DEMOD,y);
subplot(3,1,2)
plot(t,z,'r')
xlabel('Time (s)')
ylabel('Amplitude')
title('Demodulated signal')
grid on

%psd of FM
subplot(3,1,3)
periodogram(real(y),[],512,fs);
