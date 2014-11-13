function diffsum = normCrossCoefficient( fixed,moving )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

fixed = double(fixed);
moving = double(moving);
fixed_mean = mean(fixed(:));
fixed_stddev = std2(fixed);
moving_mean = mean(moving(:));
moving_stddev = std2(moving);
size_t = size(fixed(:),1);

temp = 0;
for x=1:size(fixed,1)
    for y=1:size(fixed,2)
        temp = temp + (fixed(x,y)*moving(x,y));
    end
end
temp = temp/size_t;
diffsum = (temp - (moving_mean*fixed_mean))/(moving_stddev*fixed_stddev);

end

