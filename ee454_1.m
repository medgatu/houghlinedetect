kernelsize = 10;
sigma = 5;
h = fspecial('gaussian',kernelsize, sigma);
% also can use surface(h)
mesh(h);
imagesc(h);
outim = imfilter(im,h); 
imshow(outim);

