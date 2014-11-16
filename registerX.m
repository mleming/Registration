function best_delta = registerX( fixed_image, moving_image, registration_function, starting_delta, register_1_data_0 )
% Registers moving_image to fixed_image in the horizontal x-direction
%   Registers an input 256x256 moving image to a 256x256 fixed image using 
%   the input registration function, a two-input function that measures
%   image mismatch values. If register_1_data_0 is 1, this registration is
%   performed at the first local peak that is found; if it is 0, it outputs
%   a graph of all image mismatch values along the image.


best_measure = -Inf;
best_delta = 0;
subimage = fixed_image(129:end-128,129:end-128);

%Three variables used in detecting peaks

current_measure = registration_function(subimage, moving_image(1:256,129:end-128));
previous_previous_measure = current_measure;
previous_measure = current_measure;
measures = [current_measure];

minima_found = 0;

if register_1_data_0 == 0
    starting_delta = 1
end

for delta_x = starting_delta:size(subimage,1)
    
    % Record the previous two measures
    previous_previous_measure = previous_measure;
    previous_measure = current_measure;
    
    % This is where the moving image is divided into subimages
    current_measure = registration_function(subimage, moving_image(129:end-128,1+delta_x:256+delta_x));
    
    % Record the measurements in a graph
    measures = [measures current_measure];
    
    % The function of this changes depending on whether this is doing
    % registration of data gathering.  In the first case, it finds the
    % peaks in the registration. In the second case, it finds the best
    % delta X.
    
    if register_1_data_0 == 1
        if (previous_previous_measure < previous_measure) && (previous_measure > current_measure)
            best_delta = delta_x;
            break;
        end
    else
        if current_measure > best_measure
            best_measure = current_measure;
            best_delta = delta_x;
        end
    end
end

% Output data. Measures are not plotted if this is simple registration.
if register_1_data_0 == 0
    figure,plot(measures);
end
figure,imshow((moving_image(129:end-128,1+best_delta:256+best_delta) + subimage)/(max(moving_image(:)) + max(subimage(:))));

end

