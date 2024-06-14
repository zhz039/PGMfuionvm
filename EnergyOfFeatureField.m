function [E]=EnergyOfFeatureField(image,mu,sigma,class_number)
    % Function to calculate the energy of the feature field in the ICM algorithm
    % Inputs:
    %   image - input image data as vectors
    %   mu - mean vectors for each class in the Gaussian Mixture Model
    %   sigma - covariance matrices for each class in the Gaussian Mixture Model
    %   class_number - number of classes for segmentation
    % Output:
    %   E - energy of the feature field for each pixel and class

    n=size(image,1); % Number of pixels in the image
    E=zeros(n,class_number); % Initialize energy matrix

    for i=1:class_number
        mu_i=mu(i,:); % Mean vector for class i
        sigma_i=sigma(:,:,i); % Covariance matrix for class i
        diff_i=image-repmat(mu_i,[n,1]); % Difference between image pixels and mean vector
        E(:,i)=sum(diff_i*inv(sigma_i).*diff_i,2)+log(det(sigma_i)); % Calculate energy for class i
    end
end