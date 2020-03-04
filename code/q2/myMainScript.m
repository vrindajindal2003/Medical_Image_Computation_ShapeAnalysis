close all;
load('../../data/hand/data.mat')
x1 = shapes(1,:,5);
y1 = shapes(2,:,5);
x1 = reshape(x1,56,1);
y1 = reshape(y1,56,1);

x2 = shapes(1,:,2);
y2 = shapes(2,:,2);
x2 = reshape(x2,56,1);
y2 = reshape(y2,56,1);
figure(1);

%plotting unaligned data set
for i=1:40
    plot(shapes(1,:,i) , shapes(2,:,i) , 'color' , [rand rand rand]);
    title('Unaligned data set');
    hold on;
end

%plot(x1,y1,'blue')
%hold on;
%plot(x2,y2,'green')

mean_ = mean_finder(shapes);     % returns 56,2 matrix
 aligned_pt_set1 = zeros(2,56,40);
    for i=1:40
        pt_set1 = mean_;      
        pt_set2 = shapes(:,:,i)';
        aligned_pt_set1(:,:,i) = align_pointset(pt_set1 , pt_set2)';        %aligning all shapes to mean
    end
    figure(2);
    
   distance = zeros(40,1);
for i=1:40
    p = plot(mean_(:,1) , mean_(:,2) , 'color','black');
    p(1).LineWidth = 2;
     hold on;
    plot(aligned_pt_set1(1,:,i) , aligned_pt_set1(2,:,i) , 'color' , [rand rand rand])
    distance(i) = norm(aligned_pt_set1(:,:,i) - mean_');
   
end
title('Aligned data set along with mean(thick black');


    
figure(3);
%subplot(1,3,2);

plot(mean_(:,1) , mean_(:,2),'-o')
title('Mean with pointset');
mean_flattened = reshape(mean_ , 56*2 , 1) ;   %flatten to bring in preshape space
[eigen_vectors, eigen_values] = modes_finder(mean_flattened,mean_,shapes);
%eigen_vectors = eigen(1);
%eigen_values = eigen(2);
figure(4);

plot(real(eigen_values));
title('Eigenvalues');
prev_mode = mean_flattened - 3*eigen_values(112)*eigen_vectors(:,112);
next_mode = mean_flattened + 3*eigen_values(112)*eigen_vectors(:,112);
prev_mode = reshape(prev_mode , 56,2);
next_mode = reshape(next_mode , 56,2);
prev_mode = align_pointset(mean_,prev_mode);
next_mode = align_pointset(mean_,next_mode);
hold on;

figure(5);

subplot(3,3,2);

plot(mean_(:,1) , mean_(:,2),'-*');
title('First mode of variation')

subplot(3,3,1);
plot(prev_mode(:,1),prev_mode(:,2),'-*');

subplot(3,3,3);
plot(next_mode(:,1),next_mode(:,2) , '-*');

prev_mode_2 = mean_flattened - 3*eigen_values(111)*eigen_vectors(:,111);
next_mode_2 = mean_flattened + 3*eigen_values(111)*eigen_vectors(:,111);
prev_mode_2 = reshape(prev_mode_2 , 56,2);
next_mode_2 = reshape(next_mode_2 , 56,2);
prev_mode_2 = align_pointset(mean_,prev_mode_2);
next_mode_2 = align_pointset(mean_,next_mode_2);

%figure(6);

subplot(3,3,5);

plot(mean_(:,1) , mean_(:,2),'-*');
title('Second mode of variation');

subplot(3,3,4);
plot(prev_mode_2(:,1),prev_mode_2(:,2),'-*');

subplot(3,3,6);
plot(next_mode_2(:,1),next_mode_2(:,2),'-*');

prev_mode_3 = mean_flattened - 3*eigen_values(110)*eigen_vectors(:,110);
next_mode_3 = mean_flattened + 3*eigen_values(110)*eigen_vectors(:,110);
prev_mode_3 = reshape(prev_mode_3 , 56,2);
next_mode_3 = reshape(next_mode_3 , 56,2);
prev_mode_3 = align_pointset(mean_,prev_mode_3);
next_mode_3 = align_pointset(mean_,next_mode_3);

%figure(7);

subplot(3,3,8);

plot(mean_(:,1) , mean_(:,2),'-*');
title('Third mode of variation');

subplot(3,3,7);
plot(prev_mode_3(:,1),prev_mode_3(:,2),'-*');

subplot(3,3,9);
plot(next_mode_3(:,1),next_mode_3(:,2),'-*');

figure(8);
[M,I] = min(distance);
disp(I);
plot(mean_(:,1),mean_(:,2),'color','red');
hold on;
plot(aligned_pt_set1(1,:,I) , aligned_pt_set1(2,:,I),'color','blue');
legend('Mean','Closest');

distance2 = zeros(40,1);
distance3 = zeros(40,1);
for i=1:40
    distance2(i) = norm(prev_mode - align_pointset(prev_mode,shapes(:,:,i)'));
    distance3(i) = norm(next_mode - align_pointset(next_mode , shapes(:,:,i)'));
end

[M2 , i2] = min(distance2);
[M3 , i3] = min(distance3);

figure(9);
A = align_pointset(prev_mode,shapes(:,:,i2)');
B = align_pointset(next_mode , shapes(:,:,i3)');
plot(A(:,1) , A(:,2),'color','red');
hold on;
plot(prev_mode(:,1),prev_mode(:,2),'color','blue');
legend('Mean - first mode','Closest ');

figure(10);
plot(B(:,1) , B(:,2),'color','red');
hold on;
plot(next_mode(:,1) , next_mode(:,2),'color','blue');
legend('Mean + first mode','Closest');