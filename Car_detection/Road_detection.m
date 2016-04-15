%read images and 
ori = imread('left_rectified.bmp');
figure; 
subplot(2,2,1)
imshow(ori)
disp = imread('disparity2.bmp');
subplot(2,2,2); 
imshow(disp)
ROW = size(disp,1); COL = size(disp,2);
disp = double(disp);

%v-disparity
edges = linspace(0,255,65);
disp_H = histc(disp',edges)';
disp_H(:,1) = 0;
H1 = zeros(size(disp_H));
%R = zeros(size(disp_H,1),1);

T1 = 5;
for i = 1: size(disp_H,1)
    val = max(disp_H(i,:));
    index = find(disp_H(i,:)  == val);  
    %R(i) = index(1);
    if length(index) < T1;
        H1(i,index) = 1; 
    end
end

%hough transform to detect road surface
BW = H1;
% ����任
[H,theta,rho] = hough(BW,'Theta',-80:0.5:80);

% ��ʾ����任�����еļ�ֵ��
P = houghpeaks(H,50,'threshold',ceil(0.03*max(H(:)))); % �ӻ���任����H����ȡ50����ֵ��
x = theta(P(:,2));
y = rho(P(:,1));
%plot(x,y,'s','color','black');
 
% ��ԭͼ�е���
lines = houghlines(BW,theta,rho,P,'FillGap',28,'MinLength',100);
subplot(2,2,3)
imshow(BW), hold on
max_len = 0;
for k = 1:length(lines)
    % ���Ƹ�����
    xy = [lines(k).point1; lines(k).point2];
    plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
   
    % �����ߵ���㣨��ɫ�����յ㣨��ɫ��
    plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
    plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');
   
    % �����ߵĳ��ȣ����б�߶�
    if abs(lines(k).point1(1) - lines(k).point2(1)) < 5
        len = -inf;
    else
        len = norm(lines(k).point1 - lines(k).point2);
    end
    if ( len > max_len)
        max_len = len;
        xy_long = xy;
    end   
end

%�Ժ�ɫ�߸�����ʾ�����
plot(xy_long(:,1),xy_long(:,2),'LineWidth',2,'Color','red');