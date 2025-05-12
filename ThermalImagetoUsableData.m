%% Image t=0
% Load the thermal image
img = imread('Image34_1.png'); % Replace with your image path

% Convert to grayscale if it's RGB
if size(img, 3) == 3
    img = rgb2gray(img);
end

% Normalize pixel values to range [0, 1]
img_norm = mat2gray(img);

% Map normalized values to temperature range (example: 20°C to 100°C)
min_temp = 6;   % Minimum temperature in Celsius
max_temp = 266.6;  % Maximum temperature in Celsius
temperature_map_t0 = img_norm * (max_temp - min_temp) + min_temp;

% Define circle parameters
centerX = 356;   % X-coordinate of the circle center
centerY = 504;   % Y-coordinate of the circle center
radius = 1;     % Radius of the circle

% Create a meshgrid of coordinates
[rows, cols] = size(img);
[xGrid, yGrid] = meshgrid(1:cols, 1:rows);

% Create a mask for the circle
circleMask = (xGrid - centerX).^2 + (yGrid - centerY).^2 <= radius^2;

% Apply the mask and compute the average
pixelsInCircle = temperature_map_t0(circleMask);
averageValue_t0 = mean(pixelsInCircle)

% Display temperature map
figure;
imagesc(temperature_map_t0);
colorbar;
title('Thermal Image Temperature Map');
xlabel('X');
ylabel('Y');
caxis([min_temp max_temp]);
colormap('hot');
hold on
scatter(355,504, 'bx',"LineWidth",2)
visboundaries(circleMask, 'Color', 'r');


% Optional: Save temperature map to CSV
csvwrite('temperature_data_t0.csv', temperature_map_t0);

%% Image t=7s
% Load the thermal image
img = imread('Image_34_7s.png'); % Replace with your image path

% Convert to grayscale if it's RGB
if size(img, 3) == 3
    img = rgb2gray(img);
end

% Normalize pixel values to range [0, 1]
img_norm = mat2gray(img);

% Map normalized values to temperature range (example: 20°C to 100°C)
min_temp = 9.5;   % Minimum temperature in Celsius
max_temp = 249.4;  % Maximum temperature in Celsius
temperature_map_t7 = img_norm * (max_temp - min_temp) + min_temp;

% Define circle parameters
centerX = 354;   % X-coordinate of the circle center
centerY = 502;   % Y-coordinate of the circle center
radius = 1;     % Radius of the circle

% Create a meshgrid of coordinates
[rows, cols] = size(img);
[xGrid, yGrid] = meshgrid(1:cols, 1:rows);

% Create a mask for the circle
circleMask = (xGrid - centerX).^2 + (yGrid - centerY).^2 <= radius^2;

% Apply the mask and compute the average
pixelsInCircle = temperature_map_t7(circleMask)
averageValue_t7 = mean(pixelsInCircle)

% Display temperature map
figure;
imagesc(temperature_map_t7);
colorbar;
title('Thermal Image Temperature Map');
xlabel('X');
ylabel('Y');
caxis([min_temp max_temp]);
colormap('hot');
hold on
scatter(355, 504, 'bx',"LineWidth",2)
visboundaries(circleMask, 'Color', 'r');
csvwrite('temperature_data_t7.csv', temperature_map_t7);

%% Image 15s
% Load the thermal image
img = imread('Image_34_15s_345_500.png'); % Replace with your image path

% Convert to grayscale if it's RGB
if size(img, 3) == 3
    img = rgb2gray(img);
end

% Normalize pixel values to range [0, 1]
img_norm = mat2gray(img);

% Map normalized values to temperature range (example: 20°C to 100°C)
min_temp = 9.5;   % Minimum temperature in Celsius
max_temp = 253.9;  % Maximum temperature in Celsius
temperature_map_t15 = img_norm * (max_temp - min_temp) + min_temp;
% Define circle parameters
centerX = 345;   % X-coordinate of the circle center
centerY = 492;   % Y-coordinate of the circle center
radius = 1;     % Radius of the circle

% Create a meshgrid of coordinates
[rows, cols] = size(img);
[xGrid, yGrid] = meshgrid(1:cols, 1:rows);

% Create a mask for the circle
circleMask = (xGrid - centerX).^2 + (yGrid - centerY).^2 <= radius^2;

% Apply the mask and compute the average
pixelsInCircle = temperature_map_t15(circleMask);
averageValue_t15 = mean(pixelsInCircle)

% Display temperature map
figure;
imagesc(temperature_map_t15);
colorbar;
title('Thermal Image Temperature Map');
xlabel('X');
ylabel('Y');
caxis([min_temp max_temp]);
colormap('hot');
hold on
scatter(345, 492, 'bx',"LineWidth",2)
visboundaries(circleMask, 'Color', 'r');
csvwrite('temperature_data_t15.csv', temperature_map_t15);

%% t = 30
% Load the thermal image
img = imread('Image_34_30s_345_500.png'); % Replace with your image path

