clear; 

%% AUDIO INPUT 
%double
[y,Fsy] = audioread('probki/ulica1_8bit.wav');
audiowrite('probki/ulica1_8bit.wav', y, Fsy, 'BitsPerSample', 8);
[y,Fsy] = audioread('probki/ulica1_8bit.wav');
info = audioinfo('probki/ulica1_8bit.wav')

% native
[z,Fsz] = audioread('probki/ulica1_8bit.wav','native');
z(1:1)=[]; 

%% SIGNAL PLOT
figure('Renderer', 'painters', 'Position', [10 10 1600 900]);

y = y(:, 1);
y = transpose(y);
Ny=length(y);
ty=(0:Ny-1)/Fsy;

plot(ty,y)
title('Signal plot')
xlabel('Time')
ylabel('Audio Signal')

%% HISTOGRAM PRE
% histogram z uint8 przed mapa chaotyczna
% subplot(5,1,3)
% histogram(y);

figure
histogram(z,256,'Normalization','probability')
title('Empiryczny rozk³ad zmiennych losowych generoweanych przez Ÿród³o szumu dla pe³nej tablicy zmiennych losowych')
xlabel('Wartoœæ (x)')
ylabel('Czestosc wystepowania (p_i)')

%sprawdzenie poprawnoœci -dodatkowe usuniêcie wartoœci
i=1;
for n=1:length(z)        
    if(z(n)<256) && (z(n)>0)
        dec256(i)=z(n);
        i=i+1;
    end
end

val_100k = dec256(1, 100000:200000)

%subplot(5,1,3)
figure
histogram(val_100k,256,'Normalization','probability')
title('Empiryczny rozk³ad zmiennych losowych generoweanych przez Ÿród³o szumu dla 100 000 zmiennych losowych')
xlabel('Wartoœæ (x)')
ylabel('Czestosc wystepowania (p_i)')
grid on


entr_100kval = entropia(val_100k)


%% POST-PROCESING
%MAPA CHAOTYCZNA
x0=0.001;
r=4;
P=2^8;
K=1000;

size_y = size(y); 
By = size_y(2);
 
Nyy=By-1;
 
x(1)=x0;
for n=1:Nyy
    x(n+1)=r.*x(n).*(1-x(n));
end

%szyfrowanie z map¹
ch=bitxor(floor(x.*P), floor(P*abs(y)))/P;

%% BINARIZATION

s = ch>0.5; % najprostsza binaryzacja 
for i=1:(Nyy/8) %konwersja bitow na liczby 8 bitowe
    a = (8*i)-7;
    b = 8*i;
    numb(i) = bi2de(s(a:b));
end


%% HISTOGRAM POST
%subplot(5,1,5)
figure

histogram(numb, 256, 'Normalization','probability');
ax = gca;
ax.YAxis.Exponent = 0;
title('Empiryczny rozk³ad zmiennych losowych po postprocessingu')
ylabel('czêstoœæ wystêpowania (p_i)')
xlabel('wartoœæ (x_i)')
xlim([0 256])

entr_post_process=entropia(numb)