%% INPUT
clear();

info = audioinfo('sample.wav')
% [y,Fs] = audioread('sample.wav');
[y,Fs] = audioread('sample.wav');

%% BINARIZATION
% fid  = fopen('background.wav', 'r');
% data = fread(fid, [1, Inf], 'uint8');
% fclose(fid);
% bit = uint8(rem(floor((1 ./ [128, 64, 32, 16, 8, 4, 2, 1].') * data), 2));
% bit = bit(:);

% q = quantizer('double');
% p = num2bin(q,y);

% DoubleAsCharacters = char(typecast(y, 'uint8'));

% y_abs=abs(y);
% p=dec2bin(y_abs, 8) - '0'

% wavdata = audioread('sample.wav', 'native');
% wavbinary = uint8(reshape((dec2bin( wavdata(:), 8 ) - '0').', [], 1));
% fid = fopen('wav.bin', 'w');
% fwrite(fid, wavbinary, 'uint8');
% fclose(fid);
% fid = fopen('wav.bin', 'r');
% A = fread(fid,'*uint8');
% wavdata = uint16(reshape(bin2dec( char(reshape(A, 8, []).' + '0') ), [], 2));
% SampleRate = 22100;
% audiowrite('FileNameGoesHere.wav', wavdata, SampleRate)

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

rozmiar = size(y); 
B = rozmiar(2);

N=B-1;
% zmiana parametr?w mapy chaotycznej w zale?no?ci od pliku audio


x(1)=x0;


for n=1:N
    x(n+1)=r.*x(n).*(1-x(n));
end
% figure
% subplot(2, 1, 1)
% plot(x(1:N), x(2:N+1),'rs-')
% ylabel('x(i+1)')
% xlabel('x(i)')
% title('x(i+1) vs x(i)')

% subplot(2, 1, 2)
% plot(x)
% axis([0 N 0.2 1])
% ylabel('x(i)')
% xlabel('(i)')
% title('x[i] vs. i')


P=2^16;

%x - mapa chaotyczna
%y - pr?bki z d?wi?ku
K=1000;
z=bitxor(floor(x.*P), floor(P*abs(y)))/P;

subplot(4,1,4)
histogram(z);

