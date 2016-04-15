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

% ����任
[H,theta,rho] = hough(BW);

% ��ʾ����任�����еļ�ֵ��
P = houghpeaks(H,50,'threshold',ceil(0.03*max(H(:)))); % �ӻ���任����H����ȡ5����ֵ��
x = theta(P(:,2));
y = rho(P(:,1));
%plot(x,y,'s','color','black');
 
% ��ԭͼ�е���
lines = houghlines(BW,theta,rho,P,'FillGap',18,'MinLength',60);

%subplot(2,2,2)
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
%plot(xy_long(:,1),xy_long(:,2),'LineWidth',2,'Color','red');

 