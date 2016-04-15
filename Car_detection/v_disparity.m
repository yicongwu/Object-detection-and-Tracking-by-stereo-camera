disp_v = histc(disp',edges)';
disp_v(:,1) = 0;
Hv = zeros(size(disp_v));

T1 = 15;
for i = 1: size(disp_v,1)
    val = max(disp_v(i,:));
    index = find(disp_v(i,:)  >= 0.9*val);  
    if val >= T1 % & index > 5
        Hv(i,index) = 1;   
    end
end

BW = Hv;

% 霍夫变换
[H,theta,rho] = hough(BW);

% 显示霍夫变换矩阵中的极值点
P = houghpeaks(H,50,'threshold',ceil(0.03*max(H(:)))); % 从霍夫变换矩阵H中提取5个极值点
x = theta(P(:,2));
y = rho(P(:,1));
%plot(x,y,'s','color','black');
 
% 找原图中的线
lines = houghlines(BW,theta,rho,P,'FillGap',18,'MinLength',60);

%subplot(2,2,2)
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
%plot(xy_long(:,1),xy_long(:,2),'LineWidth',2,'Color','red');

 