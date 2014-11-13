function diffsum = sumOverMiddle( fixed, moving )
% Takes the normalized cross correlation of one image over the other in 64x64 squares.
% Returns the sum of their squares.

% Get the values needed for NCC
fixed_mean = mean(fixed(:));
fixed_stddev = std2(fixed);
moving_mean = mean(moving(:));
moving_stddev = std2(moving);

% Just take the values needed for NCC and put them into an array. This is a
% time saver
mult_field = zeros(size(fixed));
for x=1:size(fixed,1)
    for y=1:size(fixed,2)
        mult_field(x,y) = (1/(65*65))*((fixed(x,y) - fixed_mean)*(moving(x,y)-moving_mean))/(fixed_stddev*moving_stddev);
    end
end

% Do the summations for the areas and multiply them here.
diffsum = 0;
for xm=34:size(moving,1)-32
    for ym=34:size(moving,2)-32
    	diffsum = diffsum + sum(sum(mult_field(xm-33:xm+32,ym-33:ym+32)))^2;
    end
end


end

