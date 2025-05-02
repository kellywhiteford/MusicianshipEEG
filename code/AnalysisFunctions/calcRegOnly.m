function [slope, rSquared,yresid] = calcRegOnly(x,y)
%calculates linear regression
%x: independent variable [row]
%y: dependent (predictor) variable [row]


p = polyfit(x,y,1);
yfit =  p(1) * x + p(2);
yresid = y - yfit;
SSresid = sum(yresid.^2);
SStotal = (length(y)-1) * var(y);

rSquared = 1 - SSresid/SStotal; %R-squared!

slope = p(1);
