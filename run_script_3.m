fixed_image = double(imread('scaledfixedimage.png'));

G = fspecial('gaussian', [10 10], 10);
gaussian_distribution = imfilter(fixed_image,G,'same');
moving_image_1 = fixed_image + gaussian_distribution;
moving_image_2 = fixed_image + 20 + gaussian_distribution;
moving_image_3 = -fixed_image + 1100 + gaussian_distribution;
best_measure = -Inf;
best_delta = 0;
subimage = moving_image_2(129:end-128,129:end-128);
previous_measure = 0;
current_measure = sumOverMiddle(subimage, moving_image_1(1:256,129:end-128))
measures = [current_measure];
for delta_x = 1:size(subimage,1)
    previous_measure = current_measure;
    current_measure = sumOverMiddle(subimage, moving_image_1(129:end-128,1+delta_x:256+delta_x))
    measures = [measures current_measure];
    if current_measure > best_measure
        best_measure  = current_measure;
        best_delta = delta_x
%         figure;
%         imshow(subimage/max(subimage(:)))
%         figure;
%         imshow(moving_image_1(129:end-128,1+delta_x:256+delta_x)/max(moving_image_1(:)))
%         figure;
%         imshow((moving_image_1(129:end-128,1+delta_x:256+delta_x) + subimage)/(max(moving_image_1(:)) + max(subimage(:))));
    end
end
plot(measures);
best_delta
previous_measure;
delta_x;
imshow((moving_image_1(129:end-128,1+111:256+111) + subimage)/(max(moving_image_1(:)) + max(subimage(:))));