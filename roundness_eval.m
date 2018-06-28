load('roundness.mat')
%   load variables:
%   A - probe 002, 3-lobed
%   B - 1 in. Steel 45 T3, 4-lobed
%   C - 3 in. T3, elliptical

nbins = 100;
theta = (0:.05:359.95)' * pi / 180;
theta180 = (0:0.05:179.95)';

%transform roundness data to 2-pt diameter
dia_A = zeros(3600, 1);
dia_B = zeros(3600, 1);
dia_C = zeros(3600, 1);
for i = 1 : 3600
    dia_A(i) = A(i) + A(3600 + i);
    dia_B(i) = B(i) + B(3600 + i);
    dia_C(i) = C(i) + C(3600 + i);
end

figure(1)
    subplot(3, 1, 1)
        polar(theta, A+100)
        title('Probe 002, 3-Lobe')
    subplot(3, 1, 2)
        hist(dia_A, nbins)
        title('2-pt Diameter Distribution')
    subplot(3, 1, 3)
        plot(theta180, dia_A)
        title('2-pt Non-spatial Diameter Rotation')
        xlabel('Rotation, degrees'); ylabel('Deviation, nm')

figure(2)
    subplot(3, 1, 1)
        polar(theta, B+100)
        title('1 in. Steel, 4-Lobe')
    subplot(3, 1, 2)
        hist(B, nbins)
        title('2-pt Diameter Distribution')
    subplot(3, 1, 3)
        plot(theta180, dia_B)
        title('2-pt Non-spatial Diameter Rotation')
        xlabel('Rotation, degrees'); ylabel('Deviation, nm')

figure(3)
    subplot(3, 1, 1)
        polar(theta, C+100)
        title('3 in. Steel PS1032, 2-Lobe')
    subplot(3, 1, 2)
        hist(C, nbins)
        title('2-pt Diameter Distribution')
    subplot(3, 1, 3)
        plot(theta180, dia_C)
        title('2-pt Non-spatial Diameter Rotation')
        xlabel('Rotation, degrees'); ylabel('Deviation, nm')