function xb = incsearch(func,xmin,xmax,ns)
%incsearch: incremental search for roots
%   xb = incsearch(func,xmin,xmax,ns):
%       finds brackets of x that contain sugn changes of a function on an
%       interval
%   inputs:
%       func = name of function
%       xmin, xmax, endpoints of interval
%       ns = number of subintervals (optional)
%   output: 
%       xb(k,1) is lower bound of kth sign change
%       xb(k,2) is upper bound of kth sign change
%       if no roots, xb = []
    if nargin < 4   %if user does not define ns, set default
        ns = 5000;
    end

    %incremental search
    x = linspace(xmin,xmax,ns);
    f = func(x);
    nb = 0;
    xb = [];
    for k = 1:length(x)-1
        if sign(f(k)) ~= sign(f(k+1))   %if sign changes
            nb = nb+1;
            xb(nb,1) = x(k);
            xb(nb,2) = x(k+1);
        end
    end
end