function [img1] = myImageFilter(img0, h)

    img0 = im2double(img0);
    h = im2double(h);   
    %img1 = zeros(size(img0));
   
    [imrow, imcol, imdim] = size(img0);
    kernel = h;
    [hrow, hcol] = size(kernel);
    a = floor(hrow/2);
    b = floor(hcol/2);

    padded = padarray(img0, [a b], 0 ,'both');
    [rowp, colp] = size(padded);

    for i = 1+a:rowp-a
        for j=1+b:colp-b
            weightedSum = 0;
            for m=-a:a
                for n =-b:b
                    weightedSum = weightedSum+(kernel(m+a+1,n+b+1) * padded(i+m, j+n));
                end
            end
            % absolute value for finer detail output: x and y together
            img1(i-a,j-b) = abs(weightedSum);
        end
    end

end
