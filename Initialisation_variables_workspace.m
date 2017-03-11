clear all
close all

%hypothèses :
    %le pneu est indéformable et le coefficient d'adhérence est constant
    %Aucun glissement des pneus
    %Absence de suspensions
    %Aucune perte dans la transmission (pas encore estimé le coefficient
    %   lié au perte)
    %L'appui aérodynamique n'est pas considéré, considère que la trainée
    %Passage des rapports optimisé (post d'adrien de la salle)
    %Temps de passage des rapports constant
    %Aucun regime transitoire considéré (transfert de charges)
    
    %Equation mécanique obtenu avec un TEC sur le véhicule entier
    

%Paramètres géométriques du véhicule en mm

h_v = 0.3; %hauteur du centre de gravité du véhicule
h_p = 0.3; %hauteur du centre de gravité du pilote
e = 1.2; %empattement
b = 0.5; %distance selon x entre le centre de gravité et le centre des roues arriere
v = 1.2; %voie

%Paramètre véhicule
mveh = 220; %masse de la voiture
mpilote = 70; %Masse du pilote
maileron = 20; %masse de des dispositif aérodynamique
mtot = mveh + mpilote + maileron; %masse de l'ensemble
m = mtot;
g = 9.81;
h = (mpilote*h_p + mveh*h_v)/m; %hauteur du centre de gravité
D_roue = 0.53; % Diametre exterieur de la roue (m)
R = D_roue/2; %Rayon de la roue

coeff_roul = 0.01; % Coefficient de resistance au roulement du pneu (delta en m)

J_rot = 0.111; % Inertie d'une roue équipée (kg.m²) (estimé avec Catia)
J_trans = m*R^2; % Inertie equivalente des masses en translation (kg.m²)
J_eq = J_trans + 4*J_rot; % Inertie totale (kg.m²)

%Moteur
%Courbe moteur
C_mot = [0,45.126,51.01200000000001,52.974000000000004,51.01200000000001,48.069,49.050000000000004,51.01200000000001,56.898,58.86,58.86,57.879000000000005,56.898,54.936,51.993,48.069,44.145,40.221,36.297000000000004,32.373];

%Régime correspondant
regime = [0, 4500:500:13500];

reg_patinage = 8000; %régime de patinage de l'embrayage (rpm)
reg_rupteur = 14000; %regime du rupteur (rpm)


%Paramètre boite de vitesse :
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
rapport_max = 6; %rapport maximale autorisé

t_passage = 0.1; %temps de passage des vitesses en seconde

%Donne pneu
load('HB136_P10_IA0_SA0_maxR5.mat');
ChargePneu = FzMu(1,:);
MuLong = FzMu(2,:);

%Parametre aerodynamique
%trainée
rho = 1.2; %masse volumique de l'air en kg/m3
Cx = 0.7; %coeff de trainée
S = 1; %surface de référence (m2)

%appui
Cl = 2.2;%
Sproj = 1.2*0.3 ;%0.3 est la corde de l'aileron
%pour rappel : penser à la masse de l'aileron

%Paramètre initiaux de la simulation
vitesse_initiale = 0;
position_initale = 0;


%Lancement de la simulation :
sim('Accel_model');

%Création des graphiques
run('DessinCourbe.m');

%Résultats de la simulation :
disp('Temps (s) :')
disp(max(Distance.time))