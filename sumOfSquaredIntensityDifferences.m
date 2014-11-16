function diffsum = sumOfSquaredIntensityDifferences( image1, image2 )
% Computes the sum of squared intensities between two input images
    diffsum = - sum((int16(image1(:)) - int16(image2(:))).^2);
end