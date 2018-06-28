function [sigma,mu,A]=mygaussfit(x,y,h)

%Author: Yohanan Sivan
%http://www.mathworks.com/matlabcentral/fileexchange/11733-gaussian-curve-fit
% [sigma,mu,A]=mygaussfit(x,y)
% [sigma,mu,A]=mygaussfit(x,y,h)
%
% this function is doing fit to the function
% y=A * exp( -(x-mu)^2 / (2*sigma^2) )
%
% the fitting is been done by a polyfit
% the lan of the data.
%
% h is the threshold which is the fraction
% from the maximum y height that the data
% is been taken from.
% h should be a number between 0-1.
% if h have not been taken it is set to be 0.2
% as default.
%


%% threshold
if nargin==2, h=0.2; end

%% cutting
indx = (y > max(y)*h);

%% fitting
p=polyfit(x(indx), log(y(indx)), 2);
sigma=sqrt(-1/(2*p(1)));
mu=p(2)*sigma^2;
A=exp(p(3)+mu^2/(2*sigma^2));