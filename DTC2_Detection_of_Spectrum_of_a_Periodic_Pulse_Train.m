%%
%Spectrum of periodic signal is discrete:
A=2;
n=-15:1:15;
T=2; 
tau=0.2;
Cn=A*tau*sinc(n*tau/T);
stem(n/T,Cn, 'k')
xlabel('nf')
ylabel('Cn')
title('Spectrum of rectangular pulse train A=2, T=2 and Tau=0.2 units')
grid on

%%
%Impact of impact of τ on shifting of zero crossing points
subplot(2,1,1)
 n=-20:1:20;
 T=10;
 tau=2;
 d=tau/T;
 y=sinc(n*d);
 stem(n/T,y, 'k')
 title('tau=10')
 subplot(2,1,2)
 tau=5;  %reduced
 d=tau/T;
 y=sinc(n*d);
 stem(n/T,y, 'k')
 title('tau=5')

%%
%Impact of impact of T 
subplot(2,1,1) 
n=-10:1:10;
T=2;
tau=0.2;
d=tau/T;
y=sinc(n*d);
stem(n/T,y, 'k')
title('T=2')
subplot(2,1,2)
n=-5:1:5;
T=1;
tau=0.2;  
d=tau/T;
y=sinc(n*d);
stem(n/T,y, 'k')
title('T=1')

%%
% For Period T=0.5 , T=0.3
subplot(2,1,1)
n=-10:1:10;
T=0.5;
tau=0.2;
d=tau/T;
y=sinc(n*d);
stem(n/T,y, 'k')
title('T=0.5')
subplot(2,1,2)
n=-5:1:5;
T=0.3;
tau=0.2;
d=tau/T;
y=sinc(n*d);
stem(n/T,y, 'k')
title('T=0.3')

%%
%Impact of impact of 𝑵
subplot(2,1,1) 
n=-41:1:41;
T=2;
tau=0.2;
d=tau/T;
y=sinc(n*d);
stem(n/T,y, 'k')
title('n=41')
subplot(2,1,2)
n=-14:1:14;
T=2;
tau=0.2;  
d=tau/T;
y=sinc(n*d);
stem(n/T,y, 'k')
title('n=14')


