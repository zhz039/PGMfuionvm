function [E]=EnergyOfLabelField(segmentation,potential,width,height,class_number)
    % Function to calculate the energy of the label field in the ICM algorithm
    % Inputs:
    %   segmentation - current segmentation of the image
    %   potential - potential function for the Markov Random Field model
    %   width - width of the image
    %   height - height of the image
    %   class_number - number of classes for segmentation
    % Output:
    %   E - energy of the label field for each pixel and class

    n=size(segmentation,1); % Number of pixels in the segmentation
    segmentation=reshape(segmentation,[width height]); % Reshape segmentation to image dimensions
    Nei8=imstack2vectors(NeiX(segmentation)); % Get 8-neighborhood for each pixel and convert to vectors

    E=zeros(n,class_number); % Initialize energy matrix
    for i=1:class_number
        E(:,i)=sum(Nei8~=i,2); % Calculate energy for each class by counting mismatches in neighborhood
    end
    E=E*potential; % Multiply by potential function
end