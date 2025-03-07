%%
%Q1 DPCM
predictor = [0 1];
partition = [-1:0.1:0.9]; codebook = [-1:0.1:1];
t = 0:pi/20:3*pi;
x = sin(0.2*pi*t); %upper and lower bounds are [1 -1]
en = dpcmenco(x, codebook, partition, predictor);
de = dpcmdeco(en, codebook, predictor);
stem(t,x, 'r*')
hold on
stem(t, de, 'bd')
legend('Original', 'Recovered')
grid on
distor = sum((x-de).^2)/length(x) % Mean square error
xlabel('time')
ylabel('Original and Recovered Signal')

%%
% Original and Encoded Signal
stem(t, x, 'r*');
hold on
stem(t, en, 'm>')
legend('Original', 'Encoded Signal')
grid on
xlabel('time')
ylabel('Original and Encoded Signal')

%%
%Q2 Encode a sinusoidal signal based on DPCM and recover it using previous sample as the predictor.
load mtlb
y = mtlb;
x = y(1:1000);
t = 1:1:length(x);
predictor = [0 1];
partition = [-3:0.1:3];
codebook = [-3:0.1:3.1];
encodedx = dpcmenco(x,codebook,partition,predictor);
% Try to recover x from the modulated signal.
decodedx = dpcmdeco(encodedx, codebook, predictor);
plot(t, x, 'r', t, decodedx, 'b--')
legend('Original', 'Recovered')
grid on
xlabel('time')
ylabel('Original and Recovered Signal')
distor = sum((x-transpose(decodedx)).^2)/length(x)

%%
%Q3 Signal Recovery and Encryption Using Step-wise Adjustment Based on Signal Differences
t = 0:pi/20:3*pi;
x = sin(0.2*pi*t); % Original signal
k=0.06; % Step Size
for i=1:length(t)-1
if x(i+1)-x(i)>=0;
Del(i)=k;
else
		Del(i)=-k;
end
end
y(1)=x(1); % Initialisation
for i=1:length(t)-1
y(i+1) = y(i)+Del(i);
end
stem(t,x, 'r*');
hold on
stem(t, y, 'bd')
hold on
stem(0:pi/20:3*pi-pi/20, Del, 'ms')
legend('Original', 'Recovered', 'Encrypted')

%%
%Q4 Signal Recovery Using Step-wise Adjustment Based on Signal Differences
load mtlb
z = mtlb; x = z(100:250);
t = 1:1:length(x);
k=0.03;
for i=1:length(t)-1 
if x(i+1)-x(i)>=0;
Del(i)=k;
else
Del(i)=-k;
end
end
y(1)=x(1); % Initialisation
for i=1:length(t)-1
y(i+1) = y(i)+Del(i); %Previous sample + K
end

stem(t,x, 'r*');
hold on
stem(t, y, 'bd')
legend('Original', 'Recovered')
grid on 

%%
%Signal Recovery Using Weighted Sum of Previous Samples and Step-wise Adjustment
load mtlb
z = mtlb; x = z(100:250);
t = 1:1:length(x);
k=0.03;
for i=1:length(t)-1
if x(i+1)-x(i)>=0;
Del(i)=k;
else
Del(i)=-k;
end
end
y(1)=x(1);y(2)=x(1)+Del(1); % Initialisation
for i=2:length(t)-1
y(i+1) = 0.2*y(i-1)+0.8*y(i)+Del(i);
%Weighted sum of Previous samples + K
end

stem(t,x, 'r*');
hold on
stem(t, y, 'bd')
legend('Original', 'Recovered')
grid on


%% A Question to Solve
%(i) Observe the results for considering, y(i+1) = 0.1*y(i-1)+0.9*y(i)+Del(i); 
%(ii) Find error for both combinations.  
%(iii) Change step size and observe error.

