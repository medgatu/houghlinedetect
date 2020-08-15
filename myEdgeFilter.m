function [img1] = myEdgeFilter(img0, sigma)
%Your implemention
%% gaussian filter
h = fspecial('gaussian', 2*ceil(3*sigma)+1, sigma);
img_smooth = myImageFilter(img0,h);
%% sobel filter in x and y direction
sobel_y = [1 2 1; 0 0 0; -1 -2 -1];
sobel_x = [[1 2 1]' [0 0 0]' [-1 -2 -1]'];

%% convolved smoothed image with x and y oriented sobel filter
imgx = myImageFilter(img_smooth, sobel_x);
imgy = myImageFilter(img_smooth, sobel_y);

%% convert to double
imgx = im2double(imgx);
imgy = im2double(imgy);

%% smoothed imaged output into x and y
[row, col] = size(img_smooth)

%% empty array for storage allocation
Im = zeros([row col]);
Io = zeros([row col]);

%% padding
imgx_pad = padarray(imgx, [1,1],0,'both');
imgy_pad = padarray(imgy, [1,1],0,'both');

%% logic
for i=1:row
    for j=1:col
        Im(i,j) = sqrt( (imgx_pad(i,j)^2) + (imgy_pad(i,j)^2) );
        if(imgy_pad(i,j) == 0)
            Io(i,j) = 0;
        else
            Io(i,j) = atand( abs(imgy_pad(i,j)) / abs(imgx_pad(i,j)) );
        end
    end
end

%% open resources from here used to help me with angles
for i=1:row
    for j=1:col
        if((Io(i,j) >= 0 && Io(i,j) <= 15) || (Io(i,j) >= 165 && Io(i,j) <= 180))
            if(i==1)
                if(Im(i,j)>Im(i+1,j))
                    Im(i,j) = 0;
                end
            elseif (i == size(Im,1))
                    if (Im(i,j)>Im(i-1,j))
                        Im(i,j) = 0;
                    end
            else
                if((Im(i,j)>Im(i+1,j))&&(Im(i,j)>Im(i-1,j)))
                    Im(i,j) = 0;
                end
            end
        
        elseif((Io(i,j) >= 75) && (Io(i,j)<=105))
            if(j==1)
                if(Im(i,j)>Im(i,j+1))
                    Im(i,j) = 0;
                end
            elseif (j == size(Im,2))
                if (Im(i,j)>Im(i,j-1))
                    Im(i,j) = 0;
                end
            else
                if((Im(i,j)>Im(i,j+1))&&(Im(i,j)>Im(i,j-1)))
                    Im(i,j) = 0;
                end
            end

        
        elseif((Io(i,j) >= 30) && (Io(i,j) <= 60))
            if(j==1) 
               if(i == size(Im,1))
                   continue;
               elseif(Im(i,j)>Im(i+1,j+1))
                       Im(i,j) = 0;
                    
                end
            elseif (j == size(Im,2))
                if(i == 1)
                    continue;
                elseif(Im(i,j)>Im(i-1,j-1))
                         Im(i,j) = 0;
                end
                
            else
                 if(i == 1)
                     if(Im(i,j) > Im(i+1,j+1))
                         Im(i,j) = 0;
                     end
                 elseif(i == size(Im,1))
                        if(Im(i,j) > Im(i-1,j-1))
                            Im(i,j) = 0;
                        end 
                  else
                        if((Im(i,j)>Im(i+1,j+1))&&(Im(i,j)>Im(i-1,j-1)))
                            Im(i,j) = 0;
                        end
                 end
                end
        elseif((Io(i,j) <= 150) && (Io(i,j) >= 120))
               if(j==1) 
                   if(i == 1)
                        continue;
                   elseif(Im(i,j)>Im(i-1,j+1))
                           Im(i,j) = 0;
                        end
                    
               elseif (j == size(Im,2))
                        if(i == size(Im,1))
                            continue;
                        elseif(Im(i,j)>Im(i+1,j-1))
                                 Im(i,j) = 0;
                            end
                        
                    else
                         if(i == 1)
                             if(Im(i,j) > Im(i+1,j-1))
                                 Im(i,j) = 0;
                             end
                         elseif(i == size(Im,1))
                                if(Im(i,j) > Im(i-1,j+1))
                                    Im(i,j) = 0;
                                end 
                              else
                                if((Im(i,j)>Im(i-1,j+1))&&(Im(i,j)>Im(i+1,j-1)))
                                    Im(i,j) = 0;
                                end
                             end
                         end
                    end
               end
               
end
 img1 = Im
 imshow(imgx);
 figure();
 imshow(imgy);
 
end
 