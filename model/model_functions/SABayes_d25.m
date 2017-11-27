function [d] = SABayes_d25(sT, sD)
% function [d] = SABayes_d(sT, sD, sST, sSD)
% Use a Bayessian model to detect orientation sinlgeton
% Returned the correct dprime (d) based on the following paramters
% sT: target signal sigma, 
% sD: distractor signal sigma, 
% model with only signal sigma
%   Copy rights Amit Yashar Oct 2016l
%%

T = 0;  %target mean
D = 30; %distractor mean
ntrials = 1000; %number of trials
dFA = zeros(size(ntrials));
dHit = dFA;

parfor i = 1:ntrials
        
    ST = T; % estimated target value for this trialsed 
    SD = D; % estimated distractor value for this trialsed 

    xAb = normrnd(D,sD,25,1); % sampaled signal for distractors only
    xPr = normrnd(T,sT,1,1); % sampled signal for target present
    
    % callcualte target evidence rate () for each locaiton in both abasent and
    % present rtrials.
    dAb = (log((sD.^2)./(sT.^2))).*0.5 - (((xAb-ST).^2)./(sT.^2)-((xAb-SD).^2)./(sD.^2)).*0.5;
    dPr = dAb;
    dPr(1) = (log((sD.^2)./(sT.^2))).*0.5 - (((xPr-ST).^2)./(sT.^2)-((xPr-SD).^2)./(sD.^2)).*0.5;
    
    logFAm = log((1/25)*(sum(exp(dAb))));
    logHit = log((1/25)*(sum(exp(dPr))));
    
    % criterion equal to one in log liklyhood space
    dFA(i) = logFAm>=1; % False Alarm
    dHit(i) = logHit>=1; % Hits 
end
%-- proportion of Hit and FA
pFA = mean(dFA);
pHit = mean(dHit);

%-- Convert to Z scores, no error checking
zFA  = norminv(pFA);
zHit = norminv(pHit);

%-- Calculate d-prime
d = zHit - zFA;

end

