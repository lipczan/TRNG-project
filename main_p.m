%% INPUT
clear;

% 1th sample 
% audio info
info = audioinfo('samples/background.wav')
% to double
[y,Fsy] = audioread('samples/background.wav');

% to int16
[z,Fsz] = audioread('samples/background.wav','native');

% int16 to int8
z_size = size(z); 
Bz = z_size(1);
Nz=Bz-1; %size

z=transpose(z); %transpose
z(2:2) = []; %delete row

  
% SIGNAL
% display window
figure('Renderer', 'painters', 'Position', [10 10 900 600]);

% % signal plot
y = y(:, 1);
y = transpose(y);
Ny=length(y);
% N=length(y);
t=(0:Ny-1)/Fsy;

subplot(4,1,1)
plot(t,y)
xlabel('Time')
ylabel('Audio Signal')

% normalized before
subplot(4,1,2)
histogram(y,'Normalization','probability');
subplot(4,1,3)
histogram(z,'Normalization','probability');

% %% POSTPROCESING
x0=0.001;
r=4;
P=2^16;

y_size = size(y); 
By = y_size(2);
Ny=By-1; %size

% zmiana parametr?w mapy chaotycznej w zale?no?ci od pliku audio

x(1)=x0;
for n=1:Ny
    x(n+1)=r.*x(n).*(1-x(n));
end

%x - chaotic map
%y - samples

K=1000;
ch=bitxor(floor(x.*P), floor(P*abs(y)))/P;

s = ch>0.5; % najprostsza binaryzacja 
for i=1:(Ny/8) %konwersja bitow na liczby 8 bitowe
    a = (8*i)-7;
    b = 8*i;
    numb(i) = bi2de(s(a:b));
end

% normalized after
subplot(4,1,4)
% histogram(numb,256);
histogram(numb,'Normalization','probability')

