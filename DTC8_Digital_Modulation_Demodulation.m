%%
%FSK modulation
M=2; %2-ary system
N =2000; %number of binary bit
x=randi([0,M-1], N,1);
tone = 8; %frequency separation between f1 and f2
Fs=100; %sampling frequency
y = fskmod(x, M, tone, N, Fs); % y is the modulated signal
z = fskdemod(y, M, tone, N, Fs); %demodulated data
s=symerr(x, z)

%%
%FSK modulation and transmission through noisy channel
M =2; %2-ary system
N =2000; %number of binary bit
x = randi([0,M-1], N,1);
tone = 8; %frequency separation between f1 and f2
Fs = 100; %sampling frequency
y = fskmod(x, M, tone, N, Fs); %modulated wave
yr = awgn(y, -30); %-30 dB SNR
z = fskdemod(yr, M, tone, N, Fs); %demodulated data
s = symerr(x, z)

%%
%Plot SNR vs. BER.
M =2; %2-ary system
N =2000; %number of binary bit
x = randi([0,M-1], N,1);
tone = 8; %frequency separation between f1 and f2
Fs = 100; %sampling frequency
y = fskmod(x, M, tone, N, Fs); %Complex envelope of modulated wave
for i=1:20,
yr = awgn(y, -40+i); % -40+i dB SNR
z= fskdemod(yr, M, tone, N, Fs); %demodulated data
s(i) = symerr(x, z)/N;
SNR(i) = -40+i; %-40 to -20 dB
end
plot(SNR, s, 'r>:')
xlabel('SNR in dB')
ylabel('BER')
grid on


%%
%Binary Phase Shift Keying BPSK
M=2; %2-ary system
x=randi([0, M-1], 2000, 1);
Fs=100; %sampling frequency
N=2000; %number of binary bit
y=pskmod(x, M); %modulated wave
z=pskdemod(y, M); %demodulated data
s=symerr(x, z)

M=2; %2-ary system
N=2000; %number of binary bit
x = randi([0, M-1], N, 1);
Fs=100; %sampling frequency
y = pskmod(x, M); %modulated wave
yr = awgn(y, -6); %-6 dB SNR
z = pskdemod(yr, M); %demodulated data
s = symerr(x, z)

%%
%8-ary PSK
M = 8; % Alphabet size
x = randi([0 M-1],5000,1); % Random symbols
hMod = pskmod(x, M);
scatterPlot = scatterplot(hMod);
ynoisy = awgn(hMod,15,'measured');
scatterPlot = scatterplot(ynoisy);
s=symerr(x, pskdemod(ynoisy,M))

%%
%Constellation of 16-QAM
M = 16; % Alphabet size
x = randi([0 M-1],5000,1); % Random symbols
% Use 16-QAM modulation.
hMod = qammod(x,M);
hDmod=qamdemod(hMod,M);
scatterPlot = scatterplot(hMod);
ynoisy = awgn(hMod,15,'measured');
scatterPlot = scatterplot(ynoisy);

s=symerr(x, qamdemod(ynoisy,M))