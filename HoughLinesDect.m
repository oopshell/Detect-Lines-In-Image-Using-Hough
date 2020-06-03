clc
clear

I = imread('tar_img.tif');

edges = edge(I, 'canny');

[H, theta, rho] = hough(edges, 'RhoResolution', 3, 'ThetaResolution', 3);
peaks = houghpeaks(H, 10, 'threshold', ceil(0.001*max(H(:))));
lines = houghlines(edges, theta, rho, peaks,'MinLength',2);

figure, imshow(edges), hold on
max_len = 0;
for k = 1 : length(lines)
   xy = [lines(k).point1; lines(k).point2];
   plot(xy(:,1), xy(:,2), 'LineWidth', 2, 'Color','green');

   % Plot beginnings and ends of lines
   plot(xy(1,1), xy(1,2), 'x', 'LineWidth', 2, 'Color','yellow');
   plot(xy(2,1), xy(2,2), 'x', 'LineWidth', 2, 'Color','red');

   % Determine the endpoints of the longest line segment
   len = norm(lines(k).point1 - lines(k).point2);
   if (len > max_len)
      max_len = len;
      xy_long = xy;
   end
end
