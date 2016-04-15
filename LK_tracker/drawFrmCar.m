function hf = drawFrmCar(sequence, rect, iFrm)
% CV Fall 2014 - Provided Code
% draw a frame for car tracker

hf = figure(1); clf; hold on;
imshow(sequence(:,:,:,iFrm));
drawRect([rect(1:2),rect(3:4)-rect(1:2)],'r',3);
text(80,50,['frame ',num2str(iFrm)],'color','y','fontsize',30);
hold off;
title('Car tracker with Lucas-Kanade Tracker');
drawnow;