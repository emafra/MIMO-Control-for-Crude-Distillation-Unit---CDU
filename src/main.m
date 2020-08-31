%%% planta do artigo do Odloak
clear all, close all, clc

s = tf('s')

G = tf(0,1)*zeros(10,8);
%%% modelos monovari?veis Gij, onde i ? a i-?sima controlada e j ? a
%%% j-?sima manipulada
G(8,1) = tf([7.31e-4 -1.82e-3 1.49e-2 2.67e-3 1.32e-3 1.71e-4],[1 2.18 5.83 2.14 0.56 0.03 9.07e-4]);
G(9,1) = tf([-2.63e-2 -0.17 0.36 0.15 0.12 5.55e-3 8.86e-4],[1 8.16 +29.45 19.87 7.98 1.11 0.10 3.2e-3]);
G(10,1) = tf([-1.88e-4 1.11e-4 1.53e-4 8.67e-5 -1.76e-5 3.9e-5],[1 3.83 6.67 2.84 0.68 0.12 4.88e-3]);


G(3,2) = tf([-1.29 -1.37 -2.13],[1 1.99 0.99 0.19],'iodelay',14);
G(7,2) = tf([4.6e-3 0.06 4.11e-3],[1 0.39 0.07 2.93e-3]);
G(8,2) = tf([11.31 102.90 -58.29 -171.20 -362.10 -159.70 -56.27],[1 8.84 38.89 71.07 83.25 53.24 19.11 3.16]);
G(9,2) = tf([-8.80 13.69 8.60 5.95 0.89 0.18],[1 4.13 4.94 2.19 0.65 0.11 7.57e-3]);
G(10,2) = tf([-4.67e-3 -5.59e-4 -6.75e-4],[1 0.32 0.06 5.19e-3]);

G(1,3) = tf([0.46 -1.15 7.40 0.91],[1 2.57 11.90 3.96 0.32]);
G(7,3) = tf([-0.2 -1.08 3.67 3.13],[1 9.85 35.88 12.34 1.62]);
G(8,3) = tf([-0.83 15.19 4.86],[1 1.85 0.46 0.06]);
G(9,3) = tf([0.56 14.74 5.08],[1 1.96 0.52 0.05]);
G(10,3) = tf([1.82e-3 0.2 -0.41 -0.78],[1 3.55 14.10 9.24 2.22]);

G(2,4) = tf([0.24 -0.14 1.71 3.63 3.72 0.66 0.05],[1 5.58 19.65 39.65 11.93 3.85 0.2 4.13e-3]);
G(3,4) = tf([0.14 3.82 -7.56 -12.02 -0.3 -0.39],[1 5.22 18.97 17.63 3.14 0.32 0.01]);
G(4,4) = tf([-0.13 0.26 0.29],[1 4.16 1.90 0.32]);
G(5,4) = tf([-6.42e-4 -0.02 0.04 0.05 0.04 0.03 6.327e-3],[1 4.27 16.04 10.95 6.98 1.72 0.51 0.02]);
G(6,4) = tf([0.03 -0.12 0.60 0.42],[1 3.26 13.41 7.94 1.64]);

G(5,5) = tf([-6.499e-4 -6.382e-4 -1.923e-4],[1 0.58 0.09 5.371e-3]);

G(3,6) = tf([-0.05 0.52 -1.92 -2.32],[1 4.56 17.19 17.01 5.58]);
G(4,6) = tf([0.01 0.03 0.05 -0.44],[1 7.28 29.63 53.21 33.54]);
G(6,6) = tf([9.46e-4 -1.39e-5 1.72e-4],[1 0.46 0.12 0.01]);

G(2,7) = tf([0.01 -0.02 -0.02 -0.01 -1.84e-4 -1.89e-4],[1 3.39 4.97 2.45 0.47 0.03 9.58e-4]);
G(3,7) = tf([-1.84e-3 -6.35e-4 -1.07e-4],[1 0.26 0.02 3.83e-4]);
G(4,7) = tf([-6.67e-4 1.26e-3 1.71e-3 1.68e-4 6.58e-5],[1 2.48 3.34 0.66 0.08 4.09e-3]);
G(5,7) = tf([-8.51e-4 -1.52e-4 -1.48e-4 -1.01e-5 -1.32e-6 -6e-8],[1 0.31 0.21 0.04 6.14e-3 2.93e-4 5.26e-6]);
G(6,7) = tf([-8.431e-4 5.02e-5 -0.02 -3.67e-3],[1 3.34 13.05 3.09 0.25]);


