function [H, rhoScale, thetaScale] = myHoughTransform(Im, threshold, rhoRes, thetaRes)
%Your implementation here
% Im - grayscale image
% threshold - avoid low gradient magn points
% rhoRes - resolution of rhos
% thetaRes - resolution of theta
%to find rho max, m are rows, n are columns

%% amateur stuff
[m,n] = size(Im);
rhomax = (sqrt(m^2 + n^2));
% convert radians to deg
thetadeg = thetaRes*(180/pi);
%range of parameters using rhomax for resolution and radians for theta
rhoScale = 0:rhoRes:ceil(rhomax);
thetaScale = 0:thetadeg:180;
%% accumulator
rholen = length(rhoScale);
thetalen = length(thetaScale);
H = zeros(rholen, thetalen); %initialize accumulator

%% find non zero indices of edges in image
for i = 1: 1: m
    for j = 1: 1: n
        if Im(i,j) > threshold 
            for theta = thetaScale
                rho_raw = (i*cos(theta) + j*sin(theta));
                if(rho_raw >= 0)
                    theta_target = floor(theta/thetadeg) +1;
                    rho_target = floor(rho_raw/rhoRes)+1;
                    H(rho_target, theta_target) = H(rho_target,theta_target) + 1;
                end
            end
        end
    end
end
end


        