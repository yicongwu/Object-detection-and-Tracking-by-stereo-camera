k = 1;
for m = 213:322
    for n = 180:260
        car(k) = disp_sequence(m,n,1);
        k = k+1;
    end
end
car_disp = median(car);

lrow = floor(213/1.1);
hrow = floor(322*1.1);

lcol = floor(180/1.1);
hcol = floor(260*1.1);

BW = zeros(384,512);
for i = lrow:hrow
    for j = lcol:hcol
        if abs(disp_sequence(i,j,1) - car_disp) < 1
            BW(i,j) = 1;
        end
    end
end
