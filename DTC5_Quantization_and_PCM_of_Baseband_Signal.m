%%
%Quantization and PCM of Baseband Signal
%Sinusoidal Wave 4sin(pie*t)
t=0:0.1:2*pi;
S=4*sin(pi*t); % sampled signal
quantization = [ -3.25, -2.5, -1.5, -0.5, 0.5, 1.5, 2.5, 3.25 ];
partition = [-3, -2, -1, 0, 1, 2, 3];
[I, Q] = quantiz(S, partition, quantization);
% Q gives the quantized value
stem(t ,S, 'b')
hold on
stem(t, Q, 'r*')
legend('Baseband','Sampled Value')
xlabel('time')
ylabel('Amplitude')
grid on


%%
%Determine maximum error and standard deviation of error hence plot errorvs.time
t=0:0.01:2*pi;
S=4*sin(pi*t); %sampled signal
quantization = [ -3.25, -2.5, -1.5, -0.5, 0.5, 1.5, 2.5, 3.25 ];
partition = [-3, -2, -1, 0, 1, 2, 3];
[I, Q] = quantiz(S, partition, quantization);
% Q gives the quantized value
%SD=sqrt(sum((Q-S).^2)/length(Q))
%standards deviation of Q and S
%E=max(abs(Q-S)) %maximum value error
Er=S-Q;
plot(t,Er, 'k')
xlabel('time')
ylabel('Error')

%%
%speech signal quantization
load mtlb;
X=mtlb;
S=X (1200:1300); %Taking 100 samples of speech
quantization = [ -3.25, -2.5, -1.5, -0.5, 0.5, 1.5, 2.5, 3.25 ];
partition = [-3, -2, -1, 0, 1, 2, 3];
[I, Q] = quantiz(S, partition, quantization);
stem(Q, 'r')
hold on
stem(S, 'b*')
legend('Baseband','Sampled Value')
xlabel('Index of samples')
ylabel('Amplitude')
grid on

%%
%plot Error signal of speech
Er=S-Q';
plot(Er, 'k')
xlabel('time')
ylabel('Error')
grid on