% Convert to grayscale if it's RGB
if size(img, 3) == 3
    img = rgb2gray(img);
end

% Normalize pixel values to range [0, 1]
img_norm = mat2gray(img);

% Map normalized values to temperature range (example: 20°C to 100°C)
min_temp = 8.6;   % Minimum temperature in Celsius
max_temp = 258.4;  % Maximum temperature in Celsius
temperature_map_t30 = img_norm * (max_temp - min_temp) + min_temp;

% Define circle parameters
centerX = 345;   % X-coordinate of the circle center
centerY = 492;   % Y-coordinate of the circle center
radius = 1;     % Radius of the circle

% Create a meshgrid of coordinates
[rows, cols] = size(img);
[xGrid, yGrid] = meshgrid(1:cols, 1:rows);

% Create a mask for the circle
circleMask = (xGrid - centerX).^2 + (yGrid - centerY).^2 <= radius^2;

% Apply the mask and compute the average
pixelsInCircle = temperature_map_t30(circleMask);
averageValue_t30 = mean(pixelsInCircle)
% Display temperature map
figure;
imagesc(temperature_map_t30);
colorbar;
title('Thermal Image Temperature Map');
xlabel('X');
ylabel('Y');
caxis([min_temp max_temp]);
colormap('hot');
hold on
scatter(345, 492, 'bx',"LineWidth",2)
visboundaries(circleMask, 'Color', 'r');
csvwrite('temperature_data_t30.csv', temperature_map_t30);
%% t= 45
% Load the thermal image
img = imread('Image_34_45s_345_500.png'); % Replace with your image path

% Convert to grayscale if it's RGB
if size(img, 3) == 3
    img = rgb2gray(img);
end

% Normalize pixel values to range [0, 1]
img_norm = mat2gray(img);

% Map normalized values to temperature range (example: 20°C to 100°C)
min_temp = 7.5;   % Minimum temperature in Celsius
max_temp = 256.9;  % Maximum temperature in Celsius
temperature_map_t45 = img_norm * (max_temp - min_temp) + min_temp;

% Define circle parameters
centerX = 345;   % X-coordinate of the circle center
centerY = 492;   % Y-coordinate of the circle center
radius = 1;     % Radius of the circle

% Create a meshgrid of coordinates
[rows, cols] = size(img);
[xGrid, yGrid] = meshgrid(1:cols, 1:rows);

% Create a mask for the circle
circleMask = (xGrid - centerX).^2 + (yGrid - centerY).^2 <= radius^2;

% Apply the mask and compute the average
pixelsInCircle = temperature_map_t45(circleMask);
averageValue_t45 = mean(pixelsInCircle)

% Display temperature map
figure;
imagesc(temperature_map_t45);
colorbar;
title('Thermal Image Temperature Map');
xlabel('X');
ylabel('Y');
caxis([min_temp max_temp]);
colormap('hot');
hold on
scatter(345, 492, 'bx',"LineWidth",2)
visboundaries(circleMask, 'Color', 'r');
csvwrite('temperature_data_t45.csv', temperature_map_t45);

%% t = 54, right before next layer
% Load the thermal image
img = imread('Image_34_54s_345_500.png'); % Replace with your image path

% Convert to grayscale if it's RGB
if size(img, 3) == 3
    img = rgb2gray(img);
end

% Normalize pixel values to range [0, 1]
img_norm = mat2gray(img);

% Map normalized values to temperature range (example: 20°C to 100°C)
min_temp = 6.6;   % Minimum temperature in Celsius
max_temp = 262.2;  % Maximum temperature in Celsius
temperature_map_t54 = img_norm * (max_temp - min_temp) + min_temp;

% Define circle parameters
centerX = 345;   % X-coordinate of the circle center
centerY = 490;   % Y-coordinate of the circle center
radius = 1;     % Radius of the circle

% Create a meshgrid of coordinates
[rows, cols] = size(img);
[xGrid, yGrid] = meshgrid(1:cols, 1:rows);

% Create a mask for the circle
circleMask = (xGrid - centerX).^2 + (yGrid - centerY).^2 <= radius^2;

% Apply the mask and compute the average
pixelsInCircle = temperature_map_t54(circleMask);
averageValue_t54 = mean(pixelsInCircle)

% Display temperature map
figure;
imagesc(temperature_map_t54);
colorbar;
title('Thermal Image Temperature Map');
xlabel('X');
ylabel('Y');
caxis([min_temp max_temp]);
colormap('hot');
hold on
scatter(345, 490, 'bx',"LineWidth",2)
visboundaries(circleMask, 'Color', 'r');
csvwrite('temperature_data_t54.csv', temperature_map_t54);

%% dT/dt

time = [0, 7, 15, 30, 45, 54];
temps = [temperature_map_t0(504,355), temperature_map_t7(504, 355), temperature_map_t15(497,355), temperature_map_t30(498,355), temperature_map_t45(498,355), temperature_map_t54(497,355)];

figure
scatter(time,temps,'filled')
% curveFitter