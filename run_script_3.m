% Matthew Leming
% COMP 775, Fall 2014, Pizer
% This program generates four moving images from the fixed scalar image and
% uses a horizontal registration program to register them to the original
% moving image. Run this script to output everything

fixed_image = double(imread('images/scaledfixedimage.png'));

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


% Register all images or look at their mismatch values at all points along
% the image?
register_1_data_0 = 1;

% Where to begin the registration at?
start_delta = 28;

% Perform Registrations
registerX(fixed_image, moving_image_1, @sumOfSquaredIntensityDifferences,start_delta,register_1_data_0)
registerX(fixed_image, moving_image_1, @sumOverMiddle,start_delta,register_1_data_0)
registerX(fixed_image, moving_image_1, @sumOverQuantileDifferences,start_delta,register_1_data_0)
registerX(fixed_image, moving_image_1, @mutualInfo,start_delta,register_1_data_0)

registerX(fixed_image, moving_image_2, @sumOfSquaredIntensityDifferences,start_delta,register_1_data_0)
registerX(fixed_image, moving_image_2, @sumOverMiddle,start_delta,register_1_data_0)
registerX(fixed_image, moving_image_2, @sumOverQuantileDifferences,start_delta,register_1_data_0)
registerX(fixed_image, moving_image_2, @mutualInfo,start_delta,register_1_data_0)

registerX(fixed_image, moving_image_3, @sumOfSquaredIntensityDifferences,start_delta,register_1_data_0)
registerX(fixed_image, moving_image_3, @sumOverMiddle,start_delta,register_1_data_0)
registerX(fixed_image, moving_image_3, @sumOverQuantileDifferences,start_delta,register_1_data_0)
registerX(fixed_image, moving_image_3, @mutualInfo,start_delta,register_1_data_0)

registerX(fixed_image, moving_image_4, @sumOfSquaredIntensityDifferences,start_delta,register_1_data_0)
registerX(fixed_image, moving_image_4, @sumOverMiddle,start_delta,register_1_data_0)
registerX(fixed_image, moving_image_4, @sumOverQuantileDifferences,start_delta,register_1_data_0)
registerX(fixed_image, moving_image_4, @mutualInfo,start_delta,register_1_data_0)

