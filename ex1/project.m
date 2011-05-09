clear;
load('object.mat');
close all;
% a)


X = cart2hom(X);
plot3(X(1,:),X(2,:),X(3,:), 'r.');
hold on;
pause;


% b)
T = [1, 0 , 0 , -22.9; 0,1,0, -7.1; 0, 0,1, -3.2; 0,0,0,1];

XT = T*X;


R45 =  rotmatrix(0,0,45);
XR = R45*XT;

R135 =  rotmatrix(0,135,0);
XR = R135*XR;

R30 =  rotmatrix(-30,0,0);
XR = R30*XR;

plot3(XR(1,:),XR(2,:),XR(3,:), 'b.');
hold on;
pause;

'these transformations are not commutative!'

TransM = R30*R135*R45*T;

Minv = inv(TransM);

'inverse tranformation matrix:'
Minv


%to test it
%XInv = Minv*XR;
%plot3(XInv(1,:),XInv(2,:),XInv(3,:), 'go');
%hold on;

f = 10;

PR = [f, 0,-1 , 0; 0, f, -5, 0; 0,0,1,0];


Xp = PR*X;
XRp = PR*XR;


XP = [Xp(1,:)./Xp(3,:);Xp(2,:)./Xp(3,:)];

XRP = [XRp(1,:)./XRp(3,:);XRp(2,:)./XRp(3,:)];

figure;

%plot(XP(1,:),XP(2,:) , 'r.');
%hold on;
plot(XRP(1,:),XRP(2,:), 'b.');

pause;

% c)

'Combined Projection and Transformation matrix:'
P = PR*TransM

Xp = hom2cart(P*X);


figure;

plot(Xp(1,:),Xp(2,:), 'r.');

pause;

'We get the same results'