% i
load mtlb
z = mtlb; x = z(100:250);
t = 1:1:length(x);
k=0.03;
for i=1:length(t)-1
if x(i+1)-x(i)>=0;
Del(i)=k;
else
Del(i)=-k;
end
end
y(1)=x(1);y(2)=x(1)+Del(1); % Initialisation
for i=2:length(t)-1
y(i+1) = 0.1*y(i-1)+0.9*y(i)+Del(i);
%Weighted sum of Previous samples + K
end
stem(t,x, 'r*');
hold on
stem(t, y, 'bd')
legend('Original', 'Recovered')
grid on

%%
% ii
% Load data
load mtlb
z = mtlb; 
x = z(100:250); % Select segment of signal
t = 1:1:length(x); % Time indices
k = 0.03; % Step size

% Delta Modulation
for i = 1:length(t)-1
    if x(i+1) - x(i) >= 0
        Del(i) = k;
    else
        Del(i) = -k;
    end
end
% Case 1: y(i+1) = 0.1*y(i-1) + 0.9*y(i) + Del(i)
% Initialize
y1(1) = x(1); 
y1(2) = x(1) + Del(1); 

for i = 2:length(t)-1
    y1(i+1) = 0.1 * y1(i-1) + 0.9 * y1(i) + Del(i);
end

% Compute Error for Case 1
error1 = sum((x - y1').^2) / length(x); % Mean square error

% Case 2: y(i+1) = 0.2*y(i-1) + 0.8*y(i) + Del(i)
% Initialize
y2(1) = x(1); 
y2(2) = x(1) + Del(1); 

for i = 2:length(t)-1
    y2(i+1) = 0.2 * y2(i-1) + 0.8 * y2(i) + Del(i);
end
% Compute Error for Case 2
error2 = sum((x - y2').^2) / length(x); % Mean square error

% Plot Results
figure;
subplot(2,1,1);
stem(t, x, 'r*'); hold on;
stem(t, y1, 'bd');
legend('Original Signal', 'Recovered Signal (0.1 & 0.9)');
title(['Recovered Signal for Case 1 (Error = ', num2str(error1), ')']);
grid on; xlabel('Time'); ylabel('Amplitude');

subplot(2,1,2);
stem(t, x, 'r*'); hold on;
stem(t, y2, 'bd');
legend('Original Signal', 'Recovered Signal (0.2 & 0.8)');
title(['Recovered Signal for Case 2 (Error = ', num2str(error2), ')']);
grid on; xlabel('Time'); ylabel('Amplitude');
% Display Errors
disp(['Mean Square Error for Case 1 (0.1 & 0.9): ', num2str(error1)]);
disp(['Mean Square Error for Case 2 (0.2 & 0.8): ', num2str(error2)]);


%%
% iii
% Initialization
t = 0:pi/20:3*pi;
x = sin(0.2*pi*t); % Original signal
k_values = [0.03, 0.06]; % Different step sizes

for k = k_values
% Delta Modulation
Del = zeros(1, length(t)-1); % Preallocate Delta array
for i = 1:length(t)-1
if x(i+1) - x(i) >= 0
Del(i) = k;
else
Del(i) = -k;
end
end

% Recovered Signal with Weights (0.2 & 0.8)
y = zeros(1, length(t)); % Preallocate Recovered Signal
y(1) = x(1); y(2) = x(1) + Del(1); % Initialization
for i = 2:length(t)-1
y(i+1) = 0.2 * y(i-1) + 0.8 * y(i) + Del(i);
end

% Error Calculation
error = sum((x - y).^2) / length(x); % Mean square error
% Plot Results
figure;
stem(t, x, 'r*', 'DisplayName', 'Original Signal'); hold on;
stem(t, y, 'bd', 'DisplayName', ['Recovered Signal (k = ', num2str(k), ')']);
grid on;
legend();
title(['Recovered Signal with Step Size ', num2str(k), ' | Error: ', num2str(error)]);
xlabel('Time'); ylabel('Amplitude');
end
