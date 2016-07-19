function PSF=fref(Y,isize)
llll='reference...'
%%Smooth
% Y=smooth(Y);
%% Baseline correction
f=chebfun(Y,[-1,1],'equi');
s=chebfun('s',[-1,1]);
A=[s,1];
c=A\f;
ffit=A*c;
ffit=-ffit;
f=plus(f,ffit);
%% Integral
k=cumsum(f,1);
%% Determine the size of the PSF matrix
si=1;
[maxval,maxpos]=max(k);
while k(maxpos+si*2/size(Y,1))/maxval>0.1
    si=si+1;
end
x=(-si:si)*2/size(Y,1);
y=x';
N=si*2+1;
x=repmat(x,N,1);
y=repmat(y,1,N);
PSF=(k(maxpos+sqrt(x.^2+y.^2))+k(maxpos-sqrt(x.^2+y.^2)))/2;
PSF=PSF/sum(sum(PSF));
end
