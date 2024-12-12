clc
clear all
close all

x= 0.1: 1/22 : 1;

y = ((1+0.6*sin(2*pi*x/0.7))+(0.3 * sin(2 * pi *x )))/2;

[max1_10, idx1_10] = max(y(1:10));
x_at_max1_10 = x(idx1_10);  % Get the corresponding x value for the maximum

[max11_20, idx11_20] = max(y(11:20));
x_at_max11_20 = x(idx11_20+10);  % Get the corresponding x value for the maximum
c1 = x_at_max1_10;
c2 = x_at_max11_20;
r1 = 0.12;
r2 = 0.12;
% c1 = 0.5;
% c2 = 0.5;
% r1 = 0.5;
% r2 = 0.5;
% c1 = 0.2; 
% c2 = 0.9;
% r1 = 0.16; 
% r2 = 0.16;

RFB1 = exp(-(x-c1).^2./(2.*r1.^2));
RFB2 = exp(-(x-c2).^2./(2.*r2.^2));

figure(1)
nexttile
plot(x,y)
hold on
plot(x,RFB1)
plot(x,RFB2)
legend('Target','RFB1','RFB2')
hold off

%aprasomi svoriai
w11_2 = rand(1);
w12_2 = rand(1);
b1_2 = rand(1);
eta = 0.1;
eta_c = 0.1;
eta_r = 0.1;
Y = zeros(1,length(x));

for j = 1:1000
    for i = 1:length(x)
    % Gauso f-jos
    y1_1 = exp(-(x(i)-c1).^2./(2.*r1.^2));
    y2_1 = exp(-(x(i)-c2).^2./(2.*r2.^2));

    % pasvertoji suma isejimo neuronui
    v1_2 = w11_2*y1_1+w12_2*y2_1+ b1_2;
    y1_2 = v1_2;
    Y(i) = y1_2; 

    %Klaidos skaiciavimas ir svoriu atnaujinimas
    e(i) = y(i) - Y(i);

    % Gradients for c1, c2, r1, r2
    dc1 = (e(i) * w11_2 * y1_1 .* (x(i)-c1)) ./ (r1.^2);
    dc2 = (e(i) * w12_2 * y2_1 .* (x(i)-c2)) ./ (r2.^2);
    dr1 = (e(i) * w11_2 * y1_1 .* (x(i)-c1).^2) ./ (r1.^3);
    dr2 = (e(i) * w12_2 * y2_1 .* (x(i)-c2).^2) ./ (r2.^3);
       
    % Update parameters c1, c2, r1, r2
    w11_2 = w11_2 + eta * e(i) * y1_1;
    w12_2 = w12_2 + eta * e(i) * y2_1;
    b1_2  = b1_2  + eta * e(i);
    c1 = c1 + eta_c * dc1;
    c2 = c2 + eta_c * dc2;
    r1 = r1 + eta_r * dr1;
    r2 = r2 + eta_r * dr2;
    end
end
nexttile
hold on
plot(x,y)
plot(x,Y)
legend('Target','Predicted')

%testavimas
x_test= linspace(0.1,1,1000);
y_test = ((1+0.6*sin(2*pi*x_test/0.7))+(0.3 * sin(2 * pi *x_test )))/2;
Y_test = zeros(1,length(x_test));
for i = 1:length(x_test) 
    y1_1 = exp(-(x_test(i)-c1).^2./(2.*r1.^2));
    y2_1 = exp(-(x_test(i)-c2).^2./(2.*r2.^2));
    v1_2 = w11_2*y1_1+w12_2*y2_1+ b1_2;
    y1_2 = v1_2;
    Y_test(i) = y1_2; 
end
nexttile
plot(x,y)
hold on
plot(x_test,Y_test,'--','LineWidth',2)
legend('Target','new input data')