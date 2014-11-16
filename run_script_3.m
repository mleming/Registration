fixed_image = double(imread('scaledfixedimage.png'));

% Create moving images

gaussian_noise_distribution = normrnd(zeros(size(fixed_image)),10);
moving_image_1 = fixed_image + gaussian_noise_distribution;
moving_image_2 = fixed_image + 20 + gaussian_noise_distribution;
moving_image_3 = -fixed_image + 1100 + gaussian_noise_distribution;
moving_image_4 = zeros(size(fixed_image));
for x=1:size(fixed_image,1)
    factor = gaussmf(abs(x-size(fixed_image,1)),[300,size(fixed_image,1)/2]);
    for y=1:size(fixed_image,2)
        moving_image_4(x,y) = fixed_image(x,y)*factor;
    end
end
moving_image_4 = moving_image_4 + gaussian_noise_distribution;

registerX(fixed_image, moving_image_1, @sumOfSquaredIntensityDifferences)
registerX(fixed_image, moving_image_1, @sumOverMiddle)
registerX(fixed_image, moving_image_1, @sumOverQuantileDifferences)
registerX(fixed_image, moving_image_1, @mutualInfo)

registerX(fixed_image, moving_image_2, @sumOfSquaredIntensityDifferences)
registerX(fixed_image, moving_image_2, @sumOverMiddle)
registerX(fixed_image, moving_image_2, @sumOverQuantileDifferences)
registerX(fixed_image, moving_image_2, @mutualInfo)

registerX(fixed_image, moving_image_3, @sumOfSquaredIntensityDifferences)
registerX(fixed_image, moving_image_3, @sumOverMiddle)
registerX(fixed_image, moving_image_3, @sumOverQuantileDifferences)
registerX(fixed_image, moving_image_3, @mutualInfo)

registerX(fixed_image, moving_image_4, @sumOfSquaredIntensityDifferences)
registerX(fixed_image, moving_image_4, @sumOverMiddle)
registerX(fixed_image, moving_image_4, @sumOverQuantileDifferences)
registerX(fixed_image, moving_image_4, @mutualInfo)

