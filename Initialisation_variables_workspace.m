
%Param�tres g�om�triques du v�hicule en mm

h_v = 0.3; %hauteur du centre de gravit� du v�hicule
h_p = 0.3; %hauteur du centre de gravit� du pilote
e = 1.2; %empattement
b = 0.5; %distance selon x entre le centre de gravit� et le centre des roues arriere
v = 1.2; %voie

%Param�tre v�hicule
mveh = 215; %masse de la voiture
mpilote = 70; %Masse du pilote
mtot = mveh + mpilote; %masse de l'ensemble
m = mtot;
g = 9.81;
h = (mpilote*h_p + mveh*h_v)/m; %hauteur du centre de gravit�
D_roue = 0.53; % Diametre exterieur de la roue (m)

coeff_roul = 0.01; % Coefficient de resistance au roulement du pneu
b = coeff_roul*2/D_roue; % Decalage du point d'appui (m)
c_roul = m*g*b; % Resistance au roulement (N.m)

J_rot = 0; % Inertie equivalente des masses en rotation (kg.m�)
J_trans = m*D_roue*D_roue/4; % Inertie equivalente des masses en translation (kg.m�)
J_eq = J_trans + J_rot; % Inertie totale (kg.m�)

c_moteur = 60;  % Couple d�livr� par le moteur

parametreGeo = [h, e, b, v];

%Param�tre boite de vitesse :
rap_pri = 36/76;
rap(1) = 12/33;
rap(2) = 16/32;
rap(3) = 18/30;
rap(4) = 18/26;
rap(5) = 23/30;
rap(6) = 24/29;
rap_couronne = 13/45;

%Param�tre initiaux de la simulation
vitesse_initiale = 0;


%Lancement de la simulation :
sim('Accel_model_test');


%Cr�ation des graphiques

run('DessinCourbe.m');
