px_spacing = 7;

[y,x] = size(fringeimage);
xx = 1:px_spacing:x;
yy = 1:px_spacing:y;
[yyy,xxx] = meshgrid(yy,xx);

i = 1;
j = 1;

i_index = 1;
j_index = 1;
while i <= y
    while j <= x
        fringeimage_reduced(i_index,j_index) = fringeimage(i,j)/10;
        j = j+px_spacing;
        j_index = j_index+1;
    end
    i = i+px_spacing; j = 1; j_index = 1;
    i_index = i_index+1;
end

surf(fringeimage_reduced)
axis equal

%%
figure(1); hold on
colormap gray
view(0,90)
pause(0.25)
colormap jet
for i = 90:-10:35
    view(0,i)
    pause(0.1)
end
for i = 0:10:360
    view(i,35)
    pause(0.1)
end
for i = 35:10:90
    view(0,i)
    pause(0.1)
end
colormap gray
view(0,90)
pause(0.1)