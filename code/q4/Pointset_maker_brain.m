

    load('pointset_brain.mat');
    [x,y]=Pointset_brain(40);
    pointset(1,:,40)=x';
    pointset(2,:,40)=y';
    close all;
    save('pointset_brain.mat','pointset');

    