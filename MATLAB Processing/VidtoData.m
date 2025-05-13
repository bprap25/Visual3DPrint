% --- Step 1: List all video files ---
videoFiles = {'FlexCon_36_1.mp4', 'FlexCon_36_2.mp4', 'FlexCon_36_3.mp4', 'FlexCon_36_4.mp4','FlexCon_36_5.mp4'};
% --- Step 3: Load a frame from the middle of the first video for ROI selection ---
v = VideoReader(videoFiles{1});
frameNumForROI = round(9.3 * floor(v.Duration * v.FrameRate) / 10);
for i = 1:frameNumForROI
   frame = readFrame(v);
end
if size(frame, 3) == 3
   frame = rgb2gray(frame);
end
figure;
imshow(frame);
title('Draw ROI 1, then double-click inside it');
h1 = drawrectangle('Color', 'red');
wait(h1);
roi1_FC_36 = round(h1.Position);
title('Draw ROI 2, then double-click inside it');
h2 = drawrectangle('Color', 'blue');
wait(h2);
roi2_FC_36 = round(h2.Position);
close;
% --- Step 4: Initialize result arrays ---
roi1Temps_FC_36 = [];
roi2Temps_FC_36 = [];
timeVec = [];
% --- Step 5: Process each video file ---
currentTime = 0;
for fileIdx = 1:length(videoFiles)
   v = VideoReader(videoFiles{fileIdx});
   numFrames = floor(v.Duration * v.FrameRate);
  
   for frameIdx = 1:numFrames
       if ~hasFrame(v), break; end
       frame = readFrame(v);
       % Convert to grayscale
       if size(frame, 3) == 3
           frame = rgb2gray(frame);
       end
       frame = double(frame);
       % --- Dynamic scaling for this frame ---
       pixelMin = min(frame(:));
       pixelMax = max(frame(:));
       Tmax = maxTemps_FC_36(frameIdx);
       Tmin = minTemps_FC_36(frameIdx);
       if pixelMax == pixelMin
           frameTemp = ones(size(frame)) * Tmin;
       else
           frameTemp = (frame - pixelMin) / (pixelMax - pixelMin) * (Tmax - Tmin) + Tmin;
       end
       % --- ROI 1 ---
       x1 = roi1_FC_36(1); y1 = roi1_FC_36(2); w1 = roi1_FC_36(3); h1 = roi1_FC_36(4);
       roiFrame1 = frameTemp(y1:y1+h1-1, x1:x1+w1-1);
       roi1Temps_FC_36(end+1, 1) = mean(roiFrame1(:), 'omitnan');
       % --- ROI 2 ---
       x2 = roi2_FC_36(1); y2 = roi2_FC_36(2); w2 = roi2_FC_36(3); h2 = roi2_FC_36(4);
       roiFrame2 = frameTemp(y2:y2+h2-1, x2:x2+w2-1);
       roi2Temps_FC_36(end+1, 1) = mean(roiFrame2(:), 'omitnan');
       % --- Append time vector ---
       timeVec(end+1, 1) = currentTime;
       currentTime = currentTime + 1 / v.FrameRate;
   end
end
% --- Step 6: Plot combined temperature data ---
figure;
plot(timeVec, roi1Temps_FC_36, 'r', 'DisplayName', 'ROI 1');
hold on;
plot(timeVec, roi2Temps_FC_36, 'b', 'DisplayName', 'ROI 2');
xlabel('Time (seconds)');
ylabel('Mean Temperature (°C)');
title('Thermal Trends Across Combined Videos');
legend;
grid on;
%% CSV
% Combine data into a table
T = table(timeVec, roi1Temps_FC_36, roi2Temps_FC_36, maxTemps_FC_36, minTemps_FC_36, ...
   'VariableNames', {'Time_s', 'ROI1_Temp', 'ROI2_Temp', 'Max_Temp', 'Min_Temp'});
% Write table to CSV file
writetable(T, 'FlexCon_36_data.csv');
