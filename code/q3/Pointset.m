function [x,y] = Pointset(i)
s = '../../data/leaf/data/leaf_';
    s = '../../data/leaf/data/leaf_';

    s = strcat(s,num2str(i));
    s = strcat(s,'.png');
    im = imread(s);
    imshow(im);
    [x,y]=getpts;
end