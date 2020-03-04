load('pointset.mat')
[x,y] = Pointset(75);
pointset(1,:,75) = x';
pointset(2,:,75) = y';
save('pointset.mat', 'pointset');
%Plotter(1);