%%
%Verification of Gibb's Phenomenon
t=-1.1:0.001:1.1;
T=1; %period of rectangular pulse train
tau=0.2; %width of pulse
a0=tau/T;
n=10; %number of harmonics components
ft=a0;
for i=1:n,
ft=ft+(2/T)*tau*sinc(i*tau/T)*cos(2*pi*i*t/T);
end
plot(t, ft); %plot the sum of the Fourier components
xlabel('Time-------');
ylabel('Amplitude');
title('Gibbs phenomenon for n=10');
hold on;
t=[-1.1 -1.1 -0.9 -0.9 -0.5 -0.1 -0.1 0.1 0.1 0.5 0.9 0.9 1.1 1.1];
ft=[0 1 1 0 0 0 1 1 0 0 0 1 1 0];
plot(t, ft, 'r'); %plots the original pulse wave
hold off;
grid on