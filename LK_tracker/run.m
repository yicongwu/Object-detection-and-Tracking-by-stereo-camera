%read images
cd disparity\
for i = 1 : 82
    imageName = strcat('disparity',num2str(i),'.bmp');
    disp_sequence(:,:,i) = imread(imageName);
end
cd ..
cd left_ori\
for i = 1 : 82
    imageName = strcat('left',num2str(i),'.bmp');
    sequence(:,:,:,i) = imread(imageName);
end
cd ..
runTrackCar;