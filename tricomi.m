
function betaOfy = tricomi(y)
%TRICOMI beta transform through the use of chebfuns and tricomi
%   The TRICOMI function computes the beta transform of a vector or matrix
%   through the use of chebfun and the tricomi transform.
%   if val == 'chebpts' then the values in y are considered to be taken at
%   the size(y,1) chebyshev points
%   If opt = funqui then the funqui interpolation is used and val is the d
%   parameter of the interpolation.

llll='tricomi ...'

n=size(y,1);
nech=size(y,2);

x=linspace(-1,1,n)';

xs=sqrt(1-x.^2);

y=bsxfun(@times,y,xs);

OneOverN = @(N) [1 ./ (1:1:N),0];

f = chebfun(y,[min(x) max(x)],'equi');
g = chebfun(bsxfun(@times,chebcoeffs(f),(feval(OneOverN,size(chebcoeffs(f),1)-1))'),'coeffs');

betaOfy =-diff(g,2);

end

