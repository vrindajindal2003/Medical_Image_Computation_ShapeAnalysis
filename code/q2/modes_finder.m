function [V,D] = modes_finder(mean_flattened,mean_,shapes)
  
    covariance_matrix = zeros(56*2,56*2);
    
    
    for i=1:40
        ptset_i = shapes(:,:,i)';
        ptset_i_aligned = align_pointset(mean_,ptset_i);
        shapes_aligned(:,:,i) = ptset_i_aligned';
    end
  %  x_aligned = shapes_aligned(1,:,:);
  %  x_aligned = reshape(x_aligned,56,40);
  %  x_mean = mean(x_aligned'); 
        
  %  y_aligned = shapes_aligned(2,:,:);
  %  y_aligned = reshape(y_aligned,56,40);
  %  y_mean = mean(y_aligned');
   % mean_mat = [x_mean',y_mean'];
    %mean_flattened = reshape(mean_mat,56*2,1);
    
    for i=1:40
      %  ptset_i = shapes(:,:,i)';
      % ptset_i_aligned = align_pointset(mean_,ptset_i);
        
   %     disp(size(ptset_i));
        ptset_i_aligned = shapes_aligned(:,:,i)'; 
        ptset_i_flattened = reshape(ptset_i_aligned,56*2,1);
        ptset_i_flattened = ptset_i_flattened - mean_flattened;
        covariance_matrix = covariance_matrix + ptset_i_flattened*ptset_i_flattened';
    
    end
    M = zeros(size(covariance_matrix));
    covariance_matrix = covariance_matrix/39;
    [V,M] = eig(covariance_matrix);
    D = sqrt(diag(M));
    
    %eigen = [V,D];

end