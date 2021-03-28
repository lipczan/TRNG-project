%% INPUT
clear();

% info = audioinfo('samples/background.wav')
% [y,Fs] = audioread('samples/background.wav');
% 
% 
% info = audioinfo('samples/ojcze_nasz.wav')
% [y,Fs] = audioread('samples/ojcze_nasz.wav');

info = audioinfo('samples/karol_halasuje.wav')
[y,Fs] = audioread('samples/karol_halasuje.wav');

%% SIGNAL
figure('Renderer', 'painters', 'Position', [10 10 900 600]);

y = y(:, 1);
y = transpose(y);
N=length(y);
t=(0:N-1)/Fs;

subplot(4,1,1)
plot(t,y)
xlabel('Time')
ylabel('Audio Signal')

% normalizacja
subplot(4,1,2)
histogram(y);
subplot(4,1,3)
histogram(y,'Normalization','probability');

%% POSTPROCESING
x0=0.001;
r=4;
P=2^16;

rozmiar = size(y); 
B = rozmiar(2);

N=B-1;
% zmiana parametr?w mapy chaotycznej w zale?no?ci od pliku audio

x(1)=x0;
for n=1:N
    x(n+1)=r.*x(n).*(1-x(n));
end

%x - chaotic map
%y - samples

K=1000;
z=bitxor(floor(x.*P), floor(P*abs(y)))/P;

s = z>0.5; % najprostsza binaryzacja 
for i=1:(N/8) %konwersja bitow na liczby 8 bitowe
    a = (8*i)-7;
    b = 8*i;
    numb(i) = bi2de(s(a:b));
end

subplot(4,1,4)
histogram(numb,256);

