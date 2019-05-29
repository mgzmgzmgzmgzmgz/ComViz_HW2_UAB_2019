%Micah Giles


% HW2 CSx73 Computer Vision, Johnstone 19sp
% simulating the image processing pipeline on a raw image

% please use the following variable names for images at intermediate stages:
% raw:       raw image
% im_linear: linearized image
% im_zoom:   zoomed image showing Bayer pattern
% im_bggr, im_rggb, im_grbg, im_gbrg: brightened quarter-resolution RGB images
%                                     (for the 4 Bayer pattern candidates)
% im_gw, im_ww: white-balanced images under grey and white assumptions
% im_rgb:       demosaicked RGB image
% im_final:     final image

clear; close all; clc

% read the image (raw.tiff) as-is
% write its width, height, and type to the file 'hw2_x73sp19.txt'
% write its min and max values to the file
% display the image (before casting to double); use the title 'raw image'
% cast the image to double

raw = imread("/Users/micahgiles/Desktop/UAB_Spring_19/Computer_Vision/ComVis_HW2_Folder/raw.tiff");

[height, width] = size(raw);

img_type = class(raw);

max_raw = max(max(raw));
min_raw = min(min(raw));

imshow(raw);

raw_double = double(raw);

fileID = fopen('hw2_x73sp19.txt','w');
fprintf(fileID, 'Specs of the image for HW2\n\n');
fprintf(fileID, 'Height of the image: %f\n', height);
fprintf(fileID, 'Width of the image: %f\n', width);
fprintf(fileID, 'Type of the image: %f\n', img_type);
fprintf(fileID, 'Max of the image: %f\n', max_raw);
fprintf(fileID, 'Min of the image: %f\n', min_raw);

type hw2_x73sp19.txt

fprintf('Program paused. Press enter to continue.\n');
pause;

% -----------------------------------------------------------------------------
% linearize: map black to 0 and white to 1, then clamp to [0,1]

% display the new image with the title 'linearized'
% and write to 'linearized.jpg'

black = double(2047);
white = double(13584);

im_linear = raw_double;

im_linear(im_linear <= black) = 0;

im_linear(im_linear >= white) = 1;
im_linear(im_linear > 1) = im_linear(im_linear > 1)/(black + white);

imshow(im_linear)
title("linearized")
imwrite(im_linear,"linearized.jpg");

fprintf('Program paused. Press enter to continue.\n');
pause;

% -----------------------------------------------------------------------------
% 3. visualize the Bayer mosaic

% extract the 100x100 patch with top-right corner at (1000,1000)
% display a zoomed version of this image with the title
% 'visualizing the Bayer mosaic' and write to 'zoomed.jpg'


im_zoom = im_linear(1000:1099, 901:1000);
imwrite(im_zoom,'zoomed.jpg');
im_zoom = im_zoom * 5;
im_zoom(im_zoom > 1) = 1;

truesize([height,width]);
imshow(im_zoom);

title("'visualizing the Bayer mosaic'")


fprintf('Program paused. Press enter to continue.\n');
pause;

% -----------------------------------------------------------------------------
% 4. discover the Bayer pattern

% extract quarter-resolution images from the linearized image
% suggested variable names: top_left, top_right, bot_left, bot_right

% build 4 quarter-resolution RGB images, one per Bayer mosaic candidate
% hint: given a Bayer candidate, which subimage represents red? (draw a 2x2 box)

% display 4 brightened quarter-resolution RGB images, 
% labeled by their mosaic 4-tuple (e.g., bggr) in a 2x2 grid

% choose the best one for downstream processing (hint: use the shirt)
% write your chosen Bayer pattern choice to 'hw2_x73sp19.txt' and to the screen

% write the associated brightened quarter-resolution image to 'best_bayer.jpg'

%top_left = im_linear(1:2:end, 1:2:end); %Probably red
red = im_linear(1:2:end, 1:2:end); %Probably red

%top_right = im_linear(1:2:end, 2:2:end); %Probably green
green1 = im_linear(1:2:end, 2:2:end); %Probably green

%bot_left = im_linear(2:2:end, 1:2:end); %Probably green
green2 = im_linear(2:2:end, 1:2:end); %Probably green

%bot_right = im_linear(2:2:end, 2:2:end); %Probably blue
blue = im_linear(2:2:end, 2:2:end); %Probably blue

im_bggr = cat(3, blue, (green1+green2 / 2),  red);
imwrite(im_bggr,"im_bggr.jpg");

im_rggb = cat(3, red, (green1+green2 / 2),  blue);
imwrite(im_rggb,"im_rggb.jpg");

im_gbrg = cat(3, (green1+green2 / 2), blue, red);
imwrite(im_gbrg,"im_gbrg.jpg");

im_grbg = cat(3, (green1+green2 / 2), red, blue);
imwrite(im_grbg,"im_grbg.jpg");


truesize([height/5,width/5]);
subplot(2,2,1), imshow(4*im_bggr)
title("bggr")

subplot(2,2,2), imshow(4*im_rggb)
title("rggb")

subplot(2,2,3), imshow(4*im_gbrg)
title("gbrg")

subplot(2,2,4), imshow(4*im_grbg)
title("grbg")


fprintf(fileID, 'Using rgb as best option. \n');
fprintf('Using rggb as best option. \n');

fprintf('Program paused. Press enter to continue.\n');
pause;
% -----------------------------------------------------------------------------
% 5. white balance

% extract the red, blue, and green channels from the original Bayer mosaic
% (using your choice of the underlying Bayer pattern)

% white-balance the Bayer mosaic under the grey-world assumption:
% 1) find the mean of each channel
% 2) inject the white-balanced red/blue channels back into a new mosaic;
%    inject the original green channels (both of them) back too;
% call the new Bayer mosaic image im_gw 

% white-balance the Bayer mosaic using the white-world assumption:
% 1) find the maximum of each channel
% 2) inject back into a new mosaic called im_ww

% display the white-balanced images, with labels 'grey-world' and 'white-world',
% as a 2x1 grid;
% write them to 'grey_world.jpg' and 'white_world.jpg'

green = (green1 + green2)/2;

red_average = mean(mean(red));
blue_average = mean(mean(blue));
green_average = (mean(mean(green)));

red_max = max(max(red));
blue_max = max(max(blue));
green_max = max(max(green));

red_grey_world = red * (green_average / red_average);
blue_grey_world = blue * (green_average / blue_average);

red_white_world = red * (green_max / red_max);
blue_white_world = blue * (green_max / blue_max);


im_ww = cat(3, red_white_world, green, blue_white_world);
imwrite(im_ww,"white_world.jpg");

im_gw = cat(3, red_grey_world, green, blue_grey_world);
imwrite(im_gw,"grey_world.jpg");

subplot(2,1,1), imshow(4*im_ww)
title("white-world")
truesize([height/2,width/2]);

subplot(2,1,2), imshow(4*im_gw)
title("grey-world")
truesize([height/2,width/2]);

fprintf(fileID, 'Using grey-world option seems better than white-world. \n');
fclose(fileID);
fprintf('Using rggb as best option. \n');

fprintf('Using grey-world option seems better than white-world. \n');
pause;