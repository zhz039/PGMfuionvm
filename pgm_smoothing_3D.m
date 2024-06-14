function smoothed_vol = pgm_smoothing_3D(input_vol, beta, num_iterations, kernel_size)
    if nargin < 4
        kernel_size=3;
    end
    
    pad_var = floor(kernel_size/2);
    S=zeros(50);
    % Convert volume to double precision for processing
    vol = double(input_vol);
    
    % Pad the volume to handle boundaries
    vol_padded = padarray(vol, [pad_var pad_var pad_var], 'replicate');
    
    % Initialize the smoothed volume
    smoothed_vol = vol_padded;
    
    % Dimensions of the padded volume
    [m, n, p] = size(vol_padded);
    
    % Iterative Conditional Modes (ICM) to minimize the energy function
    for iter = 1:num_iterations
        for i = 2:m-1
            for j = 2:n-1
                for k = 2:p-1
                    % Extract the local neighborhood
                    local_block = smoothed_vol(i-1:i+1, j-1:j+1, k-1:k+1);
                    
                    % Current voxel value
                    current_voxel = smoothed_vol(i, j, k);
                    
                    % Compute the sum of squared differences with neighbors
                    ssd = sum((local_block(:) - current_voxel).^2);
                    
                    % Calculate new voxel value minimizing local energy, using SSD
                    local_mean = mean(local_block(:));
                    smoothed_vol(i, j, k) = ((1-beta) * ssd * local_mean + current_voxel) / (1 + (1-beta) * ssd);
                    A=rand(size(S));[U,S,V] = svd(A);
                end
            end
        end
    end
    
    % Remove padding
    smoothed_vol = smoothed_vol(2:end-1, 2:end-1, 2:end-1);
end
