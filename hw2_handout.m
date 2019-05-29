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

fprintf('Program paused. Press enter to continue.\n');
pause;
% -----------------------------------------------------------------------------
% linearize: map black to 0 and white to 1, then clamp to [0,1]

% display the new image with the title 'linearized'
% and write to 'linearized.jpg'

fprintf('Program paused. Press enter to continue.\n');
pause;
% -----------------------------------------------------------------------------
% 3. visualize the Bayer mosaic

% extract the 100x100 patch with top-right corner at (1000,1000)
% display a zoomed version of this image with the title
% 'visualizing the Bayer mosaic' and write to 'zoomed.jpg'

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

fprintf('Program paused. Press enter to continue.\n');
pause;
% -----------------------------------------------------------------------------
% 6. demosaicing [673/773 only]

% choose one of the white-balanced images, store in im, and work with im
% (so that you can easily shift white-balancing assumptions)

% build the red channel, using bilinear interpolation

% a) insert the existing red pixels directly
% b) ind the coordinates of the red pixels in the Bayer pattern
%   notes: standard geometric coords rather than image, in both input and output
%   and cannot use end;
%   hint: what are the dimensions of an image in conventional x and y,
%   which is what meshgrid expects
% c) insert the missing pixels using bilinear interpolation, 1/4 at a time


% build the blue channel, using bilinear interpolation

% build the green channel, using bilinear interpolation
% a) insert the existing green pixels directly
% b) find the coordinates of the green pixels in the Bayer pattern (two sets)
% c) insert the missing pixels using bilinear interpolation, 1/4 at a time:
%    compute both ways (using both available green pixels) and average them;
%    recall vectorized operators and that the average of two values is (a+b)/2;

% now that all channels are available, 
% build the 3-channel RGB image, called im_rgb

% write it to 'demosaicked.jpg', and display it, labeled 'demosaicked'
% display the red/green/blue channels and the rgb image in a 2x2 grid

fprintf('Program paused. Press enter to continue.\n');
pause;
% -----------------------------------------------------------------------------
% 7. brighten and gamma-correct

% convert to grayscale to discover max luminance
% scale (brighten) the image, capped by 1
% report the brightening factor to hw2_x73sp19.txt
% write to 'brightened.jpg' and display with title 'brightened'

fprintf('Program paused. Press enter to continue.\n');
pause;

% build a gamma corrected image
% display this final image with title 'final'
% write to final.png and final.jpg (which compresses)
% then find a minimal quality that is indistinguishable from uncompressed png
% and report this quality and its compression ratio to hw2_x73sp19.txt

% report your favourite white balancing algorithm to hw2_x73sp19.txt
% (after running pipeline both ways)
