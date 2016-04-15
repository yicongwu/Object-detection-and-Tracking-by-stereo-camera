function drawRect(rect, color, linewidth)
% CV Fall 2014 - Provided Code
% Draw a rectangle on current figure
% Input:  
%    rect:      rect = [x, y, w, h] is the rectangle you want to draw
%    color:     [1,0,0] means 'red', [0,1,0] means 'green', 
%               [0,0,1] means 'blue', etc.
%    linewidth: specify the linewidth
%
% Jan-18-2011: Wen-Sheng Chu

if nargin<3
  linewidth = 1;
  if nargin<2
    color = [0,0,1];
  end
end

hold on;
rectangle('Position', rect, 'Curvature',[0,0],...
          'EdgeColor',color, 'linewidth', linewidth);
drawnow;