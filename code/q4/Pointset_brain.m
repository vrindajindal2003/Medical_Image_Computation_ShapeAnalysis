function [x,y] = Pointset_brain(i)
s = '../../data/brain/data/mri_image_';

    s = strcat(s,num2str(i));
    s = strcat(s,'.png');
    im = imread(s);
    imshow(im);
    [x,y]=getpts;
end