disp_u = histc(disp,edges);
disp_u(1,:) = 0;
Hu = zeros(size(disp_u));


T1 = 15;
for i = 1: size(disp_u,2)
    val = max(disp_u(:,i));
    index = find(disp_u(:,i) >= 0.7*val); 
    if val >= T1 & index > 6
        Hu(index,i) = 1;   
    end
end


BW = Hu;           

% 霍夫变换
[H,theta,rho] = hough(BW);

% 显示霍夫变换矩阵中的极值点
P = houghpeaks(H,50,'threshold',ceil(0.03*max(H(:)))); % 从霍夫变换矩阵H中提取5个极值点
x = theta(P(:,2));
y = rho(P(:,1));
%plot(x,y,'s','color','black');
 
% 找原图中的线
lines = houghlines(BW,theta,rho,P,'FillGap',15,'MinLength',50);

figure, 
subplot(2,2,1)
imshow(ori);
subplot(2,2,3)
imshow(BW), hold on
max_len = 0;
for k = 1:length(lines)
    % 绘制各条线
    xy = [lines(k).point1; lines(k).point2]
    plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
   
    % 绘制线的起点（黄色）、终点（红色）
    plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
    plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');
   
    % 计算线的长度，找最长线段
    len = norm(lines(k).point1 - lines(k).point2);
    if ( len > max_len)
        max_len = len;
        xy_long = xy;
    end   
end