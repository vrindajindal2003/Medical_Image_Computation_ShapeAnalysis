function aligned = align_leaf_pointset(ptset1 , ptset2)
    x1_dash = ptset1(:,1);
    x2_dash = ptset2(:,1);
    x1_dash = x1_dash - mean(x1_dash);
    x2_dash = x2_dash - mean(x2_dash);
    
    y1_dash = ptset1(:,2);
    y1_dash = y1_dash - mean(y1_dash);
    y2_dash = ptset2(:,2);
    y2_dash = y2_dash - mean(y2_dash);
    
    a = (sum(x1_dash.*x2_dash) + sum(y1_dash.*y2_dash))/(sum(x2_dash.*x2_dash) + sum(y2_dash.*y2_dash));
    b = (sum(x2_dash.*y1_dash) - sum(x1_dash.*y2_dash))/(sum(x2_dash.*x2_dash) + sum(y2_dash.*y2_dash));

    rot_scaled_mat = [a -b ; b a];
    aligned_x2 = x2_dash*a -b*y2_dash;
    aligned_y2 = b*x2_dash + a*y2_dash;
    
    aligned = [aligned_x2,aligned_y2];  %returning 56,2 matrix after aligning set 2 to set 1.
end