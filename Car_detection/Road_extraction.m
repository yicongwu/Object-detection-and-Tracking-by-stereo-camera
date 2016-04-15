k = [xy_long(2,2) - xy_long(1,2)] / [xy_long(2,1) - xy_long(1,1)];
b = xy_long(1,2) - xy_long(1,1)*k;
interval = edges(2) - edges(1);
if b < 0
    start = 1;
else
    start = ceil(b);
end
for i = start:ROW
    dis_i = (i - b) / k;
    index = floor(dis_i);
    if index == 0
        low = 0.1;
    else
        low = edges(index);
    end
    high = (dis_i - index) * interval + edges(index+1);
    for j = 1:size(disp,2)
       if disp(i,j) >=0.85 * low & disp(i,j) <= 1.15  * high
           disp(i,j) = 0;
       end
    end
end

for i = 1:ROW    
    if length(find(disp(i,:) == 0)) >= 0.8 * size(disp,2) & i > xy_long(1,2)
               disp(i,:) = 0;
               continue;
    end 
    
    for j = 1:COL
        if disp(i,j) <= edges (xy_long(1,1))
                disp(i,j) = 0;
        end
    end
end

subplot(2,2,4)
imshow(uint8(disp))