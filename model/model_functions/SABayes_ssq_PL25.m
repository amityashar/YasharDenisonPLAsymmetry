function [ ssq, outdp, outdSig, stats ] = SABayes_ssq_PL25(x, a)
% function [ ssq ] = SABayes_ssq(x) returesn the sum of squares based on the
% run the learning function and call the d-prime search function
%%

data = [0.3485	0.8615	1.3715	1.555	1.6005	1.7985	2.204;... % cardianl group
    1.0625	1.558	1.964	2.431	2.2025	2.555	0.9255];  % oblique group
%data = data(:,1);
k=numel(x);
%x = [x(1:4) x(5) 0 x(6) 0 x(5) 0 x(6) 0] % target
% asigned parameters for the model based ont he spe of fit;
x=SABayes_getXpara(x, a(1));

t=[0:5]; % sessions

switch a(2) % which type of learning?
    case 1 % linear PL
        %% cardinal
        sTc = x(1)-x(3)*t; % target car sd
        sDc = x(2)-x(4)*t;  % distractor car sd
        %% oblique
        sTo = x(2)-x(5)*t; % target obl sd
        sDo = x(1)-x(6)*t; % distractor obl sd
    case 2 %  exponential y = a(1 + e^(-s*(x)))
        %% cardinal
        sTc = x(1)*(1+exp(-x(3)*t));% target sd
        sDc = x(2)*(1+exp(-x(4)*t));% distractor sd
        %% oblique
        sTo = x(2)*(1+exp(-x(5)*t)); % target sd
        sDo = x(1)*(1+exp(-x(6)*t)); % distractor sd
end

% Add the transfer test to the days
sTc = [sTc sDc(numel(t))]; % ori swap transfer
sDc = [sDc sTc(numel(t))]; % ori swap transfer
sTo = [sTo sDo(numel(t))]; % ori swap transfer
sDo = [sDo sTo(numel(t))]; % ori swap transfer


% run the loop of training and transfer test
parfor i=1:numel(sTc)
    % pre and training
    dcar(i) = SABayes_d25(sTc(i), sDc(i)); % cardianl group
    dobl(i) = SABayes_d25(sTo(i), sDo(i)); % oblique group
end
d=[dcar; dobl];

sig = [sTc; sDc; sTo; sDo];

d1 = d(:);
data = data(:);
ssq = sum(sum((d1-data).^2));

% -- out dprime if requested
if (nargout > 1)
    outdp = d;
end

if (nargout > 2)
    outdSig = sig;
end

if (nargout > 3)
    [AICc, rsq] = SABayes_AICc(data,d,k);
    stats.rsq = rsq;
    stats.AICc= AICc;
end

end