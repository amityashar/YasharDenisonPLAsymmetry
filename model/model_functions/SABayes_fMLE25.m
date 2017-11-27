function [rsq, AICc, sigs, md] = SABayes_fMLE25(x, a, nsamp)
% function [rsq, AICc, sigs, md] = SABayes_fMLE25(x, a, nsamp)
% x: model parmateres
% a: modeel fit type: a1= 1: start signal leraning all; a1=2: full; a2=
% group blind; a1=4: signal group blind; a1=5 template group blinde; a1=6: signal learning for templatel 
% a2=1: exponential  a2=2: liniar
% nsamp: number of samples;
%%
    % real data: pre-car pre-obl post-car post-obl tra-car tra-obl
    mdata = [0.3485	0.8615	1.3715	1.555	1.6005	1.7985	2.204;... % cardianl group
        1.0625	1.558	1.964	2.431	2.2025	2.555	0.9255];  % oblique group
    edata = [0.1427 0.0794 0.1628 0.1599 0.1432 0.0940 0.1909;...
        0.1021 0.0784 0.0873 0.1651 0.0782 0.1015 0.0944];
    %data = data(:,1);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
rss = zeros(nsamp,1);
mles = rss;
m = mean(mean(mdata));
%%

des=zeros(2,7,nsamp);
sigs = zeros(4,7,nsamp);
for i=1:nsamp
    [ ssq, d, sig ] = SABayes_ssq_PL25(x, a);
     des(:,:,i) = d;
     sigs(:,:,i) = sig;
end
desnoinf= des(:,:,~isinf(des(1,1,:))); % delete cases with inf
md = nanmean(desnoinf,3);
k = numel(x);
n = numel(md(:));



[AICc, rsq] = SABayes_AICc(mdata,md,k);

%r = ay_rsq(md(:),mdata(:));
%% plot parameters
f = figure;
f.Position = [680 678 1800 600];
f.PaperSize = [25.5 9];

subplot(1,3,1)
% switch a(1) 
%     case 1
%         params = x;
%     case 2
%         params = [x(1:4) 0 0];
%     case 2
%         params = [x(1:2) x(3)];
%     case 4
%         params = [x(1) x(1) x(2:3)];
% 
% end
%  caluclated parameters dinamic
params = x;
sigs = mean(sigs,3);
postSigs = sigs(:,end);
transfersigs = postSigs([2 1 4 3]); 
sigs = [sigs  transfersigs];
fittingType = {'1','2','3','4','5','6'};


hold on
bar(params);
title('parameters')

hold off


learningType = {'linear','exponential'};
yc = [md(1,:)' mdata(1,:)'];
yo = [md(2,:)' mdata(2,:)'];
% plot cardinal
subplot(1,3,2)
hold on
bar(yc)
text(1,2.5,num2str(x))
text(1,2.4, num2str(params))
text(1,2.3,fittingType{a(1)})
text(1,2.2,learningType{a(2)})

outputText = sprintf('R^2 = %0.2f, AICc = %.2f ', rsq,AICc);
text(1,2,outputText);
title('cardinal')
hold off
% plot oblique
subplot(1,3,3)
hold on
bar(yo)
legend('model','data')
title('oblique')
hold off
%% fig save
savedfilename = aynamedate( 'Bar','.fig',9);
savefig(f,savedfilename);

linePlot4pannels2(sigs, md, mdata, edata)

end
