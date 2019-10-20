%set parameter
xt = sqrt(2)*rand-1;
yt = sqrt(2)*rand-1;
xi = [1,-1,0,0,1];
yi = [0,0,1,-1];
xi3 = [-1/2,-1/2];
yi3 = [sqrt(3)/2,-sqrt(3)/2];
sigmax = 0.25;
sigmay = 0.25;
sigmai = 0.3;
dti = zeros(1,6);
%generate ri
for i = 1:4
    dti(i) = sqrt((xi(i)-xt)^2+(yi(i)-yt)^2);
end
for i = 5:6
    dti(i) = sqrt((xi3(i-4)-xt)^2+(yi3(i-4)-yt)^2);
end

ri = zeros(1,6);
for i = 1:6
    while(ri(i) <= 0)
        ni = normrnd(0,0.3,1,1);
        ri(i) = dti(i) + ni;
    end
end

% MAP Estimator
xmap = linspace(-2,2,100);
ymap = linspace(-2,2,100);
[x,y] = meshgrid(xmap,ymap);
MAPK1 = -(ri(1) - sqrt((x(:)-xi(1)).^2+(y(:)-yi(1)).^2)).^2/0.09 - x(:).^2/0.25/0.25 - y(:).^2/0.25/0.25;
MAPK2 = -(ri(1) - sqrt((x(:)-xi(1)).^2+(y(:)-yi(1)).^2)).^2/0.09 - x(:).^2/0.25/0.25 - y(:).^2/0.25/0.25 - (ri(2) - sqrt((x(:)-xi(2)).^2+(y(:)-yi(2)).^2)).^2/0.09;
MAPK4 = -(ri(1) - sqrt((x(:)-xi(1)).^2+(y(:)-yi(1)).^2)).^2/0.09 - x(:).^2/0.25/0.25 - y(:).^2/0.25/0.25 - (ri(2) - sqrt((x(:)-xi(2)).^2+(y(:)-yi(2)).^2)).^2/0.09 - (ri(3) - sqrt((x(:)-xi(3)).^2+(y(:)-yi(3)).^2)).^2/0.09 - (ri(4) - sqrt((x(:)-xi(4)).^2+(y(:)-yi(4)).^2)).^2/0.09;
MAPK3 = -(ri(1) - sqrt((x(:)-xi(1)).^2+(y(:)-yi(1)).^2)).^2/0.09 - x(:).^2/0.25/0.25 - y(:).^2/0.25/0.25 - (ri(5) - sqrt((x(:)-xi3(1)).^2+(y(:)-yi3(1)).^2)).^2/0.09 - (ri(6) - sqrt((x(:)-xi3(2)).^2+(y(:)-yi3(2)).^2)).^2/0.09;
MAP1 = reshape(MAPK1,100,100);
MAP2 = reshape(MAPK2,100,100);
MAP3 = reshape(MAPK3,100,100);
MAP4 = reshape(MAPK4,100,100);

%plot contour
figure(1);
figure(1),scatter(xi(1),yi(1),'ob'), hold on,
figure(1),scatter(xt,yt,'+g'), hold on
figure(1),contour(xmap,ymap,MAP1,20,'showtext','on'); 
legend('Reference Points','True Point','MAP'), 
title('MAP Estimator Contour'),
xlabel('x'), ylabel('y')

figure(2);
figure(2),scatter(xi(1),yi(1),'ob'), hold on,
figure(2),scatter(xi(2),yi(2),'ob'), hold on,
figure(2),scatter(xt,yt,'+g'), hold on
figure(2),contour(xmap,ymap,MAP2,'showtext','on'); 
legend('Reference Point','Reference Points','True Point','MAP'), 
title('MAP Estimator Contour'),
xlabel('x'), ylabel('y')

figure(3);
figure(3),scatter(xi(1),yi(1),'or'), hold on,
figure(3),scatter(xi3(1),yi3(1),'or'), hold on,
figure(3),scatter(xi3(2),yi3(2),'or'), hold on,
figure(3),scatter(xt,yt,'+g'), hold on
figure(3),contour(xmap,ymap,MAP3,'showtext','on'); 
legend('Reference Point','Reference Point','Reference Points','True Point','MAP'), 
title('MAP Estimator Contour'),
xlabel('x'), ylabel('y')

figure(4);
figure(4),scatter(xi(1),yi(1),'or'), hold on,
figure(4),scatter(xi(2),yi(2),'or'), hold on,
figure(4),scatter(xi(3),yi(3),'or'), hold on,
figure(4),scatter(xi(4),yi(4),'or'), hold on,
figure(4),scatter(xt,yt,'+g'), hold on
figure(4),contour(xmap,ymap,MAP4,20,'showtext','on'); 
legend('Reference Point','Reference Point','Reference Point','Reference Point','True Point','MAP'), 
title('MAP Estimator Contour'),
xlabel('x'), ylabel('y')

