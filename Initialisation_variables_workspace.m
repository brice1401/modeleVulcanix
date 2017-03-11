clear all
close all

%hypoth�ses :
    %le pneu est ind�formable et le coefficient d'adh�rence est constant
    %Aucun glissement des pneus
    %Absence de suspensions
    %Aucune perte dans la transmission (pas encore estim� le coefficient
    %   li� au perte)
    %L'appui a�rodynamique n'est pas consid�r�, consid�re que la train�e
    %Passage des rapports optimis� (post d'adrien de la salle)
    %Temps de passage des rapports constant
    %Aucun regime transitoire consid�r� (transfert de charges)
    
    %Equation m�canique obtenu avec un TEC sur le v�hicule entier
    

%Param�tres g�om�triques du v�hicule en mm

h_v = 0.3; %hauteur du centre de gravit� du v�hicule
h_p = 0.3; %hauteur du centre de gravit� du pilote
e = 1.2; %empattement
b = 0.5; %distance selon x entre le centre de gravit� et le centre des roues arriere
v = 1.2; %voie

%Param�tre v�hicule
mveh = 220; %masse de la voiture
mpilote = 70; %Masse du pilote
maileron = 20; %masse de des dispositif a�rodynamique
mtot = mveh + mpilote + maileron; %masse de l'ensemble
m = mtot;
g = 9.81;
h = (mpilote*h_p + mveh*h_v)/m; %hauteur du centre de gravit�
D_roue = 0.53; % Diametre exterieur de la roue (m)
R = D_roue/2; %Rayon de la roue

coeff_roul = 0.01; % Coefficient de resistance au roulement du pneu (delta en m)

J_rot = 0.111; % Inertie d'une roue �quip�e (kg.m�) (estim� avec Catia)
J_trans = m*R^2; % Inertie equivalente des masses en translation (kg.m�)
J_eq = J_trans + 4*J_rot; % Inertie totale (kg.m�)

%Moteur
%Courbe moteur
C_mot = [0,45.126,51.01200000000001,52.974000000000004,51.01200000000001,48.069,49.050000000000004,51.01200000000001,56.898,58.86,58.86,57.879000000000005,56.898,54.936,51.993,48.069,44.145,40.221,36.297000000000004,32.373];

%R�gime correspondant
regime = [0, 4500:500:13500];

reg_patinage = 8000; %r�gime de patinage de l'embrayage (rpm)
reg_rupteur = 14000; %regime du rupteur (rpm)


%Param�tre boite de vitesse :
rap_pri = 36/76;
rap(1) = 12/33;
rap(2) = 16/32;
rap(3) = 18/30;
rap(4) = 18/26;
rap(5) = 23/30;
rap(6) = 24/29;
rap_couronne = 13/45;

%Donnees pour le passage des vitesses
%les vitesses sont en km/h
v1 = 62.7;
v2 = 80.5;
v3 = 95;
v4 = 107.9;
v5 = 118.3;

v_passage = [0, v1, v2, v3, v4, v5]/3.6; %vitesse en m/s
rapport = [1, 2, 3, 4, 5, 6];
rapport_max = 6; %rapport maximale autoris�

t_passage = 0.1; %temps de passage des vitesses en seconde

%Donne pneu
load('HB136_P10_IA0_SA0_maxR5.mat');
ChargePneu = FzMu(1,:);
MuLong = FzMu(2,:);

%Parametre aerodynamique
%train�e
rho = 1.2; %masse volumique de l'air en kg/m3
Cx = 0.7; %coeff de train�e
S = 1; %surface de r�f�rence (m2)

%appui
Cl = 2.2;%
Sproj = 1.2*0.3 ;%0.3 est la corde de l'aileron
%pour rappel : penser � la masse de l'aileron

%Param�tre initiaux de la simulation
vitesse_initiale = 0;
position_initale = 0;


%Lancement de la simulation :
sim('Accel_model');

%Cr�ation des graphiques
run('DessinCourbe.m');

%R�sultats de la simulation :
disp('Temps (s) :')
disp(max(Distance.time))