G(3,8) = tf([0.5407 1.312 0.5546 0.3327 0.06388 0.005414 0.0003131],[1 0.4485 0.599 0.1516 0.06437 0.009542 0.0005524 1.289e-5]);
G(4,8) = tf([0.008947 -0.3574 1.39 0.9825],[1 4.132 15.16 7.629 1.396]);
G(5,8) = tf([-0.02 -0.26 0.74 0.21 0.11 0.04],[1 5.85 20.46 13.84 4.03 0.67 0.04]);
G(10,8) = tf([0.03 -0.1 0.51 0.11],[1 2.96 12.66 5.60 0.7]);
%%

%%% sele??o das vari?veis para o trabalho
iy = [1,3,7,9];
iu = [1,2,3,8];

%% condicoes iniciais do processo de acordo com artigo
y0 = [1.03 220 1670.41 184.38 368.6 39.7 173.68 1050 911.62 17.7]';
u0 = [8000 128 1 110 1271.5 6400 1050 372]';

umax = [9500 135 1.2 120 2000 7000 1200 380];
umin = [7000 125 0.2 100 800  5000 800  360];

ymax = [4 380 1850 190 370 65 180 1290 1342 21];
ymin = [1 40 800 180 368 35 160 600 600 15];

%% modelo simplificado
G = G(iy,iu);
K = dcgain(G);

y0 = y0(iy);
u0 = u0(iu);

ymax = ymax(iy);
ymin = ymin(iy);

umax = umax(iu);
umin = umin(iu);

