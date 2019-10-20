m(:,1) = [-1;0]; Sigma(:,:,1) = 0.1*[10 -4;-4,5]; % mean and covariance of data pdf conditioned on label 3
m(:,2) = [1;0]; Sigma(:,:,2) = 0.1*[5 0;0,2]; % mean and covariance of data pdf conditioned on label 2
m(:,3) = [0;1]; Sigma(:,:,3) = 0.1*eye(2); % mean and covariance of data pdf conditioned on label 1
classPriors = [0.15,0.35,0.5]; thr = [0,cumsum(classPriors)];
N = 10000; u = rand(1,N); L = zeros(1,N); x = zeros(2,N);p = zeros(3,10000);d = zeros(1,N);a=0;
figure(1),clf, colorList = 'rbg';
for l = 1:3
    indices = find(thr(l)<=u & u<thr(l+1));
    disp('actual number of samples of each class is')
    disp(length(indices));
    L(1,indices) = l*ones(1,length(indices));
    x(:,indices) = mvnrnd(m(:,l),Sigma(:,:,l),length(indices))';
    figure(1), plot(x(1,indices),x(2,indices),'.','MarkerFaceColor',colorList(l)); axis equal, hold on,
end
figure(2),clf;
T1=0;T2=0;T3=0;F1=0;F2=0;F3=0;%number of true and false
for i = 1:N
    for j = 1:3
        p(j,i) = (2*pi)^(-1)*det(Sigma(:,:,j))^(0-1/2)*exp(0-1/2*(x(:,i)-m(:,j))'*inv(Sigma(:,:,j))*(x(:,i)-m(:,j)))*classPriors(j);%likelyhood * piror
        if max(p(:,i)) == p(j,i)% when p is max
            d(1,i) = j;
        end
    end
    if d(1,i) == L(1,i) && L(1,i) == 1
        T1 =T1+1;
    end
    if d(1,i) == L(1,i) && L(1,i) == 2
        T2 =T2+1;
    end
    if d(1,i) == L(1,i) && L(1,i) == 3
        T3 =T3+1;
    end
    if d(1,i) ~= L(1,i) && L(1,i) == 1
        F1 =F1+1;
    end
    if d(1,i) ~= L(1,i) && L(1,i) == 2
        F2 =F2+1;
    end
    if d(1,i) ~= L(1,i) && L(1,i) == 3
        F3 =F3+1;
    end
    
end
a=1;R1 = zeros(1,T1);R2 = zeros(1,T2);R3 = zeros(1,T3);FA1 = zeros(1,F1);FA2 = zeros(1,F2);FA3 = zeros(1,F3);
for i = 1:10000
    if d(1,i)==L(1,i)&&L(1,i)==1
        R1(a) = i;
        a=a+1;
    end
end
a=1;
for i = 1:10000
    if d(1,i)==L(1,i)&&L(1,i)==2
        R2(a) = i;
        a=a+1;
    end
end
a=1;
for i = 1:10000
    if d(1,i)==L(1,i)&&L(1,i)==3
        R3(a) = i;
        a=a+1;
    end
end
a=1;
for i = 1:10000
    if d(1,i)~=L(1,i)&&L(1,i)==1
        FA1(a) = i;
        a=a+1;
    end
end
a=1;
for i = 1:10000
    if d(1,i)~=L(1,i)&&L(1,i)==2
        FA2(a) = i;
        a=a+1;
    end
end
a=1;
for i = 1:10000
    if d(1,i)~=L(1,i)&&L(1,i)==3
        FA3(a) = i;
        a=a+1;
    end
end
figure(2), plot(x(1,R1),x(2,R1),'g.'); axis equal, hold on,
figure(2), plot(x(1,R2),x(2,R2),'gx'); axis equal, hold on,
figure(2), plot(x(1,R3),x(2,R3),'g+'); axis equal, hold on,
figure(2), plot(x(1,FA1),x(2,FA1),'r.'); axis equal, hold on,
figure(2), plot(x(1,FA2),x(2,FA2),'rx'); axis equal, hold on,
figure(2), plot(x(1,FA3),x(2,FA3),'r+'); axis equal, hold on,
TE = F1+F2+F3;
PE = TE/N;% probability of error = number of false/N
disp('probability of error is')
disp(PE);

ind11 = find(d==1 & L==1); n11 = length(ind11);  
ind12 = find(d==1 & L==2); n12 = length(ind12);
ind13 = find(d==1 & L==3); n13 = length(ind13);
ind21 = find(d==2 & L==1); n21 = length(ind21);
ind22 = find(d==2 & L==2); n22 = length(ind22);
ind23 = find(d==2 & L==3); n23 = length(ind23);
ind31 = find(d==3 & L==1); n31 = length(ind31);
ind32 = find(d==3 & L==2); n32 = length(ind32);
ind33 = find(d==3 & L==3); n33 = length(ind33);

conmat = [n11 n12 n13; n21 n22 n23; n31 n32 n33];
disp('confusion matrix is')
disp(conmat);

