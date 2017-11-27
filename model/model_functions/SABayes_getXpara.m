function [ x ] = SABayes_getXpara(x, a)
%[ x ] = SABayes_getXpara(x, a)
% retutrn the x paramters based on the type of learning
%   Detailed explanation goes here

switch a
    case 1% full
        if numel(x)<6
            display('not enought parameters')
        end
    case 2 % group blind
        x = [x(1:2) x(3:4) x(3:4)]; % group blind
    case 3 % same learning 3p
        x = [x(1:2) x(3) x(3) x(3) x(3)];
    case 4 % same sigma
        x = [x(1) x(1) x(2:3) x(2:3)];
        
end
end

