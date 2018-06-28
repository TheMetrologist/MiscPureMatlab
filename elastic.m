function [ force_curve, def_curve] = elastic
    %authored by M. Braine
    %calculate single plane-sphere elastic deformation curve and plot
    %E - young's modulus [GPa]
    %V - elastic constant []
    %p - poissons ratio [ratio]

    %inputs
    %diameter
    %sphere material
    %plane material
    %force

%% Material Variables
    %sphere parameters
    display(' ')
    diameter = input('Enter sphere diameter in millimeters: ');
    diameter = diameter / 1e3;                                                  %mm -> m conversion.

    display(' ')
    display('Aluminum for aluminum')
    display('Brass for brass (70% copper, 30% zinc')
    display('Ceramic for partially stabilized zirconia')
    display('Chrome for chromium carbide (carnet CA-815G)')
    display('Copper for copper (OFHC)')
    display('DiamondN for natural diamond')
    display('DiamondS for synthetic diamond')
    display('GlassH for heavy silicate flint glass')
    display('GlassL for light borate crown glass')
    display('GlassP for pyrex glass')
    display('Gold for gold')
    display('Invar for invar and super invar')
    display('Platinum for platinum')
    display('Ruby for synthetic sapphire')
    display('Silica for fused silica')
    display('Silver for silver')
    display('Steelone for steel with 1% carbon')
    display('Steel52100 for 52100 tool steel')
    display('Stainless for stainless steel')
    display('TC6 for tungsten carbide (6% cobalt)')
    display('TC10 for tungsten carbide (10% cobalt)')
    display('TC16 for tungsten carbide (16% cobalt)')
    display('Zerodur for zerodur')
    display('Other for user-defined Youngs Modulus and Poissons Ratio')
    display(' ')
    display('Enter sphere material')
    material_sphere = lower(input('', 's'));
    switch material_sphere
        case 'aluminum'
            E1 = 71.9;
            p1 = 0.345;
        case 'brass'
            E1 = 104.11;
            p1 = 0.374;
        case 'ceramic'
            E1 = 200;
            p1 = 0.23;
        case 'chrome'
            E1 = 341.98;
            p1 = 0.28;
        case 'copper'
            E1 = 129.83;
            p1 = .343;
        case 'diamondn'
            E1 = 950;
            p1 = 0.2;
        case 'diamonds'
            E1 = 860;
            p1 = 0.2;
        case 'glassh'
            E1 = 53.5;
            p1 = 0.224;
        case 'glassl'
            E1 = 46.13;
            p1 = 0.274;
        case 'glassp'
            E1 = 62.05;
            p1 = 0.24;
        case 'gold'
            E1 = 77.91;
            p1 = 0.44;
        case 'invar'
            E1 = 148;
            p1 = 0.29;
        case 'platinum'
            E1 = 168.03;
            p1 = 0.377;
        case 'ruby'
            E1 = 380;
            p1 = 0.254;
        case 'silica'
            E1 = 72.88;
            p1 = 0.17;
        case 'silver'
            E1 = 82.74;
            p1 = .367;
        case 'steelone'
            E1 = 205;
            p1 = 0.29;
        case 'steel52100'
            E1 = 205;
            p1 = 0.29;
        case 'stainless'
            E1 = 200;
            p1 = 0.29;
        case 'tc6'
            E1 = 723.95;
            p1 = 0.28;
        case 'tc10'
            E1 = 599.84;
            p1 = 0.2;
        case 'tc16'
            E1 = 524;
            p1 = 0.22;
        case 'zerodur'
            E1 = 91;
            p1 = 0.24;
        case 'other'
            E1 = input('Enter Youngs Modulus in gigapascals: ');
            p1 = input('Enter Poissons Ratio: ');
        otherwise
            display('!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!')
            display('Error: Enter one of the options given')
            display('!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!')
            return
    end
    E1 = E1 * 1e9;                                                              %GPa -> N/m^2 conversion.
    V1 = (1 - p1^2) / (pi * E1);                                                %calculation of elastic constant for the sphere.

    display(' ')
    display('Enter material for plane contact')
    material_anvil = lower(input('', 's'));
    switch material_anvil
        case 'aluminum'
            E2 = 71.9;
            p2 = 0.345;
        case 'brass'
            E2 = 104.11;
            p2 = 0.374;
        case 'ceramic'
            E2 = 200;
            p2 = 0.23;
        case 'chrome'
            E2 = 341.98;
            p2 = 0.28;
        case 'copper'
            E2 = 129.83;
            p2 = .343;
        case 'diamondn'
            E2 = 950;
            p2 = 0.2;
        case 'diamonds'
            E2 = 860;
            p2 = 0.2;
        case 'glassh'
            E2 = 53.5;
            p2 = 0.224;
        case 'glassl'
            E2 = 46.13;
            p2 = 0.274;
        case 'glassp'
            E2 = 62.05;
            p2 = 0.24;
        case 'gold'
            E2 = 77.91;
            p2 = 0.44;
        case 'invar'
            E2 = 148;
            p2 = 0.29;
        case 'platinum'
            E2 = 168.03;
            p2 = 0.377;
        case 'ruby'
            E2 = 380;
            p2 = 0.254;
        case 'silica'
            E2 = 72.88;
            p2 = 0.17;
        case 'silver'
            E2 = 82.74;
            p2 = .367;
        case 'steelone'
            E2 = 205;
            p2 = 0.29;
        case 'steel52100'
            E2 = 205;
            p2 = 0.29;
        case 'stainless'
            E2 = 200;
            p2 = 0.29;
        case 'tc6'
            E2 = 723.95;
            p2 = 0.28;
        case 'tc10'
            E2 = 599.84;
            p2 = 0.2;
        case 'tc16'
            E2 = 524;
            p2 = 0.22;
        case 'zerodur'
            E2 = 91;
            p2 = 0.24;
        case 'other'
            display(' ')
            E2 = input('Enter Youngs Modulus in gigapascals: ');
            p2 = input('Enter Poissons Ratio: ');
        otherwise
            display(' ')
            display('!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!')
            display('Enter one of the options given')
            display('!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!')
            return
    end
    E2 = E2 * 1e9;                                                              %GPa -> N/m^2 conversion.
    V2 = (1 - p2^2) / (pi * E2);                                                %calculation of elastic constant.
    display(' ')
    force = input('Enter contact force in Newtons: ');

