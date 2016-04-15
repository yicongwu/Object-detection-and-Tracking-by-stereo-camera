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

% ����任
[H,theta,rho] = hough(BW);

% ��ʾ����任�����еļ�ֵ��
P = houghpeaks(H,50,'threshold',ceil(0.03*max(H(:)))); % �ӻ���任����H����ȡ5����ֵ��
x = theta(P(:,2));
y = rho(P(:,1));
%plot(x,y,'s','color','black');
 
% ��ԭͼ�е���
lines = houghlines(BW,theta,rho,P,'FillGap',15,'MinLength',50);

figure, 
subplot(2,2,1)
imshow(ori);
subplot(2,2,3)
imshow(BW), hold on
max_len = 0;
for k = 1:length(lines)
    % ���Ƹ�����
    xy = [lines(k).point1; lines(k).point2]
    plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
   
    % �����ߵ���㣨��ɫ�����յ㣨��ɫ��
    plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
    plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');
   
    % �����ߵĳ��ȣ�����߶�
    len = norm(lines(k).point1 - lines(k).point2);
    if ( len > max_len)
        max_len = len;
        xy_long = xy;
    end   
end