clc
clear all
close all

x= 0.1: 1/22 : 1;

y = ((1+0.6*sin(2*pi*x/0.7))+(0.3 * sin(2 * pi *x )));

figure(1)
plot(x,y)
grid("on")
%aprasomi svoriai
%1 sluoksnis
w11_1 = rand(1);
w21_1 = rand(1);
w31_1 = rand(1);
w41_1 = rand(1);
w51_1 = rand(1);
w61_1 = rand(1);
w71_1 = rand(1);
w81_1 = rand(1);

b1_1 = rand(1);
b2_1 = rand(1);
b3_1 = rand(1);
b4_1 = rand(1);
b5_1 = rand(1);
b6_1 = rand(1);
b7_1 = rand(1);
b8_1 = rand(1);

%2 sluoksnis
w11_2 = rand(1);
w12_2 = rand(1);
w13_2 = rand(1);
w14_2 = rand(1);
w15_2 = rand(1);
w16_2 = rand(1);
w17_2 = rand(1);
w18_2 = rand(1);

b1_2 = rand(1);

eta = 0.1;
Y = zeros(1,length(x));

for j=1:2000
    for i = 1:length(x)
        %Pasleptojo sluoksnio iejimai
        v1_1 = w11_1*x(i)+b1_1;
        v2_1 = w21_1*x(i)+b2_1;
        v3_1 = w31_1*x(i)+b3_1;
        v4_1 = w41_1*x(i)+b4_1;
        v5_1 = w51_1*x(i)+b5_1;
        v6_1 = w61_1*x(i)+b6_1;
        v7_1 = w71_1*x(i)+b7_1;
        v8_1 = w81_1*x(i)+b8_1;

        %Pasleptojo sluoksnio aktyvacijos funkcija
        y1_1 = tanh(v1_1);
        y2_1 = tanh(v2_1);
        y3_1 = tanh(v3_1);
        y4_1 = tanh(v4_1);
        y5_1 = tanh(v5_1);
        y6_1 = tanh(v6_1);
        y7_1 = tanh(v7_1);
        y8_1 = tanh(v8_1);

        %antras (isejimo sluoksnis)
        v1_2 = y1_1*w11_2 + y2_1*w12_2 + y3_1*w13_2 + y4_1*w14_2 + y5_1*w15_2 + y6_1*w16_2 + y7_1*w17_2 + y8_1*w18_2 + b1_2;

        %Isejimo sluoksnio aktyvacijos funkcija
        y1_2=v1_2;
        Y(i)=y1_2;

        %skaiciuojame klaida
        e=y(i) - y1_2;

        %svoriu atnaujinimas
        delta1_2=e;

        %pasleptojo sluoksnio klaidos gradientai
        delta1_1=(1-tanh(v1_1)^2)*delta1_2*w11_2;
        delta2_1=(1-tanh(v2_1)^2)*delta1_2*w12_2;
        delta3_1=(1-tanh(v3_1)^2)*delta1_2*w13_2;
        delta4_1=(1-tanh(v4_1)^2)*delta1_2*w14_2;
        delta5_1=(1-tanh(v5_1)^2)*delta1_2*w15_2;
        delta6_1=(1-tanh(v6_1)^2)*delta1_2*w16_2;
        delta7_1=(1-tanh(v7_1)^2)*delta1_2*w17_2;
        delta8_1=(1-tanh(v8_1)^2)*delta1_2*w18_2;

        %Atnaujinami svoriai
        %antras sluoksnis
        w11_2 = w11_2 + eta*delta1_2*y1_1;
        w12_2 = w12_2 + eta*delta1_2*y2_1;
        w13_2 = w13_2 + eta*delta1_2*y3_1;
        w14_2 = w14_2 + eta*delta1_2*y4_1;
        w15_2 = w15_2 + eta*delta1_2*y5_1;
        w16_2 = w16_2 + eta*delta1_2*y6_1;
        w17_2 = w17_2 + eta*delta1_2*y7_1;
        w18_2 = w18_2 + eta*delta1_2*y8_1;
        b1_2 = b1_2 + eta*delta1_2;

        %pasleptasis sluoksnis
        w11_1 = w11_1 + eta*delta1_1*x(i);
        w21_1 = w21_1 + eta*delta2_1*x(i);
        w31_1 = w31_1 + eta*delta3_1*x(i);
        w41_1 = w41_1 + eta*delta4_1*x(i);
        w51_1 = w51_1 + eta*delta5_1*x(i);
        w61_1 = w61_1 + eta*delta6_1*x(i);
        w71_1 = w71_1 + eta*delta7_1*x(i);
        w81_1 = w81_1 + eta*delta8_1*x(i);

        b1_1 = b1_1 + eta*delta1_1;
        b2_1 = b2_1 + eta*delta2_1;
        b3_1 = b3_1 + eta*delta3_1;
        b4_1 = b4_1 + eta*delta4_1;
        b5_1 = b5_1 + eta*delta5_1;
        b6_1 = b6_1 + eta*delta6_1;
        b7_1 = b7_1 + eta*delta7_1;
        b8_1 = b8_1 + eta*delta8_1;
    end
end

hold on
plot(x,Y)

legend('Target','Predicted','new data')



x_test= 0.1: 1/200 : 1;
y_test = ((1+0.6*sin(2*pi*x_test/0.7))+(0.3 * sin(2 * pi *x_test )));
Y_test = zeros(1,length(x_test));

for i = 1:length(x_test)
        %Pasleptojo sluoksnio iejimai 
        v1_1 = w11_1*x_test(i)+b1_1;
        v2_1 = w21_1*x_test(i)+b2_1;
        v3_1 = w31_1*x_test(i)+b3_1;
        v4_1 = w41_1*x_test(i)+b4_1;
        v5_1 = w51_1*x_test(i)+b5_1;
        v6_1 = w61_1*x_test(i)+b6_1;
        v7_1 = w71_1*x_test(i)+b7_1;
        v8_1 = w81_1*x_test(i)+b8_1;

        %Pasleptojo sluoksnio aktyvacijos funkcija
        y1_1 = tanh(v1_1);
        y2_1 = tanh(v2_1);
        y3_1 = tanh(v3_1);
        y4_1 = tanh(v4_1);
        y5_1 = tanh(v5_1);
        y6_1 = tanh(v6_1);
        y7_1 = tanh(v7_1);
        y8_1 = tanh(v8_1);

        %antras (isejimo sluoksnis)
        v1_2 = y1_1*w11_2 + y2_1*w12_2 + y3_1*w13_2 + y4_1*w14_2 + y5_1*w15_2 + y6_1*w16_2 + y7_1*w17_2 + y8_1*w18_2 + b1_2;
        Y_test(i)=v1_2;
end

plot(x_test,Y_test,'LineWidth',2)
legend('Target','Predicted','New input data')
