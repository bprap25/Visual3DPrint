% --- Step 1: Load the video ---
videoFile = 'Truss_1.mp4';
v = VideoReader(videoFile);
numFrames = floor(v.Duration * v.FrameRate);
% --- Step 2: Select ROI interactively from a single frame ---
% Use the middle frame for clarity
frameNumForROI = round(3*numFrames/4);
frame = [];
% Read up to the selected frame
for i = 1:frameNumForROI
   frame = readFrame(v);
end
% Convert to grayscale if needed
if size(frame, 3) == 3
   frame = rgb2gray(frame);
end
% Show the frame and allow user to draw ROI
figure;
imshow(frame);
title('Draw ROI, then double-click inside it to confirm');
h = drawrectangle('Color', 'red');  % Interactive ROI tool
wait(h);  % Wait until user double-clicks
roiPos = round(h.Position);  % [x, y, width, height]
roi = roiPos;  % Save ROI for rest of processing
close;  % Close ROI selection window
% --- Step 3: Rewind video for main loop ---
v.CurrentTime = 0;
% Preallocate
roiTemps = zeros(numFrames, 1);
frameIdx = 1;
% --- Step 4: Process video using selected ROI ---
while hasFrame(v)
   frame = readFrame(v);
   if size(frame,3) == 3
       frame = rgb2gray(frame);
   end
   frame = double(frame);
   % Extract ROI
   x = roi(1); y = roi(2); w = roi(3); h = roi(4);
   roiFrame = frame(y:y+h-1, x:x+w-1);
   % Store mean temperature in ROI
   roiTemps(frameIdx) = mean(roiFrame(:), 'omitnan');
   frameIdx = frameIdx + 1;
end
% --- Step 5: Plot thermal trend ---
figure;
plot(roiTemps);
xlabel('Frame Number');
ylabel('Mean ROI Pixel Value');
title('Thermal Trend in Selected ROI');