%% Calculation selection
    display(' ')
    display('SPHPLA     for sphere in contact with a plane')
    display('UnRightCYL for unequal diameter cylinders crossed at right angle')
    display('UnAnyCYL   for unequal diameter cylinders crossed at any angle')
    display('CYLPLA     for cylinder in contact with a plane')

    display(' ')
    method = lower(input('Enter contact calculation type: ', 's'));

    n = 200;                                                                    %number of force to calculate
    force_curve = linspace( (1/100), 8, n)';                                    %for force-deformation curves. in Newtons.

    switch method
        case 'sphpla'   %Sphere-Plane elastic deformation
            def_curve = (( ( (3 * pi)^(2 / 3) ) / 2) * (force_curve.^(2 / 3) ) * ( (V1 + V2)^(2 / 3) ) * ( (1 / diameter)^(1 / 3) ))*1e9;    %calculate deformation for force array, F
            deformation = (( ( (3 * pi)^(2 / 3) ) / 2) * (force^(2 / 3) ) * ( (V1 + V2)^(2 / 3) ) * ( (1 / diameter)^(1 / 3) ))*1e9;
    end

    %plotting deformation curve
    figure(1)
        plot(force_curve,def_curve)
        hold on
        xlabel('Force [N]')
        ylabel('Deformation [nm]')
        %title('title string')

    display(' ')
        plot([force,force,0],[0,deformation,deformation],'-r')                  %plot lines at user input force-deformation
%        x = 0.02 * xlim() + force;
%        y = deformation - 0.02 * ylim();
%        text(x(:,2),y(:,2),'xxx nm @ x.x N') %does not print formatted text
	fprintf('Deformation = %.2f nanometers at %.1f Newtons\n', deformation, force)
    hold off

%% Calculate elastic limit and probability of exceeding
    %hopeless because of lack of availability of compressive strength
    %information
end