clear();

% info = audioinfo('sample.wav');
% info = audioinfo('sample_2.wav');

% [y,Fs] = audioread('sample_2.wav');
%  [y,Fs] = audioread('background.wav');
 [y,Fs] = audioread('background.amr');

figure('Renderer', 'painters', 'Position', [10 10 900 600]);

y = y(:, 1);
N=length(y);
t=(0:N-1)/Fs;
N/Fs;

subplot(3,1,1)
plot(t,y)
xlabel('Time')
ylabel('Audio Signal')

subplot(3,1,2)
histogram(y);
subplot(3,1,3)
histogram(y,'Normalization','probability');

% logistic_map(0.001,4,500);


