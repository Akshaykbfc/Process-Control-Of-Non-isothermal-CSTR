%Script for Step reponse analysis of system with conventional controller and Cascaded controllers to analyse the
% performance of each controller and to compare them.

% Normal Transfer function(Fj- T)
num = [-1375 -6.476e04]
den = [1 76.97 1565 2775]
Gsys = tf(num,den)

%Effective transfer function of cascaded system(Tj-T) with P controller
num2 = [135.1 6360]
den2 = [1 141.6 4170 1.14e04]
Gcsys = tf(num2,den2)


%Effective transfer function of cascaded system(Tj-T) with PI controller
num3 = [135.1 9142 1.31e05]
den3 = [1 141.6 5502 6.481e04 1.724e05]
Gcsys1 = tf(num3,den3)


%Controller TF's
Gzn= tf([-0.1316 -0.2122],[1 0])

%cascade controller TF with P inner loop
Gcs = tf([5.3363 13.112],[1 0])

%cascade controller TF with PI inner loop
Gcs1 = tf([4.0329 10.2496],[1 0])

% cascaded Tf of Ziegler Nichol with IMC constroller and system
G1 = Gzn*Gsys

% cascaded TF of Effective system with cascade controller with P inner
G2 = Gcs*Gcsys

% cascaded TF of Effective system with cascade controller with PI inner
G3 = Gcs1*Gcsys1

%Unity feedback TF with both controller seperatly.
Gcl1 = feedback(G1,1)
Gcl2 = feedback(G2,1)
Gcl3 = feedback(G3,1)

%Step response analysis of both controllers for performance analysis

step(Gcl1,'red')
hold on
step(Gcl2,'green')
step(Gcl3,'blue')
legend("Standard controller","Cascaded with Inner P","Cascaded with inner PI")
hold off

% Performance information of all control scheme 
Normalcontroller = stepinfo(Gcl1)
cascadedwithP = stepinfo(Gcl2)
cascadedwithPI = stepinfo(Gcl3)
