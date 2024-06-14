function segmentation=ICM(image,class_number,potential,maxIter)
    % Function to perform Image Segmentation using the Iterated Conditional Modes (ICM) algorithm
    % Inputs:
    %   image - input image to be segmented
    %   class_number - number of classes for segmentation
    %   potential - potential function for the Markov Random Field model
    %   maxIter - maximum number of iterations for the ICM algorithm
    % Output:
    %   segmentation - segmented image

    [width,height,bands]=size(image); % Get dimensions of the image
    image=imstack2vectors(image); % Convert image stack to vectors
    [segmentation,c]=kmeans(image,class_number); % Initial segmentation using k-means clustering
    clear c; % Clear the cluster centers

    iter=0; % Initialize iteration counter
    while(iter<maxIter)
        [mu,sigma]=GMM_parameter(image,segmentation,class_number); % Estimate parameters for Gaussian Mixture Model
        Ef=EnergyOfFeatureField(image,mu,sigma,class_number); % Calculate the energy of the feature field
        E1=EnergyOfLabelField(segmentation,potential,width,height,class_number); % Calculate the energy of the label field
        E=Ef+E1; % Total energy

        [~,segmentation]=min(E,[],2); % Update segmentation by finding the minimum energy
        iter=iter+1; % Increment iteration counter
    end