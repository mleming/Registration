function mutual_info = mutualInfo( image1, image2 )
% Computes mutual information of two images. This function first normalizes
% all values to be between 1 and 1023 for each image before taking a joint
% histogram of both. This is used in computing their entropy, which is then
% used in computing a measure of mutual information.

% Normalize Images to values in between 1 and 1023
image1 = (image1 - min(image1(:)));
image1 = image1*(1022/max(image1(:)))+1;
image2 = (image2 - min(image2(:)));
image2 = image2*(1022/max(image2(:)))+1;

accumulative_values(:,1) = int16(image1(:));
accumulative_values(:,2) = int16(image2(:));

joint_histogram = accumarray(accumulative_values+1,1);
joint_histogram = joint_histogram./sum(joint_histogram(:));

image_1_margin = sum(joint_histogram,1);
image_2_margin = sum(joint_histogram,2);

image_1_entropy = -sum(image_1_margin.* log2(image_1_margin + (image_1_margin == 0)));
image_2_entropy = -sum(image_2_margin.* log2(image_2_margin + (image_2_margin == 0)));

images_squared = joint_histogram.*(log2(joint_histogram+(joint_histogram==0)));
mutual_info = image_1_entropy + image_2_entropy - sum(-images_squared(:));

end

