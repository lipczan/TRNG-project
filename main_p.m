%% INPUT
clear(); 

info = audioinfo('samples/karol_halasuje.wav')
[y,Fsy] = audioread('samples/karol_halasuje.wav');

%to uint16
[z,Fsz] = audioread('samples/karol_halasuje.wav','native');

z=transpose(z); %transpose
z(2:2)=[]; 
u8=typecast(z,'uint8');

%% origin signal
% display
figure('Renderer', 'painters', 'Position', [10 10 900 600]);

y = y(:, 1);
y = transpose(y);
Ny=length(y);
ty=(0:Ny-1)/Fsy;

subplot(4,1,1)
plot(ty,y)
xlabel('Time')
ylabel('Audio Signal')
 
%% normalized
% histogram z uint8 przed mapa chaotyczna
subplot(4,1,2)
histogram(y);
subplot(4,1,3)
histogram(u8,'Normalization','probability');
 
%% POST-PROCESING
x0=0.001;
r=4;
P=2^16;
K=1000;

size_y = size(y); 
By = size_y(2);
 
Nyy=By-1;
 
x(1)=x0;
for n=1:Nyy
    x(n+1)=r.*x(n).*(1-x(n));
end

ch=bitxor(floor(x.*P), floor(P*abs(y)))/P;

% histogram po mapie chaotycznej z double 
s = ch>0.5; % najprostsza binaryzacja 
for i=1:(Nyy/8) %konwersja bitow na liczby 8 bitowe
    a = (8*i)-7;
    b = 8*i;
    numb(i) = bi2de(s(a:b));
end

subplot(4,1,4)
histogram(numb,256);
