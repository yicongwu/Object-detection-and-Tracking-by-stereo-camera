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
% 霍夫变换
[H,theta,rho] = hough(BW,'Theta',-80:0.5:80);

% 显示霍夫变换矩阵中的极值点
P = houghpeaks(H,50,'threshold',ceil(0.03*max(H(:)))); % 从霍夫变换矩阵H中提取50个极值点
x = theta(P(:,2));
y = rho(P(:,1));
%plot(x,y,'s','color','black');
 
% 找原图中的线
lines = houghlines(BW,theta,rho,P,'FillGap',28,'MinLength',100);
subplot(2,2,3)
imshow(BW), hold on
max_len = 0;
for k = 1:length(lines)
    % 绘制各条线
    xy = [lines(k).point1; lines(k).point2];
    plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
   
    % 绘制线的起点（黄色）、终点（红色）
    plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
    plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');
   
    % 计算线的长度，找最长斜线段
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

%以红色线高亮显示最长的线
plot(xy_long(:,1),xy_long(:,2),'LineWidth',2,'Color','red');