function [ ] = main ( )

load source.mat
for NoB=1:1
        disp('The value of N= ')
        NoB
    
     for p=4:4
        disp('The value of p=')
        p
N = length(x);
%Number of bits we are going to use

yy=x;
%Allocating memory
y = zeros(N,1);
y_hat_t = zeros(N,1);
y_hat = zeros(N,1);
y_t = zeros(N,1);
r = zeros(p, 1);
R = zeros(p, p);

%Calculating r
for i = 1:p
   r(i) = 1/(N - p) * sum(x(p+1:N).*x(p+1-i:N-i));
end

%Calculating R
for i = 1:p
   for j = 1:p
      R(i, j) =  1/(N - p + 1) * sum(x(p+1-j:N-j).*x(p+1-i:N-i));
   end
end

a = R\r;

aq = my_quantizer(a, 8, -2, 2);

y(1:p) = x (1:p);
y_hat(1:p) = my_quantizer(y(1:p), NoB, -3, 3);
y_hat_t(1:p) = y_t(1:p) + y_hat(1:p);


for i = p+1:N
y_t(i) = sum(aq(1:p).*y_hat_t(i-1:-1:i-p));
y(i) = x(i) - y_t(i);
y_hat(i) = my_quantizer(y(i), NoB, -3, 3);
y_hat_t(i) = y_t(i) + y_hat(i);
%disp('Predicted!')
end

%figure
%subplot(1,1,1)
% i=[1:10000];
%plot(i,x, 'g.-', i,y_hat_t, 'b.--');
%legend('the first signal: x', 'prediction:y_hat_t');
%xlabel('i');
% ylabel('');
% title('”ˆ‹ÎÏ· - p=32 & N=3 -');


disp('The value of p=')
p

%Calculating E_Y_2
E_y_2 = mean((yy - y_t).^2)
%disp('The value of E_y_2=')
E_y_2;

pause(10);
disp('-----------------')
    end
end
%N = [2 4 6];
%figure(3);
%plot( y_hat_t, 'r.-');

end
