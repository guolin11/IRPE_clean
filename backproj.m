function [res,T] = backproj( R,theta,n,opt )
%UNTITLED Summary of this function goes here
%   backproj computes the backprojection of a matrix of chebfuns, the nth
%   chebfun being the radon projection of angle theta(n), the argument n is
%   the desired size of the result.
%   if opt=='chebteta' then the sampling on theta must be made at chebyshev
%   points.
llll='backprojection ...'

x=gpuArray.linspace(-1,1,n)/sqrt(2);
y=gpuArray.linspace(1,-1,n)'/sqrt(2);
ntheta=gpuArray(theta)*pi/180;
x = repmat(x, n, 1);
y = repmat(y, 1, n);

ll=length(ntheta);
res=zeros(n);
parfor k=1:ll
    t=cos(ntheta(k)).*x+sin(ntheta(k)).*y;
    res=res+feval(R(:,k),t);
end
res=gather(res);
res=res/max(max(res(:,2:n-1)))*1.5;
end
