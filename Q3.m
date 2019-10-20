%set parameter
sigma = 1;
w = transpose([1,-0.15,-0.4825,0.144375]);
gamma = [10^-4,10^-3,10^-2,10^-1,1,10,100,1000,10000,100000,1000000];
error = zeros(11,100);bx = zeros(4,10);bxy = zeros(4,10);b2x = zeros(4,4,10);emapml = zeros(11,100);
for g = 1:11
    for i = 1:100
        v = normrnd(0,1,10,1);
        x = 2*rand(10,1)-1;
        for a = 1:4
            for b = 1:10
                bx(a,b) = x(b)^(4-a);
            end
        end
        for a = 1:10
            b2x(:,:,a) = bx(:,a)*bx(:,a)';
        end
        b2xsum = b2x(:,:,1)+b2x(:,:,2)+b2x(:,:,3)+b2x(:,:,4)+b2x(:,:,5)+b2x(:,:,6)+b2x(:,:,7)+b2x(:,:,8)+b2x(:,:,9)+b2x(:,:,10);
        for a = 1:10
            y(a) = w'* bx(:,a)+v(a);
        end
        for a = 1:10
            bxy(:,a) = bx(:,a)*y(a);
        end
        bxysum = bxy(:,1)+bxy(:,2)+bxy(:,3)+bxy(:,4)+bxy(:,5)+bxy(:,6)+bxy(:,7)+bxy(:,8)+bxy(:,9)+bxy(:,10);
        
        %MAP estimator
        wmap = inv(sigma^2/gamma(g)^2*eye(4)+b2xsum)*bxysum;
        wml = inv(b2xsum)*bxysum;
        %error(g,i) = (wmap(1)-w(1))^2+(wmap(2)-w(2))^2+(wmap(3)-w(3))^2+(wmap(4)-w(4))^2;
        
        % caculate error
        error(g,i) = sum(w-wmap).^2;
        emapml(g,i) = (wmap(1)-wml(1))^2+(wmap(2)-wml(2))^2+(wmap(3)-wml(3))^2+(wmap(4)-wml(4))^2;
        clear v x y wmap wml;
    end
end

%sort error and find min 25 50 75 max of error
error_s = sort(error,2);
error_min = error_s(:,1);
error_25 = error_s(:,25);
error_med = error_s(:,50);
error_75 = error_s(:,75);
error_max = error_s(:,100);

%plot
scatter(gamma,error_min,'ob'), hold on,
set(gca,'xscale','log')
set(gca,'yscale','log')
scatter(gamma,error_25,'oc'), hold on,
set(gca,'xscale','log')
set(gca,'yscale','log')
scatter(gamma,error_med,'om'), hold on,
set(gca,'xscale','log')
set(gca,'yscale','log')
scatter(gamma,error_75,'or'), hold on,
set(gca,'xscale','log')
set(gca,'yscale','log')
scatter(gamma,error_max,'ok'), hold on,
set(gca,'xscale','log')
set(gca,'yscale','log')

legend('Minimum Errors','25th Percentile Errors','Median Errors','75th Percentile Errors','Maximum Errors'), 
title('Squared Errors with Different Gammas'),
xlabel('gamma'), ylabel('Squared Errors')

