function [ AICc, rsq ] = SABayes_AICc( y,Y,k )
%function [ AICc, rsq ] = AICc( x,y )
%   Returns the AICc and rsq of the model
%   y= data, Y=  model prediction, k=number of model
%   parameters.
%% 

y=y(:);
Y=Y(:);
n = numel(Y);
mssq = sum((Y-mean(y)).^2)./n;
mles = prod(exp(-((Y-y).^2)./(2*mssq)));
Lmle = log(mles);
AIC = 2*(k)-Lmle.*2;
AICc = AIC + 2*k*(k+1)/(n-k-1);
rsq = corr(y,Y)^2;

end
