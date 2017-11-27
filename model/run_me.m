% the script first, load the fitted parameters for the Reliability-and-Learning
% model and  display the fiting of the model. The script also display the best fitting fo the other models: i.g. Reliability-Learning-Group (RLG), 2: 3: Learning (L), 4: Reliability

clear all;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Fig S1 - Models R, L, and RLG models performance
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% load fitted parameters
load('fit.mat') % load the fitted parametes for model 2: Reliability-and-Learning (RL

mdata = [0.3485	0.8615	1.3715	1.555	1.6005	1.7985	2.204;... % cardianl group
    1.0625	1.558	1.964	2.431	2.2025	2.555	0.9255];  % oblique group
edata = [0.1427 0.0794 0.1628 0.1599 0.1432 0.0940 0.1909;...
    0.1021 0.0784 0.0873 0.1651 0.0782 0.1015 0.0944];
m1=load('m1_fMLE.mat');
m3=load('m3_fMLE.mat');
m4=load('m4_fMLE.mat');
md= [m3.md(1,:);m4.md(1,:);m1.md(1,:);
    m3.md(2,:);m4.md(2,:);m1.md(2,:)];


linePlot2pannels2( md, mdata, edata)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Reliability-and-Learning (RL) model fiting
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% which model to fit: here the fitted data is for the wining model (2)
a(1) = 2; %  1: Reliability-Learning-Group (RLG), 2: Reliability-and-Learning (RL), 3: Learning (L), 4: Reliability (R)
%which learning funciton to fit?: here the fitted data is for exponential
a(2) = 2; % 1: linear, 2: exponential
% number of fits to perform to cal ulates parameters
resamp = 40;

%% prepare the data

nfits=size(fit,1);

for i=1:nfits
    m.x(i,:) = fit{i}.x;
    m.vfun(i)  = fit{i}.vfun;
    m.rsq(i) = fit{i}.stats.rsq;
    m.AICc(i) = fit{i}.stats.AICc;
end

optrsq = m.rsq(m.vfun==min(m.vfun));
optAICc = m.AICc(m.vfun==min(m.vfun));
optX = m.x(m.vfun==min(m.vfun),:);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Fig S2
figure;
%b=bar(sort(m.vfun));
gr=zeros(size(m.x,1),1);
vfun= m.vfun';

gr(isnan(vfun))=0;
gr(isinf(vfun))=1;
gr(vfun<prctile(vfun,89))=2;
gr(vfun<prctile(vfun,75))=3;
gr(vfun<prctile(vfun,50))=4;
gr(vfun<prctile(vfun,25))=5;
gr(vfun==min(vfun))=6;

grsq=zeros(size(m.x,1),1);
rsq=m.rsq';
grsq(isnan(rsq))=0;
grsq(rsq>0)=1;
grsq(rsq>0.5)=2;
grsq(rsq>0.7)=3;
grsq(rsq>0.8)=4;
grsq(rsq>0.9)=5;
grsq(rsq==max(m.rsq))=6;


hold on;
cmat=[0.9 0.9 0.9;
    0.65 0.65 0.65;
    0.5 0.5 0.5;
    0.35 0.35 0.35;
    0.25 0.25 0.25;
    0.1 0.1 0.1;
    0.9 0 0];
%set(gca, 'ColorOrder', cmat, 'NextPlot', 'replacechildren');
simb='......*';
size=[15 15 15 15 15 15 8];
x=m.x;
[H,AX,BigAx]=gplotmatrix(x,[],grsq,cmat,simb,size);


AX(1).YLabel.String='?C';
AX(2).YLabel.String='?O';
AX(3).YLabel.String='?T';
AX(4).YLabel.String='?D';

AX(4).XLabel.String='?C';
AX(9).XLabel.String='?O';
AX(14).XLabel.String='?T';
AX(19).XLabel.String='?D';
title('FIg S2 - Reliability-and-Learning (RL) ')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Fig 3

[rsq,AICc,sigs,md] = SABayes_fMLE25(optX,a,resamp);
save('fMLE','rsq','AICc','sigs','md')
