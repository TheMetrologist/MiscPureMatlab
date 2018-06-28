function scattersurf(XYZ)

    %XYZ is variable containing array of (x,y,z) points

    sort(XYZ,1)
    tri=delaunay(XYZ(:,2), XYZ(:,1)); %perform delaunay triangulation
    trisurf(tri, XYZ(:,2), XYZ(:,1), XYZ(:,3)); %generate triangular surface plot

    l = light('Position',[-50 -15 29])
    set(gca,'CameraPosition',[208 -50 7687])
    lighting phong
    shading interp
    colorbar EastOutside
end