%% parametros para simulação
clc
tsim = 1000;
ref_t = [0;300;600];
ref_v = [y0';y0';y0'];
ref_v(:,1) = [1.4;1.2;1.2]; %% y1
ref_v(:,2) = [1580;1330;1400]; %% y3
ref_v(:,3) = [170;180;175]; %% y7
ref_v(:,4) = [950; 1000; 900];  %% y9

refs = [ref_t,ref_v];

%% Aproximando o atraso 

%Gn = G;

%s = tf('s');

G(2,2) = (1/(1+14*s))*(-1.29*(s^2) -1.37*s -2.13)/(s^3 + 1.99*s^2 + 0.99*s + 0.19);

%% Desacoplamento

Gs = sym('G',[4 4]);
Ds = sym('D',[4 4]);

for i = 1:4
    Ds(i,i) = 1;
end

GDs = Gs*Ds;

Dvar = []; %% icógnitas

for i = 1:4
    for j= 1:4
        if(~(i==j))
            Dvar = [Dvar;Ds(i,j)];
        end
    end
end

eqn = [GDs(1,1); GDs(1,2); GDs(1,4); GDs(2,1); GDs(2,2); GDs(2,3);
    GDs(3,1); GDs(3,3); GDs(3,4); GDs(4,2); GDs(4,3); GDs(4,4)]; % quais equações eu quero qie sejam zero a partir da minha 
% análise da matriz RGA.

Dot = solve(eqn, Dvar);


Dotv =[];
x = fieldnames(Dot);
for i=1:12
    Dotv = [Dotv;Dot.(x{i})];
end

D1 = subs(Ds,Dvar,Dotv);

% Atribuindo valores as variaveis simbólicas:

G1_1 = G(1,1);
G1_2 = G(1,2);
G1_3 = G(1,3);
G1_4 = G(1,4);

G2_1 = G(2,1);
G2_2 = G(2,2);
G2_3 = G(2,3);
G2_4 = G(2,4);

G3_1 = G(3,1);
G3_2 = G(3,2);
G3_3 = G(3,3);
G3_4 = G(3,4);

G4_1 = G(4,1);
G4_2 = G(4,2);
G4_3 = G(4,3);
G4_4 = G(4,4);

% Encontrando os valores dos desacopladores:
D = zeros(4,4)*tf(0,1);

for i = 1:4
    for j =1:4
        D(i,j) = eval(char(D1(i,j)));
    end
end

D = minreal(D);

% Db = D;
% 
% Db(1,2) = aproxD(D(1,2));
% Db(1,3) = aproxD(D(1,3));
% Db(4,3) = aproxD(D(4,3));

Dn = D;

Dn(1,2) = invPZ(D(1,2));
Dn(1,3) = invPZ(D(1,3));
Dn(2,3) = invPZ(D(2,3));
Dn(4,2) = invPZ(D(4,2));
Dn(4,3) = invPZ(D(4,3));

%% Aproximando as plantas de interesse para primeira ordem:

rga = K.*inv(K)';

s = tf('s');

%step(G(1,3)) Coletando os tempos de assentamento
%step(G(2,4))
%step(G(3,2))
%step(G(4,1))

Gn_aprox = G;

temp13 = 11.8;
[Tau13,p13] = aproxima_primeira_ordem(temp13);
K13 = dcgain(G(1,3))/Tau13;
Gn_aprox(1,3) = K13/(s+p13);
%step(Gn(1,3),Gn_aprox(1,3))

temp24 = 72.4;
[Tau24,p24] = aproxima_primeira_ordem(temp24);
K24 = dcgain(G(2,4))/Tau24;
Gn_aprox(2,4) = K24/(s+p24);
%step(Gn(2,4),Gn_aprox(2,4))

temp32 = 20;
[Tau32,p32] = aproxima_primeira_ordem(temp32);
K32 = dcgain(G(3,2))/Tau32;
Gn_aprox(3,2) = K32/(s+p32);
%step(Gn(3,2),Gn_aprox(3,2))

temp41 = 63.1;
[Tau41,p41] = aproxima_primeira_ordem(temp41);
K41 = dcgain(G(4,1))/Tau41;
Gn_aprox(4,1) = K41/(s+p41);
%step(Gn(4,1),Gn_aprox(4,1))

%% Projeto de controle sem cancelamento com polos reias iguais:

Taud13 = temp13/9.6;
pd13 = 1/Taud13;
Kc13 = ((2/Taud13)-p13)/K13;
z13 = ((1/Taud13)^2)/(Kc13*K13);
C13 = Kc13*(s + z13)/s;

Taud24 = temp24/9.6;
pd24 = 1/Taud24;
Kc24 = ((2/Taud24)-p24)/K24;
z24 = ((1/Taud24)^2)/(Kc24*K24);
C24 = Kc24*(s + z24)/s;

Taud32 = temp32/9.6;
pd32 = 1/Taud32;
Kc32 = ((2/Taud32)-p32)/K32;
z32 = ((1/Taud32)^2)/(Kc32*K32);
C32 = Kc32*(s + z32)/s;

Taud41 = temp41/9.6;
pd41 = 1/Taud41;
Kc41 = ((2/Taud41)-p41)/K41;
z41 = ((1/Taud41)^2)/(Kc41*K41);
C41 = Kc41*(s + z41)/s;

% C = C'; ele será transposto na simulação do simulink

%   Aplicamos o comando "pid" para conseguir os ganhos do controlador PI 
% paralelo.

%% Planta desacoplada

GD = G * Dn;

%% Controle planta desacoplada 

% step(GD(1,3))
temp13 = 11.8;
[Tau13,p13] = aproxima_primeira_ordem(temp13);
K13 = dcgain(GD(1,3))/Tau13;

Kc13 = ((2/Taud13)-p13)/K13;
Taud13 = temp13/9.6;
pd13 = 1/Taud13;
Kc13 = ((2/Taud13)-p13)/K13;
z13 = ((1/Taud13)^2)/(Kc13*K13);
CD13 = Kc13*(s + z13)/s;

% step(GD(2,4))
temp24 = 72.4;
[Tau24,p24] = aproxima_primeira_ordem(temp24);
K24 = dcgain(GD(2,4))/Tau24;

Kc24 = ((2/Taud24)-p24)/K24;
Taud24 = temp24/9.6;
pd24 = 1/Taud24;
Kc24 = ((2/Taud24)-p24)/K24;
z24 = ((1/Taud24)^2)/(Kc24*K24);
CD24 = Kc24*(s + z24)/s;

% step(GD(3,2))
temp32 = 20;
[Tau32,p32] = aproxima_primeira_ordem(temp32);
K32 = dcgain(GD(3,2))/Tau32;

Kc32 = ((2/Taud32)-p32)/K32;
Taud32 = temp32/9.6;
pd32 = 1/Taud32;
Kc32 = ((2/Taud32)-p32)/K32;
z32 = ((1/Taud32)^2)/(Kc32*K32);
CD32 = Kc32*(s + z32)/s;

% step(GD(4,1))
temp41 = 63.1;
[Tau41,p41] = aproxima_primeira_ordem(temp41);
K41 = dcgain(GD(4,1))/Tau41;

Kc41 = ((2/Taud41)-p41)/K41;
Taud41 = temp41/9.6;
pd41 = 1/Taud41;
Kc41 = ((2/Taud41)-p41)/K41;
z41 = ((1/Taud41)^2)/(Kc41*K41);
CD41 = Kc41*(s + z41)/s;


