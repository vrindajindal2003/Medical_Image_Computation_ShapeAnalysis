function mean_pt_set = mean_leaf_finder(pt_set)
    no_of_shapes = 75;
    r = 1;         %generate a random number from 1-40.
    mean_pt_set = pt_set(:,:,r)';   %choose current mean as dataset with index r
    last_mean = mean_pt_set;        %set last mean
   
    aligned_pt_set1 = zeros(2,32,75);
  % while(diff > 0.1) 
  for j=1:15                 %Currently working with 5 iterations of algorithm
    for i=1:no_of_shapes
        pt_set1 = mean_pt_set;      
        pt_set2 = pt_set(:,:,i)';
        aligned_pt_set1(:,:,i) = align_leaf_pointset(pt_set1 , pt_set2)';        %aligning all shapes to mean
    end

    x_aligned = aligned_pt_set1(1,:,:);
    x_aligned = reshape(x_aligned,32,75);
    
    y_aligned = aligned_pt_set1(2,:,:);
    y_aligned = reshape(y_aligned,32,75);
    
    
    x_mean = mean(x_aligned');      
    y_mean = mean(y_aligned');
    
    mean_pt_set = [x_mean',y_mean'];    %new mean
    mean_pt_set = mean_pt_set/norm(mean_pt_set);    %scaled to bring norm = 1
    
    %plot(mean_pt_set(:,1) , mean_pt_set(:,2));
    z_mean = align_leaf_pointset(last_mean , mean_pt_set);   %to check how much mean converges to last mean
    diff = norm(last_mean - z_mean);
    disp(diff);
    last_mean = mean_pt_set;
    
  end
    
    
    
    
    
end