function best_delta = registerX( fixed_image, moving_image, registration_function )
% Registers moving_image to fixed_image in the horizontal x-direction
%   Detailed explanation goes here

best_measure = -Inf;
best_delta = 0;
subimage = fixed_image(129:end-128,129:end-128);
previous_measure = 0;
current_measure = registration_function(subimage, moving_image(1:256,129:end-128));
measures = [current_measure];
for delta_x = 1:size(subimage,1)
    previous_measure = current_measure;
    current_measure = registration_function(subimage, moving_image(129:end-128,1+delta_x:256+delta_x));
    measures = [measures current_measure];
    if current_measure > best_measure
        best_measure  = current_measure;
        best_delta = delta_x;
    end
end
figure,plot(measures);
figure,imshow((moving_image(129:end-128,1+best_delta:256+best_delta) + subimage)/(max(moving_image(:)) + max(subimage(:))));



end

