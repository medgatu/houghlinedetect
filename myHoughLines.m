function [rhos, thetas] = myHoughLines(H, nLines)
%Your implemention here

%% amateur stuff
rhos = zeros(nLines, 1); 
thetas = zeros(nLines, 1); 
H_nms = H; % create copy of accumulator for non-maximal suppression
H_padded= padarray(H_nms, [1, 1], 0, 'both'); 
[m, n] = size(H_nms); % size of hough accumulator

%% non-maximal suppression for line detection
for i = 2:m-1 
    for j = 2:n-1
        if any(find((H_padded(i-1:i+1, j-1:j+1) > H_padded(i,j)))) > 0 % if any of the neighbors are greater than center pixel
            H_nms(i-1,j-1) = 0; % non-maximal suppression
        end
    end
end
%% find peaks in hough accumulator
for i = 1:nLines
    maxIdx = max(H_nms(:)); % highest score
    [rhoMaxIdx, thetaMaxIdx] = find(H_nms==maxIdx);
    rhos(i) = rhoMaxIdx(1); % 3 by 3 filter
    thetas(i) = thetaMaxIdx(1);
    H_nms(rhoMaxIdx(1), thetaMaxIdx(1)) = 0; 
end


end


