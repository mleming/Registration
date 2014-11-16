function quantile_sum = sumOverQuantileDifferences( image1, image2 )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
quantile_sum = 0;
for x=1:size(image1,1)/4:size(image1,1)
    for y=1:size(image1,2)/4:size(image1,2)
        sub_image1 = image1(x:(x+size(image1,1)/4)-1,y:(y+size(image1,2)/4)-1);
        sub_image2 = image2(x:(x+size(image2,1)/4)-1,y:(y+size(image2,2)/4)-1);
        med_quant1 = quantile(sub_image1(:),0.5);
        med_quant2 = quantile(sub_image2(:),0.5);
        div_quant1 = quantile(sub_image1(:),0.7) - quantile(sub_image1(:),0.3);
        div_quant2 = quantile(sub_image2(:),0.7) - quantile(sub_image2(:),0.3);
        euclidean_distance = 0;
        for i=0:0.1:1
            q=0;
            if div_quant1 ~= 0 && div_quant2 ~= 0
                q = (quantile(sub_image1(:),i)-med_quant1)/div_quant1-(quantile(sub_image2(:),i)-med_quant2)/div_quant2;
            elseif div_quant1 ~=0
                q = (quantile(sub_image1(:),i)-med_quant1)/div_quant1;
            elseif div_quant2 ~= 0
                q = -(quantile(sub_image2(:),i)-med_quant1)/div_quant2;
            end
            euclidean_distance = euclidean_distance + abs(q)*0.1;
        end
        quantile_sum = quantile_sum + euclidean_distance;
    end
end

% Correction for estimations in registration
quantile_sum = - quantile_sum;
end

