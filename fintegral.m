function newy=fintegral(y)
llll='integral...'
%%Smooth
% for i=1:size(y,2)
%     y(:,i)=smooth(y(:,i));
% end
%% Construct a chebfun about Y_CNRS
x=linspace(-1,1,size(y,1))';
z = chebfun(y,[-1 1],'equi');
%% Least-square
t=chebfun('t');
A=[t 1];
c=A\z;
%% Subtract the baseline
ffit=A*c;
ffit=-ffit;
z=plus(z,ffit);
%% Integral
z=cumsum(z,1);
newy=z(x);
end


