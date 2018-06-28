function [ area ] = integral_simps(data, a, b)
    %data is m x 2 matrix where column 2 is a function of an increasing
        %independent variable in column 1...i.e. f(x)
    %a is start of interval of integration
    %b is end of interval of integration
%% Notes
    %Function integral_simpson
    %calculates the approximate definite integral [area] of a data set 
    %[ a, b ] using Simpsons Rule.
    %Simpsons Rule:
        %(integral)[a,b] f(x)dx ~ Sn = (delta_x / 3) * [ f(x0) + 4 f(x1) +
        %2 f(x2) + 4 f(x3) + ... + 2 f(xn-2) + 4 f(xn-1) + f(xn) ]
        %where n is even and delta_x = (b - a) / n
    
    %Useful when integrating data which cannot be easily fit to a curve in
    %MATLAB...e.g. data showing trigonometric function behavior (unless I
    %am mistaken and a simple solution eludes me)
    %Ideally, the period of data collection should be consistent
    
    %Authored by Michael Braine, Physical Science Technician, NIST, USA
    
    %References:
    %Single Variable Calculus by James Stewart
%% Main
    a_index = find(data(:,1) == a);
    b_index = find(data(:,1) == b);

    data = data(a_index:b_index,:);                                             %restrict data to data [a,b]
    n = length(data);                                                           %n is length of the data

    if ( mod(n,2) == 0)
        disp('Warning: Simpsons rule requires an even number of divisions.')
        disp('Since integral_simpson uses real data points, an even number of divisions')
        disp('results in an odd number of pairs.')
        disp('Please increase/decrease [ a, b ] by one data point')
        return
    end    
    
    dx(1,1) = data(2,1) - data(1,1);
    
    for i = 3:n
        dx(i-1,1) = data(i,1) - data(i-1,1);
    end
    
    delta_x = sum(dx) / ( n - 1 );
    
    S_sum = data(1,2);                                                          %f(x1)
    for i = 1:(n - 2)
        if (mod(i,2) == 0)                                                      %when i is even
            c = 2;
        else                                                                    %when i is odd
            c = 4;
        end
        S_sum = S_sum + c * data(i+1,2);
    end
    S_sum = S_sum + data(end,2);                                                %f(xn)
    area = ( delta_x / 3 ) * S_sum;
end