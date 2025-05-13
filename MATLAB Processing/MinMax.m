% --- Step 1: List all video files ---
videoFiles = {'FlexCon_36_1.mp4', 'FlexCon_36_2.mp4', 'FlexCon_36_3.mp4', 'FlexCon_36_4.mp4','FlexCon_36_5.mp4'};
% --- Step 2: Define OCR text bounding box (top-left: CEN, MAX, MIN) ---
ocrRegion = [10, 10, 200, 100];  % Adjust based on your video overlay
% --- Step 3: Initialize result arrays ---
maxTemps_FC_36 = [];
minTemps_FC_36 = [];
timeVec = [];
currentTime = 0;
% --- Step 4: Loop through all video files ---
for fileIdx = 1:length(videoFiles)
   v = VideoReader(videoFiles{fileIdx});
   numFrames = floor(v.Duration * v.FrameRate);
  
   for frameIdx = 1:numFrames
       if ~hasFrame(v), break; end
       frame = readFrame(v);
       % Convert to grayscale if needed
       if size(frame, 3) == 3
           grayFrame = rgb2gray(frame);
       else
           grayFrame = frame;
       end
       % Crop OCR region and improve contrast
       ocrCrop = imcrop(grayFrame, ocrRegion);
       ocrCrop = imadjust(ocrCrop);
       % OCR
       ocrResult = ocr(ocrCrop);
       lines = splitlines(strtrim(ocrResult.Text));
       % Initialize temp values
       maxVal = NaN;
       minVal = NaN;
       % --- Extract and bound MAX value ---
       if numel(lines) >= 3
           maxStr = regexp(lines{2}, '\d+\.?\d*', 'match');
           if ~isempty(maxStr)
               val = str2double(maxStr{1});
               if val >= 245 && val <= 285
                   maxVal = val;
               elseif ~isempty(maxTemps_FC_36)
                   maxVal = maxTemps_FC_36(end);  % fallback to previous
               end
           elseif ~isempty(maxTemps_FC_36)
               maxVal = maxTemps_FC_36(end);
           end
           % --- Extract and bound MIN value ---
           minStr = regexp(lines{3}, '\d+\.?\d*', 'match');
           if ~isempty(minStr)
               val = str2double(minStr{1});
               if val >= 10 && val <= 40
                   minVal = val;
               elseif ~isempty(minTemps_FC_36)
                   minVal = minTemps_FC_36(end);
               end
           elseif ~isempty(minTemps_FC_36)
               minVal = minTemps_FC_36(end);
           end
       end
       if isnan(minVal)
           minVal = 15;
       end
       if isnan(maxVal)
           maxVal = 265;
       end
      
       % Store values
       maxTemps_FC_36(end+1, 1) = maxVal;
       minTemps_FC_36(end+1, 1) = minVal;
       timeVec(end+1, 1) = currentTime;
       currentTime = currentTime + 1 / v.FrameRate;
   end
end
% --- Step 5: Plot MAX and MIN temperatures over time ---
figure;
plot(timeVec, maxTemps_FC_36, 'r', 'DisplayName', 'Max Temp');
hold on;
plot(timeVec, minTemps_FC_36, 'b', 'DisplayName', 'Min Temp');
xlabel('Time (s)');
ylabel('Temperature (°C)');
title('OCR-Detected Max and Min Temperatures Across Videos');
legend;
grid on;
